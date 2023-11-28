<%@page import="com.project4.board.db.BoardDTO"%>
<%@page import="javax.swing.plaf.basic.BasicTabbedPaneUI"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link rel="stylesheet" type="text/css" href="./css/reset.css" />
<link rel="stylesheet" type="text/css" href="./css/layout.css" />
<link id="pagestyle" href="./css/board.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="./css/productWriteForm.css"/>
<script src="./js/jquery.js"></script>

<script>
	// 창 사이즈에 따라 움직이는 제이쿼리문
	$(document).ready(function() {
		$('selector').css('width', $(window).width());
		$('selector').css('height', $(window).height());
		$(window).resize(function() {
			$('selector').css('width', $(window).width());
			$('selector').css('height', $(window).height());
		});
	});

	$(function() {
		let currentBtn = null; // 현재 선택된 메뉴 아이콘 저장 변수
		let currentBox = null; // 현재 선택된 Box 저장 변수
		let currentSpan = null; // 현재 선택된 span 태그 저장 변수

		// 페이지 로드 시 HOME 버튼을 클릭한 상태로 초기화
		const homeButton = $('.mn_btn:eq(6)');
		setButtonStyle(homeButton);

		// 클릭 가능한 모든 메뉴 아이콘에 대한 이벤트 처리
		$('.mn_btn').click(function() {
			if (currentBtn !== null && !$(this).is(currentBtn)) {
				resetButtonStyle(currentBtn);
			}
			setButtonStyle($(this));
		});

		// 스타일 초기화 함수
		function resetButtonStyle($btn) {
			$btn.closest('.mn_box').css('box-shadow', 'none');
			$btn.find('.mn_icon').css('background-color', '#fff');
			$btn.find('.mn_icon img').css('filter', '');
			$btn.find('.clickable-span').css('color', '#A0AEC0');
		}

		// 스타일 설정 함수
		function setButtonStyle($btn) {
			$btn.closest('.mn_box').css('box-shadow',
					'rgba(0, 0, 0, 0.05) 14px 14px 14px');
			$btn.find('.mn_icon').css('background-color', '#3182ce');
			$btn
					.find('.mn_icon img')
					.css(
							'filter',
							'invert(100%) sepia(0%) saturate(0%) hue-rotate(93deg) brightness(103%) contrast(103%)');
			$btn.find('.clickable-span').css('color', '#000');
			currentBtn = $btn;
		}
	});
</script>
</head>
<body>
	<!-- 왼쪽 메뉴 -->
	<jsp:include page="../inc/left.jsp"/>
        <!-- 상단메뉴 -->
		<jsp:include page="../inc/top.jsp"/>
		<!-- 메인페이지 -->
		<!-- 메인페이지 -->
		<div id="product-row">	
		 	<form action="./ProductWriteAction.pd" method="post" enctype="multipart/form-data">
		 			<div class="productWrite-bg mb-4">
						<div class="card-header pb-0">
			            </div>
	        			<table>
							<tr class="writeForm">
								<th colspan="2" id="bs">${dto.board_subject }</th>	
							</tr>
							<tr class="imgContent">
								<td class="Announcement-img">
									<img src="./upload/${dto.board_file}" alt="Image">									
								</td>		
							</tr>		
						</table>
						<div>
						<c:if test="${sessionScope.mdto.id eq 'admin' }">
							<input type="button" value="수정하기" id="button" onclick="location.href='./AnnouncementUpdate.bo?board_bno=${dto.board_bno}&pageNum=${pageNum }&id=${sessionScope.id }&board_subject=${dto.board_subject }&board_content=${dto.board_content }';">
							<input type="button" value="삭제하기" id="button" onclick="confirmDelete('${dto.board_bno}' , '${pageNum }')">
						</c:if>
							<input type="button" value="목록으로" id="button" onclick="location.href='Announcement.bo?pageNum=${pageNum}'">
						</div>	
					</div>
			</form>
			
     		</div>     
					
		<script type="text/javascript">
			function confirmDelete(boardBno, pageNum) {
		        var confirmation = confirm("정말로 삭제하시겠습니까?");
		        if (confirmation) {
		            location.href = 'AnnouncementDeleteAction.bo?board_bno=' + boardBno + '&pageNum=' + encodeURIComponent(pageNum);
		        } else {
		            // 사용자가 취소한 경우에 대한 처리 (optional)
		        }
		    }
		</script>	
</body>
</html>