package routers

import (
	"blog/controllers"
	"blog/controllers/admin"
	"github.com/astaxie/beego"
)

func init() {

	/************************************前台路由**************************************************/
	beego.Router("/", &controllers.ArticleController{},"get:Index")
	beego.Router("/article/detail/:id([0-9]+)", &controllers.ArticleController{},"get:Detail")
	beego.Router("/article/categoryList/:id([0-9]+)", &controllers.ArticleController{},"get:CategoryList")
	beego.Router("/tutorial/classList/:id([0-9]+)", &controllers.TutorialController{},"get:ClassList")
	beego.Router("/tutorial/detail/:id([0-9]+)", &controllers.TutorialController{},"get:Detail")
	// beego.AutoRouter(&controllers.ArticleController{})
	beego.Router("/login",&controllers.LoginController{},"post:Login")
	beego.AutoRouter(&controllers.LoginController{})



	/************************************后台路由**************************************************/

	/*****************文章相关路由*****************************/
	beego.Router("/admin/article/list", &admin.ArticleController{},"get:List")
	beego.Router("/admin/article/add", &admin.ArticleController{},"get:Add")
	beego.Router("/admin/article/addedit", &admin.ArticleController{},"post:Addedit")
	beego.Router("/admin/article/update/:id([0-9]+)", &admin.ArticleController{},"get:Update")
	beego.Router("/admin/article/updateedit/:id([0-9]+)", &admin.ArticleController{},"post:Updateedit")
	beego.Router("/admin/article/delete/:id([0-9]+)", &admin.ArticleController{},"get:Delete")
	//或者直接用自动路由，用到路由的地方直接用 /article/方法名的形式来表示即可
	// beego.AutoRouter(&admin.ArticleController{})


	/*****************教程相关路由*****************************/
	//教程列表
	beego.Router("/admin/tutorial/classes", &admin.TutorialController{},"get:ClassesList")
	//具体教程文章列表
	beego.Router("/admin/tutorial/list/:id([0-9]+)", &admin.TutorialController{},"get:List")
	//教程文章详情
	beego.Router("/admin/tutorial/detail/:id([0-9]+)", &admin.TutorialController{},"get:Detail")
	
	//添加教程章节(弹出层形式，没有展示添加页面)
	beego.Router("/admin/tutorial/addchapter", &admin.TutorialController{},"post:Addchapter")
	//修改教程章节(弹出层形式，没有展示修改页面)
	beego.Router("/admin/tutorial/updateeditchapter/:id([0-9]+)", &admin.TutorialController{},"post:Updateeditchapter")
	//添加教程文章
	beego.Router("/admin/tutorial/add/:id([0-9]+)", &admin.TutorialController{},"get:Add")
	beego.Router("/admin/tutorial/addedit/:id([0-9]+)", &admin.TutorialController{},"post:Addedit")
	//修改教程文章
	beego.Router("/admin/tutorial/updateedit/:id([0-9]+)", &admin.TutorialController{},"post:Updateedit")
	

}