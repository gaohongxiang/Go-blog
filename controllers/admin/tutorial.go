package admin

import (
	"github.com/astaxie/beego"
	"blog/models"
	"strconv"
	"fmt"
)

type TutorialController struct {
	beego.Controller
}


//展示教程列表
func (c *TutorialController) ClassesList() {

	classes := models.GetClasses()

	c.Data["Classes"] = classes

	c.Layout = "admin/layouts/layout.tpl"
	c.TplName = "admin/tutorial/classes.tpl"
}

//展示具体教程内容列表
func (c *TutorialController) List() {
	//获取分类id
	classId, _ := c.GetInt(":id")
	tutorials := models.GetTutorialsByClass(classId)
	class := models.GetClassById(int64(classId))
	c.Data["Tutorials"] = tutorials
	c.Data["Class"] = class
	c.Layout = "admin/layouts/layout2.tpl"
	c.TplName = "admin/tutorial/desc.tpl"
}

//教程文章详情
func (c *TutorialController) Detail() {
	//获取具体文章id
	id, _ := c.GetInt(":id")
	//获取文章详情和所属分类
	detail, class := models.GetTutorialById(int64(id))
	//获取分类信息
	tutorials := models.GetTutorialsByClass(int(class.Id))

	c.Data["Tutorials"] = tutorials
	c.Data["Class"] = class
	c.Data["Detail"] = detail

	c.Layout = "admin/layouts/layout2.tpl"
	c.TplName = "admin/tutorial/list.tpl"
}

//执行添加章节操作（弹出层形式，没有展示添加章节页面）
func (c *TutorialController) Addchapter() {

	tutorial := &models.Tutorial{}

	tutorial.Title = c.GetString("title")
	tutorial.Sort, _ = c.GetInt("sort")
	tutorial.Pid = int64(0)

	id, _ := c.GetInt64("class")
	class := models.GetClassById(id)
	tutorial.Class = &class
	fmt.Println(id)
	fmt.Println(tutorial.Class)
	models.InstertToTutorial(tutorial)

	stringId := strconv.FormatInt(id,10)
	c.Redirect("/admin/tutorial/list/"+stringId, 301)
}

//执行修改教程章节操作
func (c *TutorialController) Updateeditchapter() {
	id, _ := c.GetInt64(":id")
	fmt.Println(id)
	params := make(map[string]string)
	params["title"] = c.GetString("title")
	params["sort"] = c.GetString("sort")
	models.UpdateTutorial(id, params)

	//如何重定向到当前页面
	stringId := strconv.FormatInt(id,10)
	c.Redirect("/admin/tutorial/detail/"+stringId, 301)

}

//展示添加教程文章页面（需要教程文章所属章节的id）
func (c *TutorialController) Add() {

	pid, _ := c.GetInt(":id")

	//获取文章详情和所属分类
	detail, class := models.GetTutorialById(int64(pid))
	//获取分类信息
	tutorials := models.GetTutorialsByClass(int(class.Id))

	c.Data["Tutorials"] = tutorials
	c.Data["Class"] = class
	c.Data["Detail"] = detail
	c.Data["Pid"] = pid
	c.Layout = "admin/layouts/layout2.tpl"
	c.TplName = "admin/tutorial/add.tpl"
}

//执行添加教程文章操作
func (c *TutorialController) Addedit() {

	pid, _ := c.GetInt64(":id")
	tutorial := &models.Tutorial{}

	tutorial.Title = c.GetString("title")
	tutorial.Content = c.GetString("content")
	tutorial.Sort, _ = c.GetInt("sort")
	tutorial.Pid = pid

	_, class := models.GetTutorialById(int64(pid))
	// class := models.GetClassById(pid)
	tutorial.Class = &class

	models.InstertToTutorial(tutorial)

	// stringId := strconv.FormatInt(pid,10)
	c.Redirect("/admin/tutorial/list/7", 301)
}


//执行修改教程文章操作
func (c *TutorialController) Updateedit() {
	id,_ := c.GetInt64(":id")
	params := make(map[string]string)
	params["title"] = c.GetString("title")
	params["content"] = c.GetString("content")
	params["sort"] = c.GetString("sort")
	models.UpdateTutorial(id, params)

	//如何重定向到当前页面
	stringId := strconv.FormatInt(id,10)
	c.Redirect("/admin/tutorial/detail/"+stringId, 301)
	
}
//删除文章
func (c *TutorialController) Delete() {
	id,_ := c.GetInt64(":id")

	models.DeleteArticle(id)
	
	c.Redirect("/admin/article/list", 301)
}