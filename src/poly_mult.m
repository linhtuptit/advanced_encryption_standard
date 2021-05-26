function poly_out = poly_mult(poly1, poly2, poly_mod)

    poly_out = 0;
    
    for k = 1:1:8;
        if bitget(poly1, k)
            tmp_poly2 = bitshift(poly2, k-1);
            poly_out = bitxor(poly_out, tmp_poly2);
        end
    end
    
    for k = 16:-1:9
        if bitget(poly_out, k)
            tmp_polyout = bitshift(poly_mod, k-9);
            poly_out = bitxor(poly_out, tmp_polyout);
        end
    end
        
end
