package models

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm" //导入包
	"time"
	"strconv"
)

type Tutorial struct {
	Id			int64
	Pid			int64
	Class		*Class		`orm:"rel(fk)"` //设置一对多关系 一个Sort对应多个Tutorial
	Title		string
	Content		string		`orm:"type(text);null"` //对应mysql的longtext类型，并允许为空（目录级的为空）
	Status		int			`orm:"default:(0)"`
	Sort		int
	Created_at	time.Time	`orm:"auto_now_add;type(datetime)"`
	Updated_at	time.Time	`orm:"auto_now;type(datetime)"`
}

func init() {
    // 需要在init中注册定义的model
	// orm.RegisterModel(new(User), new(Post), new(Profile), new(Tag))
	dbprefix := beego.AppConfig.String("dbprefix")//数据表前缀
	orm.RegisterModelWithPrefix(dbprefix, new(Tutorial))
}

//各教程文章列表
func GetTutorialsByClass(class int) ([]*Tutorial) {
    o := orm.NewOrm()
	var tutorials []*Tutorial
	o.QueryTable("ghx_tutorial").Filter("Class",class).RelatedSel().OrderBy("sort").All(&tutorials)
	return tutorials
}

//文章详情
func GetTutorialById(id int64) (tutorial Tutorial, class Class) {
	o := orm.NewOrm()
	o.QueryTable("ghx_tutorial").Filter("id", id).RelatedSel().One(&tutorial)
	o.QueryTable("ghx_class").Filter("Tutorial__Id", id).Limit(1).One(&class)
    return tutorial, class
}

func InstertToTutorial(tutorial *Tutorial) int64 {
	o := orm.NewOrm()
	id, _ := o.Insert(tutorial)//新插入的数据的id
	return id
}

func UpdateTutorial(id int64, params map[string]string) {
	o := orm.NewOrm()
	tutorial := Tutorial{Id: id}
	if o.Read(&tutorial) == nil {
		for k, v := range params {
			if k == "title" {
				tutorial.Title = v
			}
			if k == "content" {
				tutorial.Content = v
			}
			if k == "sort" {
				sort, _ := strconv.ParseInt(v, 10, 32)//string类型转换为int64类型
				tutorial.Sort = int(sort)
			}
		}
		o.Update(&tutorial)
	}
	return
}