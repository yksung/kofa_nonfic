package kr.co.wisenut.search.model;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;

@Configuration
@ComponentScan(basePackages = "kr.co.wisenut")
@PropertySource("classpath:search.properties")
public class SearchProperties {
	
	@Bean
	public static PropertySourcesPlaceholderConfigurer propertyConfigurer(){
		return new PropertySourcesPlaceholderConfigurer();
	}
}
