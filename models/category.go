package models

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm" //导入包
	"time"
	"strconv"
)

type Category struct {
	Id			int64
	Pid			int64
	Name		string
	Status		int64		`orm:"default:(0)"`
	Sort		int64
	Article		[]*Article	`orm:"reverse(many)"` //设置一对多的反向关系。
	Created_at  time.Time	`orm:"auto_now_add;type(datetime)"`
	Updated_at	time.Time	`orm:"auto_now;type(datetime)"`
	Children	[]*Category	`orm:"-"`	//用于树形化类别
}

func init() {
    // 需要在init中注册定义的model
	// orm.RegisterModel(new(User), new(Post), new(Profile), new(Tag))
	dbprefix := beego.AppConfig.String("dbprefix")//数据表前缀
	orm.RegisterModelWithPrefix(dbprefix, new(Category))
}

func GetCategorys() (categorys []*Category) {
	o := orm.NewOrm()
	o.QueryTable("ghx_category").All(&categorys)

	return categorys
}

func GetCategoryById(id int64) (catetory Category) {
	o := orm.NewOrm()
	o.QueryTable(new(Category)).Filter("id", id).One(&catetory)
	return catetory
}

//无限极分类不会

// func GetCategory() (categorysTree []*Category) {
// 	var categorys []*Category
// 	o := orm.NewOrm()
// 	o.QueryTable("ghx_category").All(&categorys)
// 	data := buildData(categorys)
// 	categorysTree = makeTreeCore(0, data)

// 	return categorysTree
// }

// func buildData(list []*Category) map[int]map[int]*Category {
// 	var data map[int]map[int]*Category = make(map[int]map[int]*Category)
// 	for _, v := range list {
// 		id := v.Id
// 		Pid := v.Pid
// 		if _, ok := data[Pid]; !ok {
// 			data[Pid] = make(map[int]*Category)
// 		}
// 		data[Pid][id] = v
// 	}
// 	return data
// }

// func makeTreeCore(index int, data map[int]map[int]*Category) []*Category {
// 	tmp := make([]*Category, 0)
// 	for id, item := range data[index] {
// 		if data[id] != nil {
// 			item.Children = makeTreeCore(id, data)
// 		}
// 		tmp = append(tmp, item)
// 	}
// 	return tmp
// }

func InstertToCategory(category *Category) int64 {
	o := orm.NewOrm()
	id, _ := o.Insert(category)//新插入的数据的id
	return id
}

func UpdateCategory(id int64, params map[string]string) {
	o := orm.NewOrm()
	category := Category{Id: id}
	if o.Read(&category) == nil {
		for k, v := range params {
			if k == "name" {
				category.Name = v
			}
			if k == "sort" {
				sort, _ := strconv.ParseInt(v, 10, 32)//string类型转换为int64类型
				category.Sort = sort
			}
		}
		o.Update(&category)
	}
	return
}

func DeleteCategory(id int64) error {
	o := orm.NewOrm()

	category := Category{Id: id}
	if _, err := o.Delete(&category); err != nil {
		return err
	}
	return nil
}