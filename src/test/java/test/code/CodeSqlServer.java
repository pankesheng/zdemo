package test.code;

import java.lang.reflect.Field;

public class CodeSqlServer {

	public static void main(String[] args) {
//		printCode("oheduz", "t_catalog", Catalog.class);
	}
	
	public static void printCode(String databaseName, String tableName, Class<?> className) {
		
		Field[] f = className.getDeclaredFields();
		
		System.out.println("CREATE TABLE ["+databaseName+"].[dbo].["+tableName+"](");
		System.out.println("  [id] [bigint] NOT NULL PRIMARY KEY,");
		for (Field ff : f) {
			if ("class java.lang.Integer".equals(ff.getType().toString())) {
				System.out.println("  ["+ff.getName()+"] [int] NULL,");
			} else if ("class java.lang.Long".equals(ff.getType().toString())) {
				System.out.println("  ["+ff.getName()+"] [bigint] NULL,");
			} else if ("class java.lang.String".equals(ff.getType().toString())) {
				System.out.println("  ["+ff.getName()+"] [nvarchar](50) NULL,");
			} else if ("class java.util.Date".equals(ff.getType().toString())) {
				System.out.println("  ["+ff.getName()+"] [datetime] NULL,");
			}
		}
		System.out.println("  [ctime] [datetime] NULL,");
		System.out.println("  [utime] [datetime] NULL");
		System.out.println(")");
	}
	
}
