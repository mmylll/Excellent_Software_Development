package com.example.art_backend.model;

import lombok.Data;

import javax.persistence.*;

@Entity
@Data
@Table(name = "eras")
public class Eras {
    @Id
    @Column(name = "EraID", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer eraId;

    @Column(name = "EraName",nullable = false)
    private String eraName;

    @Column(name = "EraYears",nullable = false)
    private String eraYears;

    @Column(name = "StartYear",nullable = false)
    private Integer startYear;

    @Column(name = "EndYear",nullable = false)
    private Integer endYear;

    public Eras(Integer eraId, String eraName, String eraYears, Integer startYear, Integer endYear) {
        this.eraId = eraId;
        this.eraName = eraName;
        this.eraYears = eraYears;
        this.startYear = startYear;
        this.endYear = endYear;
    }

    public Eras() {

    }

    public Integer getEraId() {
        return eraId;
    }

    public void setEraId(Integer eraId) {
        this.eraId = eraId;
    }

    public String getEraName() {
        return eraName;
    }

    public void setEraName(String eraName) {
        this.eraName = eraName;
    }

    public String getEraYears() {
        return eraYears;
    }

    public void setEraYears(String eraYears) {
        this.eraYears = eraYears;
    }

    public Integer getStartYear() {
        return startYear;
    }

    public void setStartYear(Integer startYear) {
        this.startYear = startYear;
    }

    public Integer getEndYear() {
        return endYear;
    }

    public void setEndYear(Integer endYear) {
        this.endYear = endYear;
    }
}
