var t,c,b,d,ts,tc;
t = argument1;
b = 0;
c = 1;
d = 1;
ts = (t/d)*t;
tc = ts*t;
switch (argument0)
 {
   //You can use negative values to invert the effect!
   case 0:  return  (t); break;
   case 1:  return  (t*t); break;
   case 2:  return  (t*t*t); break;
   case 3:  return  (t*t*t*t); break;
   case 4:  return  (t*t*t*t*t); break;
   case 5:  return  (sin(pi*0.5*t)); break;
   case 6:  return  (power(2,10 * (t - 1))); break;
   case 7:  return  (b+c*(59.9425*tc*ts + -177.43*ts*ts + 191.88*tc + -91.19*ts + 17.7975*t));   break;
   case 8:  return  (b+c*(56*tc*ts + -175*ts*ts + 200*tc + -100*ts + 20*t)); break;
   case 9:  return  (t * t * (2.70158 * t - 1.70158)); break;
   case 10: return  (power(sin(pi*t/2),2)); break;
   case 11: return  (-cos(pi*(  (-cos(pi*t)+1)*0.5  ))+1)*0.5;  break;
   case 12: return  (b+c*(8*tc*ts + -20*ts*ts + 12*tc + 2*ts + -1*t)); break;
   case 13: return  (-cos(pi*2*t)+1)*0.5; break;
   case 14: return  (-cos(pi*(  (-cos(pi*2*t)+1)*0.5  ))+1)*0.5;  break;
 }