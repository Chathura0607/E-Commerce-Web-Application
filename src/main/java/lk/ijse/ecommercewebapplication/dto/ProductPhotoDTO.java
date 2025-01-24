package lk.ijse.ecommercewebapplication.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ProductPhotoDTO {
    private int photoId;
    private int productId;
    private String photoUrl;
}
