package com.reservaciones.hotel.repository;

import com.reservaciones.hotel.model.Reservacion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import java.sql.Types;
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
        inParams.put("p_fecha_inicio", reservacion.getFechaInicio());
        inParams.put("p_fecha_fin", reservacion.getFechaFin());
        inParams.put("p_cantidad_personas", reservacion.getCantidadPersonas());
        inParams.put("p_cliente_id", reservacion.getClienteId());
        inParams.put("p_apartamento_id", reservacion.getApartamentoId());

        jdbcCall.execute(inParams);
    }

    public void actualizarReservacion(Reservacion reservacion) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("PKG_CRUD_RESERVACION")
                .withProcedureName("MODIFICAR_RESERVACION");

        Map<String, Object> inParams = new HashMap<>();
        inParams.put("p_reservacion_id", reservacion.getReservacionId());
        inParams.put("p_fecha_inicio", reservacion.getFechaInicio());
        inParams.put("p_fecha_fin", reservacion.getFechaFin());
        inParams.put("p_cantidad_personas", reservacion.getCantidadPersonas());
        inParams.put("p_cliente_id", reservacion.getClienteId());
        inParams.put("p_apartamento_id", reservacion.getApartamentoId());

        jdbcCall.execute(inParams);
    }

    public Reservacion obtenerReservacionPorId(int reservacionId) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("PKG_CRUD_RESERVACION")
                .withProcedureName("OBTENER_RESERVACION_POR_ID")
                .returningResultSet("reservacion",
                        BeanPropertyRowMapper.newInstance(Reservacion.class));

        Map<String, Object> inParams = new HashMap<>();
        inParams.put("p_reservacion_id", reservacionId);

        Map<String, Object> out = jdbcCall.execute(inParams);
        List<Reservacion> reservaciones = (List<Reservacion>) out.get("reservacion");

        return reservaciones.isEmpty() ? null : reservaciones.get(0);
    }

    public void eliminarReservacion(int reservacionId) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("PKG_CRUD_RESERVACION")
                .withProcedureName("ELIMINAR_RESERVACION");

        Map<String, Object> inParams = new HashMap<>();
        inParams.put("p_reservacion_id", reservacionId);

        jdbcCall.execute(inParams);
    }
}
