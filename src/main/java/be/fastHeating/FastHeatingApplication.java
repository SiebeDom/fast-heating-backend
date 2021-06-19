package be.fastHeating;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@SpringBootApplication
public class FastHeatingApplication {

	public static void main(String[] args) {
		SpringApplication.run(FastHeatingApplication.class, args);
	}

	@Bean
	public WebMvcConfigurer corsConfigurer() {
		return new WebMvcConfigurer() {
			@Override
			public void addCorsMappings(CorsRegistry registry) {
				registry
						.addMapping("/**")
						.allowedOrigins("http://localhost:4200")
						.allowCredentials(true)
						.allowedMethods(
								RequestMethod.GET.name(),
								RequestMethod.POST.name(),
								RequestMethod.PUT.name(),
								RequestMethod.DELETE.name());
			}
		};
	}

}
