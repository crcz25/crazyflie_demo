"""Takeoff-hover-land for one CF. Useful to validate hardware config."""

# from pycrazyswarm import Crazyswarm
from crazyflie_py import Crazyswarm
import numpy as np

TAKEOFF_DURATION = 2.5
HOVER_DURATION = 5.0


def main():
    try:
        swarm = Crazyswarm()
        timeHelper = swarm.timeHelper

        allcfs = swarm.allcfs

        for cf in allcfs.crazyflies:
            print(f'Drone ID: {cf.prefix}')
            print(f'Initial position: {cf.initialPosition}')


        z = 1.0
        allcfs.takeoff(targetHeight=z, duration=TAKEOFF_DURATION)
        timeHelper.sleep(TAKEOFF_DURATION + HOVER_DURATION)

        for cf in allcfs.crazyflies:
            pos = np.array(cf.initialPosition) + np.array([0.0, 1.0, 1.0])
            cf.goTo(goal=pos, yaw=0.0, duration=2.0)

            print(f'Drone ID: {cf.prefix}')
            print(f'Initial position: {cf.initialPosition}')

        timeHelper.sleep(5.0)

        allcfs.land(targetHeight=0.04, duration=2.5)
        timeHelper.sleep(TAKEOFF_DURATION)

    except KeyboardInterrupt:
        # Press Ctrl-C to stop the program and land all CFs
        pass
    finally:
        if swarm is not None:
            cf.land(targetHeight=0.04, duration=2.5)
            timeHelper.sleep(TAKEOFF_DURATION)

if __name__ == "__main__":
    main()
