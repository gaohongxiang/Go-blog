<div class="layui-bg-gray">
        <div class="layui-container container">
            <div class="layui-card">
                <div class="layui-card-header">
                    <div class="header-content">首页</div>
                </div>
                <div class="layui-card-body" >
                    <ul>
                        {{range .Articles}}
                            <li>
                                <a href="/article/detail/{{.Id}}"><p style="font-size:20px;margin-bottom:10px;"><strong>{{.Title}}</strong></p></a>
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
    
    <!-- <script src="../../static/layui-2.4.3/layui.js"></script>
    <script>
    //一般直接写在一个js文件中
    layui.use('laypage', function(){
        var laypage = layui.laypage;
    
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
    </script>  -->
    