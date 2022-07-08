# Scale font and line width (dpi) by changing the size! It will always display stretched.
set terminal svg size 400,300 enhanced fname 'arial'  fsize 10 butt solid
set output 'out.svg'

set style fill solid

set xrange [0:99]
set yrange [0:99]
set title 'Z-Order Index'
plot "data.txt" using 1:2:(0.3) title 'Page 7' with circles