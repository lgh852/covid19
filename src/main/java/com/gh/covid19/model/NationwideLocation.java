package com.gh.covid19.model;

public class NationwideLocation {

	String []latArray = {"126.978357","129.075332","128.601243","126.705725","126.851454","127.384583","129.311242","127.289036","127.008965","127.730264","127.491392","126.673829","127.108213","126.463634","128.50489","128.691938","126.498122"};
	String []lonArray = {"37.566698","35.18021","35.871469","37.456244","35.160041","36.350383","35.538905","36.480062","37.275268","37.8856","36.635727","36.659178","35.819795","34.816853","36.57592","35.237489","33.488683"};
	String []location = {"서울","부산","대구","인천","광주","대전","울산","세종","경기","강원","충청","충청","전북","전남","경상","경상","제주"};

	public String[] getLatArray() {
		return latArray;
	}
	public void setLatArray(String[] latArray) {
		this.latArray = latArray;
	}
	public String[] getLonArray() {
		return lonArray;
	}
	public void setLonArray(String[] lonArray) {
		this.lonArray = lonArray;
	}
	public String[] getLocation() {
		return location;
	}
	public void setLocation(String[] location) {
		this.location = location;
	}
	
}
