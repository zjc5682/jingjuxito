package com.jingju.entity;

import java.util.Date;

public class AdminApply {
    private Integer id;
    private Integer userId;
    private Integer status; // 0待审核, 1通过, 2拒绝
    private Date applyTime;
    private Date approveTime;
    private Integer approvedAdminId;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }

    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }

    public Date getApplyTime() { return applyTime; }
    public void setApplyTime(Date applyTime) { this.applyTime = applyTime; }

    public Date getApproveTime() { return approveTime; }
    public void setApproveTime(Date approveTime) { this.approveTime = approveTime; }

    public Integer getApprovedAdminId() { return approvedAdminId; }
    public void setApprovedAdminId(Integer approvedAdminId) { this.approvedAdminId = approvedAdminId; }
}
