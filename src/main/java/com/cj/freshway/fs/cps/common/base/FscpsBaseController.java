package com.cj.freshway.fs.cps.common.base;

import org.springframework.web.bind.annotation.RestController;

/**
 * 통합결제(FSCPS) 기본 컨트롤러 — mock 서버용 경량 버전.
 * context-path(/fscps)로 경로 접두사 처리하므로 여기선 별도 @RequestMapping 불필요.
 *
 * 실무 원본: com.cj.freshway.fs.cps.common.base.FscpsBaseController
 * - 파일 다운로드, DRM 등은 mock에서 불필요하므로 제외
 */
@RestController
public class FscpsBaseController {
}
