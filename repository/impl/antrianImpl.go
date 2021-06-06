package impl

import (
	"errors"
	"fmt"
	"log"
	"nano-antrian/auth"
	"nano-antrian/encrypt"
	"nano-antrian/models"
	repo "nano-antrian/repository"
	"strconv"
	"time"

	"github.com/360EntSecGroup-Skylar/excelize"
	"github.com/jmoiron/sqlx"
)

type mySQLAntrian struct {
	Conn *sqlx.DB
}

func NewSQLAntrian(Conn *sqlx.DB) repo.NanoAntrian {
	return &mySQLAntrian{
		Conn: Conn,
	}
}

func (m *mySQLAntrian) SignIn(params map[string]string) (string, error) {
	var tokenString string
	var User models.UserAccount
	username := params["username"]

	q, e := m.Conn.Queryx(`SELECT id, username, password FROM mst_users WHERE username =$1`, username)
	if e != nil {
		return "", e
	}
	for q.Next() {
		if err := q.StructScan(&User); err != nil {
			return "", err
		} else {
			payload := User
			userID := payload.ID
			username := payload.Username
			password := payload.Password
			pass := params["password"]

			verify := encrypt.ComparePasswords(password, []byte(pass))
			if verify == false {

				log.Print("SALAHHH")
				return "", errors.New("incorrect username or password")
			} else {
				var params map[string]string
				params = map[string]string{}

				params["id"] = userID
				params["username"] = username

				getToken, err := auth.GenerateToken(params)
				if err != nil {
					return "", err
				}
				log.Print("ini token ", getToken)
				tokenString := getToken
				return tokenString, nil
			}
		}
	}
	return tokenString, nil
}

// func(m *mySQLAntrian) GetUser(userName string)(models)

func (m *mySQLAntrian) AntrianList(idPelayanan string) ([]models.AntrianList, error) {
	var arrAntrian []models.AntrianList

	q, err := m.Conn.Queryx(`SELECT nama_lengkap, tanggal_kedatangan, mp.nama as loket, jam_kedatangan, no_antrian FROM tran_form_isian t
	LEFT JOIN mst_pelayanan mp on mp.id = t.id_pelayanan
	WHERE id_pelayanan = $1`, idPelayanan)
	if err != nil {
		return nil, err
	}
	log.Println("coyyy masuk", q)
	for q.Next() {
		// log.Println("coyyy masuk")
		var a models.AntrianList
		errScan := q.StructScan(&a)

		if errScan != nil {
			return nil, errScan
		}

		arrAntrian = append(arrAntrian, a)
	}

	return arrAntrian, nil
}

func (m *mySQLAntrian) GetUserByID(userName string) (models.User, error) {
	var u models.User
	e := m.Conn.Get(&u, `SELECT id, username, nama, loketid, onlineid, offlineid, namalayanan FROM mst_users WHERE username=$1`, userName)
	if e != nil {
		return u, e
	}
	return u, e
}

func (m *mySQLAntrian) GetJumlahAntrian(idPelayanan string) (models.JumlahAntrian, error) {

	var ja models.JumlahAntrian

	eTa := m.Conn.Get(&ja.TotalAntrian, `select count(id) from tran_form_isian where id_pelayanan = $1`, idPelayanan)
	if eTa != nil {
		return ja, eTa
	}

	eAs := m.Conn.Get(&ja.AntrianSelesai, `select count(id) from tran_form_isian where id_pelayanan = $1 AND status = 'done'`, idPelayanan)
	if eAs != nil {
		return ja, eAs
	}

	eAm := m.Conn.Get(&ja.AntrianBerlangsung, `select count(id) from tran_form_isian where status = 'waiting' and id_pelayanan = $1`, idPelayanan)
	if eAm != nil {
		return ja, eAm
	}

	eNa := m.Conn.Get(&ja.NoAntiran, `select no_antrian from tran_form_isian where status = 'on progress' and id_pelayanan = $1`, idPelayanan)
	if eNa != nil {
		return ja, eNa
	}

	return ja, nil
}

func (m *mySQLAntrian) DisplayAntrian() ([]models.DisplayAntrian, error) {
	var arrDisplay []models.DisplayAntrian

	q, e := m.Conn.Queryx(`select mp.nama as loket, t.no_antrian as antrian from tran_form_isian t 
	left join mst_pelayanan mp on mp.id = t.id_pelayanan
	where status = 'on progress'`)
	if e != nil {
		return nil, e
	}
	for q.Next() {
		var da models.DisplayAntrian
		eScan := q.StructScan(&da)
		if eScan != nil {
			return nil, eScan
		}
		arrDisplay = append(arrDisplay, da)
	}

	return arrDisplay, nil
}

func (m *mySQLAntrian) ExportAntrian(start string, end string) (string, error) {
	var arrX []models.ExportAntrian
	rows, err := m.Conn.Queryx(`
	select 
		nama_lengkap, 
		no_identitas, 
		jenis_kelamin, 
		alamat, 
		email, 
		no_hp, 
		tanggal_kedatangan, 
		mp.nama as loket, 
		rjk.keterangan as jam_kedatangan, 
		status, 
		COALESCE(lama_menunggu, 0) as lama_menunggu, 
		COALESCE(lama_pelayanan, 0) as lama_pelayanan 
	from 
		tran_form_isian t 
		left join mst_pelayanan mp on mp.id = t.id_pelayanan 
		left join ref_jam_kedatangan rjk on rjk.id = t.jam_kedatangan 
	where 
		tanggal_kedatangan between $1 
		and $2
	`, start, end)
	if err != nil {
		return "", err
	}
	defer rows.Close()
	for rows.Next() {
		var x models.ExportAntrian
		if errScan := rows.StructScan(&x); errScan != nil {
			return "", errScan
		}
		arrX = append(arrX, x)
	}
	if arrX == nil {
		return "", errors.New("Antrian tidak tersedia")
	}
	path, _ := GenerateExlxs(arrX)
	return path, nil

}

func GenerateExlxs(arrX []models.ExportAntrian) (string, error) {

	xlsx := excelize.NewFile()

	sheet1Name := "Sheet1"
	xlsx.SetSheetName(xlsx.GetSheetName(1), sheet1Name)

	xlsx.SetCellValue(sheet1Name, "A1", "Nama lengkap")
	xlsx.SetCellValue(sheet1Name, "B1", "No identitas")
	xlsx.SetCellValue(sheet1Name, "C1", "Jenis kelamin")
	xlsx.SetCellValue(sheet1Name, "D1", "Alamat")
	xlsx.SetCellValue(sheet1Name, "E1", "Email")
	xlsx.SetCellValue(sheet1Name, "F1", "No HP")
	xlsx.SetCellValue(sheet1Name, "G1", "Tanggal kedatangan")
	xlsx.SetCellValue(sheet1Name, "H1", "Loket")
	xlsx.SetCellValue(sheet1Name, "I1", "Jam kedatanga")
	xlsx.SetCellValue(sheet1Name, "J1", "Status")
	xlsx.SetCellValue(sheet1Name, "K1", "Lama menunggu")
	xlsx.SetCellValue(sheet1Name, "L1", "Lama pelayanan")

	// err := xlsx.AutoFilter(sheet1Name, "A1", "C1", "")
	// if err != nil {
	//     log.Fatal("ERROR", err.Error())
	// }

	for i, each := range arrX {
		log.Println("data ", each.Nama_lengkap)
		xlsx.SetCellValue(sheet1Name, fmt.Sprintf("A%d", i+2), each.Nama_lengkap)
		xlsx.SetCellValue(sheet1Name, fmt.Sprintf("B%d", i+2), each.No_identitas)
		xlsx.SetCellValue(sheet1Name, fmt.Sprintf("C%d", i+2), each.Jenis_kelamin)
		xlsx.SetCellValue(sheet1Name, fmt.Sprintf("D%d", i+2), each.Alamat)
		xlsx.SetCellValue(sheet1Name, fmt.Sprintf("E%d", i+2), each.Email)
		xlsx.SetCellValue(sheet1Name, fmt.Sprintf("F%d", i+2), each.No_hp)
		xlsx.SetCellValue(sheet1Name, fmt.Sprintf("G%d", i+2), each.Tanggal_Kedatangan)
		xlsx.SetCellValue(sheet1Name, fmt.Sprintf("H%d", i+2), each.Loket)
		xlsx.SetCellValue(sheet1Name, fmt.Sprintf("I%d", i+2), each.Jam_Kedatangan)
		xlsx.SetCellValue(sheet1Name, fmt.Sprintf("J%d", i+2), each.Status)
		xlsx.SetCellValue(sheet1Name, fmt.Sprintf("K%d", i+2), each.Lama_menunggu)
		xlsx.SetCellValue(sheet1Name, fmt.Sprintf("L%d", i+2), each.Lama_pelayanan)
	}

	err := xlsx.SaveAs("./files/" + arrX[0].Loket + ".xlsx")
	if err != nil {
		log.Println("tes", err)
		return "", err
	}

	path := "./files/" + arrX[0].Loket + ".xlsx"
	return path, nil
}

func inTimeSpan(start, end, check time.Time) bool {
	return check.After(start) && check.Before(end)
}

func (m *mySQLAntrian) GetJamKedatangan() int {
	var (
		start string
		end   string
	)
	// i := 0
	rows, err := m.Conn.Queryx(`select start_jam, end_jam from ref_jam_kedatangan`)
	if err != nil {
		log.Panicln(err)
	}
	for rows.Next() {
		err := rows.Scan(&start, &end)
		if err != nil {
			log.Panicln(err)
		}

	}
	return 0
}

var idJam int

func getJamKedatanganID() int {
	// tx := m.Conn.MustBegin()
	// var jam2 bool
	fmt.Println("TES")
	dt := time.Now()
	layoutJam := "15:04"
	dates := dt.Format("15:04")
	datesParse, _ := time.Parse(layoutJam, dates)

	// ======================== jam ke 1 ========================
	start1 := "17:00"
	startParse1, _ := time.Parse(layoutJam, start1)

	end1 := "18:00"
	endParse1, _ := time.Parse(layoutJam, end1)

	jam1 := inTimeSpan(startParse1, endParse1, datesParse)

	// ======================== jam ke 2 ========================
	start2 := "09:00"
	startParse2, _ := time.Parse(layoutJam, start2)

	end2 := "10:00"
	endParse2, _ := time.Parse(layoutJam, end2)

	jam2 := inTimeSpan(startParse2, endParse2, datesParse)

	// ======================== jam ke 3 ========================
	start3 := "10:00"
	startParse3, _ := time.Parse(layoutJam, start3)

	end3 := "11:00"
	endParse3, _ := time.Parse(layoutJam, end3)

	jam3 := inTimeSpan(startParse3, endParse3, datesParse)

	// ======================== jam ke 4 ========================
	start4 := "11:00"
	startParse4, _ := time.Parse(layoutJam, start4)

	end4 := "12:00"
	endParse4, _ := time.Parse(layoutJam, end4)

	jam4 := inTimeSpan(startParse4, endParse4, datesParse)

	// ======================== jam ke 5 ========================
	start5 := "13:00"
	startParse5, _ := time.Parse(layoutJam, start5)

	end5 := "14:00"
	endParse5, _ := time.Parse(layoutJam, end5)

	jam5 := inTimeSpan(startParse5, endParse5, datesParse)

	// ======================== jam ke 6 ========================
	start6 := "14:00"
	startParse6, _ := time.Parse(layoutJam, start6)

	end6 := "15:00"
	endParse6, _ := time.Parse(layoutJam, end6)

	jam6 := inTimeSpan(startParse6, endParse6, datesParse)

	if jam1 == true {
		idJam = 1
	} else if jam2 == true {
		idJam = 2
	} else if jam3 == true {
		idJam = 3
	} else if jam4 == true {
		idJam = 4
	} else if jam5 == true {
		idJam = 5
	} else if jam6 == true {
		idJam = 6
	}

	log.Println("INI DIA ID JAM NYA ", idJam)

	return idJam
}

var jamKdtng string

func getMinute(idJam int) float64 {

	dt := time.Now()
	layoutJam := "15:04"
	currentTime := dt.Format("15:04")

	switch idJam {
	case 1:
		jamKdtng = "17:00"
	case 2:
		jamKdtng = "09:00"
	case 3:
		jamKdtng = "10:00"
	case 4:
		jamKdtng = "11:00"
	case 5:
		jamKdtng = "13:00"
	case 6:
		jamKdtng = "14:00"
	}

	pTime1, _ := time.Parse(layoutJam, jamKdtng)
	pTime2, _ := time.Parse(layoutJam, currentTime)

	diff := pTime2.Sub(pTime1).Minutes()

	return diff
}

type OnProgres struct {
	ID           int
	Jam_dilayani string
}

func (m *mySQLAntrian) NextAntrian(idPelayanan string) error {
	idJam := getJamKedatanganID()
	var idAntWaiting int
	// var idAntOnProgress int
	Onprogress := OnProgres{}
	// var jamDilayani string
	iPelayanan, _ := strconv.Atoi(idPelayanan)
	layoutJam := "15:04"
	dt := time.Now()
	currentTime := dt.Format("15:04")
	lamaMenunggu := getMinute(idJam)
	// lamaLayanan := dt.Format("15:04")
	log.Println("menit nya  ", lamaMenunggu)

	tx := m.Conn.MustBegin()

	err := m.Conn.Get(&idAntWaiting, `select id from tran_form_isian
	where tanggal_kedatangan = '2021-04-25'
	and jam_kedatangan = $1
	and id_pelayanan = $2
	and status = 'Waiting'
	order by no_antrian ASC
	limit 1`, idJam, iPelayanan)

	if err != nil {
		log.Println("ERROR DI GET id waiting", err)
		// return err
	}

	errOp := m.Conn.Get(&Onprogress, `select id, jam_dilayani from tran_form_isian
	where tanggal_kedatangan = '2021-04-25'
	and jam_kedatangan = $2
	and id_pelayanan = $1
	and status = 'On Progress'
	order by no_antrian asc limit 1`, idPelayanan, idJam)

	if errOp != nil {
		log.Println("ERROR DI GET id done ", errOp)
		// return err
	}

	_, errEx := tx.Exec(`UPDATE tran_form_isian SET status = 'On Progress', jam_dilayani = $2, lama_menunggu = $3 WHERE id =$1`, idAntWaiting, currentTime, lamaMenunggu)
	if errEx != nil {
		tx.Rollback()
		return errEx
	}

	jamSkrng, _ := time.Parse(layoutJam, currentTime)
	jamDilayani, _ := time.Parse(time.RFC3339, Onprogress.Jam_dilayani)
	// log.Println("jam dilayani di ", Onprogress.Jam_dilayani)
	// log.Println("jam skarang di ", jamSkrng)
	lamaPelayanan := jamSkrng.Sub(jamDilayani).Minutes()
	log.Println("lama di layanai ", lamaPelayanan, "menit")

	_, errExOP := tx.Exec(`UPDATE tran_form_isian SET status = 'Done', lama_pelayanan =$2 WHERE id =$1`, Onprogress.ID, lamaPelayanan)
	if errExOP != nil {
		return errExOP
	}

	tx.Commit()

	// log.Println("MASUKKK ", idAntrian)
	return nil
}

func (m *mySQLAntrian) Scheduler() error {
	tx := m.Conn.MustBegin()

	_, err := tx.Exec(`update tran_form_isian set status = 'waiting'`)
	if err != nil {
		tx.Rollback()
		return err
	}

	tx.Commit()
	return nil
}
