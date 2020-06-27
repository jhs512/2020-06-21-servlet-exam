<%@ page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	Map<String, Object> articleRow = (Map<String, Object>) request.getAttribute("articleRow");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=">
<title>장희성 개발자 블로그 - <%=articleRow.get("title")%></title>

<!-- 구글 폰트 불러오기 -->
<!-- rotobo(400/900), notosanskr(400/900) -->
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;900&family=Roboto:wght@400;900&display=swap"
	rel="stylesheet">

<!-- 폰트어썸 불러오기 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.1/css/all.min.css">

<!-- 제이쿼리 불러오기 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- 뷰어 관련 라이브러리 시작 -->
<!-- 하이라이트 라이브러리 추가, 토스트 UI 에디터에서 사용됨 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.1.1/highlight.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.1.1/styles/default.min.css">

<!-- 하이라이트 라이브러리, 언어 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.1.1/languages/css.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.1.1/languages/javascript.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.1.1/languages/java.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.1.1/languages/xml.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.1.1/languages/php.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.1.1/languages/php-template.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.1.1/languages/sql.min.js"></script>

<!-- 코드 미러 라이브러리 추가, 토스트 UI 에디터에서 사용됨 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.min.css" />

<!-- 토스트 UI 에디터, 자바스크립트 코어 -->
<script
	src="https://uicdn.toast.com/editor/latest/toastui-editor-viewer.min.js"></script>

<!-- 토스트 UI 에디터, 신택스 하이라이트 플러그인 추가 -->
<script
	src="https://uicdn.toast.com/editor-plugin-code-syntax-highlight/latest/toastui-editor-plugin-code-syntax-highlight-all.min.js"></script>

<!-- 토스트 UI 에디터, CSS 코어 -->
<link rel="stylesheet"
	href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<!-- 뷰어 관련 라이브러리 끝 -->

<style>
html {
	/* 영문이면 roboto가 적용되고, 한글이면 Noto Sans KR가 적용되도록 아래와 같은 순서로 배치 */
	font-family: "Roboto", "Noto Sans KR", sans-serif;
}

/* 노말라이즈 */
body, ul, li, h1 {
	margin: 0;
	padding: 0;
	list-style: none;
}

a {
	color: inherit;
	text-decoration: none;
}

label[for] {
	cursor: pointer;
	user-select: none;
}

/* 라이브러리 */
.block {
	display: block;
}

.inline-block {
	display: inline-block;
}

.absolute-left {
	position: absolute;
	left: 0;
}

.absolute-right {
	position: absolute;
	right: 0;
}

.absolute-bottom {
	position: absolute;
	bottom: 0;
}

.absolute-top {
	position: absolute;
	top: 0;
}

.absolute-center {
	position: absolute;
	left: 50%;
	transform: translateX(-50%);
}

.absolute-middle {
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
}

.absolute-middle.absolute-center {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translateX(-50%) translateY(-50%);
}

.relative {
	position: relative;
}

.cell {
	float: left;
	box-sizing: border-box;
}

.cell-right {
	float: right;
	box-sizing: border-box;
}

.row::after {
	content: "";
	display: block;
	clear: both;
}

.clear-both {
	clear: both;
}

.img-box>img {
	width: 100%;
	display: block;
}

.con {
	margin-left: auto;
	margin-right: auto;
}

.margin-0-auto {
	margin-left: auto;
	margin-right: auto;
}

.text-align-center {
	text-align: center;
}

.text-align-right {
	text-align: right;
}

.line-height-0 {
	line-height: 0;
}

.line-height-0>* {
	line-height: normal;
}

.width-30px {
	width: 30px;
}

.width-35px {
	width: 35px;
}

.width-40px {
	width: 35px;
}

.width-45px {
	width: 35px;
}

.width-50px {
	width: 50px;
}

.width-80px {
	width: 80px;
}

.width-100px {
	width: 100px;
}

.width-100p {
	width: 100%;
}

.width-60p {
	width: 60%;
}

.width-55p {
	width: 55%;
}

.width-50p {
	width: 50%;
}

.width-45p {
	width: 45%;
}

.width-40p {
	width: 40%;
}

.width-30p {
	width: 30%;
}

.width-35p {
	width: 35%;
}

.width-100p-except-30px {
	width: calc(100% - 30px);
}

.width-100p-except-35px {
	width: calc(100% - 35px);
}

.width-100p-except-40px {
	width: calc(100% - 40px);
}

.width-100p-except-50px {
	width: calc(100% - 50px);
}

.width-100p-except-80px {
	width: calc(100% - 80px);
}

.width-100p-except-100px {
	width: calc(100% - 100px);
}

.height-100p {
	height: 100%;
}

.height-50p {
	height: 50%;
}

.border-box {
	box-sizing: border-box;
}

.font-size-dot-8rem {
	font-size: .8rem;
}

.table-row {
	display: table;
}

.table-row.row::after {
	display: inline;
	clear: non;
}

.table-row>.cell {
	float: none;
	display: table-cell;
}

.border-red {
	border: 10px solid red;
}

.border-green {
	border: 10px solid green;
}

.border-blue {
	border: 10px solid blue;
}

.border-gold {
	border: 10px solid gold;
}

.border-pink {
	border: 10px solid pink;
}

/* 라이브러리 - flex */
*>.flex {
	display: flex;
}

*>.flex-grow-1 {
	flex-grow: 1;
}

*>.flex-jc-s {
	justify-content: flex-start;
}

*>.flex-jc-e {
	justify-content: flex-end;
}

*>.flex-jc-sb {
	justify-content: space-between;
}

*>.flex-ai-c {
	align-items: center;
}

*>.flex-ai-s {
	align-items: flex-start;
}

*>.flex-ai-e {
	align-items: flex-end;
}

*>.flex-as-s {
	align-self: stretch;
}

*>.flex-as-c {
	align-self: center;
}

*>.flex-as-s {
	align-self: flex-start;
}

*>.flex-as-e {
	align-self: flex-end;
}

*>.flex-column-nowrap {
	flex-flow: column nowrap;
}

*>.flex-column-wrap {
	flex-flow: column wrap;
}

.flex-ch-basis-0>* {
	flex-basis: 0;
}

*>.flex-1-0-0 {
	flex: 1 0 0;
}

/* 커스텀 */
.con-min-width {
	min-width: 1356px;
}

.con {
	width: 1356px;
}

.table-box>table {
	width: 100%;
	border-collapse: collapse;
}

.table-box>table td, .table-box>table th {
	border: 1px solid black;
	padding: 10px;
}
</style>

</head>
<body>
	<h1 class="con">장희성 개발자 블로그</h1>
	<h2 class="con">게시물 상세페이지</h2>
	<h3 class="con"><%=articleRow.get("title")%></h3>
	<div class="con"></div>
	<div class="table-box con">
		<table>
			<colgroup>
				<col width="200">
			</colgroup>
			<tbody>
				<tr>
					<th>번호</th>
					<td><%=articleRow.get("id")%></td>
				</tr>
				<tr>
					<th>작성날짜</th>
					<td><%=articleRow.get("regDate")%></td>
				</tr>
				<tr>
					<th>수정날짜</th>
					<td><%=articleRow.get("updateDate")%></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>장희성</td>
				</tr>
				<tr>
					<th>비고</th>
					<td>
						<a href="#" onclick="history.back(); return false;">뒤로가기</a>
						<a href="list">리스트</a>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="con" style="display: none;" id="origin1"><%=articleRow.get("body")%></div>
						<div class="con" id="viewer1"></div> <script>
							var editor1__initialValue = $('#origin1').html();
							var editor1 = new toastui.Editor(
									{
										el : document.querySelector('#viewer1'),
										height : '600px',
										initialValue : editor1__initialValue,
										viewer : true,
										plugins : [ toastui.Editor.plugin.codeSyntaxHighlight ]
									});
						</script>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>



