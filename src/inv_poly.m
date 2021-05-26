function output = inv_poly(input, poly_mod)

    input = bin2dec(input);
    poly_mod = bin2dec(poly_mod);
    
    for idx = 1:1:255
        prod = poly_mult(input, idx, poly_mod);
        if prod == 1
            output = dec2bin(idx);
        end
    end
    
end
