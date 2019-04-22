package com.hunger.model;

import java.io.Serializable;
import java.util.Date;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.enums.IdType;

/**
 * 
 * 
 * @author wcyong
 * 
 * @date 2019-04-21
 */
public class SysRole implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@TableId(value = "RID",type = IdType.INPUT)
	private Long rid;

    private String rolename;

    private String description;

    private String status;

    private String px;

    private Date createdtime;

    private Date modifytime;

    public Long getRid() {
        return rid;
    }

    public void setRid(Long rid) {
        this.rid = rid;
    }

    public String getRolename() {
        return rolename;
    }

    public void setRolename(String rolename) {
        this.rolename = rolename == null ? null : rolename.trim();
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public String getPx() {
        return px;
    }

    public void setPx(String px) {
        this.px = px == null ? null : px.trim();
    }

    public Date getCreatedtime() {
        return createdtime;
    }

    public void setCreatedtime(Date createdtime) {
        this.createdtime = createdtime;
    }

    public Date getModifytime() {
        return modifytime;
    }

    public void setModifytime(Date modifytime) {
        this.modifytime = modifytime;
    }
}