package com.hotel.hotel.model;

import java.sql.Date;

public class Reservacion {

    private Long idReservacion;
    private Date fechaEntrada;
    private Date fechaSalida;
    private int cantidadPersonas;
    private String estado; // Por ejemplo: Confirmada, Cancelada, Pendiente

    private int fkCliente;      // ID de cliente (para insertar)
    private int fkHabitacion;   // ID de habitación (para insertar)
    private int fkHotel;        // ID de hotel (para insertar)

    private String nombreCliente;    // Nombre descriptivo (para mostrar)
    private String numeroHabitacion;
    private String nombreHotel;

    // Getters y setters

    public Long getIdReservacion() {
        return idReservacion;
    }

    public void setIdReservacion(Long idReservacion) {
        this.idReservacion = idReservacion;
    }

    public Date getFechaEntrada() {
        return fechaEntrada;
    }

    public void setFechaEntrada(Date fechaEntrada) {
        this.fechaEntrada = fechaEntrada;
    }

    public Date getFechaSalida() {
        return fechaSalida;
    }

    public void setFechaSalida(Date fechaSalida) {
        this.fechaSalida = fechaSalida;
    }

    public int getCantidadPersonas() {
        return cantidadPersonas;
    }

    public void setCantidadPersonas(int cantidadPersonas) {
        this.cantidadPersonas = cantidadPersonas;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public int getFkCliente() {
        return fkCliente;
    }

    public void setFkCliente(int fkCliente) {
        this.fkCliente = fkCliente;
    }

    public int getFkHabitacion() {
        return fkHabitacion;
    }

    public void setFkHabitacion(int fkHabitacion) {
        this.fkHabitacion = fkHabitacion;
    }

    public int getFkHotel() {
        return fkHotel;
    }

    public void setFkHotel(int fkHotel) {
        this.fkHotel = fkHotel;
    }

    public String getNombreCliente() {
        return nombreCliente;
    }

    public void setNombreCliente(String nombreCliente) {
        this.nombreCliente = nombreCliente;
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
}

