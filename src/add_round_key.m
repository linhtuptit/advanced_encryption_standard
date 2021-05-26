function output = add_round_key(input, round_KEY)

    output = bitxor(input, round_KEY);

end
