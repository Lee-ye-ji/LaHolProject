<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지-스토어 관리</title>
    <!-- menubar css -->
    <link rel="stylesheet" href="${ contextPath }/resources/css/common/menubar.css">
    <!-- side menubar css -->
    <link rel="stylesheet" href="${ contextPath }/resources/css/mypage/sideMenu.css">
    <!-- footer css -->
    <link rel="stylesheet" href="${ contextPath }/resources/css/common/footer.css">
    <!-- datepicker -->
    <link href="${ contextPath }/resources/css/common/datepicker.min.css" rel="stylesheet" type="text/css" media="all">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    
    <!-- char.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
    <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.0.1/chart.min.js" integrity="sha512-2uu1jrAmW1A+SMwih5DAPqzFS2PI+OPw79OVLS4NJ6jGHQ/GmIVDDlWwz4KLO8DnoUmYdU8hTtFcp8je6zxbCg==" crossorigin="anonymous"></script> -->

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
        	height : 1000px;
        }

        #mp{
            display: flex;
            margin-top: 1%;
            margin-left: 5%;
            width: 80vw;
            height: 900px;
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
            margin-top : 30px;
            justify-content: flex-start;
            width : 90%;
            flex-direction: row;
        }

        .content-div .content-header {
            text-align: left;
            margin-bottom: 10px;
        }

        .content-div .content-header select {
            width : 150px;
            height: 40px;
            margin-bottom: 10px;
            outline: none;
        }

        .content-div .content-header input[type=button] {
            width : 100px;
            outline: none;
            color : #fff;
            background: #4B654A;
            border : none;
        }
        
        .content-div .text-div {
            width : 70%;
        }

        .content-div .price-text {
            display: flex;
            text-align: center;
            margin-bottom: 10px;
        }

        .content-div .text-div .sub-text {
            border-left: 2px solid #5A452E;
            margin : 0 10px;
            margin-right: 0;
            padding : 0 15px;
        }

        .content-div .text-div .sub-text:first-child {
            padding-left: 0;
            margin-left: 0;
            border-left: none;
        }

        #date1, #date2 {
            width : 150px;
            outline: none;

            border : 1px solid #e7e7e7;
            transition: border 0.3s;
        }

        #date1:focus, #date2:focus {
            border : 1px solid #4B654A;
        }

        @media only screen and (max-width : 1340px) {
            #date1, #date2 {
                width : 100px;
                font-size: 11px;
            }

            .content-div .content-header input[type=button] {
                width : 80px;
            }
        }

        .content-table {
        	margin-bottom : 10px;
            /* min-height: 580px; */
        }

        .content-div #list-table {
            text-align: center;
            border-collapse: collapse;
            border-top : 2px solid #5A452E;
            border-bottom : 2px solid #5A452E;
        }

        .content-div #list-table td {
            padding : 10px;
        }

        .content-div #list-table tr:not(:first-child) {
            height: 50px;
        }

        .content-div #list-table tr:first-child {
            background: #5A452E;
            border-bottom: 2px solid #5A452E;
            color : white;

            height: 30px !important;
        }

        .content-div #list-table tr:first-child td:nth-child(1) {
            width : 100px;
        }

        .content-div #list-table tr:first-child td:nth-child(2) {
            width : 150px;
        }

        .content-div #list-table tr:first-child td:nth-child(3) {
            width : 400px;
        }

        .content-div #list-table tr:first-child td:nth-child(4) {
            width : 200px;
        }

        .content-div #list-table tr:first-child td:nth-child(5) {
            width : 150px;
        }

        .content-div #list-table tr:first-child td:nth-child(6) {
            width : 150px;
        }

        .chart-div {
            width : 30%;
        }
        #mychart {
            width : 100%;
            height: 60%;
        }

        .modal2,
        .modal3 {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }
    
        /* Modal Content/Box */
        .modal-content2,
        .modal-content3 {
            border-radius: 15px;
            background-color: #fefefe;
            margin: 15% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 20%; /* Could be more or less, depending on screen size */
            display: flex;                       
            flex-direction: column;
        }
        /* The Close Button */
        .modal-close2,
        .modal-close3 {
            color: #aaa;
            display: flex;
            justify-content: flex-end;
            font-size: 28px;
            font-weight: bold;
        }
        .modal-close2:hover,
        .modal-close2:focus,
        .modal-close3:hover,
        .modal-close3:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        .select-menuBtn {
            width : 90%;
            border: 1px solid #4B654A;
            background: #4B654A;
            color : #fff;
            border-radius: 15px;
            outline: none;
            height: 50px;

            margin : 10px;
        }
        
        .btn-ba,
        .btn-p {
        	width : 30px;
        	height : 30px;
        }
        
        .btn-ba {
        	background : #4B654A;
        	border : none;
        	color : #fff;
        	border-radius : 5px;
        	
        	transition : all 0.3s;
        }
        
        .btn-ba:hover {
        	background : #5A452E;
        	
        	transition : all 0.3s;
        }
        
        .btn-p {
        	border : none;
        	background : transparent;
        }
        
        .btn-p:disabled {
        	color : #E5BD62;
        }
		
		.swal2-confirm,
        .swal2-cancel,
        .swal2-html-container,
        .swal2-title {
        	font-family: 'NEXON Lv1 Gothic OTF';
        }
        
        #list-table tr:not(:nth-child(1)) td {
        	font-size : 12px;
        }

    </style>
</head>
<body>
	<!-- menubar -->
	<jsp:include page="/WEB-INF/views/common/menubar.jsp"/>
    <!-- Air datepicker css -->
    <script src="${ contextPath }/resources/js/mypage/datepicker.js"></script> <!-- Air datepicker js -->
    <script src="${ contextPath }/resources/js/mypage/datepicker.ko.js"></script> <!-- 달력 한글 추가를 위해 커스텀 -->
    <!-- 카페 사이드 메뉴 바 -->
    <div class="mypage-container">
        <div id="side" class="col-mp">
            <ul class="side-menu">
                <li class="side-item active" onclick="location.href='${contextPath}/pMypage/homeView'"> 
                        <div class="side-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                                <path   d="M18 12H19.9248C20.8933 12 21.2962 10.7609 20.513 10.1913L12.5881 4.42778C12.2375 4.17276 11.7625 4.17276 11.4118 4.42778L3.48699 10.1913C2.70374 10.7609 3.10668 12 4.07516 12H5.99998V19C5.99998 19.5523 6.44769 20 6.99998 20H9.99998V14H14V20H17C17.5523 20 18 19.5523 18 19V12Z"/>
                            </svg>
                        </div>
                        <p class="menu-text">HOME</p>
                </li>
                <li class="side-item" onclick="location.href='${contextPath}/pMypage/updateView'">
                        <div class="side-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                                <path  d="M17.864 3.60051C17.4735 3.20999 16.8403 3.20999 16.4498 3.60051L15.0356 5.01472 19.2782 9.25736 20.6924 7.84315C21.0829 7.45263 21.0829 6.81946 20.6924 6.42894L17.864 3.60051zM17.864 10.6716L13.6213 6.42894 4.72185 15.3284C4.53431 15.516 4.42896 15.7703 4.42896 16.0355L4.42896 18.864C4.42895 19.4163 4.87667 19.864 5.42896 19.864H8.25738C8.5226 19.864 8.77695 19.7586 8.96449 19.5711L17.864 10.6716z"/>
                            </svg>
                        </div>
                        <p class="menu-text">정보 수정</p>
                </li>
                <li class="side-item" >
                        <div class="side-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" height="48" viewBox="0 0 48 48" width="48">
                                <path d="M0 0h48v48h-48z" fill="none"/><path d="M40 8h-32v4h32v-4zm2 20v-4l-2-10h-32l-2 10v4h2v12h20v-12h8v12h4v-12h2zm-18 8h-12v-8h12v8z"/>
                            </svg>
                        </div>
                        <p class="menu-text">스토어 관리</p>
                </li>
                <li class="side-item">
                        <div class="side-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                                <path  fill-rule="evenodd" d="M15 5H18C19.1046 5 20 5.89543 20 7V19C20 20.1046 19.1046 21 18 21H6C4.89543 21 4 20.1046 4 19V7C4 5.89543 4.89543 5 6 5H9C9 3.34315 10.3431 2 12 2C13.6569 2 15 3.34315 15 5ZM13 5C13 5.55228 12.5523 6 12 6C11.4477 6 11 5.55228 11 5C11 4.44772 11.4477 4 12 4C12.5523 4 13 4.44772 13 5ZM6 9C6 8.44772 6.44772 8 7 8H17C17.5523 8 18 8.44772 18 9C18 9.55228 17.5523 10 17 10H7C6.44772 10 6 9.55228 6 9ZM7 12C6.44772 12 6 12.4477 6 13C6 13.5523 6.44772 14 7 14H17C17.5523 14 18 13.5523 18 13C18 12.4477 17.5523 12 17 12H7ZM7 16C6.44772 16 6 16.4477 6 17C6 17.5523 6.44772 18 7 18H10C10.5523 18 11 17.5523 11 17C11 16.4477 10.5523 16 10 16H7Z" clip-rule="evenodd"/>
                            </svg>
                        </div>
                        <p class="menu-text">배너 신청</p>
                </li>
                <li class="side-item" onclick="location.href='${contextPath}/pMypage/classView'">
                        <div class="side-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" enable-background="new 0 0 512 512" viewBox="0 0 512 512">
                                <path d="M302.1 80.2c-.2 19.2-12.2 37.2-30.7 43.5-18.4 6.3-38.7.7-51.2-14.2-12.4-14.9-13.7-36.6-3.8-53.1C226.4 40 246.2 31 265 34.9 286.5 39.4 301.8 58.3 302.1 80.2c.1 9.6 15.1 9.7 15 0-.3-25.7-16.3-48.5-40.4-57.5-23.6-8.7-51.4-1.1-67.4 18.1-16.5 19.8-19.1 48.5-5.7 70.7 13.2 22 39 33.1 64.1 28.6 28.7-5.2 49.1-31.3 49.5-60C317.2 70.5 302.2 70.5 302.1 80.2zM161.7 206c20-19.5 44.9-33.3 72.6-38.1 25.9-4.5 53.2-.4 76.9 10.9 14.5 6.9 27.6 16.2 39.1 27.3 7 6.7 17.6-3.9 10.6-10.6-21.9-21.1-49.4-36.5-79.5-41.9-29.5-5.3-59.6-1.3-86.7 11.3-16.2 7.5-30.8 18.2-43.6 30.6C144.2 202.1 154.8 212.7 161.7 206L161.7 206zM71.8 316.5c0-18.5 0-37 0-55.5 0-6-1.6-14.8 1-20.5 3.2-7.2 11.5-9.3 18.6-9.3 28.9-.1 57.9 0 86.8 0 48.4 0 96.9 0 145.3 0 33.1 0 66.2 0 99.3 0 1.8 0 3.6 0 5.4 0 6.8.1 14.5 3 17.3 9.8 1 2.4.8 5 .8 7.6 0 20.8 0 41.6 0 62.4 0 1.9 0 3.7 0 5.6 0 9.7 15 9.7 15 0 0-19.2 0-38.4 0-57.6 0-8.2 1-17.2-2.5-24.9-5.5-11.9-18.6-17.8-31.2-17.9-28.3-.2-56.7 0-85 0-50 0-99.9 0-149.9 0-33 0-66.1 0-99.1 0-4.8 0-9.7.1-14.4 1.5-13.8 4.1-22.5 15.5-22.5 29.8 0 21.1 0 42.1 0 63.2 0 2 0 3.9 0 5.9C56.8 326.2 71.8 326.2 71.8 316.5L71.8 316.5zM119.6 388.1c-.2 12.5-7.8 23.9-19.6 28.3-12.1 4.5-25.9.7-34-9.3-17.2-21.2 2-53.7 28.9-48.6C109.2 361.2 119.3 373.6 119.6 388.1c.2 9.6 15.2 9.7 15 0-.3-19.1-12-35.9-30-42.5-17.6-6.5-38.3-.6-50 14C42.8 374 41 394.7 50.5 410.9c9.7 16.6 29 24.9 47.7 21.5 21.2-3.9 36-23.2 36.4-44.3C134.7 378.5 119.7 378.5 119.6 388.1zM24.8 478c17.5-17 40.4-27.6 65-27.3 24.2.2 46.9 10.7 64.2 27.3 7 6.7 17.6-3.9 10.6-10.6-20.2-19.3-46.7-31.5-74.8-31.7-28.5-.2-55.3 12-75.6 31.7C7.3 474.1 17.9 484.7 24.8 478L24.8 478z"/><g><path d="M286.1 388.1c-.2 12.5-7.8 23.9-19.6 28.3-12.1 4.5-25.9.7-34-9.3-17.2-21.2 2-53.7 28.9-48.6C275.8 361.2 285.9 373.6 286.1 388.1c.2 9.6 15.2 9.7 15 0-.3-19.1-12-35.9-30-42.5-17.6-6.5-38.3-.6-50 14-11.7 14.5-13.5 35.2-4.1 51.3 9.7 16.6 29 24.9 47.7 21.5 21.2-3.9 36-23.2 36.4-44.3C301.3 378.5 286.3 378.5 286.1 388.1zM191.4 478c17.5-17 40.4-27.6 65-27.3 24.2.2 46.9 10.7 64.2 27.3 7 6.7 17.6-3.9 10.6-10.6-20.2-19.3-46.7-31.5-74.8-31.7-28.5-.2-55.3 12-75.6 31.7C173.8 474.1 184.4 484.7 191.4 478L191.4 478z"/></g><g><path d="M452.7 388.1c-.2 12.5-7.8 23.9-19.6 28.3-12.1 4.5-25.9.7-34-9.3-17.2-21.2 2-53.7 28.9-48.6C442.4 361.2 452.4 373.6 452.7 388.1c.2 9.6 15.2 9.7 15 0-.3-19.1-12-35.9-30-42.5-17.6-6.5-38.3-.6-50 14-11.7 14.5-13.5 35.2-4.1 51.3 9.7 16.6 29 24.9 47.7 21.5 21.2-3.9 36-23.2 36.4-44.3C467.9 378.5 452.9 378.5 452.7 388.1zM357.9 478c17.5-17 40.4-27.6 65-27.3 24.2.2 46.9 10.7 64.2 27.3 7 6.7 17.6-3.9 10.6-10.6-20.2-19.3-46.7-31.5-74.8-31.7-28.5-.2-55.3 12-75.6 31.7C340.4 474.1 351 484.7 357.9 478L357.9 478z"/></g>
                            </svg>
                        </div>
                        <p class="menu-text">클래스 현황</p>
                </li>
                <li class="side-item" onclick="location.href='${contextPath}/pMypage/deleteView'">
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
                $(".side-item:nth-child(3)").addClass("active");

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
                <div class="text-div">
                    <div class="content-header">
                        <form id="period_form" method="GET" action="${ contextPath }/pMypage/searchStore">
                            <select id="pay-category" name="searchCondition">
                                <option value="" <c:if test="${ param.searchCondition == '' }">selected</c:if>>전체</option>
                                <option value="CA" <c:if test="${ param.searchCondition == 'CA' }">selected</c:if>>카페</option>
                                <option value="CL" <c:if test="${ param.searchCondition == 'CL' }">selected</c:if>>클래스</option>
                                <option value="ST" <c:if test="${ param.searchCondition == 'ST' }">selected</c:if>>스토어</option>
                            </select>
                            <br>
                            <input type="radio" id="1-month" name="search" value="1" checked>
                            <label for="1-month">1개월</label>&nbsp;&nbsp;
                            <input type="radio" id="3-month" name="search" value="3" <c:if test="${ param.search == '3' }">checked</c:if>>
                            <label for="3-month">3개월</label>&nbsp;&nbsp;
                            <input type="radio" id="6-month" name="search" value="6" <c:if test="${ param.search == '6' }">checked</c:if>>
                            <label for="6-month">6개월</label>&nbsp;&nbsp;
                            <input type="radio" id="selection" name="search" value="selection" <c:if test="${ param.search == '' }">checked</c:if>>
                            <input type="text" id="date1" name="period_start">&nbsp;
                            <label style="color:#5A452E"> ~</label>&nbsp;
                            <input type="text" id="date2" name="period_end">&nbsp;&nbsp;
                            <input type="button" value="검색" onclick="onSubmit();">
                        </form>
                    </div>
                    <div class="price-text">
                        <span class="sub-text">판매 건 수 : <fmt:formatNumber value="${ map.count }"/>건</span>
                        <c:if test="${ empty search }">
	                        <span class="sub-text">총 판매 금액 : <fmt:formatNumber value="${ map.sumPriceTotal }"/>원</span>
	                        <span class="sub-text">발생 수수료 : <fmt:formatNumber value="${ map.sumPriceTotal * 0.05 }"/>원</span>
	                        <span class="sub-text">순이익 : <fmt:formatNumber value="${ map.sumPriceTotal * 0.95 }"/>원</span>
                        </c:if>
                        <c:if test="${ !empty search }">
                        	<span class="sub-text">총 판매 금액 : <fmt:formatNumber value="${ map.sumPriceCategory }"/>원</span>
	                        <span class="sub-text">발생 수수료 : <fmt:formatNumber value="${ map.sumPriceCategory * 0.05 }"/>원</span>
	                        <span class="sub-text">순이익 : <fmt:formatNumber value="${ map.sumPriceCategory * 0.95 }"/>원</span>
                        </c:if>
                    </div>
                    <div class="content-table">
                        <table id="list-table">
                            <tr>
                                <td>결제코드</td>
                                <td>카테고리</td>
                                <td>물품명</td>
                                <td>수량</td>
                                <td>금액</td>
                                <td>판매일</td>
                            </tr>
                            <c:if test="${ empty list }">
                            	<tr>
                            		<td colspan="6">${ payList }</td>
                            	</tr>
                            </c:if>
                            <c:if test="${ !empty list }">
                            <c:forEach var="p" items="${ list }" varStatus="status">
	                            <tr>
	                                <td>${ p.pay_no }</td>
	                                <c:if test="${ fn:contains(p.pay_no, 'CL') }">
	                                <td>클래스</td>
	                                </c:if>
	                                <c:if test="${ fn:contains(p.pay_no, 'ST') }">
	                                <td>스토어</td>
	                                </c:if>
	                                <c:if test="${ fn:contains(p.pay_no, 'CA') }">
	                                <td>카페</td>
	                                </c:if>
	                                <td>${ p.pay_item }</td>
	                                <c:if test="${ fn:contains(p.pay_no, 'CA') }">
	                                <td>-</td>
	                                </c:if>
	                                <c:if test="${ !fn:contains(p.pay_no, 'CA') }">
	                                <td>${ p.pr_count }</td>
	                                </c:if>
	                                <td><fmt:formatNumber value="${ p.pay_price }"/></td>
	                                <td><fmt:formatDate value="${ p.pay_date }" pattern="MM월 dd일"/></td>
	                            </tr>
                            </c:forEach>
                            </c:if>
                        </table>
                    </div>
                    <!-- 페이징 추가 해야 함 -->
                    <div class="paging-div">
                    <!-- 이전 -->
                    <c:choose>
                    	<c:when test="${ pi.currentPage <= 1 }">
                    		<button class="btn-ba" disabled> &lt; </button>
                    	</c:when>
                    	<c:when test="${ empty search }">
                    		<c:url var="before" value="/pMypage/storeView">
                				<c:param name="page" value="${ pi.currentPage - 1 }"/>
                			</c:url>
                			<button class="btn-ba" onclick="location.href='${ before }'"> &lt;</button>
                    	</c:when>
                    	<c:otherwise>
                    		<c:url var="before" value="/pMypage/searchStore">
                				<c:param name="page" value="${ pi.currentPage - 1 }"/>
                				<c:param name="searchCondition" value="${ param.searchCondition }"/>
								<c:param name="period_start" value="${ param.period_start }"/>
								<c:param name="period_end" value="${ param.period_end }"/>
								<c:param name="search" value="${ param.search }"/>
                			</c:url>
                			<button class="btn-ba" onclick="location.href='${ before }'"> &lt;</button>
                    	</c:otherwise>
                    </c:choose>
                	<!-- 페이지 숫자 -->
                	<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
                		<c:choose>
	                		<c:when test="${ p eq pi.currentPage }">
	                			<button class="btn-p" disabled>${ p }</button>
	                		</c:when>
	                		<c:when test="${ empty search }">
	                			<c:url var="pagination" value="/pMypage/storeView">
	                				<c:param name="page" value="${ p }"/>
	                			</c:url>
	               				<button class="btn-p" onclick="location.href='${ pagination }'">${ p }</button>
	                		</c:when>
	                		<c:otherwise>
	                			<c:url var="pagination" value="/pMypage/searchStore">
	                				<c:param name="page" value="${ p }"/>
	                				<c:param name="searchCondition" value="${ param.searchCondition }"/>
									<c:param name="period_start" value="${ param.period_start }"/>
									<c:param name="period_end" value="${ param.period_end }"/>
									<c:param name="search" value="${ param.search }"/>
	                			</c:url>
	               				<button class="btn-p" onclick="location.href='${ pagination }'">${ p }</button>
	                		</c:otherwise>
               			</c:choose>
                	</c:forEach>
                	<!-- 다음 -->
                	<c:choose>
	                	<c:when test="${ pi.currentPage >= pi.maxPage }">
							<button class="btn-ba" disabled> &gt; </button>
						</c:when>
						<c:when test="${ empty search }">
							<c:url var="after" value="/pMypage/storeView">
								<c:param name="page" value="${ pi.currentPage + 1 }"/>
							</c:url>
							<button class="btn-ba" onclick="location.href='${ after }'"> &gt;</button>
						</c:when>
						<c:otherwise>
							<c:url var="after" value="/pMypage/searchStore">
								<c:param name="page" value="${ pi.currentPage + 1 }"/>
								<c:param name="searchCondition" value="${ param.searchCondition }"/>
								<c:param name="period_start" value="${ param.period_start }"/>
								<c:param name="period_end" value="${ param.period_end }"/>
								<c:param name="search" value="${ param.search }"/>
							</c:url>
							<button class="btn-ba" onclick="location.href='${ after }'"> &gt;</button>
						</c:otherwise>
					</c:choose>
                    </div>
                </div>
                <div class="chart-div" style="margin-left:5%;">
                	<div id="barChart" style="width:90%; height:45%; margin-top: 15%;">
                    	<canvas id="myChart" width="300" height="250"></canvas>
                    </div>
                    <script>
                    var ctx = document.getElementById('myChart');
                    var myChart = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: ['Store', 'Class', 'Cafe'],
                            datasets: [{
                                label: '판매비율',
                                data: [${ map.storePriceTotal div map.sumPriceTotal * 100}, ${ map.classPriceTotal div map.sumPriceTotal * 100}, ${ map.cafePriceTotal div map.sumPriceTotal * 100}],   // 비율 변경
                                backgroundColor: [
                                    'rgba(255, 99, 132, 0.2)',
                                    'rgba(54, 162, 235, 0.2)',
                                    'rgba(255, 206, 86, 0.2)',
                                    'rgba(75, 192, 192, 0.2)',
                                    'rgba(153, 102, 255, 0.2)',
                                    'rgba(255, 159, 64, 0.2)'
                                ],
                                borderColor: [
                                    'rgba(255, 99, 132, 1)',
                                    'rgba(54, 162, 235, 1)',
                                    'rgba(255, 206, 86, 1)',
                                    'rgba(75, 192, 192, 1)',
                                    'rgba(153, 102, 255, 1)',
                                    'rgba(255, 159, 64, 1)'
                                ],
                                borderWidth: 1
                            }]
                        },
                        options: {
                        	 tooltips: {
                                 callbacks: {
                                     label: function (tooltipItem, data) {
                                         return Number(tooltipItem.yLabel).toFixed(2);
                                     }
                                 }
                             },
                        	legend: {
            		            position: "bottom",
            		            display: false
            		        },
                            scales: {
                            	yAxes: [{
            		                ticks: {
            		                    fontColor: "rgba(0,0,0,0.5)",
            		                    fontStyle: "bold",
            		                    beginAtZero: true,
            		                    maxTicksLimit: 5,
            		                    padding: 5,
            		                    display: false
            		                },
            		                gridLines: {
            		                    drawTicks: false,
            		                    display: false
            		                }

            		            }]
                            }
                        }
                    });
                    </script>
                    <div id="lineChart" style="width:90%; height:300px;">
                    	<canvas id="line" width="300" height="250"></canvas>
                    </div>
                    <script>
                        var chart = document.getElementById("line").getContext("2d");
                        var data = [];
                        if(${ empty search }) {
        		            data = [${ map.storePriceTotal div map.sumPriceTotal * 100 }, ${ map.classPriceTotal div map.sumPriceTotal * 100 }, ${ map.cafePriceTotal div map.sumPriceTotal * 100 }]
    		            } else {
    		            	data = [${ map.storePrice div map.sumPrice * 100 }, ${ map.classPrice div map.sumPrice * 100 }, ${ map.cafePrice div map.sumPrice * 100 }]
    		            }
                        var myChart = new Chart(chart, {
                		    type: 'line',
                		    data: {
                		        labels: ["Store", "Class", "Cafe"],
                		        datasets: [{
                		            label: "전체 판매 비율",
                		            borderColor: "#ff6384",
                		            pointBorderColor: "#ff6384",
                		            pointBackgroundColor: "#ff6384",
                		            pointHoverBackgroundColor: "#ff6384",
                		            pointHoverBorderColor: "#ff6384",
                		            pointBorderWidth: 5,
                		            pointHoverRadius: 5,
                		            pointHoverBorderWidth: 1,
                		            pointRadius: 3,
                		            fill: false,
                		            borderWidth: 4,
                		            data : data
                		        }]
                		    },
                		    options: {
                		    	tooltips: {
                                    callbacks: {
                                        label: function (tooltipItem, data) {
                                            return Number(tooltipItem.yLabel).toFixed(2);
                                        }
                                    }
                                },
                		        legend: {
                		            position: "bottom",
                		            display: false
                		        },
                		        scales: {
                		            yAxes: [{
                		                ticks: {
                		                    fontColor: "rgba(0,0,0,0.5)",
                		                    fontStyle: "bold",
                		                    beginAtZero: true,
                		                    maxTicksLimit: 5,
                		                    padding: 5,
                		                    display: false
                		                },
                		                gridLines: {
                		                    drawTicks: false,
                		                    display: false
                		                }

                		            }],
                		            xAxes: [{
                		                gridLines: {
                		                    zeroLineColor: "transparent"
                		                },
                		                ticks: {
                		                    padding: 2,
                		                    fontColor: "rgba(0,0,0,0.5)",
                		                    fontStyle: "bold"
                		                }
                		            }]
                		        }
                		    }
                		});
                    </script>
                </div>
            </div>
        </div>
        
    </div>
    <script>
        $("#date1").datepicker({
    	    language: 'ko',
    	    autoClose : true
        });
        $("#date2").datepicker({
        	language: 'ko',
    	    autoClose : true
        });
        
        var category = document.getElementById("pay-category");
        var month1 = document.getElementById("1-month");
        var month3 = document.getElementById("3-month");
        var month6 = document.getElementById("6-month");
        var date1 = document.getElementById("date1");
        var date2 = document.getElementById("date2");
        
        function onSubmit() {
	        if($("#selection").prop('checked')) {
	    		if(date1.value == "") {
	    			Swal.fire({
						title : '시작 기간을 설정해주세요.',
						icon : 'warning'
					});
	    			return;
	    		}
	    		
	    		if(date2.value == "") {
	    			Swal.fire({
						title : '끝 기간을 설정해주세요.',
						icon : 'warning'
					});
	    			return;
	    		}
	    	}
	        $("#period_form").submit();
        }
        
        /* $("#pay-category").change(function(){
        	var category = $(this).val();
        	
        	$.ajax({
        		url : ""
        	});
        }); */
        </script>
    <div id="menuModal" class="modal2">
        <div class="modal-content2">
            <span class="modal-close2">&times;</span>
            <button class="select-menuBtn" onclick="location.href='${contextPath}/pMypage/storeView'">스토어 통계</button>
            <button class="select-menuBtn" onclick="location.href='${contextPath}/pMypage/orderView'">주문내역</button>
        </div>
    </div>

    <div id="menuModal2" class="modal3">
        <div class="modal-content3">
            <span class="modal-close3">&times;</span>
            <button class="select-menuBtn" onclick="location.href='${contextPath}/pMypage/adView'">신청하기</button>
            <button class="select-menuBtn" onclick="location.href='${contextPath}/pMypage/adListView'">신청내역</button>
        </div>
    </div>
    <script>
        var modal = document.getElementById("menuModal");
        var modal2 = document.getElementById("menuModal2");
        var btn = $(".side-item:nth-child(3)");
        var btn2 = $(".subMenu-div:nth-child(2)");

        var adBtn = $(".side-item:nth-child(4)");
        var adBtn2 = $(".subMenu-div:nth-child(3)");

        var span = document.getElementsByClassName("modal-close2")[0];
        var span2 = document.getElementsByClassName("modal-close3")[0];

        btn.on('click', function(){
            modal.style.display = "block";
        });

        btn2.on('click', function(){
            modal.style.display = "block";
        });

        span.onclick = function(){
            modal.style.display = "none";
        }

        adBtn.on('click', function(){
            modal2.style.display = "block";
        });

        adBtn2.on('click', function(){
            modal2.style.display = "block";
        });

        span2.onclick = function(){
            modal2.style.display = "none";
        }

        window.onclick = function(event){
            if(event.target == modal) {
                modal.style.display = "none";
            }

            if(event.target == modal2) {
                modal2.style.display = "none";
            }
        }
    </script>
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>