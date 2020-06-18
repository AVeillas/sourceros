#!/bin/bash

# Display help
if [[ $1 == "-h" ]] || [[ $1 == "--help" ]]
then
  echo "Usage: sourceros WORKSPACE_DIR"
  echo
  echo "Sources the ROS distribution and workspace at WORKSPACE_DIR."
  echo
  echo "Please create a file at the root of the workspace called '.rosdistro'"
  echo "containing the name of the target ROS distribution."
  echo "Supported distros: kinetic, melodic, noetic, dashing, eloquent"
  return
fi

WORKSPACE_DIR=""

# Check if a workspace dir is specified and valid
if [ $# -eq 0 ]
then
  echo "ERROR: Please specify the workspace directory."
  return
fi
WORKSPACE_DIR=$1
if [ ! -d "$WORKSPACE_DIR" ]
then
  echo "ERROR: Workspace directory does not exist."
  return
fi

# Read the .rosdistro file
input="$WORKSPACE_DIR/.rosdistro"
if [ ! -f "$input" ]
then
  echo "ERROR: .rosdistro file not found."
  echo "Make sure that $WORKSPACE_DIR is the workspace you want to source,"
  echo "and create a '.rosdistro' file in it containing the name of the distro."
  return
fi
read -r distro < "$input"

# Source the ros distro
if [ ! -d "/opt/ros/$distro" ]
then
  echo "ERROR: ROS $distro not found."
  echo "Make sure the correct distro is installed at the default directory."
  return
fi
source /opt/ros/$distro/setup.bash


# Print sourced distro and source the workspace
cd "$WORKSPACE_DIR"
case $distro in
  "kinetic" | "melodic" | "noetic")

    echo "Sourced ROS $distro."
    if [ ! -d "devel" ]
    then
      echo "ERROR: Cannot find the workspace devel directory."
      echo "Use 'catkin_make' to initialize the workspace."
      return
    fi
    source devel/setup.bash
    ;;
  "dashing" | "eloquent")
    echo "Sourced ROS 2 $distro."
    if [ ! -d "install" ]
    then
      echo "ERROR: Cannot find the workspace install directory."
      echo "Use 'colcon build' to initialize the workspace."
      return
    fi
    source install/setup.bash
    ;;
  *)
    echo "ERROR: Unrecognized / unsupported distro: $distro."
    return
    ;;
esac
echo "Sourced workspace."

return