package com.cj.freshway.fs.cps.airstar.storemng;

import com.cj.freshway.fs.cps.airstar.storemng.dto.ShopScheduleSearchDto;
import com.cj.freshway.fs.cps.airstar.storemng.entity.ShopScheduleEntity;
import com.cj.freshway.fs.cps.common.base.FscpsBaseController;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Tag(name = "매장 스케줄 관리", description = "Airstar 매장 스케줄 조회/저장 (DB 연동)")
@Slf4j
@RestController
@RequestMapping("api/airstar/shopschedulemng")
@RequiredArgsConstructor
public class ShopScheduleController extends FscpsBaseController {

    private final ShopScheduleService service;

    @Operation(summary = "월 스케줄 목록 조회", description = "coId + storeId + searchMonth(YYYYMM)로 해당 월 스케줄 전체 조회")
    @PostMapping("v1.0/selectScheduleMonthList")
    public Map<String, Object> selectScheduleMonthList(@RequestBody ShopScheduleSearchDto dto) {
        log.info("[Schedule] selectScheduleMonthList - storeId={}, month={}", dto.getStoreId(), dto.getSearchMonth());

        Map<String, Object> result = new HashMap<>();
        try {
            if (dto.getCoId() == null || dto.getCoId().isEmpty()) {
                dto.setCoId("FW00");
            }
            List<ShopScheduleEntity> list = service.selectScheduleMonthList(dto);
            result.put("code", "200");
            result.put("data", list);
        } catch (Exception e) {
            log.error("월 스케줄 조회 실패", e);
            result.put("code", "500");
            result.put("message", "스케줄 조회 실패");
            result.put("data", null);
        }
        return result;
    }

    @Operation(summary = "스케줄 저장", description = "신규(status=C) 또는 수정(status=U). 우선순위 자동 계산")
    @PostMapping("v1.0/saveSchedule")
    public Map<String, Object> saveSchedule(@RequestBody ShopScheduleEntity entity) {
        log.info("[Schedule] saveSchedule - storeId={}, date={}, status={}",
                entity.getStoreId(), entity.getScheduleDate(), entity.getStatus());

        Map<String, Object> result = new HashMap<>();
        try {
            if (entity.getCoId() == null || entity.getCoId().isEmpty()) {
                entity.setCoId("FW00");
            }
            service.saveSchedule(entity);
            result.put("code", "200");
            result.put("message", "저장되었습니다.");
        } catch (Exception e) {
            log.error("스케줄 저장 실패", e);
            result.put("code", "500");
            result.put("message", "스케줄 저장 실패");
        }
        return result;
    }
}
