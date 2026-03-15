package com.cj.freshway.fs.cps.common.userInfo.dto;

import lombok.Data;
import java.util.List;

@Data
public class MenuDto {
    private String id;
    private String menuName;
    private int depth;
    private boolean active;
    private String no;
    private String componentName;
    private String component;
    private List<MenuDto> subMenus;
}
