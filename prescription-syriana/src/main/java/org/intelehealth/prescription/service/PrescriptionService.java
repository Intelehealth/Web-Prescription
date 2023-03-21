package org.intelehealth.prescription.service;

import java.util.HashMap;

import org.intelehealth.prescription.PrescriptionDao;
import org.intelehealth.prescription.model.ReturnMe;
import org.springframework.stereotype.Service;

@Service
public class PrescriptionService {

	public ReturnMe checkCombo(String visitId, String patientId) {
		// TODO Auto-generated method stub
		PrescriptionDao pd = new PrescriptionDao();
		return pd.checkCombo(visitId,patientId);
	}

}
