function [ out ] = clipBinary( v, w, s, e )
% s/e values between 1 and w included
% v value to be clipped
% w wordlength of the rapresentation

    r = real(v);
    i = imag(v);

    sr = sign(r);
    si = sign(i);

    br = dec2bin(abs(r), 2*w);
    bi = dec2bin(abs(i), 2*w);
    
    ts = 2*w-e+1;
    te = 2*w-s+1;
    
    rr = sr*bin2dec(br(ts:te));
    ri = si*bin2dec(bi(ts:te));
    
    if isreal(v)==1
        out = rr;
    else
        out = complex( rr, ri );
    end
end

