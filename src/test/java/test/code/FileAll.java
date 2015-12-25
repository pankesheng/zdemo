package test.code;

import java.util.HashMap;
import java.util.Map;

import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import com.thanone.zdemo.entity.example.Example;
import com.zcj.util.coder.database.Database;
import com.zcj.util.coder.database.DatabaseBuilder;
import com.zcj.util.coder.java.JavaCode;
import com.zcj.util.coder.java.JavaCodeBuilder;
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
		Database database = DatabaseBuilder.initDatabase(carray, DATABASETYPE);
		Map<String, Object> root = new HashMap<String, Object>();
		root.put("tables", database.getTables());
		root.put("databasename", database.getName());
		if ("MySQL".equals(DATABASETYPE)) {
			FreemarkerUtil.getInstance(freemarkerConfig).htmlFile(root, "/code/DatabaseMySQL.ftl", SAVEPATH + "init.sql");
		} else if ("SqlServer".equals(DATABASETYPE)) {
			FreemarkerUtil.getInstance(freemarkerConfig).htmlFile(root, "/code/DatabaseSqlServer.ftl", SAVEPATH + "init.sql");
		}
	}

	private void allJava(Class<?>[] carray) {
		for (Class<?> c : carray) {
			allJava(c);
		}
	}

	private void allJava(Class<?> className) {

		JavaCode code = JavaCodeBuilder.initJavaCode(className);

		Map<String, Object> root = new HashMap<String, Object>();
		if (code != null) {
			root.put("packages", code.getPackageName());
			root.put("modules", code.getModuleName());
			root.put("classes", code.getClassName());
			root.put("tables", code.getTableName());
			root.put("fields", code.getFieldList());
			root.put("qbuilderList", code.getQbuilderList());
			FreemarkerUtil.getInstance(freemarkerConfig).htmlFile(root, "/code/XxMapperJava.ftl",
					SAVEPATH + code.getPackageName() + "/mapper/" + code.getModuleName() + "/" + code.getClassName() + "Mapper.java");
			if ("MySQL".equals(DATABASETYPE)) {
				FreemarkerUtil.getInstance(freemarkerConfig).htmlFile(root, "/code/XxMapperXmlMySQL.ftl",
						SAVEPATH + code.getPackageName() + "/mapper/" + code.getModuleName() + "/" + code.getClassName() + "Mapper.xml");
			} else if ("SqlServer".equals(DATABASETYPE)) {
				FreemarkerUtil.getInstance(freemarkerConfig).htmlFile(root, "/code/XxMapperXmlSqlServer.ftl",
						SAVEPATH + code.getPackageName() + "/mapper/" + code.getModuleName() + "/" + code.getClassName() + "Mapper.xml");
			}
			FreemarkerUtil.getInstance(freemarkerConfig).htmlFile(root, "/code/XxService.ftl",
					SAVEPATH + code.getPackageName() + "/service/" + code.getModuleName() + "/" + code.getClassName() + "Service.java");
			FreemarkerUtil.getInstance(freemarkerConfig).htmlFile(root, "/code/XxServiceImpl.ftl",
					SAVEPATH + code.getPackageName() + "/service/" + code.getModuleName() + "/" + code.getClassName() + "ServiceImpl.java");
			FreemarkerUtil.getInstance(freemarkerConfig).htmlFile(root, "/code/XxAction.ftl",
					SAVEPATH + code.getPackageName() + "/action/" + code.getModuleName() + "/" + code.getClassName() + "Action.java");
		} else {
			System.out.println("生成 " + className.getName() + " 失败");
		}

	}

}
