package test.code;

import java.lang.reflect.Field;

public class CodeMySql {

	public static void main(String[] args) {
		printCode("t_user", User.class);
	}
	
	public static void printCode(String tableName, Class<?> className) {
		
		Field[] f = className.getDeclaredFields();
		
		System.out.println("CREATE TABLE `"+tableName+"` (");
		System.out.println("  `id` bigint(20) NOT NULL,");
		for (Field ff : f) {
			if ("class java.lang.Integer".equals(ff.getType().toString())) {
				System.out.println("  `"+ff.getName()+"` int(11) DEFAULT NULL,");
			} else if ("class java.lang.Long".equals(ff.getType().toString())) {
				System.out.println("  `"+ff.getName()+"` bigint(20) DEFAULT NULL,");
			} else if ("class java.lang.String".equals(ff.getType().toString())) {
				System.out.println("  `"+ff.getName()+"` varchar(100) DEFAULT NULL,");
			} else if ("class java.util.Date".equals(ff.getType().toString())) {
				System.out.println("  `"+ff.getName()+"` datetime DEFAULT NULL,");
			}
		}
		System.out.println("  `ctime` datetime DEFAULT NULL,");
		System.out.println("  `utime` datetime DEFAULT NULL,");
		System.out.println("  PRIMARY KEY (`id`)");
		System.out.println(") ENGINE=InnoDB DEFAULT CHARSET=utf8;");
	}
	
}
