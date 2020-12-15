function [ c ] = cxmul( a, b, div )

r1 = resizeInteger( real(a)*real(b), div );
r2 = resizeInteger( imag(a)*imag(b), div );
r = r1-r2;

i1 = resizeInteger( real(a)*imag(b), div );
i2 = resizeInteger( imag(a)*real(b), div );
i = i1 + i2;

c = complex(r, i);

end

