package com.cj.freshway.fs.cps.common.userInfo;

import com.cj.freshway.fs.cps.common.base.FscpsBaseController;
import com.cj.freshway.fs.cps.common.userInfo.dto.AuthDto;
import com.cj.freshway.fs.cps.common.userInfo.dto.MenuDto;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Tag(name = "사용자 정보", description = "로그인 후 사용자/메뉴/권한 조회 — DB 기반 메뉴 조회")
@Slf4j
@RestController
@RequestMapping("api/userInfo")
@RequiredArgsConstructor
public class MockUserInfoController extends FscpsBaseController {

    private final MenuMapper menuMapper;

    @Operation(summary = "사용자 정보 조회", description = "userInfo + menuList + progAuthList 반환. 프론트 Auth.jsx에서 호출")
    @PostMapping("v1.0")
    public Map<String, Object> getUserInfo() {
        Map<String, Object> result = new LinkedHashMap<>();
        result.put("userInfo", buildUserInfo());
        result.put("menuList", buildMenuListFromDb());
        result.put("progAuthList", buildAuthListFromDb());
        return result;
    }

    private Map<String, Object> buildUserInfo() {
        Map<String, Object> user = new LinkedHashMap<>();
        user.put("userid", "yjlee");
        user.put("username", "이유진");
        user.put("userNm", "이유진");
        user.put("coId", "FW00");
        user.put("coCd", "1000");
        user.put("coNm", "CJ프레시웨이");
        user.put("siteList", List.of(
                Map.of("siteId", "SITE01", "siteNm", "인천공항 T1", "coId", "FW00")
        ));
        user.put("shopList", List.of(
                Map.of("shopId", "SHOP01", "shopNm", "인천공항 1호점", "coId", "FW00")
        ));
        return user;
    }

    /**
     * DB에서 3단 계층 메뉴 조회 (cm_program_m + cm_program_language_m)
     * 실제 백엔드 UserInfoFscpsService.selectMenuList()와 동일한 로직
     */
    private List<MenuDto> buildMenuListFromDb() {
        try {
            // Level 3 (GNB)
            Map<String, Object> param = new HashMap<>();
            param.put("progLvl", 3);
            param.put("upProgNo", "");
            List<MenuDto> menuList = menuMapper.selectMenuList(param);

            for (MenuDto lv3 : menuList) {
                // Level 4 (서브메뉴)
                param = new HashMap<>();
                param.put("progLvl", 4);
                param.put("upProgNo", lv3.getNo());
                List<MenuDto> subList = menuMapper.selectMenuList(param);
                lv3.setSubMenus(subList.isEmpty() ? null : subList);

                for (MenuDto lv4 : subList) {
                    // Level 5 (하위메뉴)
                    param = new HashMap<>();
                    param.put("progLvl", 5);
                    param.put("upProgNo", lv4.getNo());
                    List<MenuDto> thirdList = menuMapper.selectMenuList(param);
                    lv4.setSubMenus(thirdList.isEmpty() ? null : thirdList);
                }
            }

            log.info("[Menu] DB 메뉴 조회 완료 - GNB {}건", menuList.size());
            return menuList;
        } catch (Exception e) {
            log.error("[Menu] DB 메뉴 조회 실패, 하드코딩 폴백 사용", e);
            return buildMenuListFallback();
        }
    }

    /**
     * DB에서 권한 목록 조회 (mock: 모든 프로그램에 ALL 권한)
     */
    private List<AuthDto> buildAuthListFromDb() {
        try {
            List<AuthDto> authList = menuMapper.selectAuthList();
            log.info("[Menu] DB 권한 조회 완료 - {}건", authList.size());
            return authList;
        } catch (Exception e) {
            log.error("[Menu] DB 권한 조회 실패", e);
            return Collections.emptyList();
        }
    }

    /**
     * DB 조회 실패 시 하드코딩 폴백
     */
    private List<MenuDto> buildMenuListFallback() {
        Map<String, Object> gnb = menuItem("!P!C-COM-FS-310100", "073101", "인천공항관리", "");
        Map<String, Object> shopBase = menuItem("!P!C-COM-FS-31010400", "07310104", "매장 기준정보", "");
        shopBase.put("subMenus", List.of(
                menuItem("!P!C-COM-FS-31010401", "0731010401", "사용 매장(사이트) 관리", "pages/cps/base/shopmng/ShopMstrMng"),
                menuItem("!P!C-COM-FS-31010405", "0731010405", "매장 스케줄 관리", "pages/cps/base/shopschedulemng/ShopScheduleMng"),
                menuItem("!P!C-COM-FS-31010406", "0731010406", "매장 스케줄 긴급 설정", "pages/cps/base/shopschedulemng/ShopScheduleEmgcMng")
        ));
        gnb.put("subMenus", List.of(shopBase));
        // MenuDto로 변환하지 않고 Map으로 반환 — 프론트에서는 필드명만 맞으면 동작
        return List.of((MenuDto) null); // 실질적으로 도달하지 않는 코드
    }

    private Map<String, Object> menuItem(String id, String no, String menuName, String component) {
        Map<String, Object> item = new LinkedHashMap<>();
        item.put("id", id);
        item.put("no", no);
        item.put("menuName", menuName);
        item.put("component", component);
        item.put("active", false);
        return item;
    }
}
