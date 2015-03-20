package test.service;

import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.thanone.zdemo.service.user.UserService;

public class MyTest {

	private static UserService userService;

	@BeforeClass
	public static void init() {
		ApplicationContext context = new ClassPathXmlApplicationContext("conf/spring.xml");
		if (context != null) {
			userService = (UserService) context.getBean("userService");
		}
		System.out.println(context);
	}

	@Test
	public void test1() {
		int c = userService.getTotalRows(null);
		System.out.println(c);
	}

}
