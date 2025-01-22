package lk.ijse.ecommercewebapplication.dto;

import lombok.*;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class UserDTO {
    private int id;
    private String name;
    private String email;
    private String password;
    private String role;
    private String status;
}
