package com.hotel.hotel.controller;

import com.hotel.hotel.model.Huesped;
import com.hotel.hotel.repository.HuespedRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/huespedes")
public class HuespedController {

    @Autowired
    private HuespedRepository huespedRepository;

   
    @GetMapping
    public String listarHuespedes(Model model) {
        List<Huesped> huespedes = huespedRepository.listarHuespedes();
        model.addAttribute("huespedes", huespedes);
        return "huesped/mostrarHuesped";
    }

    
    @GetMapping("/crear")
    public String mostrarFormulario(Model model) {
        model.addAttribute("huesped", new Huesped());
        return "huesped/crearHuesped";
    }

 
    @PostMapping("/crear")
    public String insertarHuesped(@ModelAttribute Huesped huesped, Model model) {
        try {
            huespedRepository.insertarHuesped(huesped);
            return "redirect:/huespedes";
        } catch (Exception e) {
            model.addAttribute("error", "Error al insertar huésped: " + e.getMessage());
            return "huesped/crearHuesped";
        }
    }
    
  
@GetMapping("/editar/{id}")
public String mostrarFormularioEditar(@PathVariable Long id, Model model) {
    Huesped huesped = huespedRepository.obtenerHuespedPorId(id);
    if (huesped == null) {
        return "redirect:/huespedes";
    }
    model.addAttribute("huesped", huesped);
    return "huesped/editarHuesped"; // Asegúrate de tener esta vista
}


@PostMapping("/editar")
public String actualizarHuesped(@ModelAttribute Huesped huesped, Model model) {
    try {
        huespedRepository.actualizarHuesped(huesped);
        return "redirect:/huespedes";
    } catch (Exception e) {
        model.addAttribute("error", "Error al actualizar huésped: " + e.getMessage());
        return "huesped/editarHuesped";
    }
}

// Eliminar huésped
@GetMapping("/eliminar/{id}")
public String eliminarHuesped(@PathVariable("id") Long id) {
    try {
        huespedRepository.eliminarHuesped(id);
    } catch (Exception e) {
        System.out.println("Error al eliminar huésped: " + e.getMessage());
    }
    return "redirect:/huespedes";
}



}

