package com.solstice.codechallenge.beans;

import java.io.Serializable;

/**
 * Created by tavo on 28/03/2015.
 */
public final class Contact implements Serializable {
    private static final long serialVersionUID = 1L;
    private String name;
    private String employeeId;
    private String company;
    private String detailsURL;
    private String smallImageURL;// ver de caregar la imagen
    private String birthdate;

    private Phones phones;

    public Contact(){


    }

   /* public Contact(String name,String employeeId,String company,
                   String detailsURL,String smallImageURL,String birthdate, Phones phones) {
        this.name=name;
        this.employeeId=employeeId;
        this.company=company;
        this.detailsURL=detailsURL;
        this.smallImageURL=smallImageURL;
        this.birthdate=birthdate;
    }*/

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(String employeeId) {
        this.employeeId = employeeId;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getDetailsURL() {
        return detailsURL;
    }

    public void setDetailsURL(String detailsURL) {
        this.detailsURL = detailsURL;
    }

    public String getSmallImageURL() {
        return smallImageURL;
    }

    public void setSmallImageURL(String smallImageURL) {
        this.smallImageURL = smallImageURL;
    }

    public String getBirthdate() {
        return birthdate;
    }

    public void setBirthdate(String birthdate) {
        this.birthdate = birthdate;
    }

    public Phones getPhones() {
        return phones;
    }

    public void setPhones(Phones phones) {
        this.phones = phones;
    }

    @Override
    public String toString() {
        return this.name + "\n";
    }
}