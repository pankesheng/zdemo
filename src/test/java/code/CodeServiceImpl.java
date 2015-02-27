package code;

import com.zcj.util.UtilString;

public class CodeServiceImpl {

	public static void main(String[] args) {
		printCode("User");
	}
	
	public static void printCode(String beanName) {
		
		String sbean = UtilString.firstLower(beanName);
		
		System.out.println("@Component(\""+sbean+"Service\")");
		System.out.println("public class "+beanName+"ServiceImpl extends BasicServiceImpl<"+beanName+", Long, "+beanName+"Mapper> implements "+beanName+"Service {");
		System.out.println("");
		System.out.println("	@Autowired");
		System.out.println("	private "+beanName+"Mapper "+sbean+"Mapper;");
		System.out.println("	");
		System.out.println("	@Override");
		System.out.println("	protected "+beanName+"Mapper getMapper() {");
		System.out.println("		return "+sbean+"Mapper;");
		System.out.println("	}");
		System.out.println("");
		System.out.println("}");
		
	}
	
}
