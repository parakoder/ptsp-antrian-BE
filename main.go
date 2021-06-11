package main

import (
	"fmt"
	"nano-antrian/config"
	"nano-antrian/controllers"
	"os"
	"time"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
)

// func main() {
//  if err := godotenv.Load(); err != nil {
// 	 panic(".env does not exist")
// 	 } else {

// 		log.Println("CONN ")
// 	 conn, errConn := config.ConnectSQL()
// 	 if errConn != nil {
// 		 fmt.Println(errConn)
// 		 os.Exit(-1)
// 	 }

// 	 r := gin.Default()
// 	r.GET("/", func(c *gin.Context) {
// 		c.JSON(200, gin.H{
// 			"message" : "Wellcome to antrian service",
// 		})
// 	})

// 	aController := controllers.NewAntrianHandler(conn)
// 	a := r.Group("v1/api/antrian")
// 	{
// 		a.GET("/getAntrian", aController.GetAntrianList)
// 	}
// 	r.Use(cors.New(cors.Config{
// 		AllowOrigins:     []string{"*"},
// 		AllowMethods:     []string{"POST, GET, OPTIONS, PUT, DELETE"},
// 		AllowHeaders:     []string{"*"},
// 		ExposeHeaders:    []string{"*"},
// 		AllowCredentials: true,
// 		AllowOriginFunc: func(origin string) bool {
// 			return origin == "*"
// 		},
// 		MaxAge: 12 * time.Hour,
// 	}))
// 	r.Run(":" + os.Getenv("PORT"))
//  }

// }

func main() {
	if err := godotenv.Load(".env.prod"); err != nil {
		panic(".env not exists")
	} else {

		conn, errConn := config.ConnectSQL()
		if errConn != nil {
			fmt.Println(errConn)
			os.Exit(-1)
		}
		// log.Println("MAIN", conn)

		r := gin.Default()
		r.GET("/", func(c *gin.Context) {
			c.JSON(200, gin.H{
				"messages": "Wellcome to ptsp-antrian service",
			})
		})

		aController := controllers.NewAntrianHandler(conn)

		a := r.Group("v1/api/antrian")
		{

			a.GET("/queue-table", aController.GetAntrianList)
			a.GET("/profile", aController.GetUserByID)
			a.GET("/card", aController.GetTotalAntrian)
			a.GET("/display", aController.DisplayAntrian)
			a.GET("/export", aController.ExportAntrian)
			a.PUT("/next", aController.NextButton)
			a.GET("/call", aController.CallButton)
			a.POST("/signin", aController.SignIn)
		}

		r.Use(cors.New(cors.Config{
			AllowOrigins:     []string{"*"},
			AllowMethods:     []string{"POST, GET, OPTIONS, PUT, DELETE"},
			AllowHeaders:     []string{"*"},
			ExposeHeaders:    []string{"*"},
			AllowCredentials: true,
			AllowOriginFunc: func(origin string) bool {
				return origin == "*"
			},
			MaxAge: 12 * time.Hour,
		}))
		r.Run(":" + os.Getenv("APP_PORT"))
	}
}
