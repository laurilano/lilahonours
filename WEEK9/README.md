# WEEK 9
Main points:

# 24/09/24
Ran /L1/ and no flow behaviour was observed; hence quick runtime. Repeated for /L2/ but tried to be careful with error messages in the terminal; code used is:

```python
define/operating-conditions/gravity y 0 -9.81
define/models/viscous/laminar y
define/materials/change-create/air/air y boussinesq 1.225 n n n n y 0.00343 n
define/boundary-conditions/modify-zones/zone-type/left symmetry
define/boundary-conditions/modify-zones/zone-type/right symmetry
define/operating-conditions/operating-temperature 298
define/operating-conditions/operating-density y 1.225
define/boundary-conditions/wall mid-bottom n 0 n 0 n n n 308 n n n 1
define/boundary-conditions/wall cylinder n 0 n 0 n n n 318 n n n 1
define/boundary-conditions/modify-zones/zone-type/top pressure-outlet
define/boundary-conditions/modify-zones/zone-type/left-bottom pressure-outlet
define/boundary-conditions/modify-zones/zone-type/right-bottom pressure-outlet
define/boundary-conditions/pressure-outlet/top y n 0 n 298 n y y n n 
define/boundary-conditions/pressure-outlet/left-bottom y n 0 n 298 n y y n n 
define/boundary-conditions/pressure-outlet/right-bottom y n 0 n 298 n y y n n
report/reference-values/area 1
report/reference-values/density 1.225
report/reference-values/length 1
report/reference-values/velocity 1
report/reference-values/viscosity 1.7894e-5
report/reference-values/temperature 298 
solve/monitors/residual/convergence-criteria 0.00001 0.00001 0.00001 0.000001
solve/initialize/set-defaults/temperature 298
solve/initialize/set-defaults/pressure 0
solve/initialize/set-defaults/x-velocity 0
solve/initialize/set-defaults/y-velocity 0
solve/initialize/initialize-flow
solve/iterate 5000
define/models/unsteady-2nd-order y
solve/monitors/force/set-drag-monitor CL y cylinder () y y CL y 2 n 1 0 
solve/monitors/force/set-lift-monitor CD y cylinder () y y CD y 3 n 0 1
surface/point-surface top_point 0.005 0.01
surface/point-surface bottom_point 0.1 -0.01
solve/monitors/surface/set-monitor temp-top "Vertex Average" temperature top_point () n n y "temp-top" 1 y flow-time
solve/monitors/surface/set-monitor xvel-top "Vertex Average" x-velocity top_point () n n y "xvel-top" 1 y flow-time
solve/monitors/surface/set-monitor yvel-top "Vertex Average" y-velocity top_point () n n y "yvel-top" 1 y flow-time
solve/monitors/surface/set-monitor temp-bottom "Vertex Average" temperature bottom_point () n n y "temp-bottom" 1 y flow-time
solve/monitors/surface/set-monitor xvel-bottom "Vertex Average" x-velocity bottom_point () n n y "xvel-bottom" 1 y flow-time
solve/monitors/surface/set-monitor yvel-bottom "Vertex Average" y-velocity bottom_point () n n y "yvel-bottom" 1 y flow-time
solve/set/extrapolate-vars y
solve/set/time-step 0.05
solve/dual-time-iterate 2000 50 
file/auto-save/data-frequency 0
```
Then we set up the post files... then:

```python
solve/set/data-sampling y 1 y y y y
solve/dual-time-iterate 20000 50
```

... and I had almost no flow from flow time 0-300s, with plumes and vortex shedding showing up at 300 onwards. Am yet to debug as per 1:30 but that is next goal. Just left remote desktop up to the step `solve/dual-time-iterate 2000 50`... may continue with other tasks first. 
