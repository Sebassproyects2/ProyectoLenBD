package com.hotel.hotel.repository;

import com.hotel.hotel.model.Huesped;
import jakarta.annotation.PostConstruct;
import oracle.jdbc.OracleTypes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import java.sql.Types;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class HuespedRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private SimpleJdbcCall listarHuespedesCall;

    @PostConstruct
    public void init() {
        listarHuespedesCall = new SimpleJdbcCall(jdbcTemplate)
            .withCatalogName("HUESPED_PKG")
            .withProcedureName("LISTAR_HUESPEDES_SP")
            .withoutProcedureColumnMetaDataAccess()
            .declareParameters(new SqlOutParameter("P_CURSOR", OracleTypes.CURSOR))
            .returningResultSet("P_CURSOR", new RowMapper<Huesped>() {
                @Override
                public Huesped mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Huesped h = new Huesped();
                    h.setIdHuesped(rs.getLong("ID_HUESPED"));
                    h.setNombre(rs.getString("NOMBRE"));
                    h.setCedula(rs.getInt("CEDULA"));
                    h.setApellido1(rs.getString("APELLIDO1"));
                    h.setApellido2(rs.getString("APELLIDO2"));
                    h.setCorreo(rs.getString("CORREO"));
                    h.setTelefono(rs.getInt("TELEFONO"));
                    h.setFechaNacimiento(rs.getDate("FECHA_NACIMIENTO"));
                    h.setFechaRegistro(rs.getDate("FECHA_REGISTRO"));
                    return h;
                }
            });

        listarHuespedesCall.compile();
    }

    public void insertarHuesped(Huesped huesped) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
            .withCatalogName("HUESPED_PKG")
            .withProcedureName("INSERTAR_HUESPED_SP");

        Map<String, Object> params = new HashMap<>();
        params.put("P_NOMBRE", huesped.getNombre());
        params.put("P_CEDULA", huesped.getCedula());
        params.put("P_APELLIDO1", huesped.getApellido1());
        params.put("P_APELLIDO2", huesped.getApellido2());
        params.put("P_CORREO", huesped.getCorreo());
        params.put("P_TELEFONO", huesped.getTelefono());
        params.put("P_FECHA_NACIMIENTO", huesped.getFechaNacimiento());
        params.put("P_FECHA_REGISTRO", huesped.getFechaRegistro());

        jdbcCall.execute(params);
    }

    public List<Huesped> listarHuespedes() {
        Map<String, Object> result = listarHuespedesCall.execute();
        return (List<Huesped>) result.get("P_CURSOR");
    }
    
    public void actualizarHuesped(Huesped huesped) {
    SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
        .withCatalogName("HUESPED_PKG")
        .withProcedureName("ACTUALIZAR_HUESPED_SP");

    Map<String, Object> params = new HashMap<>();
    params.put("P_ID_HUESPED", huesped.getIdHuesped());
    params.put("P_NOMBRE", huesped.getNombre());
    params.put("P_CEDULA", huesped.getCedula());
    params.put("P_APELLIDO1", huesped.getApellido1());
    params.put("P_APELLIDO2", huesped.getApellido2());
    params.put("P_CORREO", huesped.getCorreo());
    params.put("P_TELEFONO", huesped.getTelefono());
    params.put("P_FECHA_NACIMIENTO", huesped.getFechaNacimiento());
    params.put("P_FECHA_REGISTRO", huesped.getFechaRegistro());

    jdbcCall.execute(params);
}
    
    public Huesped obtenerHuespedPorId(Long idHuesped) {
    SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
        .withCatalogName("HUESPED_PKG")
        .withProcedureName("OBTENER_HUESPED_POR_ID_SP")
        .withoutProcedureColumnMetaDataAccess()
        .declareParameters(
            new SqlParameter("P_ID_HUESPED", Types.NUMERIC),
            new SqlOutParameter("P_CURSOR", OracleTypes.CURSOR, new RowMapper<Huesped>() {
                @Override
                public Huesped mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Huesped h = new Huesped();
                    h.setIdHuesped(rs.getLong("ID_HUESPED"));
                    h.setNombre(rs.getString("NOMBRE"));
                    h.setApellido1(rs.getString("APELLIDO1"));
                    h.setApellido2(rs.getString("APELLIDO2"));
                    h.setCedula(rs.getInt("CEDULA"));
                    h.setCorreo(rs.getString("CORREO"));
                    h.setTelefono(rs.getInt("TELEFONO"));
                    h.setFechaNacimiento(rs.getDate("FECHA_NACIMIENTO"));
                    h.setFechaRegistro(rs.getDate("FECHA_REGISTRO"));
                    return h;
                }
            })
        );

    Map<String, Object> result = jdbcCall.execute(new MapSqlParameterSource("P_ID_HUESPED", idHuesped));
    List<Huesped> huespedes = (List<Huesped>) result.get("P_CURSOR");
    return huespedes.isEmpty() ? null : huespedes.get(0);
}
    public void eliminarHuesped(Long idHuesped) {
    SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
        .withCatalogName("HUESPED_PKG")
        .withProcedureName("ELIMINAR_HUESPED_SP");

    Map<String, Object> inParams = new HashMap<>();
    inParams.put("P_ID_HUESPED", idHuesped);

    jdbcCall.execute(inParams);
}

    
}

