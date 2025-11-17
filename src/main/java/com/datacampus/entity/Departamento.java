package com.datacampus.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "DEPARTAMENTO")
public class Departamento {

    @Id
    @Column(name = "ID_DEPARTAMENTO")
    private Long idDepartamento;

    @Column(name = "NOMBRE")
    private String nombre;
}
