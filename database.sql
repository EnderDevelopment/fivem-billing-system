CREATE TABLE IF NOT EXISTS billing_invoices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    description TEXT,
    status ENUM('open', 'paid', 'sent') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO billing_invoices (sender_id, receiver_id, amount, description, status) VALUES
(1, 2, 100.00, 'Repair service', 'open'),
(2, 1, 50.00, 'Towing service', 'paid'),
(3, 4, 200.00, 'Police fine', 'sent');