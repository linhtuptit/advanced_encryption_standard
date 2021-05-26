function [poly_mat, inv_poly_mat] = poly_mat_generate()

    poly_mat =     {'02' '03' '01' '01' ... 
                    '01' '02' '03' '01' ...
                    '01' '01' '02' '03' ... 
                    '03' '01' '01' '02'};
                
    poly_mat = hex2dec(poly_mat);
                
    poly_mat = (reshape(poly_mat, 4, 4))';
    
    inv_poly_mat = {'0e' '0b' '0d' '09' ... 
                    '09' '0e' '0b' '0d' ... 
                    '0d' '09' '0e' '0b' ... 
                    '0b' '0d' '09' '0e'};
                
    inv_poly_mat = hex2dec(inv_poly_mat);
                
    inv_poly_mat = (reshape(inv_poly_mat, 4, 4))';

end
