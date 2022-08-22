package com.example.art_backend.model;

import lombok.Data;

import javax.persistence.*;
import java.util.Date;

@Entity
@Data
@Table(name = "cart")
public class Cart {

    @Id
    @Column(name = "ID", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "UserEmail",nullable = false)
    private String userEmail;

    @Column(name = "PaintingID",nullable = false)
    private Integer paintingId;

    @Column(name = "Money",nullable = false)
    private Double money;

    @Column(name = "Valid",nullable = false)
    private Boolean valid;

    @OneToOne
    @JoinColumn(name="PaintingID",referencedColumnName="PaintingID",insertable = false, updatable = false)
    private Painting painting;

    public Cart(Integer id, String userEmail, Integer paintingId, Double money, Boolean valid, Painting painting) {
        this.id = id;
        this.userEmail = userEmail;
        this.paintingId = paintingId;
        this.money = money;
        this.valid = valid;
        this.painting = painting;
    }

    public Cart(String userEmail, Integer paintingId, Double money) {
        this.userEmail = userEmail;
        this.paintingId = paintingId;
        this.money = money;
        this.valid = true;
    }

    public Cart() {

    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public Integer getPaintingId() {
        return paintingId;
    }

    public void setPaintingId(Integer paintingId) {
        this.paintingId = paintingId;
    }

    public Double getMoney() {
        return money;
    }

    public void setMoney(Double money) {
        this.money = money;
    }

    public Boolean getValid() {
        return valid;
    }

    public void setValid(Boolean valid) {
        this.valid = valid;
    }

    public Painting getPainting() {
        return painting;
    }

    public void setPainting(Painting painting) {
        this.painting = painting;
    }
}
