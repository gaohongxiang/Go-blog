<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="gaohongxiang 博客">
    <meta name="author" content="gaohongxiang<ghongxiang@outlook.com>">
    <title>个人博客</title>
    <link rel="shortcut icon" href="../../static/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="../../static/layui-2.4.3/css/layui.css" />
    <link rel="stylesheet" href="../../static/editor/css/editormd.min.css" />
    <link rel="stylesheet" href="../../static/css/layout.css">
</head>
<body>
    <!-- ##################################头部############################################ -->
    <div class="layui-bg-black header" style="position:fixed;top:0;width:100%;z-index: 1000">
        <div class="layui-container">
            <div class="layui-row">
                <div class="layui-nav layui-col-xs1 layui-col-sm1 layui-col-md1" style="height:60px;line-height:60px;">
                    <i class="layui-icon layui-icon-release" style="font-size: 45px; color: #1E9FFF;"></i>
                </div>
                <ul class="layui-nav layui-col-xs7 layui-col-sm7 layui-col-md7" lay-filter="" style="padding:0 10px;">
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
                <div class="layui-nav layui-col-xs2 layui-col-sm2 layui-col-md2" style="position: relative;line-height:60px;">
                    <form action="/article/search">
                        <input type="text" name="keywords" class="layui-input layui-bg-cyan" style="display: inline-block;vertical-align:middle;height:26px;padding-left:25px;">
                        <button type="submit" style="position:absolute;top:22px;left:23px;background-color: transparent;border: none;"><i class="layui-icon layui-icon-search" style="font-size:18px;color: #1E9FFF;"></i></button>
                    </form>
                </div>  
                <ul class="layui-nav layui-col-xs2 layui-col-sm2 layui-col-md2" lay-filter="">
                    <li class="layui-nav-item"><a href="javascript:;" onclick="login()">登录</a></li>
                    <li class="layui-nav-item"><a href="javascript:;" onclick="register()">注册</a></li>
                </ul>
            </div>
            
        </div>
    </div>
    <div style="height:60px"></div>
    
    

    <!-- ##################################内容部分############################################ -->
    <!-- 框架会将具体的结构和数据解析到此 -->
    {{.LayoutContent}}
    

    <!-- ####################################尾部############################################## -->
    <div class="layui-bg-gray footer" style="height:100px;padding-top:50px;text-align: center;">
        <div class="layui-container">
            <span style="font-size: 14px;margin-right:10px;"><i class="layui-icon layui-icon-website" style="color: #1E9FFF;"></i><strong>友情链接</strong></span>
            <span class="layui-breadcrumb" lay-separator="|">
                <a href="https://leetcode-cn.com/" target="_blank">leetCode</a>
                <a href="https://www.golangtc.com/" target="_blank">Golang 中国</a>
                <a href="https://gocn.vip/" target="_blank">Go中国技术社区</a> 
                <a href="https://www.infoq.cn/" target="_blank">InfoQ</a>
                <a href="https://bitshuo.com/" target="_blank">区块链中文社区</a>
                <a href="https://learnblockchain.cn/" target="_blank">深入浅出区块链</a>
                <a href="http://me.tryblockchain.org/" target="_blank">区块链技术博客</a>
                <a href="https://coolshell.cn/" target="_blank">酷壳</a>
                <a href="https://broqiang.com/" target="_blank">Bro Qiang</a>
                <a href="http://www.superdeng.cn/" target="_blank">新房博客</a>
            </span>
        </div>
        <div class="layui-container" style="text-align: center;margin-top:20px;">
            <span class="layui-breadcrumb"><i class="layui-icon layui-icon-auz" style="color: #1E9FFF;"></i>  <small> 京ICP备18040032号</small></span>
        </div>
    </div> 

<script src="../../static/layui-2.4.3/layui.js"></script>
<script>
    // 全局通用模块
    // 注意：导航 依赖 element 模块，否则无法进行功能性操作，如二级菜单的弹出
    layui.use(['element','util','laypage'], function(){
        var element = layui.element
        ,util = layui.util
        ,laypage = layui.laypage;

        util.fixbar({
            css: {right: 650, bottom: 200},
            click: function(type){
                
            }
        });
        
        laypage.render({
            elem: 'page', //注意，这里的 page 是 ID，不用加 # 号
            count: "{{.totals}}", //数据总数，从服务端得到
            curr: function(){
                    var page = "{{.currentPage}}"; // 当前页(后台获取到的)
                    return page ? page : 1; // 返回当前页码值
                }(),
            jump: function(obj, first){
                //obj包含了当前分页的所有参数，比如：
                // console.log(obj.curr); //得到当前页，以便向服务端请求对应页的数据。
                // console.log(obj.limit); //得到每页显示的条数
                
                //首次不执行
                if(!first){
                    location.href = '?page='+obj.curr;
                }
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
    
    

    
<!-- <script>
    //Demo
    layui.use('form', function(){
    var form = layui.form;
    
    //监听提交
    form.on('submit(formDemo)', function(data){
        layer.msg(JSON.stringify(data.field));
        return false;
    });
    });
</script> -->