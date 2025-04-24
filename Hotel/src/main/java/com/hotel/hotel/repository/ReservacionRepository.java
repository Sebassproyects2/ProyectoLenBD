package com.hotel.hotel.repository;

import com.hotel.hotel.model.Reservacion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class ReservacionRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Reservacion> listarReservaciones() {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("PKG_CRUD_RESERVACION")
                .withProcedureName("LISTAR_RESERVACIONES")
                .returningResultSet("reservaciones",
                        BeanPropertyRowMapper.newInstance(Reservacion.class));

        Map<String, Object> out = jdbcCall.execute();
        return (List<Reservacion>) out.get("reservaciones");
    }

    public void insertarReservacion(Reservacion reservacion) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
            .withCatalogName("PKG_CRUD_RESERVACION")
            .withProcedureName("AGREGAR_RESERVACION");

    Map<String, Object> inParams = new HashMap<>();
    inParams.put("P_FK_HUESPED", reservacion.getFkHuesped());
    inParams.put("P_FK_HOTEL", reservacion.getFkHotel());
    inParams.put("P_FK_HABITACION", reservacion.getFkHabitacion());
    inParams.put("P_FK_PROMOCION", reservacion.getFkPromocion());
    inParams.put("P_ESTADO", reservacion.getEstado());
    inParams.put("P_COMENTARIOS", reservacion.getComentarios());
    inParams.put("P_FECHA_CHECKIN", reservacion.getFechaCheckin());
    inParams.put("P_FECHA_CHECKOUT", reservacion.getFechaCheckout());

    jdbcCall.execute(inParams);
}


    public void actualizarReservacion(Reservacion reservacion) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("PKG_CRUD_RESERVACION")
                .withProcedureName("MODIFICAR_RESERVACION");

        Map<String, Object> inParams = new HashMap<>();
        inParams.put("p_id_reservacion", reservacion.getIdReservacion());
        inParams.put("p_id_huesped", reservacion.getFkHuesped());
        inParams.put("p_id_hotel", reservacion.getFkHotel());
        inParams.put("p_id_habitacion", reservacion.getFkHabitacion());
        inParams.put("p_id_promocion", reservacion.getFkPromocion());
        inParams.put("p_estado", reservacion.getEstado());
        inParams.put("p_comentarios", reservacion.getComentarios());
        inParams.put("p_fecha_checkin", reservacion.getFechaCheckin());
        inParams.put("p_fecha_checkout", reservacion.getFechaCheckout());

        jdbcCall.execute(inParams);
    }

    public Reservacion obtenerReservacionPorId(Long idReservacion) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("PKG_CRUD_RESERVACION")
                .withProcedureName("OBTENER_RESERVACION_POR_ID")
                .returningResultSet("reservacion",
                        BeanPropertyRowMapper.newInstance(Reservacion.class));

        Map<String, Object> inParams = new HashMap<>();
        inParams.put("p_id_reservacion", idReservacion);

        Map<String, Object> out = jdbcCall.execute(inParams);
        List<Reservacion> lista = (List<Reservacion>) out.get("reservacion");

        return lista.isEmpty() ? null : lista.get(0);
    }

    public void eliminarReservacion(Long idReservacion) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("PKG_CRUD_RESERVACION")
                .withProcedureName("ELIMINAR_RESERVACION");

        Map<String, Object> inParams = new HashMap<>();
        inParams.put("p_id_reservacion", idReservacion);

        jdbcCall.execute(inParams);
    }
    


}
