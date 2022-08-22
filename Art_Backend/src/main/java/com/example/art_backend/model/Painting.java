package com.example.art_backend.model;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Data
@Table(name = "painting")
public class Painting implements Serializable {
    @Id
    @Column(name = "PaintingID", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer paintingId;

    @Column(name = "ArtistID",nullable = false)
    private Integer artistId;

    @Column(name = "GalleryID",nullable = false)
    private Integer galleryId;

    @Column(name = "ImageFileName",nullable = false)
    private String imageFileName;

    @Column(name = "Title")
    private String title;

    @Column(name = "ShapeID")
    private Integer shapeId;

    @Column(name = "MuseumLink")
    private String museumLink;

    @Column(name = "AccessionNumber")
    private String accessionNumber;

    @Column(name = "CopyrightText")
    private String copyrightText;

    @Column(name = "Description")
    private String description;

    @Column(name = "Excerpt")
    private String excerpt;

    @Column(name = "YearOfWork")
    private Integer yearOfWork;

    @Column(name = "Width")
    private Integer width;

    @Column(name = "Height")
    private Integer height;

    @Column(name = "Medium")
    private String medium;

    @Column(name = "Cost")
    private Double cost;

    @Column(name = "MSRP")
    private Double MSRP;

    @Column(name = "GoogleLink")
    private String googleLink;

    @Column(name = "GoogleDescription")
    private String googleDescription;

    @Column(name = "WikiLink")
    private String wikiLink;

    @Column(name = "Views")
    private Integer views;

    @Column(name = "Sell")
    private Boolean sell;

    @OneToOne
    @JoinColumn(name="ArtistID",referencedColumnName="ArtistID",insertable = false, updatable = false)
    private Artist artist;

    public Painting() {
    }

    public Painting(Integer paintingId, Integer artistId, Integer galleryId, String imageFileName, String title, Integer shapeId, String museumLink, String accessionNumber, String copyrightText, String description, String excerpt, Integer yearOfWork, Integer width, Integer height, String medium, Double cost, Double MSRP, String googleLink, String googleDescription, String wikiLink, Integer views, Boolean sell) {
        this.paintingId = paintingId;
        this.artistId = artistId;
        this.galleryId = galleryId;
        this.imageFileName = imageFileName;
        this.title = title;
        this.shapeId = shapeId;
        this.museumLink = museumLink;
        this.accessionNumber = accessionNumber;
        this.copyrightText = copyrightText;
        this.description = description;
        this.excerpt = excerpt;
        this.yearOfWork = yearOfWork;
        this.width = width;
        this.height = height;
        this.medium = medium;
        this.cost = cost;
        this.MSRP = MSRP;
        this.googleLink = googleLink;
        this.googleDescription = googleDescription;
        this.wikiLink = wikiLink;
        this.views = views;
        this.sell = sell;
    }

    public Painting(Integer paintingId, Integer artistId, Integer galleryId, String imageFileName, String title, Integer shapeId, String museumLink, String accessionNumber, String copyrightText, String description, String excerpt, Integer yearOfWork, Integer width, Integer height, String medium, Double cost, Double MSRP, String googleLink, String googleDescription, String wikiLink, Integer views, Boolean sell, Artist artist) {
        this.paintingId = paintingId;
        this.artistId = artistId;
        this.galleryId = galleryId;
        this.imageFileName = imageFileName;
        this.title = title;
        this.shapeId = shapeId;
        this.museumLink = museumLink;
        this.accessionNumber = accessionNumber;
        this.copyrightText = copyrightText;
        this.description = description;
        this.excerpt = excerpt;
        this.yearOfWork = yearOfWork;
        this.width = width;
        this.height = height;
        this.medium = medium;
        this.cost = cost;
        this.MSRP = MSRP;
        this.googleLink = googleLink;
        this.googleDescription = googleDescription;
        this.wikiLink = wikiLink;
        this.views = views;
        this.sell = sell;
        this.artist = artist;
    }

    public Integer getPaintingId() {
        return paintingId;
    }

    public void setPaintingId(Integer paintingId) {
        this.paintingId = paintingId;
    }

    public Integer getArtistId() {
        return artistId;
    }

    public void setArtistId(Integer artistId) {
        this.artistId = artistId;
    }

    public Integer getGalleryId() {
        return galleryId;
    }

    public void setGalleryId(Integer galleryId) {
        this.galleryId = galleryId;
    }

    public String getImageFileName() {
        return imageFileName;
    }

    public void setImageFileName(String imageFileName) {
        this.imageFileName = imageFileName;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getShapeId() {
        return shapeId;
    }

    public void setShapeId(Integer shapeId) {
        this.shapeId = shapeId;
    }

    public String getMuseumLink() {
        return museumLink;
    }

    public void setMuseumLink(String museumLink) {
        this.museumLink = museumLink;
    }

    public String getAccessionNumber() {
        return accessionNumber;
    }

    public void setAccessionNumber(String accessionNumber) {
        this.accessionNumber = accessionNumber;
    }

    public String getCopyrightText() {
        return copyrightText;
    }

    public void setCopyrightText(String copyrightText) {
        this.copyrightText = copyrightText;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getExcerpt() {
        return excerpt;
    }

    public void setExcerpt(String excerpt) {
        this.excerpt = excerpt;
    }

    public Integer getYearOfWork() {
        return yearOfWork;
    }

    public void setYearOfWork(Integer yearOfWork) {
        this.yearOfWork = yearOfWork;
    }

    public Integer getWidth() {
        return width;
    }

    public void setWidth(Integer width) {
        this.width = width;
    }

    public Integer getHeight() {
        return height;
    }

    public void setHeight(Integer height) {
        this.height = height;
    }

    public String getMedium() {
        return medium;
    }

    public void setMedium(String medium) {
        this.medium = medium;
    }

    public Double getCost() {
        return cost;
    }

    public void setCost(Double cost) {
        this.cost = cost;
    }

    public Double getMSRP() {
        return MSRP;
    }

    public void setMSRP(Double MSRP) {
        this.MSRP = MSRP;
    }

    public String getGoogleLink() {
        return googleLink;
    }

    public void setGoogleLink(String googleLink) {
        this.googleLink = googleLink;
    }

    public String getGoogleDescription() {
        return googleDescription;
    }

    public void setGoogleDescription(String googleDescription) {
        this.googleDescription = googleDescription;
    }

    public String getWikiLink() {
        return wikiLink;
    }

    public void setWikiLink(String wikiLink) {
        this.wikiLink = wikiLink;
    }

    public Integer getViews() {
        return views;
    }

    public void setViews(Integer views) {
        this.views = views;
    }

    public Boolean getSell() {
        return sell;
    }

    public void setSell(Boolean sell) {
        this.sell = sell;
    }

    public Artist getArtist() {
        return artist;
    }

    public void setArtist(Artist artist) {
        this.artist = artist;
    }
}
