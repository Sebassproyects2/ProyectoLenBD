
package com.hotel.hotel.controller;

import com.hotel.hotel.model.Hotel;
import com.hotel.hotel.service.HotelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/hoteles")
public class HotelController {

    private final HotelService hotelService;

    @Autowired
    public HotelController(HotelService hotelService) {
        this.hotelService = hotelService;
    }

    @GetMapping("/listar")
    public String listarHoteles(Model model) {
        List<Hotel> hoteles = hotelService.obtenerTodosHoteles();
        model.addAttribute("hoteles", hoteles);
        return "hoteles/listar-hoteles"; // Especifica la ruta dentro de templates
    }

    @GetMapping("/nuevo")
    public String mostrarFormularioNuevoHotel(Model model) {
        model.addAttribute("hotel", new Hotel());
        return "hoteles/nuevo-hotel"; // Especifica la ruta dentro de templates
    }

    @PostMapping("/guardar")
    public String guardarHotel(@ModelAttribute Hotel hotel) {
        hotelService.agregarHotel(hotel);
        return "redirect:/hoteles/listar";
    }

    @GetMapping("/editar/{id}")
    public String mostrarFormularioEditarHotel(@PathVariable Long id, Model model) {
        Optional<Hotel> hotel = hotelService.obtenerHotelPorId(id);
        hotel.ifPresent(h -> model.addAttribute("hotel", h));
        return "hoteles/editar-hotel"; // Especifica la ruta dentro de templates
    }

    @PostMapping("/actualizar")
    public String actualizarHotel(@ModelAttribute Hotel hotel) {
        hotelService.actualizarHotel(hotel);
        return "redirect:/hoteles/listar";
    }

    @GetMapping("/eliminar/{id}")
    public String eliminarHotel(@PathVariable Long id) {
        hotelService.eliminarHotel(id);
        return "redirect:/hoteles/listar";
    }
}