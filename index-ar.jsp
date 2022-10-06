<%@page pageEncoding="UTF-8" %>
<!DOCTYPE HTML>
<html dir="rtl"  >
    <head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

@font-face {
  font-family: 'RobotoItalic';
  src: url('fonts/Roboto-ThinItalic.ttf');
}

@font-face {
  font-family: 'Caveat';
  src: url('fonts/Caveat-VariableFont_wght.ttf');
}

@font-face {
  font-family: 'Cormorant';
  src: url('fonts/CormorantInfant-MediumItalic.ttf');
}

@font-face {
  font-family: 'Pacifico';
  src: url('fonts/Pacifico-Regular.ttf');
}
@font-face {
  font-family: 'Arial Unicode MS';
  src: url('fonts/arial-unicode-ms.ttf');
}


body {
color:black;
font-family: 'Arial Unicode MS',sans-serif;
text-align: right;
}

html{
color:black;
font-family: 'Arial Unicode MS',sans-serif;
}

    </style>
    </head>
    <body>
        <div class="content" id="queryDiv">
            أدخل رقم البطاقة التعريفية  للمريض <input type="text" style="line-height: 30px;border-radius:5px;" name="patientId" id="patientId">
        <br>
        <br>
        <button type="button" class="btn btn-info" style="line-height: 30px;text-align:center;" onclick="checkD();">احصل على وصفة طبية</button>
        <br>
        <br>
        <div id="errDesc" style="color:red;font-size:x-large">

        </div>


        </div>
        <br>
        <div id="prescription" style="display: none" class="container">
            <div class="col-sm-12 col-md-12" style="text-align: center">
                <h4 style="font-weight: bold;">سيريانا</h3>
            </div>
            <br>
                 <div class="row" style="text-align:center">

                                        <div class="col-md-4 co-sm-4">
                                            &nbsp;
                                        </div>
                                        <div class="col-md-5 col-sm-3" style="margin-right: -42px;">
                                            وصفة طبية إلكتروني
                                        </div>
                                        <div class="col-md-3 co-sm-3">
                                            <button class="btn btn-primary" onclick="createPDF();" >تحميل وصفة طبية</button>
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
                    <div style="text-align: right;margin-top: 0px;width: 100%;">
                        <div style="float: left;">
                             <span style="font-size:25px;padding: 0px;" id="docSign"></span>
                             <br>
                             <div class="pull-right" id="docDetail">
                             </div>
                             <p style="font-size:12pt; margin-top:-0px; padding: 0px;" id="docReg"></p>
                        </div> 
                </div>
                        </div> 
                         <div style="float: right;width: 15%;">
                             <span style="font-size:25px;padding: 0px;" id="docSign1"></span>
                             <br>
                             <div class="pull-right" id="docDetail1">
                             </div>
                             <p style="font-size:12pt; margin-top:-0px; padding: 0px;" id="docReg1"></p>
                         </div>
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
                             url: "https://syrianatest.intelehealth.org/prescription/prescription/visitData",
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

                                    $('#errDesc').text('لم يتم العثور على وصفة طبية');

                                }
                                else
                                {
                                    $('#queryDiv').hide();
                                    $('#prescription').show();
                                      $('#patient_name').html("<b>"+data.name.replaceAll(",", " ") + "</b>");
                                    $('#patient_details').text(' العمر : '+data.age + " | الجنس : "+ (data.gender === 'M' ? 'ذكر': 'أنثى'));
                                    $('#address_and_contact').text('العنوان :  ' + data.address);
                                    wt = parseFloat(data.weight);
                                    ht = parseInt(data.height)/100;
                                    bmi = 0.0;
                                    if(wt && ht) {
                                         bmi = wt / (ht * ht);
                                    }
                                    $('#visit_details').text('رقم البطاقة التعريفية للمريض :  '+data.openMRSID+ " | موعد زيارة : "+data.visitDate);
                                    $('#vitals').html('<b>العلامات الحيوية</b><br> الطول (سم) : '+data.height+' | الوزن (كغ) : '+data.weight+
                                    ' | مؤشر كتلة الجسم :  '+bmi.toFixed(2)+' | ضغط الدم : '+ parseInt(data.sbp).toFixed(0) + '/'+ parseInt(data.dbp).toFixed(0) +' | النبض ( نبضة بالدقيقة) :  '+ data.pulseRate+
                                    ' | درجة الحرارة (فهرنهايت)  :  '+ (data.temperature > 0 ? ((data.temperature * 1.8) + 32).toFixed(0) : 0) + ' | نسبة الأكسجة : '+ data.spo2 + '  معدل التنفس : '+ data.respRate+"<br>");
                            
                                    let complaint1;
                                    if (data.complaint.toString().startsWith("{")) {
                                         let value = JSON.parse(data.complaint.toString());
                                         complaint1 = value["ar"];
                                        }
                                    complaintString= complaint1.trim().split("<br/>");
                                  //  console.log(complaintString);
					//
			 finalComplaint="";
                                    for(counter=0;counter < complaintString.length ; counter++) {
                                        if(complaintString[counter].indexOf("<b>") > -1 && complaintString[counter].indexOf("الأعراض المرافقة") == -1){
						if(counter > 0){
						finalComplaint+=complaintString[counter].slice(5, -2)+"<br>";
						}
						else
						{
							finalComplaint+=complaintString[counter].slice(4, -2)+"<br>";
						}

                                        }
                                    }
                                   
					finalComplaint="";
                                   for(counter=0;counter < complaintString.length ; counter++) {
                                       if(complaintString[counter].indexOf("<b>") > -1 && complaintString[counter].indexOf("الأعراض المرافقة") == -1){
                                           finalComplaint+=complaintString[counter].slice(1, -2);

                                       }
                                   }
                                    $('#complaints_heading').html('<b><u>الشكوى الرئيسية</u></b><br><div style="font-size:14px;">'+finalComplaint +"</div>");
                                    if(data.diagnosis.substring(0,1)==';')
                                    {
                                        $('#diagnosis_heading').html('<b><u>تشخبص</u></b><div style="font-size:14px;">'+getData(data.arDiagnosis)+"<br></div>");
                                    }
                                    else
                                    {
                                    $('#diagnosis_heading').html('<b><u>تشخبص</u></b><div style="font-size:14px;">'+getData(data.arDiagnosis)+"<br></div>");
                                    }
                                    if(data.medication.substring(0,1)==';')
                                    {
                                         $('#rx_heading').html('<b><u>الأدوية</u></b><div style="font-size:14px;">'+getData(data.arMedication)+"<br></div>");

                                    }
                                    else
                                    {
                                        $('#rx_heading').html('<b><u>الأدوية</u></b><div style="font-size:14px;">'+getData(data.arMedication)+"<br></div>");

                                    }

                                    if(data.testsAdvised.substring(0,1)==';')
                                    {
                                        $('#tests_heading').html('<b><u>الاستقصاءات الموصى بها</u></b><div style="font-size:14px;">'+getData(data.arMedicalTests)+"<br></div>");

                                    }
                                    else
                                    {
                                        $('#tests_heading').html('<b><u>الاستقصاءات الموصى بها</u></b><div style="font-size:14px;">'+getData(data.arMedicalTests)+"<br></div>");

                                    }
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
						else if(jks[counter].trim().includes(" "))
						{                      
                            killers+= jks[counter] +"<br>";
						}
                                         }
																				     
                                        //$('#advice_heading').html('<b><u>General Advice</u></b><br><div style="font-size:14px;">'+kk.substr(kk.lastIndexOf(";")+1)+"<br></div>");
    
                                        $('#advice_heading').html('<b><u>نصائح عامة</u></b><div style="font-size:14px;">'+getData(data.arMedicalAdvice)+"</div>");


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
                                                else if(jks[counter].trim().includes(" "))
                                                {
							

						killers+= jks[counter] +"<br>";
						}
					 }
					 console.log(killers)
					
                                        //$('#advice_heading').html('<b><u>General Advice</u></b><br><div style="font-size:14px;">'+data.medicalAdvice.trim().substr(data.medicalAdvice.trim().lastIndexOf(";")+1)+"<br></div>");
                                        $('#advice_heading').html('<b><u>نصائح عامة</u></b><div style="font-size:14px;">'+getData(data.arMedicalAdvice)+"</div>");


                                    }

                                    if(data.followupNeeded.substr(0,1)==';')
                                    {
                                        let followup = data.followupNeeded ? JSON.parse(data.followupNeeded?.trim().substring(1).toString()) : {ar:""};
                                        $('#follow_up_heading').html('<b><u>تاريخ المتابعة</u></b><br><div style="font-size:14px;">'+followup['ar']?.replace(",","<br>")+"<br></div>");
                                    }
                                    else
                                    {                                    
                                        let followup = data.followupNeeded ? JSON.parse(data.followupNeeded?.trim().toString()):{ar:""};
                                        $('#follow_up_heading').html('<b><u>تاريخ المتابعة</u></b><br><div style="font-size:14px;">'+followup['ar']?.replace(",","<br>")+"<br></div>");

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
                                                    $('#docSign').css('font-size' , '50px');
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
                                                        if(docAttributes[i].split(":")[1]) {
                                                            switch(docAttributes[i].split(":")[1]) {
                                                                case "General Physician" : specialization= "طبيب عام"; break;
                                                                default: specialization=docAttributes[i].split(":")[1];
                                                            }
                                                        }

                                                    }

                                                    if(docAttributes[i].indexOf("phoneNumber") > -1)
                                                    {
                                                        phoneNumber="رقم الهاتف  : "+docAttributes[i].split(":")[1];

                                                    }

                                                    if(docAttributes[i].indexOf("emailId") > -1)
                                                    {
                                                        email="البريد الإلكتروني  : "+docAttributes[i].split(":")[1];

                                                    }
                                                    if(docAttributes[i].indexOf("registrationNumber") > -1)
                                                    {
                                                        regNumber="<b> رقم التسجيل  : "+docAttributes[i].split(":")[1]+"</b>";

                                                    }

                                                }
                                    }
                                    fullDets+= qual? qual+ "," +specialization+"<br>":"" +specialization+"<br>";
                                    fullDets+=phoneNumber+"<br>";
                                    fullDets+=email+"<br>";

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

function getData(element) {
    if(element) {
        return element?.replaceAll("#",'<br>');
    } else {
        return ''
    }
}
	

	

            function createPDF() {


var j = $('#follow_up_heading').text().slice(14).split(" ");
j.shift();

		    var tmpK = $('#advice_heading').html().replace('<b><u>نصائح عامة</u></b><div style="font-size:14px;">','')
                nest = tmpK.replace('</div>', '').split("<br>")
		    videoAddresses = [];
		//     nest.pop();
		//    // nest.pop();
		//     for(i=0;i < nest.length ; i++) {
		// 		if(nest[i].indexOf("<") == -1)
		// 		{
		// 			videoAddresses.push("#");											   
		// 		}
		// 		else
		// 		{
		// 			console.log(nest[i].indexOf("<"))											   
		// 			nest[i] = nest[i].substr(0, nest[i].indexOf("<") - 1);										   
		// 		}
		//     }			
		   console.log(nest);	

$('#advice_heading').find('a').each(function() {
	videoAddresses.push($(this).attr('href'))
});

k9 = [];
console.log(videoAddresses);
k9.push("\n");
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
k9.push("\n");										   											   


videoAddress =  $('#advice_heading a:first').attr('href')
var videoDescriptor = $('#advice_heading a:first').parent().text()
var videoLinkPos = videoDescriptor.indexOf("video link")
		    
videoDescriptor = videoDescriptor.substr(0,videoLinkPos -1)
var docDe = $('#docDetail').html().replaceAll("<br>","\n");

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

'Arial Unicode MS' : {
	 normal: 'arial-unicode-ms.ttf',
    bold:'arial-unicode-ms.ttf'
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
k2h2 = tmpComplaints;
k2h2.push("\n");


$("#diagnosis_heading").html($("#diagnosis_heading").html().replaceAll("<br>", "\n"));
$("#rx_heading").html($("#rx_heading").html().replaceAll("<br>", "\n"));
$("#tests_heading").html($("#tests_heading").html().replaceAll("<br>", "\n"));
$("#advice_heading").html($("#advice_heading").html().replaceAll("<br>", "\n"));
//                pdfMake.vfs = pdfFonts.pdfMake.vfs;

                var dd = {
                    "pageSize": "A4",
    content: [
        {

            stack: [
                'سيريانا',
                {text: 'وصفة طبية إلكتروني', style: 'subheader'},
                {canvas: [{ type: 'line', x1: 0, y1: 5, x2: 595-2*40, y2: 5, lineWidth: 1, color:'green' }]}
            ],
            style: 'header'
        },
        {
            stack: [
                {text:$('#patient_name').text(),bold:true,lineHeight: 1.25,alignment:'right', font: 'Arial Unicode MS'},
                {text: $('#patient_details').text(), lineHeight:1.25, alignment:'right',font: 'Arial Unicode MS'},
                {text:$('#address_and_contact').text(), lineHeight:1.25, alignment:'right',font: 'Arial Unicode MS'},
                {text:$('#visit_details').text(), lineHeight:2,alignment:'right', font: 'Arial Unicode MS'}


            ]
        },
        {
            stack: [{text:'الشكوى الرئيسية', decoration: 'underline',bold:true,fontSize:14,alignment:'right',font:'Arial Unicode MS'},
            {text:k2h2, alignment:'right',lineHeight:1}]

        },

        {
            stack: [{text:'العلامات الحيوية',decoration: 'underline', bold:true,alignment:'right',fontSize:14,font:'Arial Unicode MS'},
            {text:$('#vitals').text().slice(16)+"\n\n", alignment:'right',font: 'Arial Unicode MS'}
            ]

        },

        {
            stack: [

            {text:'تشخبص', bold:true,decoration: 'underline', fontSize:14,alignment:'right', lineHeight:2,font:'Arial Unicode MS'},
            {text:$('#diagnosis_heading').text().slice(5),lineHeight:2,alignment:'right',  font: 'Arial Unicode MS'}]

        },

         {
            stack: [

            {text:'الأدوية', bold:true,decoration: 'underline', fontSize:14,alignment:'right', lineHeight:2,font:'Arial Unicode MS'},
            {text:$('#rx_heading').text().slice(7),lineHeight:2,alignment:'right',  font: 'Arial Unicode MS'}]

        },

        {
            stack: [

            {text:'الاستقصاءات الموصى بها', bold:true,decoration: 'underline', alignment:'right',fontSize:14, lineHeight:2,font:'Arial Unicode MS'},
            {text:$('#tests_heading').text().slice(22),lineHeight:2,alignment:'right',font:'Arial Unicode MS' }]

        },

        {
            stack: [

            {text:'نصائح عامة \n\n', bold:true,decoration: 'underline', fontSize:14, alignment:'right', lineHeight:1,font:'Arial Unicode MS'},
            {text:$('#advice_heading').text().slice(10),lineHeight:2,alignment:'right',font:'Arial Unicode MS' }
		    ]

        },

         {
            stack: [

            {text:'تاريخ المتابعة', bold:true,decoration: 'underline', alignment:'right', fontSize:14, lineHeight:2,font:'Arial Unicode MS'},
            {text:$('#follow_up_heading').text().slice(14).split(" ")[0],alignment:'right',font:'Arial Unicode MS'},
            {text:j.join(" ") , alignment:'right',lineHeight:2,font:'Arial Unicode MS'},
            ]

        },


         {
            stack: [


          {text: $('#docSign').text(), font:$('#docSign').css('font-family').replace(/\b[a-zA-Z]/g, (match) => match.toUpperCase()),fontSize:50,alignment:'left'},
            {text:docDe, alignment:'left',lineHeight:1},
            {text:$('#docReg').text(), bold:true,alignment:'left'}
            ]

        },





    ],
    styles: {
        header: {
            fontSize: 18,
            bold: true,
            alignment: 'center',
	    font:'Arial Unicode MS',	
            margin: [0, 10, 0, 10]
        },
        subheader: {
            fontSize: 14,
		font:'Arial Unicode MS',
        },
    },
	defaultStyle: {
font: 'Arial Unicode MS',
fontSize:10
}

}
fileName = getParameterByName("v").slice(-5)+"_prescription";


pdfMake.createPdf(dd, null, fonts).download(fileName)
alert('سيتم تحميل الوصفة الطبية قريبًا');
            }
        </script>
    </body>
    <script src="js/jquery-3.5.1.min.js" ></script>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/pdfmake.min.js"></script>
<script src="js/vfs_fonts.js"></script>

</html>