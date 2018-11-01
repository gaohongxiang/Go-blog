package controllers

import (
	"github.com/astaxie/beego"
	"blog/models"
)

type CategoryController struct {
	beego.Controller
}

func (c *CategoryController) Show() {
	categorys := models.GetCategorys()
	c.Data["Categorys"] = categorys
	c.TplName = "layouts/header.tpl"
}

