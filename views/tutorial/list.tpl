<div class="layui-bg-gray">
    <div class="layui-container container">
        <div class="layui-card">
            <div class="layui-card-header">
                <div class="header-content">教程 / {{.Class.Name}}</div>
            </div>
            <div class="layui-card-body" >
                <ul>
                    {{range .Tutorials}}
                        <li>
                            <a href="/tutorial/detail/{{.Id}}"><p style="font-size:20px;margin-bottom:10px;"><strong>{{.Title}}</strong></p></a>
                            <p style="font-size:12px;margin-bottom:10px;"><i>{{.Created_at}}</i></p>
                            <div>{{substr .Content 0 300}}</div>
                        </li>
                        <hr class="layui-bg-gray">
                    {{end}}
                </ul>
            </div>
            <div id="page" style="text-align: center;"></div>
        </div>
    </div>
</div>
