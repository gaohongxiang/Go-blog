本项目是基于beego框架开发的个人博客。使用步骤如下


## 安装go语言

安装go语言并设置GOPATH。参考：[GO安装与配置](http://www.blockchant.cn/tutorial/detail/53)

## 克隆源码

```
cd src //进入src目录

git clone https://github.com/gaohongxiang/Go-blog.git
```

当然，克隆下来的项目名称可以换成自己的
```
sudo mv Go-blog 你的项目名
```

## 获取beego框架、数据库引擎

```
go get github.com/astaxie/beego

go get github.com/go-sql-driver/mysql
```

## 修改配置文件

conf/app.conf为配置文件。相关配置修改为自己的。如数据库名、表前缀等

