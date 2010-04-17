package com.aaronhardy.rlgl;

import java.util.Date;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Key;

@PersistenceCapable
public class Group {
	
	@PrimaryKey
    @Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
    private Key key;
	
    @Persistent
    private String name;

    @Persistent
    private String color;

    @Persistent
    private String lastModifiedAlias;

    public Group() {
    }

    public void setName(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getColor() {
		return color;
	}

	public void setLastModifiedAlias(String lastModifiedAlias) {
		this.lastModifiedAlias = lastModifiedAlias;
	}

	public String getLastModifiedAlias() {
		return lastModifiedAlias;
	}
}
