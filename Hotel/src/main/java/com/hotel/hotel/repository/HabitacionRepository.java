package com.hotel.hotel.repository;

import com.hotel.hotel.model.Habitacion;
import jakarta.annotation.PostConstruct;
import oracle.jdbc.OracleTypes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Repository
public class HabitacionRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private SimpleJdbcCall listarHabitacionesCall;

    @PostConstruct
    public void init() {
        listarHabitacionesCall = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("HABITACION_PKG")
                .withProcedureName("LISTAR_HABITACIONES_SP")
                .withoutProcedureColumnMetaDataAccess()
                .declareParameters(new SqlOutParameter("P_CURSOR", OracleTypes.CURSOR))
                .returningResultSet("P_CURSOR", new RowMapper<Habitacion>() {
                    @Override
                    public Habitacion mapRow(ResultSet rs, int rowNum) throws SQLException {
                        Habitacion h = new Habitacion();
                        h.setIdHabitacion(rs.getLong("ID_HABITACION"));
                        h.setFkTipoHabitacion(rs.getInt("FK_TIPOHABITACION"));
                        h.setNumeroHabitacion(rs.getInt("NUMERO_HABITACION"));
                        h.setDescripcion(rs.getString("DESCRIPCION"));
                        h.setEstado(rs.getString("ESTADO"));
                        return h;
                    }
                });

        listarHabitacionesCall.compile();
    }

    public List<Habitacion> listarHabitaciones() {
        Map<String, Object> result = listarHabitacionesCall.execute();
        return (List<Habitacion>) result.get("P_CURSOR");
    }
}
