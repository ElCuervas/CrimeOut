package com.crimeout.main.repository;

import com.crimeout.main.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario,Integer> {
    Optional<Usuario> findByRut(String rut);

    List<Usuario> findByNombreContainingIgnoreCase(String nombre);
}
