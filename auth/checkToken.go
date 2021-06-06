package auth

import (
	"errors"
	"log"
	"nano-antrian/models"
	"strings"
	"time"

	"github.com/dgrijalva/jwt-go"
)

func ValidateToken(token string) (models.TokenInfo, error){
	var response models.TokenInfo

	// token := mux.Vars(r)["token"]
	if len(token) > 0 {
		log.Println("TOKENNNNN")
		tkn := strings.Split(token, " ")
	t, e := jwt.Parse(tkn[1], func(t *jwt.Token)(interface{}, error){
		return []byte(secretKey), nil
	})
	if e == nil {
		if claims, ok := t.Claims.(jwt.MapClaims); ok && t.Valid{
			userID := claims["userID"]
			userName := claims["userName"]
			hit := claims["hit"].(float64)

			times := time.Unix(int64(hit),0)

			response.UserID = userID.(string)
			response.UserName = userName.(string)
			response.Hit = times.Format(time.RFC3339)

			return response, nil
		} else {
			return response, nil
		}
	} else {
		// log.Println("ERRPOR")
		return response, e
	}
} else {
	return response, errors.New("Token is Required")
}

	
}

