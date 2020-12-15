function [ out ] = resizeInteger( val, w )

out = zeros(length(val),1);
    for j=1:length(val)
        r = real(val(j));
        i = imag(val(j));

        sr = sign(r);
        si = sign(i);

        tr = floor(abs(r));
        ti = floor(abs(i));

        % i also need to do the following because there might be bits in
        % the upper part (i.e. between 1 and end-w).
        br = dec2bin(abs(tr), 2*w);
        bi = dec2bin(abs(ti), 2*w);
        
        br2 = br(end-w+1:end);
        bi2 = bi(end-w+1:end);
        
        br3 = sr*bin2dec(br2);
        bi3 = si*bin2dec(bi2);

        out(j) = complex( br3, bi3 );
    end
end

