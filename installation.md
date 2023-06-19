# Installation instructions to run the project locally
This file only shows how to install the necessary libraries. Please continue with the file `demo` to test the installation if you've already done this step.

## Prerequisites
### 1. Install ROS 2 Galactic
Follow the instructions in the [ROS 2 Galactic installation guide](https://docs.ros.org/en/galactic/Installation.html). 

<br>

## Dependencies
### 1. Install the following packages.
```sudo apt install libboost-program-options-dev libusb-1.0-0-dev -y```

```pip3 install rowan```

```pip3 install cflib transforms3d```

```sudo apt-get install ros-galactic-tf-transformations```

### 2. Install swig and extra packages to build the repositories.
```sudo apt install build-essential libpcre2-dev libpcre3-dev autoconf automake libtool bison git libboost-dev golang-go guile-2.2-dev nodejs node-gyp libwebkit2gtk-4.0-dev lua5.3 liblua5.3-dev mono-devel octave liboctave-dev default-jdk-headless php-cli php-dev python-dev python3-dev r-base ruby ruby-dev tcl-dev scilab libxml2-dev```

```sudo apt-get install make gcc-arm-none-eabi```

```sudo apt-get install swig```

### 3. Install pycffirmware.
#### 1. Install the dependencies.
```pip3 install numpy```

```sudo apt install build-essential```

#### 2. Clone and build the repository.
**Note:** clone the repository in the home directory:

```git clone https://github.com/utiasDSL/pycffirmware.git --recursive```

```cd ~/pycffirmware/wrapper```

```chmod +x build_linux.sh```

```./build_linux.sh```

<br>

## Setup ROS Workspace

```mkdir -p ~/crazyflie-ws/src```

```cd ~/crazyflie-ws/src```

```git clone https://github.com/IMRCLab/crazyswarm2 --recursive```

```git clone --branch ros2 --recursive https://github.com/IMRCLab/motion_capture_tracking.git```

```cd ../```

```colcon build --symlink-install```

<br>

## Build Crazyflie firmware
**Note:** clone the repository in the home directory:

```git clone --recursive https://github.com/bitcraze/crazyflie-firmware.git```

```cd ~/crazyflie-firmware```

```make cf2_defconfig```

```make -j 12```

```make tag_defconfig```

```make -j 12```

```make cf2_defconfig```

```make bindings_python```

```make unit```

<br>

## Export the path of the firmware
**Note:** you could add the following export to the .bashrc file in the home directory to avoid exporting the path every time you open a new terminal.

```export PYTHONPATH=~/crazyflie-firmware/build:$PYTHONPATH```

<br>

## Install Crazyflie client
```sudo apt install git python3-pip libxcb-xinerama0```

```pip3 install --upgrade pip```

### 1. Give permission to the USB Radio and Crazyflie 2 over USB without being root.
```sudo groupadd plugdev```

```sudo usermod -a -G plugdev $USER```
```
cat <<EOF | sudo tee /etc/udev/rules.d/99-bitcraze.rules > /dev/null
# Crazyradio (normal operation)
SUBSYSTEM=="usb", ATTRS{idVendor}=="1915", ATTRS{idProduct}=="7777", MODE="0664", GROUP="plugdev"
# Bootloader
SUBSYSTEM=="usb", ATTRS{idVendor}=="1915", ATTRS{idProduct}=="0101", MODE="0664", GROUP="plugdev"
# Crazyflie (over USB)
SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="5740", MODE="0664", GROUP="plugdev"
EOF
```

```sudo udevadm control --reload-rules```

```sudo udevadm trigger```

<br>

### Install the client
```pip3 install cfclient```

<br>

# References
https://imrclab.github.io/crazyswarm2/installation.html#first-installation

https://www.bitcraze.io/documentation/tutorials/getting-started-with-crazyflie-2-x/#config-client

https://www.bitcraze.io/documentation/repository/crazyflie-clients-python/master/installation/install/

https://www.bitcraze.io/documentation/repository/crazyflie-lib-python/master/installation/install/

