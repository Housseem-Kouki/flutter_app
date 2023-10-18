package com.example.mobileapi.Services.ConfigTable;

import com.example.mobileapi.Entities.Configtable;
import com.example.mobileapi.Entities.Configtable;
import com.example.mobileapi.Entities.Product;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface IConfigTable {

List<Configtable> getTableColInfos(String table_name);
}
