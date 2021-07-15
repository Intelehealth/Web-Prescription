<%@page pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<html>
    <head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" href="css/bootstrap.min.css" >

    <style>


    .content {
        position: absolute;
        left: 50%;
        top: 20%;
        -webkit-transform: translate(-50%, -50%);
        transform: translate(-50%, -50%);
        }

        @font-face {
    font-family: 'Asem';
    src: url('fonts/Asem.ttf');
}

        @font-face {
    font-family: 'Youthness';
    src: url('fonts/Youthness.ttf');
}

        @font-face {
    font-family: 'Arty';
    src: url('fonts/Arty.ttf') ;
}

        @font-face {
    font-family: 'almondita';
    src: url('fonts/almondita.ttf') ;
}

        @font-face {
    font-family: 'signature';
    src: url('fonts/signature.ttf') ;
}

        @font-face {
    font-family: 'terecia';
    src: url('fonts/Terecia.ttf') ;
}

        @font-face {
    font-family: 'signature';
    src: url('fonts/signature.ttf') ;
}

@font-face {
    font-family: 'Rajdhani';
    src: url('fonts/Rajdhani-Regular.ttf') ;
}



body {
color:black;
font-family: 'Rajdhani',sans-serif;
}

html
{
color:black;
}

    </style>
<script src="js/jquery-3.5.1.min.js" ></script>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/pdfmake.min.js"></script>
<script src="js/vfs_fonts.js"></script>


    </head>
    <body>
        <br>
        <div id="prescription" style="display: none" class="container">
	    <div class="row style="text-align:center">
		<div class="col-md-2 col-sm-2">
			<img src="ekal-logo.png" width="50%">
		</div>
		<div class="col-md-8 col-sm-8" style="text-align:left">
			<span><strong>एकल आरोग्य हेल्पलाइन </strong></span>
			<br>
			<span ><strong>Ekal Arogya Helpline</strong></span>
		</div>
		<div class="col-md-2 col-sm-2 pull-right" >
			<img src="ih-logo.png" width="50%">
		</div>
	    </div>
            <br>
                 <div class="row" style="text-align:center">

                                        <div class="col-md-4 col-sm-4">
                                            &nbsp;
                                        </div>
                                        <div class="col-md-5 col-sm-3" style="font-size:14">
                                           <u> <b>ePrescription</b></u>
                                        </div>
                                        <div class="col-md-3 co-sm-3">
                                            <button class="btn btn-primary" onclick="createPDF();" >Download Prescription</button>
                                        </div>

                                </div>



            <div id="detailDiv" style="margin:0px">
            <p id="patient_name" style="font-size:12pt; margin: 0px; padding: 0px;"></p></b>
                <p id="patient_details" style="font-size:12pt; margin: 0px; padding: 0px;"> </p>
                <p id="address_and_contact" style="font-size:12pt; margin: 0px; padding: 0px;"></p>
                <p id="visit_details" style="font-size:12pt; margin-top:5px; margin-bottom:0px; padding: 0px;"></p>
              <p id="complaints_heading" style="font-size:15pt;margin-top:5px; margin-bottom:0px; padding: 0px;"></p>
                <b><p id="vitals_heading" style="font-size:12pt;margin-top:5px; margin-bottom:0px;font-size:15pt; padding: 0px;"></p></b>
                <p id="vitals" style="font-size:12pt;margin:0px; padding: 0px;"></p>
              <!--<p id="complaints_heading" style="font-size:15pt;margin-top:5px; margin-bottom:0px; padding: 0px;"></p>-->

                <p id="diagnosis_heading" style="font-size:15pt;margin-top:5px; margin-bottom:0px; padding: 0px;"></p>
                <p id="rx_heading" style="font-size:15pt;margin-top:5px; margin-bottom:0px; padding: 0px;"></p>
                <p id="tests_heading" style="font-size:15pt;margin-top:5px; margin-bottom:0px; padding: 0px;"></p>

                <p id="advice_heading" style="font-size:15pt;margin-top:5px; margin-bottom:0px; padding: 0px;"></p>
                <p id="advice_heading2" style="font-size:15pt;margin-top:5px; margin-bottom:0px; padding: 0px;display:none"></p>

                <p id="follow_up_heading" style="font-size:15pt;margin-top:5px; margin-bottom:0px; padding: 0px;"></p>

                <div style="text-align:right;margin-right:50px;margin-top:0px;" >
                <span style="font-size:3rem;padding: 0px;" id="docSign">
                </span>
                <br>
                <div class="pull-right" id="docDetail">
                </div>
                <p style="font-size:12pt; margin-top:-0px; padding: 0px;" id="docReg"></p>
                </div>
		<div style="text-align:center">
			Ekal Arogya Helpline Number - +911141236457
	
		</div>

               </div>



        </div>

        <script type="text/javascript">
var kkN=[];
             function getParameterByName(name, url) {
     if (!url) url = window.location.href;
     name = name.replace(/[\[\]]/g, "\\$&");
     var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
         results = regex.exec(url);
     if (!results) return null;
     if (!results[2]) return '';
     return decodeURIComponent(results[2].replace(/\+/g, " "));
 }
            jQuery(document).ready(function()
            {
                $('#errDesc').text('');

                jQuery.ajax ({
                             url: "https://helpline.ekalarogya.org/prescription/prescription/visitData",
                             type: "POST",
                             data: JSON.stringify({
                    visitId: getParameterByName("v"),
                    patientId: getParameterByName("pid")
                }),
                             dataType: "json",
             contentType: "application/json; charset=utf-8",
                             success: function(data){
        //
                                    //var jsondata = JSON.parse(data);

                                console.log(data.status);
                             //   localStorage.setItem("doctorSignatureImage", data.imageOfSignature);
                                if(data.status=="No Data found")
                                {
                                    console.log('Hello World');

                                    $('#errDesc').text('No Prescription Found');

                                }
                                else
                                {
                                    $('#prescription').show();
                                    $('#patient_name').html("<b>"+data.name.replaceAll(",", " ")+"</b>");
                                    $('#patient_details').text('उम्र / Age: '+data.age + " | लिंग / Gender: "+data.gender);
					$('#address_and_contact').text('राज्य / State: ' + data.address);
//                                    $('#address_and_contact').text('राज्य / AState: ' + data.address);
                                    wt = parseFloat(data.weight);
                                    ht = parseInt(data.height)/100;
                                    bmi = wt / (ht * ht);
				    if(isNaN(bmi))
				    	bmi = 0;


                                    $('#visit_details').text('पेशेंट ID / Patient ID: '+data.openMRSID+ " | दिनांक / Date of visit: "+data.visitDate);
                                    $('#vitals').html('<b><u><span style="font-size:15pt;">नब्ज / Vitals </span></u></b><br>Blood Pressure: '+ parseInt(data.sbp).toFixed(0) + '/'+ parseInt(data.dbp).toFixed(0) +' | Pulse(bpm): '+ data.pulseRate+ ' | Respiratory Rate: '+ data.respRate+"<br>");
                                    complaintString= data.complaint.trim().split("<br/>");
                                  //  console.log(complaintString);
					//
		 finalComplaint="";
                                    for(counter=0;counter < complaintString.length ; counter++) {
                                        if(complaintString[counter].indexOf("<b>") > -1 && complaintString[counter].indexOf("Associated symptoms") == -1){
						if(counter > 0){
						finalComplaint+=complaintString[counter].slice(5, -2)+"<br>";
						}
						else
						{
							finalComplaint+=complaintString[counter].slice(4, -2)+"<br>";
						}

                                        }
                                    }
                                  //  finalComplaint="";
                                  //  for(counter=0;counter < complaintString.length ; counter++) {
                                  //      if(complaintString[counter].indexOf("<b>") > -1 && complaintString[counter].indexOf("Associated symptoms") == -1){
                                  //          finalComplaint+=complaintString[counter].slice(1, -2);

                                  //      }
                                  //  }

                                    $('#complaints_heading').html('<b><u>वजह / Reason for visit</u></b><br><div style="font-size:14px;">'+finalComplaint +"</div>");
                                    if(data.diagnosis.substring(0,1)==';')
                                    {
                                        $('#diagnosis_heading').html('<b><u>निदान/ Diagnosis</u></b><br><div style="font-size:14px;">'+data.diagnosis.trim().substring(1)+"<br></div>");
                                    }
                                    else
                                    {
                                    $('#diagnosis_heading').html('<b><u>निदान/ Diagnosi</u></b><br><div style="font-size:14px;">'+data.diagnosis.trim()+"<br></div>");
                                    }
                                    if(data.medication.substring(0,1)==';')
                                    {
                                         $('#rx_heading').html('<b><u>दवाएं / Medication(s)</u></b><br><div style="font-size:14px;">'+data.medication.trim().substring(1)+"<br></div>");

                                    }
                                    else
                                    {
                                        $('#rx_heading').html('<b><u>दवाएं / Medication(s)</u></b><br><div style="font-size:14px;">'+data.medication.trim()+"<br></div>");

                                    }

                                    if(data.testsAdvised.substring(0,1)==';')
                                    {
                                        $('#tests_heading').html('<b><u>जांच की सिफारिश / Recommended Investigation(s)</u></b><br><div style="font-size:14px;">'+data.testsAdvised.trim().substring(1)+"<br></div>");

                                    }
                                    else
                                    {
                                        $('#tests_heading').html('<b><u>जांच की सिफारिश / Recommended Investigation(s)</u></b><br><div style="font-size:14px;">'+data.testsAdvised.trim()+"<br></div>");

                                    }

                                    if(data.medicalAdvice.substring(0,2)=='; ' )
                                    {

var staticAdvice=";दवा समय पर खाएं;हरी सब्जियां और फल अधिक मात्रामें खाएं;कोविड -19 उपयुक्त व्यव्हार का पालन करें;दिक्कत  ज्यादा होने पर तुरंत नजदीकी अस्पताल में दिखिए या हेल्पलाइन नंबर पर कॉल करें"
		                  ktemp = data.medicalAdvice.trim()

				 kk = ktemp.substr(2)+staticAdvice 
				console.log(kk)
				kk =kk.replace(";", "")
				kk2 = "<ul><li>"+kk.replaceAll(";","</li><li>")+"</li></ul>"

				console.log(kk2)	
					//kk = kk.replaceAll(";","\r\n")
					kkN = kk.split(";")
					if(kkN[0]==";" || kkN[0] == " ")					
						kkN.shift()
					console.log(kkN)
$('#advice_heading').html('<b><u>सामान्य सलाह / General Advice</u></b><br><div style="font-size:14px;">'+kk2+"<br></div>");
$('#advice_heading2').html('<b><u>सामान्य सलाह / General Advice</u></b><br><div style="font-size:14px;">'+kk.substr(1)+"<br></div>");
//$('#advice_heading').html('<b><u>General Advice/सामान्य सलाह</u></b><br><div style="font-size:14px;">'+kk.substr(1).replaceAll(",","<br>")+"<br></div>");
//  $('#advice_heading').html('<b><u>General Advice/सामान्य सलाह</u></b><br><div style="font-size:14px;">'+kk.substr(1).replace(",","<br>")+"<br></div>");

//  $('#advice_heading').html('<b><u>General Advice/सामान्य सलाह</u></b><br><div style="font-size:14px;">'+kk.substr(1)+"<br></div>");

//                                        $('#advice_heading').html('<b><u>General Advice/सामान्य सलाह</u></b><br><div style="font-size:14px;">'+kk.substr(2)+1<br></div>");


                                    }
                                    else
                                    {

                                        $('#advice_heading').html('<b><u>सामान्य सलाह / General Advice</u></b><br><div style="font-size:14px;">'+data.medicalAdvice.trim().substr(data.medicalAdvice.trim().lastIndexOf(";")+1)+"<br></div>");


                                    }

                                    if(data.followupNeeded.substr(0,1)==';')
                                    {

                                        $('#follow_up_heading').html('<b><u>फिर से संपर्क कि तारीख / Follow Up Date</u></b><br><div style="font-size:14px;">'+data.followupNeeded.trim().substring(1).replace(",","<br>")+"<br></div>");
                                    }
                                    else
                                    {
                                        $('#follow_up_heading').html('<b><u>फिर से संपर्क कि तारीख / Follow Up Date</u></b><br><div style="font-size:14px;">'+data.followupNeeded.trim().replace(",","<br>")+"<br></div>");

                                    }




                                    var docName = data.doctorName.replaceAll("Dr ","Dr.").replaceAll(",", " ");
                                    var fullDets ="";
                                    fullDets+=docName;
                                    fullDets+="<br>";

                                    var docAttributes = data.doctorAttributes.split("|");
                                    var tmpAttributes = new Array();

                                    var qual="";
                                    var specialization="";
                                    var phoneNumber="";
                                    var email="";
                                    var regNumber="";
                                    for (i = 0  ; i < docAttributes.length; i++) {
                                                if(docAttributes[i].indexOf("fontOfSign") > -1)
                                                {
                                                    $('#docSign').css('font-family',docAttributes[i].split(":")[1]);
                                                    $('#docSign').css('font-size',"3em;");
						}
						if(docAttributes[i].indexOf("textOfSign") > -1)
						{

                                                    $('#docSign').text(docAttributes[i].split(":")[1]);


                                                }

                                                if((docAttributes[i].indexOf("textOfSign") == -1) && (docAttributes[i].indexOf("fontOfSign") == -1))    {
                                                    if(docAttributes[i].indexOf("qualification") > -1)
                                                    {
                                                        qual=docAttributes[i].split(":")[1];

                                                    }
                                                    if(docAttributes[i].indexOf("specialization") > -1)
                                                    {
                                                        specialization=docAttributes[i].split(":")[1];

                                                    }

                                                    if(docAttributes[i].indexOf("phoneNumber") > -1)
                                                    {
                                                        phoneNumber="Phone Number: "+docAttributes[i].split(":")[1];

                                                    }

                                                    if(docAttributes[i].indexOf("emailId") > -1)
                                                    {
                                                        email="E-Mail: "+docAttributes[i].split(":")[1];

                                                    }
                                                    if(docAttributes[i].indexOf("registrationNumber") > -1)
                                                    {
                                                        regNumber="<b>Registration No: "+docAttributes[i].split(":")[1]+"</b>";

                                                    }

                                                }
                                    }
                                    fullDets+=qual+","+specialization+"<br>";
                                    //fullDets+=phoneNumber+"<br>";
                                    fullDets+=email+"<br>";
                                    //fullDets+=regNumber+"<br>";

                                    $('#docDetail').html(fullDets);
                                    $('#docReg').html(regNumber);

$('#docSImage').attr('src',  data.imageOfSignature);





                                }
                             }
                            });




            });

            function createPDF() {
var j = $('#follow_up_heading').text().slice(37).split(" ");
j.shift();

var docDe = $('#docDetail').html().replaceAll("<br>","\n");


var ll = $('#advice_heading').find("div:first").text();

                var fonts = {
   Asem: {
     normal: 'Asem.ttf',
     bold:'Asem.ttf',
     italics:'Asem.ttf',
     bolditalics:'Asem.ttf'

   },
Youthness: {
normal:'Youthness.ttf'
},

Arty: {
normal: 'Arty.ttf'
},

Almondita: {
normal:'almondita.ttf',
bold:'almondita.ttf',
italics:'almondita.ttf',
bolditalics:'almondita.ttf'	
},
margareta: {
normal: 'margareta.ttf',
bold:'margareta.ttf',
italics:'margareta.ttf',
bolditalics:'margareta.ttf'
},
Siganature: {
normal: 'signature.ttf',
bold:'signature.ttf',
italics:'signature.ttf',
bolditalics:'signature.ttf'
},
Terecia: {
normal: 'Terecia.ttf',
bold:'Terecia.ttf',
italics:'Terecia.ttf',
bolditalics:'Terecia.ttf'
},
Rajdhani: {
normal: 'Rajdhani-Regular.ttf',
bold: 'Rajdhani-Bold.ttf'
}, 



   // download default Roboto font from cdnjs.com
   Roboto: {
     normal: 'Roboto-Regular.ttf',
     bold: 'Roboto-Medium.ttf',
     italics: 'Roboto-Italic.ttf',
     bolditalics: 'Roboto-MediumItalic.ttf'
   },


}

var tmpComplaints = $('#complaints_heading').html().split("<br>");
for (index =1; index < tmpComplaints.length; index++) {
n = tmpComplaints[index].replaceAll('<div style="font-size:14px;">', "");
        n1 = n.replace("<b>","");
        n2 = n1.replace("</b>","");
        n3 = n2.replace("<u>","");
        n4 = n3.replace("</u>","");
        n5 = n4.replace(/<\/?[^>]+(>|$)/g, "");
        n6 = n5.replace("&amp;","& ");
        tmpComplaints[index] = n6 ;

}
 tmpComplaints.shift();
k2h2 = tmpComplaints.join("\n");
console.log(k2h2);

//                pdfMake.vfs = pdfFonts.pdfMake.vfs;

                var dd = {
                    "pageSize": "A4",
    content: [
        {

            stack: [
		
	{		columns: [
        {
           image: 'ss_logo',
width:60,
height:60
        },
        {
		text: 'एकल आरोग्य हेल्पलाइन\n Ekal Arogya Helpline', fontSize:12
        },
 {
           image: 'nhm_logo',
width:100,
height:38
        },

      ]},
                {text: 'ePrescription', style: 'subheader'},
                //{canvas: [{ type: 'line', x1: 0, y1: 5, x2: 595-2*40, y2: 5, lineWidth: 1, color:'green' }]}
            ],
            style: 'header'
        },
        {
            stack: [
                {text:$('#patient_name').text(),bold:true,lineHeight: 1.25},
                {text: $('#patient_details').text(), lineHeight:1.25},
                {text:$('#address_and_contact').text(), lineHeight:1.25},
                {text:$('#visit_details').text(), lineHeight:2}


            ]
        },
        {
            stack: [{text:'वजह / Reason for visit', bold:true,decoration:'underline',fontSize:12},
		    {text: k2h2+"\n", lineHeight:1}]
//            {text:$('#complaints_heading').text().slice(20), lineHeight:2}]

        },

        {
            stack: [{text:'नब्ज / Vitals', bold:true,fontSize:12,decoration:'underline',lineHeight:1},
            {text:$('#vitals').text().slice(13),lineHeight:2}
            ]

        },

        {
            stack: [
		{text:'निदान/ Diagnosis', bold:true,decoration: 'underline', fontSize:12,lineHeight:1},


//            {text:'निदान/ Diagnosis', bold:true,decoration: 'underline', fontSize:14,2lilineHeight:2},
            {text:$('#diagnosis_heading').text().slice(17),lineHeight:2}]

        },

         {
            stack: [
 {text:'दवाएं / Medication(s)', bold:true,decoration: 'underline', fontSize:12,lineHeight:1},
//            {text:'Medication(s)/दवाएं', bold:true,decoration: 'underline', fontSize:142},
            {text:$('#rx_heading').text().slice(22).replaceAll(";","\n")+"\n\n",lineHeight:1}]

        },

        {
            stack: [

{text:'जांच की सिफारिश / Recommended Investigation(s)', bold:true,decoration: 'underline', fontSize:12, lineHeight:1},
            {text:$('#tests_heading').text().slice(47)+"\n",lineHeight:1}]

        },

        {
            stack: [
{text:'\nसामान्य सलाह / General Advice', bold:true,decoration: 'underline', fontSize:12,lineHeight:1},
//            {text:'सामान्य सलाह / General Advice', bold:true,decoration: 'underline', fontSize:14, 2ineHeight:2,f1nt:'Rajdhani'},
            //{text:$('#advice_heading2').text().slice(29),lineHeight:1}]
            {ul:kkN}]

        },

         {
            stack: [
{text:'\nफिर से संपर्क कि तारीख / Follow Up Date', bold:true,decoration: 'underline', fontSize:12, lineHeight:1},
// {text:'Follow Up Date/फिर से संपर्क कि तारीख', bold:true,decoration: 'underline', fontSize:12, lineHeight:1},
//            {text:'Follow Up Date/फिर से संपर्क कि तारीख', bold:true,decoration: 'underline', fontSize:14, lineHeight:2,font:'Rajdhani'},
 //           {text:$('#follow_up_heading').text().slice(39).split(" ")[0]},
         {text:j.join(" ") , lineHeight:1},
            ]

        },


         {
            stack: [

            {text: $('#docSign').text(), font:$('#docSign').css('font-family').replace(/\b[a-zA-Z]/g, (match) => match.toUpperCase()),fontSize:32,alignment:'right'},
            {text:docDe, alignment:'right',lineHeight:1},
            {text:$('#docReg').text(), bold:true,alignment:'right'}
            ]

        },


    ],
    styles: {
        header: {
            fontSize: 18,
            bold: true,
            alignment: 'center',
            margin: [0, 10, 0, 10]
        },
        subheader: {
            fontSize: 14,
            decoration:'underline'
        },
	
    },
    images: {
nhm_logo : 'https://helpline.ekalarogya.org/preApi/ih-logo.png',
ss_logo: 'https://helpline.ekalarogya.org/preApi/ekal-logo.png'
},
defaultStyle: {
font: 'Rajdhani',
fontSize:10
},
footer : {text : 'Ekal Arogya Helpline Number -  +911141236457', alignment:'center'}
}
fileName = getParameterByName("v").slice(-5)+"_prescription";


pdfMake.createPdf(dd, null, fonts).download(fileName);
alert('Prescription will be downloaded shortly');
            }
        </script>
    </body>
    <script src="js/jquery-3.5.1.min.js" ></script>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/pdfmake.min.js"></script>
<script src="js/vfs_fonts.js"></script>

</html>








