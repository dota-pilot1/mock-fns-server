package com.cj.freshway.fs.cps.common.sso;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Tag(name = "인증/로그인", description = "SSO 로그인 대체 — 고정 토큰 발급 (이유진 사용자)")
@RestController
public class MockSsoLoginController {

    private static final String MOCK_ACCESS_TOKEN = "mock-access-token-for-ui-test";
    private static final String MOCK_REFRESH_TOKEN = "mock-refresh-token-for-ui-test";

    @Operation(summary = "로그인", description = "accessToken + refreshToken 발급. 실무: SSO 서버 연동")
    @GetMapping("user/login")
    public Map<String, Object> login() {
        Map<String, Object> result = new LinkedHashMap<>();
        result.put("accessToken", MOCK_ACCESS_TOKEN);
        result.put("refreshToken", MOCK_REFRESH_TOKEN);
        return result;
    }

    @Operation(summary = "SSO 로그인", description = "로그인과 동일 응답 (SSO 경로 대체)")
    @GetMapping("sso/login")
    public Map<String, Object> ssoLogin() {
        return login();
    }

    @Operation(summary = "토큰 갱신", description = "30초마다 프론트에서 호출. 새 accessToken 반환")
    @GetMapping("user/refreshToken")
    public Map<String, Object> refreshToken() {
        Map<String, Object> result = new LinkedHashMap<>();
        result.put("accessToken", MOCK_ACCESS_TOKEN);
        return result;
    }
}
