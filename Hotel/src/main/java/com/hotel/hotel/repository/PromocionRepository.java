package com.hotel.hotel.repository;

import com.hotel.hotel.model.Promocion;
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
public class PromocionRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private SimpleJdbcCall listarPromocionesCall;

    @PostConstruct
    public void init() {
        listarPromocionesCall = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("PROMOCION_PKG")
                .withProcedureName("LISTAR_PROMOCIONES_SP")
                .withoutProcedureColumnMetaDataAccess()
                .declareParameters(new SqlOutParameter("P_CURSOR", OracleTypes.CURSOR))
                .returningResultSet("P_CURSOR", new RowMapper<Promocion>() {
                    @Override
                    public Promocion mapRow(ResultSet rs, int rowNum) throws SQLException {
                        Promocion p = new Promocion();
                        p.setIdPromocion(rs.getLong("ID_PROMOCION"));
                        p.setFkHotel(rs.getInt("FK_HOTEL"));
                        p.setDescripcion(rs.getString("DESCRIPCION"));
                        p.setFechaInicio(rs.getDate("FECHA_INICIO"));
                        p.setFechaFin(rs.getDate("FECHA_FIN"));
                        return p;
                    }
                });

        listarPromocionesCall.compile();
    }

    public List<Promocion> listarPromociones() {
        Map<String, Object> result = listarPromocionesCall.execute();
        return (List<Promocion>) result.get("P_CURSOR");
    }
}
