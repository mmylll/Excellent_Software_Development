package com.example.art_backend.model;

import lombok.Data;

import javax.persistence.*;

@Entity
@Data
@Table(name = "PaintingSubject")
public class PaintingSubject {

    @Id
    @Column(name = "PaintingSubjectID", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer paintingSubjectId;

    @Column(name = "PaintingID",nullable = false)
    private Integer paintingID;

    @Column(name = "SubjectID",nullable = false)
    private Integer subjectId;

    @JoinColumn(name = "PaintingID",insertable = false,updatable = false)//设置外键
    @ManyToOne//设置多对一
    private Painting painting;

    public PaintingSubject(Integer paintingSubjectId, Integer paintingID, Integer subjectId, Painting painting) {
        this.paintingSubjectId = paintingSubjectId;
        this.paintingID = paintingID;
        this.subjectId = subjectId;
        this.painting = painting;
    }

    public PaintingSubject() {

    }

    public Integer getPaintingSubjectId() {
        return paintingSubjectId;
    }

    public void setPaintingSubjectId(Integer paintingSubjectId) {
        this.paintingSubjectId = paintingSubjectId;
    }

    public Integer getPaintingID() {
        return paintingID;
    }

    public void setPaintingID(Integer paintingID) {
        this.paintingID = paintingID;
    }

    public Integer getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(Integer subjectId) {
        this.subjectId = subjectId;
    }

    public Painting getPainting() {
        return painting;
    }

    public void setPainting(Painting painting) {
        this.painting = painting;
    }
}
