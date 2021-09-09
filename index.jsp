
<!DOCTYPE HTML>
<html>
    <head>
<link rel="stylesheet" href="css/bootstrap.min.css" >
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300&display=swap" rel="stylesheet">

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
    src: url('fonts/almondita.ttf') ;
}

        @font-face {
    font-family: 'terecia';
    src: url('fonts/Terecia.ttf') ;
}

        @font-face {
    font-family: 'signature';
    src: url('fonts/signature.ttf') ;
}


body {
color:black;
font-family:'Roboto';}
html{
color:black;}

    </style>
    </head>
    <body>
        <div class="content" id="queryDiv">
        Enter Patient ID <input type="text" style="line-height: 30px;border-radius:5px;" name="patientId" id="patientId">
        <br>
        <br>
        <button type="button" class="btn btn-info" style="line-height: 30px;text-align:center;width:150px;" onclick="checkD();">Get Prescription</button>
        <br>
        <br>
        <div id="errDesc" style="color:red;font-size:x-large">

        </div>


        </div>
        <br>
        <div id="prescription" style="display: none" class="container">
            <div class="col-sm-12 col-md-12" style="text-align: center">
                <h4 style="font-weight: bold;">Telemed</h3>
            </div>
            <br>
                 <div class="row" style="text-align:center">

                                        <div class="col-md-4 co-sm-4">
                                            &nbsp;
                                        </div>
                                        <div class="col-md-5 col-sm-3" style="margin-left: -42px">
                                            Discharge epicrisis
                                        </div>
                                        <div class="col-md-3 co-sm-3">
                                            <button class="btn btn-primary" onclick="createPDF();" >Download Prescription</button>
                                        </div>

                                </div>


                                <hr style="height:  18px;">


            <br>
            <div id="detailDiv" style="margin:0px">
            <p id="patient_name" style="font-size:12pt; margin: 0px; padding: 0px;"></p></b>
                <p id="patient_details" style="font-size:12pt; margin: 0px; padding: 0px;"> </p>
                <p id="address_and_contact" style="font-size:12pt; margin: 0px; padding: 0px;"></p>
                <p id="visit_details" style="font-size:12pt; margin-top:5px; margin-bottom:0px; padding: 0px;"></p>
                <p id="date_of_visit" style="font-size:12pt; margin: 0px; padding: 0px;"></p>
                <p id="complaints_heading" style="font-size:15pt;margin-top:5px; margin-bottom:0px; padding: 0px;"></p>
                <p id="medical_history" style="font-size:15pt;margin-top:5px; margin-bottom:0px; padding: 0px;"></p>
                <p id="objective_data" style="font-size:15pt;margin-top:5px; margin-bottom:0px; padding: 0px;"></p>
                <b><p id="vitals_heading" style="font-size:12pt;margin-top:5px; margin-bottom:0px;; padding: 0px;"></p></b>
                <p id="vitals" style="font-size:12pt;margin:0px; padding: 0px;"></p>
                <p id="tests_heading" style="font-size:15pt;margin-top:5px; margin-bottom:0px; padding: 0px;"></p>
                <p id="diagnosis_heading" style="font-size:15pt;margin-top:5px; margin-bottom:0px; padding: 0px;"></p>
                <p id="rx_heading" style="font-size:15pt;margin-top:5px; margin-bottom:0px; padding: 0px;"></p>

                <p id="advice_heading" style="font-size:15pt;margin-top:5px; margin-bottom:0px; padding: 0px;"></p>

                <p id="follow_up_heading" style="font-size:15pt;margin-top:5px; margin-bottom:0px; padding: 0px;"></p>

                <div style="text-align:right;margin-right:50px;margin-top:0px;" >
                <span style="font-size:25px;padding: 0px;" id="docSign">

                </span>
                <br>
                <div class="pull-right" id="docDetail">
                </div>
                <p style="font-size:12pt; margin-top:-0px; padding: 0px;" id="docReg"></p>
                </div>

               </div>



        </div>

        <script type="text/javascript">
             function getParameterByName(name, url) {
     if (!url) url = window.location.href;
     name = name.replace(/[\[\]]/g, "\\$&");
     var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
         results = regex.exec(url);
     if (!results) return null;
     if (!results[2]) return '';
     return decodeURIComponent(results[2].replace(/\+/g, " "));
 }
            function checkD()
            {
                $('#errDesc').text('');

                jQuery.ajax ({
                             url: "https://uniceftraining.intelehealth.org/prescription/prescription/visitData",
                             type: "POST",
                             data: JSON.stringify({
                    visitId: getParameterByName("v"),
                    patientId: $('#patientId').val()
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
                                    $('#queryDiv').hide();
                                    $('#prescription').show();
                                    $('#patient_name').html("<b> Full Name </b>("+data.name+")");
                                    $('#patient_details').html('Date of birth: &nbsp;'+data.birthDate?.replaceAll("-","/") +  "&nbsp;&nbsp;&nbsp;Gender: &nbsp;"+(data.gender === 'M' ? 'Male': data.gender === 'F'? 'Female': data.gender));
                                    $('#address_and_contact').html('Home address:  &nbsp<br>' + data.address);
                                    $('#visit_details').html('Patient ID: &nbsp;'+data.citizenId+ "&nbsp;&nbsp;&nbsp; OpenMRS ID: &nbsp;"+data.openMRSID);
                                    $('#date_of_visit').html("Date and time of visit: &nbsp;"+data.visitDate);
                                    wt = data.weight;
                                    ht = data.height/100;
                                    bmi = 0.0;
                                    if(wt && ht) {
                                        bmi = wt / (ht * ht);
                                    }
                                    $('#vitals').html('<b>General state </b><br> Height(cm): &nbsp;'+ parseInt(data.height).toFixed(0) +' | Weight(kg): &nbsp;'+ parseInt(data.weight).toFixed(0) +' | BMI: &nbsp;'+ bmi.toFixed(2) +
                                    ' | Blood Pressure: &nbsp;'+ parseInt(data.sbp).toFixed(0) + '/'+ parseInt(data.dbp).toFixed(0) +' | Pulse(bpm): &nbsp;'+ data.pulseRate+
                                    ' | Body Temperature(F): &nbsp;'+ (data.temperature > 0 ? ((data.temperature * 1.8) + 32).toFixed(0) : 0) + ' | SpO2(%): &nbsp;'+ data.spo2 + ' | Respiratory Rate: &nbsp;'+ data.respRate+"<br>");
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
                                   
		//			finalComplaint="";
                //                    for(counter=0;counter < complaintString.length ; counter++) {
                //                        if(complaintString[counter].indexOf("<b>") > -1 && complaintString[counter].indexOf("Associated symptoms") == -1){
                //                            finalComplaint+=complaintString[counter].slice(1, -2);

                 //                       }
                  //                  }

                                    $('#complaints_heading').html('<b><u>Complaints</u></b><br><div style="font-size:14px;">'+finalComplaint +"<br></div>");
                                    
                                    let medicalHistory = data.medicalHistory?.replaceAll(".","<br>");
                                    $('#medical_history').html('<b><u>Medical history</u></b><br><div style="font-size:14px;">'+medicalHistory+"<br>")
                                    
                                    $('#objective_data').html('<b><u>Objective data</u></b><br><div style="font-size:14px;">'+data.complaint+"<br>")
                                    
                                    if(data.diagnosis.substring(0,1)==';')
                                    {
                                        $('#diagnosis_heading').html('<b><u>Diagnosis</u></b><br><div style="font-size:14px;">'+data.diagnosis.trim().substring(1)+"<br></div>");
                                    }
                                    else
                                    {
                                    $('#diagnosis_heading').html('<b><u>Diagnosis</u></b><br><div style="font-size:14px;">'+data.diagnosis.trim()+"<br></div>");
                                    }
                                    if(data.medication.substring(0,1)==';' || data.testsAdvised.substring(0,1)==';')
                                    {
                                         $('#rx_heading').html('<b><u>Treatment</u></b><br><div style="font-size:14px;">'+data.medication.trim().substring(1)+ "<br>"+data.testsAdvised.trim().substring(1)+"<br>");

                                    }
                                    else
                                    {
                                        $('#rx_heading').html('<b><u>Treatment</u></b><br><div style="font-size:14px;">'+data.medication.trim()+"<br>"+data.testsAdvised.trim()+ "<br>");

                                    }
                                    let physicalExamination = data.physicalExamination?.replaceAll(".","<br>");
                                    $('#tests_heading').html('<b><u>Physical Examination</u></b><br><div style="font-size:14px;">'+physicalExamination+"<br>");

                                    if(data.medicalAdvice.substring(0,1)==';')
                                    {

                                        kk = data.medicalAdvice.trim().substr(1)

                                        console.log(kk)
					jks = kk.split(";")
                                         killers = ""
                                         for(counter = 0 ; counter < jks.length; counter++)
                                        {
						if(jks[counter].indexOf("Audio") > -1)
						{
						}
						else
						{
		                                                killers+= jks[counter] +"<br>";
						}
                                         }
                                         console.log(killers)
																				     
                                        //$('#advice_heading').html('<b><u>General Advice</u></b><br><div style="font-size:14px;">'+kk.substr(kk.lastIndexOf(";")+1)+"<br></div>");
    
                                        $('#advice_heading').html('<b><u>Recommendations</u></b><br><div style="font-size:14px;">'+killers+"<br></div>");


                                    }
                                    else
                                    {
				         kk = data.medicalAdvice.trim()
					 jks = kk.split(";")
					 killers = ""
					 for(counter = 0 ; counter < jks.length; counter++)
					 {
						if(jks[counter].indexOf("Audio") > -1)
                                                {
                                                }
                                                else
                                                {
							

						killers+= jks[counter] +"<br>";
						}
					 }
					 console.log(killers)
					
                                        //$('#advice_heading').html('<b><u>General Advice</u></b><br><div style="font-size:14px;">'+data.medicalAdvice.trim().substr(data.medicalAdvice.trim().lastIndexOf(";")+1)+"<br></div>");
                                        $('#advice_heading').html('<b><u>Recommendations</u></b><br><div style="font-size:14px;">'+killers+"<br></div>");


                                    }

                                    if(data.followupNeeded.substr(0,1)==';')
                                    {

                                        $('#follow_up_heading').html('<b><u>Date of subsequent observation</u></b><br><div style="font-size:14px;">'+data.followupNeeded.trim().substring(1).replace(",","<br>")+"<br></div>");
                                    }
                                    else
                                    {
                                        $('#follow_up_heading').html('<b><u>Date of subsequent observation</u></b><br><div style="font-size:14px;">'+data.followupNeeded.trim().replace(",","<br>")+"<br></div>");

                                    }




                                    var docName = data.doctorName.replace(","," ");
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
                                    fullDets+= qual? qual+ "," +specialization+"<br>":"" +specialization+"<br>";
                                    //fullDets+=phoneNumber+"<br>";
                                   // fullDets+=email+"<br>";

                                    //fullDets+=regNumber+"<br>";

                                    $('#docDetail').html(fullDets);
                                    $('#docReg').html(regNumber);

$('#docSImage').attr('src',  data.imageOfSignature);





                                }
                             }
                            });




            }
function createTable(tableData, columns)
{
	return {
        table: {
            headerRows: 1,
            body: buildTableBody(tableData, columns)
        }
    };
}

function buildTableBody(data, columns) {
    var body = [];

    body.push(columns);
	
    data.forEach(function(row) {

        body.push(row);
    });

    return body;
}

	

            function createPDF() {


var j = $('#follow_up_heading').text().slice(30).split(" ");
j.shift();

		    var tmpK = $('#advice_heading').html().replace('<b><u>Recommendations</u></b><br><div style="font-size:14px;">','')
		    nest = tmpK.split("<br>")
		    console.log(nest);
		    videoAddresses = [];
		    nest.pop();
		    nest.pop();
		    for(i=0;i < nest.length ; i++) {
				if(nest[i].indexOf("<") == -1)
				{
					videoAddresses.push("#");											   
				}
				else
				{
					console.log(nest[i].indexOf("<"))											   
					nest[i] = nest[i].substr(0, nest[i].indexOf("<") - 1);										   
				}
		    }			
		   console.log(nest);	

$('#advice_heading').find('a').each(function() {
	videoAddresses.push($(this).attr('href'))
});

k9 = [];
console.log(videoAddresses);

for(nn = 0; nn  < nest.length;nn++)
{
		   if(videoAddresses[nn] == "#")
		   {
		   	k9.push({text: nest[nn] })
		   }
		   else
		 {
		   k9.push({text: nest[nn] + "Video Link ", link:videoAddresses[nn]}) 
		 }
											   
}										   
											   											   


videoAddress =  $('#advice_heading a:first').attr('href')
var videoDescriptor = $('#advice_heading a:first').parent().text()
var videoLinkPos = videoDescriptor.indexOf("video link")
		    
videoDescriptor = videoDescriptor.substr(0,videoLinkPos -1)
var docDe = $('#docDetail').html().replaceAll("<br>","\n");
var temp = $('#medical_history').html().replace('<b><u>Medical history</u></b><br><div style="font-size:14px;">','');
var medical_history = temp.replaceAll("<br>","\n").replaceAll("</div>","");
var temp1 = $('#objective_data').html().replace('<b><u>Objective data</u></b><br><div style="font-size:14px;">','');
var objective_data = temp1.replaceAll('<b>','').replaceAll('</b>','').replace('<br>','\n').replaceAll(".<br>","\n").replaceAll("<br></div>","");
var temp2 = $('#tests_heading').html().replace('<b><u>Physical Examination</u></b><br><div style="font-size:14px;">','');
var tests_heading = temp2.replaceAll("<br>","\n").replaceAll("</div>","\n");
var temp3 = $('#rx_heading').html().replace('<b><u>Treatment</u></b><br><div style="font-size:14px;">','');
var treatment = temp3.replaceAll("<br>","\n").replaceAll("</div>","");

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
normal: 'almondita.ttf',
bold:'almondita.ttf',
italics:'almondita.ttf',
bolditalics:'almondita.ttf'
},
Margareta: {
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

//                pdfMake.vfs = pdfFonts.pdfMake.vfs;

                var dd = {
                    "pageSize": "A4",
    content: [
        {

            stack: [
                'Telemed',
                {text: 'Discharge epicrisis', style: 'subheader'},
                {canvas: [{ type: 'line', x1: 0, y1: 5, x2: 595-2*40, y2: 5, lineWidth: 1, color:'green' }]}
            ],
            style: 'header'
        },
        {
            stack: [
                {text:$('#patient_name').text(),bold:true,lineHeight: 1.25},
                {text: $('#patient_details').text(), lineHeight:1.25},
                {text:$('#address_and_contact').text(), lineHeight:1.25},
                {text:$('#visit_details').text(), lineHeight:1.25},
                {text:$('#date_of_visit').text(), lineHeight:2},

            ]
        },
        {
            stack: [{text:'Complaints', bold:true,fontSize:14},
					  {text: k2h2, lineHeight:.75} ]
//            {text:$('#complaints_heading').text().slice(20), lineHeight:2}]

        },
        {
            stack: [{text:'Medical history', bold:true,fontSize:14, lineHeight:1},
            medical_history,
          //  {text:$('#medical_history').text().slice(15)+"\n\n"}
        ]

        },
        {
            stack: [{text:'Objective data', bold:true,fontSize:14, lineHeight:1},
            objective_data,
        //   {text:$('#objective_data').text().slice(14)+"\n\n"}
        ]

        },
        {
            stack: [{text:'General state', bold:true,fontSize:14, lineHeight:1},
            {text:$('#vitals').text().slice(13)+"\n\n"}
            ]

        },

        {
            stack: [

            {text:'Physical Examination', bold:true,decoration: 'underline', fontSize:14, lineHeight:2},
            tests_heading,
        ]

        },
        {
            stack: [

            {text:'Diagnosis', bold:true,decoration: 'underline', fontSize:14, lineHeight:2},
            {text:$('#diagnosis_heading').text().slice(9),lineHeight:2}]

        },

         {
            stack: [

            {text:'Treatment', bold:true,decoration: 'underline', fontSize:14, lineHeight:1},
            treatment,
            //    {text:$('#rx_heading').text().slice(9)+"\n\n"}
        ]

        },

        {
            stack: [

            {text:'Recommendations', bold:true,decoration: 'underline', fontSize:14, lineHeight:2},
		    k9,
		    ]

        },

         {
            stack: [

            {text:'Date of subsequent observation', bold:true,decoration: 'underline', fontSize:14, lineHeight:2},
            {text:$('#follow_up_heading').text().slice(30).split(" ")[0]},
            {text:j.join(" ") , lineHeight:2},
            ]

        },


         {
            stack: [


          {text: $('#docSign').text(), font:$('#docSign').css('font-family').replace(/\b[a-zA-Z]/g, (match) => match.toUpperCase()),fontSize:12,alignment:'right'},
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
            fontSize: 14
        }
    }

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







