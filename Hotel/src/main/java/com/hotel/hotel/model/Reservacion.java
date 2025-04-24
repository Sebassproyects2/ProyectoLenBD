package com.hotel.hotel.model;

import java.sql.Date;

public class Reservacion {

    private Long idReservacion;
    private int fkHuesped;
    private int fkHotel;
    private int fkHabitacion;
    private int fkPromocion;
    private String estado;
    private String comentarios;
    private Date fechaCheckin;
    private Date fechaCheckout;

    // Campos descriptivos (no se usan para insertar, solo mostrar)
    private String nombreHuesped;
    private String numeroHabitacion;
    private String nombreHotel;
    private String nombrePromocion;

    // Getters y Setters

    public Long getIdReservacion() {
        return idReservacion;
    }

    public void setIdReservacion(Long idReservacion) {
        this.idReservacion = idReservacion;
    }

    public int getFkHuesped() {
        return fkHuesped;
    }

    public void setFkHuesped(int fkHuesped) {
        this.fkHuesped = fkHuesped;
    }

    public int getFkHotel() {
        return fkHotel;
    }

    public void setFkHotel(int fkHotel) {
        this.fkHotel = fkHotel;
    }

    public int getFkHabitacion() {
        return fkHabitacion;
    }

    public void setFkHabitacion(int fkHabitacion) {
        this.fkHabitacion = fkHabitacion;
    }

    public int getFkPromocion() {
        return fkPromocion;
    }

    public void setFkPromocion(int fkPromocion) {
        this.fkPromocion = fkPromocion;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getComentarios() {
        return comentarios;
    }

    public void setComentarios(String comentarios) {
        this.comentarios = comentarios;
    }

    public Date getFechaCheckin() {
        return fechaCheckin;
    }

    public void setFechaCheckin(Date fechaCheckin) {
        this.fechaCheckin = fechaCheckin;
    }

    public Date getFechaCheckout() {
        return fechaCheckout;
    }

    public void setFechaCheckout(Date fechaCheckout) {
        this.fechaCheckout = fechaCheckout;
    }

    public String getNombreHuesped() {
        return nombreHuesped;
    }

    public void setNombreHuesped(String nombreHuesped) {
        this.nombreHuesped = nombreHuesped;
    }

    public String getNumeroHabitacion() {
        return numeroHabitacion;
    }

    public void setNumeroHabitacion(String numeroHabitacion) {
        this.numeroHabitacion = numeroHabitacion;
    }

    public String getNombreHotel() {
        return nombreHotel;
    }

    public void setNombreHotel(String nombreHotel) {
        this.nombreHotel = nombreHotel;
    }

    public String getNombrePromocion() {
        return nombrePromocion;
    }

    public void setNombrePromocion(String nombrePromocion) {
        this.nombrePromocion = nombrePromocion;
    }
}
