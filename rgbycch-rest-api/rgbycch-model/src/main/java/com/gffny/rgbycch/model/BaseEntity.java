package com.gffny.rgbycch.model;

public abstract class BaseEntity {

    private Integer id;

    public BaseEntity() {
	super();
    }

    // @Id
    // @Column(name = "pk")
    public Integer getId() {
	return id;
    }

    public void setId(Integer id) {
	this.id = id;
    }

    public abstract String name();
}