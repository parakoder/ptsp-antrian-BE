package auth

import (
	"log"
	"time"

	"github.com/dgrijalva/jwt-go"
)



type Exception struct {
	Messages string `form:"messages"`
}

var secretKey = []byte("secret12345")

func GenerateToken(params map[string]string)(string, error){
	token := jwt.New(jwt.SigningMethodHS256)
	claims := token.Claims.(jwt.MapClaims)

	claims["userID"] = params["userID"]
	claims["userName"] = params["userName"]
	claims["hit"] = time.Now().Unix()
	
	tokenString, err := token.SignedString(secretKey)
	if err != nil {
		log.Println("tess1")
		return "", err
	}
	return tokenString, nil
}

