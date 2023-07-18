package org.intelehealth.prescription;

import java.sql.*;

import org.intelehealth.prescription.model.ReturnMe;


public class PrescriptionDao {

	Connection con ; 
	//private static String dbUrl = "jdbc:mysql://azureuser_openmrs-referenceapplication-mysql_1:3306/openmrs";
	private static final String dbUrl = "jdbc:mysql://localhost:3306/openmrs";
	private static final String dbUsername = "root";
	private static final String dbPassword = "i10hi1c";
	public static Connection getConnection()
    {
		 Connection con = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con =  DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
        return con;
    }
	
	public ReturnMe checkCombo(String visitUUID, String openMRSId) {
		ReturnMe returnme = new ReturnMe();
		try {
			con = getConnection();
			String vCheckQuery = "SELECT COUNT(1) FROM visit WHERE uuid = ? AND patient_id=(SELECT patient_id from patient_identifier WHERE identifier =?)";
			PreparedStatement pstmt = con.prepareStatement(vCheckQuery);
			pstmt.setString(1,visitUUID);
			pstmt.setString(2,openMRSId);
			ResultSet rst = pstmt.executeQuery();
			rst.next();
			int noOfRows =rst.getInt(1);

			returnme.setNoOfRows(String.valueOf(noOfRows));
			if(noOfRows==0)
			{
				returnme.setStatus("No Data found");
			}
			else
			{
				String prescriptionQuery="SELECT patient_id, \n" +
						"identifier as 'OpenMRS ID', \n" +
						"gender, \n" +
						"Age, \n" +
						"patient_name,\n" +
						"address,\n" +
						"visit_id, \n" +
						"date_started as 'Visit_Date', \n" +
						"location_id, \n" +
						"location_name, \n" +
						"birthdate AS 'DateOfBirth' , \n" +
					//	"value AS 'CitizenId' , \n" +
						"max(CurrCom) as 'Chief Complaint', \n" +
						"max(PhyExm) as 'Physical Examination', \n" +
						"max(FamHis) as 'Family History', \n" +
						"max(MedHis) as 'Medical History', \n" +
						"max(SBP) as 'SBP', \n" +
						"max(DBP) as 'DBP', \n" +
						"max(Heart_Rate) as 'Heart Rate', \n" +
						"max(Temp) as 'Temperature', \n" +
						"max(Weight) as'Weight', \n" +
						"max(height) as 'Height',\n" +
						"max(Resp_Rate) as 'Resp_Rate',\n" +
						"max(SPO2) as 'SPO2',\n" +
						"max(BloodGroup) as 'Blood Group' , \n" +
						"max(Haemoglobin) as 'Haemoglobin' , \n" +
						"max(SugarFasting) as 'Sugar Fasting' , \n" +
						"max(SugarRandom) as 'Sugar Random' , \n" +
						"max(SugarPP) as 'Sugar After Meal' , \n" +
				//		" max(arm_girth) as 'Arm Girth' , \n" +
				//		" max(total_cholesterol_id) as 'Total Cholesterol Id' , \n" +
				//		" max(abdominal_girth) as 'Abdominal Girth' , \n" +
			//			" max(billPriceBloodGlucoseFastingId) as 'Bill Price Blood Glucose Fasting Id' , \n" +
			//			" max(billPriceBloodGlucoseId) as 'Bill Price Blood Glucose Id' , \n" +
			//			" max(billPriceBloodGlucoseRandomId) as 'Bill Price Blood Glucose Random Id' , \n" +
		//				" max(billPriceBloodGlucosePostPrandialId) as 'Bill Price Blood Glucose Post Prandial Id' , \n"+
		//				" max(ecg) as 'ECG' , \n"+
						"group_concat(distinct Diagnosis separator '; ') as 'Diagnosis', \n" +
						"group_concat(distinct Medication separator '; ') as 'Medication', \n" +
						"group_concat(distinct Medical_Advice separator '; ') as 'Medical Advice', \n" +
						"group_concat(distinct Notes separator '; ') as 'Notes', \n" +
						"group_concat(distinct Medical_Tests separator '; ') as 'Medical Tests', \n" +
						"group_concat(distinct IsEmergency separator '; ') as 'IsEmergency', \n" +
						"group_concat(distinct Followup separator '; ') as 'Followup Requested' \n" +
						"FROM ( \n" +
						"select v.patient_id, \n" +
						"pi.identifier, \n" +
						"v.visit_id, \n" +
						"v.location_id, \n" +
						"l.name AS location_name, \n"+
						"v.date_started, \n" +
						"p.gender,\n" +
						"p.birthdate,\n" +
					//	"pat.value,\n" +
						"concat_ws(',',  pn.given_name, pn.middle_name, pn.family_name) as patient_name,\n" +
						"concat_ws(',', pa.address1, pa.address2, pa.city_village, pa.postal_code) AS address,\n" +
					//	"pa.state_province as Address,\n" +
						"YEAR(curdate())-YEAR(p.birthdate) as 'Age',\n" +
						"case o.concept_id \n" +
						"when 163212 then o.value_text\n" +
						"else ''  end as 'CurrCom', \n" +
						"case o.concept_id \n" +
						"when 163213 then strip_tags(o.value_text) \n" +
						"else '' end as 'PhyExm', \n" +
						"case o.concept_id \n" +
						"when 163211 then strip_tags(o.value_text) \n" +
						"else '' end as 'FamHis',\t\t\t \n" +
						"case o.concept_id \n" +
						"when 163210 then strip_tags(o.value_text) \n" +
						"else '' end as 'MedHis',\t \n" +
						"case o.concept_id \n" +
						"when 5085 then o.value_numeric \n" +
						"else 0 end as 'SBP', \n" +
						"case o.concept_id \n" +
						"when 5086 then o.value_numeric \n" +
						"else 0 end as 'DBP', \n" +
						"case o.concept_id \n" +
						"when 5087 then o.value_numeric \n" +
						"else 0 end as 'Heart_Rate',\t\t \n" +
						"case o.concept_id \n" +
						"when 5088 then o.value_numeric \n" +
						"else 0 end as 'Temp', \n" +
						"case o.concept_id \n" +
						"when 5089 then o.value_numeric \n" +
						"else 0 end as 'Weight', \n" +
						"case o.concept_id \n" +
						"when 5090 then o.value_numeric \n" +
						"else 0 end as 'Height',\t\n" +
						"case o.concept_id\n" +
						"when 5092 then o.value_numeric \n" +
						"else 0 end as 'SPO2',\t\t\n" +
						"case o.concept_id\n" +
						"when 5242 then o.value_numeric\n" +
						"else 0 end as 'Resp_Rate',\t\t\n" +
						"case o.concept_id \n" +
						"when 163219 then o.value_text \n" +
						"else '' end as 'Diagnosis', \n" +
						"case o.concept_id \n" +
						"when 163202 then o.value_text \n" +
						"else '' end as 'Medication', \n" +
						"case o.concept_id \n" +
						"when 165180 then o.value_text \n" +
						"else '' end as 'BloodGroup', \n" +
						"case o.concept_id \n" +
						"when 165175 then o.value_text \n" + //165175 -- ekal-production
						"else '' end as 'Haemoglobin', \n" +
						"case o.concept_id \n" +
						"when 165182 then o.value_text \n" +
						"else '' end as 'SugarRandom', \n" +
						"case o.concept_id \n" +
						"when 165183 then o.value_text \n" +
						"else '' end as 'SugarFasting', \n" +
						"case o.concept_id \n" +
						"when 165184 then o.value_text \n" +
						"else '' end as 'SugarPP', \n" +
						"case o.concept_id \n" +
						//"when 163205 then strip_tags(o.value_text) \n" +
						"when 163205 then o.value_text \n" +
						"else '' end as 'Medical_Advice', \n" +
						"case o.concept_id \n" +
						"when 163206 then o.value_text \n" +
						"else '' end as 'Medical_Tests', \n" +
						"case o.concept_id \n" +
						"when 162169 then o.value_text \n" +
						"else '' end as 'Notes'\t,\t \n" +
						"case o.concept_id \n" +
						"when 163373 then 'Yes' \n" +
						"else '' end as 'IsEmergency'\t, \n" +
						"case o.concept_id \n" +
						"when 163345 then o.value_text \n" +
						"else '' end as 'Followup' \n" +
						"from visit v, \n" +
						"patient_identifier pi, \n" +
						"encounter e, \n" +
						"obs o,\n" +
						"person_name pn, \n" +
						"person_address pa, \n" +
						//"person_attribute pat, \n" +
						"person p,\n" +
						"location l\n"+
						"where v.voided = 0 \n" +
					//	"and v.location_id <> 2 \n" +
						" and v.location_id = l.location_id \n" +
						"and pi.voided = 0 \n" +
						"and pi.patient_id = v.patient_id \n" +
						"and e.voided = 0 \n" +
						"and e.encounter_type in (1,6,9,14,15) \n" +
						"and e.visit_id = v.visit_id \n" +
						"and o.encounter_id = e.encounter_id \n" +
						"and o.voided = 0 \n" +
						"and o.comments is  null " + // Added for non-empty comments SOFT DELETE 07072023
						"and p.person_id = v.patient_id\n" +
						"and pn.person_id = v.patient_id\n" +
						"and pa.person_id = v.patient_id\n" +
						"and p.voided = 0\n" +
						//" and pat.person_attribute_type_id = 8 \n"+
						//"and pat.person_id = v.patient_id \n"+
						"and o.person_id in (SELECT patient_id from patient_identifier WHERE identifier = ?)\n" +
						"and v.uuid in (?)\n" +
						") as t \n" +
						"group by patient_id,identifier,visit_id,date_started,location_id,gender,Age,patient_name,birthdate, address\n" +
						"order by 1,5";
				//37 - person_attribute_type_id UNICEF
				// 8 - Telephone number
				PreparedStatement pstmt2 = con.prepareStatement(prescriptionQuery);
				pstmt2.setString(1,openMRSId);
				
				pstmt2.setString(2,visitUUID);
				ResultSet rst2 = pstmt2.executeQuery();
				rst2.next();
				returnme.setAge(rst2.getString("Age"));
				returnme.setDBP(rst2.getString("DBP"));
				returnme.setSBP(rst2.getString("SBP"));
				returnme.setBirthDate(rst2.getString("DateOfBirth"));
				//returnme.setCitizenId(rst2.getString("CitizenId"));

				returnme.setComplaint(rst2.getString("Chief Complaint"));
				returnme.setName(rst2.getString("patient_name"));
				returnme.setPhysicalExamination(rst2.getString("Physical Examination"));
				returnme.setDiagnosis(rst2.getString("Diagnosis"));
				returnme.setFollowupNeeded(rst2.getString("Followup Requested"));
				returnme.setGender(rst2.getString("gender"));
				returnme.setVisitDate(rst2.getString("Visit_Date"));
				returnme.setHeartRate(rst2.getString("Heart Rate"));
				returnme.setHeight(rst2.getString("Height"));
				returnme.setWeight(rst2.getString("Weight"));
				returnme.setTemperature(rst2.getString("Temperature"));
				returnme.setOpenMRSID(openMRSId);
				returnme.setSPO2(rst2.getString("SPO2"));
				returnme.setFamilyHistory(rst2.getString("Family History"));
				returnme.setMedicalHistory(rst2.getString("Medical History"));
				returnme.setDiagnosis(rst2.getString("Diagnosis"));
				returnme.setMedication(rst2.getString("Medication"));




				String beforeClean = rst2.getString("Medical Advice");

				int j = beforeClean.indexOf('<');
				int i = beforeClean.lastIndexOf('>');
				String tmp="";
				if (i >= 0 && j >= 0) {
					tmp = beforeClean.substring(j, i + 1);
				} else {
					tmp = "";
				}
				//Log.d("Hyperlink", "Hyperlink: " + medicalAdvice_HyperLink);
				String kk  = beforeClean.replaceAll(tmp, "");
				//Log.d("Hyperlink", "hyper_string: " + medicalAdvice_string);
				/*
				 * variable a contains the hyperlink sent from webside.
				 * variable b contains the string data (medical advice) of patient.
				 * */
				beforeClean = kk.replace("\n\n", "\n");

				returnme.setMedicalAdvice(beforeClean);
				returnme.setNotes(rst2.getString("Notes"));
				returnme.setTestsAdvised(rst2.getString("Medical Tests"));
				returnme.setStatus("OK");
				returnme.setAddress(rst2.getString("address"));

			returnme.setRespRate(rst2.getString("Resp_Rate"));
				returnme.setPulseRate(rst2.getString("Heart Rate"));
				returnme.setBloodGroup(rst2.getString("Blood Group"));
				returnme.setHaemoGlobin(rst2.getString("Haemoglobin"));
				returnme.setSugarRandom(rst2.getString("Sugar Random"));
				returnme.setSugarFasting(rst2.getString("Sugar Fasting"));
				returnme.setSugarAfterMeal(rst2.getString("Sugar After Meal"));
				returnme.setLocationName(rst2.getString("location_name"));

				// Added to pick up only that provider who has given prescription -- encounter_type 14
				String providerFinderQuery = "select DISTINCT provider_id from encounter_provider WHERE encounter_id in (SELECT encounter_id FROM encounter WHERE visit_id = (SELECT visit_id\n" +
						" from visit where uuid=?) AND encounter_type = 14 ) AND provider_id in (select provider.provider_id from provider,users,user_role WHERE provider.person_id = users.person_id and user_role.user_id = users.user_id and user_role.role like '%Doctor%')";

				PreparedStatement pstmt3 = con.prepareStatement(providerFinderQuery);
				pstmt3.setString(1,visitUUID);
				ResultSet rst44 = pstmt3.executeQuery();
				rst44.next();
				int providerId = rst44.getInt(1);


				String doctorAtrribsQuery="select group_concat(concat_ws(':',a.name , b.value_reference) SEPARATOR '|') AS doctorAttribs from provider_attribute_type a, provider_attribute b  WHERE a.provider_attribute_type_id IN (4,3,9,7,6,5,8,1)  AND a.provider_attribute_type_id =  b.attribute_type_id AND b.provider_id = ? ";
				PreparedStatement pstmt4 = con.prepareStatement(doctorAtrribsQuery);
				pstmt4.setInt(1,providerId);
				ResultSet rst55 = pstmt4.executeQuery();
				rst55.next();
				returnme.setDoctorAttributes(rst55.getString(1));

				String doctorNameQuery = "SELECT concat_ws(' ',given_name,family_name) FROM person_name WHERE person_id = (SELECT person_id from provider WHERE provider_id = ?)";
				PreparedStatement pstmt5 = con.prepareStatement(doctorNameQuery);
				pstmt5.setInt(1,providerId);
				ResultSet rst66 = pstmt5.executeQuery();
				rst66.next();
				returnme.setDoctorName(rst66.getString(1));


				String diagnosisQuery = "select " +
						" group_concat(DISTINCT json_unquote(json_extract(value_text,'$.ar')) SEPARATOR '#') as arDiagnosis, "+
						" group_concat(DISTINCT json_unquote(json_extract(value_text,'$.en')) SEPARATOR '#') as enDiagnosis "+
						" from obs where concept_id = 163219 "+
						" AND "+
						" person_id = (select patient_id from patient_identifier where identifier=?) "+
						" AND voided = 0 AND comments IS  NULL"+
						" AND encounter_id in (select encounter_id from encounter where visit_id in "+
						" (select visit_id from visit where uuid = ?))";

				PreparedStatement diagStatment = con.prepareStatement(diagnosisQuery);
				diagStatment.setString(1,openMRSId);
				diagStatment.setString(2,visitUUID);
				ResultSet rstDiagnosis = diagStatment.executeQuery();
				rstDiagnosis.next();
				returnme.setArDiagnosis(rstDiagnosis.getString(1));
				returnme.setEnDiagnosis(rstDiagnosis.getString(2));

				rstDiagnosis.close();
				diagStatment.close();

				String medicationQuery = "select "+
						" group_concat(DISTINCT json_unquote(json_extract(value_text,'$.ar'))  SEPARATOR '#') as arMedication, "+
						" group_concat(DISTINCT json_unquote(json_extract(value_text,'$.en'))  SEPARATOR '#') as enMedication "+
						" from "+
						" obs where concept_id = 163202 "+
						" AND "+
						" person_id = (select patient_id from patient_identifier where identifier=?) "+
						" AND voided = 0 AND comments IS NULL "+
						" AND encounter_id in (select encounter_id from encounter where visit_id in "+
						" (select visit_id from visit where uuid = ?))";

				PreparedStatement medicationStatement = con.prepareStatement(medicationQuery);
				medicationStatement.setString(1,openMRSId);
				medicationStatement.setString(2,visitUUID);
				ResultSet rstMedication = medicationStatement.executeQuery();
				rstMedication.next();
				returnme.setArMedication(rstMedication.getString(1));
				returnme.setEnMedication(rstMedication.getString(2));

				rstMedication.close();
				medicationStatement.close();

				String medicalTestQuery = "select "+
						" group_concat(DISTINCT json_unquote(json_extract(value_text,'$.ar'))   SEPARATOR '#') as arMedicalTests, "+
						" group_concat(DISTINCT json_unquote(json_extract(value_text,'$.en'))  SEPARATOR '#') as enMedicalTests "+
						" from "+
						" obs where concept_id = 163206 "+
						" AND "+
						" person_id = (select patient_id from patient_identifier where identifier=?) "+
						" AND voided = 0 AND comments IS  NULL "+
						" AND encounter_id in (select encounter_id from encounter where visit_id in "+
						" (select visit_id from visit where uuid = ?))";

				PreparedStatement medicalTestStatement = con.prepareStatement(medicalTestQuery);
				medicalTestStatement.setString(1,openMRSId);
				medicalTestStatement.setString(2,visitUUID);
				ResultSet rstMedicalTests = medicalTestStatement.executeQuery();
				rstMedicalTests.next();
				returnme.setArMedicalTests(rstMedicalTests.getString(1));
				returnme.setEnMedicalTests(rstMedicalTests.getString(2));

				rstMedicalTests.close();
				medicalTestStatement.close();

				String medicalAdviceQuery = "select "+
						" group_concat(DISTINCT json_unquote(json_extract(value_text,'$.ar'))  SEPARATOR '#') as arMedicalTests, "+
						" group_concat(DISTINCT json_unquote(json_extract(value_text,'$.en'))  SEPARATOR '#') as enMedicalTests "+
						" from "+
						" obs where concept_id = 163205 "+
						" AND "+
						" person_id = (select patient_id from patient_identifier where identifier=?) "+
						" AND voided = 0 AND comments IS  NULL "+
						" AND encounter_id in (select encounter_id from encounter where visit_id in "+
						" (select visit_id from visit where uuid = ?)) AND JSON_VALID(value_text)";

				PreparedStatement medicalAdviceStatement = con.prepareStatement(medicalAdviceQuery);
				medicalAdviceStatement.setString(1,openMRSId);
				medicalAdviceStatement.setString(2,visitUUID);
				ResultSet rstMedicalAdvice = medicalAdviceStatement.executeQuery();
				rstMedicalAdvice.next();
				returnme.setArMedicalAdvice(rstMedicalAdvice.getString(1));
				returnme.setEnMedicalAdvice(rstMedicalAdvice.getString(2));

				rstMedicalAdvice.close();
				medicalAdviceStatement.close();

				String notesQuery = "select "+
						" group_concat(DISTINCT json_unquote(json_extract(value_text,'$.ar'))  SEPARATOR '#') as arMedicalTests, "+
						" group_concat(DISTINCT json_unquote(json_extract(value_text,'$.en'))  SEPARATOR '#') as enMedicalTests "+
						" from "+
						" obs where concept_id = 162169 "+
						" AND "+
						" person_id = (select patient_id from patient_identifier where identifier=?) "+
						" AND voided = 0 AND comments IS  NULL "+
						" AND encounter_id in (select encounter_id from encounter where visit_id in "+
						" (select visit_id from visit where uuid = ?))";

				PreparedStatement notesStatement = con.prepareStatement(notesQuery);
				notesStatement.setString(1,openMRSId);
				notesStatement.setString(2,visitUUID);
				ResultSet rstNotes = notesStatement.executeQuery();
				rstNotes.next();
				returnme.setArNotes(rstNotes.getString(1));
				returnme.setEnNotes(rstNotes.getString(2));

				rstNotes.close();
				notesStatement.close();

				String followupQuery = "select "+
						" group_concat(DISTINCT json_unquote(json_extract(value_text,'$.ar'))  SEPARATOR '#') as arFollowup, "+
						" group_concat(DISTINCT json_unquote(json_extract(value_text,'$.en'))  SEPARATOR '#') as enFollowup "+
						" from "+
						" obs where concept_id = 162169 "+
						" AND "+
						" person_id = (select patient_id from patient_identifier where identifier=?) "+
						" AND voided = 0 AND comments IS  NULL "+
						" AND encounter_id in (select encounter_id from encounter where visit_id in "+
						" (select visit_id from visit where uuid = ?))";

				PreparedStatement followupStatement = con.prepareStatement(followupQuery);
				followupStatement.setString(1,openMRSId);
				followupStatement.setString(2,visitUUID);
				ResultSet rstFollowup = followupStatement.executeQuery();
				rstFollowup.next();
				returnme.setArFollowup(rstFollowup.getString(1));
				returnme.setEnFollowUp(rstFollowup.getString(2));

				rstFollowup.close();
				followupStatement.close();

				String medicalEquipmentLoanQuery="SELECT json_unquote(json_extract(value_text,'$.en')) as enMELoan, " +
				"json_unquote(json_extract(value_text,'$.ar')) as arMELoan" +
						" from "+
						" obs where concept_id = 165406 "+
						" AND "+
						" person_id = (select patient_id from patient_identifier where identifier=?) "+
						" AND voided = 0  AND comments IS NULL"+
						" AND encounter_id in (select encounter_id from encounter where visit_id in "+
						" (select visit_id from visit where uuid = ?))";

				PreparedStatement medicalEquipmentLoanStatement = con.prepareStatement(medicalEquipmentLoanQuery);
				medicalEquipmentLoanStatement.setString(1,openMRSId);
				medicalEquipmentLoanStatement.setString(2,visitUUID);
				ResultSet rstMEL = medicalEquipmentLoanStatement.executeQuery();
				if(rstMEL.next()) {
					returnme.setArMEL(rstMEL.getString(2));
					returnme.setEnMEL(rstMEL.getString(1));
				}
				rstMEL.close();
				medicalEquipmentLoanStatement.close();

				String freeMedicalEquipementQuery="SELECT json_unquote(json_extract(value_text,'$.en')) as enFreeMedicalEquipment, " +
						"json_unquote(json_extract(value_text,'$.ar')) as arFreeMedicalEquipment" +
						" from "+
						" obs where concept_id = 165407 "+
						" AND "+
						" person_id = (select patient_id from patient_identifier where identifier=?) "+
						" AND voided = 0  AND comments IS NULL "+
						" AND encounter_id in (select encounter_id from encounter where visit_id in "+
						" (select visit_id from visit where uuid = ?))";

				PreparedStatement freeMedicalEquipmentStatement = con.prepareStatement(freeMedicalEquipementQuery);
				freeMedicalEquipmentStatement.setString(1,openMRSId);
				freeMedicalEquipmentStatement.setString(2,visitUUID);
				ResultSet rstFME = freeMedicalEquipmentStatement.executeQuery();

				if(rstFME.next()) {
					returnme.setArFME(rstFME.getString(2));
					returnme.setEnFME(rstFME.getString(1));
				}
				rstFME.close();
				freeMedicalEquipmentStatement.close();

				String coverMedicalExpensesQuery="SELECT json_unquote(json_extract(value_text,'$.en')) as enCoverMedicalExpenses, " +
						"json_unquote(json_extract(value_text,'$.ar')) as arCoverMedicalExpenses" +
						" from "+
						" obs where concept_id = 165408"+
						" AND "+
						" person_id = (select patient_id from patient_identifier where identifier=?) "+
						" AND voided = 0 AND comments IS  NULL "+
						" AND encounter_id in (select encounter_id from encounter where visit_id in "+
						" (select visit_id from visit where uuid = ?))";

				PreparedStatement coverMedicalExpensesStatement = con.prepareStatement(coverMedicalExpensesQuery);
				coverMedicalExpensesStatement.setString(1,openMRSId);
				coverMedicalExpensesStatement.setString(2,visitUUID);
				ResultSet rstCME = coverMedicalExpensesStatement.executeQuery();
				if(rstCME.next()) {
					returnme.setArCME(rstCME.getString(2));
					returnme.setEnCME(rstCME.getString(1));
				}
				rstCME.close();
				coverMedicalExpensesStatement.close();

				String coverSurgicalExpensesQuery="SELECT json_unquote(json_extract(value_text,'$.en')) as enCoverSurgicalExpenses, " +
						"json_unquote(json_extract(value_text,'$.ar')) as arCoverMedicalExpenses" +
						" from "+
						" obs where concept_id = 165409"+
						" AND "+
						" person_id = (select patient_id from patient_identifier where identifier=?) "+
						" AND voided = 0 AND comments IS  NULL "+
						" AND encounter_id in (select encounter_id from encounter where visit_id in "+
						" (select visit_id from visit where uuid = ?))";

				PreparedStatement coverSurgicalExpensesStatement = con.prepareStatement(coverSurgicalExpensesQuery);
				coverSurgicalExpensesStatement.setString(1,openMRSId);
				coverSurgicalExpensesStatement.setString(2,visitUUID);
				ResultSet rstCSE = coverSurgicalExpensesStatement.executeQuery();
				if(rstCSE.next()) {
					returnme.setArCSE(rstCSE.getString(2));
					returnme.setEnCSE(rstCSE.getString(1));
				}
				rstCSE.close();
				coverSurgicalExpensesStatement.close();

				String cashAssistanceQuery="SELECT json_unquote(json_extract(value_text,'$.en')) as enCashAssistance, " +
						"json_unquote(json_extract(value_text,'$.ar')) as arCashAssitance" +
						" from "+
						" obs where concept_id = 165410"+
						" AND "+
						" person_id = (select patient_id from patient_identifier where identifier=?) "+
						" AND voided = 0 AND comments IS  NULL "+
						" AND encounter_id in (select encounter_id from encounter where visit_id in "+
						" (select visit_id from visit where uuid = ?))";

				PreparedStatement cashAssistanceStatement = con.prepareStatement(cashAssistanceQuery);
				cashAssistanceStatement.setString(1,openMRSId);
				cashAssistanceStatement.setString(2,visitUUID);
				ResultSet rstCCA = cashAssistanceStatement.executeQuery();
				if(rstCCA.next() ) {
					returnme.setArCCA(rstCCA.getString(2));
					returnme.setEnCCA(rstCCA.getString(1));
				}
				rstCCA.close();
				cashAssistanceStatement.close();

				String dischargeOrderQuery="SELECT json_unquote(json_extract(value_text,'$.en')) as enDischargeOrder, " +
						"json_unquote(json_extract(value_text,'$.ar')) as arDischargeOrder" +
						" from "+
						" obs where concept_id = 165411"+
						" AND "+
						" person_id = (select patient_id from patient_identifier where identifier=?) "+
						" AND voided = 0 AND comments IS NULL "+
						" AND encounter_id in (select encounter_id from encounter where visit_id in "+
						" (select visit_id from visit where uuid = ?))";
				PreparedStatement dischargeOrderStatement = con.prepareStatement(dischargeOrderQuery);
				dischargeOrderStatement.setString(1,openMRSId);
				dischargeOrderStatement.setString(2,visitUUID);
				ResultSet rstDO = dischargeOrderStatement.executeQuery();
				if(rstDO.next()) {
					returnme.setDischargeOrder(true);
					returnme.setArDischargeOrder(rstDO.getString(2));
					returnme.setEnDischargeOrder(rstDO.getString(1));
				}

				rstDO.close();
				dischargeOrderStatement.close();




				/* AEAT-12 Doctor's signature is now pushed as an image
				* So pull the base64 representation image in String
				* And set the image src as this base64 String


				String doctorSignQuery = "select value_reference from provider_attribute WHERE attribute_type_id = 10 and provider_id = ?";
				PreparedStatement pstmt6 = con.prepareStatement(doctorSignQuery);
				pstmt6.setInt(1,providerId);
				ResultSet rst77 = pstmt6.executeQuery();
				if (!rst77.isBeforeFirst())
				{

					String placeHolderImage  = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAASwAAABkBAMAAADOLxDzAAAAHlBMVEX///8AAACfn58fHx8/Pz+/v79/f3/f399fX1+Pj499dADfAAAACXBIWXMAAA7EAAAOxAGVKw4bAAABsUlEQVRoge3U30vCUBjG8fds6Nnlq5Z1qYyoy2WtH3dTKG8XFnW56KbLY7PychGaf3bvOSkVCAU1g3g+oI7zDvflbEoEAAAAAAAAAAAAAAAAAPAr6qTcp34+MsvPGGaLIzV/cflZjXlWMDkv3i+nPpwRJvMDXmHWWustwTc6SpdmTRcV6Qqz1iNFNweS1ZLLjTqsblqDRqubyNbUk4EM6DCmHh3vdmS3ZKLCPrFbLxX3VLU/yshrTIhnY1ZbUedOUiVr8zLODVWSGd3qve1QluzkZUYbdr3krHPlp5WI6K6b8aFmZTi9Z5e14RXVjKrZgHJvos9kyU5MTnW7XnKWf6bs0+JRJWK2NTw4fcviaq1WkF+rGX98sX9tb6KdKGra9ZKzvK7bLd9Q5HaLOHZNQ8nKtKHh4ygLQj+1pXYiu9W06yVn0a57toKTq4Jvxy5L3k3cJtZxntIOeUnlyL98slkyeZnaZyv98ot/mtV2v0SSv1MOmjar3ZkFRSg3jUIZ9Egz1b3GTsFKJuq6IA5L/yV+kupopdf7pulD8dcJy+RrZT/KAAAAAAAAAAAAAAD/yyubDkU2aEAJ8gAAAABJRU5ErkJggg==";

					returnme.setImageOfSignature(placeHolderImage);
				}

				else {
					rst77.next();

					returnme.setImageOfSignature(rst77.getString(1));
				}
				* */

// Adding for Unicef Training -- Fetch details of Remote doctor giving a prescription
// Encounter Type 17

				providerFinderQuery = "select DISTINCT provider_id from encounter_provider WHERE encounter_id in (SELECT encounter_id FROM encounter WHERE visit_id = (SELECT visit_id\n" +
						" from visit where uuid=?) AND encounter_type = 17 ) AND provider_id in (select provider.provider_id from provider,users,user_role WHERE provider.person_id = users.person_id and user_role.user_id = users.user_id and user_role.role like '%Doctor%')";

				pstmt3 = con.prepareStatement(providerFinderQuery);
				pstmt3.setString(1,visitUUID);
				rst44 = pstmt3.executeQuery();
				rst44.next();
				providerId = rst44.getInt(1);


				doctorAtrribsQuery="select group_concat(concat_ws(':',a.name , b.value_reference) SEPARATOR '|') AS doctorAttribs from provider_attribute_type a, provider_attribute b  WHERE a.provider_attribute_type_id IN (4,3,9,7,6,5,8,1)  AND a.provider_attribute_type_id =  b.attribute_type_id AND b.provider_id = ? ";
				pstmt4 = con.prepareStatement(doctorAtrribsQuery);
				pstmt4.setInt(1,providerId);
				rst55 = pstmt4.executeQuery();
				rst55.next();
				returnme.setRemoteDoctorAttributes(rst55.getString(1));

				doctorNameQuery = "SELECT concat_ws(' ',given_name,family_name) FROM person_name WHERE person_id = (SELECT person_id from provider WHERE provider_id = ?)";
				pstmt5 = con.prepareStatement(doctorNameQuery);
				pstmt5.setInt(1,providerId);
				rst66 = pstmt5.executeQuery();
				rst66.next();
				returnme.setRemoteDoctorName(rst66.getString(1));








// Adding for Unicef Training -- End Fetch details of Remote doctor giving a prescription





				//Cleaning Up
				//rst77.close();
				rst66.close();
				rst55.close();
				rst44.close();
				rst2.close();
				rst.close();

				pstmt.close();
				pstmt2.close();
				pstmt3.close();
				pstmt4.close();
				pstmt5.close();
			//	pstmt6.close();

				con.close();



			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
		return returnme;
		
	}
	
}
