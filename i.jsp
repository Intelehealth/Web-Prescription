<!-- <%@page pageEncoding="UTF-8"%> -->

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

    <link rel="stylesheet" href="css/bootstrap.min.css" />

    <style>
      .content {
        position: absolute;
        left: 50%;
        top: 20%;
        -webkit-transform: translate(-50%, -50%);
        transform: translate(-50%, -50%);
      }

      @font-face {
        font-family: "Asem";
        src: url("fonts/Asem.ttf");
      }

      @font-face {
        font-family: "Youthness";
        src: url("fonts/Youthness.ttf");
      }

      @font-face {
        font-family: "Arty";
        src: url("fonts/Arty.ttf");
      }

      @font-face {
        font-family: "almondita";
        src: url("fonts/almondita.ttf");
      }

      @font-face {
        font-family: "signature";
        src: url("fonts/signature.ttf");
      }

      @font-face {
        font-family: "terecia";
        src: url("fonts/Terecia.ttf");
      }

      @font-face {
        font-family: "signature";
        src: url("fonts/signature.ttf");
      }

      @font-face {
        font-family: "Rajdhani";
        src: url("fonts/Rajdhani-Regular.ttf");
      }

      body {
        color: black;
        font-family: "Rajdhani", sans-serif;
      }

      html {
        color: black;
      }
    </style>
    <script src="js/jquery-3.5.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/pdfmake.min.js"></script>
    <script src="js/vfs_fonts.js"></script>
  </head>
  <body>
    <br />
    <div id="prescription" style="display: none" class="container">
      <div class="row style="text-align:center">
      <div class="col-md-2 col-sm-2">
        <img src="msf.png" width="50%" />
      </div>
      <div class="col-md-8 col-sm-8" style="text-align: center">
        <span><strong>एमएसएफ डायबिटीज केअर हेल्पलाइन</strong></span>
        <br />
        <span><strong>MSF Diabetes Care Helpline</strong></span>
      </div>
      <div class="col-md-2 col-sm-2 pull-right">
        <img src="ih-logo.png" width="50%" />
      </div>
    </div>
    <br />
    <div class="row" style="text-align: center">
      <div class="col-md-4 col-sm-4">&nbsp;</div>
      <div class="col-md-5 col-sm-3" style="font-size: 14">
        <u> <b>ePrescription</b></u>
      </div>
      <div class="col-md-3 co-sm-3">
        <button class="btn btn-primary" onclick="createPDF();">
          Download Prescription
        </button>
      </div>
    </div>

    <div id="detailDiv" style="margin: 0px">
      <p
        id="patient_name"
        style="font-size: 12pt; margin: 0px; padding: 0px"
      ></p>
      <p
        id="patient_details"
        style="font-size: 12pt; margin: 0px; padding: 0px"
      ></p>
      <p
        id="address_and_contact"
        style="font-size: 12pt; margin: 0px; padding: 0px"
      ></p>

      <p
        id="visit_details"
        style="
          font-size: 12pt;
          margin-top: 5px;
          margin-bottom: 0px;
          padding: 0px;
        "
      ></p>
      <p
        id="complaints_heading"
        style="
          font-size: 15pt;
          margin-top: 5px;
          margin-bottom: 0px;
          padding: 0px;
        "
      ></p>
      <b
        ><p
          id="vitals_heading"
          style="
            font-size: 12pt;
            margin-top: 5px;
            margin-bottom: 0px;
            font-size: 15pt;
            padding: 0px;
          "
        ></p
      ></b>
      <p id="vitals" style="font-size: 12pt; margin: 0px; padding: 0px"></p>
      <p
      id="diagnosis_heading"
      style="
        font-size: 15pt;
        margin-top: 5px;
        margin-bottom: 0px;
        padding: 0px;
      "
     ></p>
     <p
     id="food_allergy"
     style="
       font-size: 15pt;
       margin-top: 5px;
       margin-bottom: 0px;
       padding: 0px;
     "
   ></p>
      <p
        id="rx_heading"
        style="
          font-size: 15pt;
          margin-top: 5px;
          margin-bottom: 0px;
          padding: 0px;
        "
      ></p>
      <p
        id="tests_heading"
        style="
          font-size: 15pt;
          margin-top: 5px;
          margin-bottom: 0px;
          padding: 0px;
        "
      ></p>

      <p
        id="advice_heading"
        style="
          font-size: 15pt;
          margin-top: 5px;
          margin-bottom: 0px;
          padding: 0px;
        "
      ></p>
      <p
        id="advice_heading2"
        style="
          font-size: 15pt;
          margin-top: 5px;
          margin-bottom: 0px;
          padding: 0px;
          display: none;
        "
      ></p>

      <p
        id="follow_up_heading"
        style="
          font-size: 15pt;
          margin-top: 5px;
          margin-bottom: 0px;
          padding: 0px;
        "
      ></p>

      <div style="text-align: right; margin-right: 50px; margin-top: 0px">
        <span style="font-size: 3rem; padding: 0px" id="docSign"> </span>
        <br />
        <div class="pull-right" id="docDetail"></div>
        <p
          style="font-size: 12pt; margin-top: -0px; padding: 0px"
          id="docReg"
        ></p>
      </div>
      <div style="text-align: center">
        MSF Diabetes Care Helpline Number - +9118003094144
      </div>
    </div>
  </body>

  <script type="text/javascript">
    var kkN = [];
    prescTypes = [
      {
        label: "Early Morning",
        hiLabel: "बहुत सवेरे",
        key: "earlyMorning",
        sortId: 1,
      },
      { label: "Breakfast", hiLabel: "नाश्ता", key: "breakfast", sortId: 2 },
      {
        label: "Mid Morning",
        hiLabel: "सुबह के दौरान",
        key: "midMorning",
        sortId: 3,
      },
      { label: "Lunch", hiLabel: "दिन का खाना", key: "lunch", sortId: 4 },
      {
        label: "Evening Snack",
        hiLabel: "शाम का नाश्ता",
        key: "eveningSnack",
        sortId: 5,
      },
      { label: "Dinner", hiLabel: "रात का खाना", key: "dinner", sortId: 6 },
      { label: "Bed Time", hiLabel: "सोने के समय", key: "bedTime", sortId: 7 },
    ];

    function getParameterByName(name, url) {
      if (!url) url = window.location.href;
      name = name.replace(/[\[\]]/g, "\\$&");
      var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
      if (!results) return null;
      if (!results[2]) return "";
      return decodeURIComponent(results[2].replace(/\+/g, " "));
    }

    function parse(value) {
      try {
        return JSON.parse(value.trim());
      } catch (error) {
        return value;
      }
    }

    function parseSingleDietElem(dietData) {
      const value = parse(dietData);

      if (value instanceof Object) {
        return value;
      } else {
        return value;
      }
    }

    function parseAndShowDeitPrescription(data) {
      try {
        let precData = data;
        data = data.split(";");
        if (data.length === 1) [data] = data;

        if (data.length === 1) {
          data = data.split("||");
          if (data.length === 1) [data] = data;
        }

        if (Array.isArray(data)) {
          let hiData = "";
          let enData = "";
          let parsedDataArr = [];
          data.forEach((dietElem) => {
            let parseData = parseSingleDietElem(dietElem);

            const type = prescTypes.find((pt) => {
              const label = pt && pt.label ? pt.label : 1;
              const mealType =
                parseData && parseData.en && parseData.en.meal_type
                  ? parseData.en.meal_type
                  : 2;
              return label === mealType;
            });
            const sortId = type && type.sortId ? type.sortId : null;

            if (parseData instanceof Object) {
              parseData.sortId = sortId;
              parsedDataArr.push(parseData);
            } else {
              precData = `${parseData}\n`;
            }
          });
          parsedDataArr = parsedDataArr
            .sort((a, b) => a.sortId - b.sortId)
            .map(({ sortId, ...rest }) => rest);

          parsedDataArr.forEach((presData, idx) => {
            hiData += `${idx + 1}. ${presData.hi.meal_type}:\n`;
            presData.hi.data.forEach((hiVal) => {
              hiData += `- ${hiVal.value} - ${hiVal.qty || ""} ${
                hiVal.unit || ""
              }\n`;
            });
          });

          parsedDataArr.forEach((presData, idx) => {
            enData += `${idx + 1}. ${presData.en.meal_type}:\n`;
            presData.en.data.forEach((enVal) => {
              enData += `- ${enVal.value} - ${enVal.qty || ""} ${
                enVal.unit || ""
              }\n`;
            });
          });

          return `${enData}\n${hiData}`;
        } else {
          precData += `${parseSingleDietElem(data)}\n`;
        }
        return precData;
      } catch (error) {
        console.log("error: ", error);
        return data;
      }
    }

    function parseAndShowDeitPrescription1(englishDiet, hindiDiet) {
      try {
        let hiData = "";
        let enData = ""; 
        let array2 = [];  
        englishDiet.forEach((diet) => {
          const sortId = this.prescTypes.find(pt => pt.label === diet.mealType)?.sortId;
          let data = array2.find(pt => pt.mealType === diet.mealType);
            if(data) {
              data.dish.push({mealPrescribed: diet.mealPrescribed, quantity: diet.quantity, unit: diet.unit});
            } else {
              array2.push({'mealType': diet.mealType, 'dish': [{mealPrescribed: diet.mealPrescribed, quantity: diet.quantity, unit: diet.unit}],'sortId' : sortId});
            }
        });
        let englishDietData = array2
            .sort((a, b) => a.sortId - b.sortId)
            .map(({ sortId, ...rest }) => rest);
        
        englishDietData.forEach((presData, idx) => {
            enData += `${idx + 1}. ${presData.mealType}:\n`;
            presData.dish.forEach(d => {
              enData += `- ${d.mealPrescribed} - ${d.quantity || ""} ${
                d.unit || ""
              }\n`;
            });
          });

        let array1 = [];  
        hindiDiet.forEach((diet) => {
          const sortId = this.prescTypes.find(pt => pt.hiLabel === diet.mealType)?.sortId;
          let data = array1.find(pt => pt.mealType === diet.mealType);
            if(data) {
              data.dish.push({mealPrescribed: diet.mealPrescribed, quantity: diet.quantity, unit: diet.unit});
            } else {
              array1.push({'mealType': diet.mealType, 'dish': [{mealPrescribed: diet.mealPrescribed, quantity: diet.quantity, unit: diet.unit}],'sortId' : sortId});
            }
          });
        let hindiDietData = array1
            .sort((a, b) => a.sortId - b.sortId)
            .map(({ sortId, ...rest }) => rest);
    
        hindiDietData.forEach((presData, idx) => {
            hiData += `${idx + 1}. ${presData.mealType}:\n`;
            presData.dish.forEach(d => {
              hiData += `- ${d.mealPrescribed} - ${d.quantity || ""} ${
                d.unit || ""
              }\n`;
            });
          });
        return `${enData}\n${hiData}`;
      } catch (error) {
        console.log("error: ", error);
        return data;
      }
    }

    function init() {
      $("#errDesc").text("");

      jQuery.ajax({
        url: "https://msf-arogyabharat.intelehealth.org/prescription/prescription/visitData",
        type: "POST",
        data: JSON.stringify({
          visitId: getParameterByName("v"),
          patientId: getParameterByName("pid"),
        }),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
          if (data.status == "No Data found") {
            $("#errDesc").text("No Prescription Found");
          } else {
            $("#prescription").show();
            $("#patient_name").html(
              "<b>" + data.name.replaceAll(",", " ") + "</b>"
            );
            $("#patient_details").text(
              "उम्र / Age: " + data.age + " | लिंग / Gender: " + data.gender
            );
            $("#address_and_contact").text("राज्य / State: " + data.address);
            //                                    $('#address_and_contact').text('राज्य / AState: ' + data.address);
            wt = parseFloat(data.weight);
            ht = parseInt(data.height) / 100;
            bmi = wt / (ht * ht);
            if (isNaN(bmi)) bmi = 0;

            $("#visit_details").text(
              "पेशेंट ID / Patient ID: " +
                data.openMRSID +
                " | दिनांक / Date of visit: " +
                data.visitDate
            );
            $("#vitals").html(
              '<b><u><span style="font-size:15pt;">नब्ज / Vitals </span></u></b><br>Height(cm): &nbsp;'+ parseInt(data.height).toFixed(0) +
              ' | Weight(kg): &nbsp;'+ parseInt(data.weight).toFixed(0) +' | BMI: &nbsp;'+ bmi.toFixed(2) + ' | Blood Pressure: ' +
                parseInt(data.sbp).toFixed(0) +
                "/" +
                parseInt(data.dbp).toFixed(0) +
                " |  Blood Glucose: "+ parseInt(data.bloodGlucose).toFixed(0)+
                "<br>"
            );
            complaintString = data.complaint.trim().split("<br/>");
            finalComplaint = "";
            for (counter = 0; counter < complaintString.length; counter++) {
              if (
                complaintString[counter].indexOf("<b>") > -1 &&
                complaintString[counter].indexOf("Associated symptoms") == -1
              ) {
                if (counter > 0) {
                  finalComplaint +=
                    complaintString[counter].slice(5, -2) + "<br>";
                } else {
                  finalComplaint +=
                    complaintString[counter].slice(4, -2) + "<br>";
                }
              }
            }
            //  finalComplaint="";
            //  for(counter=0;counter < complaintString.length ; counter++) {
            //      if(complaintString[counter].indexOf("<b>") > -1 && complaintString[counter].indexOf("Associated symptoms") == -1){
            //          finalComplaint+=complaintString[counter].slice(1, -2);

            //      }
            //  }

            $("#complaints_heading").html(
              '<b><u>वजह / Reason for visit</u></b><br><div style="font-size:14px;">' +
                finalComplaint +
                "</div>"
            );
            if (data.dietPrescription.substring(0, 1) == ";") {
              $("#diagnosis_heading").html(
                '<b><u>आहार-सम्बन्धी अतिरिक्त जानकारी / Diet prescription </u></b><br><div style="font-size:14px;">' +
                  data.dietPrescription.trim().substring(1)+
                  "<br></div>"
              );
            } else {
              $("#diagnosis_heading").html(
                '<b><u>आहार-सम्बन्धी अतिरिक्त जानकारी / Diet prescription</u></b><br><div style="font-size:14px;">' +
                  data.dietPrescription.trim() +
                  "<br></div>"
              );
            }
            if (data.medication.substring(0, 1) == ";") {
              $("#rx_heading").html(
                '<b><u>पोषण विशेषज्ञ प्रिस्क्रिप्शन / Nutritionist Prescription</u></b><br><div style="font-size:14px;white-space: pre-line;">' +
                  parseAndShowDeitPrescription1(
                    data.englishDiet, data.hindiDiet
                  ) +
                  "<br></div>"
              );
            } else {
              $("#rx_heading").html(
                '<b><u>पोषण विशेषज्ञ प्रिस्क्रिप्शन / Nutritionist Prescription</u></b><br><div style="font-size:14px;">' +
                  data.medication.trim() +
                  "<br></div>"
              );
            }

            if (data.foodAllergy.substring(0, 1) == ";") {
              $("#food_allergy").html(
                '<b><u>आहार-विशेष से एलर्जी / Food Allergy</u></b><br><div style="font-size:14px;white-space: pre-line;">' +
                  data.foodAllergy.trim().substring(1) +
                  "<br></div>"
              );
            } else {
              $("#food_allergy").html(
                '<b><u>आहार-विशेष से एलर्जी / Food Allergy</u></b><br><div style="font-size:14px;">' +
                  data.foodAllergy.trim() +
                  "<br></div>"
              );
            }

            if (data.testsAdvised.substring(0, 1) == ";") {
              $("#tests_heading").html(
                '<b><u>जांच की सिफारिश / Recommended Investigation(s)</u></b><br><div style="font-size:14px;">' +
                  data.testsAdvised.trim().substring(1) +
                  "<br></div>"
              );
            } else {
              $("#tests_heading").html(
                '<b><u>जांच की सिफारिश / Recommended Investigation(s)</u></b><br><div style="font-size:14px;">' +
                  data.testsAdvised.trim() +
                  "<br></div>"
              );
            }

            if (data.medicalAdvice.substring(0, 2) == "; ") {
              var staticAdvice =
                `;Limit oil intake to 3 teaspoon per day that is 500ml per person per month./तेल का सेवन प्रतिदिनी ३ चम्मच, अर्थात* ५०० मिलि प्रति व्यक्ति प्रति माह तक सीमित करें
;Do not consume simple sugar in the diet. Avoid honey/ jiggery. Instead can use artificial sweeteners like stevia./आहार में साधारण चीनी का सेवन न करें। शहद/गुड़ से परहेज करें। इसके बजाय स्टीविया जैसे कृत्रिम मिठास का उपयोग कर सकते हैं।
;Avoid hydrogenated oil, Dalda, and animal fat. Consume sunflower oil/ Corn oil/ ground nut oil./हाइड्रोजनीकृत तेल, डालडा और पशु वसा से बचें। सूरजमुखी तेल/मकई का तेल/मूंगफली के तेल का सेवन करें।
;Avoid large gaps between the meals. Eat small and frequent meals./छोटे-छोटे अंतरालों में थोडी-थोडी मात्रा में आहार लें
;Limit salt intake to 4gram per day./नमक का सेवन प्रतिदिन 4 ग्राम तक सीमित करें।
;Avoid processed and refined food products like maida and maida products, toast, khaari, biscuits, white breads. Avoid Namkeens, bakery items./मैदा और मैदा उत्पाद, टोस्ट, खारी, बिस्कुट, सफेद ब्रेड जैसे प्रसंस्कृत और परिष्कृत खाद्य उत्पादों से बचें। नमकीन, बेकरी आइटम से बचें।
;Hypoglycaemia most often occurs due to reasons such as inadequate meal intake, too much exercise without proper carbohydrate intake. This can lead to blurred vision, confused thinking, giddiness,sweating, restlnessness, drowsiness, slurred speech./हाइपोग्लाइसीमिया अक्सर अपर्याप्त भोजन सेवन, उचित कार्बोहाइड्रेट सेवन के बिना बहुत अधिक व्यायाम जैसे कारणों से होता है। इससे धुंधली दृष्टि, भ्रमित सोच, चक्कर आना, पसीना आना, बेचैनी, उनींदापन, गंदी बोली हो सकती है |
;Treatment- Have 15 grams of carbohydrate and check it after 15 minutes. If it’s still below 70 mg/dL, have another dose of 15g carbohydrate. Carbohydrate sources to include- Sugar or glucon-  1Tbsp (15g), 150-200ml of fruit juice./उपचार- 15 ग्राम कार्बोहाइड्रेट लें और 15 मिनट बाद चेक करें। यदि यह अभी भी 70 मिलीग्राम / डीएल से नीचे है, तो 15 ग्राम कार्बोहाइड्रेट की एक और खुराक लें। शामिल करने के लिए कार्बोहाइड्रेट स्रोत- चीनी या ग्लूकॉन- 1 बड़ा चम्मच (15 ग्राम), 150-200 मिलीलीटर फलों का रस|`;
              ktemp = data.medicalAdvice.trim();

              kk = ktemp.substr(2) + staticAdvice;
              kk = kk.replace(";", "");
              kk2 = "<ul><li>" + kk.replaceAll(";", "</li><li>") + "</li></ul>";

              //kk = kk.replaceAll(";","\r\n")
              kkN = kk.split(";");
              if (kkN[0] == ";" || kkN[0] == " ") kkN.shift();

              $("#advice_heading").html(
                '<b><u>सामान्य सलाह / General Advice</u></b><br><div style="font-size:14px;">' +
                  kk2 +
                  "<br></div>"
              );
              $("#advice_heading2").html(
                '<b><u>सामान्य सलाह / General Advice</u></b><br><div style="font-size:14px;">' +
                  kk.substr(1) +
                  "<br></div>"
              );
              //$('#advice_heading').html('<b><u>General Advice/सामान्य सलाह</u></b><br><div style="font-size:14px;">'+kk.substr(1).replaceAll(",","<br>")+"<br></div>");
              //  $('#advice_heading').html('<b><u>General Advice/सामान्य सलाह</u></b><br><div style="font-size:14px;">'+kk.substr(1).replace(",","<br>")+"<br></div>");

              //  $('#advice_heading').html('<b><u>General Advice/सामान्य सलाह</u></b><br><div style="font-size:14px;">'+kk.substr(1)+"<br></div>");

              //                                        $('#advice_heading').html('<b><u>General Advice/सामान्य सलाह</u></b><br><div style="font-size:14px;">'+kk.substr(2)+1<br></div>");
            } else {
              $("#advice_heading").html(
                '<b><u>सामान्य सलाह / General Advice</u></b><br><div style="font-size:14px;">' +
                  data.medicalAdvice
                    .trim()
                    .substr(data.medicalAdvice.trim().lastIndexOf(";") + 1) +
                  "<br></div>"
              );
            }

            if (data.followupNeeded.substr(0, 1) == ";") {
              $("#follow_up_heading").html(
                '<b><u>फिर से संपर्क कि तारीख / Follow Up Date</u></b><br><div style="font-size:14px;">' +
                  data.followupNeeded.trim().substring(1).replace(",", "<br>") +
                  "<br></div>"
              );
            } else {
              $("#follow_up_heading").html(
                '<b><u>फिर से संपर्क कि तारीख / Follow Up Date</u></b><br><div style="font-size:14px;">' +
                  data.followupNeeded.trim().replace(",", "<br>") +
                  "<br></div>"
              );
            }

            var docName = data.doctorName
              .replaceAll("Dr ", "Dr.")
              .replaceAll(",", " ");
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
                $("#docSign").css(
                  "font-family",
                  docAttributes[i].split(":")[1]
                );
                $("#docSign").css("font-size", "3em;");
              }
              if (docAttributes[i].indexOf("textOfSign") > -1) {
                $("#docSign").text(docAttributes[i].split(":")[1]);
              }

              if (
                docAttributes[i].indexOf("textOfSign") == -1 &&
                docAttributes[i].indexOf("fontOfSign") == -1
              ) {
                if (docAttributes[i].indexOf("qualification") > -1) {
                  qual = docAttributes[i].split(":")[1];
                }
                if (docAttributes[i].indexOf("specialization") > -1) {
                  specialization = docAttributes[i].split(":")[1];
                }

                if (docAttributes[i].indexOf("phoneNumber") > -1) {
                  phoneNumber =
                    "Phone Number: " + docAttributes[i].split(":")[1];
                }

                if (docAttributes[i].indexOf("emailId") > -1) {
                  email = "E-Mail: " + docAttributes[i].split(":")[1];
                }
                if (docAttributes[i].indexOf("registrationNumber") > -1) {
                  regNumber =
                    "<b>Registration No: " +
                    docAttributes[i].split(":")[1] +
                    "</b>";
                }
              }
            }
            fullDets += qual + "," + specialization + "<br>";
            //fullDets+=phoneNumber+"<br>";
            fullDets += email + "<br>";
            //fullDets+=regNumber+"<br>";

            $("#docDetail").html(fullDets);
            $("#docReg").html(regNumber);

            $("#docSImage").attr("src", data.imageOfSignature);
          }
        },
      });
    }

    function createPDF() {
      var j = $("#follow_up_heading").text().slice(37).split(" ");
      j.shift();

      var docDe = $("#docDetail").html().replaceAll("<br>", "\n");

      var ll = $("#advice_heading").find("div:first").text();

      var fonts = {
        Asem: {
          normal: "Asem.ttf",
          bold: "Asem.ttf",
          italics: "Asem.ttf",
          bolditalics: "Asem.ttf",
        },
        Youthness: {
          normal: "Youthness.ttf",
        },

        Arty: {
          normal: "Arty.ttf",
        },

        Almondita: {
          normal: "almondita.ttf",
          bold: "almondita.ttf",
          italics: "almondita.ttf",
          bolditalics: "almondita.ttf",
        },
        margareta: {
          normal: "margareta.ttf",
          bold: "margareta.ttf",
          italics: "margareta.ttf",
          bolditalics: "margareta.ttf",
        },
        Siganature: {
          normal: "signature.ttf",
          bold: "signature.ttf",
          italics: "signature.ttf",
          bolditalics: "signature.ttf",
        },
        Terecia: {
          normal: "Terecia.ttf",
          bold: "Terecia.ttf",
          italics: "Terecia.ttf",
          bolditalics: "Terecia.ttf",
        },
        Rajdhani: {
          normal: "Rajdhani-Regular.ttf",
          bold: "Rajdhani-Bold.ttf",
        },

        // download default Roboto font from cdnjs.com
        Roboto: {
          normal: "Roboto-Regular.ttf",
          bold: "Roboto-Medium.ttf",
          italics: "Roboto-Italic.ttf",
          bolditalics: "Roboto-MediumItalic.ttf",
        },
      };

      var tmpComplaints = $("#complaints_heading").html().split("<br>");
      for (index = 1; index < tmpComplaints.length; index++) {
        n = tmpComplaints[index].replaceAll(
          '<div style="font-size:14px;">',
          ""
        );
        n1 = n.replace("<b>", "");
        n2 = n1.replace("</b>", "");
        n3 = n2.replace("<u>", "");
        n4 = n3.replace("</u>", "");
        n5 = n4.replace(/<\/?[^>]+(>|$)/g, "");
        n6 = n5.replace("&amp;", "& ");
        tmpComplaints[index] = n6;
      }
      tmpComplaints.shift();
      k2h2 = tmpComplaints.join("\n");
      console.log(k2h2);

      //pdfMake.vfs = pdfFonts.pdfMake.vfs;

      var dd = {
        pageSize: "A4",
        content: [
          {
            stack: [
              {
                columns: [
                  {
                    image: "ss_logo",
                    width: 60,
                    height: 60,
                  },
                  {
                    text: "एमएसएफ डायबिटीज केअर हेल्पलाइन\nMSF Diabetes Care Helpline",
                    fontSize: 12,
                  },
                  {
                    image: "nhm_logo",
                    width: 100,
                    height: 38,
                  },
                ],
              },
              { text: "ePrescription", style: "subheader" },
              //{canvas: [{ type: 'line', x1: 0, y1: 5, x2: 595-2*40, y2: 5, lineWidth: 1, color:'green' }]}
            ],
            style: "header",
          },
          {
            stack: [
              { text: $("#patient_name").text(), bold: true, lineHeight: 1.25 },
              { text: $("#patient_details").text(), lineHeight: 1.25 },
              { text: $("#address_and_contact").text(), lineHeight: 1.25 },
              { text: $("#visit_details").text(), lineHeight: 2 },
            ],
          },
          {
            stack: [
              {
                text: "वजह / Reason for visit",
                bold: true,
                decoration: "underline",
                fontSize: 12,
              },
              { text: k2h2 + "\n", lineHeight: 1 },
            ],
            //            {text:$('#complaints_heading').text().slice(20), lineHeight:2}]
          },

          {
            stack: [
              {
                text: "नब्ज / Vitals",
                bold: true,
                fontSize: 12,
                decoration: "underline",
                lineHeight: 1,
              },
              { text: $("#vitals").text().slice(13), lineHeight: 2 },
            ],
          },
          {
            stack: [
              {
                text: "आहार-सम्बन्धी अतिरिक्त जानकारी / Diet prescription",
                bold: true,
                decoration: "underline",
                fontSize: 12,
                lineHeight: 1,
              },

              //            {text:'निदान/ Diagnosis', bold:true,decoration: 'underline', fontSize:14,2lilineHeight:2},
              { text: $("#diagnosis_heading").text().slice(50)+ "\n", lineHeight: 2 },
            ],
          },
          {
            stack: [
              {
                text: "आहार-विशेष से एलर्जी / Food Allergy",
                bold: true,
                decoration: "underline",
                fontSize: 12,
                lineHeight: 1,
              },

              //            {text:'निदान/ Diagnosis', bold:true,decoration: 'underline', fontSize:14,2lilineHeight:2},
              { text: $("#food_allergy").text().slice(35), lineHeight: 2 },
            ],
          },
          {
            stack: [
              {
                text: "पोषण विशेषज्ञ प्रिस्क्रिप्शन / Nutritionist Prescription",
                bold: true,
                decoration: "underline",
                fontSize: 12,
                lineHeight: 1,
              },
              //            {text:'Medication(s)/दवाएं', bold:true,decoration: 'underline', fontSize:142},
              {
                text:
                  $("#rx_heading").text().slice(56).replaceAll(";", "\n") +
                  "\n\n",
                lineHeight: 1,
              },
            ],
          },

          {
            stack: [
              {
                text: "जांच की सिफारिश / Recommended Investigation(s)",
                bold: true,
                decoration: "underline",
                fontSize: 12,
                lineHeight: 1,
              },
              {
                text: $("#tests_heading").text().slice(47) + "\n",
                lineHeight: 1,
              },
            ],
          },

          {
            stack: [
              {
                text: "\nसामान्य सलाह / General Advice",
                bold: true,
                decoration: "underline",
                fontSize: 12,
                lineHeight: 1,
              },
              //            {text:'सामान्य सलाह / General Advice', bold:true,decoration: 'underline', fontSize:14, 2ineHeight:2,f1nt:'Rajdhani'},
              //{text:$('#advice_heading2').text().slice(29),lineHeight:1}]
              { ul: kkN },
            ],
          },

          {
            stack: [
              {
                text: "\nफिर से संपर्क कि तारीख / Follow Up Date",
                bold: true,
                decoration: "underline",
                fontSize: 12,
                lineHeight: 1,
              },
              // {text:'Follow Up Date/फिर से संपर्क कि तारीख', bold:true,decoration: 'underline', fontSize:12, lineHeight:1},
              //            {text:'Follow Up Date/फिर से संपर्क कि तारीख', bold:true,decoration: 'underline', fontSize:14, lineHeight:2,font:'Rajdhani'},
              //           {text:$('#follow_up_heading').text().slice(39).split(" ")[0]},
              { text: j.join(" "), lineHeight: 1 },
            ],
          },

          {
            stack: [
              {
                text: $("#docSign").text(),
                font: $("#docSign")
                  .css("font-family")
                  .replace(/\b[a-zA-Z]/g, (match) => match.toUpperCase()),
                fontSize: 32,
                alignment: "right",
              },
              { text: docDe, alignment: "right", lineHeight: 1 },
              { text: $("#docReg").text(), bold: true, alignment: "right" },
            ],
          },
        ],
        styles: {
          header: {
            fontSize: 18,
            bold: true,
            alignment: "center",
            margin: [0, 10, 0, 10],
          },
          subheader: {
            fontSize: 14,
            decoration: "underline",
          },
        },
        images: {
          nhm_logo: "https://msf-arogyabharat.intelehealth.org/preApi/ih-logo.png",
          ss_logo: "https://msf-arogyabharat.intelehealth.org/preApi/msf.png",
        },
        defaultStyle: {
          font: "Rajdhani",
          fontSize: 10,
        },
        footer: {
          text: "MSF Diabetes Care Helpline Number - +9118003094144",
          alignment: "center",
        },
      };
      fileName = getParameterByName("v").slice(-5) + "_prescription";

      pdfMake.createPdf(dd, null, fonts).download(fileName);
      alert("Prescription will be downloaded shortly");
    }

    jQuery(document).ready(init);
  </script>
  <script src="js/jquery-3.5.1.min.js"></script>
  <script src="js/popper.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/pdfmake.min.js"></script>
  <script src="js/vfs_fonts.js"></script>
</html>
