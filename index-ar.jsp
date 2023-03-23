<%@page pageEncoding="UTF-8" %>
    <!DOCTYPE HTML>
    <html dir="rtl">

    <head>
        <META http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/bootstrap.min.css">
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
                src: url('fonts/Arty.ttf');
            }

            @font-face {
                font-family: 'almondita';
                src: url('fonts/almondita.ttf');
            }

            @font-face {
                font-family: 'signature';
                src: url('fonts/almondita.ttf');
            }

            @font-face {
                font-family: 'terecia';
                src: url('fonts/Terecia.ttf');
            }

            @font-face {
                font-family: 'signature';
                src: url('fonts/signature.ttf');
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
                color: black;
                font-family: 'Arial Unicode MS', sans-serif;
                text-align: right;
            }

            html {
                color: black;
                font-family: 'Arial Unicode MS', sans-serif;
            }
        </style>
    </head>

    <body>
        <div class="content" id="queryDiv">
            أدخل رقم البطاقة التعريفية للمريض <input type="text" style="line-height: 30px;border-radius:5px;"
                name="patientId" id="patientId">
            <br>
            <br>
            <button type="button" class="btn btn-info" style="line-height: 30px;text-align:center;"
                onclick="checkD();">احصل على وصفة طبية</button>
            <br>
            <br>
            <div id="errDesc" style="color:red;font-size:x-large">

            </div>


        </div>
        <br>
        <div id="prescription" style="display: none" class="container">
            <div class="row" style="text-align:center;margin-right: 0px; margin-left: 0px;">
                <div class="col-md-3">
                    <!-- <img src="sila.png" width="50%" /> -->
                </div>
                <div class="col-md-6" style="text-align: center;padding-top: 10px;font-size:15pt;">
                    <span id="projectName"><strong> فريق الصحي
                        </strong></span>
                </div>
                <div class="col-md-3" style="text-align: center;padding-top: 10px;">
                    <!-- <img src="ih-logo.png" width="50%" /> -->
                </div>
            </div>
            <br />
            <div class="row" style="text-align:center;margin-right: 0px; margin-left: 0px;">

                <div class="col-md-3">
                    &nbsp;
                </div>
                <div class="col-md-6">
                    <u><b>وصفة طبية إلكتروني</b></u>
                </div>
                <div class="col-md-3">
                    <button class="btn btn-primary" onclick="createPDF();">تحميل وصفة طبية</button>
                </div>

            </div>


            <hr style="height:  18px;">


            <br>
            <div id="detailDiv" style="margin:0px">
                <p id="patient_info" style="font-size:12pt; margin: 0px; padding: 0px;"></p></b>
                <p id="patient_name" style="font-size:12pt; margin: 0px; padding: 0px;"></p></b>
                <p id="patient_details" style="font-size:12pt; margin: 0px; padding: 0px;"> </p>
                <p id="address_and_contact" style="font-size:12pt; margin: 0px; padding: 0px;"></p>
                <p id="visit_details" style="font-size:12pt; margin-top:5px; margin-bottom:0px; padding: 0px;"></p>
                <p id="complaints_heading" style="font-size:15pt;margin-top:5px; margin-bottom:0px; padding: 0px;"></p>
                <b>
                    <p id="vitals_heading" style="font-size:12pt;margin-top:5px; margin-bottom:0px;; padding: 0px;"></p>
                </b>
                <p id="diagnosis_heading" style="font-size:15pt;margin-top:5px; margin-bottom:0px; padding: 0px;"></p>
                <p id="rx_heading" style="font-size:15pt;margin-top:5px; margin-bottom:0px; padding: 0px;"></p>
                <p id="tests_heading" style="font-size:15pt;margin-top:5px; margin-bottom:0px; padding: 0px;"></p>
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
            function checkD() {
                $('#errDesc').text('');

                jQuery.ajax({
                    url: "https://services.sila.care/prescription/prescription/visitData",
                    type: "POST",
                    data: JSON.stringify({
                        visitId: getParameterByName("v"),
                        patientId: $('#patientId').val()
                    }),
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        //
                        //var jsondata = JSON.parse(data);

                        console.log(data.status);
                        //   localStorage.setItem("doctorSignatureImage", data.imageOfSignature);
                        if (data.status == "No Data found") {
                            console.log('Hello World');

                            $('#errDesc').text('لم يتم العثور على وصفة طبية');

                        }
                        else {
                            $('#queryDiv').hide();
                            $('#prescription').show();
                            $('#projectName').html("<strong>فريق الصحي</strong>");
                            $('#patient_info').html("<b style=font-size:15pt;><u>معلومات المريض</u></b>");
                            $('#patient_name').html("الاسم :  " + data.name.replaceAll(",", " ") + "</br>");
                            $('#patient_details').text(' العمر : ' + data.age + " | الجنس : " + (data.gender === 'M' ? 'ذكر' : 'أنثى'));
                            $('#address_and_contact').text('العنوان : NA'+ "," +(data.citizenId === "-" ? "غير مزود" : data.citizenId));
                            wt = parseFloat(data.weight);
                            ht = parseInt(data.height) / 100;
                            bmi = 0.0;
                            if (wt && ht) {
                                bmi = wt / (ht * ht);
                            }
                            $('#visit_details').text('رقم الاضبارة :  ' + data.openMRSID + "| تاريخ الزيارة : " + getFollowup(moment(data.visitDate).format('DD-MMMM-YYYY')));
                            // $('#vitals').html('<b><u>العلامات الحيوية</u></b><br> الطول (سم) : '+data.height+' | الوزن (كغ) : '+data.weight+
                            // ' | مؤشر كتلة الجسم :  '+bmi.toFixed(2)+' | ضغط الدم : '+ parseInt(data.sbp).toFixed(0) + '/'+ parseInt(data.dbp).toFixed(0) +' | النبض ( نبضة بالدقيقة) :  '+ data.pulseRate+
                            // ' | درجة الحرارة (فهرنهايت)  :  '+ (data.temperature > 0 ? ((data.temperature * 1.8) + 32).toFixed(2) : 0) + ' | نسبة الأكسجة : '+ data.spo2 + '  معدل التنفس : '+ data.respRate+"<br>");

                            let complaint1;
                            if (data.complaint.toString().startsWith("{")) {
                                let value = JSON.parse(data.complaint.toString());
                                complaint1 = value["ar"];
                            }
                            complaintString = complaint1?.trim().split("<br/>");
                            //  console.log(complaintString);
                            //
                            finalComplaint = "";
                            for (counter = 0; counter < complaintString?.length; counter++) {
                                if (complaintString[counter].indexOf("<b>") > -1 && complaintString[counter].indexOf("الأعراض المرافقة") == -1) {
                                    if (counter > 0) {
                                    finalComplaint += "<li>" + complaintString[counter].slice(5, -2) + "</li>";
                                }
                                else {
                                    finalComplaint += "<li>" + complaintString[counter].slice(4, -2) + "</li>"
                                }

                                }
                            }

                            $('#complaints_heading').html('<b><u>سبب الزيارة</u></b><br><div style="font-size:12pt;">' + finalComplaint + "</div>");
                            if (data.diagnosis.substring(0, 1) == ';') {
                                let diagnosis = getData(data.arDiagnosis)?.split("<br>");
                            finalDiagnosis = "";
                            for (counter = 0; counter < diagnosis.length; counter++) {
                                finalDiagnosis += "<li>" + diagnosis[counter] + "</li>";
                            }
                                $('#diagnosis_heading').html('<b><u> التشخيص</u></b><div style="font-size:12pt;">' + finalDiagnosis + "</div>");
                            }

                            if (data.arMedication) {
                              let med = getData(data.arMedication)?.split("<br>");
                            finalMedication = "";
                            for (counter = 0; counter < med.length; counter++) {
                                finalMedication += "<li>" + med[counter] + "</li>";
                            }
                                $('#rx_heading').html('<b><u>الخطة العلاجية</u></b><div style="font-size:12pt;">' + finalMedication + "</div>");

                            }

                            if (data.arMedicalTests) {
                                let testsAdvised = getData(data.arMedicalTests)?.split("<br>");
                            finalTest = "";
                            for (counter = 0; counter < testsAdvised.length; counter++) {
                                finalTest += "<li>" + testsAdvised[counter] + "</li>";
                            }
                                $('#tests_heading').html('<b><u>التحاليل و الفحوصات المطلوبة</u></b><div style="font-size:12pt;">' + finalTest + "</div>");

                            }

                            if (data.arMedicalAdvice) {
                            let medicalAdvice = getData(data.arMedicalAdvice)?.split("<br>");
                            finalMedicalAdvice = "";
                            for (counter = 0; counter < medicalAdvice.length; counter++) {
                                if (!medicalAdvice[counter].includes("Audio"))
                                    finalMedicalAdvice += "<li>" + medicalAdvice[counter] + "</li>";
                            }
                                $('#advice_heading').html('<b><u>توجيهات عامة</u></b><div style="font-size:12pt;">' + finalMedicalAdvice + "</div>");


                            }

                            if (data.followupNeeded) {
                                let followup = data.followupNeeded ? JSON.parse(data.followupNeeded?.trim().substring(1).toString()) : { ar: "" };
                                $('#follow_up_heading').html('<b><u> تاريخ زيارة المتابعة</u></b><br><div style="font-size:12pt;"><li>' + getFollowup(followup['ar']) + "</li><br></div>");
                            }




                            var docName = data.doctorName.replace(",", " ");
                            var fullDets = "";
                            fullDets += docName;
                            fullDets += "<br>";

                            var docAttributes = data.doctorAttributes.split("|");
                            var tmpAttributes = new Array();

                            var qual = "";
                            var specialization = "";
                            var phoneNumber = "";
                            var email = "";
                            var regNumber = "";
                            for (i = 0; i < docAttributes.length; i++) {
                                if (docAttributes[i].indexOf("fontOfSign") > -1) {
                                    $('#docSign').css('font-family', docAttributes[i].split(":")[1]);
                                    $('#docSign').css('font-size', '50px');
                                }
                                if (docAttributes[i].indexOf("textOfSign") > -1) {
                                    $('#docSign').text(docAttributes[i].split(":")[1]);


                                }

                                if ((docAttributes[i].indexOf("textOfSign") == -1) && (docAttributes[i].indexOf("fontOfSign") == -1)) {
                                    if (docAttributes[i].indexOf("qualification") > -1) {
                                        qual = docAttributes[i].split(":")[1];

                                    }
                                    if (docAttributes[i].indexOf("specialization") > -1) {
                                        if (docAttributes[i].split(":")[1]) {
                                            switch (docAttributes[i].split(":")[1]) {
                                                case "General Physician": specialization = "طبيب عام"; break;
                                                default: specialization = docAttributes[i].split(":")[1];
                                            }
                                        }

                                    }

                                    if (docAttributes[i].indexOf("phoneNumber") > -1) {
                                        phoneNumber = "رقم الهاتف  : " + docAttributes[i].split(":")[1];

                                    }

                                    if (docAttributes[i].indexOf("emailId") > -1) {
                                        email = "البريد الإلكتروني  : " + docAttributes[i].split(":")[1];

                                    }
                                    if (docAttributes[i].indexOf("registrationNumber") > -1) {
                                        regNumber = "رقم التسجيل  : " + docAttributes[i].split(":")[1];

                                    }

                                }
                            }
                            // fullDets+= qual? qual+ "," +specialization+"<br>":"" +specialization+"<br>";
                            // fullDets += phoneNumber + "<br>";
                            fullDets += email + "<br>";

                            //fullDets+=regNumber+"<br>";

                            $('#docDetail').html(fullDets);
                            $('#docReg').html(regNumber);

                            $('#docSImage').attr('src', data.imageOfSignature);





                        }
                    }
                });




            }
            function createTable(tableData, columns) {
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

                data.forEach(function (row) {

                    body.push(row);
                });

                return body;
            }

            function getData(element) {
                if (element) {
                    return element?.replaceAll("#", '<br>');
                } else {
                    return ''
                }
            }

            function getFollowup(data) {
                let followUp_date = data
                    .replace("January", "كانون الثاني")
                    .replace("February", "شهر شباط")
                    .replace("March", "شهر اذار")
                    .replace("April", "أشهر نيسان")
                    .replace("May", "شهر أيار")
                    .replace("June", "شهر حزيران")
                    .replace("July", "شهر تموز")
                    .replace("August", "شهر أب")
                    .replace("September", "شهر أيلول")
                    .replace("October", "شهر تشرين الأول")
                    .replace("November", "شهر تشرين الثاني")
                    .replace("December", "شهر كانون الأول");
                return followUp_date;
            }



            function createPDF() {
                var docDe = $('#docDetail').html().replaceAll("<br>", "\n");

                var fonts = {
                    Asem: {
                        normal: 'Asem.ttf',
                        bold: 'Asem.ttf',
                        italics: 'Asem.ttf',
                        bolditalics: 'Asem.ttf'

                    },
                    Youthness: {
                        normal: 'Youthness.ttf'
                    },

                    'Arial Unicode MS': {
                        normal: 'arial-unicode-ms.ttf',
                        bold: 'arial-unicode-ms.ttf'
                    },

                    Arty: {
                        normal: 'Arty.ttf'
                    },

                    Almondita: {
                        normal: 'almondita.ttf',
                        bold: 'almondita.ttf',
                        italics: 'almondita.ttf',
                        bolditalics: 'almondita.ttf'
                    },
                    Margareta: {
                        normal: 'margareta.ttf',
                        bold: 'margareta.ttf',
                        italics: 'margareta.ttf',
                        bolditalics: 'margareta.ttf'
                    },
                    Siganature: {
                        normal: 'signature.ttf',
                        bold: 'signature.ttf',
                        italics: 'signature.ttf',
                        bolditalics: 'signature.ttf'
                    },
                    Terecia: {
                        normal: 'Terecia.ttf',
                        bold: 'Terecia.ttf',
                        italics: 'Terecia.ttf',
                        bolditalics: 'Terecia.ttf'
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
                for (index = 1; index < tmpComplaints.length; index++) {
                    n = tmpComplaints[index].replaceAll('<div style="font-size:12pt;">', "");
                    n1 = n.replace("<b>", "");
                    n2 = n1.replace("</b>", "");
                    n3 = n2.replace("<u>", "");
                    n4 = n3.replace("</u>", "");
                    n5 = n4.replace("<ul>", "");
                    n6 = n5.replace("</ul>", "");
                    n7 = n6.replaceAll("<li>", "\u2022");
                    n8 = n7.replaceAll("</li>", "\n");
                    n9 = n8.replace(/<\/?[^>]+(>|$)/g, "");
                    n10 = n9.replace("&amp;", "& ");
                    tmpComplaints[index] = n10;

                }
                tmpComplaints.shift();
                k2h2 = tmpComplaints;
                k2h2.push("\n\n");


            $("#diagnosis_heading").html($("#diagnosis_heading").html().replaceAll("<li>", "\u2022").replaceAll("</li>", "\n"));
            $("#rx_heading").html($("#rx_heading").html().replaceAll("<li>", "\u2022").replaceAll("</li>", "\n"));
            $("#tests_heading").html($("#tests_heading").html().replaceAll("<li>", "\u2022").replaceAll("</li>", "\n"));
            $("#advice_heading").html($("#advice_heading").html().replaceAll("<li>", "\u2022").replaceAll("</li>", "\n"));
            $("#follow_up_heading").html($("#follow_up_heading").html().replaceAll("<li>", "\u2022").replaceAll("</li>", "\n"));


                var dd = {
                    "pageSize": "A4",
                    content: [
                        {

                            stack: [
                                {
                                    columns: [
                                        {
                                            text: "الصحي فريق",
                                            fontSize: 20,
                                            bold: true
                                        }
                                    ],
                                },
                                { text: 'وصفة طبية إلكتروني', style: 'subheader' },
                                { canvas: [{ type: 'line', x1: 0, y1: 5, x2: 595 - 2 * 40, y2: 5, lineWidth: 1, color: 'green' }] }
                            ],
                            style: 'header'
                        },
                        {
                            stack: [
                                { text: $('#patient_info').text(), alignment: 'right', decoration: 'underline', bold: true, fontSize: 14, lineHeight: 1.25, font: 'Arial Unicode MS' },
                                { text: $('#patient_name').text(), bold: true, lineHeight: 1.25, alignment: 'right', font: 'Arial Unicode MS' },
                                { text: $('#patient_details').text(), lineHeight: 1.25, alignment: 'right', font: 'Arial Unicode MS' },
                                { text: $('#address_and_contact').text(), lineHeight: 1.25, alignment: 'right', font: 'Arial Unicode MS' },
                                { text: $('#visit_details').text(), lineHeight: 2, alignment: 'right', font: 'Arial Unicode MS' },
                            ]
                        },
                        {
                            stack: [{ text: 'سبب الزيارة', bold: true, fontSize: 14, alignment: 'right', decoration: 'underline', font: 'Arial Unicode MS' },
                            { text: k2h2, alignment: 'right', lineHeight: 1 }]

                        },

                        // {
                        //     stack: [{text:'العلامات الحيوية',decoration: 'underline', bold:true,alignment:'right',fontSize:14,font:'Arial Unicode MS'},
                        //     {text:$('#vitals').text().slice(16)+"\n\n", lineHeight:1, alignment:'right',font: 'Arial Unicode MS'}
                        //     ]

                        // },

                        {
                            stack: [

                                { text: 'التشخيص', bold: true, fontSize: 14, alignment: 'right', decoration: 'underline', lineHeight: 2, font: 'Arial Unicode MS' },
                                { text: $('#diagnosis_heading').text().slice(7) + "\n", lineHeight: 1, alignment: 'right', font: 'Arial Unicode MS' }]

                        },

                        {
                            stack: [

                                { text: 'الخطة العلاجية', bold: true, fontSize: 14, alignment: 'right', decoration: 'underline', lineHeight: 2, font: 'Arial Unicode MS' },
                                { text: $('#rx_heading').text().slice(14), lineHeight: 2, alignment: 'right', font: 'Arial Unicode MS' }]

                        },

                        {
                            stack: [

                                { text: 'التحاليل و الفحوصات المطلوبة', decoration: 'underline', bold: true, alignment: 'right', fontSize: 14, lineHeight: 2, font: 'Arial Unicode MS' },
                                { text: $('#tests_heading').text().slice(28) + "\n", lineHeight: 1, alignment: 'right', font: 'Arial Unicode MS' }]

                        },

                        {
                            stack: [

                                { text: 'توجيهات عامة \n\n', bold: true, fontSize: 14, decoration: 'underline', alignment: 'right', lineHeight: 1, font: 'Arial Unicode MS' },
                                { text: $('#advice_heading').text().slice(12), lineHeight: 2, alignment: 'right', font: 'Arial Unicode MS' }
                            ]

                        },

                        {
                            stack: [

                                { text: ' تاريخ زيارة المتابعة', bold: true, decoration: 'underline', alignment: 'right', fontSize: 14, lineHeight: 2, font: 'Arial Unicode MS' },
                                { text: $('#follow_up_heading').text().slice(21), lineHeight: 2, alignment: 'right', font: 'Arial Unicode MS' },
                            ]

                        },


                        {
                            stack: [


                                { text: $('#docSign').text(), font: $('#docSign').css('font-family').replace(/\b[a-zA-Z]/g, (match) => match.toUpperCase()), fontSize: 50, alignment: 'left' },
                                { text: docDe, alignment: 'left', lineHeight: 1 },
                                { text: $('#docReg').text(), alignment: 'left' }
                            ]

                        },





                    ],
                    styles: {
                        header: {
                            fontSize: 18,
                            bold: true,
                            alignment: 'center',
                            font: 'Arial Unicode MS',
                            margin: [0, 10, 0, 10]
                        },
                        subheader: {
                            fontSize: 14,
                            font: 'Arial Unicode MS',
                            decoration: "underline"
                        }
                    },
                    defaultStyle: {
                        font: 'Arial Unicode MS',
                        fontSize: 10,
                    },


                }
                fileName = getParameterByName("v").slice(-5) + "_prescription";


                pdfMake.createPdf(dd, null, fonts).download(fileName)
                alert('سيتم تحميل الوصفة الطبية قريبًا');
            }
        </script>
    </body>
    <script src="js/jquery-3.5.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/pdfmake.min.js"></script>
    <script src="js/vfs_fonts.js"></script>
    <script src="https://momentjs.com/downloads/moment.min.js"></script>

    </html>