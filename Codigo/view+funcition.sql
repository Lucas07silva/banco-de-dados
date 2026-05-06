-- =========================================
-- DDL - Criação da tabela
-- =========================================
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    active BOOLEAN
);

-- =========================================
-- DML - Inserção de dados (exemplo)
-- =========================================
INSERT INTO users (name, email, active) VALUES
('João Silva', 'joao@email.com', true),
('Maria Souza', 'maria@email.com', false),
('Carlos Lima', 'carlos@email.com', true);

-- =========================================
-- VIEW - Usuários ativos
-- =========================================
CREATE OR REPLACE VIEW active_users_view AS
SELECT 
    id,
    name,
    email
FROM users
WHERE active = true;

-- Teste da VIEW
SELECT * FROM active_users_view;

-- =========================================
-- FUNCTION - Verificar status do usuário
-- =========================================
CREATE OR REPLACE FUNCTION check_user_status(p_id INT)
RETURNS TEXT AS $$
DECLARE
    user_status BOOLEAN;
BEGIN
    -- Buscar status do usuário
    SELECT active INTO user_status
    FROM users
    WHERE id = p_id;

    -- Verifica se encontrou o usuário
    IF NOT FOUND THEN
        RETURN 'Usuário não encontrado';
    END IF;

    -- Verifica se está ativo ou não
    IF user_status = true THEN
        RETURN 'Usuário ativo';
    ELSE
        RETURN 'Usuário inativo';
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Teste da FUNCTION
SELECT check_user_status(1);
