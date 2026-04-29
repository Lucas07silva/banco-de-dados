CREATE OR REPLACE PROCEDURE realizar_venda(
    p_produto_id INT,
    p_quantidade INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_preco NUMERIC(10,2);
    v_estoque INT;
    v_valor_total NUMERIC(10,2);
BEGIN
    -- Verifica se o produto existe
    SELECT preco, estoque
    INTO v_preco, v_estoque
    FROM produtos
    WHERE id = p_produto_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Produto não encontrado!';
    END IF;

    -- Verifica estoque
    IF v_estoque < p_quantidade THEN
        RAISE EXCEPTION 'Estoque insuficiente!';
    END IF;

    -- Calcula valor total
    v_valor_total := v_preco * p_quantidade;

    -- Insere venda
    INSERT INTO vendas (produto_id, quantidade, valor_total)
    VALUES (p_produto_id, p_quantidade, v_valor_total);

    -- Atualiza estoque
    UPDATE produtos
    SET estoque = estoque - p_quantidade
    WHERE id = p_produto_id;

    RAISE NOTICE 'Venda realizada com sucesso!';
END;
$$;
