package admin

import (
	"github.com/astaxie/beego"
	"blog/models"
)

type ClassController struct {
	beego.Controller
}

//展示教程列表
func (c *ClassController) List() {

	classes := models.GetClasses()

	c.Data["Classes"] = classes

	c.Layout = "admin/layouts/layout.tpl"
	c.TplName = "admin/class/list.tpl"
}

//展示添加教程页面
func (c *ClassController) Add() {

	c.Layout = "admin/layouts/layout.tpl"
	c.TplName = "admin/class/add.tpl"
}
//执行添加教程操作
func (c *ClassController) Addedit() {

	class := &models.Class{}

	class.Name = c.GetString("name")
	class.Sort, _ = c.GetInt64("sort")
	class.Desc = c.GetString("desc")

	models.InstertToClass(class)

	c.Redirect("/admin/class/list", 301)
}

//展示修改教程页面
func (c *ClassController) Update() {
	
	id, _ := c.GetInt64(":id")
	class := models.GetClassById(id)

	c.Data["Class"] = class

	c.Layout = "admin/layouts/layout.tpl"
	c.TplName = "admin/class/edit.tpl"
}

//执行修改教程操作
func (c *ClassController) Updateedit() {

	id,_ := c.GetInt64(":id")
	params := make(map[string]string)
	params["name"] = c.GetString("name")
	params["desc"] = c.GetString("desc")
	params["sort"] = c.GetString("sort")
	models.UpdateClass(id, params)
	
	c.Redirect("/admin/class/list", 301)
}

//删除教程
func (c *ClassController) Delete() {
	id,_ := c.GetInt64(":id")

	models.DeleteClass(id)
	
	c.Redirect("/admin/class/list", 301)
}
