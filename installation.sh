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
source ~/crazyflies_ws/install/setup.bash
ros2 launch crazyflie_examples keyboard_velmux_launch.py
ros2 launch crazyflie launch.py backend:=sim


