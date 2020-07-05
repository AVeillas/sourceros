# sourceros

**A simple bash script to source your ROS or ROS2 environment and workspace in one command !**

This script is especially useful if you have more than one ROS / ROS2 distribution installed and/or several workspaces. 
Just specify which workspace you want to source, and sourceros will automatically source the correct ROS distro, source the workspace, and cd you in it.

Sourceros supports ROS kinetic, melodic, noetic and ROS2 dashing, eloquent.

## Setting up your workspace
In order to know which ROS distro is associated with a workspace, sourceros looks for a `.rosdistro` file at the root of the workspace directory, containing the codename of the distro.

To easily create this file, run the following command in your workspace:

    echo distro_name >> .rosdistro

replacing `distro_name` by one of the following: 

* `kinetic`
* `melodic`
* `noetic`
* `dashing`
* `eloquent`

## Using sourceros
As sourceros is meant to initialize your environment, it needs to be sourced to work properly.

To run it, use the following command : 

    source sourceros.sh path/to/your/workspace

The path to the workspace can be absolute or relative. To specify the current directory as the workspace, use `source sourceros.sh .`.

### Setting up an alias
It can be useful to setup an alias for sourceros so you don't have to navigate to its directory each time you want to run it. To create an alias, you need to add a line in the `.bash_aliases` in your home directory. For example, if you want to alias sourceros to `sros`, add the following line:

    alias sros='source /absolute/path/to/sourceros.sh'

To create the alias without using an editor, run the following command in your home directory: 

    echo alias sros='source /absolute/path/to/sourceros.sh' >> .bash_aliases
    
 That way, you can run sourceros using `sros path/to/ws` from any directory.
