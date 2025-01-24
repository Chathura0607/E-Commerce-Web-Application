package lk.ijse.ecommercewebapplication.dto;

import lombok.*;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class OrderDTO {
    private int orderId;
    private String customerName;
    private double totalAmount;
    private String status;
    private String createdAt;
}
