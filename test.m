clc;
clear all;

addpath('.../your_path_to/src');

RGB = imread('aes_demo.png');

YCbCr = rgb2ycbcr(RGB);

% Turn it into YCbCr
Y  = double(YCbCr(:,:,1));
Cb = double(YCbCr(:,:,2));
Cr = double(YCbCr(:,:,3));

% Reshape Y, Cb and Cr
Y1 = reshape(Y, 1, 320*240);
Cb1 = reshape(Cb, 1, 320*240);
Cr1 = reshape(Cr, 1, 320*240);


% AES parameter
poly_mod = '101111011';
main_key =  {'00' '01' '02' '03' '04' '05' '06' '07' ...
             '08' '09' '0a' '0b' '0c' '0d' '0e' '0f'};
main_key = hex2dec(main_key);
[sbox, inv_sbox] = sbox_generation(poly_mod);
[poly_mat, inv_poly_mat] = poly_mat_generate;
[rcon] = rcon_generate;
tic;
key = key_expansion(main_key, sbox, rcon);
time = toc;

% 
   Y_cypher = [];
  Cb_cypher = [];
  Cr_cypher = [];
 Y_decypher = [];
Cb_decypher = [];
Cr_decypher = [];

for idx = 1:1:4800
     Y_tmp = Y1(16*(idx-1)+1:16*idx);
     Y_tmp = reshape(Y_tmp, 4, 4);
     Y_tmp_cypher = aes_cypher(Y_tmp, key, sbox, poly_mat, poly_mod);
     Y_tmp_cypher1 = reshape(Y_tmp_cypher, 1, 16);
     Y_cypher = [Y_cypher, Y_tmp_cypher1];
     Y_tmp_decyph = aes_decypher(Y_tmp_cypher, key, inv_sbox, inv_poly_mat, poly_mod);
     Y_tmp_decyph = reshape(Y_tmp_decyph, 1, 16);
     Y_decypher = [Y_decypher, Y_tmp_decyph];
     
    Cb_tmp = Cb1(16*(idx-1)+1:16*idx);
    Cb_tmp = reshape(Cb_tmp, 4, 4);
    Cb_tmp_cypher = aes_cypher(Cb_tmp, key, sbox, poly_mat, poly_mod);
    Cb_tmp_cypher1 = reshape(Cb_tmp_cypher, 1, 16);
    Cb_cypher = [Cb_cypher, Cb_tmp_cypher1];
    Cb_tmp_decyph = aes_decypher(Cb_tmp_cypher, key, inv_sbox, inv_poly_mat, poly_mod);
    Cb_tmp_decyph = reshape(Cb_tmp_decyph, 1, 16);
    Cb_decypher = [Cb_decypher, Cb_tmp_decyph];
    
    Cr_tmp = Cr1(16*(idx-1)+1:16*idx);
    Cr_tmp = reshape(Cr_tmp, 4, 4);
    Cr_tmp_cypher = aes_cypher(Cr_tmp, key, sbox, poly_mat, poly_mod);
    Cr_tmp_cypher1 = reshape(Cr_tmp_cypher, 1, 16);
    Cr_cypher = [Cr_cypher, Cr_tmp_cypher1];
    Cr_tmp_decyph = aes_decypher(Cr_tmp_cypher, key, inv_sbox, inv_poly_mat, poly_mod);
    Cr_tmp_decyph = reshape(Cr_tmp_decyph, 1, 16);
    Cr_decypher = [Cr_decypher, Cr_tmp_decyph];
end

Y_c = reshape(Y_cypher, 320, 240);
Cb_c = reshape(Cb_cypher, 320, 240);
Cr_c = reshape(Cr_cypher, 320, 240);

Y_d = reshape(Y_decypher, 320, 240);
Cb_d = reshape(Cb_decypher, 320, 240);
Cr_d = reshape(Cr_decypher, 320, 240);

% Show image after encryph
figure(1)
out1(:,:,1) = uint8(Y);
out1(:,:,2) = uint8(Cb);
out1(:,:,3) = uint8(Cr);
imshow(ycbcr2rgb(out1));

figure(2)
out2(:,:,1) = uint8(Y_c);
out2(:,:,2) = uint8(Cb_c);
out2(:,:,3) = uint8(Cr_c);
imshow(ycbcr2rgb(out2));

figure(3)
out3(:,:,1) = uint8(Y_d);
out3(:,:,2) = uint8(Cb_d);
out3(:,:,3) = uint8(Cr_d);
imshow(ycbcr2rgb(out3));
