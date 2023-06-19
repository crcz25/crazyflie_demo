1. Have ROS 2 Galactic or Humble Installed

2. Install dependencies:

sudo apt install libboost-program-options-dev libusb-1.0-0-dev -y
pip3 install rowan
pip3 install cflib transforms3d
sudo apt-get install ros-galactic-tf-transformations


3 Install swig and build python bindings

3.1 Install prerequisites for swig
sudo apt install build-essential libpcre2-dev libpcre3-dev autoconf automake libtool bison git libboost-dev golang-go guile-2.2-dev nodejs node-gyp libwebkit2gtk-4.0-dev lua5.3 liblua5.3-dev mono-devel octave liboctave-dev default-jdk-headless php-cli php-dev python-dev python3-dev r-base ruby ruby-dev tcl-dev scilab libxml2-dev


sudo apt-get install make gcc-arm-none-eabi

sudo apt -y install swig

3.2 Install pycffirmware

pip3 install numpy
sudo apt install build-essential


git clone https://github.com/utiasDSL/pycffirmware.git --recursive
cd ~/pycffirmware/wrapper
chmod +x build_linux.sh
./build_linux.sh

# 4.2.2 Build swig
# cd
# git clone https://github.com/swig/swig.git  -> in home directory
# cd ~/swig
# ./autogen.sh && ./configure && make

# make -k check-test-suite
# make check-python-test-suite
# sudo make install

4. Setup ROS 2 workspace
mkdir -p ~/crazyflie-ws/src
cd ~/crazyflie-ws/src
git clone https://github.com/IMRCLab/crazyswarm2 --recursive
git clone --branch ros2 --recursive https://github.com/IMRCLab/motion_capture_tracking.git
cd ../
colcon build --symlink-install



5 Build Crazyflie firmware

git clone --recursive https://github.com/bitcraze/crazyflie-firmware.git -> in home directory
cd ~/crazyflie-firmware

make cf2_defconfig
make -j 12

make tag_defconfig
make -j 12

make cf2_defconfig
make bindings_python

make unit

6. Export builds to path
export PYTHONPATH=~/crazyflie-firmware/build:$PYTHONPATH

7. Run example
source ~/crazyflie-ws/install/setup.bash
ros2 launch crazyflie_examples keyboard_velmux_launch.py -> dron real

ros2 launch crazyflie launch.py backend:=sim
ros2 run crazyflie_examples hello_world --ros-args -p use_sim_time:=True



# Install client
sudo apt install git python3-pip libxcb-xinerama0
pip3 install --upgrade pip

# Set instructions
sudo groupadd plugdev
sudo usermod -a -G plugdev $USER

cat <<EOF | sudo tee /etc/udev/rules.d/99-bitcraze.rules > /dev/null
# Crazyradio (normal operation)
SUBSYSTEM=="usb", ATTRS{idVendor}=="1915", ATTRS{idProduct}=="7777", MODE="0664", GROUP="plugdev"
# Bootloader
SUBSYSTEM=="usb", ATTRS{idVendor}=="1915", ATTRS{idProduct}=="0101", MODE="0664", GROUP="plugdev"
# Crazyflie (over USB)
SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="5740", MODE="0664", GROUP="plugdev"
EOF

sudo udevadm control --reload-rules
sudo udevadm trigger

pip3 install cfclient

# Test
cfclient


# Get the address to connect via radio
1. first connect the drone via usb
2. launch the client
3. go to connect-> connect to crazyflie->
4. Get the address: connect->configure 2.x->Radio Address
5. click disconnect
6. Unplug the drone

#Connect via radio
5. plug the radio
6. insert the address from the previous step in the field "Address"
7. click scan
8. click connect 


# Install vrpn
# mkdir -p ~/crazyflie-ws/src
# cd ~/crazyflie-ws/src
# clone repo in home directory
git clone --single-branch --branch debian/noetic/vrpn https://github.com/ajordan5/vrpn_client_ros2.git

git clone --single-branch https://github.com/ajordan5/vrpn_client_ros2.git