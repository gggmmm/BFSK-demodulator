function Out = ADC(In, SatVal, b)
%#codegen

    if b >= 2
        delta = SatVal/(2^(b-1)-1);
        Out = zeros(length(In), 1);

            for i=1:length(In) 

                if In(i) >= SatVal
                    Out(i) = SatVal+delta/2;
                end

                if In(i) < -SatVal
                    Out(i) = -SatVal-delta/2;
                end

                if (In(i) < SatVal) && (In(i) >= -SatVal)
                       Out(i) = floor(In(i)/delta)*delta +delta/2;
                end

            end
    else
        disp('ADC b has to be greater or equal than 2');
    end
end