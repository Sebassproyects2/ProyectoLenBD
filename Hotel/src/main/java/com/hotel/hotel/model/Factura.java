package com.hotel.hotel.model;

import java.sql.Date;

public class Factura {

    private Long idFactura;
    private Long fkReservacion;
    private Date fechaEmision;
    private double descuento;
    private String metodoPago;
    private double monto;
    private String estado;

    // Getters y Setters

    public Long getIdFactura() {
        return idFactura;
    }

    public void setIdFactura(Long idFactura) {
        this.idFactura = idFactura;
    }

    public Long getFkReservacion() {
        return fkReservacion;
    }

    public void setFkReservacion(Long fkReservacion) {
        this.fkReservacion = fkReservacion;
    }

    public Date getFechaEmision() {
        return fechaEmision;
    }

    public void setFechaEmision(Date fechaEmision) {
        this.fechaEmision = fechaEmision;
    }

    public double getDescuento() {
        return descuento;
    }

    public void setDescuento(double descuento) {
        this.descuento = descuento;
    }

    public String getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(String metodoPago) {
        this.metodoPago = metodoPago;
    }

    public double getMonto() {
        return monto;
    }

    public void setMonto(double monto) {
        this.monto = monto;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
}