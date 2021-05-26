function disp_hex (string, hex_array)

    [n_hex_array, m_hex_array] = size (hex_array);

    n_string = length (string);

    empty_string = ones (1, n_string)*' ';

    for i = 1 : n_hex_array
        if i == 1
            line = string;
        else
            line = empty_string;
        end
        
        for j = 1 : m_hex_array
            line = [line, lower(dec2hex(hex_array(i,j),2)), ' '];
        end
        disp (line) 
    end

    disp (' ') 
    
end
