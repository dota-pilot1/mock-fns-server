package com.cj.freshway.mock;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = {
	"com.cj.freshway.mock",    // config (CORS 등)
	"com.cj.freshway.fs"       // 실무 패키지 구조 (cps/common, cps/airstar)
})
@MapperScan({
	"com.cj.freshway.fs.cps.airstar",
	"com.cj.freshway.fs.cps.common.code",
	"com.cj.freshway.fs.cps.common.userInfo"
})
public class MockScheduleServerApplication {

	public static void main(String[] args) {
		SpringApplication.run(MockScheduleServerApplication.class, args);
	}

}
