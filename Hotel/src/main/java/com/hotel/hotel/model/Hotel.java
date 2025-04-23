
package com.hotel.hotel.model;



import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "Hotel")
public class Hotel {

    @Id
    @Column(name = "Id_Hotel")
    private Long idHotel;

    @Column(name = "Nombre", nullable = false, length = 50)
    private String nombre;

    @Column(name = "Ciudad", nullable = false, length = 50)
    private String ciudad;

    @Column(name = "Canton", nullable = false, length = 50)
    private String canton;

    @Column(name = "Distrito", nullable = false, length = 50)
    private String distrito;

    @Column(name = "Detalle_Direccion", nullable = false, length = 50)
    private String detalleDireccion;

    @Column(name = "Telefono", nullable = false, length = 30)
    private String telefono;

    @Column(name = "Numero_pisos", nullable = false)
    private Integer numeroPisos;

    // Constructores (necesario para JPA)
    public Hotel() {
    }

    public Hotel(Long idHotel, String nombre, String ciudad, String canton, String distrito, String detalleDireccion, String telefono, Integer numeroPisos) {
        this.idHotel = idHotel;
        this.nombre = nombre;
        this.ciudad = ciudad;
        this.canton = canton;
        this.distrito = distrito;
        this.detalleDireccion = detalleDireccion;
        this.telefono = telefono;
        this.numeroPisos = numeroPisos;
    }

    // Getters y Setters
    public Long getIdHotel() {
        return idHotel;
    }

    public void setIdHotel(Long idHotel) {
        this.idHotel = idHotel;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public String getCanton() {
        return canton;
    }

    public void setCanton(String canton) {
        this.canton = canton;
    }

    public String getDistrito() {
        return distrito;
    }

    public void setDistrito(String distrito) {
        this.distrito = distrito;
    }

    public String getDetalleDireccion() {
        return detalleDireccion;
    }

    public void setDetalleDireccion(String detalleDireccion) {
        this.detalleDireccion = detalleDireccion;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public Integer getNumeroPisos() {
        return numeroPisos;
    }

    public void setNumeroPisos(Integer numeroPisos) {
        this.numeroPisos = numeroPisos;
    }
}
