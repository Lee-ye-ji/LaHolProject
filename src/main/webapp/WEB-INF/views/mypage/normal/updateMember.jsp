<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 - 정보 수정</title>
    <!-- menubar css -->
    <link rel="stylesheet" href="${ contextPath }/resources/css/common/menubar.css">
    <!-- side menubar css -->
    <link rel="stylesheet" href="${ contextPath }/resources/css/mypage/sideMenu.css">
    <!-- footer css -->
    <link rel="stylesheet" href="${ contextPath }/resources/css/common/footer.css">
    <link rel="stylesheet" href="${ contextPath }/resources/css/common/fonts.css" type="text/css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <style>
        body{
            margin: 0;
            padding: 0;
        }

        .mypage-container{
            width: 100%;
            height: auto; 
            padding-top: 10%;
        }
        
        .mp-container {
        	height : 900px;
        }


        #mp{
            display: flex;
            margin-top: 1%;
            margin-left: 5%;
            width: 80vw;
            height: 800px;
            justify-content: center;
            text-align: center;
            border-radius: 30px;
            -webkit-box-shadow: 0px 14px 32px 0px rgba(0, 0, 0, 0.15);
            -moz-box-shadow: 0px 14px 32px 0px rgba(0, 0, 0, 0.15);
            box-shadow: 0px 14px 32px 0px rgba(0, 0, 0, 0.15);
        }

        .col-mp{
            float: left;
        }

        .side-item {
            cursor: pointer;
        }

        .content-div {
            display : flex;
            justify-content: center;
            align-content: center;
            width : 80%;
            margin : 30px auto;
            flex-direction: column;
        }

        .content-title {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 10%;
        }

        .content-info {
            display: flex;
            justify-content: center;
            background : rgba(243, 215, 152, 0.6);
            border-radius: 20px;
            width : 100%;
            height : 90%;
        }

        .info-div {
            padding-top : 20px;
            width : 80%;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-content: center;
        }

        .info-div table tr td:first-child {
            text-align: right;
            padding: 10px;
        }

        .info-div table tr td:nth-child(3) {
            text-align: right;
            padding : 10px;

        }
        
        .info-div table tr:last-child td {
        	text-align : center;
        }
        
        .info-div table tr:last-child button {
        	width : 9vw;
        }

        .info-div span {
            font-size : 20px;
        }

        @media only screen and (max-width : 1280px) {
            .info-div span {
                font-size: 14px;
            }
        }

        @media only screen and (max-width : 970px) {
            .info-div span {
                font-size : 10px;
            }
        }

        .info-div input {
            width : 17vw;
            height : 50px;
            margin : 10px 0;
            padding: 10px;
            font-size : 13px;
            outline: none;
            border : 1px solid #c2c2c2;

            transition: border 0.3s;
        }

        .info-div input:focus {
            border: 1px solid #4B654A;
            transition: border 0.3s;
        }

        #address1 {
            width : 12vw;
        }

        .info-div button {
            width : 4.5vw;
            height: 50px;
            outline: none;
            border : none;
            background: #4B654A;
            color : #fff;
        }
        
        .swal2-confirm,
        .swal2-cancel,
        .swal2-html-container,
        .swal2-title {
        	font-family: 'NEXON Lv1 Gothic OTF';
        }

    </style>
</head>
<body>
	<!-- menubar -->
	<jsp:include page="/WEB-INF/views/common/menubar.jsp"/>
    <!-- 카페 사이드 메뉴 바 -->
    <div class="mypage-container">
        <div id="side" class="col-mp">
            <ul class="side-menu">
                <li class="side-item active" onclick="location.href='${contextPath}/nMypage/homeView'"> 
                        <div class="side-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                                <path   d="M18 12H19.9248C20.8933 12 21.2962 10.7609 20.513 10.1913L12.5881 4.42778C12.2375 4.17276 11.7625 4.17276 11.4118 4.42778L3.48699 10.1913C2.70374 10.7609 3.10668 12 4.07516 12H5.99998V19C5.99998 19.5523 6.44769 20 6.99998 20H9.99998V14H14V20H17C17.5523 20 18 19.5523 18 19V12Z"/>
                            </svg>
                        </div>
                        <p class="menu-text">HOME</p>
                </li>
                <li class="side-item" onclick="location.href='${contextPath}/nMypage/updateView'">
                        <div class="side-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                                <path  d="M17.864 3.60051C17.4735 3.20999 16.8403 3.20999 16.4498 3.60051L15.0356 5.01472 19.2782 9.25736 20.6924 7.84315C21.0829 7.45263 21.0829 6.81946 20.6924 6.42894L17.864 3.60051zM17.864 10.6716L13.6213 6.42894 4.72185 15.3284C4.53431 15.516 4.42896 15.7703 4.42896 16.0355L4.42896 18.864C4.42895 19.4163 4.87667 19.864 5.42896 19.864H8.25738C8.5226 19.864 8.77695 19.7586 8.96449 19.5711L17.864 10.6716z"/>
                            </svg>
                        </div>
                        <p class="menu-text">정보 수정</p>
                </li>
                <li class="side-item" onclick="location.href='${contextPath}/nMypage/paymentView'">
                        <div class="side-icon" id="cafeRes">
                            <svg xmlns="http://www.w3.org/2000/svg" data-name="Layer 1" viewBox="0 0 24 24">
                                <path d="M12,19a1,1,0,1,0-1-1A1,1,0,0,0,12,19Zm5,0a1,1,0,1,0-1-1A1,1,0,0,0,17,19Zm0-4a1,1,0,1,0-1-1A1,1,0,0,0,17,15Zm-5,0a1,1,0,1,0-1-1A1,1,0,0,0,12,15ZM19,3H18V2a1,1,0,0,0-2,0V3H8V2A1,1,0,0,0,6,2V3H5A3,3,0,0,0,2,6V20a3,3,0,0,0,3,3H19a3,3,0,0,0,3-3V6A3,3,0,0,0,19,3Zm1,17a1,1,0,0,1-1,1H5a1,1,0,0,1-1-1V11H20ZM20,9H4V6A1,1,0,0,1,5,5H6V6A1,1,0,0,0,8,6V5h8V6a1,1,0,0,0,2,0V5h1a1,1,0,0,1,1,1ZM7,15a1,1,0,1,0-1-1A1,1,0,0,0,7,15Zm0,4a1,1,0,1,0-1-1A1,1,0,0,0,7,19Z"/>
                            </svg>
                        </div>
                        <p class="menu-text">구매 내역</p>
                </li>
                <li class="side-item" onclick="location.href='${contextPath}/nMypage/couponView'">
                        <div class="side-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                                <path d="M22,4H2A1,1,0,0,0,1,5V19a1,1,0,0,0,1,1H22a1,1,0,0,0,1-1V5A1,1,0,0,0,22,4ZM21,18H19V15a1,1,0,0,0-2,0v3H3V6H17V9a1,1,0,0,0,2,0V6h2ZM13.71,8.29a1,1,0,0,1,0,1.42l-6,6a1,1,0,0,1-1.42,0,1,1,0,0,1,0-1.42l6-6A1,1,0,0,1,13.71,8.29ZM7,9a1,1,0,1,1,1,1A1,1,0,0,1,7,9Zm6,6a1,1,0,1,1-1-1A1,1,0,0,1,13,15Z"/>
                            </svg>
                        </div>
                        <p class="menu-text">My 쿠폰</p>
                </li>
                <li class="side-item" onclick="location.href='${contextPath}/nMypage/deleteView'">
                        <div class="side-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" data-name="Layer 1" viewBox="0 0 29 29">
                                <path d="M14.5,2A12.51408,12.51408,0,0,0,2,14.5,12.52131,12.52131,0,0,0,14.5,27a12.5,12.5,0,0,0,0-25Zm7.60309,19.71283a8.48005,8.48005,0,0,0-15.19873.00824A10.36659,10.36659,0,0,1,4,14.5a10.5,10.5,0,0,1,21,0A10.36807,10.36807,0,0,1,22.10309,21.71283ZM14.5,7A4.5,4.5,0,1,0,19,11.5,4.5,4.5,0,0,0,14.5,7Z"/>
                            </svg>
                        </div>
                        <p class="menu-text">회원 탈퇴</p>
                </li>
            </ul>
        </div>
        <script>
            $(function() {
                $(".side-item").removeClass("active");
                $(".side-item:nth-child(2)").addClass("active");

            $(".side-item").click(function(e) {
                    e.preventDefault();
                    $(".side-item").removeClass("active");
                    $(this).addClass("active");
                });
            });

        </script>
    </div>
    <div class="mp-container">
        <div id="mp" class="col-mp">
            <!-- 이부분에 내용 작성 -->
            <div class="content-div">
                <div class="content-title">
                    <h3>회원 정보 수정</h3>
                </div>
                <c:set var="addr" value="${ fn:split(sessionScope.loginUser.addr, ',') }"/>
                <div class="content-info">
                    <div class="info-div">
                        <form id="update_form" method="POST" action="${ contextPath }/nMypage/update">
                            <table class="info-table">
                                <tr>
                                    <td>
                                        <span class="sub-title">아이디</span>
                                    </td>
                                    <td>
                                        <input type="text" id="id" name="id" value="${ sessionScope.loginUser.id }" readonly>
                                    </td>
                                    <td><span class="sub-title">휴대폰</span></td>
                                    <td colspan="2"><input type="text" id="phone" name="phone" maxlength="11" value="${ sessionScope.loginUser.phone }" placeholder="'-'제외 입력"></td>
                                </tr>
                                <tr>
                                    <td><span class="sub-title">이름</span></td>
                                    <td><input type="text" id="name" name="name" value="${ sessionScope.loginUser.name }"></td>
                                    <td><span class="sub-title">주소</span></td>
                                    <td><input type="text" id="address1" name="address1" class="postcodify_postcode5" placeholder="우편번호" value="${ addr[0] }" readonly></td>
                                    <td><button type="button" class="btn-small" id="postcodify_search_button">검색</button></td>
                                </tr>
                                <tr>
                                    <td><span class="sub-title">비밀번호</span></td>
                                    <td><input type="password" id="pwd" name="pwd"></td>
                                    <td></td>
                                    <td colspan="2"><input type="text" id="address2" name="address2" class="postcodify_address" placeholder="도로명주소" value="${ addr[1] }" readonly></td>
                                </tr>
                                <tr>
                                    <td><span class="sub-title">비밀번호 확인</span></td>
                                    <td><input type="password" id="pwd2" name="pwd2"></td>
                                    <td></td>
                                    <td colspan="2"><input type="text" id="address3" name="address3" placeholder="상세 주소" class="postcodify_details" value="${ addr[2] }"></td>
                                </tr>
                                <tr>
                                    <td><span class="sub-title">이메일</span></td>
                                    <td><input type="text" id="email" name="email" value="${ sessionScope.loginUser.email }"></td>
                                </tr>
                                <tr>
                                	<td colspan="5"><button type="button" id="updateBtn" onclick="onSubmit();">수정하기</button></td>
                                </tr>
                            </table>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
    </div>
    <!-- jQuery와 Postcodify를 로딩한다 -->
    <script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>

    <!-- "검색" 단추를 누르면 팝업 레이어가 열리도록 설정한다 -->
    <script>
    	$(function() { $("#postcodify_search_button").postcodifyPopUp(); });
    	$("#address1").click(function(){
			$("#postcodify_search_button").trigger('click');
		});
		$("#address2").click(function(){
			$("#postcodify_search_button").trigger('click');
		});
		
		var pwd = document.getElementById("pwd");
		var pwd2 = document.getElementById("pwd2");
		function onSubmit() {
			if(pwd.value == "") {
            	Swal.fire({
					title : '비밀번호를 입력해주세요.',
					icon : 'warning'
				});
                pwd.focus();
                return;
			}
			
			if(pwd2.value == "") {
            	Swal.fire({
					title : '비밀번호 확인란을 입력해주세요.',
					icon : 'warning'
				});
                pwd2.focus();
                return;
			}
			
			if(pwd.value != pwd2.value) {
            	Swal.fire({
					title : '비밀번호가 일치하지 않습니다.',
					icon : 'warning'
				});
                pwd2.focus();
                return;
			}
			
			if(!chk(/(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[^a-zA-Z0-9]).{8,}$/, pwd, "비밀번호를 다시 입력해주세요.")) { // 특수문자,숫자,영대소문자 포함 8자 이상
                return;
            }
			
			$("#update_form").submit();
		}
		
		function chk(reg, e, msg) {

            if (reg.test(e.value)) {
                return true;
            }
            Swal.fire({
				title : msg,
				icon : 'warning'
			});
            e.value = "";
            e.focus();
            return false;
        }
   	</script>

    <!-- footer -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>