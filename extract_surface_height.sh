grep -e "Surface height" -e "Step" logfile  | head -10 | awk  '/Step/ {t=$4} /Surface height/ {print t, $3}'   > surface_height.dat
