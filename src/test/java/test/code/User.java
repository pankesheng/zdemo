package test.code;

import com.zcj.web.mybatis.entity.BasicEntity;

/**
 * 用户
 * 
 * @author ZCJ
 * @data 2013-4-2
 */
public class User extends BasicEntity {

	private static final long serialVersionUID = -576202652932342342L;

	private Integer type;// 角色（1：学校账号；2：中心校账号；3：教育局账号）
	private Long school;// 所属学校或所属中心校（type=1或type=2）
	
	private String realname;// 真实姓名
	
	public void init() {
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Long getSchool() {
		return school;
	}

	public void setSchool(Long school) {
		this.school = school;
	}

	public String getRealname() {
		return realname;
	}

	public void setRealname(String realname) {
		this.realname = realname;
	}
	
}
