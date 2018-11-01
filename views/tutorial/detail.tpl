<div class="layui-body">
    <div class="layui-container container">
        <div class="layui-card">
            <div class="layui-card-body" style="padding-top:30px;">
                <div>
                    <p style="font-size:28px;margin-bottom:10px;"><strong style="color:#FF5722">{{.Detail.Title}}</strong></p>
                </div>
                <div id="content" style="padding:20px 0;font-size:16px;overflow-y:hidden;">
                    <textarea style="display: none;">{{.Detail.Content}}</textarea>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="../../static/layui-2.4.3/layui.js"></script>
<script src="../../static/editor/jquery.min.js"></script>
<script src="../../static/editor/lib/marked.min.js"></script>
<script src="../../static/editor/lib/prettify.min.js"></script>
<script src="../../static/editor/lib/raphael.min.js"></script>
<script src="../../static/editor/lib/underscore.min.js"></script>
<script src="../../static/editor/lib/sequence-diagram.min.js"></script>
<script src="../../static/editor/lib/flowchart.min.js"></script>
<script src="../../static/editor/lib/jquery.flowchart.min.js"></script>
<script src="../../static/editor/editormd.js"></script>
<script>
    editormd.markdownToHTML("content", {//注意：content是上面DIV的id
        htmlDecode : "style,script,iframe", //可以过滤标签解码
        emoji : true,
        taskList : true,
        tex : true,             // 默认不解析
        flowChart : true,       // 默认不解析
        sequenceDiagram : true, // 默认不解析
        codeFold : true
    });
</script>


    