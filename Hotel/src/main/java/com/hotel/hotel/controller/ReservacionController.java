package com.hotel.hotel.controller;

import com.hotel.hotel.model.Reservacion;
import com.hotel.hotel.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/reservacion")
public class ReservacionController {

    @Autowired
    private ReservacionRepository reservacionRepository;

    @Autowired
    private HuespedRepository huespedRepository;

    @Autowired
    private HabitacionRepository habitacionRepository;

    @Autowired
    private HotelRepository hotelRepository;

    @Autowired
    private PromocionRepository promocionRepository;

    // Mostrar lista de reservaciones
    @GetMapping
    public String listarReservaciones(Model model) {
        List<Reservacion> reservaciones = reservacionRepository.listarReservaciones();
        model.addAttribute("reservaciones", reservaciones);
        return "reservacion/reservacion"; // Asegúrate de tener esta vista
    }

    // Mostrar formulario para nueva reservación
    @GetMapping("/crear")
    public String mostrarFormularioNuevaReservacion(Model model) {
        model.addAttribute("reservacion", new Reservacion());
        cargarDatosAuxiliares(model);
        return "reservacion/crearReservacion";
    }
    



    // Guardar nueva reservación
    @PostMapping("/guardar")
    public String guardarReservacion(@ModelAttribute Reservacion reservacion) {
        if (reservacion.getIdReservacion() != null) {
            reservacionRepository.actualizarReservacion(reservacion);
        } else {
            reservacionRepository.insertarReservacion(reservacion);
        }
        return "redirect:/reservacion";
    }

    // Editar reservación existente
    @GetMapping("/editar/{id}")
    public String editarReservacion(@PathVariable Long id, Model model) {
        Reservacion reservacion = reservacionRepository.obtenerReservacionPorId(id);
        if (reservacion != null) {
            model.addAttribute("reservacion", reservacion);
            cargarDatosAuxiliares(model);
            return "reservacion/editarReservacion";
        } else {
            return "redirect:/reservacion";
        }
    }
    
     @PostMapping("/editar")
    public String actualizarReservacion(@ModelAttribute Reservacion reservacion) {
        reservacionRepository.actualizarReservacion(reservacion);
        return "redirect:/reservacion";
    }

    // Eliminar reservación
    @GetMapping("/eliminar/{id}")
    public String eliminarReservacion(@PathVariable Long id) {
        reservacionRepository.eliminarReservacion(id);
        return "redirect:/reservacion";
    }

    // Método auxiliar para cargar combos en formulario
    private void cargarDatosAuxiliares(Model model) {
        model.addAttribute("huespedes", huespedRepository.listarHuespedes());
        model.addAttribute("habitaciones", habitacionRepository.listarHabitaciones());
        model.addAttribute("hoteles", hotelRepository.findAll());
        model.addAttribute("promociones", promocionRepository.listarPromociones());
    }
}
