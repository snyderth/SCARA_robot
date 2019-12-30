import numpy as np
import matplotlib as mpt
import matplotlib.pyplot as plt
from enum import Enum

class methodIK(Enum):
    JACOBIAN_PS = 0
    FABRIK = 1



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
        self.joint_pos = [np.array([0,0])] # First joint is always at origin 0,0
        self.joint_ang = []
        for i in range(len(joint_len)):
            if i is 0:
                x = joint_len[i]
            else:
                x = joint_len[i] + joint_len[i-1]
                # print(self.joint_pos[i-1])
            # All joints start in pure positive x position
            y = 0
            ang = 0
            self.joint_pos.append(np.array([x, y]))
            self.joint_ang.append(ang)
            
        print(self.joint_ang)

        self.length_max = 0
        for x in self.joint_lengths:
            self.length_max += x


        self.target = None
        self.target_dist = None
        self.target_tolerance = 0.1
        


    def set_target(self, x, y):
        self.target = (x, y)
        self.target_dist = np.sqrt(x**2 + y**2)

    def linear_spline(self, last, first, step_size):

        slope = (last[1] - first[1]) / (last[0] - first[0])
        yint = last[1] - (last[0] * slope)
        line_len = (last[0] - first[0]) / step_size
        
        line = []
        print(step_size)
        print(first)
        print(last)
        print(np.arange(first[0], last[0], step_size))
        for i in np.arange(first[0], last[0], step_size):
            line.append((slope * i) + yint)

        return line



    def jacobian_pseudoinverse_method(self):
        while(self.target_dist > self.target_tolerance):
            (x,y) = self.effector_pos()
            dx = self.target[0] - x
            dy = self.target[1] - y
            # step = 0.01
            # line = self.linear_spline(self.target, self.effector_pos(), step)
            # print("Line {}".format(line))
            # for i in range(len(line)):
            #     (x, y) = self.effector_pos()
            #     print("Effector Position: {}, {}".format(x, y))
            #     dx = self.target[0] + (i * step) - x
            #     dy = self.target[1] + line[i] - y
            print("Calculating the partials")
            # Partial derivatives of the forward kinematics equations for the jacobian
            df1dth1 = -self.joint_lengths[0] * np.sin(self.joint_ang[0]) - self.joint_lengths[1] * np.sin(self.joint_ang[0] + self.joint_ang[1])
            df1dth2 = -self.joint_lengths[1] * np.sin(self.joint_ang[0] + self.joint_ang[1])
            df2dth1 = self.joint_lengths[0] * np.cos(self.joint_ang[0]) + self.joint_lengths[1] * np.cos(self.joint_ang[0] + self.joint_ang[1])
            df2dth2 = self.joint_lengths[1] * np.cos(self.joint_ang[0] + self.joint_ang[1])

            print("Joint lengths:")
            print(self.joint_lengths)
            print("Joint angles:")
            print(self.joint_ang)
            print("{}, {}, {}, {}".format(df1dth1, df1dth2, df2dth1, df2dth2))
            
            det_j = (np.square(df1dth1) + np.square(df1dth2)) * (np.square(df2dth1) + np.square(df2dth2))
            det_j -= ((df2dth1 * df1dth1) + (df2dth2 * df1dth2)) * ((df1dth1 * df2dth1) + (df1dth2 * df2dth2))

            print("Jacobian Det: ")
            print(det_j)
            print("Calculating the javobian pseudo inverse")
            if det_j != 0.0:
                a = ((df1dth1 * (np.square(df2dth1) + np.square(df2dth2))) + (df2dth1 * ((-df2dth1 * df1dth1) - (df2dth2 * df1dth2)))) / det_j
                b = ((df1dth1 * (-(df1dth1 * df2dth1) - (df1dth2 * df2dth2))) + (df2dth1 * ((np.square(df1dth1) + np.square(df1dth2))))) / det_j
                c = ((df1dth2 * (np.square(df2dth1) + np.square(df2dth2))) + (df2dth2 * (-(df2dth1 * df1dth1) - (df2dth2 * df1dth2)))) / det_j
                d = ((df1dth2 * (-(df1dth1 * df2dth1) - (df1dth2 * df2dth2))) + (df2dth2 * (np.square(df1dth1) + np.square(df1dth2)))) / det_j
            else:
                a = 0 
                b = 0
                c = 0
                d = 0
            print("Multiplying out by dx and dy")
            th1 = a * dx + b * dy
            th2 = c * dx + d * dy

            print("dx, dy: {}, {}, th1, th2, {}, {}".format(dx, dy, th1, th2))

            self.joint_ang[0] = th1
            self.joint_ang[1] = th2

            self.calc_joint_pos()
            dx = self.target[0] - x
            dy = self.target[1] - y
            self.target_dist = np.sqrt(dx ** 2 + dy ** 2)
        (x, y) = self.effector_pos()

      
        print("Tolerance: {}, Error: {}".format(self.target_tolerance,self.target_dist))




    def calc_joint_pos(self):
        joint_pos = []
        joint_pos.append(np.array((0,0)))
        x1 = self.joint_lengths[0] * np.cos(self.joint_ang[0])
        y1 = self.joint_lengths[0] * np.sin(self.joint_ang[0])
        (x2, y2) = self.effector_pos()
        joint_pos.append(np.array((x1, y1)))
        joint_pos.append(np.array((x2, y2)))
        self.joint_pos = joint_pos


    def FABRIK_method(self):
        if self.target_dist > self.length_max:
            print("Target distance is larger than max reach")
            raise Exception("Error: Target is out of reach")
        else:
            p_0 = self.joint_pos[0] # Set inital origin
            e_pos = np.array(self.effector_pos())

            t = np.array(self.target)
            
            joint_pos_temp = self.joint_pos

            dif_a = np.linalg.norm(t-e_pos)

            while dif_a > self.target_tolerance:
                # Move from the effector to the base: Forward reaching
                joint_pos_temp[len(joint_pos_temp)-1] = self.target

                for i in reversed(range(len(joint_pos_temp)-1)):
                    r_i = np.linalg.norm(joint_pos_temp[i] - joint_pos_temp[i+1])
                    # if(r_i == 0):
                    lambda_i = float(self.joint_lengths[i]) / float(r_i)
                    # print("1. Joint number {} at {}".format(i, joint_pos_temp[i]))
                    joint_pos_temp[i] = np.multiply((1-lambda_i),joint_pos_temp[i+1]) + np.multiply(lambda_i,joint_pos_temp[i])
                    # print("2. Joint number {} at {}".format(i, joint_pos_temp[i]))

                # Backward reaching
                # set the initial position of root back
                joint_pos_temp[0] = p_0
                for i in range(len(joint_pos_temp)-1):
                    r_i = np.linalg.norm(joint_pos_temp[i+1] - joint_pos_temp[i])
                    # if(r_i == 0):
                    lambda_i = float(self.joint_lengths[i]) / float(r_i)
                    joint_pos_temp[i+1] = np.multiply((1-lambda_i), joint_pos_temp[i]) + np.multiply(lambda_i, joint_pos_temp[i+1])
                    # print("Joint number {} at {}".format(i+1, joint_pos_temp[i+1]))
                dif_a = (np.linalg.norm(t - joint_pos_temp[len(joint_pos_temp)-1]))
                # print("Difference: {}".format(dif_a))

            

            #Set the positions and calculate the angles
            self.joint_pos = joint_pos_temp
            self.calc_angles()                    


    def check_position_viability(self):
        (x, y) = self.effector_pos()
        length = np.sqrt(x**2 + y**2)
        if length < 10.85 or length > 11.15:
            print("ERROR: Not a viable solution.") 

    def effector_pos(self):
        x = 0
        y = 0
        x = self.joint_lengths[0] * np.cos(self.joint_ang[0]) + self.joint_lengths[1] * np.cos(self.joint_ang[0] + self.joint_ang[1])
        y = self.joint_lengths[0] * np.sin(self.joint_ang[0]) + self.joint_lengths[1] * np.sin(self.joint_ang[0] + self.joint_ang[1])
        
        return (x, y)


    def run(self, method):
        if self.target is None:
            raise Exception("Error: No target has been set")
        
        # algorithms = {
        #     methodIK.JACOBIAN_PS: self.jacobian_pseudoinverse_method,
        #     methodIK.FABRIK: self.FABRIK_method,
        # }

        # algorithms[method]

        self.jacobian_pseudoinverse_method()
        self.check_position_viability()
        self.draw()


    def draw(self):
        x_pos = [x[0] for x in self.joint_pos]
        y_pos = [y[1] for y in self.joint_pos]
        plt.plot(x_pos, y_pos, 'bo--', linewidth=2, markersize=12)
        plt.xlim((0, 11))
        plt.ylim((0, 8.5))
        plt.show()
        

    def calc_angles(self):
         for i in range(1, len(self.joint_pos)):
            if i is 1:
                self.joint_ang[i-1] = np.arctan2(self.joint_pos[i][1], self.joint_pos[i][0])
            else:
                self.joint_ang[i-1] = np.arctan2(self.joint_pos[i][1], self.joint_pos[i][0]) - self.joint_ang[i-2]

           
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

    

    robot.set_target(10.5, 0.25)
    robot.run(methodIK.FABRIK)

    print("Current joint angles: {}".format(robot.angles()))
    print("Current joint pos: {}".format(robot.pos()))