package models

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm" //导入包
	"time"
)

type Class struct {
	Id			int64
	Name		string
	Desc		string
	Status		int
	Sort		int
	Tutorial	[]*Tutorial	`orm:"reverse(many)"` //设置一对多的反向关系。
	Created_at	time.Time	`orm:"auto_now_add;type(datetime)"`
	Updated_at	time.Time	`orm:"auto_now;type(datetime)"`
}

func init() {
    // 需要在init中注册定义的model
	// orm.RegisterModel(new(User), new(Post), new(Profile), new(Tag))
	dbprefix := beego.AppConfig.String("dbprefix")//数据表前缀
	orm.RegisterModelWithPrefix(dbprefix, new(Class))
}

//教程类别
func GetClasses() (class []*Class) {
	o := orm.NewOrm()
	o.QueryTable("ghx_class").All(&class)

	return class
}

func GetClassById(id int64) (Class) {
	o := orm.NewOrm()
	var class Class
	o.QueryTable("ghx_class").Filter("Id",id).One(&class)
	return class
}