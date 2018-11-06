<div class="layui-body" style="padding: 20px;z-index:1000;">
        <form class="layui-form" action="/admin/category/updateedit/{{.Category.Id}}" method="POST"> 
            <div class="layui-form-item">
            <label class="layui-form-label">标题</label>
            <div class="layui-input-block">
                <input type="text" name="name" value="{{.Category.Name}}" autocomplete="off" class="layui-input">
            </div>
            </div>
            <div class="layui-form-item">
            <label class="layui-form-label">排序</label>
            <div class="layui-input-block">
                <input type="text" name="sort" value="{{.Category.Sort}}" autocomplete="off" class="layui-input">
            </div>
            </div>
            <div class="layui-form-item" >
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="*">保存</button>
    
            </div>
            </div>
        </form>
    </div>