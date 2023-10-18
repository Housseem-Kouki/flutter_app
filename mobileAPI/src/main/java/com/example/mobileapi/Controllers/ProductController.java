package com.example.mobileapi.Controllers;

import com.example.mobileapi.Dto.ProductRequest;
import com.example.mobileapi.Entities.Product;
import com.example.mobileapi.Repositorys.ProductRepository;
import com.example.mobileapi.Services.ProductService.IProductService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Random;

@RestController
@AllArgsConstructor
public class ProductController {

 IProductService iProductService;
 ProductRepository productRepository;

 @GetMapping("/getAllProduct")
   public List<Product> getAllProduct(){
     return iProductService.getAllProduct();
   }


    private final Path rootLocation = Paths.get("upload-dir");

    @PostMapping("/addProduct")
    public String addProduct(@RequestParam(value = "name") String nameP ,
                              @RequestParam(value = "prix") float prix ,
                              @RequestParam(value = "image") MultipartFile image){
        Product product = new Product();
        product.setName(nameP);
        product.setPrix(prix);
        try {
            String fileName = Integer.toString(new Random().nextInt(1000000000));
            String ext = image.getOriginalFilename().substring(image.getOriginalFilename().lastIndexOf('.'));
            String name = image.getOriginalFilename().substring(0, image.getOriginalFilename().lastIndexOf('.'));
            String original = fileName+ext ;
            Path destinationFile = Paths.get("C:\\Users\\Kouki\\StudioProjects\\first_app\\images");

            Files.copy(image.getInputStream(), destinationFile.resolve(original));
            product.setImage(original);
        } catch (Exception e) {
            throw new RuntimeException("Failed to save image: " + e.getMessage());
        }
        productRepository.save(product);
        return "image uploaded";
    }




    @PostMapping("/addProduct2")
    public String addProduct2(@RequestBody ProductRequest productRequest,
                              @RequestParam(value = "image",required = false) MultipartFile image){
        Product product = new Product();
        product.setName(productRequest.getName());
        product.setPrix(productRequest.getPrix());
        try {
            String fileName = Integer.toString(new Random().nextInt(1000000000));
            String ext = image.getOriginalFilename().substring(image.getOriginalFilename().lastIndexOf('.'));
            //String name = image.getOriginalFilename().substring(0, image.getOriginalFilename().lastIndexOf('.'));
            String original = fileName+'.'+ext;
            Path destinationFile = Paths.get("C:\\Users\\Kouki\\Desktop\\khdemtyfront");
            Files.copy(image.getInputStream(), destinationFile.resolve(original));
            product.setImage(original);
        } catch (Exception e) {
            throw new RuntimeException("Failed to save image: " + e.getMessage());
        }
        productRepository.save(product);
        return "image uploaded";
    }


    @DeleteMapping("/deleteProduct/{id}")
    public void deleteProduct(@PathVariable("id") int id){
        productRepository.deleteById(id);
    }




}
