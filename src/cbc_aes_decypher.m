function output = cbc_aes_decypher(input, key, inv_sbox, inv_poly_mat, poly_mod, IV)

    lengin = length(input);
    output = zeros(1, lengin);
    
    tmp_in = reshape(input, [lengin/16, 16]);
    tmp_out = reshape(output, [lengin/16, 16]);
    
    row_num = size(tmp_in, 1);
    
    % Initial round
    IV              = reshape(IV, 4, 4);
    tmp_r1          = reshape(tmp_in(1, :), 4, 4);
    tmp_r1_decypher = AES_DECYPHER(tmp_r1, key, inv_sbox, inv_poly_mat, poly_mod);
    tmp_r1_decypher = bitxor(tmp_r1_decypher, IV);
    tmp_r1_decypher = reshape(tmp_r1_decypher, 1, 16);
    tmp_out(1, :)   = tmp_r1_decypher;
    
    % For other rounds
    for idx = 2:1:row_num
        tmp_ridx_in = reshape(tmp_in(idx, :), 4, 4);
        tmp_ridx_decypher = AES_DECYPHER(tmp_ridx_in, key, inv_sbox, inv_poly_mat, poly_mod);
        tmp_ridx_decypher = bitxor(tmp_ridx_decypher, reshape(tmp_in(idx-1, :), 4, 4));
        tmp_ridx_decypher = reshape(tmp_ridx_decypher, 1, 16);
        tmp_out(idx, :) = tmp_ridx_decypher;
    end
    
    output = reshape(tmp_out, 1, lengin);
    
end
