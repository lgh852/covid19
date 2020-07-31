package com.gh.covid19;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class Covid19Application extends SpringBootServletInitializer {

//	public static void main(String[] args) {
//		SpringApplication.run(Covid19Application.class, args);
//	}

	@Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(Covid19Application.class);
    }
	public static void main(String[] args) throws Exception {
	        SpringApplication.run(Covid19Application.class, args);
	    }
}
