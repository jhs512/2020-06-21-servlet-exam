<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	List<Map<String, Object>> articleRows = (List<Map<String, Object>>) request.getAttribute("articleRows");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=">
<title>장희성 개발자 블로그 - 게시물 리스트</title>

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
	<h2 class="con">게시물 리스트</h2>
	<div class="con"></div>
	<div class="table-box con">
		<table>
			<colgroup>
				<col width="150">
				<col width="250">
				<col width="250">
				<col width="200">
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>작성날짜</th>
					<th>수정날짜</th>
					<th>작성자</th>
					<th>제목</th>
				</tr>
			</thead>
			<tbody>
				<%
					for (Map<String, Object> articleRow : articleRows) {
				%>
				<tr>
					<td><%=articleRow.get("id")%></td>
					<td><%=articleRow.get("regDate")%></td>
					<td><%=articleRow.get("updateDate")%></td>
					<td>장희성</td>
					<td><a href="./detail?id=<%=articleRow.get("id")%>"><%=articleRow.get("title")%></a></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
	</div>
</body>
</html>



