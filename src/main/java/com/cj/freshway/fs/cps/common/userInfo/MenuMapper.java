package com.cj.freshway.fs.cps.common.userInfo;

import com.cj.freshway.fs.cps.common.userInfo.dto.AuthDto;
import com.cj.freshway.fs.cps.common.userInfo.dto.MenuDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface MenuMapper {

    /** 메뉴 목록 조회 (progLvl, upProgNo 기준) */
    List<MenuDto> selectMenuList(Map<String, Object> param);

    /** 권한 목록 조회 (mock: 전체 프로그램 ALL 권한) */
    List<AuthDto> selectAuthList();
}
