package com.hotel.hotel.repository;

import com.hotel.hotel.model.Empleado;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import java.util.HashMap;
import org.springframework.stereotype.Repository;
import oracle.jdbc.OracleTypes;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;



import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;
import java.util.Map;

@Repository
public class EmpleadoRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private SimpleJdbcCall simpleJdbcCall;

    @PostConstruct
public void init() {
    this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate)
        .withCatalogName("EMPLEADO_PKG")
        .withProcedureName("LISTAR_EMPLEADOS_SP")
        .withoutProcedureColumnMetaDataAccess()
        .declareParameters(new SqlOutParameter("P_CURSOR", OracleTypes.CURSOR))
        .returningResultSet("P_CURSOR", new RowMapper<Empleado>() {
            @Override
            public Empleado mapRow(ResultSet rs, int rowNum) throws SQLException {
                Empleado e = new Empleado();
                e.setIdEmpleado(rs.getLong("ID_EMPLEADO"));
                e.setNombre(rs.getString("NOMBRE"));
                e.setCedula(rs.getInt("CEDULA"));
                e.setCorreo(rs.getString("CORREO"));
                e.setTelefono(rs.getInt("TELEFONO"));
                e.setFechaIngreso(rs.getDate("FECHA_INGRESO"));
                e.setNombreHotel(rs.getString("NOMBRE_HOTEL"));
                e.setNombrePuesto(rs.getString("NOMBRE_PUESTO"));
                return e;
            }
        });

    this.simpleJdbcCall.compile();
}

    public List<Empleado> listarEmpleados() {
    Map<String, Object> result = simpleJdbcCall.execute();
    return (List<Empleado>) result.get("P_CURSOR");
}
    
    public void insertarEmpleado(Empleado empleado) {
    SimpleJdbcCall simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate)
        .withCatalogName("EMPLEADO_PKG")
        .withProcedureName("INSERTAR_EMPLEADO_SP");

    Map<String, Object> params = new HashMap<>();
    params.put("P_FK_HOTEL", empleado.getFkHotel());
    params.put("P_FK_PUESTO", empleado.getFkPuesto());
    params.put("P_NOMBRE", empleado.getNombre());
    params.put("P_CEDULA", empleado.getCedula());
    params.put("P_CORREO", empleado.getCorreo());
    params.put("P_TELEFONO", empleado.getTelefono());
    params.put("P_FECHA_INGRESO", empleado.getFechaIngreso());

    simpleJdbcCall.execute(params);
}
public List<String> obtenerNombresHoteles() {
    return jdbcTemplate.queryForList("SELECT Nombre FROM Hotel", String.class);
}

public List<String> obtenerNombresPuestos() {
    return jdbcTemplate.queryForList("SELECT Nombre FROM Puesto", String.class);
}

public void actualizarEmpleado(Empleado empleado) {
    SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
        .withCatalogName("EMPLEADO_PKG")
        .withProcedureName("ACTUALIZAR_EMPLEADO_SP");

    Map<String, Object> params = new HashMap<>();
    params.put("P_ID_EMPLEADO", empleado.getIdEmpleado());
    params.put("P_FK_HOTEL", empleado.getFkHotel());
    params.put("P_FK_PUESTO", empleado.getFkPuesto());
    params.put("P_NOMBRE", empleado.getNombre());
    params.put("P_CEDULA", empleado.getCedula());
    params.put("P_CORREO", empleado.getCorreo());
    params.put("P_TELEFONO", empleado.getTelefono());
    params.put("P_FECHA_INGRESO", empleado.getFechaIngreso());

    jdbcCall.execute(params);
}

public Empleado obtenerEmpleadoPorId(Long idEmpleado) {
    SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
        .withCatalogName("EMPLEADO_PKG")
        .withProcedureName("OBTENER_EMPLEADO_POR_ID_SP")
        .withoutProcedureColumnMetaDataAccess()
        .declareParameters(
            new SqlParameter("P_ID_EMPLEADO", Types.NUMERIC),
            new SqlOutParameter("P_CURSOR", Types.REF_CURSOR, new RowMapper<Empleado>() {
                @Override
                public Empleado mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Empleado e = new Empleado();
                    e.setIdEmpleado(rs.getLong("ID_EMPLEADO"));
                    e.setNombre(rs.getString("NOMBRE"));
                    e.setCedula(rs.getInt("CEDULA"));
                    e.setCorreo(rs.getString("CORREO"));
                    e.setTelefono(rs.getInt("TELEFONO"));
                    e.setFechaIngreso(rs.getDate("FECHA_INGRESO"));
                    e.setFkHotel(rs.getInt("FK_HOTEL"));
                    e.setFkPuesto(rs.getInt("FK_PUESTO"));
                    return e;
                }
            })
        );

    Map<String, Object> result = jdbcCall.execute(new MapSqlParameterSource("P_ID_EMPLEADO", idEmpleado));
    List<Empleado> empleados = (List<Empleado>) result.get("P_CURSOR");
    return empleados.isEmpty() ? null : empleados.get(0);
}
public void eliminarEmpleado(Long idEmpleado) {
    SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
        .withCatalogName("EMPLEADO_PKG")
        .withProcedureName("ELIMINAR_EMPLEADO_SP");

    Map<String, Object> inParams = new HashMap<>();
    inParams.put("P_ID_EMPLEADO", idEmpleado);

    jdbcCall.execute(inParams);
}




}

