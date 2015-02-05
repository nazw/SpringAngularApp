<!DOCTYPE html>
<html data-ng-app="formSubmit">
<head>
<meta>
	<title>Summer PLC Announcements</title>
	
	<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.3.8/angular.min.js"></script>
	<link href="lib/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href='http://fonts.googleapis.com/css?family=Nixie+One' rel='stylesheet' type='text/css'>
	<link href="lib/fontello/css/fontello.css" rel="stylesheet">
	<link href="lib/fontello/css/animation.css" rel="stylesheet">
	<link href="lib/bootstrap/css/appStyle.css" rel="stylesheet" />
	<link href="css/annStyle.css" rel="stylesheet" />
	<style type="text/css">
	.odd{
		background-color: #A9A9A9;
	}
	.even{
		background-color: #F8F8FF;
	}
	.view-alignment{margin-left: 270px;}
	.add-announcement{margin-left: 270px;}
	.button-color{background-color: #A9A9A9;}
	</style>
<script type="text/javascript">
var app = angular.module('formSubmit', []);

app.controller('FormSubmitController',[ '$scope', '$http', function($scope, $http) {
	
		$scope.list = [];			
		$scope.isVisibleAddForm = false;
		$scope.isVisibleView = false;
		$scope.isVisibleList = true;
		$scope.isVisibleMsg = false;
		
		$scope.submit = function() {
			$scope.isVisibleAddForm = false;
			var formData = {
					"title" : $scope.announcement.title,
					"body" : $scope.announcement.body,
					"expirydate" : $scope.announcement.expirydate
			};				
			var response = $http.post('postAnnouncementFormData', formData);
			response.success(function(data, status, headers, config) {
				$scope.list.push(data);
				$scope.viewData = data;
				$scope.isVisibleMsg = true;
			});
			response.error(function(data, status, headers, config) {
				alert( "Exception details: " + JSON.stringify({data: data}));
			});		
			$scope.list = [];
			$scope.isVisibleView = true;
			$scope.announcement.title = '';
			$scope.announcement.body = '';
			$scope.announcement.expirydate = '';
		};			
		
		$scope.getAnnouncements = function() {	    	
	    	$http({method: 'GET', url: 'announcements'}).
	        success(function(data, status, headers, config) {
	        	$scope.announcements = data;
	        }).
	        error(function(data, status, headers, config) {
	       
	        });	
	    	$scope.isVisibleAddForm = false;
			$scope.isVisibleView = false;
			$scope.isVisibleList = true;
			$scope.isVisibleMsg = false;
	    };
	    
	    $scope.getAnnouncementById = function(id) {	
	    	$scope.isVisibleAddForm = true;
	    	$scope.isVisibleList = false;
	    	var formData = {
					"announcementId" : id						
			};				
	    	var response = $http.post('announcement', formData);
	    	response.success(function(data, status, headers, config) {
	        	$scope.announcement = data;
	        }).
	        response.error(function(data, status, headers, config) {
	         
	        });	
	    	$scope.isVisibleMsg = false;
	    };
	 
	    $scope.getDeleteAnnouncement = function(oneannouncement) {		    	
	    	var formDeleteData = {
					"announcement" : oneannouncement						
			};		    	
	    	var response = $http.post('deleteAnnouncement', formDeleteData);
	    	response.success(function(data, status, headers, config) {
	    		
	        }).
	        response.error(function(data, status, headers, config) {
	         
	        });
	    	$scope.isVisibleList = true;
			$scope.isVisibleMsg = true;
	    };
	    
	    $scope.getViewById = function(id) {	
	    	$scope.isVisibleView = true;
	    	$scope.isVisibleList = false;
	    	var formData = {
					"announcementId" : id						
			};				
	    	var response = $http.post('announcement', formData);
	    	response.success(function(data, status, headers, config) {
	        	$scope.viewData = data;
	        }).
	        response.error(function(data, status, headers, config) {
	         
	        });		    
	    };
	    
	    $scope.getDataForm = function() {	
	    	$scope.isVisibleAddForm = true;
			$scope.isVisibleView = false;
			$scope.isVisibleList = false;
			$scope.isVisibleMsg = false;		    	    
	    };
	    
	}]);
	
	</script>
	</head>
	<body>

		<div data-ng-app="formSubmit">
			<div data-ng-controller="FormSubmitController">

				<div class="view-alignment" ng-show="isVisibleMsg" ng-animate="'box'"><p>Your operation has been successfully completed! </p>	</div>
				<div class="add-announcement"><button data-ng-click="getDataForm()" class="button-color">Add New Announcement</button>
				<button data-ng-click="getAnnouncements()" class="button-color">List All Announcements</button>
				</div>
				
				<div class="box on" ng-show="isVisibleList" ng-animate="'box'">	
				<h3 align="center">List of Announcements</h3>
					<div data-ng-init="getAnnouncements()">
					<table class="view-alignment">
					<tr><th width="600px">Title of Announcements</th><th>View</th><th>Edit</th><th>Delete</th></tr>
					<tr ng-repeat="oneannouncement in announcements"
						ng-class-even="'even'"
						ng-class-odd="'odd'">
					<td>{{oneannouncement.title}}</td>
						<td><button data-ng-click="getViewById(oneannouncement.id)" class="button-color">view</button></td>
					<td><button data-ng-click="getAnnouncementById(oneannouncement.id)" class="button-color">Edit</button></td>
					<td><button data-ng-click="getDeleteAnnouncement(oneannouncement)" class="button-color">Delete</button></td></tr>	
					</table>
					</div>	
				</div>	
					
				<div class="box on" ng-show="isVisibleAddForm" ng-animate="'box'">	
					<form data-ng-submit="submit()">
						<h3 align="center">Announcement Details</h3>
						<table class="view-alignment">
						<tr><td>Announcement Title</td><td><input type="text" data-ng-model="announcement.title" ></td></tr>
						<tr><td>Announcement Description</td><td>
						<textarea rows="10" cols="40" data-ng-model="announcement.body"></textarea>
						<tr><td>Announcement Expiry Date</td><td><input type="text" data-ng-model="announcement.expirydate" ></td></tr>
						<tr><td></td><td><input type="submit" id="submit" value="Submit" /></td></tr>
						</table>		
					</form>
				</div>
				
				<div class="box on" ng-show="isVisibleView" ng-animate="'box'">
					<h3 align="center">View Announcement Details</h3>
					<ul class="view-alignment">
					<li>Announcement Title : {{viewData.title}}</li>
					<li>Announcement Description : {{viewData.body}}</li>
					<li>Announcement Start Date: {{viewData.startDate}}</li>
					<li>Announcement Expiry Date: {{viewData.expirydate}}</li>
					</ul>
				</div>
	
	
			</div>
		</div>
	
	</body>
</html>