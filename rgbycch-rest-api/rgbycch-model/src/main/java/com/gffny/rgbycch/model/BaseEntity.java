package com.gffny.rgbycch.model;

import javax.persistence.Column;
import javax.persistence.Id;

public abstract class BaseEntity {

    private Integer id;

    public BaseEntity() {
	super();
    }

    @Id
    @Column(name = "pk")
    public Integer getId() {
	return id;
    }

    public void setId(Integer id) {
	this.id = id;
    }

    public abstract String name();
}