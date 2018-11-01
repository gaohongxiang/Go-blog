package models

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm" //导入包
	"time"
)

//定义 struct和数据表进行映射
type User struct {
    Id          int64
	Name        string
	Password	string
	Status		int		    `orm:"default:(0)"`
	Created_at  time.Time	`orm:"auto_now_add;type(datetime)"` //设置创建时自动添加时间
	Updated_at	time.Time	`orm:"auto_now;type(datetime)"` //设置修改时自动添加时间
}

func init() {
    // 需要在init中注册定义的model
	// orm.RegisterModel(new(User), new(Post), new(Profile), new(Tag))
	dbprefix := beego.AppConfig.String("dbprefix")//数据表前缀
	orm.RegisterModelWithPrefix(dbprefix, new(User))
}

func Login(name string) (User, error) {
	o := orm.NewOrm()
	user := User{Name: name}
    err := o.Read(&user, "Name")
    return user,err
}