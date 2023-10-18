package com.example.mobileapi.Services.ProductService;

import com.example.mobileapi.Entities.Product;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.List;

public interface IProductService {

    public List<Product> getAllProduct();
    public Product addProduct(Product product  , MultipartFile image);

}
