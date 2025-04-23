
package com.hotel.hotel.repository;



import com.hotel.hotel.model.Hotel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface HotelRepository extends JpaRepository<Hotel, Long> {

    @Procedure("pkg_crud_hoteles.agregarHoteles")
    void agregarHoteles(
            @Param("v_id_hotel") Long idHotel,
            @Param("v_nombre") String nombre,
            @Param("v_ciudad") String ciudad,
            @Param("v_canton") String canton,
            @Param("v_distrito") String distrito,
            @Param("v_detalle_direccion") String detalleDireccion,
            @Param("v_telefono") String telefono,
            @Param("v_numero_pisos") Integer numeroPisos
    );

    @Procedure("pkg_crud_hoteles.ver_hotel_por_id")
    Optional<Hotel> verHotelPorId(@Param("hotelid") Long hotelId);
    
    @Procedure(value = "pkg_crud_hoteles.ver_hotel_por_id")
Optional<Hotel> verHotelPorId(
        @Param("hotelid") Long hotelId,
        @Param("hotel_rec") Hotel hotelRec // Intenta mapear el OUT a un parámetro Java
);

    @Procedure("pkg_crud_hoteles.actualizar_hotel")
    void actualizarHotel(
            @Param("p_hotelid") Long idHotel,
            @Param("p_nombre") String nombre,
            @Param("p_ciudad") String ciudad,
            @Param("p_canton") String canton,
            @Param("p_distrito") String distrito,
            @Param("p_detalle_direccion") String detalleDireccion,
            @Param("p_telefono") String telefono,
            @Param("p_numero_pisos") Integer numeroPisos
    );

    @Procedure("pkg_crud_hoteles.eliminar_hotel")
    void eliminarHotel(@Param("p_hotelid") Long hotelId);
}
