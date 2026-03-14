package com.cj.freshway.fs.cps.airstar.storemng;

import com.cj.freshway.fs.cps.airstar.storemng.dto.ShopScheduleSearchDto;
import com.cj.freshway.fs.cps.airstar.storemng.entity.ShopScheduleEntity;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * 매장 스케줄 관리 Service
 * 실무 원본: com.cj.freshway.fs.cps.airstar.storemng.StoreMstrMngService (스케줄 부분)
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ShopScheduleService {

    private final ShopScheduleMapper mapper;

    // 상태별 우선순위 (낮을수록 높은 우선순위)
    private static final Map<String, Integer> PRIORITY_MAP = Map.of(
            "PAUSED", 1,
            "PERMANENTLY_CLOSED", 2,
            "HOLIDAY_CLOSED", 3,
            "TEMPORARILY_CLOSED", 4,
            "CLOSED", 5,
            "SOLD_OUT", 6,
            "BREAK_TIME", 7,
            "OPENING_SOON", 8,
            "OPEN", 9
    );

    @Transactional(readOnly = true)
    public List<ShopScheduleEntity> selectScheduleMonthList(ShopScheduleSearchDto dto) {
        log.debug("[Schedule] selectMonthList - storeId={}, month={}", dto.getStoreId(), dto.getSearchMonth());
        return mapper.selectScheduleMonthList(dto);
    }

    @Transactional
    public void saveSchedule(ShopScheduleEntity entity) {
        // 우선순위 자동 설정
        if (entity.getOpenStatus() != null) {
            entity.setSchedulePriority(PRIORITY_MAP.getOrDefault(entity.getOpenStatus(), 9));
        }

        ShopScheduleEntity existing = mapper.selectSchedule(entity);

        if (existing != null) {
            log.debug("[Schedule] update - storeId={}, date={}", entity.getStoreId(), entity.getScheduleDate());
            mapper.updateSchedule(entity);
        } else {
            log.debug("[Schedule] insert - storeId={}, date={}", entity.getStoreId(), entity.getScheduleDate());
            mapper.insertSchedule(entity);
        }
    }
}
