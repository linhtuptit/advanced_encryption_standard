function output = cbc_aes_cypher(input, key, sbox, poly_mat, poly_mod, IV)

    lengin = length(input);
    output = zeros(1, lengin);
    
    tmp_in = reshape(input, [lengin/16, 16]);
    tmp_out = reshape(output, [lengin/16, 16]);
    
    row_num = size(tmp_in, 1);
    
    % Initial round
    IV              = reshape(IV, 4, 4);
    tmp_r1          = reshape(tmp_in(1, :), 4, 4);
    tmp_r1          = bitxor(tmp_r1, IV);
    tmp_r1_cypher   = AES_CYPHER(tmp_r1, key, sbox, poly_mat, poly_mod);
    tmp_r1_cypher   = reshape(tmp_r1_cypher, 1, 16);
    tmp_out(1, :)   = tmp_r1_cypher;
    
    % For other rounds
    for idx = 2:1:row_num
        tmp_ridx_in = reshape(tmp_in(idx, :), 4, 4);
        tmp_ridx_out = reshape(tmp_out(idx-1, :), 4, 4);
        tmp_ridx = bitxor(tmp_ridx_in, tmp_ridx_out);
        tmp_ridx_cypher = AES_CYPHER(tmp_ridx, key, sbox, poly_mat, poly_mod);
        tmp_ridx_cypher = reshape(tmp_ridx_cypher, 1, 16);
        tmp_out(idx, :) = tmp_ridx_cypher;
    end
    
    output = reshape(tmp_out, 1, lengin);
    
end
