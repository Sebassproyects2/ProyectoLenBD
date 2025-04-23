
package com.hotel.hotel.service;


import com.hotel.hotel.model.Hotel;
import com.hotel.hotel.repository.HotelRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class HotelService {

    private final HotelRepository hotelRepository;

    @Autowired
    public HotelService(HotelRepository hotelRepository) {
        this.hotelRepository = hotelRepository;
    }

    public void agregarHotel(Hotel hotel) {
        hotelRepository.agregarHoteles(
                hotel.getIdHotel(),
                hotel.getNombre(),
                hotel.getCiudad(),
                hotel.getCanton(),
                hotel.getDistrito(),
                hotel.getDetalleDireccion(),
                hotel.getTelefono(),
                hotel.getNumeroPisos()
        );
    }

    public Optional<Hotel> obtenerHotelPorId(Long id) {
        return hotelRepository.verHotelPorId(id);
    }

    public List<Hotel> obtenerTodosHoteles() {
        return hotelRepository.findAll();
    }

    public void actualizarHotel(Hotel hotel) {
        hotelRepository.actualizarHotel(
                hotel.getIdHotel(),
                hotel.getNombre(),
                hotel.getCiudad(),
                hotel.getCanton(),
                hotel.getDistrito(),
                hotel.getDetalleDireccion(),
                hotel.getTelefono(),
                hotel.getNumeroPisos()
        );
    }

    public void eliminarHotel(Long id) {
        hotelRepository.eliminarHotel(id);
    }
}