function output = mix_columns(input, poly_mat, poly_mod)

    poly_mod = bin2dec(poly_mod);

    for jj = 1:1:4
        for ii = 1:1:4
            tmp_out = 0;
            for k = 1:1:4
                tmp_prod = poly_mult(poly_mat(ii,k), input(k,jj),...
                                        poly_mod);
                tmp_out = bitxor(tmp_out, tmp_prod);
            end
            output(ii, jj) = tmp_out;
        end
    end
 
end
