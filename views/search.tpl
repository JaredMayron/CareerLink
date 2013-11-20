<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Search Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link href="bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="bootstrap-tagsinput/bootstrap-tagsinput.css" rel="stylesheet">
    <style>
      body {
        padding-top: 70px; /* 60px to make the container go all the way to the bottom of the topbar */
      }
      .search {
      	padding-bottom: 20px;
      }
      .card-title {
      	font-size:28px;
      	font-weight:500;
      }
    </style>

  </head>

  <body>

<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
        </div>
        <div class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li><a href="home">Home</a></li>
              <li><a href="profile">Profile</a></li>
              <li class="active"><a href="search">Search</a></li>
              <li><a href="events">Events</a></li>
              <li><a href="careerFair">Career Fair</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>

    <div id="main" class="container">
		<div class="row search">
    		<form role="form">
    		    <div class="input-group">
					<input type="text" class="form-control input-sm" placeholder="Search here!">
    		        <span class="input-group-btn">
        		        <button class="btn btn-default btn-sm" type="submit"><span class="glyphicon glyphicon-search"></span></button>
    			    </span>
      			 </div>
  		  </form>
		</div>
		
		<div id="template" class="hidden">
			<div class='panel panel-default'>
    <div class='panel-heading'>
    	<div class='row'>
    		<div class='col-md-8'>
    			<span class='card-title'></span>
    		</div>
    		<div class='col-md-4'>
    			<div class='pull-right'><button type='button' class='btn btn-lg btn-success'>Apply Now!</button></div>
    		</div>
    	</div>
    </div>
  	<div class='panel-body'>
  		<div class='row'>
  			<div class='col-md-8 text'>
    		</div>
    		<div class='col-md-2'>
    			<ul class='list-group'>
  					<li class='list-group-item'><strong>Posted: </strong><span class='label label-default pull-right posted'></span></li>
  					<a class='list-group-item positions'>
  						   <strong class='list-group-item-heading'>Positions</strong>
    				</a>
  						
				</ul>

			</div>
    		<div class='col-md-2'>
					<ul class='list-group'>
    					<li class='list-group-item'><strong>Due: </strong><span class='label label-danger pull-right due'></span></li>
    					<a class='list-group-item locations'>
  						    <strong class='list-group-item-heading'>Locations</strong>
    					</a>
					</ul>
    				</div>

    	</div>
  	</div>
  	<div class='panel-footer'>
  		<div class='container'>
  		<select multiple data-role="tagsinput" class="tags" placeholder="Insert your tags here!"></select>
  		</div>
  	</div>
</div>
		</div>

    <script type="text/javascript" src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
    <script type="text/javascript" src="bootstrap-tagsinput/bootstrap-tagsinput.js"></script>
    
	<script>
    function renderElement(elements){
		if(elements == null){return;}
		var id = elements.name.replace(/ /g,'');
		$('<div/>', {'id':id}).appendTo("#main");
		$("#"+id).prepend($("#template").html());
		
		$('#'+id+' .card-title').text(elements.name);
		$('#'+id+' .text').text(elements.text);
		$('#'+id+' .posted').text(elements.posted);
		$('#'+id+' .due').text(elements.due);
		var i=0,posistion;
		while(position = elements.positions[i++]){
			$('#'+id+' .positions').append("<br><small class='list-group-item-text'>"+position+"</small>")
		}
		
		var location;i=0;
		while(location = elements.locations[i++]){
			$('#'+id+' .locations').append("<br><small class='list-group-item-text'>"+location+"</small>")
		}
		
		var tag;i=0;
		while(tag = elements.tags[i++]){
			$('#'+id+' .tags').append("<option value='"+tag+"'>"+tag+"</option>")
		}
		
	}
		
	function GetSampleJobs() {
		var data_file = "http://students.cec.wustl.edu/~morane/CareerLink/CareerLink/testJobs.json";
		var http_request = new XMLHttpRequest();
		try{
			// Opera 8.0+, Firefox, Chrome, Safari
			http_request = new XMLHttpRequest();
		} catch (e) {
			// Internet Explorer Browsers
			try {
				http_request = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				try {
						http_request = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (e){
					// Something went wrong
					alert("Your browser broke!");
					return false;
				}
			}
		}
		http_request.onreadystatechange  = function(){
		    if (http_request.readyState == 4  )
		    {
				var jsonObj = JSON.parse(http_request.responseText);
				for(var i = 0; i < jsonObj.jobs.length; i++) {
					renderElement(jsonObj.jobs[i]);
				}
			}
		}
		http_request.open("GET", data_file, true);
		http_request.send();
	}

   document.addEventListener("DOMContentLoaded", GetSampleJobs, false);

    </script>
    
  </body>
</html>
