package com.hotel.hotel.controller;

import com.hotel.hotel.model.Reservacion;
import com.hotel.hotel.repository.ReservacionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/reservaciones")
public class ReservacionController {

    @Autowired
    private ReservacionRepository reservacionRepository;

    // Listar reservaciones
    @GetMapping
    public String listarReservaciones(Model model) {
        List<Reservacion> reservaciones = reservacionRepository.listarReservaciones();
        model.addAttribute("reservaciones", reservaciones);
        return "reservaciones/reservaciones";
    }

    // Mostrar formulario de creación
    @GetMapping("/crear")
    public String mostrarFormularioCrear(Model model) {
        model.addAttribute("reservacion", new Reservacion());
        model.addAttribute("clientes", reservacionRepository.obtenerClientes());
        model.addAttribute("habitaciones", reservacionRepository.obtenerHabitaciones());
        model.addAttribute("hoteles", reservacionRepository.obtenerHoteles());
        model.addAttribute("promociones", reservacionRepository.obtenerPromociones());
        return "reservaciones/crearReservacion";
    }

    // Procesar creación
    @PostMapping("/crear")
    public String insertarReservacion(@ModelAttribute Reservacion reservacion, Model model) {
        try {
            reservacionRepository.insertarReservacion(reservacion);
            return "redirect:/reservaciones";
        } catch (Exception e) {
            model.addAttribute("error", "Error al insertar la reservación: " + e.getMessage());
            model.addAttribute("clientes", reservacionRepository.obtenerClientes());
            model.addAttribute("habitaciones", reservacionRepository.obtenerHabitaciones());
            model.addAttribute("hoteles", reservacionRepository.obtenerHoteles());
            model.addAttribute("promociones", reservacionRepository.obtenerPromociones());
            return "reservaciones/crearReservacion";
        }
    }

    // Mostrar formulario para editar
    @GetMapping("/editar/{id}")
    public String mostrarFormularioEditar(@PathVariable("id") Long id, Model model) {
        Reservacion reservacion = reservacionRepository.obtenerReservacionPorId(id);
        if (reservacion == null) {
            return "redirect:/reservaciones";
        }
        model.addAttribute("reservacion", reservacion);
        model.addAttribute("clientes", reservacionRepository.obtenerClientes());
        model.addAttribute("habitaciones", reservacionRepository.obtenerHabitaciones());
        model.addAttribute("hoteles", reservacionRepository.obtenerHoteles());
        model.addAttribute("promociones", reservacionRepository.obtenerPromociones());
        return "reservaciones/editarReservacion";
    }

    // Procesar edición
    @PostMapping("/editar")
    public String actualizarReservacion(@ModelAttribute Reservacion reservacion, Model model) {
        try {
            reservacionRepository.actualizarReservacion(reservacion);
            return "redirect:/reservaciones";
        } catch (Exception e) {
            model.addAttribute("error", "Error al actualizar la reservación: " + e.getMessage());
            model.addAttribute("clientes", reservacionRepository.obtenerClientes());
            model.addAttribute("habitaciones", reservacionRepository.obtenerHabitaciones());
            model.addAttribute("hoteles", reservacionRepository.obtenerHoteles());
            model.addAttribute("promociones", reservacionRepository.obtenerPromociones());
            return "reservaciones/editarReservacion";
        }
    }

    // Eliminar reservación
    @GetMapping("/eliminar/{id}")
    public String eliminarReservacion(@PathVariable("id") Long id) {
        try {
            reservacionRepository.eliminarReservacion(id);
        } catch (Exception e) {
            // Aquí puedes loguear o manejar el error si quieres
        }
        return "redirect:/reservaciones";
    }
}
