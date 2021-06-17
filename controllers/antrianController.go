package controllers

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"nano-antrian/auth"
	"nano-antrian/config"
	handler "nano-antrian/handlers"
	"nano-antrian/models"
	"nano-antrian/repository"
	"nano-antrian/repository/impl"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
)

type AntrianRepo struct {
	repo repository.NanoAntrian
}

func NewAntrianHandler(db *config.DB) *AntrianRepo {
	return &AntrianRepo{
		repo: impl.NewSQLAntrian(db.SQL),
	}
}

func (p *AntrianRepo) SignIn(c *gin.Context) {
	c.Header("Access-Control-Allow-Headers", "Content-type")
	c.Header("Access-Control-Allow-Method", "POST, GET, OPTIONS, PUT, DELETE")
	c.Header("Access-Control-Allow-Origin", "*")
	var t models.Token
	var responses models.ResponseToken
	var params = map[string]string{}
	// err := c.ParseMultipartForm(4096)
	// err := c.Request.ParseMultipartForm(4096)
	params["username"] = c.Request.FormValue("username")
	params["password"] = c.Request.FormValue("password")
	log.Println("TESSSS")
	tokenString, errT := p.repo.SignIn(params)
	if errT != nil {
		log.Println("mantap ")
		c.AbortWithStatusJSON(400, handler.ErrorHandler(400, 405, errT.Error()))
		return
	}
	dataUser, err := p.repo.GetUserByID(params["username"])

	if err != nil {
		log.Println("mantap ", err.Error())
		return
	}
	t.Nama = dataUser.Nama
	t.LoketID = dataUser.LoketID
	t.OnlineID = dataUser.OnlineID
	t.OfflineID = dataUser.OfflineID
	t.NamaLoket = dataUser.NamaLayanan
	t.Token = tokenString
	t.TokenType = "bareer"
	t.UserID = dataUser.ID
	t.Username = dataUser.Username

	responses.Status = 200
	responses.Message = "success"
	responses.Data = t

	c.Header("Content-Type", "application/json")
	c.Writer.Header().Set("Access-Control-Allow-Origin", "*")
	json.NewEncoder(c.Writer).Encode(responses)
}

func (p *AntrianRepo) GetAntrianList(c *gin.Context) {
	c.Header("Access-Control-Allow-Headers", "Content-type")
	c.Header("Access-Control-Allow-Method", "POST, GET, OPTIONS, PUT, DELETE")
	c.Header("Access-Control-Allow-Origin", "*")
	var responses models.ResponseAntrian
	idPelayanan := c.Query("idPelayanan")
	token := c.Request.Header.Get("Authorization")

	_, errC := auth.ValidateToken(token)
	if errC != nil {
		c.AbortWithStatusJSON(400, handler.ErrorHandler(400, 422, errC.Error()))
		return
	}
	payload, err := p.repo.AntrianList(idPelayanan)
	if err != nil {
		log.Println(err.Error())
		return
	}
	responses.Status = 200
	responses.Message = "Success"
	responses.Data = payload
	c.Header("Content-Type", "application/json")
	c.Writer.Header().Set("Access-Control-Allow-Origin", "*")
	json.NewEncoder(c.Writer).Encode(responses)
}

func (p *AntrianRepo) GetUserByID(c *gin.Context) {
	c.Header("Access-Control-Allow-Headers", "Content-type")
	c.Header("Access-Control-Allow-Method", "POST, GET, OPTIONS, PUT, DELETE")
	c.Header("Access-Control-Allow-Origin", "*")
	var responses models.ResponseUser
	userID := c.Query("userName")
	token := c.Request.Header.Get("Authorization")

	_, errC := auth.ValidateToken(token)
	if errC != nil {
		c.AbortWithStatusJSON(400, handler.ErrorHandler(400, 422, errC.Error()))
		return
	}

	// i, _ := strconv.Atoi(userID)

	payload, err := p.repo.GetUserByID(userID)
	if err != nil {
		log.Println(err.Error())
		c.AbortWithStatusJSON(c.Writer.Status(), handler.ErrorHandler(c.Writer.Status(), 400, err.Error()))
		return
	}
	responses.Status = 200
	responses.Message = "Success"
	responses.Data = payload
	c.Header("Content-Type", "application/json")
	c.Writer.Header().Set("Access-Control-Allow-Origin", "*")
	json.NewEncoder(c.Writer).Encode(responses)
}

func (p *AntrianRepo) GetTotalAntrian(c *gin.Context) {
	c.Header("Access-Control-Allow-Headers", "Content-type")
	c.Header("Access-Control-Allow-Method", "POST, GET, OPTIONS, PUT, DELETE")
	c.Header("Access-Control-Allow-Origin", "*")
	var responses models.ResponseJumlahAntrian
	idPelayanan := c.Query("idPelayanan")
	token := c.Request.Header.Get("Authorization")

	_, errC := auth.ValidateToken(token)
	if errC != nil {
		c.AbortWithStatusJSON(400, handler.ErrorHandler(400, 422, errC.Error()))
		return
	}
	payload, err := p.repo.GetJumlahAntrian(idPelayanan)
	if err != nil {
		log.Println(err.Error())
		return
	}
	responses.Status = 200
	responses.Message = "Success"
	responses.Data = payload
	c.Header("Content-Type", "application/json")
	c.Writer.Header().Set("Access-Control-Allow-Origin", "*")
	json.NewEncoder(c.Writer).Encode(responses)
}

func (p *AntrianRepo) ExportAntrian(c *gin.Context) {
	c.Header("Access-Control-Allow-Headers", "Content-type")
	c.Header("Access-Control-Allow-Method", "POST, GET, OPTIONS, PUT, DELETE")
	c.Header("Access-Control-Allow-Origin", "*")
	start := c.Query("start")
	end := c.Query("end")
	path, err := p.repo.ExportAntrian(start, end)
	if err != nil {
		c.JSON(200, handler.ErrorHandler(200, 204, err.Error()))
		return
	}
	// log.Println("PATH  ", path)
	if len(path) == 0 {
		c.JSON(200, handler.ErrorHandler(200, 204, "Data antrian tidak tersedia"))
		return
	}

	f, err := os.Open(path)
	if f != nil {
		defer f.Close()

	}
	if err != nil {
		http.Error(c.Writer, err.Error(), http.StatusInternalServerError)
		return
	}

	contentDisposition := fmt.Sprintf("attachment; filename=%s", f.Name())
	c.Writer.Header().Set("Content-Description", "File Transfer")
	c.Writer.Header().Set("Content-Disposition", contentDisposition)

	if _, err := io.Copy(c.Writer, f); err != nil {
		http.Error(c.Writer, err.Error(), http.StatusInternalServerError)
		return
	}

	c.Writer.Header().Set("Access-Control-Allow-Origin", "*")
	c.Header("Content-Type", "application/json")
	c.JSON(200, gin.H{
		"status":     200,
		"message_id": "Suskes dowmload antrian",
		// "vendorID":   q,
	})
}

func (p *AntrianRepo) NextButton(c *gin.Context) {
	c.Header("Access-Control-Allow-Headers", "Content-type")
	c.Header("Access-Control-Allow-Method", "POST, GET, OPTIONS, PUT, DELETE")
	c.Header("Access-Control-Allow-Origin", "*")
	// var responses models.ResponseDisplayAntrian
	idPelayanan := c.Query("idPelayanan")
	// userID := c.Query("userID")
	// i, _ := strconv.Atoi(idPelayanan)
	err := p.repo.NextAntrian(idPelayanan)
	if err != nil {
		// log.Println(err.Error())
		c.AbortWithStatusJSON(c.Writer.Status(), handler.ErrorHandler(400, 400, err.Error()))
		return
	}

	c.Writer.Header().Set("Access-Control-Allow-Origin", "*")
	c.Header("Content-Type", "application/json")
	c.JSON(200, gin.H{
		"status":  200,
		"message": "Suskes update antrian",
		// "vendorID":   q,
	})
}

func (p *AntrianRepo) Scheduler(c *gin.Context) {
	c.Header("Access-Control-Allow-Headers", "Content-type")
	c.Header("Access-Control-Allow-Method", "POST, GET, OPTIONS, PUT, DELETE")
	c.Header("Access-Control-Allow-Origin", "*")
	// var responses models.ResponseDisplayAntrian
	// idPelayanan := c.Query("idPelayanan")
	// userID := c.Query("userID")
	// i, _ := strconv.Atoi(idPelayanan)
	err := p.repo.Scheduler()
	if err != nil {
		log.Println(err.Error())
		c.AbortWithStatusJSON(c.Writer.Status(), handler.ErrorHandler(400, 400, err.Error()))
		return
	}

	c.Header("Content-Type", "application/json")
	c.Writer.Header().Set("Access-Control-Allow-Origin", "*")
	// json.NewEncoder(c.Writer).Encode(responses)
}

func (p *AntrianRepo) CallButton(c *gin.Context) {
	c.Header("Access-Control-Allow-Headers", "Content-type")
	c.Header("Access-Control-Allow-Method", "POST, GET, OPTIONS, PUT, DELETE")
	c.Header("Access-Control-Allow-Origin", "*")
	idPelayanan := c.Query("idPelayanan")
	var responses models.ResponseCall
	token := c.Request.Header.Get("Authorization")

	_, errC := auth.ValidateToken(token)
	if errC != nil {
		c.AbortWithStatusJSON(400, handler.ErrorHandler(400, 422, errC.Error()))
		return
	}
	noAntrian, bol, err := p.repo.CallButton(idPelayanan)
	if err != nil {
		// log.Println(err.Error())
		responses.Status = 200
		responses.Message = "Success"
		responses.Panggil = false
		// responses.Data = panggil
		c.Header("Content-Type", "application/json")
		c.Writer.Header().Set("Access-Control-Allow-Origin", "*")
		json.NewEncoder(c.Writer).Encode(responses)
		return
	}

	no := []rune(noAntrian)
	count := 0
	for _, angk := range no {
		count += 1
		log.Println(angk)
	}
	log.Println(count)
	var angka2 string
	if count == 3 {
		angka2 = string(no[2])
	}

	panggil := []string{"bell-start", "nomorantrian", string(no[0]), string(no[1]) + angka2, "diloket", idPelayanan, "bell-end"}
	responses.Status = 200
	responses.Message = "Success"
	responses.Panggil = bol
	responses.Data = panggil
	c.Header("Content-Type", "application/json")
	c.Writer.Header().Set("Access-Control-Allow-Origin", "*")
	json.NewEncoder(c.Writer).Encode(responses)
}
