/**
 * 
 */
package com.gffny.rgbycch.model;


/**
 * @author John D. Gaffney | gffny.com
 *
 */
// @Entity
// @Table(name = "t_club")
public class Club extends BaseEntity {

    private String name;

    public String getName() {
	return this.name;
    }

    public void setName(String name) {
	this.name = name;
    }

    @Override
    public String name() {
	return getName();
    }
}
