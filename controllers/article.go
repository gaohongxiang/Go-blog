package controllers

import (
	"fmt"
	"github.com/astaxie/beego"
	"blog/models"
)

type ArticleController struct {
	beego.Controller
}

/* 首页*/ 
func (c *ArticleController) Index() {
	
	//得到当前页码、每页显示的记录的个数
	currentPage, _ := c.GetInt("page")
	pageNum := 10
	
	//得到所有文章的数据及总数、类别数据
	articles, totals := models.GetArticles(pageNum,currentPage)
	categorys := models.GetCategorys()
	classes := models.GetPublicClasses()
	fmt.Printf("%v\n",categorys)
	c.Data["currentPage"] = currentPage	//当前页
	c.Data["totals"] = totals			//数据的总数
	c.Data["Articles"] = articles 		//列表数据
	c.Data["Categorys"] = categorys		//文章类别
	c.Data["Classes"] = classes			//教程类别

	c.Layout = "layouts/layout.tpl"
	c.TplName = "article/index.tpl"
}

/*各类别展示页*/
func (c *ArticleController) CategoryList() {

	//得到当前页码、每页显示的记录的个数、当前类别
	currentPage, _ := c.GetInt("page")
	pageNum := 10
	categoryId, _ := c.GetInt64(":id")
	category := models.GetCategoryById(categoryId)

	//得到分页的数据及总数
	articles, totals := models.GetArticlesByCategory(categoryId,pageNum,currentPage)
	categorys := models.GetCategorys()
	classes := models.GetPublicClasses()
	c.Data["currentPage"] = currentPage	//当前页
	c.Data["totals"] = totals			//数据的总数
	c.Data["Articles"] = articles 		//列表数据
	c.Data["Categorys"] = categorys
	c.Data["Classes"] = classes
	c.Data["Category"] = category

	c.Layout = "layouts/layout.tpl"
	c.TplName = "article/list.tpl"
}

/*文章详情页*/
func (c *ArticleController) Detail() {

	//获取用户请求文章id
	id, _ := c.GetInt64(":id")

	//获取文章信息
	detail, category := models.GetArticleById(id)
	categorys := models.GetCategorys()
	classes := models.GetPublicClasses()
	c.Data["Detail"] = detail
	c.Data["Categorys"] = categorys
	c.Data["Classes"] = classes
	c.Data["Category"] = category

	c.Layout = "layouts/layout.tpl"
	c.TplName = "article/detail.tpl"
}

func (c *ArticleController) Search() {
	
	//得到用户输入的搜索关键字、当前页码、每页显示的记录的个数、当前类别
	keywords := c.GetString("keywords")
	currentPage, _ := c.GetInt("page")
	pageNum := 10


	//得到分页的数据及总数
  
	categorys := models.GetCategorys()
	classes := models.GetPublicClasses()
	articles, totals := models.GetArticlesByKeyWords(keywords,pageNum,currentPage)
	c.Data["currentPage"] = currentPage	//当前页
	c.Data["totals"] = totals			//数据的总数
	c.Data["Articles"] = articles 		//列表数据
	c.Data["Categorys"] = categorys
	c.Data["Classes"] = classes

	c.Layout = "layouts/layout.tpl"
	c.TplName = "article/search.tpl"
}
