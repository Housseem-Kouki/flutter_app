package com.example.mobileapi.Repositorys;


import com.example.mobileapi.Entities.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ProductRepository extends JpaRepository<Product, Integer> {
/*
    @Query(value = "SELECT * FROM :table_name ;",
            nativeQuery = true)
    List<Product> getSpecifiedProductColInfos(@Param("table_name") String table_name, @Param("column_names") List<String> column_names);
*/
}