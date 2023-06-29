"""Takeoff-hover-land for one CF. Useful to validate hardware config."""

# from pycrazyswarm import Crazyswarm
from crazyflie_py import Crazyswarm
import numpy as np
import rclpy
from rclpy.node import Node
from random import randint
import nav_msgs.msg
from crazyflie_interfaces.msg import TrajectoryPolynomialPiece, FullState, Position, Hover


TAKEOFF_DURATION = 2.5
HOVER_DURATION = 5.0


class Drone(Node):
    def __init__(self):
        super().__init__(f'tf2_listener_{randint(0, 1000)}')
        qos_policy = rclpy.qos.QoSProfile(
            reliability=rclpy.qos.ReliabilityPolicy.BEST_EFFORT,
            history=rclpy.qos.HistoryPolicy.KEEP_LAST,
            depth=1
        )

        self._full_state =  self.create_subscription(Hover, '/cf1/cmd_hover', self._cmd_full_state_callback, 1)
        self._position = self.create_subscription(nav_msgs.msg.Odometry, '/cf1/odom', self._cmd_position_callback, 1)

    def _cmd_full_state_callback(self, msg):
        self.get_logger().info(f'HOVER')
        print(msg)

    def _cmd_position_callback(self, msg):
        # self.get_logger().info(f'Position: {msg}')
        # print(f'Position: {msg}')
        pass

def main(args=None):

    rclpy.init(args=args)

    node = Drone()

    rclpy.spin(node)

    node.destroy_node()
    rclpy.shutdown()

    # try:
    #     swarm = Crazyswarm()
    #     timeHelper = swarm.timeHelper

    #     allcfs = swarm.allcfs

    #     for cf in allcfs.crazyflies:
    #         print(f'Drone ID: {cf.prefix}')
    #         print(f'Initial position: {cf.initialPosition}')


    #     z = 1.0
    #     allcfs.takeoff(targetHeight=z, duration=TAKEOFF_DURATION)
    #     timeHelper.sleep(TAKEOFF_DURATION + HOVER_DURATION)

    #     for cf in allcfs.crazyflies:
    #         pos = np.array(cf.initialPosition) + np.array([0.0, 1.0, 1.0])
    #         cf.goTo(goal=pos, yaw=0.0, duration=2.0)

    #         print(f'Drone ID: {cf.prefix}')
    #         print(f'Initial position: {cf.initialPosition}')

    #     timeHelper.sleep(5.0)

    #     allcfs.land(targetHeight=0.04, duration=2.5)
    #     timeHelper.sleep(TAKEOFF_DURATION)

    # except KeyboardInterrupt:
    #     # Press Ctrl-C to stop the program and land all CFs
    #     pass
    # finally:
    #     if swarm is not None:
    #         cf.land(targetHeight=0.04, duration=2.5)
    #         timeHelper.sleep(TAKEOFF_DURATION)

if __name__ == "__main__":
    main()
