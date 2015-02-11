package com.thanone.zdemo.common;

import java.util.List;

import com.zcj.web.dto.Page;
import com.zcj.web.dto.ServiceResult;

/**
 * BUI列表分页查询的返回值工具类
 * 
 * @author zouchongjin@sina.com
 * @data 2014年8月8日
 */
public class BuiPageResult {
	
	private List<?> rows;
	private Integer results;
	private Boolean hasError;
	private String error;
	
	public BuiPageResult() {
		super();
	}

	public BuiPageResult(List<?> rows, Integer results, Boolean hasError, String error) {
		super();
		this.rows = rows;
		this.results = results;
		this.hasError = hasError;
		this.error = error;
	}

	public static String converByServiceResult(ServiceResult sr) {
		BuiPageResult obj = new BuiPageResult();
		if (sr.success()) {
			Page p = (Page) sr.getD();
			obj = new BuiPageResult(p.getRows(), p.getTotal(), Boolean.FALSE, null);
		} else {
			obj = new BuiPageResult(null, null, Boolean.TRUE, String.valueOf(sr.getD()));
		}
		return ServiceResult.GSON_DT.toJson(obj);
	}

	public List<?> getRows() {
		return rows;
	}

	public void setRows(List<?> rows) {
		this.rows = rows;
	}

	public Integer getResults() {
		return results;
	}

	public void setResults(Integer results) {
		this.results = results;
	}

	public Boolean getHasError() {
		return hasError;
	}

	public void setHasError(Boolean hasError) {
		this.hasError = hasError;
	}

	public String getError() {
		return error;
	}

	public void setError(String error) {
		this.error = error;
	}
	
}
