function plaintext = aes_decypher(cyphertext, key, inv_sbox, inv_poly_mat, poly_mod)

    state = cyphertext;
    
    % Initial PHASE
    round_key = key(:,41:44);
    state = add_round_KEY(state, round_key);
    
    % Loop 9 rounds
    for k = 9:-1:1;
        state = inv_shift_rows(state);
        state = sub_bytes(state, inv_sbox);
        round_key = key(:,(1:4)+4*k);
        state = add_round_KEY(state, round_key);
        state = mix_columns(state, inv_poly_mat, poly_mod);
    end
    
    % Last PHASE
    state = inv_shift_rows(state);
    state = sub_bytes(state, inv_sbox);
    round_key = key(:,1:4);
    state = add_round_KEY(state, round_key);
    
    plaintext = state;

end
