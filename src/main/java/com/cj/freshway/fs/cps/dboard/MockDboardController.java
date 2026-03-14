package com.cj.freshway.fs.cps.dboard;

import com.cj.freshway.fs.cps.common.base.FscpsBaseController;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Tag(name = "대시보드", description = "홈 대시보드 매출·메뉴·공지 조회 — 빈 데이터 반환")
@RestController
@RequestMapping("api/cps/dboard/v1.0")
public class MockDboardController extends FscpsBaseController {

    @Operation(summary = "매출현황 조회")
    @PostMapping("selectSalesStatus")
    public Map<String, Object> selectSalesStatus(@RequestBody(required = false) Map<String, Object> params) {
        Map<String, Object> data = new LinkedHashMap<>();
        data.put("salesStatus", Map.of("salesAmt", 0, "salesCnt", 0, "cancelCnt", 0, "dcCnt", 0));

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("data", data);
        return result;
    }

    @Operation(summary = "시간대별 매출(평균) 조회")
    @PostMapping("selectHourlySales")
    public Map<String, Object> selectHourlySales(@RequestBody(required = false) Map<String, Object> params) {
        Map<String, Object> data = new LinkedHashMap<>();
        data.put("list", Collections.emptyList());

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("data", data);
        return result;
    }

    @Operation(summary = "오늘메뉴판매량순위TOP10 조회")
    @PostMapping("selectMenuRank")
    public Map<String, Object> selectMenuRank(@RequestBody(required = false) Map<String, Object> params) {
        Map<String, Object> data = new LinkedHashMap<>();
        data.put("list", Collections.emptyList());

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("data", data);
        return result;
    }

    @Operation(summary = "행사매출현황 조회")
    @PostMapping("selectEvtSalesStatus")
    public Map<String, Object> selectEvtSalesStatus(@RequestBody(required = false) Map<String, Object> params) {
        Map<String, Object> data = new LinkedHashMap<>();
        data.put("evtSalesStatus", Map.of("dcAmt", 0, "dcCnt", 0));

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("data", data);
        return result;
    }

    @Operation(summary = "공지사항 목록 조회")
    @PostMapping("selectNoticeList")
    public Map<String, Object> selectNoticeList(@RequestBody(required = false) Map<String, Object> params) {
        Map<String, Object> data = new LinkedHashMap<>();
        data.put("list", Collections.emptyList());

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("data", data);
        return result;
    }

    @Operation(summary = "코너 목록 조회")
    @PostMapping("selectCrnrList")
    public Map<String, Object> selectCrnrList(@RequestBody(required = false) Map<String, Object> params) {
        Map<String, Object> data = new LinkedHashMap<>();
        data.put("crnrList", Collections.emptyList());

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("data", data);
        return result;
    }
}
