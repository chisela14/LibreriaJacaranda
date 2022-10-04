<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.jacaranda.articles.BookException"%>
<%@page import="com.jacaranda.articles.DaoBook"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Añadir Libro</title>
</head>
<body>

<% 
	HttpSession se = request.getSession();
	String isSession = (String) session.getAttribute("login");
	String userSession = (String) session.getAttribute("user");
	if(isSession != null && userSession !=null && isSession.equals("True")){
	
		String empty = "";
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
									
		String newIsbn = request.getParameter("isbn");
		String newTitle = request.getParameter("title");
		String newAuthor = request.getParameter("author");
		String newPublished_date = request.getParameter("published_date");
		int newQuantity = Integer.parseInt(request.getParameter("quantity"));
		double newPrice = Double.parseDouble(request.getParameter("price"));
		
		
		if(newIsbn == null || empty.equals(newIsbn) || newTitle == null || empty.equals(newTitle) || newAuthor == null || empty.equals(newAuthor) ||
		newPublished_date == null || empty.equals(newPublished_date) || newQuantity < 0 || newPrice < 0){%>
			<jsp:forward
				page="error.jsp?msg='Los campos no son correctos.'"></jsp:forward>
		<% } else {
			LocalDate date = LocalDate.parse(newPublished_date, formatter);
			
			DaoBook newDaoBook = new DaoBook();
			
			try {
				newDaoBook.addBook(newIsbn, newTitle, newAuthor, date, newQuantity, newPrice);%>
				<jsp:forward
				page="bookPage.jsp"></jsp:forward>
				
			<%} catch (BookException | SQLException e){%>
				<jsp:forward
				page="error.jsp?msg='No se ha podido agregar el libro.'"></jsp:forward>
			<%}
			
		}

	} else {%>
	<jsp:forward
		page="error.jsp?msg='Debes iniciar sesión para realizar cualquier cambio.'"></jsp:forward>
	<%}%>


</body>
</html>