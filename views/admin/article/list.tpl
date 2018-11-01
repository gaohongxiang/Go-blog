<div class="layui-body" style="padding:20px;position:absolute;left:0;">
  <a href="/admin/article/add" class="layui-btn">添加文章</a>
  <table class="layui-table">
    <colgroup>
      <col width="150">
      <col width="200">
      <col>
    </colgroup>
    <thead>
      <tr >
        <th style="width:5%;text-align: center">Id</th>
        <th style="width:15%;text-align: center">所属分类</th>
        <th style="width:20%;text-align: center">文章标题</th>
        <th style="width:20%;text-align: center">文章内容</th>
        <th style="width:20%;text-align: center">创建时间</th>
        <th style="width:20%;text-align: center">操作</th>
      </tr> 
    </thead>
    <tbody>
      {{range .Articles}}
      <tr>
        <td style="text-align: center">{{.Id}}</td>
        <td style="text-align: center">{{.Category.Name}}</td>
        <td>{{.Title}}</td>
        <td>{{substr .Content 0 20}}...</td>
        <td>{{.Created_at}}</td>
        <td style="text-align: center"><a href="/admin/article/update/{{.Id}}" class="layui-btn layui-btn-sm layui-btn-normal">修改</a><a href="/admin/article/delete/{{.Id}}" class="layui-btn layui-btn-sm layui-btn-danger">删除</a></td>
      </tr>
      {{end}}
    </tbody>
  </table>
  <div id="page" style="text-align: center;"></div>
</div>
