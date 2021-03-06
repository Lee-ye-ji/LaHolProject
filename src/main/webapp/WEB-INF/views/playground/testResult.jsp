<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<link rel="stylesheet" href="${ contextPath }/resources/css/playground/testResult.css" />
		<link rel="stylesheet" href="${ contextPath }/resources/css/common/fonts.css" />
	</head>
	<body>
		<section id="whole-container">
			<!-- π€μΌμͺ½ μμ­ -->
			<section id="left-area">
				<div id="title-container">
					<span id="title"><span id="type"></span>νμμ μν μΆμ² μλ</span>
				</div>
				<div id="product-container">
					<div id="product-list">
						<div class="product-box">
							<img class="product-img" src=''></img>
							<div class="product-name"></div>
						</div>
						<div class="product-box">
							<img class="product-img"></img>
							<div class="product-name"></div>
						</div>
						<div class="product-box">
							<img class="product-img"></img>
							<div class="product-name"></div>
						</div>
					</div>
				</div>
				<div id="desc-container">
					<span id="desc"></span>
				</div>
			</section>

			<!-- π€μ€λ₯Έμͺ½ μμ­ -->
			<section id="right-area">
				<div id="beanbag-container">
					<img id="beanbag"><img/>
				</div>
				<div id="retry-container">
					<a href="${ contextPath }" id="retry">
						<svg width="18" height="18" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
							<path d="M22.0209 12.4645H28.0209V6.46448" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
							<path d="M23.7782 23.7782C22.2398 25.3166 20.2798 26.3642 18.146 26.7886C16.0122 27.2131 13.8005 26.9952 11.7905 26.1627C9.78049 25.3301 8.06253 23.9202 6.85383 22.1113C5.64514 20.3023 5 18.1756 5 16C5 13.8244 5.64514 11.6977 6.85383 9.88873C8.06253 8.07979 9.78049 6.66989 11.7905 5.83733C13.8005 5.00477 16.0122 4.78693 18.146 5.21137C20.2798 5.6358 22.2398 6.68345 23.7782 8.22183L28.0208 12.4645" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
							</svg>
						νμΌλ‘
					</a>
				</div>
			</section>
		</section>
		<script>
		// νμ λ³ μ λ³΄
		var aType = {
		    typeName : 'A',
		    productList : [
		        { productName: 'Queen City', productImg: '${ contextPath }/resources/img/playground/creamy1.png'},
		        { productName: 'Gayo River', productImg: '${ contextPath }/resources/img/playground/creamy2.png'},
		        { productName: 'Peru Sabancaya', productImg: '${ contextPath }/resources/img/playground/creamy3.png'},
		    ],
		    typeDesc : 'λ¨λ―Έμμ μ£Όλ‘ μμ°λλ©° μ°λ―Έκ° κ°νμ§μκ³  λΆλλ¬μ μκΎΈ μ°Ύκ²λλ νλ¦¬λ―Έμ ν¬λ¦¬λ―Έ μλμλλ€.',
		    beanImg : '${ contextPath }/resources/img/playground/beanA.png'
		};

		var bType = {
		    'typeName' : 'B',
		    'productList' : [
		        { 'productName': 'Bisto Blend', 'productImg': '${ contextPath }/resources/img/playground/dark1.png'},
		        { 'productName': 'French Roast', 'productImg': '${ contextPath }/resources/img/playground/dark2.png'},
		        { 'productName': 'Guatemala Fnv', 'productImg': '${ contextPath }/resources/img/playground/dark3.png'},
		    ],
		    'typeDesc' : 'μμ ν μλλ₯Ό μλμ΄νλ¦¬μ λ‘μ€νΈλΌκ³ λ λΆλ¦¬λ λ€ν¬λ‘μ€νμ κ±°μ³ ν λ°λκ°κ³Ό νλΆν λ§κ³Ό ν₯μ΄ νΉμ§μλλ€',
		    'beanImg' : '${ contextPath }/resources/img/playground/beanB.png'
		};

		var cType = {
		    'typeName' : 'C',
		    'productList' : [
		        { 'productName': 'Espresso', 'productImg': '${ contextPath }/resources/img/playground/sugary1.png'},
		        { 'productName': 'Caffe Del Sol', 'productImg': '${ contextPath }/resources/img/playground/sugary2.png'},
		        { 'productName': 'Caffe Luna', 'productImg': '${ contextPath }/resources/img/playground/sugary3.png'},
		    ],
		    'typeDesc' : 'λΈλΌμ§ λ¨λΆμμ μ£Όλ‘ μμ°λλ λ°ν¬ μ΄μ½λ¦Ώκ³Ό μΉ΄λΌλ©μ λΆλλ¬μ΄ ν₯μ΄ μΊμλμ μ§ν±ν΄ μ£Όλ μ€λμ±μ΄ κ°ν μλμλλ€',
		    'beanImg' : '${ contextPath }/resources/img/playground/beanC.png'
		};

		// νμ λ¦¬μ€νΈ
		var typeList = [aType, bType, cType];


		// λλ€μΌλ‘ λ½κΈ°
		let random = Math.floor(Math.random() * typeList.length);
		var result = typeList[random];

		// νλ©΄μ μΆλ ₯
		$(function() {
		$('#type').html(result.typeName);
		$('#desc').html(result.typeDesc);
		$('#beanbag').attr('src', result.beanImg);

		for(var i= 0; i < 3; i++) {
		$('.product-img').eq(i).attr('src', result.productList[i].productImg);
		$('.product-name').eq(i).html(result.productList[i].productName);
		}
		});
		</script>
	</body>
</html>
