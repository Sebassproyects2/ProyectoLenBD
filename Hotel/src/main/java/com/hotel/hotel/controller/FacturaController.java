package com.hotel.hotel.controller;

import com.hotel.hotel.model.Factura;
import com.hotel.hotel.repository.FacturaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/facturas")
public class FacturaController {

    @Autowired
    private FacturaRepository facturaRepository;

    @GetMapping
    public String listarFacturas(Model model) {
        List<Factura> facturas = facturaRepository.listarFacturas();
        model.addAttribute("facturas", facturas);
        return "factura/mostrarFactura";
    }

    @GetMapping("/crear")
    public String mostrarFormulario(Model model) {
        model.addAttribute("factura", new Factura());
        return "factura/crearFactura";
    }

    @PostMapping("/crear")
    public String insertarFactura(@ModelAttribute Factura factura, Model model) {
        try {
            facturaRepository.insertarFactura(factura);
            return "redirect:/facturas";
        } catch (Exception e) {
            model.addAttribute("error", "Error al insertar factura: " + e.getMessage());
            return "factura/crearFactura";
        }
    }

    @GetMapping("/editar/{id}")
    public String mostrarFormularioEditar(@PathVariable Long id, Model model) {
        Factura factura = facturaRepository.obtenerFacturaPorId(id);
        if (factura == null) {
            return "redirect:/facturas";
        }
        model.addAttribute("factura", factura);
        return "factura/editarFactura";
    }
    
    @PostMapping("/editar/{id}")
    public String actualizarFactura(@PathVariable Long id, @ModelAttribute Factura factura, Model model) {
        try {
            factura.setIdFactura(id);
            facturaRepository.actualizarFactura(factura);
            return "redirect:/facturas";
        } catch (Exception e) {
            model.addAttribute("error", "Error al actualizar factura: " + e.getMessage());
            return "factura/editarFactura";
        }
    }


    @GetMapping("/eliminar/{id}")
    public String eliminarFactura(@PathVariable("id") Long id) {
        try {
            facturaRepository.eliminarFactura(id);
        } catch (Exception e) {
            System.out.println("Error al eliminar factura: " + e.getMessage());
        }
        return "redirect:/facturas";
    }
}
