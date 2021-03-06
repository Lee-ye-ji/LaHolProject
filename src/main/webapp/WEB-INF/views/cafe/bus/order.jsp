<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카페 주문 확인</title>
<link rel="stylesheet" href="${ contextPath }/resources/css/cafe/bus/order.css" type="text/css">
<link rel="stylesheet" href="${ contextPath }/resources/css/cafe/bus/sideMenu.css" type="text/css">

<style>
.lookup{
	background: #F3D798;
	color: black;
	border: 0;
}
.lookup:hover{
	background : #f1d1ac;
}
</style>
</head>
<body>

	<!-- 사업자 menubar -->
	<jsp:include page="/WEB-INF/views/common/menubar.jsp"/>
	<script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<!-- 카페 사이드 메뉴 바 -->
<div class="cafe-sidemenubar">
    <div id="side" class="col-cf">
    <ul class="side-menu">
        <li class="side-item" id="cafeHome"> 
                <div class="side-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                        <path   d="M18 12H19.9248C20.8933 12 21.2962 10.7609 20.513 10.1913L12.5881 4.42778C12.2375 4.17276 11.7625 4.17276 11.4118 4.42778L3.48699 10.1913C2.70374 10.7609 3.10668 12 4.07516 12H5.99998V19C5.99998 19.5523 6.44769 20 6.99998 20H9.99998V14H14V20H17C17.5523 20 18 19.5523 18 19V12Z"/>
                    </svg>
                </div>
                <p class="menu-text">HOME</p>
        </li>
        <li class="side-item active" id="cafeOrd">
                <div class="side-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                        <path  fill-rule="evenodd" d="M15 5H18C19.1046 5 20 5.89543 20 7V19C20 20.1046 19.1046 21 18 21H6C4.89543 21 4 20.1046 4 19V7C4 5.89543 4.89543 5 6 5H9C9 3.34315 10.3431 2 12 2C13.6569 2 15 3.34315 15 5ZM13 5C13 5.55228 12.5523 6 12 6C11.4477 6 11 5.55228 11 5C11 4.44772 11.4477 4 12 4C12.5523 4 13 4.44772 13 5ZM6 9C6 8.44772 6.44772 8 7 8H17C17.5523 8 18 8.44772 18 9C18 9.55228 17.5523 10 17 10H7C6.44772 10 6 9.55228 6 9ZM7 12C6.44772 12 6 12.4477 6 13C6 13.5523 6.44772 14 7 14H17C17.5523 14 18 13.5523 18 13C18 12.4477 17.5523 12 17 12H7ZM7 16C6.44772 16 6 16.4477 6 17C6 17.5523 6.44772 18 7 18H10C10.5523 18 11 17.5523 11 17C11 16.4477 10.5523 16 10 16H7Z" clip-rule="evenodd"/>
                    </svg>
                </div>
                <p class="menu-text">주문 내역</p>
        </li>
        <li class="side-item" id="cafeRes">
                <div class="side-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" data-name="Layer 1" viewBox="0 0 24 24">
                        <path d="M12,19a1,1,0,1,0-1-1A1,1,0,0,0,12,19Zm5,0a1,1,0,1,0-1-1A1,1,0,0,0,17,19Zm0-4a1,1,0,1,0-1-1A1,1,0,0,0,17,15Zm-5,0a1,1,0,1,0-1-1A1,1,0,0,0,12,15ZM19,3H18V2a1,1,0,0,0-2,0V3H8V2A1,1,0,0,0,6,2V3H5A3,3,0,0,0,2,6V20a3,3,0,0,0,3,3H19a3,3,0,0,0,3-3V6A3,3,0,0,0,19,3Zm1,17a1,1,0,0,1-1,1H5a1,1,0,0,1-1-1V11H20ZM20,9H4V6A1,1,0,0,1,5,5H6V6A1,1,0,0,0,8,6V5h8V6a1,1,0,0,0,2,0V5h1a1,1,0,0,1,1,1ZM7,15a1,1,0,1,0-1-1A1,1,0,0,0,7,15Zm0,4a1,1,0,1,0-1-1A1,1,0,0,0,7,19Z"/>
                    </svg>
                </div>
                <p class="menu-text">예약 내역</p>
        </li>
        <li class="side-item" id="cafeCon" onclick="location.href='${ contextPath }/cafe/biz/confirm'">
                <div class="side-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                        <path  fill-rule="evenodd" d="M12 22C17.5228 22 22 17.5228 22 12C22 6.47715 17.5228 2 12 2C6.47715 2 2 6.47715 2 12C2 17.5228 6.47715 22 12 22ZM15.5355 8.46447C15.9261 8.07394 16.5592 8.07394 16.9498 8.46447C17.3403 8.85499 17.3403 9.48816 16.9498 9.87868L11.2966 15.5318L11.2929 15.5355C11.1919 15.6365 11.0747 15.7114 10.9496 15.7602C10.7724 15.8292 10.5795 15.8459 10.3948 15.8101C10.2057 15.7735 10.0251 15.682 9.87868 15.5355L9.87489 15.5317L7.05028 12.7071C6.65975 12.3166 6.65975 11.6834 7.05028 11.2929C7.4408 10.9024 8.07397 10.9024 8.46449 11.2929L10.5858 13.4142L15.5355 8.46447Z" clip-rule="evenodd"/>
                    </svg>
                </div>
                <p class="menu-text">카페 확인</p>
        </li>
    </ul>
    </div>
    <%@include file="./sideMenu.jsp" %>
    
<div class="res-container" style="height: 120vh">
    <div id="od" class="col-cf">
        <div class="order_table">
            <h2>주문 내역</h2>
                <table class="table" id="orderTB">
                <thead>
                <tr>
                	<td colspan="8" style="text-align:center;">
                	<jsp:useBean id="now" class="java.util.Date" />
                	<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
            		<form action="${ contextPath }/cafe/biz/orderDate" method="get">
            		<c:choose>
            			<c:when test="${!empty check}">
            				<input type="date" id="date" name="checkDate" value="${ param.checkDate }" style="border:0; font-size:20px; color: #e3a259;">
            			</c:when>
            			<c:otherwise>
            				<input type="date" id="date" name="checkDate" value="${today}" style="border:0; font-size:20px; color: #e3a259;">
            			</c:otherwise>
            		</c:choose>
            		<button type="submit" class="lookup">조회</button>
            		</form>
            		</td>
                </tr>
               <tr> 
                   <td scope="col">#</td>
                   <td scope="col">주문명</td>
                   <td scope="col">고객이름</td>
                   <td scope="col">휴대폰 번호</td>
                   <td scope="col">예약</td>
                   <td scope="col">시간</td>
                   <!-- <td scope="col">상세보기</td> -->
                   <td scope="col">주문상태</td>
               </tr>
               </thead>
               <tbody id="tbody">
               <c:choose>
               	 <c:when test="${!empty cafeOrderlist}">
               	 	<c:forEach var="ord" items="${ cafeOrderlist }">
                       <tr class="orderTr">
                       <td>${ ord.caResNo }</td>
                       <td>${ ord.cfName }</td>
                       <td>${ ord.name }</td>
                       <td>${ ord.phone }</td>
                       <td>${ ord.caResType }</td>
                       <c:set var="hereTogo" value="${ ord.caResType }" />
                       <c:if test="${ hereTogo eq '매장' }">
				        	<td>${ ord.caHereTime }</td>
				        </c:if>
				        <c:if test="${ hereTogo eq '포장' }">
				        	<td>${ ord.caGoTime }</td>
				        </c:if> 
				       
                       <%-- <td class="mod trigger" onclick="coffeeInfoOpen('${ ord.caResNo }')">
                           <i class="fa fa-arrow-right" aria-hidden="true"></i>
                       		<script>
						       // Modal
						       function coffeeInfoOpen(caResNo){
						    	    console.log(caResNo);
						    	    $.ajax({
						    	    	url:"${ contextPath }/cafe/biz/order/beverage",
					    				type : "post",
					    				data : { caResNo : caResNo },
					    				success: function(data){
					    					 $('.modal-wrapper').toggleClass('open');
					    					 var divContainer = $(".row-cols-1");
					    					 for(var i in data) {
					    						 var divA = $("<div class='col'>");
					    						 var divB = $("<div class='card mb-4'>");
					    						 var divC = $("<div class='row g-0'>");
					    						 var divD = $("<div class='col-md-4' id='cardImg'>");
					    						 var img = $("<img src='${contextPath}/resources/nuploadFiles/cafeImg/" + data[i].cfIchname + "' alt='음료주문사진'>");
					    						 
					    						 var divE = $("<div class='col-md-8'>");
					    						 var divF = $("<div class='card-body'>");
					    						 
					    						 var table = $("<table class='card-table'>");
					    						 var thead = $("<thead>");
					    						 var trA = $("<tr>");
					    						 var tdA = $("<td colspan='2'>");
					    						 var h5 = $("<h5 class='blackColor'>");
					    						 h5.text(data[i].cfName);
					    						 
					    						 tdA.append(h5);
					    						 trA.append(tdA);
					    						 thead.append(trA);
					    						 table.append(thead);
					    						 
					    						 var tbody = $("<tbody>");
					    						 var trB = $("<tr>");
					    						 var tdB = $("<td class='blackColor'>");
					    						 tdB.text("수량");
					    						 var tdB1 = $("<td class='redCard'>");
					    						 tdB1.text(data[i].cfResAmount);
					    						 
					    						 trB.append(tdB);
					    						 trB.append(tdB1);
					    						 tbody.append(trB);
					    						 
					    						 var trC = $("<tr>");
					    						 var tdC = $("<td class='blackColor'>");
					    						 tdC.text("종류");
					    						 var tdC1 = $("<td class='redCard'>");
					    						 tdC1.text(data[i].cfResHI);
					    						 
					    						 trC.append(tdC);
					    						 trC.append(tdC1);
					    						 tbody.append(trC);
					    						 
					    						 var trD = $("<tr>");
					    						 var tdD = $("<td class='blackColor'>");
					    						 tdD.text("용량");
					    						 var tdD1 = $("<td class='redCard'>");
					    						 tdD1.text(data[i].cfResCap);
					    						 
					    						 trD.append(tdD);
					    						 trD.append(tdD1);
					    						 tbody.append(trD);
					    						 
					    						 var trE = $("<tr>");
					    						 var tdE = $("<td class='blackColor'>");
					    						 tdE.text("컵");
					    						 var tdE1 = $("<td class='redCard'>");
					    						 tdE1.text(data[i].cfResCup);
					    						 
					    						 trE.append(tdE);
					    						 trE.append(tdE1);
					    						 tbody.append(trE);
					    						 
					    						 table.append(tbody);
					    						 
					    						 divF.append(table);
					    						 divE.append(divF);
					    						 divD.append(img);
					    						 
					    						 divC.append(divD);
					    						 divC.append(divE);
					    						 
					    						 divB.append(divC);
					    						 divA.append(divB);
					    						 
					    						 divContainer.append(divA);
					    						 
					    					 }
					    				},
					    				error : function(e){
					    					console.log(e);
					    				}
						    	    });
						       		
						       	}
					   		</script>
					   		<!-- Modal -->
<div class="modal-wrapper">
 <div class="modalCafe">
 <div class="headModal">
     <h5 class="headerM">음료 주문 내역</h5>
     <div class="mod-close trigger headerM" >
         <i class="fa fa-times" id="closeIcon" aria-hidden="true"></i>
     </div>
 </div>

    
	
</div>
   </div>
                       </td> --%>
                       
                       <td>
                           <div class="btn-group" role="group">
                               <button disabled style="color: black;" class="btnOrd">
                                   <li id="statusCf">${ ord.caResing }</li>
                               </button>
                               <button id="btnGroupDrop" type="button" onclick="coffeeStatus('${ ord.caResNo }')" data-bs-toggle="dropdown" class="btnOrd" >
                                   <i class="fa fa-caret-down" aria-hidden="true"></i>
                               </button>
                               <ul class="dropdown-menu" aria-labelledby="btnGroupDrop">
                                   <li class="btnOrd check" id="cofBef">
                                          	 제조 전
                                   </li>
                                   <li class="btnOrd check" id="cofIng">
                                           	제조 중
                                   </li>
                                   <li class="btnOrd check" id="cofFin"> 
                                           	제조 완료
                                   </li>
                               </ul>
                               <c:set var="caResNo" value="${ ord.caResNo }" />
                           </div>
                           <script>
                           function coffeeStatus(caResNo){
                        	   $(".check").click (function(){
                                   var coffeeStatus = ($(this).text()).trim();
                                   console.log(caResNo);
                                   Swal.fire({
                                   	  title: coffeeStatus,
                                   	  text : "(으)로 바꾸시겠습니까?",
                                   	  icon: 'question',
                                   	  showCancelButton: true,
                                  	  confirmButtonColor: '#4B654A',
                                   	  cancelButtonColor: '#810B0B',
                                   	  confirmButtonText: 'Yes'
                                   	}).then((result) => {
                                   	  if (result.isConfirmed) {
                                   	    Swal.fire({
                                   	       title: coffeeStatus,
                                   	       text : '으로 변경되었습니다!',
                                   	       icon: 'success',
                                   	      confirmButtonColor: '#4B654A'
                                   	  })
                                   	    $.ajax({
                   			       			url:"${ contextPath }/cafe/biz/ing",
                   			        		type : "post",
                   			        		data : {
                   			        			caResing : coffeeStatus,
                   			        			caResNo : caResNo
                   			        		},
                   			        		success : function(data){
                   			        			$("#statusCf").text(coffeeStatus);
                   			        		},
                   			        		error : function(e){
                   								console.log(e);
                   							}
                   			        		
                   			       		});
                                   	  }
                                   	})

                                   
                               });
                           }
                           
                           </script>
                       </td>
                       </tr>
               </c:forEach>
               	 </c:when>
               	 <c:otherwise>
               	 <tr>
               	 	<td colspan="8" style='text-align:center;'>주문 된 내역이 존재하지 않습니다.</td>
               	 </tr>
               	 </c:otherwise>
               </c:choose>
               
           </tbody>
           
       </table>
       </div>
       <c:choose>
      <c:when test="${!empty check}">
		<!-- 페이징 바 -->
 		<div aria-label="Page navigation" class="cafe-order-page">
     <ul class="pagination">
         <c:if test="${ pi.currentPage > 1 }">
         <li class="page-item">
         <c:url var="before" value="/cafe/biz/orderDate?checkDate=${ param.checkDate }">
        	<c:param name="page" value="${ pi.currentPage -1 }" />
     	 </c:url>
         <a class="page-link" id="page-color" href="${ before }"   aria-label="Previous">
             <span aria-hidden="true">&laquo;</span>
         </a>
         </li>
         </c:if>
		<!-- 페이징 숫자 -->
        <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
    		<c:if test="${ p eq pi.currentPage }">
       		<li class="page-item" id="page-hover"><a class="page-link" id="page-color">${ p }</a></li>
    		</c:if>	
    		<c:if test="${ p ne pi.currentPage }">
    		<c:url var="pagination" value="/cafe/biz/orderDate?checkDate=${ param.checkDate }">
          	<c:param name="page" value="${ p }"/>
       	</c:url>
       	 <li class="page-item"><a class="page-link" id="page-color" href="${ pagination }">${ p }</a></li>
    		 </c:if>
 			</c:forEach>
    	 <c:if test="${ pi.currentPage < pi.maxPage }">
    	 <c:url var="after" value="/cafe/biz/orderDate?checkDate=${ param.checkDate }">
          <c:param name="page" value="${ pi.currentPage + 1 }" />
     </c:url>
     <li class="page-item">
         <a class="page-link" id="page-color"  href="${ after }"  aria-label="Next">
             <span aria-hidden="true">&raquo;</span>
         </a>
     </li>
      </c:if>   
    </ul>
 </div>
</c:when>
<c:otherwise>
			<!-- 페이징 바 -->
 		<div aria-label="Page navigation" class="cafe-order-page">
     <ul class="pagination">
         <c:if test="${ pi.currentPage > 1 }">
         <li class="page-item">
         <c:url var="before" value="/cafe/biz/orderDate?checkDate=${ param.checkDate }">
        	<c:param name="page" value="${ pi.currentPage -1 }" />
     	 </c:url>
         <a class="page-link" id="page-color" href="${ before }"   aria-label="Previous">
             <span aria-hidden="true">&laquo;</span>
         </a>
         </li>
         </c:if>
		<!-- 페이징 숫자 -->
        <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
    		<c:if test="${ p eq pi.currentPage }">
       		<li class="page-item" id="page-hover"><a class="page-link" id="page-color">${ p }</a></li>
    		</c:if>	
    		<c:if test="${ p ne pi.currentPage }">
    		<c:url var="pagination" value="/cafe/biz/order">
          	<c:param name="page" value="${ p }"/>
       	</c:url>
       	 <li class="page-item"><a class="page-link" id="page-color" href="${ pagination }">${ p }</a></li>
    		 </c:if>
 			</c:forEach>
    	 <c:if test="${ pi.currentPage < pi.maxPage }">
    	 <c:url var="after" value="/cafe/biz/order">
          <c:param name="page" value="${ pi.currentPage + 1 }" />
     </c:url>
     <li class="page-item">
         <a class="page-link" id="page-color"  href="${ after }"  aria-label="Next">
             <span aria-hidden="true">&raquo;</span>
         </a>
     </li>
      </c:if>   
    </ul>
 </div>
</c:otherwise>
</c:choose>
 	
	
<!-- 	<script type="text/javascript">
   $( document ).ready(function() {	
       $('.trigger').on('click', function() {
           $('.modal-wrapper').toggleClass('open');
           return false;
       });
   </script> -->

        </div>
    </div>
    </div>
    <!-- footer -->
	<jsp:include page="/WEB-INF/views/common/footer2.jsp"/>
</body>
</html>