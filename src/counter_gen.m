function output = counter_gen(input)

    % Parameters
    oct = 8;
    nbit = 32;
    
    output = {};
    
    if ~isnumeric(input)
        error('Input must be a numerical number');
    end
    
    tmp = dec2bin(input, nbit);
    tmp = reshape(logical(tmp - '0'), oct, nbit/oct);
    
    
    for idx = 1:1:nbit/oct
        tmp_hex = binaryVectorToHex(tmp(:, idx)');
        output{1, idx} = tmp_hex;
    end
    
end
