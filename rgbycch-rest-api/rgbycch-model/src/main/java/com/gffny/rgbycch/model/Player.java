/**
 * 
 */
package com.gffny.rgbycch.model;

import com.gffny.rgbycch.model.enums.PlayerPosition;

/**
 * @author John D. Gaffney | gffny.com
 *
 */
public class Player extends BaseEntity {

    private String firstName;
    private String surname;
    private PlayerPosition primaryPosition;

    public String getFirstName() {
	return firstName;
    }

    public void setFirstName(String firstName) {
	this.firstName = firstName;

    }

    public String getSurname() {
	return surname;
    }

    public void setSurname(String surname) {
	this.surname = surname;
    }

    public PlayerPosition getPrimaryPosition() {
	return this.primaryPosition;
    }

    public void setPrimaryPosition(PlayerPosition primaryPosition) {
	this.primaryPosition = primaryPosition;
    }

    @Override
    public String name() {
	return getFirstName() + " " + getSurname();
    }

}
