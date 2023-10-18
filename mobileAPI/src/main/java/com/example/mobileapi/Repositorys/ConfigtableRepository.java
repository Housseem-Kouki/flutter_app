package com.example.mobileapi.Repositorys;

import com.example.mobileapi.Entities.Configtable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ConfigtableRepository extends JpaRepository<Configtable, Integer> {

    @Query(value = "SELECT column_name AS column_name ,  data_type AS type , character_maximum_length AS taille " +
            " FROM information_schema.columns WHERE table_name = :table_name",
            nativeQuery = true)
    List<Configtable> getTableColInfos(String table_name);

    @Query(value = "SELECT column_name AS column_name, data_type AS type, character_maximum_length AS taille " +
            "FROM information_schema.columns WHERE table_name = :table_name AND column_name IN :column_names",
            nativeQuery = true)
    List<Configtable> getSpecifiedTableColInfos(@Param("table_name") String table_name, @Param("column_names") List<String> column_names);
}