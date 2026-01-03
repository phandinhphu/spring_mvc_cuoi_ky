package com.cuoi_ky.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RecentPracticeDTO {
	private String mode;
	private Date practiceDate;
	private String description;
	private String timeAgo;
}
