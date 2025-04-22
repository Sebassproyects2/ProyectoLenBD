package com.hotel.hotel.controller;


import com.hotel.hotel.model.Empleado;
import com.hotel.hotel.repository.EmpleadoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;

import java.util.List;

@Controller
public class EmpleadoController {

    @Autowired
    private EmpleadoRepository empleadoRepository;

    // Listar empleados
    @GetMapping("/empleados")
    public String listarEmpleados(Model model) {
        List<Empleado> empleados = empleadoRepository.listarEmpleados();
        model.addAttribute("empleados", empleados);
        return "empleados/empleados";
    }

    // Formulario de creación
    @GetMapping("/empleados/crear")
    public String mostrarFormularioCrear(Model model) {
        model.addAttribute("empleado", new Empleado());
        model.addAttribute("hoteles", empleadoRepository.obtenerHoteles());
        model.addAttribute("puestos", empleadoRepository.obtenerPuestos());

        return "empleados/crearEmpleado";
    }

    // Procesar creación
    @PostMapping("/empleados/crear")
    public String insertarEmpleado(@ModelAttribute Empleado empleado, Model model) {
        try {
            empleadoRepository.insertarEmpleado(empleado);
            return "redirect:/empleados";
        } catch (Exception e) {
            model.addAttribute("error", "Error al insertar el empleado: " + e.getMessage());
            model.addAttribute("hoteles", empleadoRepository.obtenerHoteles());
            model.addAttribute("puestos", empleadoRepository.obtenerPuestos());

            return "empleados/crearEmpleado";
        }
    }

    // Formulario para editar
    @GetMapping("/empleados/editar/{id}")
    public String mostrarFormularioEditar(@PathVariable Long id, Model model) {
        Empleado empleado = empleadoRepository.obtenerEmpleadoPorId(id);
        if (empleado == null) {
            return "redirect:/empleados";
        }
        model.addAttribute("empleado", empleado);
        model.addAttribute("hoteles", empleadoRepository.obtenerHoteles());
        model.addAttribute("puestos", empleadoRepository.obtenerPuestos());
        return "empleados/editarEmpleado"; // usa esta vista
    }

    // Procesar edición
    @PostMapping("/empleados/editar")
    public String actualizarEmpleado(@ModelAttribute Empleado empleado, Model model) {
        try {
            empleadoRepository.actualizarEmpleado(empleado);
            return "redirect:/empleados";
        } catch (Exception e) {
            model.addAttribute("error", "Error al actualizar el empleado: " + e.getMessage());
            model.addAttribute("hoteles", empleadoRepository.obtenerHoteles());
            model.addAttribute("puestos", empleadoRepository.obtenerPuestos());

            return "empleados/editarEmpleado";
        }
    }
    
    @GetMapping("/empleados/eliminar/{id}")
public String eliminarEmpleado(@PathVariable("id") Long id) {
    try {
        empleadoRepository.eliminarEmpleado(id);
    } catch (Exception e) {
        // Puedes agregar logs o manejar errores aquí si lo deseas
    }
    return "redirect:/empleados";
}

}

