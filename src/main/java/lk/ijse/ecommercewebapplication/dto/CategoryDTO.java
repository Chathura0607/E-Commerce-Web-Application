package lk.ijse.ecommercewebapplication.dto;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class CategoryDTO {
    private int id;
    private String name;
    private String description;

    public CategoryDTO(int categoryId, String categoryName) {
        this.id = categoryId;
        this.name = categoryName;
    }
}
