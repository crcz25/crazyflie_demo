# Mapping with SLAM Toolbox

## 1. Install the necessary packages.

```sudo apt-get install ros-galactic-slam-toolbox```

## 2. Export the crazyflie-firmware path
```export PYTHONPATH=~/crazyflie-firmware/build:$PYTHONPATH```

## 3. Source the crazyswarm2 ROS workspace
```source ~/crazyflie-ws/install/setup.bash```

## 4. Connect the crazy radio and setup the correct parameteres in the yaml file.
Modify the file crazyflies.yaml located in ~/crazyflie-ws/src/crazyswarm2/crazyflies.yaml and configure the following variables accordingly:
- uri
- type
- motion_capture->enabled (set true or false if you are using motion capture or not)
- firmware_logging->enabled (set true or false if you are logging the data)
- firmware_params->stabilizer->estimator (set to 2)
- firmware_params->stabilizer->controller (set to 1)
- Add the following to the section all->firmware_logging->default_topics:
```
      odom:
        frequency: 10 # Hz
      scan:
        frequency: 10 # Hz
```

## 5. Launch the server with the launch file.
```ros2 launch crazyflie_examples multiranger_mapping_launch.py```

## 6. Open a new terminal and launch rviz2.
```rviz2```

Add the following panels to the window:
- Changed the ‘Fixed frame’ to ‘world

![Alt text](./img/slam/1.png?raw=true)

- ‘Add’ button under displays and ‘by topic’ tab, select the ‘/map’ topic.

![Alt text](./img/slam/2.png?raw=true)

- ‘Add’ button under displays and ‘by display type’ add a transform.

![Alt text](./img/slam/3.png?raw=true)

- ‘Panels’ on the top menu, select ‘add new panel’ and select the SLAMToolBoxPlugin

![Alt text](./img/slam/4.png?raw=true)

After adding all the panels and topics, the window should look like this:

![Alt text](./img/slam/5.png?raw=true)

## 7. Open a new terminal and launch the teleop tool to control the drone.
ros2 run teleop_twist_keyboard teleop_twist_keyboard