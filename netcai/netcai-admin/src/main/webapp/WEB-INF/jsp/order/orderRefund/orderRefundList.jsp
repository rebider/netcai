<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pv" uri="/pageTaglib"%> 
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%> 
<!DOCTYPE html>
<html>
<head>
  <!-- 引入公共部分jsp文件 -->
  <meta name="decorator" content="default"/>
  <style type="text/css">
    .layui-form-label{
      width:100px;
    }
    .layui-input-block{
      width:auto;
      height:auto;
    }
    table th{
      background:#ffffff;
    }
	table tr:nth-child(odd){
	  background:#F0F0F0;
	}
	.col-sm-2 {
	  width: 10%;
	}
	.form-footer{
	  margin-right:800px;
	  float:right;
	}
	.btn-select{
	  margin-right:10px;
	}
  </style>
</head>
<body>
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>订单差价信息管理</h1>
    </section>
    <!-- Main content -->
    <shiro:hasPermission name="orderRefund:query">
	    <section class="content">
	      <div class="row">
	        <div class="col-xs-12">
	          <div class="box">
	            <div class="box-header">
	              <h3 class="box-title">订单差价信息</h3>
	            </div><div class="box box-info">
		           <!-- form start -->
		           <form  id="form_submit" class="form-horizontal" action="<%=request.getContextPath()%>/admin/orderRefund/list" method="post">
		             <input type="hidden" name="pageNum" id="pageNum" value="${paginator.currentPage}">
	                 <input type="hidden" name="pageSize" id="pageSize" value="${paginator.pageRecord}">
		             <div class="box-body">
		               <div class="form-group">
		                 <label for="buyerName" class="col-sm-2 control-label">餐馆名称：</label>
		                 <div class="col-xs-2">
		                   <input type="text" class="form-control" id="buyerName" name="buyerName" placeholder="请输入餐馆名称" value="${orderRefund.buyerName}">
		                 </div>
		                 <label for="deliveryName" class="col-sm-2 control-label">店铺名称：</label>
		                 <div class="col-xs-2">
		                   <input type="text" class="form-control" id="sellerName" name="sellerName" placeholder="请输入店铺名称" value="${orderRefund.sellerName}">
		                 </div>
		                 <label for="saleId" class="col-sm-2 control-label">销售人员：</label>
		                 <div class="col-xs-2">
		                     <select id="saleId" name="saleId" class="form-control" >
							     <option value="" >全部</option>
							     <c:forEach items="${sales}" var="r">
							         <option value="${r.id }" <c:if test="${r.id==orderRefund.saleId }">selected</c:if>>${r.realName }</option>
							     </c:forEach>
						     </select>
		                 </div>
		               </div>
		               <div class="form-group">
		                 <label for="reason" class="col-sm-2 control-label">原因：</label>
		                 <div class="col-xs-2">
		                   <input type="text" class="form-control" id="reason" name="reason" placeholder="请输入餐馆名称" value="${orderRefund.reason}">
		                 </div>
		                 <label for="createTime" class="col-sm-2 control-label">选择日期：</label>
					     <div class="col-xs-2">
						   <input type="date" class="form-control" id="createTime" name="time" placeholder="请输日期" value="<fmt:formatDate value="${orderRefund.createTime }" pattern="yyyy-MM-dd"/>">
					     </div>
		               </div>
			           <div class="form-footer" >
			             <button type="submit" class="btn btn-info pull-left btn-select">查询</button>
			             <button type="reset" class="btn btn-info pull-left" onclick="clearSearch()">重置</button>
			           </div>
		           </form>
		           <!-- form end -->
		        </div>
	            <!-- /.box-header -->
	            <div class="layui-form" >
	              <div class="site-demo-button" >
				     <button type="button" class="layui-btn layui-btn-small layui-btn-primary " onclick="exportExcel()"><i class="fa fa-fw fa-download"></i> 导出</button>
				  </div>
	              <table class="layui-table" lay-skin="row">
	                <thead>
		              <tr>
		                <th>订单号</th>
		                <th>餐馆名称</th>
		                <th>卖家店铺名称</th>
		                <th>买家补扣款金额</th>
		                <th>卖家补扣款金额</th>
		                <th>原因</th>
		                <th>备注说明</th>
		                <th>创建时间</th>
		              </tr>
	                </thead>
	                <tbody>
		               <c:forEach items="${paginator.object}" var="r"> 
			   			 <tr>
					       <td>${r.orderNumber}</td>
					       <td>${r.buyerName}</td>
					       <td>${r.sellerName}</td>
					       <td>${r.buyerMoney}</td>
					       <td>${r.sellerMoney}</td>
					       <td>${r.reason}</td>
					       <td>${r.remark}</td>
					       <td><fmt:formatDate value="${r.createTime }" pattern="yyyy-MM-dd"/></td>
			             </tr>
					   </c:forEach>
	                </tbody>
	              </table>
	            </div>
	            <div class="box-footer clearfix">
	              <ul class="pagination pagination-sm no-margin pull-left">
	              	 <pv:showPaging pageVo="${paginator}" />
	              </ul>
	            </div>
	          </div>
	        </div>
	      </div>
	    </section>
    </shiro:hasPermission>
  </div>
<script src="/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="/bootstrap/js/bootstrap.min.js"></script>
<script src="/js/raphael-min.js"></script>
<script src="/plugins/sparkline/jquery.sparkline.min.js"></script>
<script src="/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<script src="/plugins/knob/jquery.knob.js"></script>
<script src="/js/moment.min.js"></script>
<script src="/plugins/daterangepicker/daterangepicker.js"></script>
<script src="/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
<script src="/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<script src="/plugins/fastclick/fastclick.js"></script>
<script src="/dist/js/app.min.js"></script>
<script src="/dist/js/demo.js"></script>
<script src="/js/jquery-ui.min.js"></script>
<script src="/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
//导出
function exportExcel(){
	window.location.href="/admin/orderRefund/export";
}
//重置
function clearSearch(){
	window.location.href="<%=request.getContextPath()%>/admin/orderRefund/list";
}

//选择页码
function onSelectPage(currentPage,pageSize){  
	$('#pageNum').val(currentPage);
	$('#pageSize').val(pageSize);
	$('#form_submit').submit();
}   
</script>
</body>
</html>