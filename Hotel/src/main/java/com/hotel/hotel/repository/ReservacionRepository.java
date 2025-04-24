package com.hotel.hotel.repository;

import com.hotel.hotel.model.Reservacion;
import jakarta.annotation.PostConstruct;
import oracle.jdbc.OracleTypes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class ReservacionRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private SimpleJdbcCall listarReservacionesCall;

    @PostConstruct
    public void init() {
        listarReservacionesCall = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("PKG_CRUD_RESERVACION")
                .withProcedureName("LISTAR_RESERVACIONES")
                .withoutProcedureColumnMetaDataAccess()
                .declareParameters(new SqlOutParameter("P_CURSOR", OracleTypes.CURSOR))
                .returningResultSet("P_CURSOR", new RowMapper<Reservacion>() {
                    @Override
                    public Reservacion mapRow(ResultSet rs, int rowNum) throws SQLException {
                        Reservacion r = new Reservacion();
                        r.setIdReservacion(rs.getLong("ID_RESERVACION"));
                        r.setFkHuesped(rs.getLong("FK_HUESPED"));
                        r.setFkHotel(rs.getLong("FK_HOTEL"));
                        r.setFkHabitacion(rs.getLong("FK_HABITACION"));
                        r.setFkPromocion(rs.getLong("FK_PROMOCION"));
                        r.setEstado(rs.getString("ESTADO"));
                        r.setComentarios(rs.getString("COMENTARIOS"));
                        r.setFechaCheckIn(rs.getDate("FECHA_CHECKIN"));
                        r.setFechaCheckOut(rs.getDate("FECHA_CHECKOUT"));
                        return r;
                    }
                });

        listarReservacionesCall.compile();
    }

    public void insertarReservacion(Reservacion reservacion) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("PKG_CRUD_RESERVACION")
                .withProcedureName("AGREGAR_RESERVACION");

        Map<String, Object> params = new HashMap<>();
        params.put("P_FK_HUESPED", reservacion.getFkHuesped());
        params.put("P_FK_HOTEL", reservacion.getFkHotel());
        params.put("P_FK_HABITACION", reservacion.getFkHabitacion());
        params.put("P_FK_PROMOCION", reservacion.getFkPromocion());
        params.put("P_ESTADO", reservacion.getEstado());
        params.put("P_COMENTARIOS", reservacion.getComentarios());
        params.put("P_FECHA_CHECKIN", reservacion.getFechaCheckIn());
        params.put("P_FECHA_CHECKOUT", reservacion.getFechaCheckOut());

        jdbcCall.execute(params);
    }

    public List<Reservacion> listarReservaciones() {
        Map<String, Object> result = listarReservacionesCall.execute();
        return (List<Reservacion>) result.get("P_CURSOR");
    }

    public Reservacion obtenerReservacionPorId(Long idReservacion) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("PKG_CRUD_RESERVACION")
                .withProcedureName("OBTENER_RESERVACION_POR_ID")
                .withoutProcedureColumnMetaDataAccess()
                .declareParameters(
                        new SqlParameter("P_ID_RESERVACION", Types.NUMERIC),
                        new SqlOutParameter("P_CURSOR", OracleTypes.CURSOR, new RowMapper<Reservacion>() {
                            @Override
                            public Reservacion mapRow(ResultSet rs, int rowNum) throws SQLException {
                                Reservacion r = new Reservacion();
                                r.setIdReservacion(rs.getLong("ID_RESERVACION"));
                                r.setFkHuesped(rs.getLong("FK_HUESPED"));
                                r.setFkHotel(rs.getLong("FK_HOTEL"));
                                r.setFkHabitacion(rs.getLong("FK_HABITACION"));
                                r.setFkPromocion(rs.getLong("FK_PROMOCION"));
                                r.setEstado(rs.getString("ESTADO"));
                                r.setComentarios(rs.getString("COMENTARIOS"));
                                r.setFechaCheckIn(rs.getDate("FECHA_CHECKIN"));
                                r.setFechaCheckOut(rs.getDate("FECHA_CHECKOUT"));
                                return r;
                            }
                        })
                );

        Map<String, Object> result = jdbcCall.execute(new MapSqlParameterSource("P_ID_RESERVACION", idReservacion));
        List<Reservacion> reservaciones = (List<Reservacion>) result.get("P_CURSOR");
        return reservaciones.isEmpty() ? null : reservaciones.get(0);
    }

    public void actualizarReservacion(Reservacion reservacion) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("PKG_CRUD_RESERVACION")
                .withProcedureName("MODIFICAR_RESERVACION");

        Map<String, Object> params = new HashMap<>();
        params.put("P_ID_RESERVACION", reservacion.getIdReservacion());
        params.put("P_FK_HUESPED", reservacion.getFkHuesped());
        params.put("P_FK_HOTEL", reservacion.getFkHotel());
        params.put("P_FK_HABITACION", reservacion.getFkHabitacion());
        params.put("P_FK_PROMOCION", reservacion.getFkPromocion());
        params.put("P_ESTADO", reservacion.getEstado());
        params.put("P_COMENTARIOS", reservacion.getComentarios());
        params.put("P_FECHA_CHECKIN", reservacion.getFechaCheckIn());
        params.put("P_FECHA_CHECKOUT", reservacion.getFechaCheckOut());

        jdbcCall.execute(params);
    }

    public void eliminarReservacion(Long idReservacion) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("PKG_CRUD_RESERVACION")
                .withProcedureName("ELIMINAR_RESERVACION");

        Map<String, Object> params = new HashMap<>();
        params.put("P_ID_RESERVACION", idReservacion);

        jdbcCall.execute(params);
    }
}
