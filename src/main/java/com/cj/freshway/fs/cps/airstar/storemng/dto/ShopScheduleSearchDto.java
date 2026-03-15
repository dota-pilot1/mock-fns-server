package com.cj.freshway.fs.cps.airstar.storemng.dto;

import lombok.Data;

@Data
public class ShopScheduleSearchDto {
    private String coId;
    private String storeId;
    private String searchMonth;   // YYYYMM
    private String scheduleDate;  // YYYYMMDD
    private String startDate;     // YYYYMMDD (긴급: 시작일)
    private String endDate;       // YYYYMMDD (긴급: 종료일)
}
