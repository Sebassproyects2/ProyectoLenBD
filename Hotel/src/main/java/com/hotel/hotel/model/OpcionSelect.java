package com.hotel.hotel.model;

public class OpcionSelect {
    private int id;
    private String nombre;

    public OpcionSelect(int id, String nombre) {
        this.id = id;
        this.nombre = nombre;
    }

    public int getId() {
        return id;
    }

    public String getNombre() {
        return nombre;
    }
}

