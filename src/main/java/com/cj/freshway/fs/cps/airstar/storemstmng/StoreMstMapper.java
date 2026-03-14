package com.cj.freshway.fs.cps.airstar.storemstmng;

import com.cj.freshway.fs.cps.airstar.storemstmng.dto.StoreMstSearchDto;
import com.cj.freshway.fs.cps.airstar.storemstmng.entity.StoreMstEntity;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface StoreMstMapper {
    List<StoreMstEntity> selectStoreList(StoreMstSearchDto dto);
}
