<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>layout 后台大布局</title>
  <link rel="shortcut icon" href="../../../static/favicon.ico" type="image/x-icon" />
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
      <li class="layui-nav-item"><a href="">用户</a></li>
      <li class="layui-nav-item"><a href="/admin/article/list">文章管理</a></li>
      <li class="layui-nav-item"><a href="/admin/draft/list">草稿管理</a></li>
      <li class="layui-nav-item"><a href="/admin/category/list">类别管理</a></li>
      <li class="layui-nav-item"><a href="/admin/class/list">教程管理</a></li>  
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

  {{.LayoutContent}}

  <div class="layui-footer" style="position:fixed;left:0;">
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
</script>
</body>
</html>
