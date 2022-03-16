<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<fmt:requestEncoding value="utf-8"/> 
<link href="${path}/css/mail.css" rel="stylesheet">   

                <!-- Begin Page Content -->
                <div id="member" class="container-fluid">

                    <!-- Page Heading -->

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Mail Service</h6>
                        </div>
                        <div class="card-body">
	                    	<div class="mailFrm">
								<table class="mailtb">
									<tr>
										<th>Title</th>
										<td><input type="text" name="title" class="form-control"/></td>									
									</tr>
									<tr>
										<th>Recipient</th>
										<td>
											<div class="recipient">
											<input type="text" name="recipient" class="form-control"/>
											<div>
											<label for="self" class="relabel">Self</label>
											<input type="radio" name="recipientck" id="self" class="reradio" value="0"/>
											<label for="all" class="relabel">All</label>
											<input type="radio" name="recipientck" id="all" class="reradio" value="1"/>
											<label for="seller" class="relabel">Seller</label>
											<input type="radio" name="recipientck" id="seller" class="reradio" value="2"/>
											</div>
											</div>
										</td>
																		
									</tr>
									<tr>
										<th>Content</th>
										<td><textarea  name="content" rows="20" class="form-control" ></textarea></td>									
									</tr>
								</table>
								<div class="btn">
									<button id="send" class="btn btn-primary">Send</button>
								</div>
	                        </div>
                        </div>
                    </div>

                </div>
                <!-- /.container-fluid -->
                
<script type="text/javascript">

</script>