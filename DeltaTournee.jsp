<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
           <%@ page import="java.sql.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

<head>
  	<title>DeltaTournée Authentification</title>
  	<meta name="description" content="Demo of a Sliding Login Panel using jQuery 1.3.2" />
  	<meta name="keywords" content="jquery, sliding, toggle, slideUp, slideDown, login, login form, register" />
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />	

	<!-- stylesheets -->
  	<link rel="stylesheet" href="css/slide.css" type="text/css" media="screen" />
	
  
	 
    <!-- jQuery - the core -->
	<script src="js/jquery-1.3.2.min.js" type="text/javascript"></script>
	<!-- Sliding effect -->
	<script src="js/slide.js" type="text/javascript"></script>


<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
        <meta name="description" content="3D Gallery with CSS3 and jQuery" />
        <meta name="keywords" content="3d, gallery, jquery, css3, auto, slideshow, navigate, mouse scroll, perspective" />
        <meta name="author" content="Codrops" />
        <link rel="stylesheet" type="text/css" href="3DGallery/css/style.css" />
		<script type="text/javascript" src="3DGallery/js/modernizr.custom.53451.js"></script>
		
		<link rel="stylesheet" href="css/styles.css" media="screen">
		
		
		
</head>

<body >
<jsp:useBean id="connectionc" class="JSF.DB_Connection" scope="page">
    <jsp:setProperty name="connectionc" property="*"/>
</jsp:useBean> 

<jsp:useBean id="connectiont" class="JSF.DB_ConnectionTournee" scope="page">
    <jsp:setProperty name="connectiont" property="*"/>
</jsp:useBean> 

<% 

Connection conc=null;
conc=connectionc.getConn();

Connection cont=null;
cont=connectiont.getConn();

int a=0;
	String idadmin=null;
	String h=null;
	String login=null;
	String motdepasse=null;
	String offset = null;
	
	h=request.getParameter("h");

	if(h!=null)
	{
		login = request.getParameter("username");
		motdepasse= request.getParameter("passwd");
		offset=request.getParameter("offset1");
		if(login!="" && motdepasse!="")
		{
			
 			Statement stmt=null;
 			ResultSet rs=null;
 			
 			try
 			{
 	    		
 				             
                        
 				stmt = cont.createStatement();
 				rs=stmt.executeQuery("select * from user where login ='" + login + "' and pwd ='" + motdepasse + "'");
 				while(rs.next())
 				{
 					a=1;
 					String id=rs.getString("iduser");
 					String log=rs.getString("login");
 					String mdp=rs.getString("pwd");
 					String nom=rs.getString("nom");
 					String role=rs.getString("role");
 					
 					session.setAttribute("id",id);
 					session.setAttribute("login",log);
					session.setAttribute("password",mdp);
					session.setAttribute("nom",nom);
					session.setAttribute("role",role);
					session.setAttribute("timezone",offset);
					
					DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                             Date date = new Date();
                                       
					Statement st=cont.createStatement();
                                       st.execute("insert into historique (date,action,nomuser) values ('"+dateFormat.format(date)+"','Connection','"+session.getAttribute("nom")+"')");
					
						response.sendRedirect("gestionTournee.jsp");
				
 					break;
 					
 				}
 				
 				rs.close();
 				stmt.close();
 				cont.close(); 
 	     	} 
 	     	catch(Exception e)
 	        {
 	     		out.println("Connection ratée: "+e);
 	     		System.out.println(e);
 	     	}	
 	     	
 	}
 
 	
 }
	
%>



                     
<!-- Panel -->
				<img src="images/object1406027747.png" />

<div id="toppanel">
	<div id="panel">
		<div class="content clearfix">
			<div class="left">
				<h1>Bienvenu à DeltaTournée</h1>
				</div>
			<div class="left">
				<!-- Login Form -->
				<form class="clearfix" action="" method="post" name="login" id="login"  onsubmit="javascript:return validate();">
					<h1>Login</h1>
					<label class="grey" for="log">Username:</label>
					<input class="field" type="text" name="username" id="log" value="" size="23" style="color:white" />
					<label class="grey" for="pwd">Password:</label>
					<input class="field" type="password" name="passwd" id="pwd" size="23" />
					        <input type="hidden" name="h" value="1">
   <input type="hidden" id="offset1" name="offset1"/>


						<script type="text/javascript"
							src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>

						<script type="text/javascript">
							function get_time_zone_offset() {
								var current_date = new Date();
								var gmt_offset = current_date
										.getTimezoneOffset() / 60;

								return "GMT+" + (gmt_offset * -1);

							}

							$('#offset1').val(get_time_zone_offset());
						</script>

						<div class="clear"></div>
					<input type="submit" name="submit" value="Login" class="bt_register" />
				</form>
			</div>
			
		</div>
</div> <!-- /login -->	

	<!-- The tab on top -->	
	<div class="tab">
		<ul class="login">
			<li class="left">&nbsp;</li>
			<li><% if(session.getAttribute("login")!=null){%>Bonjour <%=session.getAttribute("nom") %><%} %></li>
			<li class="sep">|</li>
			<li id="toggle">
				<a id="open" class="open" href="#">Connexion</a>
				<a id="close" style="display: none;" class="close" href="#">Annuler</a>			
			</li>
			<li class="right">&nbsp;</li>
		</ul> 
	</div> <!-- / top -->
	
</div> <!--panel -->

    <!-- container -->
    <br></br> <br></br>  <br></br> <br></br> 
    
    <div class="container">
			<!-- Codrops top bar -->
            
			<section id="dg-container" class="dg-container">
				<div class="dg-wrapper">
					<a href="#"><img src="3DGallery/images/GESTIONTOURNEE.jpg" alt="image01"><div >Géstion tournée</div></a>
					<a href="#"><img src="3DGallery/images/MAPS.jpg" alt="image02"><div>Itinéraires</div></a>
					<a href="#"><img src="3DGallery/images/resizedImage_poetrpuSdbWu3168.jpg" alt="image03"><div>Gestion Livreurs</div></a>
			        <a href="#"><img src="3DGallery/images/livraison.png" alt="image04"><div>Gestions Livraisons</div></a>
			        <a href="#"><img src="3DGallery/images/gestionvehicules.jpg" alt="image05"><div>Gestions Véhicules</div></a>
			       <a href="#"><img src="3DGallery/images/gestioncontacts.jpg" alt="image06"><div>Gestions Contacts</div></a>
			        
					
				</div>
				
				<!--nav>	
					<span class="dg-prev">&lt;</span>
					<span class="dg-next">&gt;</span>
				</nav-->
			</section>
        </div>
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
		<script type="text/javascript" src="3DGallery/js/jquery.gallery.js"></script>
		<script type="text/javascript">
			$(function() {
				$('#dg-container').gallery({
					autoplay	:	true
				});
			});
</script>  


<header class="art-header">


    <div class="art-shapes">
<div class="art-object1406027747" data-left="0.13%"></div>
<div class="art-object2004227567" data-left="59.02%"></div>

   </div>
    




                        <div id="art-flash-area">
                    <div id="art-flash-container">
                    <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="1920" height="544" id="art-flash-object">
                        <param name="movie" value="images/flash.swf"/>
                        <param name="quality" value="best"/>
                    	<param name="scale" value="exactfit"/>
                    	<param name="wmode" value="transparent"/>
                    	<param name="flashvars" value="color1=0xFFFFFF&amp;alpha1=1&amp;framerate1=24&amp;loop=true&amp;wmode=transparent"/>
                        <param name="swfliveconnect" value="true"/>
                        <!--[if !IE]>-->
                        <object type="application/x-shockwave-flash" data="images/flash.swf" width="1920" height="544">
                            <param name="quality" value="best"/>
                    	    <param name="scale" value="exactfit"/>
                            <param name="wmode" value="transparent"/>
                                                    	    <param name="flashvars" value="color1=0xFFFFFF&amp;alpha1=1&amp;framerate1=24&amp;loop=true&amp;wmode=transparent"/>
                            <param name="swfliveconnect" value="true"/>
                        <!--<![endif]-->
                          	<div class="art-flash-alt"><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player"/></a></div>
                        <!--[if !IE]>-->
                        </object>
                        <!--<![endif]-->
                    </object>
                    </div>
                    </div>
<nav class="art-nav">
    <div class="art-nav-inner">
        <ul class="art-hmenu"><li><br/><br/></li></ul> 
        </div>
    </nav>
<footer class="art-footer">
  <div class="art-footer-inner">
<div class="art-content-layout">
    <div class="art-content-layout-row">
    <div class="art-layout-cell layout-item-0" style="width: 100%">
        <p style="text-align:right;">Copyright © CallSoft 2014. Tout droit réservé.</p>
    </div>
    </div>
</div>

   
  </div>
</footer>
                    
</header>
</body>
</html>
