package models

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm" //导入包
	"time"
	"strconv"
)

type Class struct {
	Id			int64
	Name		string
	Desc		string
	Status		int64		`orm:"default:(0)"`
	Sort		int64
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

func InstertToClass(class *Class) int64 {
	o := orm.NewOrm()
	id, _ := o.Insert(class)//新插入的数据的id
	return id
}

func UpdateClass(id int64, params map[string]string) {
	o := orm.NewOrm()
	class := Class{Id: id}
	if o.Read(&class) == nil {
		for k, v := range params {
			if k == "name" {
				class.Name = v
			}
			if k == "desc" {
				class.Desc = v
			}
			if k == "sort" {
				sort, _ := strconv.ParseInt(v, 10, 32)//string类型转换为int64类型
				class.Sort = sort
			}
		}
		o.Update(&class)
	}
	return
}

func DeleteClass(id int64) error {
	o := orm.NewOrm()

	class := Class{Id: id}
	if _, err := o.Delete(&class); err != nil {
		return err
	}
	return nil
}