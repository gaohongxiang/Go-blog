package controllers

import (
	"github.com/astaxie/beego"
	"blog/models"
)

type TutorialController struct {
	beego.Controller
}
 

func (c *TutorialController) ClassList() {
	
	
	id, _ := c.GetInt(":id")
	tutorials := models.GetTutorialsByClass(id)
	categorys := models.GetCategorys()
	classes := models.GetClasses()
	class := models.GetClassById(int64(id))

	c.Data["Categorys"] = categorys
	c.Data["Classes"] = classes
	c.Data["Tutorials"] = tutorials
	c.Data["Class"] = class

	c.Layout = "layouts/layout2.tpl"
	c.TplName = "tutorial/desc.tpl"
}


/*教程详情页*/
func (c *TutorialController) Detail() {

	//获取用户请求文章id
	id, _ := c.GetInt64(":id")

	//获取文章信息和文章所属类别
	detail, class := models.GetTutorialById(id)
	tutorials := models.GetTutorialsByClass(int(class.Id))
	categorys := models.GetCategorys()
	classes := models.GetClasses()

	c.Data["Categorys"] = categorys
	c.Data["Classes"] = classes
	c.Data["Class"] = class
	c.Data["Tutorials"] = tutorials
	c.Data["Detail"] = detail
	
	c.Layout = "layouts/layout2.tpl"
	c.TplName = "tutorial/detail.tpl"
}