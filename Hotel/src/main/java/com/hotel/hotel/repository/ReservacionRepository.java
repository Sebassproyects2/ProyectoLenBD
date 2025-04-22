package com.hotel.hotel.repository;

import com.hotel.hotel.model.Reservacion;
import com.hotel.hotel.model.OpcionSelect;

import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.stereotype.Repository;

import oracle.jdbc.OracleTypes;

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

    private SimpleJdbcCall simpleJdbcCall;

    @PostConstruct
    public void init() {
        this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate)
            .withCatalogName("RESERVACION_PKG")
            .withProcedureName("LISTAR_RESERVACIONES_SP")
            .withoutProcedureColumnMetaDataAccess()
            .declareParameters(new SqlOutParameter("P_CURSOR", OracleTypes.CURSOR))
            .returningResultSet("P_CURSOR", new RowMapper<Reservacion>() {
                @Override
                public Reservacion mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Reservacion r = new Reservacion();
                    r.setIdReservacion(rs.getLong("ID_RESERVACION"));
                    r.setFechaInicio(rs.getDate("FECHA_INICIO"));
                    r.setFechaFin(rs.getDate("FECHA_FIN"));
                    r.setCantidadPersonas(rs.getInt("CANTIDAD_PERSONAS"));
                    r.setNombreCliente(rs.getString("NOMBRE_CLIENTE"));
                    r.setNombreHabitacion(rs.getString("NOMBRE_HABITACION"));
                    return r;
                }
            });

        this.simpleJdbcCall.compile();
    }

    public List<Reservacion> listarReservaciones() {
        Map<String, Object> result = simpleJdbcCall.execute();
        return (List<Reservacion>) result.get("P_CURSOR");
    }

    public void insertarReservacion(Reservacion reservacion) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
            .withCatalogName("RESERVACION_PKG")
            .withProcedureName("INSERTAR_RESERVACION_SP");

        Map<String, Object> params = new HashMap<>();
        params.put("P_FK_CLIENTE", reservacion.getFkCliente());
        params.put("P_FK_HABITACION", reservacion.getFkHabitacion());
        params.put("P_FECHA_INICIO", reservacion.getFechaInicio());
        params.put("P_FECHA_FIN", reservacion.getFechaFin());
        params.put("P_CANTIDAD_PERSONAS", reservacion.getCantidadPersonas());

        jdbcCall.execute(params);
    }

    public void actualizarReservacion(Reservacion reservacion) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
            .withCatalogName("RESERVACION_PKG")
            .withProcedureName("ACTUALIZAR_RESERVACION_SP");

        Map<String, Object> params = new HashMap<>();
        params.put("P_ID_RESERVACION", reservacion.getIdReservacion());
        params.put("P_FK_CLIENTE", reservacion.getFkCliente());
        params.put("P_FK_HABITACION", reservacion.getFkHabitacion());
        params.put("P_FECHA_INICIO", reservacion.getFechaInicio());
        params.put("P_FECHA_FIN", reservacion.getFechaFin());
        params.put("P_CANTIDAD_PERSONAS", reservacion.getCantidadPersonas());

        jdbcCall.execute(params);
    }

    public Reservacion obtenerReservacionPorId(Long idReservacion) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
            .withCatalogName("RESERVACION_PKG")
            .withProcedureName("OBTENER_RESERVACION_POR_ID_SP")
            .withoutProcedureColumnMetaDataAccess()
            .declareParameters(
                new SqlParameter("P_ID_RESERVACION", Types.NUMERIC),
                new SqlOutParameter("P_CURSOR", OracleTypes.CURSOR, new RowMapper<Reservacion>() {
                    @Override
                    public Reservacion mapRow(ResultSet rs, int rowNum) throws SQLException {
                        Reservacion r = new Reservacion();
                        r.setIdReservacion(rs.getLong("ID_RESERVACION"));
                        r.setFkCliente(rs.getInt("FK_CLIENTE"));
                        r.setFkHabitacion(rs.getInt("FK_HABITACION"));
                        r.setFechaInicio(rs.getDate("FECHA_INICIO"));
                        r.setFechaFin(rs.getDate("FECHA_FIN"));
                        r.setCantidadPersonas(rs.getInt("CANTIDAD_PERSONAS"));
                        return r;
                    }
                })
            );

        Map<String, Object> result = jdbcCall.execute(new MapSqlParameterSource("P_ID_RESERVACION", idReservacion));
        List<Reservacion> reservaciones = (List<Reservacion>) result.get("P_CURSOR");
        return reservaciones.isEmpty() ? null : reservaciones.get(0);
    }

    public void eliminarReservacion(Long idReservacion) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
            .withCatalogName("RESERVACION_PKG")
            .withProcedureName("ELIMINAR_RESERVACION_SP");

        Map<String, Object> inParams = new HashMap<>();
        inParams.put("P_ID_RESERVACION", idReservacion);

        jdbcCall.execute(inParams);
    }

    public List<OpcionSelect> obtenerClientes() {
        String sql = "SELECT Id_Cliente, Nombre FROM Cliente";
        return jdbcTemplate.query(sql, (rs, rowNum) ->
            new OpcionSelect(rs.getInt("Id_Cliente"), rs.getString("Nombre"))
        );
    }

    public List<OpcionSelect> obtenerHabitaciones() {
        String sql = "SELECT Id_Habitacion, Nombre FROM Habitacion";
        return jdbcTemplate.query(sql, (rs, rowNum) ->
            new OpcionSelect(rs.getInt("Id_Habitacion"), rs.getString("Nombre"))
        );
    }
}
