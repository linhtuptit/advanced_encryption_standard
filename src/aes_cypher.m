function cyphertext = aes_cypher(plaintext, key, sbox, poly_mat, poly_mod)
    
    state = plaintext;
    
    % Initial PHASE
    round_key = key(:,1:4);
    state = add_round_KEY(state, round_key);
    
    % Loop 9 rounds
    for k = 1:1:9;
        state = sub_bytes(state, sbox);
        state = shift_rows(state);
        state = mix_columns(state, poly_mat, poly_mod);
        round_key = key(:,(1:4)+4*k);
        state = add_round_KEY(state, round_key);
    end
    
    % Last PHASE
    state = sub_bytes(state, sbox);
    state = shift_rows(state);
    round_key = key(:,41:44);
    state = add_round_KEY(state, round_key);
    
    cyphertext = state;
   
end
