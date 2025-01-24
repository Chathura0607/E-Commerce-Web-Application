package lk.ijse.ecommercewebapplication.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ProductDTO {
    private int productId;
    private String name;
    private int categoryId;
    private double price;
    private int stock;
}
