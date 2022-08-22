package com.example.art_backend.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.Date;

@Entity
@Data
@Table(name = "art_order")
public class Order {

    @Id
    @Column(name = "OrderID", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer orderId;

    @Column(name = "PaintingID",nullable = false)
    private Integer paintingId;

    @Column(name = "UserEmail",nullable = false)
    private String userEmail;

    @Column(name = "OrderTime",nullable = false)
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
    @Temporal(TemporalType.TIMESTAMP)
    private Date orderTime;

    @Column(name = "Money",nullable = false)
    private Double money;

    @OneToOne
    @JoinColumn(name="PaintingID",referencedColumnName="PaintingID",insertable = false, updatable = false)
    private Painting painting;

    public Order(Integer orderId, Integer paintingId, String userEmail, Date orderTime, Double money, Painting painting) {
        this.orderId = orderId;
        this.paintingId = paintingId;
        this.userEmail = userEmail;
        this.orderTime = orderTime;
        this.money = money;
        this.painting = painting;
    }

    public Order(Integer paintingId, String userEmail, Date orderTime, Double money) {
        this.paintingId = paintingId;
        this.userEmail = userEmail;
        this.orderTime = orderTime;
        this.money = money;
    }

    public Order() {

    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Integer getPaintingId() {
        return paintingId;
    }

    public void setPaintingId(Integer paintingId) {
        this.paintingId = paintingId;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public Date getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(Date orderTime) {
        this.orderTime = orderTime;
    }

    public Double getMoney() {
        return money;
    }

    public void setMoney(Double money) {
        this.money = money;
    }

    public Painting getPainting() {
        return painting;
    }

    public void setPainting(Painting painting) {
        this.painting = painting;
    }
}
