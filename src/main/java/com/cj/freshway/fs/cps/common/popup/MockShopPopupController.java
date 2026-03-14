package com.cj.freshway.fs.cps.common.popup;

import com.cj.freshway.fs.cps.common.base.FscpsBaseController;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Tag(name = "공통 팝업/콤보", description = "점포·사이트 SelectBox용 목록 반환")
@RestController
@RequestMapping("api/common")
public class MockShopPopupController extends FscpsBaseController {

    @Operation(summary = "점포 목록 조회", description = "대시보드 점포 SelectBox. shopId/shopNm 반환")
    @PostMapping("shopRtrvPop/v1.0/list")
    public Map<String, Object> shopList(@RequestBody(required = false) Map<String, Object> params) {
        Map<String, Object> result = new LinkedHashMap<>();
        List<Map<String, Object>> data = new ArrayList<>();

        Map<String, Object> shop = new LinkedHashMap<>();
        shop.put("shopId", "SHOP01");
        shop.put("shopNm", "인천공항 1호점");
        shop.put("coId", "FW00");
        data.add(shop);

        result.put("lastRow", data.size());
        result.put("data", data);
        return result;
    }

    @Operation(summary = "사이트 목록 조회", description = "점포 하위 사이트 SelectBox. steId/steNm 반환")
    @PostMapping("steRtrvPop/v1.0/list")
    public Map<String, Object> siteList(@RequestBody(required = false) Map<String, Object> params) {
        Map<String, Object> result = new LinkedHashMap<>();
        List<Map<String, Object>> data = new ArrayList<>();

        Map<String, Object> site = new LinkedHashMap<>();
        site.put("steId", "SITE01");
        site.put("steNm", "인천공항 T1");
        site.put("coId", "FW00");
        data.add(site);

        result.put("lastRow", data.size());
        result.put("data", data);
        return result;
    }
}
