import numpy as np
import matplotlib as plt




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
        self.joint_lengths = joint_len
        self.joint_pos = [(0,0)] # First joint is always at origin 0,0
        self.joint_ang = []
        for i in range(len(joint_len)):
            if i is 0:
                x = joint_len[i]
            else:
                x = joint_len[i] + self.joint_pos[i-1][0]
            y = 0
            ang = 0
            self.joint_pos.append((x, y))
            self.joint_ang.append(ang)
            

        self.length_max = 0
        for x in self.joint_lengths:
            self.length_max += x


        self.target = None
        self.target_dist = None
        self.target_tolerance = 0.1

    def set_target(self, x, y):
        self.target = (x, y)
        self.target_dist = np.sqrt(x**2 + y**2)

    def jacobian_method(self):
        pass

    def FABRIK_method(self):
        if self.target_dist > self.length_max:
            raise Exception("Error: Target is out of reach")
        else:
            p_0 = joint_pos[0] # Set inital origin
            e_pos = np.array(self.effector_pos())
            t = np.array(self.target)
            

    def effector_pos(self):
        x = 0
        y = 0
        for i in range(len(self.joint_pos)):
            x += self.joint_pos[i][0]
            y += self.joint_pos[i][1]
        return (x, y)


    def run(self):
        if self.target is None:
            raise Exception("Error: No target has been set")
            
    def calc_angles(self):
        for i in range(len(self.joint_pos)):
            pos = self.joint_pos[i]
            angle = np.arctan2(pos[1], pos[0])
                
            if i is 0:
                # First joint
                self.joint_ang[i] = angle
            else:
                # Must transform other joint coordinates
                cumu_ang = 0
                for j in range(i):
                    cumu_ang += self.joint_ang[j]
                
                self.joint_ang[i] = angle - cumu_ang

    def max_len(self):
        return self.length_max

    def angles(self):
        return self.joint_ang

    def pos(self):
        return self.joint_pos

if __name__ == '__main__':
    robot = SCARA_IK([5, 6])

    print("Maximum stretch: {}".format(robot.max_len()))
    print("Current joint angles: {}".format(robot.angles()))
    print("Current joint pos: {}".format(robot.pos()))




        
