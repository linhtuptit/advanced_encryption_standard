function key = key_expansion(key, sbox, rcon)

    key = reshape(key, 4, 4)';

    for k = 5:1:44
        
        tmp_key = key(:, k-1);
        
        if mod(k, 4) == 1
            tmp_key = rot_word(tmp_key);
            tmp_key = sub_bytes(tmp_key, sbox)';
            r = rcon(:,(k-1)/4);
            tmp_key = bitxor(tmp_key, r);
        end
        
        key(:,k) = bitxor(key(:,k-4), tmp_key);
    end
    
    function output = rot_word(input)

        output = input([2 3 4 1]);

    end
    
end
