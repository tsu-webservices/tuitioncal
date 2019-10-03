// SEMESTER TO CALCULATE
var semester_prices = new Array();
semester_prices["SemesterFall"]=2; //The fall and spring semester will have the same value, as they co-exist in the same academic year
semester_prices["SemesterSpring"]=20;
semester_prices["SemesterSummer"]=10;

// STUDENT TYPES

var studenttype_prices = new Array();
studenttype_prices["NewStudent"]=1;
studenttype_prices["ContinueStudent"]=2;

//TUITION FEES

var tuitiontype_prices = new Array();
tuitiontype_prices["VariableTuition"]=40;
tuitiontype_prices["GuaranteedTuition"]=50;

//HOURS FEES - This includes the initial fee for 3hrs * 2

var hours_fee = new Array();
hours_fee["Hours3"]=300;
hours_fee["Hours6"]=600;
hours_fee["Hours9"]=900;
hours_fee["Hours12"]=1200;
hours_fee["Hours15"]=1500;
hours_fee["Hours18"]=1800;

function getSelectedSemesterPrice() {
	var selectedSemesterPrice=0;
	var tuitionEstimator = document.forms["tuitionEstimator"];
	var selectedSemester = tuitionEstimator.elements["selectedsemester"];

	for(var i = 0; i < selectedSemester.length; i++)
	{
		if(selectedSemester[i].checked){
			selectedSemesterPrice = semester_prices[selectedSemester[i].value];
			break;
		}
	}

	return selectedSemesterPrice;
}

function displayHoursSelected(val) {
          document.getElementById('textInput').value=val; 
}

function getSelectedHoursFee(){
	var selectedHoursFee=0;
	var tuitionEstimator = document.forms["tuitionestimator"];
	var selectedHours = tuitionEstimator.elements["selectedhours"];
	return selectedHours;
}


function getSelectedStudentPrice(){
	var selectedStudentPrice=0;
	var tuitionEstimator = document.forms["tuitionestimator"];
	var selectedStudent = tuitionEstimator.elements["selectedstudent"];

	for (var i = 0; i < selectedStudent.length; i++) 
	{
		if(selectedStudent[i].checked){
			selectedStudentPrice = studenttype_prices[selectedStudent[i].value];
			break;
		}
	}

	return selectedStudentPrice;
}

function getSelectedTuitionPrice(){
	var selectedTutionPrice=0;
	var tuitionEstimator = document.forms["tuitionestimator"];
	var selectedTution = tuitionEstimator.elements["selectedtuition"];

	for(var i = 0; i < selectedTution.length; i++)
	{
		if(selectedTution[i].checked){
			selectedTutionPrice = tuitiontype_prices[selectedTution[i].value]
			break;
		}
	}

	return selectedTutionPrice;
}



function calculateTotal(){
	var tutionPrice = getSelectedSemesterPrice() + getSelectedStudentPrice() + getSelectedTuitionPrice() + getSelectedHoursFee();

	var divTotal = document.getElementById('totalPrice');
	divTotal.style.display='block';
	divTotal.innerHTML = "$"+tutionPrice;
}
function hideTotal(){
    var divobj = document.getElementById('totalPrice');
    divobj.style.display="none";
}

function resetEstimator(){ // 

}