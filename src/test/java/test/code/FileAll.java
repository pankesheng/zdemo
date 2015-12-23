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
import com.zcj.util.coder.database.TableBuilder;
import com.zcj.util.coder.query.QueryBuilder;
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
			tables.add(TableBuilder.initTable(c, DATABASETYPE));
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
		root.put("qbuilderList", QueryBuilder.initQueryColumnList(className));
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
