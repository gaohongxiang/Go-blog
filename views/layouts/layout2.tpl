<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>{{.Class.Name}} 教程</title>
  <link rel="stylesheet" href="../../static/layui-2.4.3/css/layui.css">
  <link rel="stylesheet" href="../../static/editor/css/editormd.min.css" />
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo"><i class="layui-icon layui-icon-release" style="font-size: 45px; color: #1E9FFF;"></i></div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="/">首页</a></li>
            {{$GlobalCategorys:=.Categorys}}
            {{range $value := $GlobalCategorys}}
                {{if eq $value.Pid 0}}
                    <!-- class="layui-this"表示选中 -->
                    <li class="layui-nav-item">
                        <a href="/article/categoryList/{{.Id}}" style="padding:0 13px;">{{$value.Name}}</a>
                    </li>
                {{end}}
            {{end}}
            <li class="layui-nav-item"><a href="javascript:;">教程</a>
                <dl class="layui-nav-child">
                    {{range .Classes}}
                    <dd><a href="/tutorial/classList/{{.Id}}">{{.Name}}</a></dd>
                    {{end}}
                </dl>
            </li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item"><a href="javascript:;" onclick="login()">登录</a></li>
            <li class="layui-nav-item"><a href="javascript:;" onclick="register()">注册</a></li>
        </ul>
    </div>
  
    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                <li class="layui-nav-item layui-bg-green" style="text-align:center;">
                    <div>{{.Class.Name}}</div>
                </li>
                {{$tutorials := .Tutorials}}
                {{range $value := $tutorials}}
                  <!-- class="layui-nav-itemed"为打开状态 -->
                <li class="layui-nav-item layui-nav-itemed">
                    {{if eq $value.Pid 0}}
                    <a class="" href="javascript:;">{{$value.Title}}</a>
                    {{end}}
                    {{range $v := $tutorials}}
                    {{if eq $value.Id $v.Pid}}
                    <dl class="layui-nav-child">
                        <dd><a href="/tutorial/detail/{{$v.Id}}">{{$v.Title}}</a></dd>
                    </dl>
                    {{end}}
                    {{end}}
                </li>
                {{end}}
            </ul>
        </div>
    </div>

    {{.LayoutContent}}

  
    <div class="layui-footer">
        <div>
            <span style="font-size: 14px;margin-right:10px;"><i class="layui-icon layui-icon-website" style="color: #1E9FFF;"></i><strong>友情链接</strong></span>
            <span class="layui-breadcrumb" lay-separator="|">
                <a href="https://bitshuo.com/" target="_blank">区块链中文社区</a>
                <a href="https://learnblockchain.cn/" target="_blank">深入浅出区块链</a>
                <a href="http://me.tryblockchain.org/" target="_blank">区块链技术博客</a>
                <a href="https://coolshell.cn/" target="_blank">酷壳</a>
                <a href="https://broqiang.com/" target="_blank">Bro Qiang</a>
                <a href="http://www.superdeng.cn/" target="_blank">新房博客</a>
            </span>
        </div>
    </div>
</div>
<script src="../../static/layui-2.4.3/layui.js"></script>
<script src="../../static/editor/jquery.min.js"></script>

<script>
//JavaScript代码区域
layui.use(['element', 'util'], function(){
    var element = layui.element
    ,util = layui.util;

    util.fixbar({
        css: {right: 650, bottom: 200},
        click: function(type){
            
        }
    });
}); 

function login() {
    layui.use('layer', function(){
        var layer = layui.layer;

        layer.open({
            type: 1, 
            area: ['600px', '300px'],
            title:'登录',
            content:`<form class="layui-form" action="/login" method="post" style="margin-top:20px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label">邮箱</label>
                            <div class="layui-input-block">
                            <input type="text" name="name" class="layui-input" required  lay-verify="required" placeholder="请输入邮箱" autocomplete="off" style="width:80%">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">密码</label>
                            <div class="layui-input-block">
                            <input type="password" name="password" class="layui-input" required lay-verify="required" placeholder="请输入密码" autocomplete="off" style="width:80%">
                            </div>
                        </div>
                        
                        <div class="layui-form-item">
                            <div class="layui-input-block">
                            <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
                            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                            </div>
                        </div>
                    </form>`
        });
    });
}
function register() {
    layui.use('layer', function(){
        var layer = layui.layer;

        layer.msg('nihao');
    });
}
</script>
</body>
</html>
