package admin

import (
	"github.com/astaxie/beego"
	"blog/models"
)

type ArticleController struct {
	beego.Controller
}


//展示文章列表
func (c *ArticleController) List() {

	//得到当前页码、每页显示的记录的个数
	currentPage, _ := c.GetInt("page")
	pageNum := 10

	articles,totals := models.GetArticles(pageNum, currentPage)

	c.Data["currentPage"] = currentPage	//当前页
	c.Data["totals"] = totals			//数据的总数
	c.Data["Articles"] = articles 		//列表数据

	c.Layout = "admin/layouts/layout.tpl"
	c.TplName = "admin/article/list.tpl"
}

//展示添加文章页面
func (c *ArticleController) Add() {

	categorys := models.GetCategorys()

	c.Data["Categorys"] = categorys
	
	c.Layout = "admin/layouts/layout.tpl"
	c.TplName = "admin/article/add.tpl"
}

//执行添加文章操作
func (c *ArticleController) Addedit() {

	article := &models.Article{}

	article.Title = c.GetString("title")
	article.Content = c.GetString("content")

	id, _ := c.GetInt64("category")
	category := models.GetCategoryById(id)
	article.Category = &category
 
	models.InstertToArticle(article)

	c.Redirect("/admin/article/list", 301)
}
//展示修改文章页面
func (c *ArticleController) Update() {
	id,_ := c.GetInt64(":id")
	article,category := models.GetArticleById(id)
	categorys := models.GetCategorys()
	c.Data["Article"] = article 
	c.Data["Category"] = category
	c.Data["Categorys"] = categorys

	c.Layout = "admin/layouts/layout.tpl"
	c.TplName = "admin/article/edit.tpl"
}

//执行修改文章操作
func (c *ArticleController) Updateedit() {
	id,_ := c.GetInt64(":id")
	params := make(map[string]string)
	params["title"] = c.GetString("title")
	params["content"] = c.GetString("content")
	params["category"] = c.GetString("category")
	models.UpdateArticle(id, params)
	
	c.Redirect("/admin/article/list", 301)
}
//删除文章
func (c *ArticleController) Delete() {
	id,_ := c.GetInt64(":id")

	models.DeleteArticle(id)
	
	c.Redirect("/admin/article/list", 301)
}