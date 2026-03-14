package com.cj.freshway.fs.cps.common.code;

import com.cj.freshway.fs.cps.common.base.FscpsBaseController;
import com.cj.freshway.fs.cps.common.code.dto.CmCodeSearchDto;
import com.cj.freshway.fs.cps.common.code.entity.CmCode;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 공통코드 컨트롤러 — 실무 CmCodeController와 동일 구조 (DB 연동)
 * 실무 원본: com.cj.freshway.fs.cps.common.code.CmCodeController
 */
@Tag(name = "공통코드", description = "공통코드 조회 (DB 연동)")
@Slf4j
@RestController
@RequestMapping("api/common/code")
@RequiredArgsConstructor
public class MockCommonCodeController extends FscpsBaseController {

    private final CmCodeService codeService;

    @Operation(summary = "공통코드 조회", description = "분류코드(commClCd)로 공통코드 목록 조회")
    @PostMapping("v1.0")
    public List<CmCode> getCodeList(@RequestBody CmCodeSearchDto search) {
        log.info("[CommonCode] getCodeList - commClCd={}", search.getCommClCd());
        return codeService.selectCodeList(search);
    }

    @Operation(summary = "전체 공통코드 목록", description = "로그인 시 전체 공통코드 일괄 조회 (sessionStorage 저장용)")
    @PostMapping("v1.0/allClCmCodeList")
    public List<CmCode> allClCmCodeList(@RequestBody(required = false) CmCodeSearchDto search) {
        log.info("[CommonCode] allClCmCodeList");
        return codeService.selectAllClCmCodeList();
    }
}
