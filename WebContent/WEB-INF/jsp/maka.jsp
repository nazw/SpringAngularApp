 
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<body>
    <h2>Here is a simple CRUD using Spring MVC and MongoDB.</h2>
 
        <form action="announcement/save.html" method="post">
            <input type="hidden" name="id">
            <label for="title">Title</label>
            <input type="text" id="title" name="title"/>
              <label for="body">body</label>
            <input type="text" id="body" name="body"/>
            <input type="submit" value="Submit"/>
        </form>
 

 
    <table border="1">
        <c:forEach var="announcement" items="${announcementList}">
         <c:set var="now" value="${announcement.expirydate}" />
            <tr>
                <td>${announcement.id}</td>
                <td>${announcement.title}</td>
                <td>${announcement.body}</td>
                <td><fmt:formatDate pattern="yyyy-MM-dd" value="${now}" /></td>
                                          
                
                <td><input type="button" value="delete" onclick="window.location='announcement/delete.html?id=${announcement.id}'"/></td>
            </tr>
        </c:forEach>
    </table> 
</body>
</html>