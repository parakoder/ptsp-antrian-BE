package models

import "time"

type ResponseAntrian struct {
	Status  int           `json:"status"`
	Message string        `json:"message"`
	Data    []AntrianList `json:"data"`
}

type AntrianList struct {
	No_Antrian     string `json:"noAntrian"`
	Loket          string `json:"Loket"`
	Jam_Kedatangan string `json:"jamKedatangan"`

	Lama_Menunggu  *int       `json:"lamaMenunggu"`
	Lama_Pelayanan *int       `json:"lamaPelayanan"`
	Jam_Dilayani   *time.Time `json:"jamDilayani"`
}

type ResponseUser struct {
	Status  int    `json:"status"`
	Message string `json:"message"`
	Data    User   `json:"data"`
}

type User struct {
	ID          int    `json:"id"`
	Username    string `json:"userName"`
	Nama        string `json:"nama"`
	LoketID     int    `json:"loketID"`
	OnlineID    string `json:"onlineID"`
	OfflineID   string `json:"offlineID"`
	NamaLayanan string `json:"namaPelayanan"`
}

type JumlahAntrian struct {
	TotalAntrian       int    `json:"totalAntrian"`
	AntrianSelesai     int    `json:"antrianSelesai"`
	AntrianBerlangsung int    `json:"antrianBerlangsung"`
	NoAntiran          string `json:"noAntrian"`
	NoAntiranOff       string `json:"noAntrianOff"`
}
type ResponseJumlahAntrian struct {
	Status  int           `json:"status"`
	Message string        `json:"message"`
	Data    JumlahAntrian `json:"data"`
}

type DisplayAntrian struct {
	Loket   string `json:"loket"`
	Antrian string `json:"antrian"`
}
type ResponseDisplayAntrian struct {
	Status  int              `json:"status"`
	Message string           `json:"message"`
	Data    []DisplayAntrian `json:"data"`
}

type UserAccount struct {
	ID       string `json:"id"`
	Username string `json:userName`
	Password string `json:password`
}

type TokenInfo struct {
	UserID   string `json:"userID"`
	UserName string `json:"userName"`
	Hit      string `json:"hit"`
}

type ResponseToken struct {
	Status  int    `json:"status"`
	Message string `json:"message"`
	Data    Token  `json:"data"`
}

type Token struct {
	NamaLoket string `json:"namaLoket"`
	Nama      string `json:"nama"`
	LoketID   int    `json:"loketID"`
	OnlineID  string `json:"onlineID"`
	OfflineID string `json:"offlineID"`
	UserID    int    `json:"userID"`
	Username  string `json:"userName"`
	Token     string `json:"accessToken"`
	TokenType string `json:"tokenType"`
}

type DetailUser struct {
	ID            int    `json:"id"`
	Username      string `json:"userName"`
	OnlineID      string `json:"onlineID"`
	OfflineID     string `json:"offlineID"`
	Namapelayanan string `json:"namaPelayanan"`
}

type ExportAntrian struct {
	Nama_lengkap       string
	No_identitas       *string
	Jenis_kelamin      *string
	Alamat             *string
	Email              *string
	No_hp              *string
	Tanggal_Kedatangan string
	Loket              string
	Jam_Kedatangan     string
	Status             string
	Lama_menunggu      *int
	Lama_pelayanan     *int
	Jam_Dilayani       *time.Time
}

type ResponseCall struct {
	Status  int      `json:"status"`
	Message string   `json:"message"`
	Panggil bool     `json:"panggil"`
	Data    []string `json:"data"`
}
