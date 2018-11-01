<div class="layui-body" style="padding:20px;position:absolute;left:0;">
    <a href="/admin/tutorial/add" class="layui-btn">添加教程</a>
    <table class="layui-table">
      <colgroup>
        <col width="150">
        <col width="200">
        <col>
      </colgroup>
      <thead>
        <tr >
          <th style="width:10%;text-align: center">Id</th>
          <th style="width:20%;text-align: center">教程标题</th>
          <th style="width:20%;text-align: center">描述</th>
          <th style="width:10%;text-align: center">排序</th>
          <th style="width:20%;text-align: center">创建时间</th>
          <th style="width:20%;text-align: center">操作</th>
        </tr> 
      </thead>
      <tbody>
        {{range .Classes}}
        <tr>
          <td style="text-align: center">{{.Id}}</td>
          <td style="text-align: center">{{.Name}}</td>
          <td>{{substr .Desc 0 20}}...</td>
          <td style="text-align: center">{{.Sort}}</td>
          <td>{{.Created_at}}</td>
          <td style="text-align: center">
            <a href="/admin/tutorial/list/{{.Id}}" class="layui-btn layui-btn-sm">进入</a>
            <a href="/admin/tutorial/update/{{.Id}}" class="layui-btn layui-btn-sm layui-btn-normal">修改</a>
            <a href="/admin/tutorial/delete/{{.Id}}" class="layui-btn layui-btn-sm layui-btn-danger">删除</a>
        </td>
        </tr>
        {{end}}
      </tbody>
    </table>
    <!-- <div id="page" style="text-align: center;"></div> -->
  </div>
  