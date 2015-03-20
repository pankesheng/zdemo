package test.code;

import java.lang.reflect.Field;

public class CodeMapperMySql {

	public static void main(String[] args) {
		printCode("t_user", "User", User.class);
	}
	
	public static void printCode(String tableName, String beanName, Class<?> className) {
		
		Field[] f = className.getDeclaredFields();

		System.out.println("	<!-- 大于等于(&gt;=);小于等于(&lt;=);IS NOT NULL; -->");
		System.out.println("	<sql id=\"qbuilder\">");
		System.out.println("		<where>");
		System.out.println("			<if test=\"qbuilder.id != null\">"+tableName+".id = #{qbuilder.id}</if>");
		System.out.println("			<if test=\"qbuilder.xxx != null\">AND "+tableName+".xxx = #{qbuilder.xxx}</if>");
		System.out.println("		</where>");
		System.out.println("	</sql>");
		System.out.println("");
		System.out.println("	<select id=\"find\" resultType=\""+beanName+"\">");
		System.out.println("		SELECT * FROM "+tableName+"");
		System.out.println("		<if test=\"qbuilder != null\">");
		System.out.println("			<include refid=\"qbuilder\"/>");
		System.out.println("		</if>");
		System.out.println("		<choose>");
		System.out.println("			<when test=\"orderby != null\">");
		System.out.println("				ORDER BY "+tableName+".${orderby}");
		System.out.println("			</when>");
		System.out.println("			<otherwise>");
		System.out.println("				ORDER BY "+tableName+".id");
		System.out.println("			</otherwise>");
		System.out.println("		</choose>");
		System.out.println("		<choose>");
		System.out.println("			<when test=\"start != null and size != null\">");
		System.out.println("				LIMIT #{start},#{size}");
		System.out.println("			</when>");
		System.out.println("			<when test=\"start == null and size != null\">");
		System.out.println("				LIMIT #{size}");
		System.out.println("			</when>");
		System.out.println("		</choose>");
		System.out.println("	</select>");
		System.out.println("");
		System.out.println("	<select id=\"getTotalRows\" resultType=\"int\">");
		System.out.println("		SELECT COUNT(*) FROM "+tableName+"");
		System.out.println("		<if test=\"qbuilder != null\">");
		System.out.println("			<include refid=\"qbuilder\"/>");
		System.out.println("		</if>");
		System.out.println("	</select>");
		System.out.println("");
		System.out.println("	<select id=\"findById\" resultType=\""+beanName+"\">");
		System.out.println("		SELECT * FROM "+tableName+" WHERE id = #{id}");
		System.out.println("	</select>");
		System.out.println("");
		System.out.println("	<insert id=\"insert\">");
		System.out.println("		INSERT INTO "+tableName);
		System.out.print("			(id,");
			for (Field ff : f) {
				if (!"serialVersionUID".equals(ff.getName())) {
					System.out.print(ff.getName()+",");
				}
			}
		System.out.println("ctime,utime)");
		System.out.println("		VALUES");
		System.out.print("			(#{object.id},");
			for (Field ff : f) {
				if (!"serialVersionUID".equals(ff.getName())) {					
					System.out.print("#{object."+ff.getName()+"},");
				}
			}
		System.out.println("now(),now())");
		System.out.println("	</insert>");
		System.out.println("");
		System.out.println("	<update id=\"update\">");
		System.out.println("		UPDATE "+tableName);
		System.out.println("		SET");
			for (Field ff : f) {
				if (!"serialVersionUID".equals(ff.getName())) {					
					System.out.println("			"+ff.getName()+" = #{object."+ff.getName()+"},");
				}
			}
		System.out.println("			utime = now()");
		System.out.println("		WHERE");
		System.out.println("			id = #{object.id}");
		System.out.println("	</update>");
		System.out.println("");
		System.out.println("	<delete id=\"delete\">");
		System.out.println("		DELETE FROM "+tableName+" WHERE id = #{id}");
		System.out.println("	</delete>");
		System.out.println("");
		System.out.println("	<delete id=\"deleteByIds\">");
		System.out.println("		DELETE FROM "+tableName+" WHERE id in ");
		System.out.println("		<foreach item=\"id\" index=\"index\" collection=\"ids\" open=\"(\" separator=\",\" close=\")\">");
		System.out.println("			#{id}");
		System.out.println("		</foreach>");
		System.out.println("	</delete>");
		System.out.println("");
		System.out.println("	<delete id=\"cleanTable\">");
		System.out.println("		DELETE FROM "+tableName);
		System.out.println("	</delete>");
		System.out.println("");
	}
	
}
