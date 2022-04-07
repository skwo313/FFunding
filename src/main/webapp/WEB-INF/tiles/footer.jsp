<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${not empty member.mid}">
	<button class="chatbox-open">
		<i class="fa fa-comment fa-2x"></i>
	</button>
	<div class="chat-box" style="dispaly: none;">
		<div class="chat-box-header">
			<span>고객 센터</span>
			<button class="chatbox-close">
				<i class="fa fa-window-close" aria-hidden="true" id="chat-close"></i>
			</button>
		</div>

		<div class="chat-box-body">
			<div class="chat-box-overlay"></div>
			<div class="chat-logs"  style="overflow:auto;"></div>
		</div>
		<div class="chat-input">
			<input type="text" id="chat-input" placeholder="Send a message..." />
			<button type="submit" class="chat-submit" id="chat-submit">
				<i class="material-icons">send</i>
			</button>
		</div>
	</div>
</c:if>
<footer id="footer">
	<div class="footer-top">
		<div class="container">
			<div class="row">
				<div class="col-lg-3 col-md-6 footer-info">
					<h3>FFunding</h3>
					<p></p>
				</div>

				<div class="col-lg-3 col-md-6 footer-links">
					<h4>Useful Links</h4>
					<ul>
						<li><a href="#">Home</a></li>
						<li><a href="#">About us</a></li>
						<li><a href="#">Services</a></li>
						<li><a href="#">Terms of service</a></li>
						<li><a href="#">Privacy policy</a></li>
					</ul>
				</div>

				<div class="col-lg-3 col-md-6 footer-contact">
					<h4>Contact Us</h4>
					<p>
						A108 Adam Street <br /> New York, NY 535022<br /> United States <br /> <strong>Phone:</strong> +1 5589 55488 55<br /> <strong>Email:</strong> info@example.com<br />
					</p>

					<div class="social-links">
						<a href="#" class="twitter"><i class="bi bi-twitter"></i></a> <a href="#" class="facebook"><i class="bi bi-facebook"></i></a> <a href="#" class="instagram"><i class="bi bi-instagram"></i></a> <a href="#" class="linkedin"><i class="bi bi-linkedin"></i></a>
					</div>
				</div>

				<div class="col-lg-3 col-md-6 footer-newsletter">
					<h4>Our Newsletter</h4>
					<p>Tamen quem nulla quae legam multos aute sint culpa legam noster magna veniam enim veniam illum dolore legam minim quorum culpa amet magna export quem marada parida nodela caramase seza.</p>
					<form action="" method="post">
						<input type="email" name="email" />
						<input type="submit" value="Subscribe" />
					</form>
				</div>
			</div>
		</div>
	</div>

	<div class="container">
		<div class="copyright">
			&copy; Copyright <strong><span>Serenity</span></strong>. All Rights Reserved
		</div>
		<div class="credits">
			<!-- All the links in the footer should remain intact. -->
			<!-- You can delete the links only if you purchased the pro version. -->
			<!-- Licensing information: https://bootstrapmade.com/license/ -->
			<!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/serenity-bootstrap-corporate-template/ -->
			Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
		</div>
	</div>
</footer>

<script type="text/javascript">
	$(function() {

	});
</script>
