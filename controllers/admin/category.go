package admin

import (
	"github.com/astaxie/beego"
	"blog/models"
)

type CategoryController struct {
	beego.Controller
}

//展示教程列表
func (c *CategoryController) List() {

	categorys := models.GetCategorys()

	c.Data["Categorys"] = categorys

	c.Layout = "admin/layouts/layout.tpl"
	c.TplName = "admin/category/list.tpl"
}

//展示添加教程页面
func (c *CategoryController) Add() {

	c.Layout = "admin/layouts/layout.tpl"
	c.TplName = "admin/category/add.tpl"
}
//执行添加教程操作
func (c *CategoryController) Addedit() {

	category := &models.Category{}

	category.Name = c.GetString("name")
	category.Sort, _ = c.GetInt64("sort")

	models.InstertToCategory(category)

	c.Redirect("/admin/category/list", 301)
}

//展示修改教程页面
func (c *CategoryController) Update() {
	
	id, _ := c.GetInt64(":id")
	category := models.GetCategoryById(id)

	c.Data["Category"] = category

	c.Layout = "admin/layouts/layout.tpl"
	c.TplName = "admin/category/edit.tpl"
}

//执行修改教程操作
func (c *CategoryController) Updateedit() {

	id,_ := c.GetInt64(":id")
	params := make(map[string]string)
	params["name"] = c.GetString("name")
	params["sort"] = c.GetString("sort")
	models.UpdateCategory(id, params)
	
	c.Redirect("/admin/category/list", 301)
}

//删除教程
func (c *CategoryController) Delete() {
	id,_ := c.GetInt64(":id")

	models.DeleteCategory(id)
	
	c.Redirect("/admin/category/list", 301)
}
