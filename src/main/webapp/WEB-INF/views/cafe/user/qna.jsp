<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q & A</title>
</head>
<body>
<div class="qa-content">
	<c:if test="${!empty sessionScope.loginUser.id }">
     <div class="writeBtn">
       <button id="wBtn" data-bs-toggle="modal" data-bs-target="#askModal">Write</button>
     </div>
    </c:if>
   
     <div class="accordionMenu">
      <c:forEach var="qa" items="${ caQnA }">
       <div class="accordion accordion-flush" id="accordionFlushExample">
         <div class="accordion-item">
           <h2 class="accordion-header"  id="heading${ qa.qaNo }">
             <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${ qa.qaNo }" aria-expanded="false" aria-controls="collapse${ qa.qaNo }">
               <table class="qaTable">
                 <tr>
                   <td style="width: 10vw">${ qa.qaNo }</td>
                   <td style="width: 10vw">${ qa.qaStatus }</td>
                   <td style="width: 20vw">${ qa.qaTitle }</td>
                   <td style="width: 10vw">${ qa.userId }</td>
                   <fmt:formatDate var="date" value="${ qa.qaDate }" pattern="yyyy-MM-dd"/>
                   <td style="width: 10vw">${ date }</td>
                 </tr>
               </table>
             </button>
           </h2>
           <div id="collapse${ qa.qaNo }" class="accordion-collapse collapse" aria-labelledby="heading${ qa.qaNo }" data-bs-parent="#accordionFlushExample">
             <div class="accordion-body">
               <div class="qaAnswer">
                 <div>
                   <h1 style="color: #810B0B;">Q</h1>
                   	${ qa.qaTitle }
                 </div>
                 <hr>
                 <div>
                 <c:choose>
                 <c:when test="${!empty qa.qaAnswer}">
                 	<p>
                     <h1 style="color: #4B654A;">A</h1>
                    	${ qa.qaAnswer }
                   </p>
                 </c:when>
                 <c:otherwise>
                 	<p>
                     <h1 style="color: #4B654A;">A</h1>
                    	???????????? ?????? ???????????? ?????? ????????? ?????? ?????? ???????????????.
                    	????????? ??????????????????~!!!
                   </p>
                 </c:otherwise>
                 </c:choose>
                   
                 </div>
               </div>
             </div>
           </div>
         </div>
        
       </div>
        </c:forEach>
   </div>
   
   <!-- ?????? ?????? -->
 <div class="modal fade" id="askModal" tabindex="-1" aria-labelledby="askModalLabel" aria-hidden="true">
	<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header" style="background-color: #F3D798;">
		<h5 class="modal-title" id="askModalLabel" style="color: white;">
			<img src="${ contextPath }/resources/img/common/logo-green.png" style="width : 30px; height: 30px;">
			????????????
		</h5>
		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		</div>
		<div class="modal-body">
		<h5  style="text-align: center; padding: 5vh;"> '${ cafeInfo.caName }'<br>
													 ????????? ????????? ?????? ????????? ???????????????! </h5>
			<form action="${ contextPath }/cafe/ask" method="post">
              	<input type="hidden" name="caCode" value="${ cafeInfo.caCode }">
              	<input type="hidden" name="idUser" value="${ sessionScope.loginUser.id }">
			<table style="width: 100%;">
				<tr>			
					<td>????????????</td>
				</tr>
				<tr>
					<td colspan="2">
						<textarea style="width: 100%; height:20vh; resize:none;" name="qaTitle"></textarea>
					</td>
				</tr>
			</table>
			<br>
			<p class="alert-text" style="color:rgb(170, 42, 42); font-size: 13px;">
			??????????????? 3???????????? ????????? ????????????. <br> ?????? ????????? ??????????????? ????????? ??????????????? ????????? ???????????????????????????!
			</p>
			<div class="modal-footer"  style="background-color: #F3D798;">
				<button type="submit" class="btn btn-danger">????????????</button>
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">??????</button>
			</div>
			</form>
	</div>
	</div>
</div>
</div>
   
   
   
   
   
   </div>
</body>
</html>