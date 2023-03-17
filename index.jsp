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


        body {
            color: black;
            font-family: 'Roboto';
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
        <div class="row" style="text-align:center;margin-right: 0px; margin-left: 0px;">
            <div class="col-md-3">
                <!-- <img src="sila.png" width="50%" /> -->
            </div>
            <div class="col-md-6" style="text-align: center;padding-top: 10px;font-size: 15pt;">
                <span id="projectName"><strong>"Registration Village Location - Dynamic" Health Unit</strong></span>
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
                <u><b>e-prescription</b></u>
            </div>
            <div class="col-md-3">
                <button class="btn btn-primary" onclick="createPDF();">Download Prescription</button>
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
            <b>
                <p id="vitals_heading" style="font-size:12pt;margin-top:5px; margin-bottom:0px;; padding: 0px;"></p>
            </b>
            <!-- <p id="vitals" style="font-size:12pt;margin:0px; padding: 0px;"></p> -->
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
    </div>
    </div>
    </div>
    </div>
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
                url: "https://service.sila.care/prescription/prescription/visitData",
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
                        $('#projectName').html("<strong>" + data.locationName + " Health Unit" + "</strong>");
                        $('#patient_info').html("<b style=font-size:15pt;><u>Patient information:</u></b>");
                        $('#patient_name').html("Name: " + data.name.replaceAll(",", " ") + "</br>");
                        $('#patient_details').text('Age: ' + data.age + " | Gender: " + data.gender);
                        $('#address_and_contact').text('Address and Contact: ' + data.address + "," + (data.citizenId === "-" ? "Not provided" : data.citizenId));
                        wt = parseFloat(data.weight);
                        ht = parseInt(data.height) / 100;
                        bmi = 0.0;
                        if (wt && ht) {
                            bmi = wt / (ht * ht);
                        }
                        $('#visit_details').text('Patient Id: ' + data.openMRSID + " | Date of visit: " + moment(data.visitDate).format('DD-MMMM-YYYY'));                                    // $('#vitals').html('<b><u>Vitals</u></b><br> Height(cm): '+data.height+' | Weight(kg): '+data.weight+
                        // ' | BMI: '+bmi.toFixed(2)+' | Blood Pressure: '+ parseInt(data.sbp).toFixed(0) + '/'+ parseInt(data.dbp).toFixed(0) +' | Pulse(bpm): '+ data.pulseRate+
                        // ' | Temperature(F): '+ (data.temperature > 0 ? ((data.temperature * 1.8) + 32).toFixed(2) : 0) + ' | SpO2(%): '+ data.spo2 + ' | Respiratory Rate: '+ data.respRate+"<br>");
                        let complaint1;
                        if (data.complaint.toString().startsWith("{")) {
                            let value = JSON.parse(data.complaint.toString());
                            complaint1 = value["en"];
                        }
                        complaintString = complaint1?.trim().split("<br/>");
                        finalComplaint = "";
                        for (counter = 0; counter < complaintString?.length; counter++) {
                            if (complaintString[counter].indexOf("<b>") > -1 && complaintString[counter].indexOf("Associated symptoms") == -1) {
                                if (counter > 0) {
                                    finalComplaint += "<li>" + complaintString[counter].slice(5, -2) + "</li>";
                                }
                                else {
                                    finalComplaint += "<li>" + complaintString[counter].slice(4, -2) + "</li>"
                                }

                            }
                        }

                        $('#complaints_heading').html('<b><u>Reason of visit:</u></b><br><div style="font-size:12pt;">' + finalComplaint + "</div>");
                        if (data.diagnosis.substring(0, 1) == ';') {
                            let diagnosis = getData(data.enDiagnosis)?.split("<br>");
                            finalDiagnosis = "";
                            for (counter = 0; counter < diagnosis.length; counter++) {
                                finalDiagnosis += "<li>" + diagnosis[counter] + "</li>";
                            }

                            $('#diagnosis_heading').html('<b><u>Diagnosis:</u></b><div style="font-size:12pt;">' + finalDiagnosis + "</div>");
                        }

                        if (data.enMedication) {
                            let med = getData(data.enMedication)?.split("<br>");
                            finalMedication = "";
                            for (counter = 0; counter < med.length; counter++) {
                                finalMedication += "<li>" + med[counter] + "</li>";
                            }
                            $('#rx_heading').html('<b><u>Medication plan:</u></b><div style="font-size:12pt;">' + finalMedication + "</div>");

                        }

                        if (data.testsAdvised) {
                            let testsAdvised = getData(data.enMedicalTests)?.split("<br>");
                            finalTest = "";
                            for (counter = 0; counter < testsAdvised.length; counter++) {
                                finalTest += "<li>" + testsAdvised[counter] + "</li>";
                            }
                            $('#tests_heading').html('<b><u>Recommended Investigation(s):</u></b><div style="font-size:12pt;">' + finalTest + "</div>");

                        }
                        if (data.medicalAdvice) {
                            let medicalAdvice = getData(data.enMedicalAdvice)?.split("<br>");
                            finalMedicalAdvice = "";
                            for (counter = 0; counter < medicalAdvice.length; counter++) {
                                if (!medicalAdvice[counter].includes("Audio"))
                                    finalMedicalAdvice += "<li>" + medicalAdvice[counter] + "</li>";
                            }
                            $('#advice_heading').html('<b><u>General Instructions:</u></b><div style="font-size:12pt;">' + finalMedicalAdvice + "</div>");


                        }

                        if (data.followupNeeded) {
                            let followup = data.followupNeeded ? JSON.parse(data.followupNeeded?.trim().substring(1).toString()) : { en: "" };
                            $('#follow_up_heading').html('<b><u>Followup date:</u></b><br><div style="font-size:12pt;"><li>' + followup['en'] + "</li><br></div>");
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
                                    specialization = docAttributes[i].split(":")[1];

                                }

                                if (docAttributes[i].indexOf("phoneNumber") > -1) {
                                    phoneNumber = "Phone Number: " + docAttributes[i].split(":")[1];

                                }

                                if (docAttributes[i].indexOf("emailId") > -1) {
                                    email = "Email id: " + docAttributes[i].split(":")[1];

                                }
                                if (docAttributes[i].indexOf("registrationNumber") > -1) {
                                    regNumber = "Registration No: " + docAttributes[i].split(":")[1];

                                }

                            }
                        }
                        // fullDets+= qual? qual+ "," +specialization+"<br>":"" +specialization+"<br>";
                        // fullDets+=phoneNumber+"<br>";
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

        function createPDF() {


            // var j = $('#follow_up_heading').text().slice(14).split(" ");
            // j.shift();

            // var tmpK = $('#advice_heading').html().replace('<b><u>General Instructions:</u></b><div style="font-size:12pt;">', '')
            // nest = tmpK.replaceAll("<li>", "\u2022");
            // videoAddresses = [];
            // nest.pop();
            // // nest.pop();
            // for (i = 0; i < nest.length; i++) {
            //     if (nest[i].indexOf("<") == -1) {
            //         videoAddresses.push("#");
            //     }
            //     else {
            //         console.log(nest[i].indexOf("<"))
            //         nest[i] = nest[i].substr(0, nest[i].indexOf("<") - 1);
            //     }
            // }
            // console.log(nest);

            // $('#advice_heading').find('a').each(function () {
            //     videoAddresses.push($(this).attr('href'))
            // });

            // k9 = [];
            // console.log(videoAddresses);
            // k9.push("\n");
            // for (nn = 0; nn < nest.length; nn++) {
            //     if (videoAddresses[nn] == "#") {
            //         k9.push({ text: nest[nn] })
            //     }
            //     else {
            //         k9.push({ text: nest[nn] + "Video Link ", link: videoAddresses[nn] })
            //     }

            // }
            // k9.push("\n");


            // videoAddress = $('#advice_heading a:first').attr('href')
            // var videoDescriptor = $('#advice_heading a:first').parent().text()
            // var videoLinkPos = videoDescriptor.indexOf("video link")

            // videoDescriptor = videoDescriptor.substr(0, videoLinkPos - 1)
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
            k2h2.push("\n");

            $("#diagnosis_heading").html($("#diagnosis_heading").html().replaceAll("<li>", "\u2022").replaceAll("</li>", "\n"));
            $("#rx_heading").html($("#rx_heading").html().replaceAll("<li>", "\u2022").replaceAll("</li>", "\n"));
            $("#tests_heading").html($("#tests_heading").html().replaceAll("<li>", "\u2022").replaceAll("</li>", "\n"));
            $("#advice_heading").html($("#advice_heading").html().replaceAll("<li>", "\u2022").replaceAll("</li>", "\n"));
            $("#follow_up_heading").html($("#follow_up_heading").html().replaceAll("<li>", "\u2022").replaceAll("</li>", "\n"));


            //                pdfMake.vfs = pdfFonts.pdfMake.vfs;

            var dd = {
                "pageSize": "A4",
                content: [
                    {

                        stack: [
                            {
                                columns: [
                                    {
                                        text: { text: $('#projectName').text(), bold: true },
                                        fontSize: 20,
                                        bold: true
                                    }
                                ],
                            },
                            { text: 'e-prescription', style: 'subheader' },
                            { canvas: [{ type: 'line', x1: 0, y1: 5, x2: 595 - 2 * 40, y2: 5, lineWidth: 1, color: 'green' }] }
                        ],
                        style: 'header'
                    },
                    {
                        stack: [
                            { text: $('#patient_info').text(), decoration: 'underline', bold: true, fontSize: 14, lineHeight: 1.25 },
                            { text: $('#patient_name').text(), lineHeight: 1.25 },
                            { text: $('#patient_details').text(), lineHeight: 1.25 },
                            { text: $('#address_and_contact').text(), lineHeight: 1.25 },
                            { text: $('#visit_details').text(), lineHeight: 2 }

                        ]
                    },
                    {
                        stack: [{ text: 'Reason of visit:\n\n', decoration: 'underline', bold: true, fontSize: 14 },
                            k2h2]
                        //            {text:$('#complaints_heading').text().slice(20), lineHeight:2}]

                    },

                    // {
                    //     stack: [{text:'Vitals', decoration: 'underline', bold:true,fontSize:14},
                    //     {text:$('#vitals').text().slice(6)+"\n\n",lineHeight:1}
                    //     ]

                    // },

                    {
                        stack: [

                            { text: 'Diagnosis:', bold: true, decoration: 'underline', fontSize: 14, lineHeight: 2 },
                            { text: $('#diagnosis_heading').text().slice(10), lineHeight: 2 }]

                    },

                    {
                        stack: [

                            { text: 'Medication plan:', bold: true, decoration: 'underline', fontSize: 14, lineHeight: 2 },
                            { text: $('#rx_heading').text().slice(16), lineHeight: 2 }]

                    },

                    {
                        stack: [

                            { text: 'Recommended Investigation(s):', bold: true, decoration: 'underline', fontSize: 14, lineHeight: 2 },
                            { text: $('#tests_heading').text().slice(29), lineHeight: 2 }]

                    },

                    {
                        stack: [

                            { text: 'General Instructions: \n\n', bold: true, decoration: 'underline', fontSize: 14, lineHeight: 1 },
                            { text: $('#advice_heading').text().slice(21), lineHeight: 2 }
                        ]

                    },

                    {
                        stack: [

                            { text: 'Followup date:', bold: true, decoration: 'underline', fontSize: 14, lineHeight: 2 },
                            { text: $('#follow_up_heading').text().slice(14), lineHeight: 2 },
                        ]

                    },


                    {
                        stack: [


                            { text: $('#docSign').text(), font: $('#docSign').css('font-family').replace(/\b[a-zA-Z]/g, (match) => match.toUpperCase()), fontSize: 50, alignment: 'right' },
                            { text: docDe, alignment: 'right', lineHeight: 1 },
                            { text: $('#docReg').text(), alignment: 'right' }
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
                        decoration: "underline"
                    }
                }

            }
            fileName = getParameterByName("v").slice(-5) + "_prescription";


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
<script src="https://momentjs.com/downloads/moment.min.js"></script>

</html>