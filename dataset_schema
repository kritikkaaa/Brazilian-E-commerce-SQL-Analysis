## Dataset Overview

This project analyzes more than 100,000 e-commerce orders from Brazil using
Google BigQuery. The dataset captures customer behavior, order timelines,
payments, freight costs, and delivery performance to understand operational
efficiency, regional trends, and purchasing patterns.

The analysis focuses on order trends over time, geographic distribution of
customers, payment behavior, logistics performance, and delivery efficiency
across different states.

---

## Tables Used

### 1. Orders (`orders`)
Contains order-level information along with purchase and delivery timelines.

**Key Columns:**
- order_id – Unique identifier for each order  
- customer_id – Identifier linking orders to customers  
- order_status – Current status of the order  
- order_purchase_timestamp – Date and time when the order was placed  
- order_delivered_customer_date – Actual delivery date to the customer  
- order_estimated_delivery_date – Estimated delivery date  

**Used for:**
- Time-based trend analysis  
- Seasonality and order volume analysis  
- Delivery time calculations  

---

### 2. Customers (`customers`)
Contains customer identity and geographic information.

**Key Columns:**
- customer_id – Customer identifier used for joins  
- customer_unique_id – Unique customer across multiple orders  
- customer_city – Customer city  
- customer_state – Customer state  

**Used for:**
- Geographic distribution of customers  
- State-wise and city-wise order analysis  

---

### 3. Order Items (`order_items`)
Contains item-level details for each order, including price and freight cost.

**Key Columns:**
- order_id – Reference to the orders table  
- price – Price of the item  
- freight_value – Shipping cost for the item  

**Used for:**
- Order pricing analysis  
- Freight cost analysis  
- State-wise freight comparison  

---

### 4. Payments (`payments`)
Contains payment-related information for each order.

**Key Columns:**
- order_id – Reference to the orders table  
- payment_type – Payment method used  
- payment_installments – Number of installments  
- payment_value – Total payment amount  

**Used for:**
- Payment behavior analysis  
- Installment-based order distribution  
- Year-over-year revenue comparison  

---

### 5. Products (`products`)
Contains product-level information.

**Key Columns:**
- product_id – Unique product identifier  

**Used for:**
- Dataset exploration and validation  

(Note: Product attributes were explored but not directly used in the core analysis.)

---

## Table Relationships (Join Logic)

- orders.customer_id → customers.customer_id  
- orders.order_id → order_items.order_id  
- orders.order_id → payments.order_id  

---

## Analytical Scope Enabled

Using this schema, the following analyses were performed:
- Order trends and seasonality analysis  
- Time-of-day and month-wise ordering patterns  
- State-wise customer and order distribution  
- Payment method and installment analysis  
- Freight cost comparison across states  
- Delivery time and delivery delay analysis  

---

## Notes

All queries were executed using Google BigQuery.
Due to data size and usage constraints, raw datasets are not included in this repository.
