<%@page pageEncoding="UTF-8" %>

    <!DOCTYPE HTML>
    <html>

    <head>
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
                src: url('fonts/signature.ttf');
            }

            @font-face {
                font-family: 'terecia';
                src: url('fonts/Terecia.ttf');
            }



            @font-face {
                font-family: 'Rajdhani';
                src: url('fonts/Rajdhani-Regular.ttf');
            }



            body {
                color: black;
                font-family: 'Rajdhani', sans-serif;
            }

            html {
                color: black;
            }
        </style>
    </head>

    <body>
        <div class="content" id="queryDiv">
            Enter Patient ID <input type="text" style="line-height: 30px;border-radius:5px;" name="patientId"
                id="patientId">
            <br>
            <br>
            <button type="button" class="btn btn-info" style="line-height: 30px;text-align:center;width:150px;"
                onclick="checkD();">Get Prescription</button>
            <br>
            <br>
            <div id="errDesc" style="color:red;font-size:x-large">

            </div>


        </div>
        <br>
        <div id="prescription" style="display: none" class="container">
            <div class="row" style="text-align:center">
                <div class="col-md-2 col-sm-2">
                    <img src="ih-logo.png" width="50%">
                </div>
                <div class="col-md-7 col-sm-8" style="text-align:center">
                    <span> <strong>Arogya Sampada Telemedicine</strong></span>
                    <br>
                    <span>
                        <strong>आरोग्य संपदा टेलिमेडिसिन</strong>
                    </span>
                </div>
                <div class="col-md-2 col-sm-2 pull-right">
                    <img src="nas-logo.png" width="40%">
                </div>
            </div>
            <br>
            <div class="row" style="text-align:center">

                <div class="col-md-4 col-sm-4">
                    &nbsp;
                </div>
                <div class="col-md-3 col-sm-3" style="font-size:14">
                    <u> <b>ePrescription</b></u>
                </div>
                <div class="col-md-5 co-sm-3">
                    <button class="btn btn-primary" onclick="createPDF();">Download Prescription</button>
                </div>

            </div>
            <hr style="height:  18px;">
            <div id="detailDiv" style="margin:0px">
                <p id="patient_name" style="font-size:12pt; margin: 0px; padding: 0px;"></p></b>
                <p id="patient_details" style="font-size:12pt; margin: 0px; padding: 0px;"> </p>
                <p id="address_and_contact" style="font-size:12pt; margin: 0px; padding: 0px;"></p>
                <p id="visit_details" style="font-size:12pt; margin-top:5px; margin-bottom:0px; padding: 0px;"></p>
                <b>
                    <p id="vitals_heading" style="font-size:12pt;margin-top:5px; margin-bottom:0px;; padding: 0px;"></p>
                </b>
                <p id="vitals" style="font-size:12pt;margin:0px; padding: 0px;"></p>
                <p id="complaints_heading" style="font-size:15pt;margin-top:5px; margin-bottom:0px; padding: 0px;"></p>

                <p id="diagnosis_heading" style="font-size:15pt;margin-top:5px; margin-bottom:0px; padding: 0px;"></p>
                <p id="rx_heading" style="font-size:15pt;margin-top:5px; margin-bottom:0px; padding: 0px;"></p>
                <p id="tests_heading" style="font-size:15pt;margin-top:5px; margin-bottom:0px; padding: 0px;"></p>

                <p id="advice_heading" style="font-size:15pt;margin-top:5px; margin-bottom:0px; padding: 0px;"></p>

                <p id="follow_up_heading" style="font-size:15pt;margin-top:5px; margin-bottom:0px; padding: 0px;"></p>

                <div style="text-align:right;margin-right:50px;margin-top:0px;">
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
            function checkD() {
                $('#errDesc').text('');

                jQuery.ajax({
                    url: "https://as.intelehealth.org/prescription/prescription/visitData",
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

                            $('#errDesc').text('No Prescription Found');

                        }
                        else {
                            $('#queryDiv').hide();
                            $('#prescription').show();
                            $('#patient_name').html("<b>" + data.name.replaceAll(",", " ") + "</b>");
                            $('#patient_details').text('Age: ' + data.age + " | Gender: " + data.gender);
                            $('#address_and_contact').text('Address: ' + data.address);
                            wt = parseFloat(data.weight);
                            ht = parseInt(data.height) / 100;
                            bmi = 0.0;
                            if (wt && ht) {
                                bmi = wt / (ht * ht);
                            }
                            $('#visit_details').text('Patient Id: ' + data.openMRSID + " | Date of visit: " + data.visitDate);
                            if (data.height.length > 0 || data.weight.length > 0 || data.sbp.length > 0 || data.dbp.length > 0 || data.pulseRate.length > 0 ||
                                data.respRate.length > 0 || data.haemoGlobin.length > 0 || data.bloodGroup.length > 0 || data.sugarRandom.length > 0 || data.sugarFasting.length > 0) {
                                $('#vitals').html('<b>Vitals</b><br>Height(cm): ' + data.height + ' | Weight(kg): ' + data.weight +
                                    ' | BMI: ' + bmi.toFixed(2) + ' | Blood Pressure: ' + parseInt(data.sbp).toFixed(0) + '/' + parseInt(data.dbp).toFixed(0) +
                                    ' | Pulse(bpm): ' + data.pulseRate + ' | Respiratory Rate: ' + data.respRate + ' | Hemoglobin: ' + (data.haemoGlobin ? data.haemoGlobin : "-") +
                                    ' | Blood Group: ' + (data.bloodGroup ? data.bloodGroup : "-") + ' | Sugar Level(Fasting/After Meal): ' + ((data.sugarFasting && data.sugarAfterMeal) ? (data.sugarFasting + "/" + data.sugarAfterMeal) : "-") +
                                    ' | Sugar Level - Random: ' + (data.sugarRandom ? data.sugarRandom : "-") + "<br>");
                            }
                            complaintString = data.complaint.trim().split("<br/>");
                            //  console.log(complaintString);
                            //
                            finalComplaint = "";
                            for (counter = 0; counter < complaintString.length; counter++) {
                                if (complaintString[counter].indexOf("<b>") > -1 && complaintString[counter].indexOf("Associated symptoms") == -1) {
                                    if (counter > 0) {
                                        finalComplaint += complaintString[counter].slice(5, -2) + "<br>";
                                    }
                                    else {
                                        finalComplaint += complaintString[counter].slice(4, -2) + "<br>";
                                    }

                                }
                            }

                            //			finalComplaint="";
                            //                    for(counter=0;counter < complaintString.length ; counter++) {
                            //                        if(complaintString[counter].indexOf("<b>") > -1 && complaintString[counter].indexOf("Associated symptoms") == -1){
                            //                            finalComplaint+=complaintString[counter].slice(1, -2);

                            //                       }
                            //                  }

                            $('#complaints_heading').html('<b><u>Presenting complaint</u></b><br><div style="font-size:14px;">' + finalComplaint + "</div>");
                            if (data.diagnosis.trim().length > 0) {
                                if (data.diagnosis.substring(0, 1) == ';') {
                                    $('#diagnosis_heading').html('<b><u>Diagnosis</u></b><br><div style="font-size:14px;">' + data.diagnosis.trim().substring(1) + "<br></div>");
                                }
                                else {
                                    $('#diagnosis_heading').html('<b><u>Diagnosis</u></b><br><div style="font-size:14px;">' + data.diagnosis.trim() + "<br></div>");
                                }
                            }
                            if (data.medication.trim().length > 0) {
                                if (data.medication.substring(0, 1) == ';') {
                                    let med = data.medication.trim().substring(1).replaceAll(";", "<br>")
                                    $('#rx_heading').html('<b><u>Medication(s)</u></b><br><div style="font-size:14px;">' + med.trim() + "<br></div>");

                                }
                                else {
                                    let med = data.medication.trim().replaceAll(";", "<br>")
                                    $('#rx_heading').html('<b><u>Medication(s)</u></b><br><div style="font-size:14px;">' + med.trim() + "<br></div>");

                                }
                            }
                            if (data.testsAdvised.trim().length > 0) {
                                if (data.testsAdvised.substring(0, 1) == ';') {
                                    let tests = data.testsAdvised.trim().substring(1).replaceAll(";", "<br>")
                                    $('#tests_heading').html('<b><u>Recommended Investigation(s)</u></b><br><div style="font-size:14px;">' + tests.trim() + "<br></div>");

                                }
                                else {
                                    let tests = data.testsAdvised.trim().replaceAll(";", "<br>")
                                    $('#tests_heading').html('<b><u>Recommended Investigation(s)</u></b><br><div style="font-size:14px;">' + tests.trim() + "<br></div>");

                                }
                            }
                            if (data.medicalAdvice.trim().length > 0 && data.medicalAdvice.trim().length !== 1) {
                                if (data.medicalAdvice.substring(0, 1) == ';') {

                                    kk = data.medicalAdvice.trim().substr(1)

                                    console.log(kk)
                                    jks = kk.split(";")
                                    killers = ""
                                    for (counter = 0; counter < jks.length; counter++) {
                                        if (jks[counter].indexOf("Audio") > -1) {
                                        }
                                        else if (jks[counter].trim().includes(" ")) {
                                            killers += jks[counter] + "<br>";
                                        }
                                    }

                                    //$('#advice_heading').html('<b><u>General Advice</u></b><br><div style="font-size:14px;">'+kk.substr(kk.lastIndexOf(";")+1)+"<br></div>");

                                    $('#advice_heading').html('<b><u>General Advice</u></b><div style="font-size:14px;">' + killers + "</div>");


                                }
                                else {
                                    kk = data.medicalAdvice.trim()
                                    jks = kk.split(";")
                                    killers = ""
                                    for (counter = 0; counter < jks.length; counter++) {
                                        if (jks[counter].indexOf("Audio") > -1) {
                                        }
                                        else if (jks[counter].trim().includes(" ")) {


                                            killers += jks[counter] + "<br>";
                                        }
                                    }
                                    console.log(killers)

                                    //$('#advice_heading').html('<b><u>General Advice</u></b><br><div style="font-size:14px;">'+data.medicalAdvice.trim().substr(data.medicalAdvice.trim().lastIndexOf(";")+1)+"<br></div>");
                                    $('#advice_heading').html('<b><u>General Advice</u></b><div style="font-size:14px;">' + killers + "</div>");


                                }
                            }
                            if (data.followupNeeded.trim().length > 0) {
                                if (data.followupNeeded.substr(0, 1) == ';') {

                                    $('#follow_up_heading').html('<b><u>Follow Up Date</u></b><br><div style="font-size:14px;">' + data.followupNeeded.trim().substring(1).replace(",", "<br>") + "<br></div>");
                                }
                                else {
                                    $('#follow_up_heading').html('<b><u>Follow Up Date</u></b><br><div style="font-size:14px;">' + data.followupNeeded.trim().replace(",", "<br>") + "<br></div>");

                                }
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


                                }
                                if (docAttributes[i].indexOf("textOfSign") > -1) {
                                    $('#docSign').text(docAttributes[i].split(":")[1]);


                                }

                                if ((docAttributes[i].indexOf("textOfSign") == -1) && (docAttributes[i].indexOf("fontOfSign") == -1)) {
                                    if (docAttributes[i].indexOf("qualification") > -1) {
                                        qual = docAttributes[i].split(":")[1];

                                    }
                                    if (docAttributes[i].indexOf("specialization") > -1) {
                                        specialization = docAttributes[i].split(":")[1];

                                    }

                                    if (docAttributes[i].indexOf("phoneNumber") > -1) {
                                        phoneNumber = "Phone Number: " + docAttributes[i].split(":")[1];

                                    }

                                    if (docAttributes[i].indexOf("emailId") > -1) {
                                        email = "E-Mail: " + docAttributes[i].split(":")[1];

                                    }
                                    if (docAttributes[i].indexOf("registrationNumber") > -1) {
                                        regNumber = "<b>Registration No: " + docAttributes[i].split(":")[1] + "</b>";

                                    }

                                }
                            }
                            fullDets += qual ? qual + "," + specialization + "<br>" : "" + specialization + "<br>";
                            fullDets += phoneNumber + "<br>";
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



            function createPDF() {


                var j = $('#follow_up_heading').text().slice(14).split(" ");
                j.shift();

                var tmpK = $('#advice_heading').html().replace('<b><u>General Advice</u></b><div style="font-size:14px;">', '')
                nest = tmpK.split("<br>")
                videoAddresses = [];
                nest.pop();
                // nest.pop();
                for (i = 0; i < nest.length; i++) {
                    if (nest[i].indexOf("<") == -1) {
                        videoAddresses.push("#");
                    }
                    else {
                        console.log(nest[i].indexOf("<"))
                        nest[i] = nest[i].substr(0, nest[i].indexOf("<") - 1);
                    }
                }
                console.log(nest);

                $('#advice_heading').find('a').each(function () {
                    videoAddresses.push($(this).attr('href'))
                });

                k9 = [];
                if (nest.length > 0) {
                    console.log(videoAddresses);
                    k9.push("\n");
                    for (nn = 0; nn < nest.length; nn++) {
                        if (videoAddresses[nn] == "#") {
                            k9.push({ text: nest[nn] })
                        }
                        else {
                            k9.push({ text: nest[nn] + "Video Link ", link: videoAddresses[nn] })
                        }

                    }
                    k9.push("\n");
                }

                var medication = $('#rx_heading').html().replace('<b><u>Medication(s)</u></b><br><div style="font-size:14px;">', '')
                var medications = medication.replaceAll("<br>", "\n").replace("</div>", "\n");

                var tmpK = $('#tests_heading').html().replace('<b><u>Recommended Investigation(s)</u></b><br><div style="font-size:14px;">', '')
                var tests = tmpK.replaceAll("<br>", "\n").replace("</div>", "\n");

                videoAddress = $('#advice_heading a:first').attr('href')
                var videoDescriptor = $('#advice_heading a:first').parent().text()
                var videoLinkPos = videoDescriptor.indexOf("video link")

                videoDescriptor = videoDescriptor.substr(0, videoLinkPos - 1)
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
                for (index = 1; index < tmpComplaints.length; index++) {
                    n = tmpComplaints[index].replaceAll('<div style="font-size:14px;">', "");
                    n1 = n.replace("<b>", "");
                    n2 = n1.replace("</b>", "");
                    n3 = n2.replace("<u>", "");
                    n4 = n3.replace("</u>", "");
                    n5 = n4.replace(/<\/?[^>]+(>|$)/g, "");
                    n6 = n5.replace("&amp;", "& ");
                    tmpComplaints[index] = n6;

                }
                tmpComplaints.shift();
                k2h2 = tmpComplaints;
                k2h2.push("\n");

                //                pdfMake.vfs = pdfFonts.pdfMake.vfs;

                var dd = {
                    "pageSize": "A4",
                    content: [
                        {

                            stack: [

                                {
                                    columns: [
                                        {
                                            image: 'ih_logo',
                                            width: 100,
                                            height: 38
                                      
                                        },
                                        {
                                            text: 'Arogya Sampada Telemedicine \n आरोग्य संपदा टेलिमेडिसिन', fontSize: 12
                                        },

                                        {
                                            image: 'nas_logo',
                                            width: 60,
                                            height: 60
                                        },

                                    ]
                                },
                                { text: 'ePrescription', style: 'subheader' },
                                {canvas: [{ type: 'line', x1: 0, y1: 5, x2: 595-2*40, y2: 5, lineWidth: 1, color:'green' }]}
                            ],
                            style: 'header'
                        },
                        {
                            stack: [
                                { text: $('#patient_name').text(), bold: true, lineHeight: 1.25 },
                                { text: $('#patient_details').text(), lineHeight: 1.25 },
                                { text: $('#address_and_contact').text(), lineHeight: 1.25 },
                                { text: $('#visit_details').text(), lineHeight: 2 }


                            ]
                        },
                        {
                            stack: [{ text: 'Presenting complaint', bold: true, fontSize: 14 },
                                k2h2]
                            //            {text:$('#complaints_heading').text().slice(20), lineHeight:2}]

                        },

                        {
                            stack: [{ text: 'Vitals', bold: true, fontSize: 14 },
                            { text: $('#vitals').text().slice(6) + "\n\n" }
                            ]

                        },

                        {
                            stack: [

                                { text: 'Diagnosis', bold: true, decoration: 'underline', fontSize: 14, lineHeight: 2 },
                                { text: $('#diagnosis_heading').text().slice(9), lineHeight: 2 }]

                        },

                        {
                            stack: [

                                { text: 'Medication(s)', bold: true, decoration: 'underline', fontSize: 14, lineHeight: 2 },
                                medications]

                        },
                        {
                            stack: [

                                { text: 'Recommended Investigation(s)', bold: true, decoration: 'underline', fontSize: 14, lineHeight: 2 },
                                tests]

                        },

                        {
                            stack: [

                                { text: 'General Advice', bold: true, decoration: 'underline', fontSize: 14, lineHeight: 1 },
                                k9
                            ]

                        },

                        {
                            stack: [

                                { text: 'Follow Up Date', bold: true, decoration: 'underline', fontSize: 14, lineHeight: 2 },
                                { text: $('#follow_up_heading').text().slice(14).split(" ")[0] },
                                { text: j.join(" "), lineHeight: 2 },
                            ]

                        },


                        {
                            stack: [


                                { text: $('#docSign').text(), font: $('#docSign').css('font-family').replace(/\b[a-zA-Z]/g, (match) => match.toUpperCase()), fontSize: 12, alignment: 'right' },
                                { text: docDe, alignment: 'right', lineHeight: 1 },
                                { text: $('#docReg').text(), bold: true, alignment: 'right' }
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
                    },
                    images: {
                        ih_logo: 'https://as.intelehealth.org/preApi/ih-logo.png',
                        nas_logo: 'https://as.intelehealth.org/preApi/nas-logo.png'
                    },
                    defaultStyle: {
                        font: 'Rajdhani',
                        fontSize: 10
                    },


                }
                fileName = getParameterByName("v").slice(-5) + "_prescription";
                let aa = [];
                dd.content.forEach((content1) => {
                    if (content1 && (content1?.stack[1]?.text || content1?.stack[1]?.length > 0)) {
                        aa.push(content1);
                    }
                });
                dd.content = aa;
                pdfMake.createPdf(dd, null, fonts).download(fileName);
                alert('Prescription will be downloaded shortly');
            }
        </script>
    </body>
    <script src="js/jquery-3.5.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/pdfmake.min.js"></script>
    <script src="js/vfs_fonts.js"></script>

    </html>