package controllers

import (
	"fmt"
	"github.com/astaxie/beego"
	"blog/models"
)

type LoginController struct {
	beego.Controller
}

/* 首页*/
func (c *LoginController) Login() {
	//获取用户名、密码
	name := c.GetString("name")
	password := c.GetString("password")
	user, err := models.Login(name)
	if err != nil {
		fmt.Println("没有此用户，请注册")
	}
	if password != user.Password {
		fmt.Println("密码不正确")
	}
	
	c.Redirect(c.Ctx.Request.RequestURI, 301)//重定向到当前页面
	
}

