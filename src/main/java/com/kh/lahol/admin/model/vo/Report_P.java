package com.kh.lahol.admin.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Report_P {
	private String prCode;
	private String reportNo;
	private String cafe;
	private String reportType;
	private String reportReason;
	private String ceo;
	private String phone;
	private String service;
	private String accu;
	private String reporter;
	private String reportee;
	private String status;
}
