package com.example.mobileapi.Services.ProductService;

import com.example.mobileapi.Entities.Product;
import com.example.mobileapi.Repositorys.ProductRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Random;

@Service
@AllArgsConstructor
public class ImpProductService implements IProductService{

    ProductRepository productRepository;
    private final Path rootLocation = Paths.get("upload-dir");
    @Override
    public List<Product> getAllProduct() {
        return productRepository.findAll();
    }

    @Override
    public Product addProduct(Product product, MultipartFile image) {
        try {
            String fileName = Integer.toString(new Random().nextInt(1000000000));
            String ext = image.getOriginalFilename().substring(image.getOriginalFilename().lastIndexOf('.'));
            String name = image.getOriginalFilename().substring(0, image.getOriginalFilename().lastIndexOf('.'));
            String original = ext + name + fileName;

            Files.copy(image.getInputStream(), this.rootLocation.resolve(original));
            product.setImage(original);
        } catch (Exception e) {
            throw new RuntimeException("Failed to save image: " + e.getMessage());
        }
        return productRepository.save(product);
    }
}
