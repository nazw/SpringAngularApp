<!DOCTYPE html>
<!-- Declares the root element that allows behaviour to be modified through Angular custom HTML tags. -->
<html ng-app="announcement">
<head>
    <title>javaee7-angular</title>

    <!-- build:css css/third-party.css -->
    <!-- bower:css -->
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/ng-grid.min.css" />
    <!-- endbower -->
    <!-- endbuild -->

    <!-- build:css css/application.css -->
    <link rel="stylesheet" type="text/css" href="css/style.css"/>
    <!-- endbuild -->

    <!-- build:js lib/third-party.js -->
    <!-- bower:js -->
    <script src="js/jquery.min.js"></script>
    <script src="js/angular.min.js"></script>
    <script src="js/angular-resource.min.js"></script>
    <script src="js/ng-grid-2.0.11.min.js"></script>
    <script src="js/ui-bootstrap-tpls.min.js"></script>
    <!-- endbower -->
    <!-- endbuild -->

    <!-- build:js script/all.js -->
    <script src="js/app.js"></script>
    <!-- endbuild -->
</head>

<body>

<h1>Java EE - Angular Application</h1>

<br/>

<!-- Specify a Angular controller script that binds Javascript variables to the feedback messages.-->
<div class="message" ng-controller="alertMessagesController">
    <alert ng-repeat="alert in alerts" type="{{alert.type}}" close="closeAlert($index)">{{alert.msg}}</alert>
</div>

<br>

<!-- Specify a Angular controller script that binds Javascript variables to the grid.-->
<div class="grid" ng-controller="announcementListController">
    <div>
        <h3>List announcements</h3>
    </div>

    <!-- Binds the grid component to be displayed. -->
    <div class="gridStyle" ng-grid="gridOptions"></div>

    <!--  Bind the pagination component to be displayed. -->
    <pagination direction-links="true" boundary-links="true"
                total-items="announcement.totalResults" items-per-page="announcement.pageSize"
                ng-model="announcement.currentPage" ng-change="refreshGrid()">
    </pagination>
</div>

<!-- Specify a Angular controller script that binds Javascript variables to the form.-->
<div class="form" ng-controller="announcementFormController">
    <!-- Verify person, if there is no id present, that we are Adding a Person -->
    <div ng-if="announcement.id == null">
        <h3>Add Person</h3>
    </div>
    <!-- Otherwise it's an Edit -->
    <div ng-if="announcement.id != null">
        <h3>Edit Person</h3>
    </div>

    <div>
        <!-- Specify the function to be called on submit and disable HTML5 validation, since we're using Angular validation-->
        <form name="announcementForm" ng-submit="updateAnnouncement()" novalidate>

            <!-- Display an error if the input is invalid and is dirty (only when someone changes the value) -->
            <div class="form-group" ng-class="{'has-error' : announcementForm.title.$invalid && announcementForm.title.$dirty}">
                <label for="title">title:</label>
                <!-- Display a check when the field is valid and was modified -->
                <span ng-class="{'glyphicon glyphicon-ok' : announcementForm.title.$valid && announcementForm.title.$dirty}"></span>

                <input id="title" name="title" type="text" class="form-control" maxlength="50"
                       ng-model="announcement.title"
                       required ng-minlength="2" ng-maxlength="50"/>

                <!-- Validation messages to be displayed on required, minlength and maxlength -->
                <p class="help-block" ng-show="announcementForm.title.$error.required">Add Name.</p>
                <p class="help-block" ng-show="announcementForm.title.$error.minlength">Name must be at least 2 characters long.</p>
                <p class="help-block" ng-show="announcementForm.title.$error.maxlength">Name cannot be longer than 50 characters.</p>
            </div>

            <!-- Display an error if the input is invalid and is dirty (only when someone changes the value) -->
            <div class="form-group" ng-class="{'has-error' : announcementForm.body.$invalid && announcementForm.body.$dirty}">
                <label for="body">body:</label>
                <!-- Display a check when the field is valid and was modified -->
                <span ng-class="{'glyphicon glyphicon-ok' : announcementForm.body.$valid && announcementForm.body.$dirty}"></span>

                <input id="body" name="body" type="text" class="form-control" maxlength="100"
                       ng-model="announcement.body"
                       required ng-minlength="5" ng-maxlength="100"/>

                <!-- Validation messages to be displayed on required, minlength and maxlength -->
                <p class="help-block" ng-show="announcementForm.body.$error.required">Add Description.</p>
                <p class="help-block" ng-show="announcementForm.body.$error.minlength">Description must be at least 5 characters long.</p>
                <p class="help-block" ng-show="announcementForm.body.$error.maxlength">Description cannot be longer than 100 characters.</p>
            </div>

     

            <!-- Form buttons. The 'Save' button is only enabled when the form is valid. -->
            <div class="buttons">
                <button type="button" class="btn btn-primary" ng-click="clearForm()">Clear</button>
                <button type="submit" class="btn btn-primary" ng-disabled="announcementForm.$invalid">Save</button>
            </div>
        </form>
    </div>
</div>

</body>
</html>
