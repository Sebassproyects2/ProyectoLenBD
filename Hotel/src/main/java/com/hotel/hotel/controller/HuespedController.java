
package com.hotel.hotel.controller;

import com.hotel.hotel.model.Huesped;
import com.hotel.hotel.repository.HuespedRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;

import java.util.List;


@Controller
public class HuespedController {
    
    @Autowired
    private HuespedRepository huespedRepository;

    // MOSTRAR HUESPEDES
    
    @GetMapping("/huespedes")
    public String listarHuespedes(Model model) {
        List<Huesped> huespedes = huespedRepository.listarHuespedes();
        model.addAttribute("huespedes", huespedes);
        return "huesped/mostrarHuesped";
    }

    // FORM
    
    @GetMapping("/huespedes/crear")
    public String mostrarFormularioCrear(Model model) {
        model.addAttribute("huesped", new Huesped());
        return "huesped/crearHuesped";
    }

    // INSERTAR
    
    @PostMapping("/huespedes/crear")
    public String insertarHuesped(@ModelAttribute Huesped huesped, Model model) {
        try {
            huespedRepository.insertarHuesped(huesped);
            return "redirect:/huespedes";
        } catch (Exception e) {
            model.addAttribute("error", "Error al insertar el huésped: " + e.getMessage());
            return "huesped/crearHuesped";
        }
    }

    // FORM DE ACTUALIZAR
    
    @GetMapping("/huespedes/editar/{id}")
    public String mostrarFormularioEditar(@PathVariable Long id, Model model) {
        Huesped huesped = huespedRepository.obtenerHuespedPorId(id);
        if (huesped == null) {
            return "redirect:/huespedes";
        }
        model.addAttribute("huesped", huesped);
        return "huesped/editarHuesped";
    }

    // ACTUALIZAR
    @PostMapping("/huespedes/editar")
    public String actualizarHuesped(@ModelAttribute Huesped huesped, Model model) {
        try {
            huespedRepository.actualizarHuesped(huesped);
            return "redirect:/huespedes";
        } catch (Exception e) {
            model.addAttribute("error", "Error al actualizar el huésped: " + e.getMessage());
            return "huesped/editarHuesped";
        }
    }

    // ELIMINAR
    
    @GetMapping("/huespedes/eliminar/{id}")
    public String eliminarHuesped(@PathVariable("id") Long id) {
        try {
            huespedRepository.eliminarHuesped(id);
        } catch (Exception e) {
        }
        return "redirect:/huespedes";
    }

}
