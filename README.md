
# 🌐 E-Commerce Web Application

An elegant and user-friendly E-Commerce platform built using **JSP**, **CSS**, **JavaScript**, and **SQL**. The application runs on a local **Tomcat** server and provides features for both **administrators** and **customers** to manage and utilize the platform effectively.  

---

## 🚀 Features  

### 🔑 User Roles and Permissions  

#### 👤 **Customer**  
- **Access URL**: [`http://localhost:8080/E_CommerceWebApplication_war_exploded/`](http://localhost:8080/E_CommerceWebApplication_war_exploded/)
- **Features**:  
  - User authentication (signup, login, logout)  
  - Browse products by category, search by name, or sort by price  
  - Manage shopping cart and checkout  
  - View order history  
  - Update profile details and password  

#### 👨‍💼 **Admin**  
- **Access URL**: [`http://localhost:8080/E_CommerceWebApplication_war_exploded/admin.jsp`](http://localhost:8080/E_CommerceWebApplication_war_exploded/admin.jsp)  
- **Features**:  
  - Register customers and admins  
  - Manage products, categories, and orders  
  - Activate or deactivate customer accounts  

---

## 🛠️ Technologies Used  

| **Frontend** | **Backend** | **Database** |
|--------------|-------------|--------------|
| JSP, CSS, JavaScript | Java (Servlets & JSP) | MySQL |

### Additional Highlights:
- **Authentication**: Passwords are hashed using the **SHA-256** algorithm for security.  
- **Database Connection**: Utilizes **Tomcat JDBC Connection Pool** with a `DataSource` configured as `@Resource(name = "java:comp/env/jdbc/pool")`.  

---

## 📷 Screenshots  

### 🏠 Customer Login  
![Image](https://github.com/user-attachments/assets/ca86f864-d17b-4321-89f8-7cb458634677)  

### 🛍️ Customer Register  
![Image](https://github.com/user-attachments/assets/ed8d4a00-408d-40b7-9e13-5704465346e1)

### 🛒 Shopping Cart  
![Shopping Cart](path/to/cart_screenshot.png)  

### ⚙️ Admin Panel  
![Admin Panel](path/to/adminpanel_screenshot.png)  

> **Note:** Replace `path/to/...` with actual file paths or URLs of your images.  

---

## 🎥 Demonstration Video  

Watch a full walkthrough of the application on [YouTube](https://www.youtube.com/watch?v=YourVideoID).  

> Replace `https://www.youtube.com/watch?v=YourVideoID` with your video link.  

---

## 📦 Installation  

### Prerequisites  
- [Apache Tomcat](https://tomcat.apache.org/)  
- [MySQL](https://www.mysql.com/) or compatible SQL database  
- JDK (Java Development Kit)  

### Steps  

1. **Clone the repository**  
   ```bash
   git clone https://github.com/Chathura0607/E-Commerce-Web-Application.git
   cd E-Commerce-Web-Application
   ```

2. **Set up the database**  
   - Import the `db.sql` file located in the `db` directory into your database:  
     ```bash
     mysql -u your_username -p your_database_name < db/db.sql
     ```  

   - Configure the Tomcat connection pool by adding your database details in the `context.xml` file:  
     ```xml
     <Resource name="jdbc/pool" auth="Container" type="javax.sql.DataSource"
               maxTotal="20" maxIdle="10" maxWaitMillis="-1"
               username="your_username" password="your_password"
               driverClassName="com.mysql.cj.jdbc.Driver"
               url="jdbc:mysql://localhost:3306/your_database_name"/>
     ```

3. **Deploy to Tomcat**  
   - Copy the project folder to the `webapps` directory in your Tomcat installation.  
   - Start the Tomcat server:  
     ```bash
     ./startup.sh  # For Linux/Mac
     startup.bat   # For Windows
     ```

4. **Access the application**  
   - Customers: Open [`http://localhost:8080/E_CommerceWebApplication_war_exploded/`](http://localhost:8080/E_CommerceWebApplication_war_exploded/)  
   - Admins: Open [`http://localhost:8080/E_CommerceWebApplication_war_exploded/admin.jsp`](http://localhost:8080/E_CommerceWebApplication_war_exploded/admin.jsp)  

---

## 🔧 Usage  

### 👤 Customer  
1. Sign up and log in.  
2. Browse products and add to your shopping cart.  
3. Place orders.
4. User profile management

### 👨‍💼 Admin  
1. Register as an admin and log in.
2. Registering customers 
3. Manage products, categories, orders, and users.
4. Activate or deactivate user accounts

---

## 🤝 Contributing  

1. Fork the repository.  
2. Create a new branch for your feature or fix.  
3. Commit your changes.  
4. Push to your forked repository.  
5. Open a pull request with a description of your changes.  

---

## 📄 License  

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.  
