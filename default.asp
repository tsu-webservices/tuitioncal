<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%> 
<% Option Explicit %>
<% Response.CacheControl = "no-cache" %>
<% Response.AddHeader "Pragma", "no-cache" %>
<% Response.Expires = -1 %>
<!--#include file="Common/Constants.asp"--><%'Variable Constants for the Page%>
<!--#include virtual="/INC/_Struct.asp" --><%'Main layout for the page%>
<!--#include virtual="/INC/User2.asp" --><%'Quick Methods Develeoped for Rapid Forms Development%>
<%

  Dim SecureL, sLevel, jQuery, mobile
  SecureL = 0 '1 means it creates a secure login. 0 Means open page (no login or can be controlled by NTNET).
  sLevel = 1' set this to -1 if the the user only needs to have NTNET login to access the app. sLevel means nothing if the SecureL is = 0.
  jQuery = 0' turns on jquery capability for forms
  mobile = 1'
  '-----------------Start Page Variables & Functions
  
  dim username, pUser
  username = Session("user")    
  
  Set pUser = New User
  
  '-----------------End Page Variables & Functions
  Call Headr_admin()  
  '-----------------beginning of module  
  %>
  <% If Session("user") <> "" or SecureL = 0 Then %>        
    
      <div id="semControl">
        
          <% If pUser.isMobile Then %><% Else %><% End If %>
        
          <h6>Student Information</h6>
        
            <div>
            
              <div id="semesterDiv" class="formControlDiv">
                  
                    <label for="semester">Semester :</label>                               
                  <% 
            Dim cmdDbConn, DbConn
            
            Set cmdDbConn = Server.CreateObject("ADODB.Command")
            With cmdDbConn
              .ActiveConnection = MM_Students_STRING              
              .CommandText = "SELECT Top(1) CHYear FROM Tcal3Cohort WHERE (CHHide = 'False') ORDER BY CHYear DESC"
              .CommandType= 1
            End With
            Set DbConn = Server.CreateObject("ADODB.Recordset")
            DbConn.CursorLocation = 3
            DbConn.Open cmdDbConn
            Set DbConn.ActiveConnection = Nothing
          %>
                    <select class="formControl" id="semester">
                      <option value="" selected></option>
                    <%  
            While  NOT dbConn.EOF 
          %>             
                         
                        <!--option class='current-academic-year summerSemester' value="%=dbConn.Fields.Item("CHYear").Value%"Summer %=dbConn.Fields.Item("CHYear").Value + 1%/option-->
                        <!--<option class='current-academic-year fallSemester' value="%=dbConn.Fields.Item("CHYear").Value%>">Fall %=dbConn.Fields.Item("CHYear").Value%/option -->
      
                        <option class='future-academic-year fallSemester' value="<%=dbConn.Fields.Item("CHYear").Value%>">Fall <%=dbConn.Fields.Item("CHYear").Value%></option>
            <option class='future-academic-year springSemester' value="<%=dbConn.Fields.Item("CHYear").Value%>">Spring <%=dbConn.Fields.Item("CHYear").Value + 1%></option>
            <!--option class='future-academic-year summerSemester' value="< %=dbConn.Fields.Item("CHYear").Value%>">Summer < %=dbConn.Fields.Item("CHYear").Value + 1%></option-->
            
                        <!-- HAVE TO FIX EACH SEMESTER: dbConn.Fields.Item("CHYear").Value + 1-->
                        
                    <% 
              dbConn.MoveNext()               
            Wend 
            dbConn.Close()
          %>
                    </select> 
                                      
                </div>
                
                <div id="classificationDiv" class="formControlDiv">
                             
                    <label title="Note:  For undergraduate students, 12 SCH is considered full time and 6 SCH is considered part-time." class="tip" for="classification"><img style="margin-bottom: -5px;" src="/_graphics/icons/question_icon.png" /> Classification :</label>
                  <select class="formControl" id="classification">
                      <option value=""></option>
                      <option value="0">Freshman</option>
                      <option value="1">Sophomore</option>
                      <option value="2">Junior</option>
                      <option value="3">Senior</option>
                        <option value="4">Graduate</option>   
                    </select>                
                    
                </div>  

                <div id="residencyDiv" class="formControlDiv"> 
                   
                    <label for="residency">Residency :</label>
                  <select class="formControl" id="residency">
                      <option value=""></option>
                      <option value="inState">In State</option> 
                        <option value="OutOfState">Out of State</option>  
                        <option value="International">International</option>   
                    </select>     
                                 
              </div>

                <div id="firstTimeDiv" class="formControlDiv"> 
                   
                    <label for="firstTime">First Semester at Tarleton :</label>
                  <select class="formControl" id="firstTime">
                      <option value=""></option>
                      <option value="yes">yes</option> 
                        <option value="no">no</option>  
                    </select>     
                                 
              </div>  
                              
                <div id="variableDiv" class="formControlDiv"> 
                   
                    <label for="variable">Tuition Plan :</label>
                  <select class="formControl" id="variable">
                      <option value=""></option>
                      <option value="variable">Variable</option> 
                        <option value="guaranteed">Guaranteed</option>  
                    </select>     
                                 
              </div>
                
                <div id="campusDiv" class="formControlDiv">  
                             
                    <label for="campus" class="tip" title="Campus: You may take classes in Stephenville, Fort Worth, Weatherford, Waco, Midlothian, Cleburne, and online (distance learning.)  Learn more about our <a href=http://www.tarleton.edu/locationsmap.html target=_blank>locations</a> or <a href=http://www.tarleton.edu/globalcampus/index.html target=_blank>distance learning</a> A student has to qualify for distance learner status in order to be charged as a Distance Learner. To apply for Distance Learner status, fill out the <a href=http://www.tarleton.edu/common/links/academic/campus-update-request-form.html target=_blank>Campus Update Request Form</a>. For more information, please email <a href=mailto:registrar@tarleton.edu target=_blank>registrar@tarleton.edu</a>."><img style="margin-bottom: -5px;" src="/_graphics/icons/question_icon.png" /> Campus :</label>
                  <select class="formControl" id="campus">
                      <option value=""></option>
                      <option value="stephenville">Stephenville</option> 
                        <option value="othercampus">Other Campus</option> 
                        <!--option value="online" id="online-campus">Distance Learner<strong>*</strong></option-->   
                    </select>                         
                                 
              </div>
                
                <div id="lsDiv" class="formControlDiv subClass">
                             
                    <label for="ls" class="tip" title="Delivery Method: Depending on availability, you may enroll in face-to-face lecture classes or online classes.  There are additional fees associated with online classes."><img style="margin-bottom: -5px;" src="/_graphics/icons/question_icon.png" /> Delivery Method :</label>
                  <select id="ls" class="formControl">
                      <option value="none"></option>
                      <option value="online">Online</option> 
                        <option value="inperson">In Person</option>   
                    </select> 
                    
              </div> 
                
                <div id="svilleDiv" class="subClass">
                
                  <div id="housingDiv">
                        <label for="housing" class="tip" title="Housing: To learn more about the residential facilities, visit the <a href=http://www.tarleton.edu/housing/facilities.html target=_blank>Residential Living &amp; Learning website</a>."><img style="margin-bottom: -5px;" src="/_graphics/icons/question_icon.png" /> Housing :</label>
                        <select id="housing" name="mealplan">
                            <option value=""></option>
                        </select>  
                    </div>              
                    
                    <div id="mealPlanDiv">                
                        <label for="mealplan" class="tip" title="Meal Plan: To learn more about the meal plans, visit the <a href=http://www.tarletondiningservices.com/ target=_blank>Dining Services website</a>."><img style="margin-bottom: -5px;" src="/_graphics/icons/question_icon.png" /> Meal Plan :</label>
                        <select id="mealplan" name="housing">
                            <option value=""></option>
                        </select>
                    </div>
              </div>           
            </div> 
            
            <div id="submitDiv">
                <input id="submit" type="button" value="Submit"/>   
                <input id="reset" type="button" value="Reset"/>  
                <input class="edit" type="button" value="Edit"/> 
            </div>  
    </div> 
        
        <div class="caution" id="cinfo">            
            <p class="red">*Please Note: All fees are approximations and subject to change because of economic conditions, board action, and/or legislative requirements.
            </p>
      
      <p class="red">The estimate also does not include lab fees that are course specific. Tuition Differentials will be charged to courses as follows: all courses in the College of Business, College of Agricultural and Environmental Sciences, College of Liberal and Fine Arts, College of Education, College of Science and Technology and College of Health Science and Human Service.  Nursing/Medical Lab Sciences/Social Work, Criminology and Engineering Courses will also have additional Tuition Differentials over and above their College Differentials. The tuition estimate includes an average tuition differential and will vary based on course enrollment.
      </p>            
        </div>  
      
        <div id="tuitioncal">
        
          <table id="estTable">     
              <tr><th>Hours</th>
                    <th>Base Tuition</th>
                    <th class="mobileHide">Fees</th>
                    <th class="mobileHide">Housing</th>
                    <th class="mobileHide">Meal Plan</th>
                    <th>Total</th>
                </tr>          
            </table> 

            <!--<div style = "clear:both;">
              <div id="debugTuition"></div>
            </div>-->
          
            <div id="xml_container">                
          </div>
            
            <div>
              <p>To receive your estimate by email, enter your email address and click send.</p>
                <label for="emailMult">Email Address:</label>
                <input name="emailMult" type="text" id="emailMult" />                 
              <input name="SendMultEmail" id="SendMultEmail" type="button" value="Submit" onClick="return false;">
                <input style="float: none" class="resetReset" type="button" value="Reset"/>
                <span id="errorMult"></span>                    
          </div> 
                    
    </div>
        
        <div id="genBill">    
        </div> 
        
        <div id="overlay" class="apple_overlay">
            <a class="close"></a>
            <div class="contentWrap"></div>
    </div> 
        
        <div class="cautionMobile">            
            <p class="red">*Please Note: All fees are approximations and subject to change because of economic conditions, board action, and/or legislative requirements.
            </p>
      
      <p class="red">The estimate also does not include lab fees that are course specific. Tuition Differentials will be charged to courses as follows: all courses in the College of Business, College of Agricultural and Environmental Sciences, College of Liberal and Fine Arts, College of Education, College of Science and Technology and College of Health Science and Human Service.  Nursing/Medical Lab Sciences/Social Work, Criminology and Engineering Courses will also have additional Tuition Differentials over and above their College Differentials. The tuition estimate includes an average tuition differential and will vary based on course enrollment.
      </p>       
        </div> 
        
        <div id="details">            
        </div>            
                    
<script type="text/javascript">

$(document).ready(function() {  
  getHousing();
  getMealPlan();  
  $('#Random').remove();
  formDisplay();  
  $(".tip").tooltip({
    position: 'center<% If pUser.isMobile Then %><% Else %> left<% End If %>',
    offset: [-2, <% If pUser.isMobile Then %>-50<% Else %>10<% End If %>],
        effect: 'fade',
    delay: <% If pUser.isMobile Then %>0 <% Else %> 1000<% End If %>,
    events: {
      def: 'click, mouseleave',
      select: 'onchange'
    }
  }); 

});

$('#semester').change(function() {
  getHousing();
  getMealPlan();  
});

$('.formControl').change(function() {
  formDisplay();
});

function getHousing() {
  var adjustmentForYear = 0;

  if ($('select#semester option:selected').hasClass('current-academic-year')){ adjustmentForYear = parseInt(-1); }

  else if ($('select#semester option:selected').hasClass('future-academic-year')) { adjustmentForYear = parseInt(0); }

  else if ($('select#semester option:selected').hasClass('last-year')) { adjustmentForYear = parseInt(-2); }

  $('#housing').empty();
  $('#housing').append('<img style=\"margin-top: 25%; margin-left: 45%;\" src=\"/_scripts/fancybox/ajax-loader.gif\" alt="loading please wait\">');
  $.get("housing.asp?CHYear=" + (parseInt($('select#semester option:selected').val()) + adjustmentForYear) + "&plan=" + $('select#variable option:selected').val(), function(data){
    $('#housing').empty();
      $('#housing').append(data); 
  });   
} 

function getMealPlan() {
  var adjustmentForYear = 0;

  if ($('select#semester option:selected').hasClass('current-academic-year')){ adjustmentForYear = parseInt(-1); }

  else if ($('select#semester option:selected').hasClass('future-academic-year')) { adjustmentForYear = parseInt(0); }

  else if ($('select#semester option:selected').hasClass('last-year')) { adjustmentForYear = parseInt(-2); }

  $('#mealplan').empty();
  $('#mealplan').append('<img style=\"margin-top: 25%; margin-left: 45%;\" src=\"/_scripts/fancybox/ajax-loader.gif\" alt="loading please wait\">');
  $.get("mealplan.asp?CHYear=" + (parseInt($('select#semester option:selected').val()) + adjustmentForYear) + "&plan=" + $('select#variable option:selected').val(), function(data){
    $('#mealplan').empty();
      $('#mealplan').append(data);  
  });   
} 

$('input#reset').click(function() { 
  $("#semester").val("");
  formDisplay();
  $("#tuitioncal").slideUp();
  $("select").show();
  $("#svilleDiv").children().show();  
  $(".selectText").remove();
  $("#submit").fadeIn();
  $("#reset").fadeIn();
  $("#errorMult").empty();
  $('#genBill').fadeOut();
});

$('input.edit').click(function() {  
  $(".edit").fadeOut();
  $("#submit").fadeIn();
  $("#reset").fadeIn();
  
  $('select').each(
    function(index) { 
      $(this).show();
      $(this).parent().show();  
    }
  );  
  formDisplay();
  $(".selectText").remove();
  $("#tuitioncal").slideUp('slow');
  formDisplay();
});

$('input#submit').click(function() {
  var currentDate = new Date();
  var currentYear = currentDate.getFullYear(); //Currently in the middle of the academic year, so the adjustment had to be made.
  var adjustedYear = 0;
  var adjustmentForYear = 1;

  if ($('select#semester option:selected').hasClass('current-academic-year')){ adjustmentForYear = parseInt(-1); }

  else if ($('select#semester option:selected').hasClass('future-academic-year')) { adjustmentForYear = parseInt(0); }

  else if ($('select#semester option:selected').hasClass('last-year')) { adjustmentForYear = parseInt(-2); }

  if ($("select#variable option:selected").val() != "variable" || $('select#classification option:selected').val() == "4") 
  {
    //Handles ALL Guaranteed Tuition Plans and Graduate Plan
    adjustedYear = (parseInt($('select#semester option:selected').val()) + adjustmentForYear - $('select#classification option:selected').val());
  }
  else
  {
    //Handles Variable Tuition Plans for Freshmen, Sophomores, Juniors, and Seniors
    adjustedYear = currentYear + adjustmentForYear;
  }                
  
  $.get("getBill.asp?CHYear=" + adjustedYear + "&plan=" + $('select#variable option:selected').val() , function(data){
                                            
    data = jQuery.parseJSON( data );  
    $('#details').empty();
    $('#debugTuition').empty();

    // RESIDENCY FOR INTERNATIONAL FEES

    if ($('select#residency option:selected').val() != "inState" ){
      changeVal ( 'Resident', '0' );
    }
    else{
      changeVal ( 'Non Resident', '0' );
    }
    
    if ($('select#residency option:selected').val() != "International" ){
      changeVal ( 'International Program Fee', '0' );
      changeVal ( 'International Student Srvc Fee', '0' );
      changeVal ( 'International Insurance', '0' );
    }


    // CLASSIFICATION FOR BREAKAGE DEPOSIT FEES
  
    if ($('select#classification option:selected').val() != "0" ){
      changeVal ( 'Breakage Deposit Fee', '0' );        
    }

    // CAMPUS FOR OFF CAMPUS PROGRAM FEES AND MEAL/HOUSING PLANS
    
    if ($('select#campus option:selected').val() != "othercampus" ){
      changeVal ( 'Off Campus Program Fee', '0' );        
    } 
    
    if ($('select#campus option:selected').val() == "othercampus" ){
      $('select#mealplan').val(0);
      $('select#housing').val(0);       
    }

    if ($('select#campus option:selected').val() != "online" || $('select#campus option:selected').val() != "Distance Learner*"){
      //changeVal ( 'Online Degree Program Fee', '0' ); 
    }

    if ($('select#ls option:selected').val() != "online" || $('select#campus option:selected').val() != "Online"){
      changeVal ( 'Online Degree Program Fee', '0' ); 
    }

    // STEPHENVILLE CAMPUS FOR PARKING FEES and REC SPORTS FEES

    if ($('select#campus option:selected').val() == "stephenville" ){

      if ($('select#semester option:selected').hasClass('fallSemester')){
        $.each(data, function() {
          if (this.FeeName == 'Parking Fee') {
            this.Fee = this.Fee * 1;
          }
          if (this.FeeName == 'Rec Sports Fee') {
            this.Fee = this.Fee * 1;
          }
        });
      }

      else if ($('select#semester option:selected').hasClass('springSemester')) { 
        $.each(data, function() {
          if (this.FeeName == 'Parking Fee') {
            this.Fee = this.Fee * 0.50;
          }
          if (this.FeeName == 'Rec Sports Fee') {
            this.Fee = this.Fee * 1;
          }
        }); 
      }

      else if ($('select#semester option:selected').hasClass('summerSemester')) { 
        $.each(data, function() {
          if (this.FeeName == 'Parking Fee') {
            this.Fee = this.Fee * 0.25;
          }
          if (this.FeeName == 'Rec Sports Fee') {
            this.Fee = this.Fee * 0.50;
          }
        });  
      }

    }

    // OTHER CAMPUS FOR NON-FLAT FEES
    
    if ($('select#campus option:selected').val() == "online" || $('select#campus option:selected').val() == "Distance Learner*"){
      //changeVal ( 'Distance Learning Fee', '0' );
      changeVal ( 'Freshman Experience Fee', '0' );   
      changeVal ( 'Breakage Deposit Fee', '0' );
      $('select#mealplan').val(0);
      $('select#housing').val(0);
    }

    if ($('select#campus option:selected').val() != "stephenville" && $('select#campus option:selected').val() != "Stephenville"){
      changeVal ( 'Rec Sports Fee', '0' );
      changeVal ( 'Student Center Fee', '0' );
      //changeVal ( 'Health Services Fee', '0' );     
      //changeVal ( 'Athletics Fee', '0' );
      changeVal ( 'Parking Fee', '0' );       
    }

    // CLASSIFICATION FOR NON-FLAT FEES
    
    if ($('select#freshman option:selected').val() == "no" ){
      changeVal ( 'Deposit', '0' );
      changeVal ( 'Freshman Experience Fee', '0' );
      changeVal ( 'Testing Fee', '0' );
      changeVal ( 'Deposit', '0' ); 
      changeVal ( 'Testing Fee', '0' ); 
    }
    
    //modifies the array for easy math===================================================
    function changeVal( id, value ) {   
      $.each(data, function() {
        if (this.FeeName == id) {
          this.Fee = value;
        }
      });
    }
    
    $(".estHolder").remove();
    for (var hours = 3; hours < 19; hours = hours + 3){
      var bt = 0;
      var ftotal = 0;
      var total = 0;
      var details = "";
      //var tuitionDetails = "<h3>Adjusted Year = " + adjustedYear + "</h3>";
      var countRounds = 0;
      var fdetails = '<div class="overlay apple_overlay" id="details' + hours + '"><div class="contentWrap" ><div class="bill"><h6>Details</h6>';
      var btsum = 0;
        
      $.each(data, function() {
        
        // === NOT BASE TUITION ===
        if (this.CatName != "Base Tuition") {
          details = details + '<div><label>' + this.FeeName + '</label><div><div class="mc">'
        }

        // === BASE TUITION or PER HOUR FEES ===
        if (this.CatName == "Per Hour Fees" || this.CatName == "Base Tuition") {
          
          if (this.HourCap != 0) {  //Did we meet an HourCap exception?     
            if (hours > this.HourCap){
              ftotal = ftotal + (parseFloat(this.Fee) * this.HourCap);
              details = details + '<div class="base">' + parseFloat(this.Fee).toFixed(2) + '</div><div class="mult"> x ' + this.HourCap + '</div><div class="out"> = ' + parseFloat(this.Fee * this.HourCap).toFixed(2) + '</div>';
            }
            else {
              ftotal = ftotal + (parseFloat(this.Fee) * hours);
              details = details + '<div class="base">' + parseFloat(this.Fee).toFixed(2) + '</div><div class="mult"> x ' + hours + '</div><div class="out"> = ' + parseFloat(this.Fee * hours).toFixed(2) + '</div>';
            }
          } 

          else if (this.FeeCap != 0) {  //Did we meet an FeeCap exception?  
            //console.log(this.FeeCap)  ;   
            if ((parseFloat(this.Fee) * hours) > this.FeeCap){
              ftotal = ftotal + parseFloat(this.FeeCap);
              details = details + '<div class="base">' + parseFloat(this.Fee).toFixed(2) + '</div><div class="mult">N/A</div><div class="out"> = ' + parseFloat(this.FeeCap).toFixed(2) + '</div>';
            }
            else {
              ftotal = ftotal + (parseFloat(this.Fee) * hours);
              details = details + '<div class="base">' + parseFloat(this.Fee).toFixed(2) + '</div><div class="mult"> x ' + hours + '</div><div class="out"> = ' + parseFloat(this.Fee * hours).toFixed(2) + '</div>';
            }
          } 

          else { //No HourCap or FeeCap on this Fee.  
            if (this.CatName != "Base Tuition") {
              ftotal = ftotal + (parseFloat(this.Fee) * hours);
              details = details + '<div class="base">' + parseFloat(this.Fee).toFixed(2) + '</div><div class="mult"> x ' + hours + '</div><div class="out"> = ' + parseFloat(this.Fee * hours).toFixed(2) + '</div>';
            }
          } 

          //tuitionDetails = tuitionDetails + '<table width="100%"><tr><th width="10%">Hours</th><th>Category</th><th width="15%">FeeName (ID)</th><th width="15%">HourCap</th><th width="15%">FeeCap</th><th width="15%">Fee</th><th width="15%">Fee Total</th></tr>';
          //tuitionDetails = tuitionDetails + '<tr><td>' + hours + '</td><td>' + this.CatName + '</td><td>' + this.FeeName + ' (' + this.FeeID + ')</td><td>' + parseFloat(this.HourCap).toFixed(2) + '</td><td>' + parseFloat(this.FeeCap).toFixed(2) + '</td><td>' + parseFloat(this.Fee).toFixed(2) + '</td><td>' + parseFloat(ftotal).toFixed(2) + '</td></tr></table>';

          if (this.CatName == "Base Tuition"){
            //tuitionDetails = tuitionDetails + '<table width="100%"><tr><th width="10%">Hours</th><th width="15%">BEF bt (' + countRounds + ')</th><th width="15%">BEF Fee (' + countRounds + ')</th><th width="15%">BEF BTSum (' + countRounds + ')</th><th width="15%">AFT bt (' + countRounds + ')</th><th width="15%">AFT Fee (' + countRounds + ')</th><th width="15%">AFT BTSum (' + countRounds++ + ')</th></tr>';

            //tuitionDetails = tuitionDetails + '<tr><td>' + hours + '</td><td>' + parseFloat(bt).toFixed(2) + '</td><td>' + parseFloat(this.Fee) + '</td><td>' + parseFloat(btsum).toFixed(2) + '</td>';
            
            bt = bt + (parseFloat(this.Fee) * hours);

            //bt = (parseFloat(this.Fee) * hours);
            if (btsum < this.Fee){
              btsum = this.Fee;
            }
            
            //tuitionDetails = tuitionDetails + '<td>' + parseFloat(bt).toFixed(2) + '</td><td>' + parseFloat(this.Fee) + '</td><td>' + parseFloat(btsum).toFixed(2) + '</td></tr></table>';
          }
        }
        else{         
          ftotal = ftotal + parseFloat(this.Fee);
          details = details + '<div class="base"></div><div class="mult"></div><div class="out"> = ' + parseFloat(this.Fee).toFixed(2) + '</div>';          
        }
        if (this.CatName != "Base Tuition") {
          details = details + '</div></div></div>';
        }
        //console.log(this.FeeName + " " + this.Fee);
      });
      
      //ftotal = ftotal - bt;
      total = ftotal + bt + parseFloat($('select#mealplan option:selected').val()) + parseFloat($('select#housing option:selected').val());     
      
      fdetails = fdetails + '<div><label>Base Tuition</label><div><div class="mc"><div class="base">' + parseFloat(btsum).toFixed(2) + '</div><div class="mult"> x ' + hours + '</div><div class="out"> = ' + parseFloat(bt).toFixed(2) + '</div></div></div></div>'
      
      var end = '<div><label>Housing</label><div><div class="mc"><div class="base"></div><div class="mult"></div><div class="out"> = ' + parseFloat($('select#housing option:selected').val()).toFixed(2) + '</div></div></div></div><div><label>Meal Plan</label><div><div class="mc"><div class="base"></div><div class="mult"></div><div class="out"> = ' + parseFloat($('select#mealplan option:selected').val()).toFixed(2) + '</div></div></div></div>'
      
      details = fdetails + details + end + '<div style="height: 10px; overflow: hidden"><hr style="width: 95%; display: block; clear: both"></div><div style="padding-top: 0px; margin-top: 0px;"><label>Total</label><div><div class="mc"><div class="base">&nbsp;</div><div class="mult">&nbsp;</div><div class="out"> = ' + total.toFixed(2) + '</div></div></div></div><p style="padding-bottom: 5px;">To receive your estimate by email, enter your email address and click send.<br /><label id="Label1" for="email">Email Address:</label><input id="email" name="email" type="text" class="email" /><input name="SendEmail" class="SendEmail" type="button" value="Submit" onClick="return false;" thours="' + hours + '"  baseXhours="' + bt.toFixed(2) + '" total="' + total.toFixed(2) + '"/><span class="error"></span></p><% If pUser.isMobile Then %><p style="width: 95%; display: block; float: left"><input class="resetReset" type="button" value="Reset"/><input class="back" type="button" value="Back"/></p><% End If %></div></div></div>';
      
      $('#details').append(details);
      //$('#debugTuition').append(tuitionDetails);      
      
      $('#estTable').append("<tr class=\"estHolder\" id=\"\"><td>" + hours + "</td><td>$" + bt.toFixed(2) + "</td><td class=\"mobileHide\">$" + ftotal.toFixed(2) + "</td><td class=\"mobileHide\">$" + parseFloat($('select#housing option:selected').val()).toFixed(2) + "</td><td class=\"mobileHide\">$" + parseFloat($('select#mealplan option:selected').val()).toFixed(2) + "</td><td><div>$" + total.toFixed(2) + "</div> <span class=\"rel\" rel=\"#details" + hours + "\">details</span></td></tr>");
    }
    $('#tuitioncal').slideDown();
    initDetail();
    
    $('input.email').keyup(function(e) {  
      if(e.keyCode == 13) {
        $('#emailMult').val($('.email').val());
        emailMult();
      }
    });
  });   
  
  $(".selectText").remove();
    
  $('select').each(
    function(index) { 
    
    if ($(this).val() == "" || $(this).val() < 0 || $(this).val() == "-") {
      $(this).parent().hide();  
    }
    else {        
      $(this).parent().append('<div class="selectText">' + $('#' + $(this).attr('id') + ' :selected').text() + '</div>');
      $(this).hide();
    } 
  });
  
  $("#submit").fadeOut(); 
  $(".selectText").fadeIn();
  $(".edit").fadeIn();
    
});

function formDisplay() {  
  $('.formControl').each(
    function(index) { 
    
    if ($(this).val() != "" || $(this).val() == null) {
      if ($(this).parent().next().hasClass("subClass")) { 
      }
      else  {
        $(this).parent().next().fadeIn();
      }
    }
    else {
      if ($(this).parent().next().hasClass("subClass")) {
        $(this).parent(".formControlDiv").next(".formControlDiv").fadeOut();
        $(this).parent(".formControlDiv").next(".formControlDiv").children().val("");     
      }
      else  {
        $(this).parent(".formControlDiv").next(".formControlDiv").fadeOut();
        $(this).parent(".formControlDiv").next(".formControlDiv").children().val("");
      }
    }   
  });   

  //Tcal3 new -------

  // -------------------------------------------------------------------------------------------------------------------------
  // TUITION PLAN: GUARANTEED or VARIABLE?
  // If classification is Freshman or First Semester at Tarleton, then you can choose Guaranteed or Variable Tuition,
  // however, if you are not in-state (Texas), you are Variable automatically. If this is not your first year, and 
  // you are not a Graduate Student, then you are on Guaranteed Automatically.
  // -------------------------------------------------------------------------------------------------------------------------
  if ($("#classification").val() == "0" || $("#firstTime").val() == "yes") 
  {
    if ($("#residency").val() == "inState")
    {
      $("#variable").parent().fadeIn();
      $("#variable").prop( "disabled", false);
    } 
    else 
    {
      $("#variable").val("variable");
      $("#variable").prop( "disabled", true );
    }
  } 
  else if ($("#classification").val() == "4") 
  {
    $("#variable").val("variable");
    $("#variable").prop( "disabled", true );
    $('#firstTime').val("no");
    $("#firstTime").parent().fadeOut();
  } 
  else 
  {
    if ($("#residency").val() == "inState")
    {
      $("#variable").prop( "disabled", true );
      $("#variable").val("guaranteed");
    } 
    else 
    {
      $("#variable").val("variable");
      $("#variable").prop( "disabled", true );
    }
  } 

  // -------------------------------------------------------------------------------------------------------------------------
  // CAMPUS: Stephenville, Other Campus, or Distance Learner?
  // If semester and classification is selected, then campus and learning style (now delivery method) is made available.
  // -------------------------------------------------------------------------------------------------------------------------

  if ($("#classification").val() != "" && $("#semester").val() != "")
  {
    $("#campusDiv").fadeIn();
    $("#campus").prop( "disabled", false);
    $("#lsDiv").fadeIn();
    $("#ls").prop( "disabled", false);
  }
  else
  {
    $("#campusDiv").fadeOut();
    $("#campus").prop( "disabled", true); 
    $("#ls").parent().fadeOut();
    $("#ls").prop( "disabled", true);
      
  }

  // -------------------------------------------------------------------------------------------------------------------------
  // LEARNING STYLE (NOW DELIVERY METHOD): Online or In Person?
  // If Stephenville or Other Campus is selected, then options are available for Learning Style (now Delivery Method).
  // Otherwise, Distance Learner is only an Online choice.
  // -------------------------------------------------------------------------------------------------------------------------

  if ($("#campus").val() == "stephenville" || $("#campus").val() == "othercampus") 
  {
    $("#ls").prop( "disabled", false);  
  }
  else if ($("#campus").val() == "online")
  { 
    $("#ls").val("online");
    $("#ls").prop( "disabled", true); 
  }

  // -------------------------------------------------------------------------------------------------------------------------
  // STEPHENVILLE: Do Housing and Meal Plans show?
  // After choosing the Stephenville as the selected campus, the Housing and Meal Plans will show.
  // -------------------------------------------------------------------------------------------------------------------------

  if ($("#campus").val() == "stephenville") 
  {
    $("#svilleDiv").fadeIn();
  }
  else 
  {
    $("#svilleDiv").fadeOut();
  }


  // -------------------------------------------------------------------------------------------------------------------------
  // SUBMIT BUTTON REVEAL: Was the last question answered?
  // Depending on how you answer the questions, you should end (at minimum) either with Distance Learner or an answer to
  // the Learning Style (now Delivery Method) question. The Housing and Meal Plan questions are optional. And all must have an answer to the
  // Tuition Plan question.
  // -------------------------------------------------------------------------------------------------------------------------
  
  if ($("#campus").val() == "online" || $("#ls").val() == "inperson" || $("#ls").val() == "online" && $("#variable").val() != null) {
      $("#submitDiv").fadeIn();     
    }
    else {      
      $("#submitDiv").fadeOut();
      $("#campus").parent().next().children().val("");    
    } 
} 

/////////Sends the general estimates///////////////
$('input#SendMultEmail').click(function() { 
  emailMult();
}); 

$('input#emailMult').keypress(function(e) { 
  if(e.keyCode == 13) {
        emailMult();
    }
});

function emailMult() {
  
  var emailEstimate = $('#estTable').clone();
  $(emailEstimate).find('td').removeAttr('class');
  $(emailEstimate).find('tr').removeAttr('class');
  $(emailEstimate).find('th').removeAttr('class');
  $(emailEstimate).find('span').remove();
    
  //console.log($(emailEstimate).html().length);
    
  $.post("emailAll.asp", { 
        "email" : $('#emailMult').val(), 
      "classification": $('select#classification option:selected').text(),
      "residency": $('select#residency option:selected').val(),
      "campus": $('select#campus option:selected').val(),
      "message": encodeURIComponent($(emailEstimate).html()) 
    }, function(data){    
      $('#errorMult').html(data);
      $('.error').html(data);   
    }
  );
} 

///////////displays detail in a window////////////
function initDetail() {
  
  //adding the event listerner for Mozilla  

  // if the function argument is given to overlay, it is assumed to be the onBeforeLoad event listener
  
  $("a[rel]").unbind('click');
  
  <% If pUser.isMobile Then %>
  $("span[rel]").click(function() { 
    $('#genBill').hide();
    $('#genBill').empty();
    $('#genBill').append($($(this).attr('rel')).html());  
    $('#semControl').hide();
    $('#tuitioncal').hide();
    $('#genBill').fadeIn(); 
    $(".resetReset").click(function(){
      $("#reset").trigger("click");
      $("#semControl").fadeIn();
      formDisplay();
    });
    $('input.back').click(function() {    
      $("#submit").fadeIn();
      $("#reset").fadeIn();
      
      $('select').each(
        function(index) { 
          $(this).show();
          $(this).parent().show();  
        }
      );  
      formDisplay();
      $(".selectText").remove();
      $("#tuitioncal").slideUp('slow');   
      $("#errorMult").empty();
      $('#genBill').fadeOut();
      $('#semControl').fadeIn();
      $(".edit").fadeOut();
    });
    
    $('.SendEmail').click(function() {
      $('#emailMult').val($('.email').val());
      emailMult();

    });
    $(".resetReset").click(function(){
      $("#reset").trigger("click");
      $("#semControl").fadeIn();
      formDisplay();
    });
  })  
  $(".resetReset").click(function(){
    $("#reset").trigger("click");
    $("#semControl").fadeIn();
    formDisplay();
  });
  <% Else %>
  
  $("span[rel]").overlay({
    //effect: 'apple',
    onBeforeLoad: function() {
      // grab wrapper element inside content
      //var wrap = this.getOverlay().find(".contentWrap");
      // load the page specified in the trigger
      //wrap.load(this.getTrigger().attr("href"));    
          
      x=$(window).scrollLeft()
      y=$(window).scrollTop()
      window.onscroll=function() {
        window.scrollTo(x,y) 
      }
      window.document.body.style.overflow = 'hidden';
    },
    onLoad: function () {
      this.getOverlay().addClass("target");
      
            if(window.addEventListener) {
        document.addEventListener('DOMMouseScroll', moveObject, false);
      }
        
      document.onmousewheel = moveObject;     
      
      function moveObject(event)
      {
        var delta = 0;
       
        if (!event) event = window.event;
       
        // normalize the delta//code has been modified for jquey shorthand calls.
        if (event.wheelDelta) { 
          // IE and Opera
          delta = event.wheelDelta / 60;
       
        } else if (event.detail) { 
          // W3C
          delta = -event.detail / 2;
        }     
       
        var currPos=$(".target").css("top");   
              
        currPos=parseInt(currPos)+(delta*10);//calculating the next position of the object
                
        if ($(window).height() < 700){  
          if (currPos < 60 ) {
            if ( $(window).height() - (currPos + 700) > 100) {
            }
            else {
              $(".overlay").css("top", currPos+"px");//jquery version
            }
          }   
        } 
      }
        },
    onClose : function(ev){
      window.onscroll=function() {} 
      $("body").css("overflow", "");
      $('.target').removeClass('target');
    },
    mask: {
      color: '#000',
      loadSpeed: 200,
      opacity: 0.7
      }
  });
  
  $('.SendEmail').click(function() {
    $('#emailMult').val($('.email').val());
    emailMult();

  });
  
  <% End If %>    
  
}
</script> 
                              
  <% End If %> 
  <%
  '-----------------end of module
    
    Call Footr_admin()    
    %>