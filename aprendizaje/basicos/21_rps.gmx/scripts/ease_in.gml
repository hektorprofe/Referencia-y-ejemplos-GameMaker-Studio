/// ease_in(ease,time,begin,end,duration)

/*
** Easing ecuations taken fom JQuery Easing Plugin By Robert Penners:
**  http://gsgd.co.uk/sandbox/jquery/easing/
**
** Converted to GML by Manuel Etchegaray, 2014
**  http://invadergames.net/
**  contact@invadergames.net
**
**  fase = min(120, fase+1);
**  x = ease_in(easeOutElastic, fase, 0, 120, 120);
*/

var function = argument0;// constant value
var t = argument1;// current time
var b = argument2;// beginning value
var c = argument3;// ending value
var d = argument4;// time duration
var td = t/d;
var td2 = t/(d/2);
var ttd = t/d-1;
var ret;
switch (function) {
    case 0:
        return c*(td)*td + b;
    break;
    case 1:
        return -c *(td)*(td-2) + b;
    break;
    case 2:
        if ((td2) < 1) return c/2*td2*td2 + b;
        return -c/2 * ((--td2)*(td2-2) - 1) + b;
    break;
    case 3:
        return c*(td)*td*td + b;
    break;
    case 4:
        return c*((ttd)*ttd*ttd + 1) + b;
    break;
    case 5:
        if ((td2) < 1) return c/2*td2*td2*td2 + b;
        return c/2*((td2-2)*(td2-2)*(td2-2) + 2) + b;
    break;
    case 6:
        return c*(td)*td*td*td + b;
    break;
    case 7:
        return -c * ((ttd)*ttd*ttd*ttd - 1) + b;
    break;
    case 8:
        if ((td2) < 1) return c/2*td2*td2*td2*td2 + b;
        return -c/2 * ((td2-2)*(td2-2)*(td2-2)*(td2-2) - 2) + b;
    break;
    case 9:
        return c*(td)*td*td*td*td + b;
    break;
    case 10:
        return c*((ttd)*ttd*ttd*ttd*ttd + 1) + b;
    break;
    case 11:
        if ((td2) < 1) return c/2*td2*td2*td2*td2*td2 + b;
        return c/2*((td2-2)*(td2-2)*(td2-2)*(td2-2)*(td2-2) + 2) + b;
    break;
    case 12:
        return -c * cos(td * (pi/2)) + c + b;
    break;
    case 13:
        return c * sin(td * (pi/2)) + b;
    break;
    case 14:
        return -c/2 * (cos(pi*t/d) - 1) + b;
    break;
    case 15:
        if (t==0) return b;
        else return (c * power(2, 10 * (t/d - 1)) + b);
    break;
    case 16:
        if (t==d) return b+c;
        else return c * (-power(2, -10 * td) + 1) + b;
    break;
    case 17:
        if (t==0) return b;
        if (t==d) return b+c;
        if ((td2) < 1) return c/2 * power(2, 10 * (td2 - 1)) + b;
        return c/2 * (-power(2, -10 * (td2-1)) + 2) + b;
    break;
    case 18:
        return -c * (sqrt(1 - (ttd)*ttd) - 1) + b;
    break;
    case 19:
        return c * sqrt(1 - (ttd)*ttd) + b;
    break;
    case 20:
        if ((td2) < 1) return -c/2 * (sqrt(1 - td2*td2) - 1) + b;
        return c/2 * (sqrt(1 - (td2-2)*(td2-2)) + 1) + b;
    break;
    case 21:
        var s=1.70158; var p=0; var a=c;
        if (t==0) return b;
        if ((td)==1) return b+c;
        if (!p) p=d*.3;
        if (a < abs(c)) { a=c; var s=p/4; }
        else var s = p/(2*pi) * arcsin (c/a);
        return -(a*power(2, 10*(td-1)) * sin( ((td-1)*d-s)*(2*pi)/p )) + b;
    break;
    case 22:
        var s=1.70158;var p=0;var a=c;
        if (t==0) return b;
        if ((td)==1) return b+c;
        if (!p) p=d*.3;
        if (a < abs(c)) { a=c; var s=p/4; }
        else var s = p/(2*pi) * arcsin(c/a);
        return a*power(2, -10*td) * sin( (td*d-s)*(2*pi)/p ) + c + b;
    break;
    case 23:
        var s=1.70158;var p=0;var a=c;
        if (t==0) return b;
        if ((td2)==2) return b+c;
        if (!p) p=d*(.3*1.5);
        if (a < abs(c)) { a=c; var s=p/4; }
        else var s = p/(2*pi) * arcsin(c/a);
        if (td2 < 1) return -0.5*(a*power(2,10*(td2-1)) * sin( ((td2-1)*d-s)*(2*pi)/p )) + b;
        return a*power(2,-10*(td2-1)) * sin( ((td2-1)*d-s)*(2*pi)/p )*0.5 + c + b;
    break;
    case 24:
        var s = 1.70158;
        return c*(td)*td*((s+1)*td - s) + b;
    break;
    case 25:
        s = 1.70158;
        return c*(ttd*ttd*((s+1)*ttd + s) + 1) + b;
    break;
    case 26:
        s = 1.70158; 
        if ((td2) < 1) return c/2*(td2*td2*(((s*(1.525))+1)*td2 - (s*(1.525)))) + b;
        return c/2*((td2-2)*(td2-2)*(((s*(1.525))+1)*(td2-2) + (s*(1.525))) + 2) + b;
    break;
    case 27:
        t = d-t;
        if ((td) < (1/2.75)) {
        var ret = c*(7.5625*td*td) + b;
        } else if (td < (2/2.75)) {
        var ret = c*(7.5625*(td-(1.5/2.75))*(td-(1.5/2.75)) + .75) + b;
        } else if (td < (2.5/2.75)) {
        var ret = c*(7.5625*(td-(2.25/2.75))*(td-(2.25/2.75)) + .9375) + b;
        } else {
        var ret = c*(7.5625*(td-(2.625/2.75))*(td-(2.625/2.75)) + .984375) + b;
        }
        return c - ret + b;
    break;
    case 28:
        if ((td) < (1/2.75)) {
        var ret = c*(7.5625*td*td) + b;
        } else if (td < (2/2.75)) {
        var ret = c*(7.5625*(td-(1.5/2.75))*(td-(1.5/2.75)) + .75) + b;
        } else if (td < (2.5/2.75)) {
        var ret = c*(7.5625*(td-(2.25/2.75))*(td-(2.25/2.75)) + .9375) + b;
        } else {
        var ret = c*(7.5625*(td-(2.625/2.75))*(td-(2.625/2.75)) + .984375) + b;
        }
        return ret;
    break;
    case 29:
        if (t < d/2) {
            t *= 2;
            t = d-t;
            td = t/d;
            if ((td) < (1/2.75)) {
            var ret = c*(7.5625*td*td) + b;
            } else if (td < (2/2.75)) {
            var ret = c*(7.5625*(td-(1.5/2.75))*(td-(1.5/2.75)) + .75) + b;
            } else if (td < (2.5/2.75)) {
            var ret = c*(7.5625*(td-(2.25/2.75))*(td-(2.25/2.75)) + .9375) + b;
            } else {
            var ret = c*(7.5625*(td-(2.625/2.75))*(td-(2.625/2.75)) + .984375) + b;
            }
            ret = c - ret + b;
            return ret * .5 + b
        }
        else {
            t = t*2-d;
            td = t/d;
            if ((td) < (1/2.75)) {
            var ret = c*(7.5625*td*td) + b;
            } else if (td < (2/2.75)) {
            var ret = c*(7.5625*(td-(1.5/2.75))*(td-(1.5/2.75)) + .75) + b;
            } else if (td < (2.5/2.75)) {
            var ret = c*(7.5625*(td-(2.25/2.75))*(td-(2.25/2.75)) + .9375) + b;
            } else {
            var ret = c*(7.5625*(td-(2.625/2.75))*(td-(2.625/2.75)) + .984375) + b;
            }
            return ret * .5 + c*.5 + b;
        }
    break;
    default:
        return c *(td) + b;
    break;
}
