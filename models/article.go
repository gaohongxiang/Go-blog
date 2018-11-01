package models

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm" //导入包
	"time"
	"strconv"
)

type Article struct {
	Id			int64
	Category	*Category	`orm:"rel(fk)"` //设置一对多关系 一个Category对应多个Article
	Title		string
	Content		string		`orm:"type(text)"` //对应mysql的longtext类型
	Status		int			`orm:"default:(0)"`
	Created_at	time.Time	`orm:"auto_now_add;type(datetime)"`
	Updated_at	time.Time	`orm:"auto_now;type(datetime)"`
}

func init() {
    // 需要在init中注册定义的model
	// orm.RegisterModel(new(User), new(Post), new(Profile), new(Tag))
	dbprefix := beego.AppConfig.String("dbprefix")//数据表前缀
	orm.RegisterModelWithPrefix(dbprefix, new(Article))
}

//全部文章数据
func GetArticles(pageNum int,currentPage int) ([]*Article, int64) {
	o := orm.NewOrm()
	var articles []*Article
	o.QueryTable("ghx_article").OrderBy("-id").Limit(pageNum,(currentPage-1)*pageNum).RelatedSel().All(&articles)
	totals, _ := o.QueryTable("ghx_article").Count()
	return articles, totals
}

//各分类页数据
func GetArticlesByCategory(category int64, pageNum int,currentPage int) ([]*Article, int64) {
    o := orm.NewOrm()
	var articles []*Article
	o.QueryTable("ghx_article").Filter("Category",category).RelatedSel().OrderBy("-id").Limit(pageNum,(currentPage-1)*pageNum).All(&articles)
	totals, _ := o.QueryTable("ghx_article").Filter("Category",category).Count()
	return articles, totals
}


//文章详情
func GetArticleById(id int64) (article Article, category Category) {
	o := orm.NewOrm()
	o.QueryTable("ghx_article").Filter("id", id).One(&article)
	o.QueryTable("ghx_category").Filter("article__Id", id).Limit(1).One(&category)
    return article, category
}

/*搜索文章功能*/
func GetArticlesByKeyWords(keywords string, pageNum int, currentPage int) (articles []*Article, totals int64) {
	o := orm.NewOrm()
	o.QueryTable("ghx_article").Filter("title__icontains", keywords).Limit(pageNum,(currentPage-1)*pageNum).All(&articles)
	totals, _ = o.QueryTable("ghx_article").Filter("title__icontains", keywords).Count()
	return articles, totals
}

//添加文章操作
func InstertToArticle(article *Article) int64 {
	o := orm.NewOrm()

	// article := new(Article)
	// article.Title = title
	// article.Content = content
	// article.Category = category

	//执行添加操作
	id, _ := o.Insert(article)//新插入的数据的id
	return id
}

func UpdateArticle(id int64, params map[string]string) {
	o := orm.NewOrm()
	article := Article{Id: id}
	if o.Read(&article) == nil {
		for k, v := range params {
			if k == "title" {
				article.Title = v
			}
			if k == "content" {
				article.Content = v
			}
			if k == "category" {
				id, _ := strconv.ParseInt(v, 10, 32)//string类型转换为int64类型
				category := GetCategoryById(id)
				article.Category = &category
			}
		}
		o.Update(&article)
	}
	return
}

func DeleteArticle(id int64) error {
	o := orm.NewOrm()

	article := Article{Id: id}
	if _, err := o.Delete(&article); err != nil {
		return err
	}
	return nil
}