package com.gh.covid19.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

public class CovidClinicVO {

	private String clinicIdx;
	
	private String megalopolis; //시 도 
	
	private String gu; //군,구
	
	private String clinicName; //선별진료소 이름
	
	private String zipCode; //우편번호
	
	private String clinicLocation;//선별진료소 위치

	private String phoneNumber;//전화번호
	
	private String taksPosition;//검쳐여부

	public String getClinicIdx() {
		return clinicIdx;
	}

	public void setClinicIdx(String clinicIdx) {
		this.clinicIdx = clinicIdx;
	}

	public String getMegalopolis() {
		return megalopolis;
	}

	public void setMegalopolis(String megalopolis) {
		this.megalopolis = megalopolis;
	}

	public String getGu() {
		return gu;
	}

	public void setGu(String gu) {
		this.gu = gu;
	}

	public String getClinicName() {
		return clinicName;
	}

	public void setClinicName(String clinicName) {
		this.clinicName = clinicName;
	}

	public String getZipCode() {
		return zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	public String getClinicLocation() {
		return clinicLocation;
	}

	public void setClinicLocation(String clinicLocation) {
		this.clinicLocation = clinicLocation;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getTaksPosition() {
		return taksPosition;
	}

	public void setTaksPosition(String taksPosition) {
		this.taksPosition = taksPosition;
	}
	
	
}
