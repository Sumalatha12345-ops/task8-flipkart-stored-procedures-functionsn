USE FlipkartDB;

-- 1. Stored Procedure: Get orders by a specific user
DELIMITER //

CREATE PROCEDURE get_orders_by_user(IN uid INT)
BEGIN
    SELECT o.order_id, o.order_date, o.total_amount
    FROM Orders o
    WHERE o.user_id = uid;
END //

DELIMITER ;

-- Usage:
-- CALL get_orders_by_user(1);

-- 2. Stored Procedure with OUT parameter: Count total orders for a user
DELIMITER //

CREATE PROCEDURE get_order_count(IN uid INT, OUT total INT)
BEGIN
    SELECT COUNT(*) INTO total
    FROM Orders
    WHERE user_id = uid;
END //

DELIMITER ;

-- Usage:
-- CALL get_order_count(1, @total);
-- SELECT @total;

-- 3. User-defined Function: Get total quantity ordered for a product
DELIMITER //

CREATE FUNCTION total_quantity_by_product(pid INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT SUM(quantity) INTO total
    FROM OrderItems
    WHERE product_id = pid;
    RETURN IFNULL(total, 0);
END //

DELIMITER ;

-- Usage:
-- SELECT total_quantity_by_product(2);

-- 4. User-defined Function: Get average order value for a user
DELIMITER //

CREATE FUNCTION avg_order_value(uid INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE avg_total DECIMAL(10,2);
    SELECT AVG(total_amount) INTO avg_total
    FROM Orders
    WHERE user_id = uid;
    RETURN IFNULL(avg_total, 0.00);
END //

DELIMITER ;

-- Usage:
-- SELECT avg_order_value(1);