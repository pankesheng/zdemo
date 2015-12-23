package test.code;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import com.thanone.zdemo.entity.example.Example;
import com.zcj.util.coder.database.Database;
import com.zcj.util.coder.database.Table;
import com.zcj.util.coder.database.TableColumn;
import com.zcj.util.coder.database.TableColumnType;
import com.zcj.util.freemarker.FreemarkerUtil;
import com.zcj.util.freemarker.MyFreeMarkerConfigurer;

public class FileAll {

	private static final String SAVEPATH = "D:/";

	private static final String DATABASETYPE = Database.TYPE_MYSQL;// MySQL、SqlServer

	private static Class<?>[] carray = new Class<?>[] { Example.class };

	@Test
	public void test1() {
		allJava(carray);
		allTable(carray);
	}

	private static FreeMarkerConfigurer freemarkerConfig = null;

	@BeforeClass
	public static void init() {
		ApplicationContext context = new ClassPathXmlApplicationContext("conf/spring-mvc.xml");
		if (context != null) {
			freemarkerConfig = (MyFreeMarkerConfigurer) context.getBean("freemarkerConfig");
		}
		System.out.println(context);
	}

	private void allTable(Class<?>[] carray) {
		List<Table> tables = new ArrayList<Table>();
		for (Class<?> c : carray) {
			tables.add(initTable(c, DATABASETYPE));
		}
		Map<String, Object> root = new HashMap<String, Object>();
		root.put("tables", tables);
		root.put("databasename", carray[0].getName().split("\\.")[2]);
		if ("MySQL".equals(DATABASETYPE)) {
			FreemarkerUtil.getInstance(freemarkerConfig).htmlFile(root, "/code/DatabaseMySQL.ftl", SAVEPATH + "init.sql");
		} else if ("SqlServer".equals(DATABASETYPE)) {
			FreemarkerUtil.getInstance(freemarkerConfig).htmlFile(root, "/code/DatabaseSqlServer.ftl", SAVEPATH + "init.sql");
		}
	}

	private static Table initTable(Class<?> c, String databaseType) {
		String tableName = "t_" + StringUtils.lowerCase(c.getSimpleName());
		List<TableColumn> columns = new ArrayList<TableColumn>();
		Field[] fs = c.getDeclaredFields();
		for (Field f : fs) {
			if (valid(f)) {
				String[] typeAndLength = initDefaultTypeAndLengthByField(databaseType, f);
				String tType = typeAndLength[0];
				Integer tLength = typeAndLength[1] == null ? null : Integer.valueOf(typeAndLength[1]);
				Boolean tNullable = true;
				if (f.isAnnotationPresent(TableColumnType.class)) {
					TableColumnType sqlType = f.getAnnotation(TableColumnType.class);
					if (sqlType.length() != 0) {
						tLength = sqlType.length();
					}
					if (!sqlType.nullable()) {
						tNullable = false;
					}
				}
				columns.add(new TableColumn(f.getName(), tType, tLength, tNullable));
			}
		}
		return new Table(tableName, columns);
	}

	private static String[] initDefaultTypeAndLengthByField(String databaseType, Field ff) {
		if (Database.TYPE_MYSQL.equals(databaseType)) {
			if ("class java.lang.Integer".equals(ff.getType().toString())) {
				return new String[] { "int", "11" };
			} else if ("class java.lang.Long".equals(ff.getType().toString())) {
				return new String[] { "bigint", "20" };
			} else if ("class java.lang.String".equals(ff.getType().toString())) {
				return new String[] { "varchar", "100" };
			} else if ("class java.util.Date".equals(ff.getType().toString())) {
				return new String[] { "datetime", null };
			} else if ("class java.lang.Float".equals(ff.getType().toString())) {
				return new String[] { "float", null };
			}
		} else if (Database.TYPE_SQLSERVER.equals(databaseType)) {
			if ("class java.lang.Integer".equals(ff.getType().toString())) {
				return new String[] { "int", null };
			} else if ("class java.lang.Long".equals(ff.getType().toString())) {
				return new String[] { "bigint", null };
			} else if ("class java.lang.String".equals(ff.getType().toString())) {
				return new String[] { "nvarchar", "100" };
			} else if ("class java.util.Date".equals(ff.getType().toString())) {
				return new String[] { "datetime", null };
			}
		}
		return new String[] { null, null };
	}

	private static boolean valid(Field f) {
		return f != null && f.getModifiers() < 8 && !f.getName().startsWith("show_");
	}

	private void allJava(Class<?>[] carray) {
		for (Class<?> c : carray) {
			allJava(c);
		}
	}

	private void allJava(Class<?> className) {
		String[] allName = className.getName().split("\\.");
		if (allName.length != 6) {// com.thanone.pm2.entity.user.User
			return;
		}
		String packages = allName[0] + "." + allName[1] + "." + allName[2];// com.thanone.pm2
		String modules = allName[4];// user
		String classes = allName[5];// User
		Field[] fs = className.getDeclaredFields();
		List<Field> fslist = new ArrayList<Field>();
		for (Field f : fs) {
			if (valid(f)) {
				fslist.add(f);
			}
		}

		Map<String, Object> root = new HashMap<String, Object>();
		root.put("packages", packages);
		root.put("modules", modules);
		root.put("classes", classes);
		root.put("tables", "t_" + StringUtils.lowerCase(classes));
		root.put("fields", fslist);
		FreemarkerUtil.getInstance(freemarkerConfig).htmlFile(root, "/code/XxMapperJava.ftl",
				SAVEPATH + packages + "/mapper/" + modules + "/" + classes + "Mapper.java");
		if ("MySQL".equals(DATABASETYPE)) {
			FreemarkerUtil.getInstance(freemarkerConfig).htmlFile(root, "/code/XxMapperXmlMySQL.ftl",
					SAVEPATH + packages + "/mapper/" + modules + "/" + classes + "Mapper.xml");
		} else if ("SqlServer".equals(DATABASETYPE)) {
			FreemarkerUtil.getInstance(freemarkerConfig).htmlFile(root, "/code/XxMapperXmlSqlServer.ftl",
					SAVEPATH + packages + "/mapper/" + modules + "/" + classes + "Mapper.xml");
		}
		FreemarkerUtil.getInstance(freemarkerConfig).htmlFile(root, "/code/XxService.ftl",
				SAVEPATH + packages + "/service/" + modules + "/" + classes + "Service.java");
		FreemarkerUtil.getInstance(freemarkerConfig).htmlFile(root, "/code/XxServiceImpl.ftl",
				SAVEPATH + packages + "/service/" + modules + "/" + classes + "ServiceImpl.java");
		FreemarkerUtil.getInstance(freemarkerConfig).htmlFile(root, "/code/XxAction.ftl",
				SAVEPATH + packages + "/action/" + modules + "/" + classes + "Action.java");
	}

}
