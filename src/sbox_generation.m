function [sbox, inv_sbox] = sbox_generation(poly_mod)

    sbox = zeros(1, 256);
    inv_sbox = zeros(1, 256);
    
    % Turn modulos polynomial (mod_poly) into decimal value
    inv_tmp = zeros(1, 256);
    
    % Figure out inverse of a number with modulos polynomial
    for idx = 1:1:255
        inv_tmp(idx + 1) = find_inverse(idx, poly_mod); 
    end
    
    % Execute linear affine and extract sbox
    for idx = 1:1:256
        sbox(idx) = aff_trans(inv_tmp(idx));
    end
    
    % Extract inv_sbox
    for idx = 1:1:256
        inv_sbox(sbox(idx) + 1) = idx - 1; 
    end
    
    % Children-functions
    % ---------------------------------------------------
    function output = find_inverse(input, poly_mod)
        
        poly_mod = bin2dec(poly_mod);
        output = [];
        
        for ii = 1:1:255
            prod = poly_mult(input, ii, poly_mod);
            if (prod == 1)
                output = ii;
            end
        end
        
    end
    % -----------------------------------------------------
    function output = aff_trans(input)
            
        mod_poly = bin2dec('100000001');
        mul_poly = bin2dec('00011111');
        add_poly = bin2dec('01100011');
        
        temp = poly_mult(input, mul_poly, mod_poly);
        output = bitxor(temp, add_poly);     
        
    end

end
