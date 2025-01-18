package lk.ijse.ecommercewebapplication.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserDTO {
    private String email;
    private String password;
    private String name;
    private String role;
    private String status;
}
