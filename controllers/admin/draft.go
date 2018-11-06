package admin

import (
	"github.com/astaxie/beego"
	"blog/models"
)

type DraftController struct {
	beego.Controller
}

//执行添加草稿文章操作
func (c *DraftController) Addedit() {

	article := &models.Article{}

	article.Title = c.GetString("title")
	article.Content = c.GetString("content")
	article.Status = int(1)

	id, _ := c.GetInt64("category")
	category := models.GetCategoryById(id)
	article.Category = &category
 
	models.InstertToArticle(article)

	c.Redirect("/admin/draft/list", 301)
}

//展示草稿文章列表
func (c *DraftController) List() {

	//得到当前页码、每页显示的记录的个数
	currentPage, _ := c.GetInt("page")
	pageNum := 10

	drafts,totals := models.GetDrafts(pageNum, currentPage)

	c.Data["currentPage"] = currentPage	//当前页
	c.Data["totals"] = totals			//数据的总数
	c.Data["Drafts"] = drafts 		//列表数据

	c.Layout = "admin/layouts/layout.tpl"
	c.TplName = "admin/draft/list.tpl"
}


//展示修改草稿文章页面
func (c *DraftController) Update() {
	id,_ := c.GetInt64(":id")
	draft,category := models.GetArticleById(id)
	categorys := models.GetCategorys()
	c.Data["Draft"] = draft 
	c.Data["Category"] = category
	c.Data["Categorys"] = categorys

	c.Layout = "admin/layouts/layout.tpl"
	c.TplName = "admin/draft/edit.tpl"
}

//执行修改草稿文章操作
func (c *DraftController) Updateedit() {
	id,_ := c.GetInt64(":id")
	params := make(map[string]string)
	params["title"] = c.GetString("title")
	params["content"] = c.GetString("content")
	params["category"] = c.GetString("category")
	models.UpdateArticle(id, params)
	
	c.Redirect("/admin/draft/list", 301)
}

//执行修改草稿文章并发布操作
func (c *DraftController) Updaterelease() {
	id,_ := c.GetInt64(":id")
	params := make(map[string]string)
	params["title"] = c.GetString("title")
	params["content"] = c.GetString("content")
	params["status"] = "0"
	params["category"] = c.GetString("category")
	models.UpdateArticle(id, params)

	c.Redirect("/admin/draft/list", 301)
}

//直接执行发布操作
func (c *DraftController) Release() {
	id,_ := c.GetInt64(":id")
	
	models.UpdateArticleStatusById(id, 0)

	c.Redirect("/admin/draft/list", 301)
}

//删除草稿文章
func (c *DraftController) Delete() {
	id,_ := c.GetInt64(":id")

	models.DeleteArticle(id)
	
	c.Redirect("/admin/draft/list", 301)
}