function [ m ] = mmod( a, b )
    m = mod(a,b); 
    
    if(m == 0)
       m = b;
    end
end

