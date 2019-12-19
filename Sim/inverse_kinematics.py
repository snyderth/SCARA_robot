import numpy as np
import matplotlib as mpt
import matplotlib.pyplot as plt




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
                print(self.joint_pos[i-1])
            # All joints start in pure positive x position
            y = 0
            ang = 0
            self.joint_pos.append(np.array([x, y]))
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
        
        self.FABRIK_method()

        self.draw()


    def draw(self):
        x_pos = [x[0] for x in self.joint_pos]
        y_pos = [y[1] for y in self.joint_pos]
        plt.plot(x_pos, y_pos, 'bo--', linewidth=2, markersize=12)
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



    robot.set_target(0, 10)
    robot.run()

    print("Current joint angles: {}".format(robot.angles()))
    print("Current joint pos: {}".format(robot.pos()))

