package com.cj.freshway.fs.cps.airstar.storemng.dto;

import lombok.Data;

@Data
public class ShopScheduleSearchDto {
    private String coId;
    private String storeId;
    private String searchMonth;   // YYYYMM
    private String scheduleDate;  // YYYYMMDD
}
