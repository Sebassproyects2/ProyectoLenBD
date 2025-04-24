package com.hotel.hotel.model;

import java.sql.Date;

public class Reservacion {

    private Long idReservacion;
    private Long fkHuesped;
    private Long fkHotel;
    private Long fkHabitacion;
    private Long fkPromocion;
    private String estado;
    private String comentarios;
    private Date fechaCheckIn;
    private Date fechaCheckOut;

    // Getters y Setters

    public Long getIdReservacion() {
        return idReservacion;
    }

    public void setIdReservacion(Long idReservacion) {
        this.idReservacion = idReservacion;
    }

    public Long getFkHuesped() {
        return fkHuesped;
    }

    public void setFkHuesped(Long fkHuesped) {
        this.fkHuesped = fkHuesped;
    }

    public Long getFkHotel() {
        return fkHotel;
    }

    public void setFkHotel(Long fkHotel) {
        this.fkHotel = fkHotel;
    }

    public Long getFkHabitacion() {
        return fkHabitacion;
    }

    public void setFkHabitacion(Long fkHabitacion) {
        this.fkHabitacion = fkHabitacion;
    }

    public Long getFkPromocion() {
        return fkPromocion;
    }

    public void setFkPromocion(Long fkPromocion) {
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

    public Date getFechaCheckIn() {
        return fechaCheckIn;
    }

    public void setFechaCheckIn(Date fechaCheckIn) {
        this.fechaCheckIn = fechaCheckIn;
    }

    public Date getFechaCheckOut() {
        return fechaCheckOut;
    }

    public void setFechaCheckOut(Date fechaCheckOut) {
        this.fechaCheckOut = fechaCheckOut;
    }
}
