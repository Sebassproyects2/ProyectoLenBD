package com.hotel.hotel.repository;

import com.hotel.hotel.model.Factura;
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

import java.sql.Types;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class FacturaRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private SimpleJdbcCall listarFacturasCall;

    @PostConstruct
    public void init() {
        listarFacturasCall = new SimpleJdbcCall(jdbcTemplate)
            .withCatalogName("FACTURA_PKG")
            .withProcedureName("LISTAR_FACTURAS_SP")
            .withoutProcedureColumnMetaDataAccess()
            .declareParameters(new SqlOutParameter("P_CURSOR", OracleTypes.CURSOR))
            .returningResultSet("P_CURSOR", new RowMapper<Factura>() {
                @Override
                public Factura mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Factura f = new Factura();
                    f.setIdFactura(rs.getLong("ID_FACTURA"));
                    f.setFkReservacion(rs.getLong("FK_RESERVACION"));
                    f.setFechaEmision(rs.getDate("FECHA_EMISION"));
                    f.setDescuento(rs.getDouble("DESCUENTO"));
                    f.setMetodoPago(rs.getString("METODO_PAGO"));
                    f.setMonto(rs.getDouble("MONTO"));
                    f.setEstado(rs.getString("ESTADO"));
                    return f;
                }
            });

        listarFacturasCall.compile();
    }

    public List<Factura> listarFacturas() {
        Map<String, Object> result = listarFacturasCall.execute();
        return (List<Factura>) result.get("P_CURSOR");
    }

    public void insertarFactura(Factura factura) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
            .withCatalogName("FACTURA_PKG")
            .withProcedureName("INSERTAR_FACTURA_SP");

        Map<String, Object> params = new HashMap<>();
        params.put("P_FK_RESERVACION", factura.getFkReservacion());
        params.put("P_FECHA_EMISION", factura.getFechaEmision());
        params.put("P_DESCUENTO", factura.getDescuento());
        params.put("P_METODO_PAGO", factura.getMetodoPago());
        params.put("P_MONTO", factura.getMonto());
        params.put("P_ESTADO", factura.getEstado());

        jdbcCall.execute(params);
    }

    public void actualizarFactura(Factura factura) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
            .withCatalogName("FACTURA_PKG")
            .withProcedureName("ACTUALIZAR_FACTURA_SP");

        Map<String, Object> params = new HashMap<>();
        params.put("P_ID_FACTURA", factura.getIdFactura());
        params.put("P_FK_RESERVACION", factura.getFkReservacion());
        params.put("P_FECHA_EMISION", factura.getFechaEmision());
        params.put("P_DESCUENTO", factura.getDescuento());
        params.put("P_METODO_PAGO", factura.getMetodoPago());
        params.put("P_MONTO", factura.getMonto());
        params.put("P_ESTADO", factura.getEstado());

        jdbcCall.execute(params);
    }

    public Factura obtenerFacturaPorId(Long idFactura) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
            .withCatalogName("FACTURA_PKG")
            .withProcedureName("OBTENER_FACTURA_POR_ID_SP")
            .withoutProcedureColumnMetaDataAccess()
            .declareParameters(
                new SqlParameter("P_ID_FACTURA", Types.NUMERIC),
                new SqlOutParameter("P_CURSOR", OracleTypes.CURSOR, new RowMapper<Factura>() {
                    @Override
                    public Factura mapRow(ResultSet rs, int rowNum) throws SQLException {
                        Factura f = new Factura();
                        f.setIdFactura(rs.getLong("ID_FACTURA"));
                        f.setFkReservacion(rs.getLong("FK_RESERVACION"));
                        f.setFechaEmision(rs.getDate("FECHA_EMISION"));
                        f.setDescuento(rs.getDouble("DESCUENTO"));
                        f.setMetodoPago(rs.getString("METODO_PAGO"));
                        f.setMonto(rs.getDouble("MONTO"));
                        f.setEstado(rs.getString("ESTADO"));
                        return f;
                    }
                })
            );

        Map<String, Object> result = jdbcCall.execute(new MapSqlParameterSource("P_ID_FACTURA", idFactura));
        List<Factura> facturas = (List<Factura>) result.get("P_CURSOR");
        return facturas.isEmpty() ? null : facturas.get(0);
    }

    public void eliminarFactura(Long idFactura) {
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
            .withCatalogName("FACTURA_PKG")
            .withProcedureName("ELIMINAR_FACTURA_SP");

        Map<String, Object> inParams = new HashMap<>();
        inParams.put("P_ID_FACTURA", idFactura);

        jdbcCall.execute(inParams);
    }
}