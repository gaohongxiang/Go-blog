<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>layout 后台大布局</title>
  <link rel="stylesheet" href="../../../static/layui-2.4.3/css/layui.css">
  <link rel="stylesheet" href="../../../static/editor/css/editormd.min.css" />
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <div class="layui-header">
    <div class="layui-logo">layui 后台布局</div>
    <!-- 头部区域（可配合layui已有的水平导航） -->
    <ul class="layui-nav layui-layout-left">
      <li class="layui-nav-item"><a href="">控制台</a></li>
      <li class="layui-nav-item"><a href="/admin/article/list">文章管理</a></li>
      <li class="layui-nav-item"><a href="/admin/tutorial/classes">教程管理</a></li>
      <li class="layui-nav-item"><a href="">用户</a></li>
      <li class="layui-nav-item"><a href="/" target="_blank">预览前台</a></li>
    </ul>
    <ul class="layui-nav layui-layout-right">
      <li class="layui-nav-item">
        <a href="javascript:;">
          <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
          贤心
        </a>
        <dl class="layui-nav-child">
          <dd><a href="">基本资料</a></dd>
          <dd><a href="">安全设置</a></dd>
        </dl>
      </li>
      <li class="layui-nav-item"><a href="">退了</a></li>
    </ul>
  </div>
  
  <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                <li class="layui-nav-item layui-bg-green" style="text-align:center;">
                    <div>{{.Class.Name}} <i class="layui-icon layui-icon-add-1" style="margin-left:20px; color: #1E9FFF;" onclick="AddChapter()"></i></div>
                </li>
                {{$tutorials := .Tutorials}}
                {{range $value := $tutorials}}
                  <!-- class="layui-nav-itemed"为打开状态 -->
                <li class="layui-nav-item layui-nav-itemed">
                    {{if eq $value.Pid 0}}
                    <div id="nav">
                        <span>{{$value.Title}}</span> 
                        <span>{{$value.Sort}}</span> 
                        <a href="/admin/tutorial/add/{{$value.Id}}">
                            <i class="layui-icon layui-icon-add-1" style="margin-left:10px;color: #1E9FFF;"></i>
                        </a>
                        <i class="layui-icon layui-icon-edit" style="margin-left:5px;color: #FF5722;" onclick="edit(`{{$value.Id}}`,`{{$value.Title}}`,`{{$value.Sort}}`)"></i>
                    </div>
                    <style> #nav{padding-left:10px;} #nav a{display:inline;padding:0;z-index:100;} #nav .layui-nav-more{display: none !important;} </style>
                    <a class="" href="javascript:;" style="width:20%;position: absolute;top:0;right:0;padding:0;"></a>
                    {{end}}
                    {{range $v := $tutorials}}
                    {{if eq $value.Id $v.Pid}}
                    <dl class="layui-nav-child">
                        <dd><a href="/admin/tutorial/detail/{{$v.Id}}">{{$v.Title}}<span style="position: absolute;top: 0;right: 10px;">{{$v.Sort}}</span></a></dd>
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
    <!-- 底部固定区域 -->
    © layui.com - 底部固定区域
  </div>
</div>
<script src="../../../static/layui-2.4.3/layui.js"></script>
<script src="../../../static/editor/jquery.min.js"></script>
<script src="../../../static/editor/editormd.min.js"></script>
<script>
//JavaScript代码区域
layui.use(['element', 'laypage', 'form'], function(){
    var element = layui.element
    ,laypage = layui.laypage
    ,form = layui.form;
    $(function() {
        var editor = editormd("editormd", {
            width: "100%",
            height: 640,
            emoji: true,
            path: '../../../static/editor/lib/' 
        });
    });
    laypage.render({
        elem: 'page', //注意，这里的 page 是 ID，不用加 # 号
        count: "{{.totals}}", //数据总数，从服务端得到
        curr: function(){
                var page = "{{.currentPage}}"; // 当前页(后台获取到的)
                return page ? page : 1; // 返回当前页码值
            }(),
        jump: function(obj, first){
            //首次不执行
            if(!first){
                location.href = '?page='+obj.curr;
            }
        }
    });
});
function AddChapter() {
    layui.use('layer', function(){
        var layer = layui.layer;
        layer.open({
            type: 1, 
            area: ['600px', '300px'],
            title:'添加章节',
            content:`<form class="layui-form" action="/admin/tutorial/addchapter" method="post" style="margin-top:20px;">
                        <input type="hidden" name="class" value="{{.Class.Id}}" class="layui-input" required  lay-verify="required"  autocomplete="off" style="width:80%">
                        <div class="layui-form-item">
                            <label class="layui-form-label">标题</label>
                            <div class="layui-input-block">
                            <input type="text" name="title" class="layui-input" required  lay-verify="required" placeholder="请输入标题" autocomplete="off" style="width:80%">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">排序</label>
                            <div class="layui-input-block">
                            <input type="text" name="sort" class="layui-input" required lay-verify="required" placeholder="请输入序号" autocomplete="off" style="width:80%">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-input-block">
                            <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
                            </div>
                        </div>
                    </form>`
        });
    });
}  
function edit(id,title,sort) {
    console.log(id);
    layui.use('layer', function(){
        var layer = layui.layer;
        layer.open({
            type: 1, 
            area: ['600px', '300px'],
            title:'修改章节',
            content:`<form id="form" class="layui-form"  method="post" style="margin-top:20px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label">标题</label>
                            <div class="layui-input-block">
                            <input type="text" name="title" class="layui-input" id="title" required  lay-verify="required" placeholder="请输入标题" autocomplete="off" style="width:80%">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">排序</label>
                            <div class="layui-input-block">
                            <input type="text" name="sort" class="layui-input" id="sort" required lay-verify="required" placeholder="请输入序号" autocomplete="off" style="width:80%">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-input-block">
                            <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
                            </div>
                        </div>
                    </form>`
        });
        
        var url = `/admin/tutorial/updateeditchapter/${id}`;
        url = url.replace(/\s+/g,"");//明明没有空格，但浏览器解析的时候莫名的在id前出现了%20，说明有空格。这里去除所有的空格
        $("#form").attr("action",url);
        title = title.replace(/\"/g,"");//去除双引号
        $("#title").val(title);
        $("#sort").val(sort);
    });
}  
</script>
</body>
</html>
