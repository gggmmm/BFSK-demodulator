function [ r ] = dec2bin_2s( v )
    if v < 0
        s = 1;
        v = -v;
    else
        s = 0;
    end
    
    bin = dec2bin(v);
    
    if s==1
        % negating
        for i=length(bin):-1:1
            if bin(i)=='0'
                bin(i) = '1';
            else
                bin(i) = '0';
            end
        end
        
        % adding 1
        for i=length(bin):-1:1
            if bin(i) == '0'
                bin(i) = '1';
                break;
            else
                bin(i) = '0';
            end
        end        
    end
    
    r = bin;
end

