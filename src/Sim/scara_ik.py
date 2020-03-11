##
# @file
# Scara inverse kinematics class.
"""
File:   scara_ik.py
Description: The scara inverse kinematics solver that implements
            4 different methods to the SCARA inverse kinematics
            problem. 
Author: Thomas Snyder
Date:   3/5/2020
"""
import numpy as np
import matplotlib as mpt
import matplotlib.pyplot as plt
import matplotlib.animation as animation
from enum import Enum
import logging

class methodIK(Enum):
    JACOBIAN_PS = 0
    FABRIK = 1
    JACOBIAN_INV = 2
    GEOMETRIC = 3


class SCARA_IK:
    """
    A class to calculate the inverse kinematics of an N-link SCARA robot
    For an N-link robot, there are N joints
    """

    def __init__(self, joint_len):
        """
        joint_len: List of doubles. The double at index i represents the length of link i
        Assume: starting angle is 0 degrees for all angles
        """
        self.log = logging.getLogger(__name__)
        # self.log.setLevel(logging.DEBUG)

        self.joint_lengths = joint_len

        self.joint_pos = [np.array([0,0])] # First joint is always at origin 0,0
        self.joint_ang = []


        for i in range(len(joint_len)):
            if i is 0:
                x = joint_len[i]
            else:
                x = joint_len[i] + joint_len[i-1]
                # self.log.debug(self.joint_pos[i-1])
            # All joints start in pure positive x position
            y = 0
            ang = np.pi / 4
            self.joint_pos.append(np.array([x, y]))
            self.joint_ang.append(ang)

        self.calc_joint_pos()
        # self.draw()
        self.log.debug(self.joint_ang)

        self.length_max = 0
        for x in self.joint_lengths:
            self.length_max += x


        self.target = None
        self.target_dist = None
        self.target_tolerance = 0.1
        
        # For animation
        self.arm_path_sim = []
        self.anim_iter = 0
        self.anim_iter_max = 0


        
    
    def plan_path(self, delta = 0.1):
        """ Path planning function that takes the amount of change between points
        on the path
        
        Args:
            delta(float): norm distance between path points

        Returns:
            list of tuples. The returned list::

                A list of tuples that describes the path in x and y
                coordinates whose norm distance from the previous
                coordinate is less than the delta argument provided.
        """
        (curr_x, curr_y) = self.effector_pos()
        # self.log.debug("Current Position: {},{}".format(curr_x, curr_y))
        targ_x = self.target[0]
        targ_y = self.target[1]
        # self.log.debug("Target Position: {}, {}".format(targ_x, targ_y))
        
        dx = targ_x - curr_x
        dy = targ_y - curr_y
        # self.log.debug("dx: {}, dy: {}".format(dx, dy))
        if np.abs(dx) > np.abs(dy):
            steps = (int)(np.floor(np.abs(dx) / delta))
        else:
            steps = (int)(np.floor(np.abs(dy) / delta))

        # self.log.debug("Number of steps: {}".format(steps))
        step_sz_x = dx / steps
        step_sz_y = dy / steps

        xpath = [(x * step_sz_x) + curr_x for x in range(1, steps)]
        ypath = [(y * step_sz_y) + curr_y for y in range(1, steps)]

        path = list(zip(xpath, ypath))
        path.append(self.target)
        self.log.debug(path)
        return path
        


    def set_target(self, x, y):
        # if INCHES == False:
        #     x = x * CONVERSION
        #     y = y * CONVERSION

        self.log.info("Attemting to set target: ({}, {})".format(x, y))
        if np.sqrt(x**2 + y**2) > self.max_len():
            raise Exception("Target out of reach")
        else:
            self.target = (x, y)
            self.target_dist = np.sqrt(x**2 + y**2)
        

    def linear_spline(self, last, first, step_size):

        slope = (last[1] - first[1]) / (last[0] - first[0])
        yint = last[1] - (last[0] * slope)
        line_len = (last[0] - first[0]) / step_size
        
        line = []
        self.log.debug(step_size)
        self.log.debug(first)
        self.log.debug(last)
        self.log.debug(np.arange(first[0], last[0], step_size))
        for i in np.arange(first[0], last[0], step_size):
            line.append((slope * i) + yint)

        return line



    def geometric_method(self):
        """
        x = l1 cos(th1) + l2 cos(th1 + th2)
        y = l1 sin(th1) + l2 sin(th1 + th2)
        x^2 + y^2 = l1^2 + l_2^2 + 2 l1 l2 cos(th2)


        cos(th2) = (x^2 + y^2 - l1^2 - l2^2) / 2l1l2
        sin(th2) = +/- sqrt(1-cos^2(th2))
        th2 = Atan2(sin(th2), cos(th2)) NOTE: Sign of sin(th2) determines 
                                            manipulator elbow-up (+) or 
                                            elbow-down (-)
        
        k1 = l1 + l2 cos(th2)
        k2 = l2 * sin(th2)

        gamma = Atan2(k2, k1)

        th1 = Atan2(y, x) - Atan2(k2, k1)
        """
        (x, y) = self.effector_pos()

        self.log.debug(self.target[0])
        self.log.debug(self.target[1])
        
        self.log.debug(self.joint_lengths[0])
        self.log.debug(self.joint_lengths[1])
        costh2 = ((self.target[0] ** 2) + (self.target[1] ** 2) - (self.joint_lengths[0] ** 2) - (self.joint_lengths[1] ** 2)) / (2 * self.joint_lengths[0] * self.joint_lengths[1])
        sinth2 = np.sqrt(1 - (costh2 ** 2))
        th2 = np.arctan2(sinth2, costh2)
        self.log.debug("CosTh2: {}".format(costh2))
        self.log.debug("SinTh2: {}".format(sinth2))
        k1 = self.joint_lengths[0] + self.joint_lengths[1] * costh2
        k2 = self.joint_lengths[1] * sinth2
        self.log.debug("len2: {}".format(self.joint_lengths[1]))
        self.log.debug("k1: {}, k2: {}".format(k1, k2))
        gamma = np.arctan2(k2, k1)
        th1 = np.arctan2(self.target[1], self.target[0]) - gamma
        self.log.debug("Gamma: {}".format(gamma))
        self.log.debug("Arctan xy: {}".format(th1 + gamma))
        self.log.debug("Joint Steps: 1: {} 2: {}".format((th1 - self.joint_ang[0]) * 31.8310155049, (th2-self.joint_ang[1]) * 31.8310155049))

        if self.joint_ang[0] is None or self.joint_ang[1] is None:
            self.log.critical("One of the joint angles is None!!")
            self.log.critical("Joint 1: {}, Joint 2: {}".format(self.joint_ang[0], self.joint_ang[1]))
        diff1 = th1 - self.joint_ang[0]
        diff2 = th2 - self.joint_ang[1]
        
        # self.joint_ang[0] = th1
        # self.joint_ang[1] = th2
        # self.calc_joint_pos()
        # self.draw()

        

        steps1 = 31.8310155049 * diff1
        steps2 = 31.8310155049 * diff2
        dir1 = steps1 / abs(steps1)
        dir2 = steps2 / abs(steps2)

        steps1 = abs(steps1)
        steps2 = abs(steps2)

        diffX = self.target[0] - x
        diffY = self.target[1] - y


        # for interpolating and mirroroing after the for loop
        if max((abs(steps1)), (abs(steps2))) != 0:
            xInc = diffX / (max((abs(steps1)), (abs(steps2))))
            yInc = diffY / (max((abs(steps1)), (abs(steps2))))
        
            

        self.log.debug("Starting Joint 1:{}, 2:{}".format(self.joint_ang[0], self.joint_ang[1]))
        self.log.debug("Target: {}, {}".format(th1, th2))
        for i in range(max(int(steps1), int(steps2))):
            if(steps1 > 0):
                self.joint_ang[0] += dir1 * 1.8 * np.pi / 180
                steps1 -= 1
            if(steps2 > 0):
                self.joint_ang[1] += dir2 * 1.8 * np.pi / 180
                steps2 -= 1
            self.calc_joint_pos()
            self.arm_path_sim.append((self.joint_pos[2][0], self.joint_pos[2][1]))


        mapped_path = [( -2 * (actual[0] - (xInc * i + x)) + actual[0] ,  -2 * (actual[1] - (yInc * i + y)) + actual[1]) for i, actual in enumerate(self.arm_path_sim)]
        # mapped_path = [((2 * (actual[0] - (xInc * i)) + actual[0]), (2 * (actual[1] - (yInc * i)) + actual[1])) for i, actual in enumerate(self.arm_path_sim)]

        # Constrain x, y to >= 0
        mapped_path = [(point[0] if point[0] >= 0 else 0, point[1] if point[1] >= 0 else 0) for point in mapped_path ]

        ypoints = [point[1] for point in mapped_path]
        xpoints = [point[0] for point in mapped_path]
        xline = [(x + (i * xInc)) for i in range(len(self.arm_path_sim))]
        yline = [y + (i * yInc) for i in range(len(self.arm_path_sim))]

        

        self.log.debug("\n\nMAPPED:\n\t{}\n\n".format(mapped_path))

        # plt.plot(xpoints, ypoints)
        # plt.plot(xline, yline)
        # plt.show()

        self.log.debug("End point: {},{}".format(self.joint_ang[0], self.joint_ang[1]))
        # self.joint_ang[0] = th1
        # self.joint_ang[1] = th2
        self.log.debug("Joint Angles: {}, {}".format(th1, th2))

        self.calc_joint_pos()

        return mapped_path
            

    

    def get_joint_trajectory(self):
        """ Returns a list of tuples describing the actual path of the end effector between 
        """
        return self.arm_path_sim


    def calc_joint_pos(self):
        joint_pos = []
        joint_pos.append(np.array((0,0)))
        x1 = self.joint_lengths[0] * np.cos(self.joint_ang[0])
        y1 = self.joint_lengths[0] * np.sin(self.joint_ang[0])
        (x2, y2) = self.effector_pos()
        joint_pos.append(np.array((x1, y1)))
        joint_pos.append(np.array((x2, y2)))
        self.joint_pos = joint_pos


    def check_position_viability(self):
        (x, y) = self.effector_pos()
        length = np.sqrt(x**2 + y**2)
        if length < 10.95 or length > 11.05:
            self.log.debug("ERROR: Not a viable solution.") 


    def effector_pos(self):
        x = 0
        y = 0
        x = self.joint_lengths[0] * np.cos(self.joint_ang[0]) + self.joint_lengths[1] * np.cos(self.joint_ang[0] + self.joint_ang[1])
        y = self.joint_lengths[0] * np.sin(self.joint_ang[0]) + self.joint_lengths[1] * np.sin(self.joint_ang[0] + self.joint_ang[1])
        
        return (x, y)


    def calc_angles(self):
         for i in range(1, len(self.joint_pos)):
            if i is 1:
                self.joint_ang[i-1] = np.arctan2(self.joint_pos[i][1], self.joint_pos[i][0])
            else:
                self.joint_ang[i-1] = np.arctan2(self.joint_pos[i][1], self.joint_pos[i][0]) - self.joint_ang[i-2]

           
    def max_len(self) -> float:
        return self.length_max


    def angles(self):
        return self.joint_ang


    def pos(self):
        return self.joint_pos

