<div class="layui-body" style="padding: 20px;z-index:1000;">
        <form class="layui-form" action="/admin/class/addedit" method="POST"> 
            <div class="layui-form-item">
            <label class="layui-form-label">标题</label>
            <div class="layui-input-block">
                <input type="text" name="name" autocomplete="off" class="layui-input">
            </div>
            </div>
            <div class="layui-form-item">
            <label class="layui-form-label">排序</label>
            <div class="layui-input-block">
                <input type="text" name="sort" autocomplete="off" class="layui-input">
            </div>
            </div>
            <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">描述</label>
            <div id="editormd" class="layui-input-block">
                <textarea  class="layui-textarea" name="desc"></textarea>
            </div>
            </div>
            <div class="layui-form-item">
            <label class="layui-form-label">状态</label>
            <div class="layui-input-block">
                <input type="radio" name="status" value="0" title="公开">
                <input type="radio" name="status" value="1" title="私密">
            </div>
            </div>
            <div class="layui-form-item" >
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="*">保存</button>
    
            </div>
            </div>
        </form>
    </div>