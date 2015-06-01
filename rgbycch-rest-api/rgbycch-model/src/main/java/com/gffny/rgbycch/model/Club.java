/**
 * 
 */
package com.gffny.rgbycch.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * @author John D. Gaffney | gffny.com
 *
 */
@Entity
@Table(name = "t_club")
public class Club {

    private Integer id;

    @Id
    @Column(name = "pk")
    public Integer getId() {
	return id;
    }

    public void setId(Integer id) {
	this.id = id;
    }

}
