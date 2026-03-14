package com.cj.freshway.mock.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SwaggerConfig {

    @Bean
    public OpenAPI openAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("FSCPS Mock Server API")
                        .description("인천공항 식음 서비스 — UI 테스트용 Mock API")
                        .version("1.0.0"));
    }
}
