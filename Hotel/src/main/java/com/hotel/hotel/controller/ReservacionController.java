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

    @GetMapping
    public String listarReservaciones(Model model) {
        List<Reservacion> reservaciones = reservacionRepository.listarReservaciones();
        model.addAttribute("reservaciones", reservaciones);
        return "reservacion/reservacion";
    }

    @GetMapping("/crear")
    public String mostrarFormularioCrear(Model model) {
        model.addAttribute("reservacion", new Reservacion());
        return "reservacion/crearReservacion";
    }

    @PostMapping("/crear")
    public String insertarReservacion(@ModelAttribute Reservacion reservacion, Model model) {
        try {
            reservacionRepository.insertarReservacion(reservacion);
            return "redirect:/reservaciones";
        } catch (Exception e) {
            model.addAttribute("error", "Error al insertar reservación: " + e.getMessage());
            return "reservacion/crearReservacion";
        }
    }

    @GetMapping("/editar/{id}")
    public String mostrarFormularioEditar(@PathVariable Long id, Model model) {
        Reservacion reservacion = reservacionRepository.obtenerReservacionPorId(id);
        if (reservacion == null) {
            return "redirect/reservaciones";
        }
        model.addAttribute("reservacion", reservacion);
        return "reservacion/editarReservacion";
    }

    @PostMapping("/editar")
    public String actualizarReservacion(@ModelAttribute Reservacion reservacion, Model model) {
        try {
            reservacionRepository.actualizarReservacion(reservacion);
            return "redirect:/reservaciones";
        } catch (Exception e) {
            model.addAttribute("error", "Error al actualizar reservación: " + e.getMessage());
            return "reservacion/editarReservacion";
        }
    }

    @GetMapping("/eliminar/{id}")
    public String eliminarReservacion(@PathVariable("id") Long id) {
        try {
            reservacionRepository.eliminarReservacion(id);
        } catch (Exception e) {
            System.out.println("Error al eliminar reservación: " + e.getMessage());
        }
        return "redirect:/reservaciones";
    }
}