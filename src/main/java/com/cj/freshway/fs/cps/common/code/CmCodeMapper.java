package com.cj.freshway.fs.cps.common.code;

import com.cj.freshway.fs.cps.common.code.dto.CmCodeSearchDto;
import com.cj.freshway.fs.cps.common.code.entity.CmCode;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CmCodeMapper {

    List<CmCode> selectCodeList(CmCodeSearchDto search);

    List<CmCode> selectAllClCmCodeList();
}
