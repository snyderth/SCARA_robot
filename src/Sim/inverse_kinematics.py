import numpy as np
import matplotlib as mpt
import matplotlib.pyplot as plt
import matplotlib.animation as animation
from enum import Enum

class methodIK(Enum):
    JACOBIAN_PS = 0
    FABRIK = 1
    JACOBIAN_INV = 2


METHOD = methodIK.JACOBIAN_INV

fig, ax = plt.subplots()
line, = ax.plot([], [], 'bo-', linewidth=2, markersize=12)
ax.grid()
xdata, ydata = [], []


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
            ang = np.pi / 4
            self.joint_pos.append(np.array([x, y]))
            self.joint_ang.append(ang)

        self.calc_joint_pos()
        # self.draw()
        print(self.joint_ang)

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
        # print("Current Position: {},{}".format(curr_x, curr_y))
        targ_x = self.target[0]
        targ_y = self.target[1]
        # print("Target Position: {}, {}".format(targ_x, targ_y))
        
        dx = targ_x - curr_x
        dy = targ_y - curr_y
        # print("dx: {}, dy: {}".format(dx, dy))
        if np.abs(dx) > np.abs(dy):
            steps = (int)(np.floor(np.abs(dx) / delta))
        else:
            steps = (int)(np.floor(np.abs(dy) / delta))

        # print("Number of steps: {}".format(steps))
        step_sz_x = dx / steps
        step_sz_y = dy / steps

        xpath = [(x * step_sz_x) + curr_x for x in range(1, steps)]
        ypath = [(y * step_sz_y) + curr_y for y in range(1, steps)]

        path = list(zip(xpath, ypath))
        path.append(self.target)
        print(path)
        return path
        


    def set_target(self, x, y):
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
        print(step_size)
        print(first)
        print(last)
        print(np.arange(first[0], last[0], step_size))
        for i in np.arange(first[0], last[0], step_size):
            line.append((slope * i) + yint)

        return line



    def jacobian_inverse_method(self):
        # print("Getting x and y position")
        (x, y) = self.effector_pos()

        # Assuming target is small enough
        dx = self.target[0] - x
        dy = self.target[1] - y
        # print("dx, dy: {}, {}".format(dx, dy))
        # Set the distance from current to target position
        # We'll recalculate this every iteration and break our
        # loop once it is less than a tolerance
        self.target_dist = np.sqrt(dx**2 + dy**2)
        # print("Target distance is {}".format(self.target_dist))
        i = 0

        while(self.target_dist > self.target_tolerance):
            i += 1
            # if i > 2000:
                # break
        #     # Calculate the partial derivatives
            # print("Computing partials...")

            df1dth1 = -self.joint_lengths[0] * np.sin(self.joint_ang[0]) - self.joint_lengths[1] * np.sin(self.joint_ang[0] + self.joint_ang[1])
            df1dth2 = -self.joint_lengths[1] * np.sin(self.joint_ang[0] + self.joint_ang[1])
            df2dth1 = self.joint_lengths[0] * np.cos(self.joint_ang[0]) + self.joint_lengths[1] * np.cos(self.joint_ang[0] + self.joint_ang[1])
            df2dth2 = self.joint_lengths[1] * np.cos(self.joint_ang[0] + self.joint_ang[1])

            # print("|{} {}|\n|{} {}|".format(df1dth1, df1dth2, df2dth1, df2dth2))
            J = np.matrix([[df1dth1, df1dth2], [df2dth1, df2dth2]])
            # print("J: {}".format(J))
            # print("Computing the determinant")
            # Calculate the determinant (for inverting)
            # det_j = 0
            # inv_det = ((df1dth1 * df2dth1) - (df1dth2 * df2dth2))
            # if(inv_det != 0):
            #     det_j = 1 / inv_det
            # else:
            #     print("[ERROR] Singularity reached")
            #     exit(1)
            J_inv = J.I

            # print("Computing dthetas")
            # Calculate the change in theta by multiplying the inverse jacobian by the change in x, y
            dxhat = np.matrix([[dx], [dy]])
            # dth1 = ( ( df2dth2 * dx ) - ( df1dth2 * dy ) ) * det_j
            # dth2 = ( ( df1dth1 * dy ) - ( df2dth2 * dx ) ) * det_j
            dthhat =  np.matmul(J_inv, dxhat)
            print(dthhat)
            print(dthhat[0])
            self.joint_ang[0] += dthhat.A[0][0]
            self.joint_ang[1] += dthhat.A[1][0]

            # Recompute where we're at            
            self.calc_joint_pos()
            (x, y) = self.effector_pos()
            dx = self.target[0] - x
            dy = self.target[1] - y
            self.target_dist = np.sqrt(dx**2 + dy**2)
            print("\rIteration {}, Target Distance: {}".format(i, self.target_dist), end=" ")
        print("Iteration {}, Target Distance: {}".format(i, self.target_dist))
        print("Joint angles are now {}".format(self.joint_ang))
        self.target_dist = 1000

   
    def jacobian_pseudoinverse_method(self):
        (x,y) = self.effector_pos()

        dx = self.target[0] - x
        dy = self.target[1] - y
        self.target_dist = np.sqrt(dx ** 2 + dy ** 2)
        iters = 0
        while(self.target_dist > self.target_tolerance):
            # if iters > 2000:
                # break

            # print("Iteration {}".format(iters))
            # iters += 1
            # step = 0.01
            # line = self.linear_spline(self.target, self.effector_pos(), step)
            # print("Line {}".format(line))
            # for i in range(len(line)):
            #     (x, y) = self.effector_pos()
            #     print("Effector Position: {}, {}".format(x, y))
            #     dx = self.target[0] + (i * step) - x
            #     dy = self.target[1] + line[i] - y
            # print("Calculating the partials")
            # Partial derivatives of the forward kinematics equations for the jacobian
            df1dth1 = -self.joint_lengths[0] * np.sin(self.joint_ang[0]) - self.joint_lengths[1] * np.sin(self.joint_ang[0] + self.joint_ang[1])
            df1dth2 = -self.joint_lengths[1] * np.sin(self.joint_ang[0] + self.joint_ang[1])
            df2dth1 = self.joint_lengths[0] * np.cos(self.joint_ang[0]) + self.joint_lengths[1] * np.cos(self.joint_ang[0] + self.joint_ang[1])
            df2dth2 = self.joint_lengths[1] * np.cos(self.joint_ang[0] + self.joint_ang[1])

            
            # Find the determinant
            det_j = (np.square(df1dth1) + np.square(df1dth2)) * (np.square(df2dth1) + np.square(df2dth2))
            det_j -= ((df2dth1 * df1dth1) + (df2dth2 * df1dth2)) * ((df1dth1 * df2dth1) + (df1dth2 * df2dth2))


            # Find the Jacobian
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

            # Multiply the jacobian through the x and y
            # Jacobian:
            #   --         -- --    -- 
            #   |   a   b   | |  dx  |
            #   |   c   d   | |  dy  |
            #   --         -- --    --
            th1 = a * dx + b * dy
            th2 = c * dx + d * dy


            # add change to current angles
            self.joint_ang[0] = self.joint_ang[0] + th1
            self.joint_ang[1] = self.joint_ang[1] + th2

            self.calc_joint_pos()
            (x, y) = self.effector_pos()
            dx = self.target[0] - x
            dy = self.target[1] - y
            self.target_dist = np.sqrt(dx ** 2 + dy ** 2)
      
        self.target_dist = 300



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
        if length < 10.95 or length > 11.05:
            print("ERROR: Not a viable solution.") 




    def effector_pos(self):
        x = 0
        y = 0
        x = self.joint_lengths[0] * np.cos(self.joint_ang[0]) + self.joint_lengths[1] * np.cos(self.joint_ang[0] + self.joint_ang[1])
        y = self.joint_lengths[0] * np.sin(self.joint_ang[0]) + self.joint_lengths[1] * np.sin(self.joint_ang[0] + self.joint_ang[1])
        
        return (x, y)


    def run(self):
        if self.target is None:
            raise Exception("Error: No target has been set")
        self.anim_iter = 0
        # algorithms = {
        #     methodIK.JACOBIAN_PS: self.jacobian_pseudoinverse_method,
        #     methodIK.FABRIK: self.FABRIK_method,
        # }

        # algorithms[method]
        if METHOD == methodIK.JACOBIAN_PS:
            print("")
            self.arm_path_sim.append(self.joint_pos)
            path = self.plan_path()
            for t in path:
                print("Moving to {}".format(t))
                self.target = t
                self.jacobian_pseudoinverse_method()
                self.arm_path_sim.append(self.joint_pos)

            self.anim_iter_max = len(self.arm_path_sim)

        elif METHOD == methodIK.FABRIK:
            self.FABRIK_method()
        
        elif METHOD == methodIK.JACOBIAN_INV:
            # Start the simulator animation at the current position
            self.arm_path_sim.append(self.joint_pos)
            path = self.plan_path() # Plan path between current and target. Assumes target is set
            for t in path:
                print("Moving to {}".format(t))
                # Move to the target
                self.target = t
                # print("Target set... Calculating angles")
                self.jacobian_inverse_method()
                self.arm_path_sim.append(self.joint_pos)
                print("Moved to {}".format(t))

        # self.check_position_viability()

        # self.draw()


    def draw(self):
        x_pos = [x[0] for x in self.joint_pos]
        y_pos = [y[1] for y in self.joint_pos]
        plt.plot(x_pos, y_pos, 'bo--', linewidth=2, markersize=12)
        plt.xlim((-6, 11))
        plt.ylim((-6, 11))
        plt.show()
        

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


### ANIMATION FUNCTIONS ###
    def playback(self):
        for arm_pos in self.arm_path_sim:
            # print("Returning {}, {}".format(x, y))
            yield arm_pos


def init_animation():
    del xdata[:]
    del ydata[:]
    ax.set_ylim(-6, 11)
    ax.set_xlim(-6, 11)
    line.set_data(xdata, ydata)
    return line,

    # (x, y) = self.arm_path_sim[self.anim_iter]
    # self.anim_iter += 1

def animate(data):
    xdata = list()
    ydata = list()
    
    # print("{}, {}".format(x, y))
    xdata = [x for (x, y) in data]
    ydata = [y for (x, y) in data]

    line.set_data(xdata, ydata)
    return line, 

if __name__ == '__main__':
    robot = SCARA_IK([5, 6])

    print("Maximum stretch: {}".format(robot.max_len()))
    print("Current joint angles: {}".format(robot.angles()))
    print("Current joint pos: {}".format(robot.pos()))

    try:
        print("Setting target")
        robot.set_target(7.7, 7.7)
        print("Running math")
        robot.run()
        robot.set_target(3, 9)
        robot.run()
        robot.set_target(5,7)
        robot.run()
        robot.set_target(1,1)
        robot.run()
        animate = animation.FuncAnimation(fig, animate, robot.playback, blit=False, interval=10, repeat=True, init_func=init_animation)
    except Exception as ex:
        print(ex)

    # robot.set_target(1, 8)
    # robot.run(methodIK.FABRIK)
    # animate = animation.FuncAnimation(fig, animate, robot.playback, blit=False, interval=40, repeat=False, init_func=init_animation)


    
    plt.title('SCARA Simulator')
    plt.show()
    print("Current joint angles: {}".format(robot.angles()))
    print("Current joint pos: {}".format(robot.pos()))