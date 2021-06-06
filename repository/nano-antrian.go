package repository

import "nano-antrian/models"

type NanoAntrian interface {
	AntrianList(idPelayana string) ([]models.AntrianList, error)
	GetUserByID(userName string) (models.User, error)
	GetJumlahAntrian(idPelayanan string) (models.JumlahAntrian, error)
	DisplayAntrian() ([]models.DisplayAntrian, error)
	ExportAntrian(start, end string) (string, error)
	GetJamKedatangan() int
	// GetUser(userName string)(models.DetailUser, error)
	NextAntrian(idPelayanan string) error
	Scheduler() error
	SignIn(params map[string]string) (string, error)
}
