package com.datacampus.controller;


import com.datacampus.repository.DepartamentoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

    @Autowired
    private DepartamentoRepository departamentoRepository;

    @GetMapping("/departamentos")
    public Object getDepartamentos() {
        try {
            return departamentoRepository.findAll();
        } catch (Exception e) {
            return e.getMessage();
        }
    }

    @GetMapping("/ping")
    public String ping() {
        return "API DataCampus funcionando!";
    }
}
