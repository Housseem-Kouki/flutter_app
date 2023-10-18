package com.example.mobileapi.Services.ConfigTable;

import com.example.mobileapi.Entities.Configtable;
import com.example.mobileapi.Entities.Configtable;
import com.example.mobileapi.Entities.Product;
import com.example.mobileapi.Repositorys.ConfigtableRepository;
import com.example.mobileapi.Repositorys.ProductRepository;
import com.example.mobileapi.Services.ProductService.IProductService;
import lombok.AllArgsConstructor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Random;

@Service
@AllArgsConstructor
public class ImpConfigTable implements IConfigTable {
    public ConfigtableRepository configTableRepository;

    @Override
    public List<Configtable> getTableColInfos(String table_name) {
        return configTableRepository.getTableColInfos(table_name);
    }
}
