# WEEK 8
Main points:

## 19/09 Update

### Regarding `.POST` files on Windows

Summary of motivation:
- `.POST` files for our data are approx. 5MB, which is 1/10 the size of an equivalent H5 file.
- 10k timesteps may be enough, so that leaves approx 50GB per case if we were to save each post file.

Important info:
- This notebook uses files stored on local drive `Tr=1.1` as we have run ANSYS to produce post files for this case starting from timestep 2001 - it skipped this timestep so produced files from 2002. 
- ANSYS also produced a cas.post file.
- This was run using VisualStudio's internal Python 3.11 environment. Internal Terminal had to be used to install h5py, numpy, scipy and matplotlib.

After running this:
- The initial goal was to use The CellX, CellY outputs from the original cas.h5 file and map them to the temperature obtained from the post file. However the shape produced from regular h5 does not equal the number of results obtained form the post: 234480 for the original vs 235616 from post. 
- The next goal was to take the cell centroid coordinates from the post.cas instead using the same structure.
    - The original path is `/meshes/1/faces/nodes/...` but in post, there MUST be a `.post` following 1, i.e. `/meshes/1.post/faces/nodes/`
    - The original H5 group `/meshes/1/faces/` has 4 children: c0, c1, nodes and zoneTopology. The post equivalent, `/meshes/1.post/faces/`, only has 2: nodes and zoneTopology.
    - Therefore, the same method to map `FaceIdToCellId = np.array(f['/meshes/1/faces/c0/1'][:])  # Shape (M/2,)` will not work using post. 

Goals:
- Find a way to get cell centroid coordinates using casefile produced by post


## 19/09 UPDATE 2

We no longer need cell centroids - .post exports in nodes already. See `/WEEK8/READ_POST_NODES.ipynb` for simplest case of reading 3 variables. Will try to save them as npz to see how much smaller we can get them. 

Update: not recorded on github but I tried saving some to npz:

``` python 
    np.savez_compressed(
            data_folder+data_files[-1].split(".")[0],
            node_x=node_x,
            node_y=node_y,
            U=U,
            V=V,
            T=T
        )
```

...however the npz file turned out to be 6MB which is larger than the post file itself. I'm not sure what the most efficient filetype is for this yet.

------------------

# POST-Friday Meeting
Based on the cumulative mean and STDEV plots, 1000s of flow time (or for a simulation delta-t of 0.05s, 20000 timesteps) is adequate for statistical convergence. Can save every 2 timesteps.
Therefore the time stats are:
- delta-t simulation: 0.05s
- flowtime: 1000s
- no. timesteps: 20000

We will try to achieve this using:
- 5000 iterations in steady state
- 2000 iterations in transient
- 20000 iterations in transient, saving .post files every other timestep.

As of a test run in 21/09, this configuration will take approx. 6 hours. 

