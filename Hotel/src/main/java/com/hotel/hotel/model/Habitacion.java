package com.hotel.hotel.model;

public class Habitacion {

    private Long idHabitacion;
    private int fkTipoHabitacion;
    private int numeroHabitacion;
    private String descripcion;
    private String estado;

    // Nombre descriptivo del tipo de habitación (para mostrar)
    private String nombreTipoHabitacion;

    // Getters y setters

    public Long getIdHabitacion() {
        return idHabitacion;
    }

    public void setIdHabitacion(Long idHabitacion) {
        this.idHabitacion = idHabitacion;
    }

    public int getFkTipoHabitacion() {
        return fkTipoHabitacion;
    }

    public void setFkTipoHabitacion(int fkTipoHabitacion) {
        this.fkTipoHabitacion = fkTipoHabitacion;
    }

    public int getNumeroHabitacion() {
        return numeroHabitacion;
    }

    public void setNumeroHabitacion(int numeroHabitacion) {
        this.numeroHabitacion = numeroHabitacion;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getNombreTipoHabitacion() {
        return nombreTipoHabitacion;
    }

    public void setNombreTipoHabitacion(String nombreTipoHabitacion) {
        this.nombreTipoHabitacion = nombreTipoHabitacion;
    }
}
