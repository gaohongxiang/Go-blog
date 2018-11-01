package main

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	_ "github.com/go-sql-driver/mysql"
	_ "blog/routers"
)

func init() {
    //注册驱动
	orm.RegisterDriver("mysql", orm.DRMySQL)
	//设置默认数据库、用户名、密码、字符集、时区
	database := beego.AppConfig.String("database")
   	dbuser := beego.AppConfig.String("dbuser")
   	dbpassword := beego.AppConfig.String("dbpassword")
	dsn := dbuser+":"+dbpassword+"@/"+database+"?charset=utf8&loc=Asia%2FShanghai"
	orm.RegisterDataBase("default", "mysql", dsn)
}

func main() {
	// 开启 ORM 调试模式
	orm.Debug = true
    // 自动建表。第一个参数代表默认数据库，第二个参数true为强制建表，第三个参数true会带上很多数据库操作和建表操作的打印信息。
	orm.RunSyncdb("default", false, true)

    beego.Run()
}