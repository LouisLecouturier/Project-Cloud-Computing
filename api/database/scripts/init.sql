CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS items (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price NUMERIC(10, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS baskets (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_item FOREIGN KEY (item_id) REFERENCES items(id) ON DELETE CASCADE
);

INSERT INTO users (username, email)
VALUES 
    ('john_doe', 'john@example.com'),
    ('jane_smith', 'jane@example.com');


INSERT INTO items (name, description, price)
VALUES 
    ('T-shirt Basic', 'T-shirt en coton uni', 19.99),
    ('Chaussures de sport', 'Baskets confortables', 79.99),
    ('Casque audio', 'Casque bluetooth avec réduction de bruit', 149.99),
    ('Livre de développement', 'Guide complet de programmation', 39.99);


INSERT INTO baskets (user_id, item_id, quantity)
VALUES 
    (1, 1, 2),
    (1, 3, 1),
    (2, 2, 1),
    (2, 4, 3);