package com.example.art_backend.model;

import lombok.Data;

import javax.persistence.*;

@Entity
@Data
@Table(name = "artist")
public class Artist {
    @Id
    @Column(name = "ArtistID", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer artistId;

    @Column(name = "FirstName")
    private String firstName;

    @Column(name = "LastName")
    private String lastName;

    @Column(name = "Nationality")
    private String nationality;

    @Column(name = "Gender")
    private String gender;

    @Column(name = "YearOfBirth")
    private Integer yearOfBirth;

    @Column(name = "YearOfDeath")
    private Integer yearOfDeath;

    @Column(name = "Details")
    private String details;

    @Column(name = "ArtistLink")
    private String artistLink;

    public Artist(Integer artistId, String firstName, String lastName, String nationality, String gender, Integer yearOfBirth, Integer yearOfDeath, String details, String artistLink) {
        this.artistId = artistId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.nationality = nationality;
        this.gender = gender;
        this.yearOfBirth = yearOfBirth;
        this.yearOfDeath = yearOfDeath;
        this.details = details;
        this.artistLink = artistLink;
    }

    public Artist() {

    }

    public Integer getArtistId() {
        return artistId;
    }

    public void setArtistId(Integer artistId) {
        this.artistId = artistId;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getNationality() {
        return nationality;
    }

    public void setNationality(String nationality) {
        this.nationality = nationality;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Integer getYearOfBirth() {
        return yearOfBirth;
    }

    public void setYearOfBirth(Integer yearOfBirth) {
        this.yearOfBirth = yearOfBirth;
    }

    public Integer getYearOfDeath() {
        return yearOfDeath;
    }

    public void setYearOfDeath(Integer yearOfDeath) {
        this.yearOfDeath = yearOfDeath;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public String getArtistLink() {
        return artistLink;
    }

    public void setArtistLink(String artistLink) {
        this.artistLink = artistLink;
    }
}
