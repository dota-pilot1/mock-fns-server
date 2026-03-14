package com.cj.freshway.fs.cps.airstar.storemstmng;

import com.cj.freshway.fs.cps.airstar.storemstmng.dto.StoreMstSearchDto;
import com.cj.freshway.fs.cps.airstar.storemstmng.entity.StoreMstEntity;
import com.cj.freshway.fs.cps.common.base.FscpsBaseController;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Tag(name = "AIRSTAR 매장 마스터", description = "매장 목록 조회 (팝업용)")
@Slf4j
@RestController
@RequestMapping("api/airstar/storemstmng")
@RequiredArgsConstructor
public class StoreMstController extends FscpsBaseController {

    private final StoreMstMapper mapper;

    @Operation(summary = "매장 목록 조회", description = "AIRSTAR 매장 검색 팝업용. coId + storeId/storeNm 검색")
    @PostMapping("v1.0/selectstorelst")
    public Map<String, Object> selectStoreList(@RequestBody StoreMstSearchDto dto) {
        log.info("[StoreMst] selectStoreList - coId={}, storeId={}, storeNm={}",
                dto.getCoId(), dto.getSearchStoreId(), dto.getSearchStoreNm());

        Map<String, Object> result = new LinkedHashMap<>();
        try {
            if (dto.getCoId() == null || dto.getCoId().isEmpty()) {
                dto.setCoId("FW00");
            }
            List<StoreMstEntity> list = mapper.selectStoreList(dto);
            result.put("lastRow", list.size());
            result.put("data", list);
        } catch (Exception e) {
            log.error("매장 목록 조회 실패", e);
            result.put("lastRow", 0);
            result.put("data", Collections.emptyList());
        }
        return result;
    }
}
