package com.cj.freshway.fs.cps.airstar.storemng.entity;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class ShopScheduleEntity {
    private String coId;
    private String storeId;
    private String scheduleDate;
    private String openStatus;
    private Integer schedulePriority;
    private String openTime;
    private String lastOrderTime;
    private String closeTime;
    private String closedReasonKor;
    private String closedReasonEn;
    private String closedReasonJp;
    private String closedReasonZhCn;
    private String closedReasonZhTw;
    private String useYn;
    private String syncStatus;
    private String regrId;
    private LocalDateTime regDttm;
    private String updtId;
    private LocalDateTime updtDttm;

    // 프론트에서 전달하는 추가 필드
    private String status; // C:신규, U:수정
}
