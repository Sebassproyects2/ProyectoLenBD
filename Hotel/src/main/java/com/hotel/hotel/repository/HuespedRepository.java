
package com.hotel.hotel.repository;

import com.hotel.hotel.model.Huesped;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;
import oracle.jdbc.OracleTypes;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
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
        // Inicialización del SimpleJdbcCall para el procedimiento LISTAR_HUESPEDES_SP
        this.listarHuespedesCall = new SimpleJdbcCall(jdbcTemplate)
            .withCatalogName("pkg_crud_huespedes")
            .withProcedureName("LISTAR_HUESPEDES_SP")
            .withoutProcedureColumnMetaDataAccess()
            .declareParameters(new SqlOutParameter("p_resultado", OracleTypes.CURSOR))
            .returningResultSet("p_resultado", new RowMapper<Huesped>() {
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
            });

        this.listarHuespedesCall.compile();
    }

    // Método para listar todos los huéspedes
    public List<Huesped> listarHuespedes() {
        Map<String, Object> result = listarHuespedesCall.execute();
        return (List<Huesped>) result.get("p_resultado");
    }

    // Método para agregar un nuevo huésped
    public void agregarHuesped(Huesped huesped) {
        SimpleJdbcCall insertCall = new SimpleJdbcCall(jdbcTemplate)
            .withCatalogName("pkg_crud_huespedes")
            .withProcedureName("agregarHuesped");

        Map<String, Object> params = new HashMap<>();
        params.put("v_id_huesped", huesped.getIdHuesped());
        params.put("v_nombre", huesped.getNombre());
        params.put("v_cedula", huesped.getCedula());
        params.put("v_apellido1", huesped.getApellido1());
        params.put("v_apellido2", huesped.getApellido2());
        params.put("v_correo", huesped.getCorreo());
        params.put("v_telefono", huesped.getTelefono());
        params.put("v_fecha_nacimiento", huesped.getFechaNacimiento());
        params.put("v_fecha_registro", huesped.getFechaRegistro());

        insertCall.execute(params);
    }

    public Huesped obtenerHuespedPorId(Long idHuesped) {
        SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
            .withCatalogName("pkg_crud_huespedes")
            .withProcedureName("HUESPED_OBETENER_SP")
            .withoutProcedureColumnMetaDataAccess()
            .declareParameters(
                new SqlParameter("p_id_huesped", Types.NUMERIC),
                new SqlOutParameter("p_resultado", OracleTypes.CURSOR)
            )
            .returningResultSet("resultado", new RowMapper<Huesped>() {
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
            });

        MapSqlParameterSource inParams = new MapSqlParameterSource()
            .addValue("p_id_huesped", idHuesped);

        Map<String, Object> result = call.execute(inParams);

        // 👇 Este "resultado" debe coincidir con el alias que diste en returningResultSet()
        List<Huesped> huespedes = (List<Huesped>) result.get("resultado");

        if (huespedes != null && !huespedes.isEmpty()) {
            return huespedes.get(0);
        } else {
            return null;
        }
    }


    // Método para modificar un huésped
    public void modificarHuesped(Huesped huesped) {
        SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
            .withCatalogName("pkg_crud_huespedes")
            .withProcedureName("HUESPED_MODIFICAR_SP");

        Map<String, Object> params = new HashMap<>();
        params.put("p_Id_Huesped", huesped.getIdHuesped());
        params.put("p_Nombre", huesped.getNombre());
        params.put("p_Cedula", huesped.getCedula());
        params.put("p_Apellido1", huesped.getApellido1());
        params.put("p_Apellido2", huesped.getApellido2());
        params.put("p_Correo", huesped.getCorreo());
        params.put("p_Telefono", huesped.getTelefono());
        params.put("p_Fecha_Nacimiento", huesped.getFechaNacimiento());
        params.put("p_Fecha_Registro", huesped.getFechaRegistro());

        call.execute(params);
    }

    // Método para eliminar un huésped
    public void eliminarHuesped(Long idHuesped) {
        SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
            .withCatalogName("pkg_crud_huespedes")
            .withProcedureName("HUESPED_BORRAR_SP");

        Map<String, Object> inParams = new HashMap<>();
        inParams.put("p_Id_Huesped", idHuesped);

        call.execute(inParams);
    }
}
