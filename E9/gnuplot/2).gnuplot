set encoding utf8;
#set terminal tikz latex color;
#set output "langeSpule.tex";

set tics nomirror;
#set border 3;
#set arrow 1 from graph 0,0 to graph 1, 0;
#set arrow 2 from graph 0,0 to graph 0, 1.05;
set key top left;

set decimalsign locale

set title "Magnetfeld einer langen Spule";
set xlabel "Position der Messspule $x$  [m]";
set ylabel "Magnetfeldstärke  [mT]";
set xrange [-0.3:.5];
set yrange[:3];

f(x) = 2e-7*pi*2.9*200e3/.3* ( (-(x-b) + L)/sqrt(R**2 + (-(x-b)+L)**2) + (x-b)/sqrt(R**2 + (x-b)**2) )

g(x) = 2e-7*pi*a* ( (-(x-b) + L)/sqrt(R**2 + (-(x-b)+L)**2) + (x-b)/sqrt(R**2 + (x-b)**2) )

R = .02
L = .3

fit f(x) 'langeSpule.table' u ($1/1000):($2/100/pi/.157) via b
fit g(x) 'langeSpule.table' u ($1/1000):($2/100/pi/.157) via a


plot  'langeSpule.table' u ($1/1000):($2/100/pi/.157):(1e-3):(.1/100/pi/.157) title "Messwerte" w xyerrorbars ,\
	f(x) title "Erwartete Kurve",\
	g(x) title "fit der Messwerte";
