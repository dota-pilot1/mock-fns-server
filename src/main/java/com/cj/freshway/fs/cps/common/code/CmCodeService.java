package com.cj.freshway.fs.cps.common.code;

import com.cj.freshway.fs.cps.common.code.dto.CmCodeSearchDto;
import com.cj.freshway.fs.cps.common.code.entity.CmCode;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class CmCodeService {

    private final CmCodeMapper codeMapper;

    public List<CmCode> selectCodeList(CmCodeSearchDto search) {
        log.debug("[CommonCode] selectCodeList - commClCd={}", search.getCommClCd());
        return codeMapper.selectCodeList(search);
    }

    public List<CmCode> selectAllClCmCodeList() {
        log.debug("[CommonCode] selectAllClCmCodeList");
        return codeMapper.selectAllClCmCodeList();
    }
}
