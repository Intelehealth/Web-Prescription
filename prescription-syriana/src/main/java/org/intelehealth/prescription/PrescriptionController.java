package org.intelehealth.prescription;
import java.util.HashMap;

import org.intelehealth.prescription.model.DataTraveller;
import org.intelehealth.prescription.model.ReturnMe;
import org.intelehealth.prescription.service.PrescriptionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping ("/prescription")

public class PrescriptionController {
	@Autowired
	PrescriptionService ps;
	@CrossOrigin(origins = "*")
	@RequestMapping("/visitData")
	public ReturnMe visitData(@RequestBody DataTraveller datatraveller) {
	//	return new Greeting(counter.incrementAndGet(), String.format(template, name));
		return ps.checkCombo(datatraveller.getVisitId(), datatraveller.getPatientId());
	}
}
