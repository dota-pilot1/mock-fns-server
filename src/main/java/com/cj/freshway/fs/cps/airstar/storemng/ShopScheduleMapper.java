package com.cj.freshway.fs.cps.airstar.storemng;

import com.cj.freshway.fs.cps.airstar.storemng.dto.ShopScheduleSearchDto;
import com.cj.freshway.fs.cps.airstar.storemng.entity.ShopScheduleEntity;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ShopScheduleMapper {

    /** 월 스케줄 목록 조회 */
    List<ShopScheduleEntity> selectScheduleMonthList(ShopScheduleSearchDto dto);

    /** 스케줄 단건 조회 (존재 여부 확인용) */
    ShopScheduleEntity selectSchedule(ShopScheduleEntity entity);

    /** 스케줄 등록 */
    int insertSchedule(ShopScheduleEntity entity);

    /** 스케줄 수정 */
    int updateSchedule(ShopScheduleEntity entity);
}
