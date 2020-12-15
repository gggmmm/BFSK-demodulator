function [arrres] = convertFpToBin( arrval, bitres, bitinteg, outputtype )
% the purpose of this function is an integer or binary representation of an
% input value.
% the input can be an array of (complex) values.

% bitres: number of bit used in the fixed point representation

% bitinteg: number of bits dedicated to the integer part (NOTE: the relation
% is bitres-bitinteg=bitfraction, where bitfraction is the number of
% bits for the fractionary part).

% outputtype: 1=binary output, 0=integer

if isreal(arrval)==1
    numofround = 1;
    %arrres = zeros(length(arrval), bitres-bitinteg);
else
    numofround = 2;
    %arrres = zeros(length(arrval), 2*(bitres-bitinteg));
end

for i=1:numofround
    if i==1
        tmparr = real(arrval);
        disp('===== REAL =====');
    else
        tmparr = imag(arrval);
        disp('===== IMAG =====');
    end
    
    for j=1:length(tmparr)
        fraction = abs(tmparr(j));
                
        fraction = floor( (fraction-floor(fraction))/2^-(bitres-bitinteg) );
        fraction = dec2bin(fraction);
        
        % I can't do zero padding here: this operation carries no weight
        % when considered in fixed point, but as I am printing values in
        % integer, that zero at the LSB carries weight
        if length(fraction) < bitres-bitinteg
            fraction = [repelem('0', (bitres-bitinteg)-length(fraction)), fraction];
        end
        
        % ==============================      
        if bitinteg~=0
            integ = abs(tmparr(j));

            integ = floor(integ);
            integ = dec2bin(integ);

            if length(integ) < bitinteg
                integ = [repelem('0', (bitinteg)-length(integ)), integ];
            end

            if outputtype==0
                bin2dec([integ fraction]);
            else
                [integ, fraction]
            end
            arrres(j,i) = bin2dec([integ fraction]);
        else
            if outputtype==0
                bin2dec([fraction]);
            else
                [fraction]
            end
            arrres(j,i) = bin2dec([fraction]);
        end
        
    end
end

