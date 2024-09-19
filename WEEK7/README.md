# WEEK 7
Main points:
1. Scipy interpolation is only useful for plotting purposes, but real operations need to be done on the raw CellX, CellY, T point. Interpolation has forced the array to be evenly spaced, but the dT/dY array is expected to be nonuniform. 
2. Attempt the running mean/running STDEV plotting backwards - get feedback.

Goals:
1. Attempt third-order derivative for dT/dy arrays. Polyfit the array - check if 2nd or 3rd order is better, attempt np.grad on polyfitted array OR investigate notebook for other kinds of methods.
2. Integral timescale calculation: Get h5 per timesetep from either Hawkins computer (Tr=1, M4) or try with RDS data, query areas with more rapid plume movement to get as small of a timescale as possible.
    - Where the autocorrelation intersects 0 gives the # timesteps to the integral timescale. Multiply this by 0.05 (current delta T of simulation).
