var header = ''+
	'<header>'+
		'<h1>Fabulous Restaurant</h1>'+
	'</header>'+
	'<div id="callout"></div>';

var callout = ''+
	'<div class="content">'+
		'<h2>Where sophisticated taste meets exquisite atmosphere</h2>'+
		'<p>Explore our rich flavors and diverse cuisines brought to you by the finest chefs who combine expert techniques with unique flair.</p>'+
	'</div>';

var nav = ''+
	'<ul id="nav">'+
		'<li class="menu active">Menu</li>'+
		'<li class="contact">Contact</li>'+
		'<li class="about">About Us</li>'+
	'</ul>'+
	'<div id="nav-content">'+
		'<p></p>'+
	'</div>';

var menu = ''+
	'<table>'+
		'<thead>'+
			'<tr>'+
				'<th scope="col" colspan="2">Item</th>'+
				'<th scope="col">Price</th>'+
			'</tr>'+
		'</thead>'+
		'<tbody>'+
			'<tr>'+
				'<td>Burger and Fries</td>'+
				'<td>8oz Kobe beef with large-cut fries</td>'+
				'<td>$112</td>'+
			'</tr>'+

			'<tr>'+
				'<td>Spaghetti with Meatballs</td>'+
				'<td>House made marinara with house-made linquini</td>'+
				'<td>$87</td>'+
			'</tr>'+

			'<tr>'+
				'<td>Calamari</td>'+
				'<td>Freshly caught and local</td>'+
				'<td>$58</td>'+
			'</tr>'+

			'<tr>'+
				'<td>Fish Tacos</td>'+
				'<td>Fried cod in house-made mango salsa</td>'+
				'<td>$42</td>'+
			'</tr>'+
		'</tbody>'+
	'</table>';
var contact = ''+
	'<h2>Phone</h2>'+
	'<p>800.555.1234</p>'+
	'<h2>Location</h2>'+
	'<p>1234 Main St<br/>San Francisco, CA</p>'+
	'<h2>Email</h2>'+
	'<p>info@fabulousrestaurant.com</p>';

var about = ''+
	'<h2>Finest Foods, Finest Chefs</h2>'+
	'<p>Locally grown, locally caught, we source the finest foods for your dining pleasure. </p>'+
	'<p>We\'ve cultivated a dining experience that will exceed your expectations. Our chefs have graduated the finest culinary schools from around the world and our flair for unique presentation will astound you.</p>'+
	'<p>Make your reservations early, we usually book 2.5 years out. Trust us, the wait is worth it.</p>';

var footer = ''+
	'<footer>'+
		'<ul>'+
			'<li>fabulous restaurant</li>'+
			'<li>made by <a href="http://katemcfaul.com">katemcfaul.com</a></li>'+
		'</ul>'+
	'</footer>';

// Display elements
$(document).ready(function() {
	$('body').prepend(header);
	$('#callout').css('background-image', 'url(./img/restaurant.jpg)');
	$('#callout').html(callout);
	$('#content').append(nav);
	$('#nav-content').html(menu);
	$('body').append(footer);

	tabClick(".menu", menu, "menu");
	tabClick(".contact", contact, "contact");
	tabClick(".about", about, "about");

	function tabClick(tab, content, tabClass) {
		$(tab).click(function() {
			$("#nav-content").html(content);
			$("#nav-content").removeClass();
			$("#nav-content").addClass(tabClass);
			$("#nav").children("li").removeClass("active");
			$(this).addClass("active");
		});
	}
});