I use `stage` and `current` to differentiate between the two. I use stage to refer to the stage cluster that I am testing and current is the current cluster that we are using and I am comparing it with the stage cluster.

Observations:

1. stage does not close the connection and it freezes the connection. This is not the case with current.

stage:

    client_loop: send disconnect: Broken pipe

current:

    Connection to cirrostratus.it.emory.edu closed by remote host.
    Connection to cirrostratus.it.emory.edu closed.

2. ssh-copy-id net_id@cirrostratus-stage.it.emory.edu it does not work. 
3. I had to remove the .ssh folder to make the scp work smoothly. 
