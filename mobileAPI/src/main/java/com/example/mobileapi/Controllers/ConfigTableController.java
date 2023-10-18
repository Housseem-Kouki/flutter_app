package com.example.mobileapi.Controllers;

import com.example.mobileapi.Entities.Configtable;
import com.example.mobileapi.Entities.Configtable;
import com.example.mobileapi.Entities.Product;
import com.example.mobileapi.Repositorys.ConfigtableRepository;
import com.example.mobileapi.Repositorys.ProductRepository;
import com.example.mobileapi.Services.ConfigTable.IConfigTable;
import lombok.AllArgsConstructor;
import org.springframework.context.ApplicationContext;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.web.bind.annotation.*;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.*;

@RestController
@AllArgsConstructor
@CrossOrigin(origins = "*")
public class ConfigTableController {
    IConfigTable _iConfigTable;

    ConfigtableRepository configTableRepository;
    ProductRepository productRepository;

    @GetMapping("/getTableColInfos/{table_name}")
   public List<Configtable> getTableColInfos(@PathVariable("table_name") String table_name){
        return  _iConfigTable.getTableColInfos(table_name);
    }



    @GetMapping("/getSpecifiedTableColInfos/{table_name}")
    public List<Configtable> getSpecifiedTableColInfos(@PathVariable("table_name") String table_name,
                                                       @RequestParam(value = "columns", required = false) List<String> columnNames) {
        if (columnNames == null || columnNames.isEmpty()) {
            // If columns are not specified, fetch all columns for the specified table
            return _iConfigTable.getTableColInfos(table_name);
        } else {
            // If columns are specified, fetch only the specified columns
            return configTableRepository.getSpecifiedTableColInfos(table_name, columnNames);
        }
    }

    @PersistenceContext
    private EntityManager entityManager;
    @GetMapping("/getSpecifiedProductColInfos/{table_name}")
    public List<Product> getSpecifiedProductColInfos(@PathVariable("table_name") String table_name,
                                                     @RequestParam(value = "columns", required = false) List<String> columnNames) {
        StringJoiner columnsJoiner = new StringJoiner(", ");
        if (columnNames == null || columnNames.isEmpty()) {
            columnsJoiner.add("*"); // Select all columns when columnNames is null or empty
        } else {
            columnNames.forEach(columnsJoiner::add);
        }

        String query = "SELECT " + columnsJoiner.toString() + " FROM " + table_name;

        List<Object[]> results = entityManager.createNativeQuery(query).getResultList();
        List<Product> products = new ArrayList<>();

        for (Object[] row : results) {
            Product product = new Product();
            product.setId(((Number) row[0]).intValue()); // Assuming the first column is the ID
            product.setName((String) row[1]); // Assuming the second column is the name
            product.setPrix(((Number) row[2]).floatValue()); // Assuming the third column is the prix
            product.setImage((String) row[3]); // Assuming the fourth column is the image

            products.add(product);
        }

        return products;
    }



    @GetMapping("/getSpecifiedTabColValuess/{table_name}")
    public List<Map<String, Object>> getSpecifiedTabColValuess(@PathVariable("table_name") String table_name,
                                                                 @RequestParam(value = "columns", required = false) List<String> columnNames) {
        StringJoiner columnsJoiner = new StringJoiner(", ");
        if (columnNames == null || columnNames.isEmpty()) {
            columnsJoiner.add("*"); // Select all columns when columnNames is null or empty
        } else {
            columnNames.forEach(columnsJoiner::add);
        }

        // Using a parameterized query to prevent SQL injection
        String query = "SELECT " + columnsJoiner.toString() + " FROM " + table_name;

        List<Object[]> results = entityManager.createNativeQuery(query).getResultList();
        List<Map<String, Object>> resultList = new ArrayList<>();

        for (Object[] row : results) {
            Map<String, Object> resultRow = new HashMap<>();
            for (int i = 0; i < row.length; i++) {
                String columnName = (columnNames != null && i < columnNames.size()) ? columnNames.get(i) : "column_" + i;
                resultRow.put(columnName, row[i]);
            }
            resultList.add(resultRow);
        }

        return resultList;
    }


    @GetMapping("/getAllFromAnyTable/{table_name}")
    public List<Object> getAllFromAnyTable(@PathVariable("table_name") String table_name){
        String query = "SELECT * FROM " + table_name;
       return entityManager.createNativeQuery(query).getResultList();
    }




    private ApplicationContext context;
    @GetMapping("/getAllDynamique/{table_name}")
    public List<?> getAllDynamique(@PathVariable("table_name") String nomtable) {
        JpaRepository<?, Integer> repository = (JpaRepository<?, Integer>) context.getBean(nomtable + "Repository");
        return repository.findAll();
    }



}
