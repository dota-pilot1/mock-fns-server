package com.cj.freshway.fs.cps.common.userInfo;

import com.cj.freshway.fs.cps.common.base.FscpsBaseController;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Tag(name = "사용자 정보", description = "로그인 후 사용자/메뉴/권한 조회 — 이유진(yjlee) 고정 응답")
@RestController
@RequestMapping("api/userInfo")
public class MockUserInfoController extends FscpsBaseController {

    @Operation(summary = "사용자 정보 조회", description = "userInfo + menuList + progAuthList 반환. 프론트 Auth.jsx에서 호출")
    @PostMapping("v1.0")
    public Map<String, Object> getUserInfo() {
        Map<String, Object> result = new LinkedHashMap<>();
        result.put("userInfo", buildUserInfo());
        result.put("menuList", buildMenuList());
        result.put("progAuthList", buildAuthList());
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

    private List<Map<String, Object>> buildMenuList() {
        Map<String, Object> gnb = menuItem("!P!C-COM-FS-310100", "073101", "인천공항관리", "");

        Map<String, Object> shopBase = menuItem("!P!C-COM-FS-31010400", "07310104", "매장 기준정보", "");
        shopBase.put("subMenus", List.of(
                menuItem("!P!C-COM-FS-31010401", "0731010401", "사용 매장(사이트) 관리", "pages/cps/base/shopmng/ShopMstrMng"),
                menuItem("!P!C-COM-FS-31010402", "0731010402", "사용 매장(코너) 관리", "pages/cps/base/shopmng/ShopCrnrMng"),
                menuItem("!P!C-COM-FS-31010403", "0731010403", "매장 기준정보 설정·밀반매장", "pages/cps/base/shopmng/ShopBaseMealMng"),
                menuItem("!P!C-COM-FS-31010404", "0731010404", "매장 기준정보 설정·코너", "pages/cps/base/shopmng/ShopBaseCrnrMng"),
                menuItem("!P!C-COM-FS-31010405", "0731010405", "매장 스케줄 관리", "pages/cps/base/shopschedulemng/ShopScheduleMng"),
                menuItem("!P!C-COM-FS-31010406", "0731010406", "매장 스케줄 긴급 설정", "pages/cps/base/shopschedulemng/ShopScheduleEmgcMng"),
                menuItem("!P!C-COM-FS-31010407", "0731010407", "매장별 전시 카테고리 관리", "pages/cps/base/shopmng/ShopDspCtgMng"),
                menuItem("!P!C-COM-FS-31010408", "0731010408", "전시 카테고리별 매장 관리", "pages/cps/base/shopmng/DspCtgShopMng")
        ));

        Map<String, Object> brand = menuItem("!P!C-COM-FS-31010100", "07310101", "브랜드 관리", "");
        brand.put("subMenus", List.of(
                menuItem("!P!C-COM-FS-31010101", "0731010101", "입점 브랜드 관리", "pages/cps/base/brandmng/BrandMng")
        ));

        Map<String, Object> dspCtg = menuItem("!P!C-COM-FS-31010200", "07310102", "전시 카테고리 관리", "");
        dspCtg.put("subMenus", List.of(
                menuItem("!P!C-COM-FS-31010201", "0731010201", "전시 카테고리 관리", "pages/cps/base/ctgmng/DspCtgMng")
        ));

        gnb.put("subMenus", List.of(brand, dspCtg, shopBase));
        return List.of(gnb);
    }

    private List<Map<String, String>> buildAuthList() {
        return List.of(
                Map.of("progId", "!P!C-COM-FS-310100", "authCl", "ALL"),
                Map.of("progId", "!P!C-COM-FS-31010401", "authCl", "ALL"),
                Map.of("progId", "!P!C-COM-FS-31010402", "authCl", "ALL"),
                Map.of("progId", "!P!C-COM-FS-31010405", "authCl", "ALL"),
                Map.of("progId", "!P!C-COM-FS-31010406", "authCl", "ALL")
        );
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
