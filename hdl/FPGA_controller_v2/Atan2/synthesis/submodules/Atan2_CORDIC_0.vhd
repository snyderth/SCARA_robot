-- ------------------------------------------------------------------------- 
-- High Level Design Compiler for Intel(R) FPGAs Version 18.1 (Release Build #625)
-- Quartus Prime development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2018 Intel Corporation.  All rights reserved.
-- Your use of  Intel Corporation's design tools,  logic functions and other
-- software and  tools, and its AMPP partner logic functions, and any output
-- files any  of the foregoing (including  device programming  or simulation
-- files), and  any associated  documentation  or information  are expressly
-- subject  to the terms and  conditions of the  Intel FPGA Software License
-- Agreement, Intel MegaCore Function License Agreement, or other applicable
-- license agreement,  including,  without limitation,  that your use is for
-- the  sole  purpose of  programming  logic devices  manufactured by  Intel
-- and  sold by Intel  or its authorized  distributors. Please refer  to the
-- applicable agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from Atan2_CORDIC_0
-- VHDL created on Sat Feb 22 22:58:52 2020


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.altera_syncram;
LIBRARY lpm;
USE lpm.lpm_components.all;

entity Atan2_CORDIC_0 is
    port (
        x : in std_logic_vector(31 downto 0);  -- sfix32_en10
        y : in std_logic_vector(31 downto 0);  -- sfix32_en10
        en : in std_logic_vector(0 downto 0);  -- ufix1
        q : out std_logic_vector(12 downto 0);  -- sfix13_en10
        clk : in std_logic;
        areset : in std_logic
    );
end Atan2_CORDIC_0;

architecture normal of Atan2_CORDIC_0 is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal constantZero_uid6_atan2Test_q : STD_LOGIC_VECTOR (31 downto 0);
    signal signX_uid7_atan2Test_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signY_uid8_atan2Test_b : STD_LOGIC_VECTOR (0 downto 0);
    signal invSignX_uid9_atan2Test_q : STD_LOGIC_VECTOR (0 downto 0);
    signal absXE_uid10_atan2Test_a : STD_LOGIC_VECTOR (33 downto 0);
    signal absXE_uid10_atan2Test_b : STD_LOGIC_VECTOR (33 downto 0);
    signal absXE_uid10_atan2Test_o : STD_LOGIC_VECTOR (33 downto 0);
    signal absXE_uid10_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal absXE_uid10_atan2Test_q : STD_LOGIC_VECTOR (32 downto 0);
    signal invSignY_uid11_atan2Test_q : STD_LOGIC_VECTOR (0 downto 0);
    signal absYE_uid12_atan2Test_a : STD_LOGIC_VECTOR (33 downto 0);
    signal absYE_uid12_atan2Test_b : STD_LOGIC_VECTOR (33 downto 0);
    signal absYE_uid12_atan2Test_o : STD_LOGIC_VECTOR (33 downto 0);
    signal absYE_uid12_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal absYE_uid12_atan2Test_q : STD_LOGIC_VECTOR (32 downto 0);
    signal absX_uid13_atan2Test_in : STD_LOGIC_VECTOR (31 downto 0);
    signal absX_uid13_atan2Test_b : STD_LOGIC_VECTOR (31 downto 0);
    signal absY_uid14_atan2Test_in : STD_LOGIC_VECTOR (31 downto 0);
    signal absY_uid14_atan2Test_b : STD_LOGIC_VECTOR (31 downto 0);
    signal yNotZero_uid15_atan2Test_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal yNotZero_uid15_atan2Test_q : STD_LOGIC_VECTOR (0 downto 0);
    signal yZero_uid16_atan2Test_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xNotZero_uid17_atan2Test_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal xNotZero_uid17_atan2Test_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xZero_uid18_atan2Test_q : STD_LOGIC_VECTOR (0 downto 0);
    signal cstArcTan2Mi_0_uid22_atan2Test_q : STD_LOGIC_VECTOR (21 downto 0);
    signal xip1E_1_uid23_atan2Test_a : STD_LOGIC_VECTOR (32 downto 0);
    signal xip1E_1_uid23_atan2Test_b : STD_LOGIC_VECTOR (32 downto 0);
    signal xip1E_1_uid23_atan2Test_o : STD_LOGIC_VECTOR (32 downto 0);
    signal xip1E_1_uid23_atan2Test_q : STD_LOGIC_VECTOR (32 downto 0);
    signal yip1E_1_uid24_atan2Test_a : STD_LOGIC_VECTOR (32 downto 0);
    signal yip1E_1_uid24_atan2Test_b : STD_LOGIC_VECTOR (32 downto 0);
    signal yip1E_1_uid24_atan2Test_o : STD_LOGIC_VECTOR (32 downto 0);
    signal yip1E_1_uid24_atan2Test_q : STD_LOGIC_VECTOR (32 downto 0);
    signal lowRangeB_uid25_atan2Test_in : STD_LOGIC_VECTOR (20 downto 0);
    signal lowRangeB_uid25_atan2Test_b : STD_LOGIC_VECTOR (20 downto 0);
    signal highBBits_uid26_atan2Test_b : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_1_uid28_atan2Test_q : STD_LOGIC_VECTOR (23 downto 0);
    signal aip1E_uid31_atan2Test_in : STD_LOGIC_VECTOR (22 downto 0);
    signal aip1E_uid31_atan2Test_b : STD_LOGIC_VECTOR (22 downto 0);
    signal xMSB_uid32_atan2Test_b : STD_LOGIC_VECTOR (0 downto 0);
    signal cstArcTan2Mi_1_uid36_atan2Test_q : STD_LOGIC_VECTOR (22 downto 0);
    signal invSignOfSelectionSignal_uid37_atan2Test_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_2NA_uid39_atan2Test_q : STD_LOGIC_VECTOR (33 downto 0);
    signal xip1E_2sumAHighB_uid40_atan2Test_a : STD_LOGIC_VECTOR (36 downto 0);
    signal xip1E_2sumAHighB_uid40_atan2Test_b : STD_LOGIC_VECTOR (36 downto 0);
    signal xip1E_2sumAHighB_uid40_atan2Test_o : STD_LOGIC_VECTOR (36 downto 0);
    signal xip1E_2sumAHighB_uid40_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_2sumAHighB_uid40_atan2Test_q : STD_LOGIC_VECTOR (35 downto 0);
    signal yip1E_2NA_uid42_atan2Test_q : STD_LOGIC_VECTOR (33 downto 0);
    signal yip1E_2sumAHighB_uid43_atan2Test_a : STD_LOGIC_VECTOR (35 downto 0);
    signal yip1E_2sumAHighB_uid43_atan2Test_b : STD_LOGIC_VECTOR (35 downto 0);
    signal yip1E_2sumAHighB_uid43_atan2Test_o : STD_LOGIC_VECTOR (35 downto 0);
    signal yip1E_2sumAHighB_uid43_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_2sumAHighB_uid43_atan2Test_q : STD_LOGIC_VECTOR (34 downto 0);
    signal aip1E_2CostZeroPaddingA_uid45_atan2Test_q : STD_LOGIC_VECTOR (1 downto 0);
    signal aip1E_2NA_uid46_atan2Test_q : STD_LOGIC_VECTOR (24 downto 0);
    signal aip1E_2sumAHighB_uid47_atan2Test_a : STD_LOGIC_VECTOR (26 downto 0);
    signal aip1E_2sumAHighB_uid47_atan2Test_b : STD_LOGIC_VECTOR (26 downto 0);
    signal aip1E_2sumAHighB_uid47_atan2Test_o : STD_LOGIC_VECTOR (26 downto 0);
    signal aip1E_2sumAHighB_uid47_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_2sumAHighB_uid47_atan2Test_q : STD_LOGIC_VECTOR (25 downto 0);
    signal xip1_2_uid48_atan2Test_in : STD_LOGIC_VECTOR (33 downto 0);
    signal xip1_2_uid48_atan2Test_b : STD_LOGIC_VECTOR (33 downto 0);
    signal yip1_2_uid49_atan2Test_in : STD_LOGIC_VECTOR (33 downto 0);
    signal yip1_2_uid49_atan2Test_b : STD_LOGIC_VECTOR (33 downto 0);
    signal aip1E_uid50_atan2Test_in : STD_LOGIC_VECTOR (24 downto 0);
    signal aip1E_uid50_atan2Test_b : STD_LOGIC_VECTOR (24 downto 0);
    signal xMSB_uid51_atan2Test_b : STD_LOGIC_VECTOR (0 downto 0);
    signal cstArcTan2Mi_2_uid55_atan2Test_q : STD_LOGIC_VECTOR (23 downto 0);
    signal invSignOfSelectionSignal_uid56_atan2Test_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_3NA_uid58_atan2Test_q : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_3sumAHighB_uid59_atan2Test_a : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_3sumAHighB_uid59_atan2Test_b : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_3sumAHighB_uid59_atan2Test_o : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_3sumAHighB_uid59_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_3sumAHighB_uid59_atan2Test_q : STD_LOGIC_VECTOR (37 downto 0);
    signal yip1E_3NA_uid61_atan2Test_q : STD_LOGIC_VECTOR (35 downto 0);
    signal yip1E_3sumAHighB_uid62_atan2Test_a : STD_LOGIC_VECTOR (37 downto 0);
    signal yip1E_3sumAHighB_uid62_atan2Test_b : STD_LOGIC_VECTOR (37 downto 0);
    signal yip1E_3sumAHighB_uid62_atan2Test_o : STD_LOGIC_VECTOR (37 downto 0);
    signal yip1E_3sumAHighB_uid62_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_3sumAHighB_uid62_atan2Test_q : STD_LOGIC_VECTOR (36 downto 0);
    signal aip1E_3NA_uid65_atan2Test_q : STD_LOGIC_VECTOR (26 downto 0);
    signal aip1E_3sumAHighB_uid66_atan2Test_a : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_3sumAHighB_uid66_atan2Test_b : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_3sumAHighB_uid66_atan2Test_o : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_3sumAHighB_uid66_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_3sumAHighB_uid66_atan2Test_q : STD_LOGIC_VECTOR (27 downto 0);
    signal xip1_3_uid67_atan2Test_in : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1_3_uid67_atan2Test_b : STD_LOGIC_VECTOR (35 downto 0);
    signal yip1_3_uid68_atan2Test_in : STD_LOGIC_VECTOR (34 downto 0);
    signal yip1_3_uid68_atan2Test_b : STD_LOGIC_VECTOR (34 downto 0);
    signal aip1E_uid69_atan2Test_in : STD_LOGIC_VECTOR (26 downto 0);
    signal aip1E_uid69_atan2Test_b : STD_LOGIC_VECTOR (26 downto 0);
    signal xMSB_uid70_atan2Test_b : STD_LOGIC_VECTOR (0 downto 0);
    signal cstArcTan2Mi_3_uid74_atan2Test_q : STD_LOGIC_VECTOR (24 downto 0);
    signal invSignOfSelectionSignal_uid75_atan2Test_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_4CostZeroPaddingA_uid76_atan2Test_q : STD_LOGIC_VECTOR (2 downto 0);
    signal xip1E_4NA_uid77_atan2Test_q : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_4sumAHighB_uid78_atan2Test_a : STD_LOGIC_VECTOR (41 downto 0);
    signal xip1E_4sumAHighB_uid78_atan2Test_b : STD_LOGIC_VECTOR (41 downto 0);
    signal xip1E_4sumAHighB_uid78_atan2Test_o : STD_LOGIC_VECTOR (41 downto 0);
    signal xip1E_4sumAHighB_uid78_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_4sumAHighB_uid78_atan2Test_q : STD_LOGIC_VECTOR (40 downto 0);
    signal yip1E_4NA_uid80_atan2Test_q : STD_LOGIC_VECTOR (37 downto 0);
    signal yip1E_4sumAHighB_uid81_atan2Test_a : STD_LOGIC_VECTOR (39 downto 0);
    signal yip1E_4sumAHighB_uid81_atan2Test_b : STD_LOGIC_VECTOR (39 downto 0);
    signal yip1E_4sumAHighB_uid81_atan2Test_o : STD_LOGIC_VECTOR (39 downto 0);
    signal yip1E_4sumAHighB_uid81_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_4sumAHighB_uid81_atan2Test_q : STD_LOGIC_VECTOR (38 downto 0);
    signal aip1E_4NA_uid84_atan2Test_q : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_4sumAHighB_uid85_atan2Test_a : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_4sumAHighB_uid85_atan2Test_b : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_4sumAHighB_uid85_atan2Test_o : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_4sumAHighB_uid85_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_4sumAHighB_uid85_atan2Test_q : STD_LOGIC_VECTOR (29 downto 0);
    signal xip1_4_uid86_atan2Test_in : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1_4_uid86_atan2Test_b : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1_4_uid87_atan2Test_in : STD_LOGIC_VECTOR (36 downto 0);
    signal yip1_4_uid87_atan2Test_b : STD_LOGIC_VECTOR (36 downto 0);
    signal aip1E_uid88_atan2Test_in : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_uid88_atan2Test_b : STD_LOGIC_VECTOR (28 downto 0);
    signal xMSB_uid89_atan2Test_b : STD_LOGIC_VECTOR (0 downto 0);
    signal cstArcTan2Mi_4_uid93_atan2Test_q : STD_LOGIC_VECTOR (25 downto 0);
    signal invSignOfSelectionSignal_uid94_atan2Test_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_5CostZeroPaddingA_uid95_atan2Test_q : STD_LOGIC_VECTOR (3 downto 0);
    signal xip1E_5NA_uid96_atan2Test_q : STD_LOGIC_VECTOR (42 downto 0);
    signal xip1E_5sumAHighB_uid97_atan2Test_a : STD_LOGIC_VECTOR (45 downto 0);
    signal xip1E_5sumAHighB_uid97_atan2Test_b : STD_LOGIC_VECTOR (45 downto 0);
    signal xip1E_5sumAHighB_uid97_atan2Test_o : STD_LOGIC_VECTOR (45 downto 0);
    signal xip1E_5sumAHighB_uid97_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_5sumAHighB_uid97_atan2Test_q : STD_LOGIC_VECTOR (44 downto 0);
    signal yip1E_5NA_uid99_atan2Test_q : STD_LOGIC_VECTOR (40 downto 0);
    signal yip1E_5sumAHighB_uid100_atan2Test_a : STD_LOGIC_VECTOR (42 downto 0);
    signal yip1E_5sumAHighB_uid100_atan2Test_b : STD_LOGIC_VECTOR (42 downto 0);
    signal yip1E_5sumAHighB_uid100_atan2Test_o : STD_LOGIC_VECTOR (42 downto 0);
    signal yip1E_5sumAHighB_uid100_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_5sumAHighB_uid100_atan2Test_q : STD_LOGIC_VECTOR (41 downto 0);
    signal aip1E_5NA_uid103_atan2Test_q : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_5sumAHighB_uid104_atan2Test_a : STD_LOGIC_VECTOR (32 downto 0);
    signal aip1E_5sumAHighB_uid104_atan2Test_b : STD_LOGIC_VECTOR (32 downto 0);
    signal aip1E_5sumAHighB_uid104_atan2Test_o : STD_LOGIC_VECTOR (32 downto 0);
    signal aip1E_5sumAHighB_uid104_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_5sumAHighB_uid104_atan2Test_q : STD_LOGIC_VECTOR (31 downto 0);
    signal xip1_5_uid105_atan2Test_in : STD_LOGIC_VECTOR (42 downto 0);
    signal xip1_5_uid105_atan2Test_b : STD_LOGIC_VECTOR (42 downto 0);
    signal yip1_5_uid106_atan2Test_in : STD_LOGIC_VECTOR (39 downto 0);
    signal yip1_5_uid106_atan2Test_b : STD_LOGIC_VECTOR (39 downto 0);
    signal aip1E_uid107_atan2Test_in : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_uid107_atan2Test_b : STD_LOGIC_VECTOR (30 downto 0);
    signal xMSB_uid108_atan2Test_b : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid112_atan2Test_b : STD_LOGIC_VECTOR (40 downto 0);
    signal twoToMiSiYip_uid113_atan2Test_b : STD_LOGIC_VECTOR (37 downto 0);
    signal cstArcTan2Mi_5_uid114_atan2Test_q : STD_LOGIC_VECTOR (26 downto 0);
    signal invSignOfSelectionSignal_uid115_atan2Test_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_6NA_uid117_atan2Test_q : STD_LOGIC_VECTOR (45 downto 0);
    signal xip1E_6sumAHighB_uid118_atan2Test_a : STD_LOGIC_VECTOR (48 downto 0);
    signal xip1E_6sumAHighB_uid118_atan2Test_b : STD_LOGIC_VECTOR (48 downto 0);
    signal xip1E_6sumAHighB_uid118_atan2Test_o : STD_LOGIC_VECTOR (48 downto 0);
    signal xip1E_6sumAHighB_uid118_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_6sumAHighB_uid118_atan2Test_q : STD_LOGIC_VECTOR (47 downto 0);
    signal yip1E_6NA_uid120_atan2Test_q : STD_LOGIC_VECTOR (42 downto 0);
    signal yip1E_6sumAHighB_uid121_atan2Test_a : STD_LOGIC_VECTOR (44 downto 0);
    signal yip1E_6sumAHighB_uid121_atan2Test_b : STD_LOGIC_VECTOR (44 downto 0);
    signal yip1E_6sumAHighB_uid121_atan2Test_o : STD_LOGIC_VECTOR (44 downto 0);
    signal yip1E_6sumAHighB_uid121_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_6sumAHighB_uid121_atan2Test_q : STD_LOGIC_VECTOR (43 downto 0);
    signal aip1E_6NA_uid124_atan2Test_q : STD_LOGIC_VECTOR (32 downto 0);
    signal aip1E_6sumAHighB_uid125_atan2Test_a : STD_LOGIC_VECTOR (34 downto 0);
    signal aip1E_6sumAHighB_uid125_atan2Test_b : STD_LOGIC_VECTOR (34 downto 0);
    signal aip1E_6sumAHighB_uid125_atan2Test_o : STD_LOGIC_VECTOR (34 downto 0);
    signal aip1E_6sumAHighB_uid125_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_6sumAHighB_uid125_atan2Test_q : STD_LOGIC_VECTOR (33 downto 0);
    signal xip1_6_uid126_atan2Test_in : STD_LOGIC_VECTOR (45 downto 0);
    signal xip1_6_uid126_atan2Test_b : STD_LOGIC_VECTOR (45 downto 0);
    signal yip1_6_uid127_atan2Test_in : STD_LOGIC_VECTOR (41 downto 0);
    signal yip1_6_uid127_atan2Test_b : STD_LOGIC_VECTOR (41 downto 0);
    signal aip1E_uid128_atan2Test_in : STD_LOGIC_VECTOR (32 downto 0);
    signal aip1E_uid128_atan2Test_b : STD_LOGIC_VECTOR (32 downto 0);
    signal xMSB_uid129_atan2Test_b : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid133_atan2Test_b : STD_LOGIC_VECTOR (39 downto 0);
    signal twoToMiSiYip_uid134_atan2Test_b : STD_LOGIC_VECTOR (35 downto 0);
    signal cstArcTan2Mi_6_uid135_atan2Test_q : STD_LOGIC_VECTOR (27 downto 0);
    signal invSignOfSelectionSignal_uid136_atan2Test_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_7_uid137_atan2Test_a : STD_LOGIC_VECTOR (48 downto 0);
    signal xip1E_7_uid137_atan2Test_b : STD_LOGIC_VECTOR (48 downto 0);
    signal xip1E_7_uid137_atan2Test_o : STD_LOGIC_VECTOR (48 downto 0);
    signal xip1E_7_uid137_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_7_uid137_atan2Test_q : STD_LOGIC_VECTOR (47 downto 0);
    signal yip1E_7_uid138_atan2Test_a : STD_LOGIC_VECTOR (43 downto 0);
    signal yip1E_7_uid138_atan2Test_b : STD_LOGIC_VECTOR (43 downto 0);
    signal yip1E_7_uid138_atan2Test_o : STD_LOGIC_VECTOR (43 downto 0);
    signal yip1E_7_uid138_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_7_uid138_atan2Test_q : STD_LOGIC_VECTOR (42 downto 0);
    signal aip1E_7NA_uid141_atan2Test_q : STD_LOGIC_VECTOR (34 downto 0);
    signal aip1E_7sumAHighB_uid142_atan2Test_a : STD_LOGIC_VECTOR (36 downto 0);
    signal aip1E_7sumAHighB_uid142_atan2Test_b : STD_LOGIC_VECTOR (36 downto 0);
    signal aip1E_7sumAHighB_uid142_atan2Test_o : STD_LOGIC_VECTOR (36 downto 0);
    signal aip1E_7sumAHighB_uid142_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_7sumAHighB_uid142_atan2Test_q : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1_7_uid143_atan2Test_in : STD_LOGIC_VECTOR (45 downto 0);
    signal xip1_7_uid143_atan2Test_b : STD_LOGIC_VECTOR (45 downto 0);
    signal yip1_7_uid144_atan2Test_in : STD_LOGIC_VECTOR (40 downto 0);
    signal yip1_7_uid144_atan2Test_b : STD_LOGIC_VECTOR (40 downto 0);
    signal aip1E_uid145_atan2Test_in : STD_LOGIC_VECTOR (34 downto 0);
    signal aip1E_uid145_atan2Test_b : STD_LOGIC_VECTOR (34 downto 0);
    signal xMSB_uid146_atan2Test_b : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid150_atan2Test_b : STD_LOGIC_VECTOR (38 downto 0);
    signal twoToMiSiYip_uid151_atan2Test_b : STD_LOGIC_VECTOR (33 downto 0);
    signal cstArcTan2Mi_7_uid152_atan2Test_q : STD_LOGIC_VECTOR (28 downto 0);
    signal invSignOfSelectionSignal_uid153_atan2Test_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_8_uid154_atan2Test_a : STD_LOGIC_VECTOR (48 downto 0);
    signal xip1E_8_uid154_atan2Test_b : STD_LOGIC_VECTOR (48 downto 0);
    signal xip1E_8_uid154_atan2Test_o : STD_LOGIC_VECTOR (48 downto 0);
    signal xip1E_8_uid154_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_8_uid154_atan2Test_q : STD_LOGIC_VECTOR (47 downto 0);
    signal yip1E_8_uid155_atan2Test_a : STD_LOGIC_VECTOR (42 downto 0);
    signal yip1E_8_uid155_atan2Test_b : STD_LOGIC_VECTOR (42 downto 0);
    signal yip1E_8_uid155_atan2Test_o : STD_LOGIC_VECTOR (42 downto 0);
    signal yip1E_8_uid155_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_8_uid155_atan2Test_q : STD_LOGIC_VECTOR (41 downto 0);
    signal aip1E_8NA_uid158_atan2Test_q : STD_LOGIC_VECTOR (36 downto 0);
    signal aip1E_8sumAHighB_uid159_atan2Test_a : STD_LOGIC_VECTOR (38 downto 0);
    signal aip1E_8sumAHighB_uid159_atan2Test_b : STD_LOGIC_VECTOR (38 downto 0);
    signal aip1E_8sumAHighB_uid159_atan2Test_o : STD_LOGIC_VECTOR (38 downto 0);
    signal aip1E_8sumAHighB_uid159_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_8sumAHighB_uid159_atan2Test_q : STD_LOGIC_VECTOR (37 downto 0);
    signal xip1_8_uid160_atan2Test_in : STD_LOGIC_VECTOR (45 downto 0);
    signal xip1_8_uid160_atan2Test_b : STD_LOGIC_VECTOR (45 downto 0);
    signal yip1_8_uid161_atan2Test_in : STD_LOGIC_VECTOR (39 downto 0);
    signal yip1_8_uid161_atan2Test_b : STD_LOGIC_VECTOR (39 downto 0);
    signal aip1E_uid162_atan2Test_in : STD_LOGIC_VECTOR (36 downto 0);
    signal aip1E_uid162_atan2Test_b : STD_LOGIC_VECTOR (36 downto 0);
    signal xMSB_uid163_atan2Test_b : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid167_atan2Test_b : STD_LOGIC_VECTOR (37 downto 0);
    signal twoToMiSiYip_uid168_atan2Test_b : STD_LOGIC_VECTOR (31 downto 0);
    signal cstArcTan2Mi_8_uid169_atan2Test_q : STD_LOGIC_VECTOR (29 downto 0);
    signal invSignOfSelectionSignal_uid170_atan2Test_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_9_uid171_atan2Test_a : STD_LOGIC_VECTOR (48 downto 0);
    signal xip1E_9_uid171_atan2Test_b : STD_LOGIC_VECTOR (48 downto 0);
    signal xip1E_9_uid171_atan2Test_o : STD_LOGIC_VECTOR (48 downto 0);
    signal xip1E_9_uid171_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_9_uid171_atan2Test_q : STD_LOGIC_VECTOR (47 downto 0);
    signal yip1E_9_uid172_atan2Test_a : STD_LOGIC_VECTOR (41 downto 0);
    signal yip1E_9_uid172_atan2Test_b : STD_LOGIC_VECTOR (41 downto 0);
    signal yip1E_9_uid172_atan2Test_o : STD_LOGIC_VECTOR (41 downto 0);
    signal yip1E_9_uid172_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_9_uid172_atan2Test_q : STD_LOGIC_VECTOR (40 downto 0);
    signal aip1E_9NA_uid175_atan2Test_q : STD_LOGIC_VECTOR (38 downto 0);
    signal aip1E_9sumAHighB_uid176_atan2Test_a : STD_LOGIC_VECTOR (40 downto 0);
    signal aip1E_9sumAHighB_uid176_atan2Test_b : STD_LOGIC_VECTOR (40 downto 0);
    signal aip1E_9sumAHighB_uid176_atan2Test_o : STD_LOGIC_VECTOR (40 downto 0);
    signal aip1E_9sumAHighB_uid176_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_9sumAHighB_uid176_atan2Test_q : STD_LOGIC_VECTOR (39 downto 0);
    signal xip1_9_uid177_atan2Test_in : STD_LOGIC_VECTOR (45 downto 0);
    signal xip1_9_uid177_atan2Test_b : STD_LOGIC_VECTOR (45 downto 0);
    signal yip1_9_uid178_atan2Test_in : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1_9_uid178_atan2Test_b : STD_LOGIC_VECTOR (38 downto 0);
    signal aip1E_uid179_atan2Test_in : STD_LOGIC_VECTOR (38 downto 0);
    signal aip1E_uid179_atan2Test_b : STD_LOGIC_VECTOR (38 downto 0);
    signal xMSB_uid180_atan2Test_b : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid184_atan2Test_b : STD_LOGIC_VECTOR (36 downto 0);
    signal twoToMiSiYip_uid185_atan2Test_b : STD_LOGIC_VECTOR (29 downto 0);
    signal cstArcTan2Mi_9_uid186_atan2Test_q : STD_LOGIC_VECTOR (30 downto 0);
    signal invSignOfSelectionSignal_uid187_atan2Test_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_10_uid188_atan2Test_a : STD_LOGIC_VECTOR (48 downto 0);
    signal xip1E_10_uid188_atan2Test_b : STD_LOGIC_VECTOR (48 downto 0);
    signal xip1E_10_uid188_atan2Test_o : STD_LOGIC_VECTOR (48 downto 0);
    signal xip1E_10_uid188_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_10_uid188_atan2Test_q : STD_LOGIC_VECTOR (47 downto 0);
    signal yip1E_10_uid189_atan2Test_a : STD_LOGIC_VECTOR (40 downto 0);
    signal yip1E_10_uid189_atan2Test_b : STD_LOGIC_VECTOR (40 downto 0);
    signal yip1E_10_uid189_atan2Test_o : STD_LOGIC_VECTOR (40 downto 0);
    signal yip1E_10_uid189_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_10_uid189_atan2Test_q : STD_LOGIC_VECTOR (39 downto 0);
    signal aip1E_10NA_uid192_atan2Test_q : STD_LOGIC_VECTOR (40 downto 0);
    signal aip1E_10sumAHighB_uid193_atan2Test_a : STD_LOGIC_VECTOR (42 downto 0);
    signal aip1E_10sumAHighB_uid193_atan2Test_b : STD_LOGIC_VECTOR (42 downto 0);
    signal aip1E_10sumAHighB_uid193_atan2Test_o : STD_LOGIC_VECTOR (42 downto 0);
    signal aip1E_10sumAHighB_uid193_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_10sumAHighB_uid193_atan2Test_q : STD_LOGIC_VECTOR (41 downto 0);
    signal xip1_10_uid194_atan2Test_in : STD_LOGIC_VECTOR (45 downto 0);
    signal xip1_10_uid194_atan2Test_b : STD_LOGIC_VECTOR (45 downto 0);
    signal yip1_10_uid195_atan2Test_in : STD_LOGIC_VECTOR (37 downto 0);
    signal yip1_10_uid195_atan2Test_b : STD_LOGIC_VECTOR (37 downto 0);
    signal aip1E_uid196_atan2Test_in : STD_LOGIC_VECTOR (40 downto 0);
    signal aip1E_uid196_atan2Test_b : STD_LOGIC_VECTOR (40 downto 0);
    signal xMSB_uid197_atan2Test_b : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid201_atan2Test_b : STD_LOGIC_VECTOR (35 downto 0);
    signal twoToMiSiYip_uid202_atan2Test_b : STD_LOGIC_VECTOR (27 downto 0);
    signal cstArcTan2Mi_10_uid203_atan2Test_q : STD_LOGIC_VECTOR (31 downto 0);
    signal invSignOfSelectionSignal_uid204_atan2Test_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_11_uid205_atan2Test_a : STD_LOGIC_VECTOR (48 downto 0);
    signal xip1E_11_uid205_atan2Test_b : STD_LOGIC_VECTOR (48 downto 0);
    signal xip1E_11_uid205_atan2Test_o : STD_LOGIC_VECTOR (48 downto 0);
    signal xip1E_11_uid205_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_11_uid205_atan2Test_q : STD_LOGIC_VECTOR (47 downto 0);
    signal yip1E_11_uid206_atan2Test_a : STD_LOGIC_VECTOR (39 downto 0);
    signal yip1E_11_uid206_atan2Test_b : STD_LOGIC_VECTOR (39 downto 0);
    signal yip1E_11_uid206_atan2Test_o : STD_LOGIC_VECTOR (39 downto 0);
    signal yip1E_11_uid206_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_11_uid206_atan2Test_q : STD_LOGIC_VECTOR (38 downto 0);
    signal aip1E_11NA_uid209_atan2Test_q : STD_LOGIC_VECTOR (42 downto 0);
    signal aip1E_11sumAHighB_uid210_atan2Test_a : STD_LOGIC_VECTOR (44 downto 0);
    signal aip1E_11sumAHighB_uid210_atan2Test_b : STD_LOGIC_VECTOR (44 downto 0);
    signal aip1E_11sumAHighB_uid210_atan2Test_o : STD_LOGIC_VECTOR (44 downto 0);
    signal aip1E_11sumAHighB_uid210_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_11sumAHighB_uid210_atan2Test_q : STD_LOGIC_VECTOR (43 downto 0);
    signal xip1_11_uid211_atan2Test_in : STD_LOGIC_VECTOR (45 downto 0);
    signal xip1_11_uid211_atan2Test_b : STD_LOGIC_VECTOR (45 downto 0);
    signal yip1_11_uid212_atan2Test_in : STD_LOGIC_VECTOR (36 downto 0);
    signal yip1_11_uid212_atan2Test_b : STD_LOGIC_VECTOR (36 downto 0);
    signal aip1E_uid213_atan2Test_in : STD_LOGIC_VECTOR (42 downto 0);
    signal aip1E_uid213_atan2Test_b : STD_LOGIC_VECTOR (42 downto 0);
    signal xMSB_uid214_atan2Test_b : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid218_atan2Test_b : STD_LOGIC_VECTOR (34 downto 0);
    signal cstArcTan2Mi_11_uid220_atan2Test_q : STD_LOGIC_VECTOR (32 downto 0);
    signal yip1E_12_uid223_atan2Test_a : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_12_uid223_atan2Test_b : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_12_uid223_atan2Test_o : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_12_uid223_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_12_uid223_atan2Test_q : STD_LOGIC_VECTOR (37 downto 0);
    signal invSignOfSelectionSignal_uid224_atan2Test_q : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_12NA_uid226_atan2Test_q : STD_LOGIC_VECTOR (44 downto 0);
    signal aip1E_12sumAHighB_uid227_atan2Test_a : STD_LOGIC_VECTOR (46 downto 0);
    signal aip1E_12sumAHighB_uid227_atan2Test_b : STD_LOGIC_VECTOR (46 downto 0);
    signal aip1E_12sumAHighB_uid227_atan2Test_o : STD_LOGIC_VECTOR (46 downto 0);
    signal aip1E_12sumAHighB_uid227_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_12sumAHighB_uid227_atan2Test_q : STD_LOGIC_VECTOR (45 downto 0);
    signal yip1_12_uid229_atan2Test_in : STD_LOGIC_VECTOR (35 downto 0);
    signal yip1_12_uid229_atan2Test_b : STD_LOGIC_VECTOR (35 downto 0);
    signal aip1E_uid230_atan2Test_in : STD_LOGIC_VECTOR (44 downto 0);
    signal aip1E_uid230_atan2Test_b : STD_LOGIC_VECTOR (44 downto 0);
    signal xMSB_uid231_atan2Test_b : STD_LOGIC_VECTOR (0 downto 0);
    signal cstArcTan2Mi_12_uid237_atan2Test_q : STD_LOGIC_VECTOR (33 downto 0);
    signal invSignOfSelectionSignal_uid241_atan2Test_q : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_13NA_uid243_atan2Test_q : STD_LOGIC_VECTOR (46 downto 0);
    signal aip1E_13sumAHighB_uid244_atan2Test_a : STD_LOGIC_VECTOR (48 downto 0);
    signal aip1E_13sumAHighB_uid244_atan2Test_b : STD_LOGIC_VECTOR (48 downto 0);
    signal aip1E_13sumAHighB_uid244_atan2Test_o : STD_LOGIC_VECTOR (48 downto 0);
    signal aip1E_13sumAHighB_uid244_atan2Test_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_13sumAHighB_uid244_atan2Test_q : STD_LOGIC_VECTOR (47 downto 0);
    signal aip1E_uid247_atan2Test_in : STD_LOGIC_VECTOR (46 downto 0);
    signal aip1E_uid247_atan2Test_b : STD_LOGIC_VECTOR (46 downto 0);
    signal alphaPreRnd_uid248_atan2Test_b : STD_LOGIC_VECTOR (13 downto 0);
    signal alphaPostRndhigh_uid254_atan2Test_a : STD_LOGIC_VECTOR (13 downto 0);
    signal alphaPostRndhigh_uid254_atan2Test_b : STD_LOGIC_VECTOR (13 downto 0);
    signal alphaPostRndhigh_uid254_atan2Test_o : STD_LOGIC_VECTOR (13 downto 0);
    signal alphaPostRndhigh_uid254_atan2Test_q : STD_LOGIC_VECTOR (13 downto 0);
    signal alphaPostRnd_uid255_atan2Test_q : STD_LOGIC_VECTOR (14 downto 0);
    signal atanRes_uid256_atan2Test_in : STD_LOGIC_VECTOR (13 downto 0);
    signal atanRes_uid256_atan2Test_b : STD_LOGIC_VECTOR (13 downto 0);
    signal cstZeroOutFormat_uid257_atan2Test_q : STD_LOGIC_VECTOR (13 downto 0);
    signal constPiP2uE_uid258_atan2Test_q : STD_LOGIC_VECTOR (12 downto 0);
    signal constPio2P2u_mergedSignalTM_uid261_atan2Test_q : STD_LOGIC_VECTOR (13 downto 0);
    signal concXZeroYZero_uid263_atan2Test_q : STD_LOGIC_VECTOR (1 downto 0);
    signal atanResPostExc_uid264_atan2Test_s : STD_LOGIC_VECTOR (1 downto 0);
    signal atanResPostExc_uid264_atan2Test_q : STD_LOGIC_VECTOR (13 downto 0);
    signal concSigns_uid265_atan2Test_q : STD_LOGIC_VECTOR (1 downto 0);
    signal constPiP2u_uid266_atan2Test_q : STD_LOGIC_VECTOR (13 downto 0);
    signal constPi_uid267_atan2Test_q : STD_LOGIC_VECTOR (13 downto 0);
    signal constantZeroOutFormat_uid268_atan2Test_q : STD_LOGIC_VECTOR (13 downto 0);
    signal constantZeroOutFormatP2u_uid269_atan2Test_q : STD_LOGIC_VECTOR (13 downto 0);
    signal firstOperand_uid271_atan2Test_s : STD_LOGIC_VECTOR (1 downto 0);
    signal firstOperand_uid271_atan2Test_q : STD_LOGIC_VECTOR (13 downto 0);
    signal secondOperand_uid272_atan2Test_s : STD_LOGIC_VECTOR (1 downto 0);
    signal secondOperand_uid272_atan2Test_q : STD_LOGIC_VECTOR (13 downto 0);
    signal outResExtended_uid273_atan2Test_a : STD_LOGIC_VECTOR (14 downto 0);
    signal outResExtended_uid273_atan2Test_b : STD_LOGIC_VECTOR (14 downto 0);
    signal outResExtended_uid273_atan2Test_o : STD_LOGIC_VECTOR (14 downto 0);
    signal outResExtended_uid273_atan2Test_q : STD_LOGIC_VECTOR (14 downto 0);
    signal atanResPostRR_uid274_atan2Test_b : STD_LOGIC_VECTOR (12 downto 0);
    signal lowRangeA_uid252_atan2Test_merged_bit_select_b : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeA_uid252_atan2Test_merged_bit_select_c : STD_LOGIC_VECTOR (12 downto 0);
    signal redist0_atanRes_uid256_atan2Test_b_1_q : STD_LOGIC_VECTOR (13 downto 0);
    signal redist1_alphaPreRnd_uid248_atan2Test_b_1_q : STD_LOGIC_VECTOR (13 downto 0);
    signal redist2_xMSB_uid231_atan2Test_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_aip1E_uid230_atan2Test_b_1_q : STD_LOGIC_VECTOR (44 downto 0);
    signal redist4_twoToMiSiXip_uid218_atan2Test_b_1_q : STD_LOGIC_VECTOR (34 downto 0);
    signal redist5_aip1E_uid213_atan2Test_b_1_q : STD_LOGIC_VECTOR (42 downto 0);
    signal redist6_yip1_11_uid212_atan2Test_b_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist7_aip1E_uid196_atan2Test_b_1_q : STD_LOGIC_VECTOR (40 downto 0);
    signal redist8_yip1_10_uid195_atan2Test_b_1_q : STD_LOGIC_VECTOR (37 downto 0);
    signal redist9_xip1_10_uid194_atan2Test_b_1_q : STD_LOGIC_VECTOR (45 downto 0);
    signal redist10_aip1E_uid179_atan2Test_b_1_q : STD_LOGIC_VECTOR (38 downto 0);
    signal redist11_yip1_9_uid178_atan2Test_b_1_q : STD_LOGIC_VECTOR (38 downto 0);
    signal redist12_xip1_9_uid177_atan2Test_b_1_q : STD_LOGIC_VECTOR (45 downto 0);
    signal redist13_aip1E_uid162_atan2Test_b_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist14_yip1_8_uid161_atan2Test_b_1_q : STD_LOGIC_VECTOR (39 downto 0);
    signal redist15_xip1_8_uid160_atan2Test_b_1_q : STD_LOGIC_VECTOR (45 downto 0);
    signal redist16_aip1E_uid145_atan2Test_b_1_q : STD_LOGIC_VECTOR (34 downto 0);
    signal redist17_yip1_7_uid144_atan2Test_b_1_q : STD_LOGIC_VECTOR (40 downto 0);
    signal redist18_xip1_7_uid143_atan2Test_b_1_q : STD_LOGIC_VECTOR (45 downto 0);
    signal redist19_aip1E_uid128_atan2Test_b_1_q : STD_LOGIC_VECTOR (32 downto 0);
    signal redist20_yip1_6_uid127_atan2Test_b_1_q : STD_LOGIC_VECTOR (41 downto 0);
    signal redist21_xip1_6_uid126_atan2Test_b_1_q : STD_LOGIC_VECTOR (45 downto 0);
    signal redist22_aip1E_uid107_atan2Test_b_1_q : STD_LOGIC_VECTOR (30 downto 0);
    signal redist23_yip1_5_uid106_atan2Test_b_1_q : STD_LOGIC_VECTOR (39 downto 0);
    signal redist24_xip1_5_uid105_atan2Test_b_1_q : STD_LOGIC_VECTOR (42 downto 0);
    signal redist25_aip1E_uid88_atan2Test_b_1_q : STD_LOGIC_VECTOR (28 downto 0);
    signal redist26_yip1_4_uid87_atan2Test_b_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist27_xip1_4_uid86_atan2Test_b_1_q : STD_LOGIC_VECTOR (38 downto 0);
    signal redist28_aip1E_uid69_atan2Test_b_1_q : STD_LOGIC_VECTOR (26 downto 0);
    signal redist29_yip1_3_uid68_atan2Test_b_1_q : STD_LOGIC_VECTOR (34 downto 0);
    signal redist30_xip1_3_uid67_atan2Test_b_1_q : STD_LOGIC_VECTOR (35 downto 0);
    signal redist31_aip1E_uid50_atan2Test_b_1_q : STD_LOGIC_VECTOR (24 downto 0);
    signal redist32_yip1_2_uid49_atan2Test_b_1_q : STD_LOGIC_VECTOR (33 downto 0);
    signal redist33_xip1_2_uid48_atan2Test_b_1_q : STD_LOGIC_VECTOR (33 downto 0);
    signal redist34_xNotZero_uid17_atan2Test_q_15_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist35_yNotZero_uid15_atan2Test_q_15_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist36_absY_uid14_atan2Test_b_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist37_absX_uid13_atan2Test_b_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist38_signY_uid8_atan2Test_b_15_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist39_signX_uid7_atan2Test_b_15_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- constPi_uid267_atan2Test(CONSTANT,266)
    constPi_uid267_atan2Test_q <= "11001001000100";

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- constPiP2uE_uid258_atan2Test(CONSTANT,257)
    constPiP2uE_uid258_atan2Test_q <= "1100100100100";

    -- constPio2P2u_mergedSignalTM_uid261_atan2Test(BITJOIN,260)@15
    constPio2P2u_mergedSignalTM_uid261_atan2Test_q <= GND_q & constPiP2uE_uid258_atan2Test_q;

    -- cstZeroOutFormat_uid257_atan2Test(CONSTANT,256)
    cstZeroOutFormat_uid257_atan2Test_q <= "00000000000010";

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- alphaPostRndhigh_uid254_atan2Test(ADD,253)@14
    alphaPostRndhigh_uid254_atan2Test_a <= STD_LOGIC_VECTOR("0" & lowRangeA_uid252_atan2Test_merged_bit_select_c);
    alphaPostRndhigh_uid254_atan2Test_b <= STD_LOGIC_VECTOR("0000000000000" & VCC_q);
    alphaPostRndhigh_uid254_atan2Test_o <= STD_LOGIC_VECTOR(UNSIGNED(alphaPostRndhigh_uid254_atan2Test_a) + UNSIGNED(alphaPostRndhigh_uid254_atan2Test_b));
    alphaPostRndhigh_uid254_atan2Test_q <= alphaPostRndhigh_uid254_atan2Test_o(13 downto 0);

    -- xMSB_uid214_atan2Test(BITSELECT,213)@12
    xMSB_uid214_atan2Test_b <= STD_LOGIC_VECTOR(redist6_yip1_11_uid212_atan2Test_b_1_q(36 downto 36));

    -- xMSB_uid180_atan2Test(BITSELECT,179)@10
    xMSB_uid180_atan2Test_b <= STD_LOGIC_VECTOR(redist11_yip1_9_uid178_atan2Test_b_1_q(38 downto 38));

    -- xMSB_uid146_atan2Test(BITSELECT,145)@8
    xMSB_uid146_atan2Test_b <= STD_LOGIC_VECTOR(redist17_yip1_7_uid144_atan2Test_b_1_q(40 downto 40));

    -- signX_uid7_atan2Test(BITSELECT,6)@0
    signX_uid7_atan2Test_b <= STD_LOGIC_VECTOR(x(31 downto 31));

    -- invSignX_uid9_atan2Test(LOGICAL,8)@0
    invSignX_uid9_atan2Test_q <= not (signX_uid7_atan2Test_b);

    -- constantZero_uid6_atan2Test(CONSTANT,5)
    constantZero_uid6_atan2Test_q <= "00000000000000000000000000000000";

    -- absXE_uid10_atan2Test(ADDSUB,9)@0
    absXE_uid10_atan2Test_s <= invSignX_uid9_atan2Test_q;
    absXE_uid10_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => constantZero_uid6_atan2Test_q(31)) & constantZero_uid6_atan2Test_q));
    absXE_uid10_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => x(31)) & x));
    absXE_uid10_atan2Test_combproc: PROCESS (absXE_uid10_atan2Test_a, absXE_uid10_atan2Test_b, absXE_uid10_atan2Test_s)
    BEGIN
        IF (absXE_uid10_atan2Test_s = "1") THEN
            absXE_uid10_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(absXE_uid10_atan2Test_a) + SIGNED(absXE_uid10_atan2Test_b));
        ELSE
            absXE_uid10_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(absXE_uid10_atan2Test_a) - SIGNED(absXE_uid10_atan2Test_b));
        END IF;
    END PROCESS;
    absXE_uid10_atan2Test_q <= absXE_uid10_atan2Test_o(32 downto 0);

    -- absX_uid13_atan2Test(BITSELECT,12)@0
    absX_uid13_atan2Test_in <= absXE_uid10_atan2Test_q(31 downto 0);
    absX_uid13_atan2Test_b <= absX_uid13_atan2Test_in(31 downto 0);

    -- redist37_absX_uid13_atan2Test_b_1(DELAY,313)
    redist37_absX_uid13_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => absX_uid13_atan2Test_b, xout => redist37_absX_uid13_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- signY_uid8_atan2Test(BITSELECT,7)@0
    signY_uid8_atan2Test_b <= STD_LOGIC_VECTOR(y(31 downto 31));

    -- invSignY_uid11_atan2Test(LOGICAL,10)@0
    invSignY_uid11_atan2Test_q <= not (signY_uid8_atan2Test_b);

    -- absYE_uid12_atan2Test(ADDSUB,11)@0
    absYE_uid12_atan2Test_s <= invSignY_uid11_atan2Test_q;
    absYE_uid12_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => constantZero_uid6_atan2Test_q(31)) & constantZero_uid6_atan2Test_q));
    absYE_uid12_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => y(31)) & y));
    absYE_uid12_atan2Test_combproc: PROCESS (absYE_uid12_atan2Test_a, absYE_uid12_atan2Test_b, absYE_uid12_atan2Test_s)
    BEGIN
        IF (absYE_uid12_atan2Test_s = "1") THEN
            absYE_uid12_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(absYE_uid12_atan2Test_a) + SIGNED(absYE_uid12_atan2Test_b));
        ELSE
            absYE_uid12_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(absYE_uid12_atan2Test_a) - SIGNED(absYE_uid12_atan2Test_b));
        END IF;
    END PROCESS;
    absYE_uid12_atan2Test_q <= absYE_uid12_atan2Test_o(32 downto 0);

    -- absY_uid14_atan2Test(BITSELECT,13)@0
    absY_uid14_atan2Test_in <= absYE_uid12_atan2Test_q(31 downto 0);
    absY_uid14_atan2Test_b <= absY_uid14_atan2Test_in(31 downto 0);

    -- redist36_absY_uid14_atan2Test_b_1(DELAY,312)
    redist36_absY_uid14_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => absY_uid14_atan2Test_b, xout => redist36_absY_uid14_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- yip1E_1_uid24_atan2Test(SUB,23)@1 + 1
    yip1E_1_uid24_atan2Test_a <= STD_LOGIC_VECTOR("0" & redist36_absY_uid14_atan2Test_b_1_q);
    yip1E_1_uid24_atan2Test_b <= STD_LOGIC_VECTOR("0" & redist37_absX_uid13_atan2Test_b_1_q);
    yip1E_1_uid24_atan2Test_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            yip1E_1_uid24_atan2Test_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                yip1E_1_uid24_atan2Test_o <= STD_LOGIC_VECTOR(UNSIGNED(yip1E_1_uid24_atan2Test_a) - UNSIGNED(yip1E_1_uid24_atan2Test_b));
            END IF;
        END IF;
    END PROCESS;
    yip1E_1_uid24_atan2Test_q <= yip1E_1_uid24_atan2Test_o(32 downto 0);

    -- xMSB_uid32_atan2Test(BITSELECT,31)@2
    xMSB_uid32_atan2Test_b <= STD_LOGIC_VECTOR(yip1E_1_uid24_atan2Test_q(32 downto 32));

    -- xip1E_1_uid23_atan2Test(ADD,22)@1 + 1
    xip1E_1_uid23_atan2Test_a <= STD_LOGIC_VECTOR("0" & redist37_absX_uid13_atan2Test_b_1_q);
    xip1E_1_uid23_atan2Test_b <= STD_LOGIC_VECTOR("0" & redist36_absY_uid14_atan2Test_b_1_q);
    xip1E_1_uid23_atan2Test_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            xip1E_1_uid23_atan2Test_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                xip1E_1_uid23_atan2Test_o <= STD_LOGIC_VECTOR(UNSIGNED(xip1E_1_uid23_atan2Test_a) + UNSIGNED(xip1E_1_uid23_atan2Test_b));
            END IF;
        END IF;
    END PROCESS;
    xip1E_1_uid23_atan2Test_q <= xip1E_1_uid23_atan2Test_o(32 downto 0);

    -- yip1E_2NA_uid42_atan2Test(BITJOIN,41)@2
    yip1E_2NA_uid42_atan2Test_q <= yip1E_1_uid24_atan2Test_q & GND_q;

    -- yip1E_2sumAHighB_uid43_atan2Test(ADDSUB,42)@2
    yip1E_2sumAHighB_uid43_atan2Test_s <= xMSB_uid32_atan2Test_b;
    yip1E_2sumAHighB_uid43_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 34 => yip1E_2NA_uid42_atan2Test_q(33)) & yip1E_2NA_uid42_atan2Test_q));
    yip1E_2sumAHighB_uid43_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & xip1E_1_uid23_atan2Test_q));
    yip1E_2sumAHighB_uid43_atan2Test_combproc: PROCESS (yip1E_2sumAHighB_uid43_atan2Test_a, yip1E_2sumAHighB_uid43_atan2Test_b, yip1E_2sumAHighB_uid43_atan2Test_s)
    BEGIN
        IF (yip1E_2sumAHighB_uid43_atan2Test_s = "1") THEN
            yip1E_2sumAHighB_uid43_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_2sumAHighB_uid43_atan2Test_a) + SIGNED(yip1E_2sumAHighB_uid43_atan2Test_b));
        ELSE
            yip1E_2sumAHighB_uid43_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_2sumAHighB_uid43_atan2Test_a) - SIGNED(yip1E_2sumAHighB_uid43_atan2Test_b));
        END IF;
    END PROCESS;
    yip1E_2sumAHighB_uid43_atan2Test_q <= yip1E_2sumAHighB_uid43_atan2Test_o(34 downto 0);

    -- yip1_2_uid49_atan2Test(BITSELECT,48)@2
    yip1_2_uid49_atan2Test_in <= STD_LOGIC_VECTOR(yip1E_2sumAHighB_uid43_atan2Test_q(33 downto 0));
    yip1_2_uid49_atan2Test_b <= STD_LOGIC_VECTOR(yip1_2_uid49_atan2Test_in(33 downto 0));

    -- redist32_yip1_2_uid49_atan2Test_b_1(DELAY,308)
    redist32_yip1_2_uid49_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 34, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_2_uid49_atan2Test_b, xout => redist32_yip1_2_uid49_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xMSB_uid51_atan2Test(BITSELECT,50)@3
    xMSB_uid51_atan2Test_b <= STD_LOGIC_VECTOR(redist32_yip1_2_uid49_atan2Test_b_1_q(33 downto 33));

    -- invSignOfSelectionSignal_uid37_atan2Test(LOGICAL,36)@2
    invSignOfSelectionSignal_uid37_atan2Test_q <= not (xMSB_uid32_atan2Test_b);

    -- xip1E_2NA_uid39_atan2Test(BITJOIN,38)@2
    xip1E_2NA_uid39_atan2Test_q <= xip1E_1_uid23_atan2Test_q & GND_q;

    -- xip1E_2sumAHighB_uid40_atan2Test(ADDSUB,39)@2
    xip1E_2sumAHighB_uid40_atan2Test_s <= invSignOfSelectionSignal_uid37_atan2Test_q;
    xip1E_2sumAHighB_uid40_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & xip1E_2NA_uid39_atan2Test_q));
    xip1E_2sumAHighB_uid40_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((36 downto 33 => yip1E_1_uid24_atan2Test_q(32)) & yip1E_1_uid24_atan2Test_q));
    xip1E_2sumAHighB_uid40_atan2Test_combproc: PROCESS (xip1E_2sumAHighB_uid40_atan2Test_a, xip1E_2sumAHighB_uid40_atan2Test_b, xip1E_2sumAHighB_uid40_atan2Test_s)
    BEGIN
        IF (xip1E_2sumAHighB_uid40_atan2Test_s = "1") THEN
            xip1E_2sumAHighB_uid40_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_2sumAHighB_uid40_atan2Test_a) + SIGNED(xip1E_2sumAHighB_uid40_atan2Test_b));
        ELSE
            xip1E_2sumAHighB_uid40_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_2sumAHighB_uid40_atan2Test_a) - SIGNED(xip1E_2sumAHighB_uid40_atan2Test_b));
        END IF;
    END PROCESS;
    xip1E_2sumAHighB_uid40_atan2Test_q <= xip1E_2sumAHighB_uid40_atan2Test_o(35 downto 0);

    -- xip1_2_uid48_atan2Test(BITSELECT,47)@2
    xip1_2_uid48_atan2Test_in <= xip1E_2sumAHighB_uid40_atan2Test_q(33 downto 0);
    xip1_2_uid48_atan2Test_b <= xip1_2_uid48_atan2Test_in(33 downto 0);

    -- redist33_xip1_2_uid48_atan2Test_b_1(DELAY,309)
    redist33_xip1_2_uid48_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 34, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_2_uid48_atan2Test_b, xout => redist33_xip1_2_uid48_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- aip1E_2CostZeroPaddingA_uid45_atan2Test(CONSTANT,44)
    aip1E_2CostZeroPaddingA_uid45_atan2Test_q <= "00";

    -- yip1E_3NA_uid61_atan2Test(BITJOIN,60)@3
    yip1E_3NA_uid61_atan2Test_q <= redist32_yip1_2_uid49_atan2Test_b_1_q & aip1E_2CostZeroPaddingA_uid45_atan2Test_q;

    -- yip1E_3sumAHighB_uid62_atan2Test(ADDSUB,61)@3
    yip1E_3sumAHighB_uid62_atan2Test_s <= xMSB_uid51_atan2Test_b;
    yip1E_3sumAHighB_uid62_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((37 downto 36 => yip1E_3NA_uid61_atan2Test_q(35)) & yip1E_3NA_uid61_atan2Test_q));
    yip1E_3sumAHighB_uid62_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & redist33_xip1_2_uid48_atan2Test_b_1_q));
    yip1E_3sumAHighB_uid62_atan2Test_combproc: PROCESS (yip1E_3sumAHighB_uid62_atan2Test_a, yip1E_3sumAHighB_uid62_atan2Test_b, yip1E_3sumAHighB_uid62_atan2Test_s)
    BEGIN
        IF (yip1E_3sumAHighB_uid62_atan2Test_s = "1") THEN
            yip1E_3sumAHighB_uid62_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_3sumAHighB_uid62_atan2Test_a) + SIGNED(yip1E_3sumAHighB_uid62_atan2Test_b));
        ELSE
            yip1E_3sumAHighB_uid62_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_3sumAHighB_uid62_atan2Test_a) - SIGNED(yip1E_3sumAHighB_uid62_atan2Test_b));
        END IF;
    END PROCESS;
    yip1E_3sumAHighB_uid62_atan2Test_q <= yip1E_3sumAHighB_uid62_atan2Test_o(36 downto 0);

    -- yip1_3_uid68_atan2Test(BITSELECT,67)@3
    yip1_3_uid68_atan2Test_in <= STD_LOGIC_VECTOR(yip1E_3sumAHighB_uid62_atan2Test_q(34 downto 0));
    yip1_3_uid68_atan2Test_b <= STD_LOGIC_VECTOR(yip1_3_uid68_atan2Test_in(34 downto 0));

    -- redist29_yip1_3_uid68_atan2Test_b_1(DELAY,305)
    redist29_yip1_3_uid68_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 35, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_3_uid68_atan2Test_b, xout => redist29_yip1_3_uid68_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xMSB_uid70_atan2Test(BITSELECT,69)@4
    xMSB_uid70_atan2Test_b <= STD_LOGIC_VECTOR(redist29_yip1_3_uid68_atan2Test_b_1_q(34 downto 34));

    -- invSignOfSelectionSignal_uid56_atan2Test(LOGICAL,55)@3
    invSignOfSelectionSignal_uid56_atan2Test_q <= not (xMSB_uid51_atan2Test_b);

    -- xip1E_3NA_uid58_atan2Test(BITJOIN,57)@3
    xip1E_3NA_uid58_atan2Test_q <= redist33_xip1_2_uid48_atan2Test_b_1_q & aip1E_2CostZeroPaddingA_uid45_atan2Test_q;

    -- xip1E_3sumAHighB_uid59_atan2Test(ADDSUB,58)@3
    xip1E_3sumAHighB_uid59_atan2Test_s <= invSignOfSelectionSignal_uid56_atan2Test_q;
    xip1E_3sumAHighB_uid59_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & xip1E_3NA_uid58_atan2Test_q));
    xip1E_3sumAHighB_uid59_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 34 => redist32_yip1_2_uid49_atan2Test_b_1_q(33)) & redist32_yip1_2_uid49_atan2Test_b_1_q));
    xip1E_3sumAHighB_uid59_atan2Test_combproc: PROCESS (xip1E_3sumAHighB_uid59_atan2Test_a, xip1E_3sumAHighB_uid59_atan2Test_b, xip1E_3sumAHighB_uid59_atan2Test_s)
    BEGIN
        IF (xip1E_3sumAHighB_uid59_atan2Test_s = "1") THEN
            xip1E_3sumAHighB_uid59_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_3sumAHighB_uid59_atan2Test_a) + SIGNED(xip1E_3sumAHighB_uid59_atan2Test_b));
        ELSE
            xip1E_3sumAHighB_uid59_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_3sumAHighB_uid59_atan2Test_a) - SIGNED(xip1E_3sumAHighB_uid59_atan2Test_b));
        END IF;
    END PROCESS;
    xip1E_3sumAHighB_uid59_atan2Test_q <= xip1E_3sumAHighB_uid59_atan2Test_o(37 downto 0);

    -- xip1_3_uid67_atan2Test(BITSELECT,66)@3
    xip1_3_uid67_atan2Test_in <= xip1E_3sumAHighB_uid59_atan2Test_q(35 downto 0);
    xip1_3_uid67_atan2Test_b <= xip1_3_uid67_atan2Test_in(35 downto 0);

    -- redist30_xip1_3_uid67_atan2Test_b_1(DELAY,306)
    redist30_xip1_3_uid67_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 36, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_3_uid67_atan2Test_b, xout => redist30_xip1_3_uid67_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xip1E_4CostZeroPaddingA_uid76_atan2Test(CONSTANT,75)
    xip1E_4CostZeroPaddingA_uid76_atan2Test_q <= "000";

    -- yip1E_4NA_uid80_atan2Test(BITJOIN,79)@4
    yip1E_4NA_uid80_atan2Test_q <= redist29_yip1_3_uid68_atan2Test_b_1_q & xip1E_4CostZeroPaddingA_uid76_atan2Test_q;

    -- yip1E_4sumAHighB_uid81_atan2Test(ADDSUB,80)@4
    yip1E_4sumAHighB_uid81_atan2Test_s <= xMSB_uid70_atan2Test_b;
    yip1E_4sumAHighB_uid81_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((39 downto 38 => yip1E_4NA_uid80_atan2Test_q(37)) & yip1E_4NA_uid80_atan2Test_q));
    yip1E_4sumAHighB_uid81_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & redist30_xip1_3_uid67_atan2Test_b_1_q));
    yip1E_4sumAHighB_uid81_atan2Test_combproc: PROCESS (yip1E_4sumAHighB_uid81_atan2Test_a, yip1E_4sumAHighB_uid81_atan2Test_b, yip1E_4sumAHighB_uid81_atan2Test_s)
    BEGIN
        IF (yip1E_4sumAHighB_uid81_atan2Test_s = "1") THEN
            yip1E_4sumAHighB_uid81_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_4sumAHighB_uid81_atan2Test_a) + SIGNED(yip1E_4sumAHighB_uid81_atan2Test_b));
        ELSE
            yip1E_4sumAHighB_uid81_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_4sumAHighB_uid81_atan2Test_a) - SIGNED(yip1E_4sumAHighB_uid81_atan2Test_b));
        END IF;
    END PROCESS;
    yip1E_4sumAHighB_uid81_atan2Test_q <= yip1E_4sumAHighB_uid81_atan2Test_o(38 downto 0);

    -- yip1_4_uid87_atan2Test(BITSELECT,86)@4
    yip1_4_uid87_atan2Test_in <= STD_LOGIC_VECTOR(yip1E_4sumAHighB_uid81_atan2Test_q(36 downto 0));
    yip1_4_uid87_atan2Test_b <= STD_LOGIC_VECTOR(yip1_4_uid87_atan2Test_in(36 downto 0));

    -- redist26_yip1_4_uid87_atan2Test_b_1(DELAY,302)
    redist26_yip1_4_uid87_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_4_uid87_atan2Test_b, xout => redist26_yip1_4_uid87_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xMSB_uid89_atan2Test(BITSELECT,88)@5
    xMSB_uid89_atan2Test_b <= STD_LOGIC_VECTOR(redist26_yip1_4_uid87_atan2Test_b_1_q(36 downto 36));

    -- invSignOfSelectionSignal_uid75_atan2Test(LOGICAL,74)@4
    invSignOfSelectionSignal_uid75_atan2Test_q <= not (xMSB_uid70_atan2Test_b);

    -- xip1E_4NA_uid77_atan2Test(BITJOIN,76)@4
    xip1E_4NA_uid77_atan2Test_q <= redist30_xip1_3_uid67_atan2Test_b_1_q & xip1E_4CostZeroPaddingA_uid76_atan2Test_q;

    -- xip1E_4sumAHighB_uid78_atan2Test(ADDSUB,77)@4
    xip1E_4sumAHighB_uid78_atan2Test_s <= invSignOfSelectionSignal_uid75_atan2Test_q;
    xip1E_4sumAHighB_uid78_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & xip1E_4NA_uid77_atan2Test_q));
    xip1E_4sumAHighB_uid78_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((41 downto 35 => redist29_yip1_3_uid68_atan2Test_b_1_q(34)) & redist29_yip1_3_uid68_atan2Test_b_1_q));
    xip1E_4sumAHighB_uid78_atan2Test_combproc: PROCESS (xip1E_4sumAHighB_uid78_atan2Test_a, xip1E_4sumAHighB_uid78_atan2Test_b, xip1E_4sumAHighB_uid78_atan2Test_s)
    BEGIN
        IF (xip1E_4sumAHighB_uid78_atan2Test_s = "1") THEN
            xip1E_4sumAHighB_uid78_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_4sumAHighB_uid78_atan2Test_a) + SIGNED(xip1E_4sumAHighB_uid78_atan2Test_b));
        ELSE
            xip1E_4sumAHighB_uid78_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_4sumAHighB_uid78_atan2Test_a) - SIGNED(xip1E_4sumAHighB_uid78_atan2Test_b));
        END IF;
    END PROCESS;
    xip1E_4sumAHighB_uid78_atan2Test_q <= xip1E_4sumAHighB_uid78_atan2Test_o(40 downto 0);

    -- xip1_4_uid86_atan2Test(BITSELECT,85)@4
    xip1_4_uid86_atan2Test_in <= xip1E_4sumAHighB_uid78_atan2Test_q(38 downto 0);
    xip1_4_uid86_atan2Test_b <= xip1_4_uid86_atan2Test_in(38 downto 0);

    -- redist27_xip1_4_uid86_atan2Test_b_1(DELAY,303)
    redist27_xip1_4_uid86_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 39, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_4_uid86_atan2Test_b, xout => redist27_xip1_4_uid86_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xip1E_5CostZeroPaddingA_uid95_atan2Test(CONSTANT,94)
    xip1E_5CostZeroPaddingA_uid95_atan2Test_q <= "0000";

    -- yip1E_5NA_uid99_atan2Test(BITJOIN,98)@5
    yip1E_5NA_uid99_atan2Test_q <= redist26_yip1_4_uid87_atan2Test_b_1_q & xip1E_5CostZeroPaddingA_uid95_atan2Test_q;

    -- yip1E_5sumAHighB_uid100_atan2Test(ADDSUB,99)@5
    yip1E_5sumAHighB_uid100_atan2Test_s <= xMSB_uid89_atan2Test_b;
    yip1E_5sumAHighB_uid100_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((42 downto 41 => yip1E_5NA_uid99_atan2Test_q(40)) & yip1E_5NA_uid99_atan2Test_q));
    yip1E_5sumAHighB_uid100_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & redist27_xip1_4_uid86_atan2Test_b_1_q));
    yip1E_5sumAHighB_uid100_atan2Test_combproc: PROCESS (yip1E_5sumAHighB_uid100_atan2Test_a, yip1E_5sumAHighB_uid100_atan2Test_b, yip1E_5sumAHighB_uid100_atan2Test_s)
    BEGIN
        IF (yip1E_5sumAHighB_uid100_atan2Test_s = "1") THEN
            yip1E_5sumAHighB_uid100_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_5sumAHighB_uid100_atan2Test_a) + SIGNED(yip1E_5sumAHighB_uid100_atan2Test_b));
        ELSE
            yip1E_5sumAHighB_uid100_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_5sumAHighB_uid100_atan2Test_a) - SIGNED(yip1E_5sumAHighB_uid100_atan2Test_b));
        END IF;
    END PROCESS;
    yip1E_5sumAHighB_uid100_atan2Test_q <= yip1E_5sumAHighB_uid100_atan2Test_o(41 downto 0);

    -- yip1_5_uid106_atan2Test(BITSELECT,105)@5
    yip1_5_uid106_atan2Test_in <= STD_LOGIC_VECTOR(yip1E_5sumAHighB_uid100_atan2Test_q(39 downto 0));
    yip1_5_uid106_atan2Test_b <= STD_LOGIC_VECTOR(yip1_5_uid106_atan2Test_in(39 downto 0));

    -- redist23_yip1_5_uid106_atan2Test_b_1(DELAY,299)
    redist23_yip1_5_uid106_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 40, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_5_uid106_atan2Test_b, xout => redist23_yip1_5_uid106_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xMSB_uid108_atan2Test(BITSELECT,107)@6
    xMSB_uid108_atan2Test_b <= STD_LOGIC_VECTOR(redist23_yip1_5_uid106_atan2Test_b_1_q(39 downto 39));

    -- invSignOfSelectionSignal_uid94_atan2Test(LOGICAL,93)@5
    invSignOfSelectionSignal_uid94_atan2Test_q <= not (xMSB_uid89_atan2Test_b);

    -- xip1E_5NA_uid96_atan2Test(BITJOIN,95)@5
    xip1E_5NA_uid96_atan2Test_q <= redist27_xip1_4_uid86_atan2Test_b_1_q & xip1E_5CostZeroPaddingA_uid95_atan2Test_q;

    -- xip1E_5sumAHighB_uid97_atan2Test(ADDSUB,96)@5
    xip1E_5sumAHighB_uid97_atan2Test_s <= invSignOfSelectionSignal_uid94_atan2Test_q;
    xip1E_5sumAHighB_uid97_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & xip1E_5NA_uid96_atan2Test_q));
    xip1E_5sumAHighB_uid97_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((45 downto 37 => redist26_yip1_4_uid87_atan2Test_b_1_q(36)) & redist26_yip1_4_uid87_atan2Test_b_1_q));
    xip1E_5sumAHighB_uid97_atan2Test_combproc: PROCESS (xip1E_5sumAHighB_uid97_atan2Test_a, xip1E_5sumAHighB_uid97_atan2Test_b, xip1E_5sumAHighB_uid97_atan2Test_s)
    BEGIN
        IF (xip1E_5sumAHighB_uid97_atan2Test_s = "1") THEN
            xip1E_5sumAHighB_uid97_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_5sumAHighB_uid97_atan2Test_a) + SIGNED(xip1E_5sumAHighB_uid97_atan2Test_b));
        ELSE
            xip1E_5sumAHighB_uid97_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_5sumAHighB_uid97_atan2Test_a) - SIGNED(xip1E_5sumAHighB_uid97_atan2Test_b));
        END IF;
    END PROCESS;
    xip1E_5sumAHighB_uid97_atan2Test_q <= xip1E_5sumAHighB_uid97_atan2Test_o(44 downto 0);

    -- xip1_5_uid105_atan2Test(BITSELECT,104)@5
    xip1_5_uid105_atan2Test_in <= xip1E_5sumAHighB_uid97_atan2Test_q(42 downto 0);
    xip1_5_uid105_atan2Test_b <= xip1_5_uid105_atan2Test_in(42 downto 0);

    -- redist24_xip1_5_uid105_atan2Test_b_1(DELAY,300)
    redist24_xip1_5_uid105_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 43, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_5_uid105_atan2Test_b, xout => redist24_xip1_5_uid105_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- twoToMiSiXip_uid112_atan2Test(BITSELECT,111)@6
    twoToMiSiXip_uid112_atan2Test_b <= redist24_xip1_5_uid105_atan2Test_b_1_q(42 downto 2);

    -- yip1E_6NA_uid120_atan2Test(BITJOIN,119)@6
    yip1E_6NA_uid120_atan2Test_q <= redist23_yip1_5_uid106_atan2Test_b_1_q & xip1E_4CostZeroPaddingA_uid76_atan2Test_q;

    -- yip1E_6sumAHighB_uid121_atan2Test(ADDSUB,120)@6
    yip1E_6sumAHighB_uid121_atan2Test_s <= xMSB_uid108_atan2Test_b;
    yip1E_6sumAHighB_uid121_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((44 downto 43 => yip1E_6NA_uid120_atan2Test_q(42)) & yip1E_6NA_uid120_atan2Test_q));
    yip1E_6sumAHighB_uid121_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & twoToMiSiXip_uid112_atan2Test_b));
    yip1E_6sumAHighB_uid121_atan2Test_combproc: PROCESS (yip1E_6sumAHighB_uid121_atan2Test_a, yip1E_6sumAHighB_uid121_atan2Test_b, yip1E_6sumAHighB_uid121_atan2Test_s)
    BEGIN
        IF (yip1E_6sumAHighB_uid121_atan2Test_s = "1") THEN
            yip1E_6sumAHighB_uid121_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_6sumAHighB_uid121_atan2Test_a) + SIGNED(yip1E_6sumAHighB_uid121_atan2Test_b));
        ELSE
            yip1E_6sumAHighB_uid121_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_6sumAHighB_uid121_atan2Test_a) - SIGNED(yip1E_6sumAHighB_uid121_atan2Test_b));
        END IF;
    END PROCESS;
    yip1E_6sumAHighB_uid121_atan2Test_q <= yip1E_6sumAHighB_uid121_atan2Test_o(43 downto 0);

    -- yip1_6_uid127_atan2Test(BITSELECT,126)@6
    yip1_6_uid127_atan2Test_in <= STD_LOGIC_VECTOR(yip1E_6sumAHighB_uid121_atan2Test_q(41 downto 0));
    yip1_6_uid127_atan2Test_b <= STD_LOGIC_VECTOR(yip1_6_uid127_atan2Test_in(41 downto 0));

    -- redist20_yip1_6_uid127_atan2Test_b_1(DELAY,296)
    redist20_yip1_6_uid127_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 42, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_6_uid127_atan2Test_b, xout => redist20_yip1_6_uid127_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xMSB_uid129_atan2Test(BITSELECT,128)@7
    xMSB_uid129_atan2Test_b <= STD_LOGIC_VECTOR(redist20_yip1_6_uid127_atan2Test_b_1_q(41 downto 41));

    -- invSignOfSelectionSignal_uid136_atan2Test(LOGICAL,135)@7
    invSignOfSelectionSignal_uid136_atan2Test_q <= not (xMSB_uid129_atan2Test_b);

    -- twoToMiSiYip_uid134_atan2Test(BITSELECT,133)@7
    twoToMiSiYip_uid134_atan2Test_b <= STD_LOGIC_VECTOR(redist20_yip1_6_uid127_atan2Test_b_1_q(41 downto 6));

    -- invSignOfSelectionSignal_uid115_atan2Test(LOGICAL,114)@6
    invSignOfSelectionSignal_uid115_atan2Test_q <= not (xMSB_uid108_atan2Test_b);

    -- twoToMiSiYip_uid113_atan2Test(BITSELECT,112)@6
    twoToMiSiYip_uid113_atan2Test_b <= STD_LOGIC_VECTOR(redist23_yip1_5_uid106_atan2Test_b_1_q(39 downto 2));

    -- xip1E_6NA_uid117_atan2Test(BITJOIN,116)@6
    xip1E_6NA_uid117_atan2Test_q <= redist24_xip1_5_uid105_atan2Test_b_1_q & xip1E_4CostZeroPaddingA_uid76_atan2Test_q;

    -- xip1E_6sumAHighB_uid118_atan2Test(ADDSUB,117)@6
    xip1E_6sumAHighB_uid118_atan2Test_s <= invSignOfSelectionSignal_uid115_atan2Test_q;
    xip1E_6sumAHighB_uid118_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & xip1E_6NA_uid117_atan2Test_q));
    xip1E_6sumAHighB_uid118_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((48 downto 38 => twoToMiSiYip_uid113_atan2Test_b(37)) & twoToMiSiYip_uid113_atan2Test_b));
    xip1E_6sumAHighB_uid118_atan2Test_combproc: PROCESS (xip1E_6sumAHighB_uid118_atan2Test_a, xip1E_6sumAHighB_uid118_atan2Test_b, xip1E_6sumAHighB_uid118_atan2Test_s)
    BEGIN
        IF (xip1E_6sumAHighB_uid118_atan2Test_s = "1") THEN
            xip1E_6sumAHighB_uid118_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_6sumAHighB_uid118_atan2Test_a) + SIGNED(xip1E_6sumAHighB_uid118_atan2Test_b));
        ELSE
            xip1E_6sumAHighB_uid118_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_6sumAHighB_uid118_atan2Test_a) - SIGNED(xip1E_6sumAHighB_uid118_atan2Test_b));
        END IF;
    END PROCESS;
    xip1E_6sumAHighB_uid118_atan2Test_q <= xip1E_6sumAHighB_uid118_atan2Test_o(47 downto 0);

    -- xip1_6_uid126_atan2Test(BITSELECT,125)@6
    xip1_6_uid126_atan2Test_in <= xip1E_6sumAHighB_uid118_atan2Test_q(45 downto 0);
    xip1_6_uid126_atan2Test_b <= xip1_6_uid126_atan2Test_in(45 downto 0);

    -- redist21_xip1_6_uid126_atan2Test_b_1(DELAY,297)
    redist21_xip1_6_uid126_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 46, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_6_uid126_atan2Test_b, xout => redist21_xip1_6_uid126_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xip1E_7_uid137_atan2Test(ADDSUB,136)@7
    xip1E_7_uid137_atan2Test_s <= invSignOfSelectionSignal_uid136_atan2Test_q;
    xip1E_7_uid137_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & redist21_xip1_6_uid126_atan2Test_b_1_q));
    xip1E_7_uid137_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((48 downto 36 => twoToMiSiYip_uid134_atan2Test_b(35)) & twoToMiSiYip_uid134_atan2Test_b));
    xip1E_7_uid137_atan2Test_combproc: PROCESS (xip1E_7_uid137_atan2Test_a, xip1E_7_uid137_atan2Test_b, xip1E_7_uid137_atan2Test_s)
    BEGIN
        IF (xip1E_7_uid137_atan2Test_s = "1") THEN
            xip1E_7_uid137_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_7_uid137_atan2Test_a) + SIGNED(xip1E_7_uid137_atan2Test_b));
        ELSE
            xip1E_7_uid137_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_7_uid137_atan2Test_a) - SIGNED(xip1E_7_uid137_atan2Test_b));
        END IF;
    END PROCESS;
    xip1E_7_uid137_atan2Test_q <= xip1E_7_uid137_atan2Test_o(47 downto 0);

    -- xip1_7_uid143_atan2Test(BITSELECT,142)@7
    xip1_7_uid143_atan2Test_in <= xip1E_7_uid137_atan2Test_q(45 downto 0);
    xip1_7_uid143_atan2Test_b <= xip1_7_uid143_atan2Test_in(45 downto 0);

    -- redist18_xip1_7_uid143_atan2Test_b_1(DELAY,294)
    redist18_xip1_7_uid143_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 46, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_7_uid143_atan2Test_b, xout => redist18_xip1_7_uid143_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- twoToMiSiXip_uid150_atan2Test(BITSELECT,149)@8
    twoToMiSiXip_uid150_atan2Test_b <= redist18_xip1_7_uid143_atan2Test_b_1_q(45 downto 7);

    -- twoToMiSiXip_uid133_atan2Test(BITSELECT,132)@7
    twoToMiSiXip_uid133_atan2Test_b <= redist21_xip1_6_uid126_atan2Test_b_1_q(45 downto 6);

    -- yip1E_7_uid138_atan2Test(ADDSUB,137)@7
    yip1E_7_uid138_atan2Test_s <= xMSB_uid129_atan2Test_b;
    yip1E_7_uid138_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((43 downto 42 => redist20_yip1_6_uid127_atan2Test_b_1_q(41)) & redist20_yip1_6_uid127_atan2Test_b_1_q));
    yip1E_7_uid138_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & twoToMiSiXip_uid133_atan2Test_b));
    yip1E_7_uid138_atan2Test_combproc: PROCESS (yip1E_7_uid138_atan2Test_a, yip1E_7_uid138_atan2Test_b, yip1E_7_uid138_atan2Test_s)
    BEGIN
        IF (yip1E_7_uid138_atan2Test_s = "1") THEN
            yip1E_7_uid138_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_7_uid138_atan2Test_a) + SIGNED(yip1E_7_uid138_atan2Test_b));
        ELSE
            yip1E_7_uid138_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_7_uid138_atan2Test_a) - SIGNED(yip1E_7_uid138_atan2Test_b));
        END IF;
    END PROCESS;
    yip1E_7_uid138_atan2Test_q <= yip1E_7_uid138_atan2Test_o(42 downto 0);

    -- yip1_7_uid144_atan2Test(BITSELECT,143)@7
    yip1_7_uid144_atan2Test_in <= STD_LOGIC_VECTOR(yip1E_7_uid138_atan2Test_q(40 downto 0));
    yip1_7_uid144_atan2Test_b <= STD_LOGIC_VECTOR(yip1_7_uid144_atan2Test_in(40 downto 0));

    -- redist17_yip1_7_uid144_atan2Test_b_1(DELAY,293)
    redist17_yip1_7_uid144_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 41, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_7_uid144_atan2Test_b, xout => redist17_yip1_7_uid144_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- yip1E_8_uid155_atan2Test(ADDSUB,154)@8
    yip1E_8_uid155_atan2Test_s <= xMSB_uid146_atan2Test_b;
    yip1E_8_uid155_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((42 downto 41 => redist17_yip1_7_uid144_atan2Test_b_1_q(40)) & redist17_yip1_7_uid144_atan2Test_b_1_q));
    yip1E_8_uid155_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & twoToMiSiXip_uid150_atan2Test_b));
    yip1E_8_uid155_atan2Test_combproc: PROCESS (yip1E_8_uid155_atan2Test_a, yip1E_8_uid155_atan2Test_b, yip1E_8_uid155_atan2Test_s)
    BEGIN
        IF (yip1E_8_uid155_atan2Test_s = "1") THEN
            yip1E_8_uid155_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_8_uid155_atan2Test_a) + SIGNED(yip1E_8_uid155_atan2Test_b));
        ELSE
            yip1E_8_uid155_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_8_uid155_atan2Test_a) - SIGNED(yip1E_8_uid155_atan2Test_b));
        END IF;
    END PROCESS;
    yip1E_8_uid155_atan2Test_q <= yip1E_8_uid155_atan2Test_o(41 downto 0);

    -- yip1_8_uid161_atan2Test(BITSELECT,160)@8
    yip1_8_uid161_atan2Test_in <= STD_LOGIC_VECTOR(yip1E_8_uid155_atan2Test_q(39 downto 0));
    yip1_8_uid161_atan2Test_b <= STD_LOGIC_VECTOR(yip1_8_uid161_atan2Test_in(39 downto 0));

    -- redist14_yip1_8_uid161_atan2Test_b_1(DELAY,290)
    redist14_yip1_8_uid161_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 40, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_8_uid161_atan2Test_b, xout => redist14_yip1_8_uid161_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xMSB_uid163_atan2Test(BITSELECT,162)@9
    xMSB_uid163_atan2Test_b <= STD_LOGIC_VECTOR(redist14_yip1_8_uid161_atan2Test_b_1_q(39 downto 39));

    -- invSignOfSelectionSignal_uid170_atan2Test(LOGICAL,169)@9
    invSignOfSelectionSignal_uid170_atan2Test_q <= not (xMSB_uid163_atan2Test_b);

    -- twoToMiSiYip_uid168_atan2Test(BITSELECT,167)@9
    twoToMiSiYip_uid168_atan2Test_b <= STD_LOGIC_VECTOR(redist14_yip1_8_uid161_atan2Test_b_1_q(39 downto 8));

    -- invSignOfSelectionSignal_uid153_atan2Test(LOGICAL,152)@8
    invSignOfSelectionSignal_uid153_atan2Test_q <= not (xMSB_uid146_atan2Test_b);

    -- twoToMiSiYip_uid151_atan2Test(BITSELECT,150)@8
    twoToMiSiYip_uid151_atan2Test_b <= STD_LOGIC_VECTOR(redist17_yip1_7_uid144_atan2Test_b_1_q(40 downto 7));

    -- xip1E_8_uid154_atan2Test(ADDSUB,153)@8
    xip1E_8_uid154_atan2Test_s <= invSignOfSelectionSignal_uid153_atan2Test_q;
    xip1E_8_uid154_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & redist18_xip1_7_uid143_atan2Test_b_1_q));
    xip1E_8_uid154_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((48 downto 34 => twoToMiSiYip_uid151_atan2Test_b(33)) & twoToMiSiYip_uid151_atan2Test_b));
    xip1E_8_uid154_atan2Test_combproc: PROCESS (xip1E_8_uid154_atan2Test_a, xip1E_8_uid154_atan2Test_b, xip1E_8_uid154_atan2Test_s)
    BEGIN
        IF (xip1E_8_uid154_atan2Test_s = "1") THEN
            xip1E_8_uid154_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_8_uid154_atan2Test_a) + SIGNED(xip1E_8_uid154_atan2Test_b));
        ELSE
            xip1E_8_uid154_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_8_uid154_atan2Test_a) - SIGNED(xip1E_8_uid154_atan2Test_b));
        END IF;
    END PROCESS;
    xip1E_8_uid154_atan2Test_q <= xip1E_8_uid154_atan2Test_o(47 downto 0);

    -- xip1_8_uid160_atan2Test(BITSELECT,159)@8
    xip1_8_uid160_atan2Test_in <= xip1E_8_uid154_atan2Test_q(45 downto 0);
    xip1_8_uid160_atan2Test_b <= xip1_8_uid160_atan2Test_in(45 downto 0);

    -- redist15_xip1_8_uid160_atan2Test_b_1(DELAY,291)
    redist15_xip1_8_uid160_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 46, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_8_uid160_atan2Test_b, xout => redist15_xip1_8_uid160_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xip1E_9_uid171_atan2Test(ADDSUB,170)@9
    xip1E_9_uid171_atan2Test_s <= invSignOfSelectionSignal_uid170_atan2Test_q;
    xip1E_9_uid171_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & redist15_xip1_8_uid160_atan2Test_b_1_q));
    xip1E_9_uid171_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((48 downto 32 => twoToMiSiYip_uid168_atan2Test_b(31)) & twoToMiSiYip_uid168_atan2Test_b));
    xip1E_9_uid171_atan2Test_combproc: PROCESS (xip1E_9_uid171_atan2Test_a, xip1E_9_uid171_atan2Test_b, xip1E_9_uid171_atan2Test_s)
    BEGIN
        IF (xip1E_9_uid171_atan2Test_s = "1") THEN
            xip1E_9_uid171_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_9_uid171_atan2Test_a) + SIGNED(xip1E_9_uid171_atan2Test_b));
        ELSE
            xip1E_9_uid171_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_9_uid171_atan2Test_a) - SIGNED(xip1E_9_uid171_atan2Test_b));
        END IF;
    END PROCESS;
    xip1E_9_uid171_atan2Test_q <= xip1E_9_uid171_atan2Test_o(47 downto 0);

    -- xip1_9_uid177_atan2Test(BITSELECT,176)@9
    xip1_9_uid177_atan2Test_in <= xip1E_9_uid171_atan2Test_q(45 downto 0);
    xip1_9_uid177_atan2Test_b <= xip1_9_uid177_atan2Test_in(45 downto 0);

    -- redist12_xip1_9_uid177_atan2Test_b_1(DELAY,288)
    redist12_xip1_9_uid177_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 46, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_9_uid177_atan2Test_b, xout => redist12_xip1_9_uid177_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- twoToMiSiXip_uid184_atan2Test(BITSELECT,183)@10
    twoToMiSiXip_uid184_atan2Test_b <= redist12_xip1_9_uid177_atan2Test_b_1_q(45 downto 9);

    -- twoToMiSiXip_uid167_atan2Test(BITSELECT,166)@9
    twoToMiSiXip_uid167_atan2Test_b <= redist15_xip1_8_uid160_atan2Test_b_1_q(45 downto 8);

    -- yip1E_9_uid172_atan2Test(ADDSUB,171)@9
    yip1E_9_uid172_atan2Test_s <= xMSB_uid163_atan2Test_b;
    yip1E_9_uid172_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((41 downto 40 => redist14_yip1_8_uid161_atan2Test_b_1_q(39)) & redist14_yip1_8_uid161_atan2Test_b_1_q));
    yip1E_9_uid172_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & twoToMiSiXip_uid167_atan2Test_b));
    yip1E_9_uid172_atan2Test_combproc: PROCESS (yip1E_9_uid172_atan2Test_a, yip1E_9_uid172_atan2Test_b, yip1E_9_uid172_atan2Test_s)
    BEGIN
        IF (yip1E_9_uid172_atan2Test_s = "1") THEN
            yip1E_9_uid172_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_9_uid172_atan2Test_a) + SIGNED(yip1E_9_uid172_atan2Test_b));
        ELSE
            yip1E_9_uid172_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_9_uid172_atan2Test_a) - SIGNED(yip1E_9_uid172_atan2Test_b));
        END IF;
    END PROCESS;
    yip1E_9_uid172_atan2Test_q <= yip1E_9_uid172_atan2Test_o(40 downto 0);

    -- yip1_9_uid178_atan2Test(BITSELECT,177)@9
    yip1_9_uid178_atan2Test_in <= STD_LOGIC_VECTOR(yip1E_9_uid172_atan2Test_q(38 downto 0));
    yip1_9_uid178_atan2Test_b <= STD_LOGIC_VECTOR(yip1_9_uid178_atan2Test_in(38 downto 0));

    -- redist11_yip1_9_uid178_atan2Test_b_1(DELAY,287)
    redist11_yip1_9_uid178_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 39, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_9_uid178_atan2Test_b, xout => redist11_yip1_9_uid178_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- yip1E_10_uid189_atan2Test(ADDSUB,188)@10
    yip1E_10_uid189_atan2Test_s <= xMSB_uid180_atan2Test_b;
    yip1E_10_uid189_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((40 downto 39 => redist11_yip1_9_uid178_atan2Test_b_1_q(38)) & redist11_yip1_9_uid178_atan2Test_b_1_q));
    yip1E_10_uid189_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & twoToMiSiXip_uid184_atan2Test_b));
    yip1E_10_uid189_atan2Test_combproc: PROCESS (yip1E_10_uid189_atan2Test_a, yip1E_10_uid189_atan2Test_b, yip1E_10_uid189_atan2Test_s)
    BEGIN
        IF (yip1E_10_uid189_atan2Test_s = "1") THEN
            yip1E_10_uid189_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_10_uid189_atan2Test_a) + SIGNED(yip1E_10_uid189_atan2Test_b));
        ELSE
            yip1E_10_uid189_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_10_uid189_atan2Test_a) - SIGNED(yip1E_10_uid189_atan2Test_b));
        END IF;
    END PROCESS;
    yip1E_10_uid189_atan2Test_q <= yip1E_10_uid189_atan2Test_o(39 downto 0);

    -- yip1_10_uid195_atan2Test(BITSELECT,194)@10
    yip1_10_uid195_atan2Test_in <= STD_LOGIC_VECTOR(yip1E_10_uid189_atan2Test_q(37 downto 0));
    yip1_10_uid195_atan2Test_b <= STD_LOGIC_VECTOR(yip1_10_uid195_atan2Test_in(37 downto 0));

    -- redist8_yip1_10_uid195_atan2Test_b_1(DELAY,284)
    redist8_yip1_10_uid195_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 38, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_10_uid195_atan2Test_b, xout => redist8_yip1_10_uid195_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xMSB_uid197_atan2Test(BITSELECT,196)@11
    xMSB_uid197_atan2Test_b <= STD_LOGIC_VECTOR(redist8_yip1_10_uid195_atan2Test_b_1_q(37 downto 37));

    -- invSignOfSelectionSignal_uid204_atan2Test(LOGICAL,203)@11
    invSignOfSelectionSignal_uid204_atan2Test_q <= not (xMSB_uid197_atan2Test_b);

    -- twoToMiSiYip_uid202_atan2Test(BITSELECT,201)@11
    twoToMiSiYip_uid202_atan2Test_b <= STD_LOGIC_VECTOR(redist8_yip1_10_uid195_atan2Test_b_1_q(37 downto 10));

    -- invSignOfSelectionSignal_uid187_atan2Test(LOGICAL,186)@10
    invSignOfSelectionSignal_uid187_atan2Test_q <= not (xMSB_uid180_atan2Test_b);

    -- twoToMiSiYip_uid185_atan2Test(BITSELECT,184)@10
    twoToMiSiYip_uid185_atan2Test_b <= STD_LOGIC_VECTOR(redist11_yip1_9_uid178_atan2Test_b_1_q(38 downto 9));

    -- xip1E_10_uid188_atan2Test(ADDSUB,187)@10
    xip1E_10_uid188_atan2Test_s <= invSignOfSelectionSignal_uid187_atan2Test_q;
    xip1E_10_uid188_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & redist12_xip1_9_uid177_atan2Test_b_1_q));
    xip1E_10_uid188_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((48 downto 30 => twoToMiSiYip_uid185_atan2Test_b(29)) & twoToMiSiYip_uid185_atan2Test_b));
    xip1E_10_uid188_atan2Test_combproc: PROCESS (xip1E_10_uid188_atan2Test_a, xip1E_10_uid188_atan2Test_b, xip1E_10_uid188_atan2Test_s)
    BEGIN
        IF (xip1E_10_uid188_atan2Test_s = "1") THEN
            xip1E_10_uid188_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_10_uid188_atan2Test_a) + SIGNED(xip1E_10_uid188_atan2Test_b));
        ELSE
            xip1E_10_uid188_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_10_uid188_atan2Test_a) - SIGNED(xip1E_10_uid188_atan2Test_b));
        END IF;
    END PROCESS;
    xip1E_10_uid188_atan2Test_q <= xip1E_10_uid188_atan2Test_o(47 downto 0);

    -- xip1_10_uid194_atan2Test(BITSELECT,193)@10
    xip1_10_uid194_atan2Test_in <= xip1E_10_uid188_atan2Test_q(45 downto 0);
    xip1_10_uid194_atan2Test_b <= xip1_10_uid194_atan2Test_in(45 downto 0);

    -- redist9_xip1_10_uid194_atan2Test_b_1(DELAY,285)
    redist9_xip1_10_uid194_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 46, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_10_uid194_atan2Test_b, xout => redist9_xip1_10_uid194_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xip1E_11_uid205_atan2Test(ADDSUB,204)@11
    xip1E_11_uid205_atan2Test_s <= invSignOfSelectionSignal_uid204_atan2Test_q;
    xip1E_11_uid205_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & redist9_xip1_10_uid194_atan2Test_b_1_q));
    xip1E_11_uid205_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((48 downto 28 => twoToMiSiYip_uid202_atan2Test_b(27)) & twoToMiSiYip_uid202_atan2Test_b));
    xip1E_11_uid205_atan2Test_combproc: PROCESS (xip1E_11_uid205_atan2Test_a, xip1E_11_uid205_atan2Test_b, xip1E_11_uid205_atan2Test_s)
    BEGIN
        IF (xip1E_11_uid205_atan2Test_s = "1") THEN
            xip1E_11_uid205_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_11_uid205_atan2Test_a) + SIGNED(xip1E_11_uid205_atan2Test_b));
        ELSE
            xip1E_11_uid205_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_11_uid205_atan2Test_a) - SIGNED(xip1E_11_uid205_atan2Test_b));
        END IF;
    END PROCESS;
    xip1E_11_uid205_atan2Test_q <= xip1E_11_uid205_atan2Test_o(47 downto 0);

    -- xip1_11_uid211_atan2Test(BITSELECT,210)@11
    xip1_11_uid211_atan2Test_in <= xip1E_11_uid205_atan2Test_q(45 downto 0);
    xip1_11_uid211_atan2Test_b <= xip1_11_uid211_atan2Test_in(45 downto 0);

    -- twoToMiSiXip_uid218_atan2Test(BITSELECT,217)@11
    twoToMiSiXip_uid218_atan2Test_b <= xip1_11_uid211_atan2Test_b(45 downto 11);

    -- redist4_twoToMiSiXip_uid218_atan2Test_b_1(DELAY,280)
    redist4_twoToMiSiXip_uid218_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 35, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => twoToMiSiXip_uid218_atan2Test_b, xout => redist4_twoToMiSiXip_uid218_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- twoToMiSiXip_uid201_atan2Test(BITSELECT,200)@11
    twoToMiSiXip_uid201_atan2Test_b <= redist9_xip1_10_uid194_atan2Test_b_1_q(45 downto 10);

    -- yip1E_11_uid206_atan2Test(ADDSUB,205)@11
    yip1E_11_uid206_atan2Test_s <= xMSB_uid197_atan2Test_b;
    yip1E_11_uid206_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((39 downto 38 => redist8_yip1_10_uid195_atan2Test_b_1_q(37)) & redist8_yip1_10_uid195_atan2Test_b_1_q));
    yip1E_11_uid206_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & twoToMiSiXip_uid201_atan2Test_b));
    yip1E_11_uid206_atan2Test_combproc: PROCESS (yip1E_11_uid206_atan2Test_a, yip1E_11_uid206_atan2Test_b, yip1E_11_uid206_atan2Test_s)
    BEGIN
        IF (yip1E_11_uid206_atan2Test_s = "1") THEN
            yip1E_11_uid206_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_11_uid206_atan2Test_a) + SIGNED(yip1E_11_uid206_atan2Test_b));
        ELSE
            yip1E_11_uid206_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_11_uid206_atan2Test_a) - SIGNED(yip1E_11_uid206_atan2Test_b));
        END IF;
    END PROCESS;
    yip1E_11_uid206_atan2Test_q <= yip1E_11_uid206_atan2Test_o(38 downto 0);

    -- yip1_11_uid212_atan2Test(BITSELECT,211)@11
    yip1_11_uid212_atan2Test_in <= STD_LOGIC_VECTOR(yip1E_11_uid206_atan2Test_q(36 downto 0));
    yip1_11_uid212_atan2Test_b <= STD_LOGIC_VECTOR(yip1_11_uid212_atan2Test_in(36 downto 0));

    -- redist6_yip1_11_uid212_atan2Test_b_1(DELAY,282)
    redist6_yip1_11_uid212_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_11_uid212_atan2Test_b, xout => redist6_yip1_11_uid212_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- yip1E_12_uid223_atan2Test(ADDSUB,222)@12
    yip1E_12_uid223_atan2Test_s <= xMSB_uid214_atan2Test_b;
    yip1E_12_uid223_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 37 => redist6_yip1_11_uid212_atan2Test_b_1_q(36)) & redist6_yip1_11_uid212_atan2Test_b_1_q));
    yip1E_12_uid223_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & redist4_twoToMiSiXip_uid218_atan2Test_b_1_q));
    yip1E_12_uid223_atan2Test_combproc: PROCESS (yip1E_12_uid223_atan2Test_a, yip1E_12_uid223_atan2Test_b, yip1E_12_uid223_atan2Test_s)
    BEGIN
        IF (yip1E_12_uid223_atan2Test_s = "1") THEN
            yip1E_12_uid223_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_12_uid223_atan2Test_a) + SIGNED(yip1E_12_uid223_atan2Test_b));
        ELSE
            yip1E_12_uid223_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_12_uid223_atan2Test_a) - SIGNED(yip1E_12_uid223_atan2Test_b));
        END IF;
    END PROCESS;
    yip1E_12_uid223_atan2Test_q <= yip1E_12_uid223_atan2Test_o(37 downto 0);

    -- yip1_12_uid229_atan2Test(BITSELECT,228)@12
    yip1_12_uid229_atan2Test_in <= STD_LOGIC_VECTOR(yip1E_12_uid223_atan2Test_q(35 downto 0));
    yip1_12_uid229_atan2Test_b <= STD_LOGIC_VECTOR(yip1_12_uid229_atan2Test_in(35 downto 0));

    -- xMSB_uid231_atan2Test(BITSELECT,230)@12
    xMSB_uid231_atan2Test_b <= STD_LOGIC_VECTOR(yip1_12_uid229_atan2Test_b(35 downto 35));

    -- redist2_xMSB_uid231_atan2Test_b_1(DELAY,278)
    redist2_xMSB_uid231_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid231_atan2Test_b, xout => redist2_xMSB_uid231_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- invSignOfSelectionSignal_uid241_atan2Test(LOGICAL,240)@13
    invSignOfSelectionSignal_uid241_atan2Test_q <= not (redist2_xMSB_uid231_atan2Test_b_1_q);

    -- cstArcTan2Mi_12_uid237_atan2Test(CONSTANT,236)
    cstArcTan2Mi_12_uid237_atan2Test_q <= "0111111111111111111111111101010101";

    -- invSignOfSelectionSignal_uid224_atan2Test(LOGICAL,223)@12
    invSignOfSelectionSignal_uid224_atan2Test_q <= not (xMSB_uid214_atan2Test_b);

    -- cstArcTan2Mi_11_uid220_atan2Test(CONSTANT,219)
    cstArcTan2Mi_11_uid220_atan2Test_q <= "011111111111111111111111010101011";

    -- cstArcTan2Mi_10_uid203_atan2Test(CONSTANT,202)
    cstArcTan2Mi_10_uid203_atan2Test_q <= "01111111111111111111110101010101";

    -- cstArcTan2Mi_9_uid186_atan2Test(CONSTANT,185)
    cstArcTan2Mi_9_uid186_atan2Test_q <= "0111111111111111111101010101011";

    -- cstArcTan2Mi_8_uid169_atan2Test(CONSTANT,168)
    cstArcTan2Mi_8_uid169_atan2Test_q <= "011111111111111111010101010101";

    -- cstArcTan2Mi_7_uid152_atan2Test(CONSTANT,151)
    cstArcTan2Mi_7_uid152_atan2Test_q <= "01111111111111110101010101011";

    -- cstArcTan2Mi_6_uid135_atan2Test(CONSTANT,134)
    cstArcTan2Mi_6_uid135_atan2Test_q <= "0111111111111101010101010111";

    -- cstArcTan2Mi_5_uid114_atan2Test(CONSTANT,113)
    cstArcTan2Mi_5_uid114_atan2Test_q <= "011111111111010101010110111";

    -- cstArcTan2Mi_4_uid93_atan2Test(CONSTANT,92)
    cstArcTan2Mi_4_uid93_atan2Test_q <= "01111111110101010110111011";

    -- cstArcTan2Mi_3_uid74_atan2Test(CONSTANT,73)
    cstArcTan2Mi_3_uid74_atan2Test_q <= "0111111101010110111010101";

    -- cstArcTan2Mi_2_uid55_atan2Test(CONSTANT,54)
    cstArcTan2Mi_2_uid55_atan2Test_q <= "011111010110110111011000";

    -- cstArcTan2Mi_1_uid36_atan2Test(CONSTANT,35)
    cstArcTan2Mi_1_uid36_atan2Test_q <= "01110110101100011001110";

    -- cstArcTan2Mi_0_uid22_atan2Test(CONSTANT,21)
    cstArcTan2Mi_0_uid22_atan2Test_q <= "0110010010000111111011";

    -- highBBits_uid26_atan2Test(BITSELECT,25)@2
    highBBits_uid26_atan2Test_b <= STD_LOGIC_VECTOR(cstArcTan2Mi_0_uid22_atan2Test_q(21 downto 21));

    -- lowRangeB_uid25_atan2Test(BITSELECT,24)@2
    lowRangeB_uid25_atan2Test_in <= cstArcTan2Mi_0_uid22_atan2Test_q(20 downto 0);
    lowRangeB_uid25_atan2Test_b <= lowRangeB_uid25_atan2Test_in(20 downto 0);

    -- aip1E_1_uid28_atan2Test(BITJOIN,27)@2
    aip1E_1_uid28_atan2Test_q <= STD_LOGIC_VECTOR((2 downto 1 => highBBits_uid26_atan2Test_b(0)) & highBBits_uid26_atan2Test_b) & lowRangeB_uid25_atan2Test_b;

    -- aip1E_uid31_atan2Test(BITSELECT,30)@2
    aip1E_uid31_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_1_uid28_atan2Test_q(22 downto 0));
    aip1E_uid31_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid31_atan2Test_in(22 downto 0));

    -- aip1E_2NA_uid46_atan2Test(BITJOIN,45)@2
    aip1E_2NA_uid46_atan2Test_q <= aip1E_uid31_atan2Test_b & aip1E_2CostZeroPaddingA_uid45_atan2Test_q;

    -- aip1E_2sumAHighB_uid47_atan2Test(ADDSUB,46)@2
    aip1E_2sumAHighB_uid47_atan2Test_s <= invSignOfSelectionSignal_uid37_atan2Test_q;
    aip1E_2sumAHighB_uid47_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 25 => aip1E_2NA_uid46_atan2Test_q(24)) & aip1E_2NA_uid46_atan2Test_q));
    aip1E_2sumAHighB_uid47_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 23 => cstArcTan2Mi_1_uid36_atan2Test_q(22)) & cstArcTan2Mi_1_uid36_atan2Test_q));
    aip1E_2sumAHighB_uid47_atan2Test_combproc: PROCESS (aip1E_2sumAHighB_uid47_atan2Test_a, aip1E_2sumAHighB_uid47_atan2Test_b, aip1E_2sumAHighB_uid47_atan2Test_s)
    BEGIN
        IF (aip1E_2sumAHighB_uid47_atan2Test_s = "1") THEN
            aip1E_2sumAHighB_uid47_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_2sumAHighB_uid47_atan2Test_a) + SIGNED(aip1E_2sumAHighB_uid47_atan2Test_b));
        ELSE
            aip1E_2sumAHighB_uid47_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_2sumAHighB_uid47_atan2Test_a) - SIGNED(aip1E_2sumAHighB_uid47_atan2Test_b));
        END IF;
    END PROCESS;
    aip1E_2sumAHighB_uid47_atan2Test_q <= aip1E_2sumAHighB_uid47_atan2Test_o(25 downto 0);

    -- aip1E_uid50_atan2Test(BITSELECT,49)@2
    aip1E_uid50_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_2sumAHighB_uid47_atan2Test_q(24 downto 0));
    aip1E_uid50_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid50_atan2Test_in(24 downto 0));

    -- redist31_aip1E_uid50_atan2Test_b_1(DELAY,307)
    redist31_aip1E_uid50_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 25, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid50_atan2Test_b, xout => redist31_aip1E_uid50_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- aip1E_3NA_uid65_atan2Test(BITJOIN,64)@3
    aip1E_3NA_uid65_atan2Test_q <= redist31_aip1E_uid50_atan2Test_b_1_q & aip1E_2CostZeroPaddingA_uid45_atan2Test_q;

    -- aip1E_3sumAHighB_uid66_atan2Test(ADDSUB,65)@3
    aip1E_3sumAHighB_uid66_atan2Test_s <= invSignOfSelectionSignal_uid56_atan2Test_q;
    aip1E_3sumAHighB_uid66_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 27 => aip1E_3NA_uid65_atan2Test_q(26)) & aip1E_3NA_uid65_atan2Test_q));
    aip1E_3sumAHighB_uid66_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 24 => cstArcTan2Mi_2_uid55_atan2Test_q(23)) & cstArcTan2Mi_2_uid55_atan2Test_q));
    aip1E_3sumAHighB_uid66_atan2Test_combproc: PROCESS (aip1E_3sumAHighB_uid66_atan2Test_a, aip1E_3sumAHighB_uid66_atan2Test_b, aip1E_3sumAHighB_uid66_atan2Test_s)
    BEGIN
        IF (aip1E_3sumAHighB_uid66_atan2Test_s = "1") THEN
            aip1E_3sumAHighB_uid66_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_3sumAHighB_uid66_atan2Test_a) + SIGNED(aip1E_3sumAHighB_uid66_atan2Test_b));
        ELSE
            aip1E_3sumAHighB_uid66_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_3sumAHighB_uid66_atan2Test_a) - SIGNED(aip1E_3sumAHighB_uid66_atan2Test_b));
        END IF;
    END PROCESS;
    aip1E_3sumAHighB_uid66_atan2Test_q <= aip1E_3sumAHighB_uid66_atan2Test_o(27 downto 0);

    -- aip1E_uid69_atan2Test(BITSELECT,68)@3
    aip1E_uid69_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_3sumAHighB_uid66_atan2Test_q(26 downto 0));
    aip1E_uid69_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid69_atan2Test_in(26 downto 0));

    -- redist28_aip1E_uid69_atan2Test_b_1(DELAY,304)
    redist28_aip1E_uid69_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 27, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid69_atan2Test_b, xout => redist28_aip1E_uid69_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- aip1E_4NA_uid84_atan2Test(BITJOIN,83)@4
    aip1E_4NA_uid84_atan2Test_q <= redist28_aip1E_uid69_atan2Test_b_1_q & aip1E_2CostZeroPaddingA_uid45_atan2Test_q;

    -- aip1E_4sumAHighB_uid85_atan2Test(ADDSUB,84)@4
    aip1E_4sumAHighB_uid85_atan2Test_s <= invSignOfSelectionSignal_uid75_atan2Test_q;
    aip1E_4sumAHighB_uid85_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 29 => aip1E_4NA_uid84_atan2Test_q(28)) & aip1E_4NA_uid84_atan2Test_q));
    aip1E_4sumAHighB_uid85_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 25 => cstArcTan2Mi_3_uid74_atan2Test_q(24)) & cstArcTan2Mi_3_uid74_atan2Test_q));
    aip1E_4sumAHighB_uid85_atan2Test_combproc: PROCESS (aip1E_4sumAHighB_uid85_atan2Test_a, aip1E_4sumAHighB_uid85_atan2Test_b, aip1E_4sumAHighB_uid85_atan2Test_s)
    BEGIN
        IF (aip1E_4sumAHighB_uid85_atan2Test_s = "1") THEN
            aip1E_4sumAHighB_uid85_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_4sumAHighB_uid85_atan2Test_a) + SIGNED(aip1E_4sumAHighB_uid85_atan2Test_b));
        ELSE
            aip1E_4sumAHighB_uid85_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_4sumAHighB_uid85_atan2Test_a) - SIGNED(aip1E_4sumAHighB_uid85_atan2Test_b));
        END IF;
    END PROCESS;
    aip1E_4sumAHighB_uid85_atan2Test_q <= aip1E_4sumAHighB_uid85_atan2Test_o(29 downto 0);

    -- aip1E_uid88_atan2Test(BITSELECT,87)@4
    aip1E_uid88_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_4sumAHighB_uid85_atan2Test_q(28 downto 0));
    aip1E_uid88_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid88_atan2Test_in(28 downto 0));

    -- redist25_aip1E_uid88_atan2Test_b_1(DELAY,301)
    redist25_aip1E_uid88_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 29, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid88_atan2Test_b, xout => redist25_aip1E_uid88_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- aip1E_5NA_uid103_atan2Test(BITJOIN,102)@5
    aip1E_5NA_uid103_atan2Test_q <= redist25_aip1E_uid88_atan2Test_b_1_q & aip1E_2CostZeroPaddingA_uid45_atan2Test_q;

    -- aip1E_5sumAHighB_uid104_atan2Test(ADDSUB,103)@5
    aip1E_5sumAHighB_uid104_atan2Test_s <= invSignOfSelectionSignal_uid94_atan2Test_q;
    aip1E_5sumAHighB_uid104_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 31 => aip1E_5NA_uid103_atan2Test_q(30)) & aip1E_5NA_uid103_atan2Test_q));
    aip1E_5sumAHighB_uid104_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 26 => cstArcTan2Mi_4_uid93_atan2Test_q(25)) & cstArcTan2Mi_4_uid93_atan2Test_q));
    aip1E_5sumAHighB_uid104_atan2Test_combproc: PROCESS (aip1E_5sumAHighB_uid104_atan2Test_a, aip1E_5sumAHighB_uid104_atan2Test_b, aip1E_5sumAHighB_uid104_atan2Test_s)
    BEGIN
        IF (aip1E_5sumAHighB_uid104_atan2Test_s = "1") THEN
            aip1E_5sumAHighB_uid104_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_5sumAHighB_uid104_atan2Test_a) + SIGNED(aip1E_5sumAHighB_uid104_atan2Test_b));
        ELSE
            aip1E_5sumAHighB_uid104_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_5sumAHighB_uid104_atan2Test_a) - SIGNED(aip1E_5sumAHighB_uid104_atan2Test_b));
        END IF;
    END PROCESS;
    aip1E_5sumAHighB_uid104_atan2Test_q <= aip1E_5sumAHighB_uid104_atan2Test_o(31 downto 0);

    -- aip1E_uid107_atan2Test(BITSELECT,106)@5
    aip1E_uid107_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_5sumAHighB_uid104_atan2Test_q(30 downto 0));
    aip1E_uid107_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid107_atan2Test_in(30 downto 0));

    -- redist22_aip1E_uid107_atan2Test_b_1(DELAY,298)
    redist22_aip1E_uid107_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 31, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid107_atan2Test_b, xout => redist22_aip1E_uid107_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- aip1E_6NA_uid124_atan2Test(BITJOIN,123)@6
    aip1E_6NA_uid124_atan2Test_q <= redist22_aip1E_uid107_atan2Test_b_1_q & aip1E_2CostZeroPaddingA_uid45_atan2Test_q;

    -- aip1E_6sumAHighB_uid125_atan2Test(ADDSUB,124)@6
    aip1E_6sumAHighB_uid125_atan2Test_s <= invSignOfSelectionSignal_uid115_atan2Test_q;
    aip1E_6sumAHighB_uid125_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((34 downto 33 => aip1E_6NA_uid124_atan2Test_q(32)) & aip1E_6NA_uid124_atan2Test_q));
    aip1E_6sumAHighB_uid125_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((34 downto 27 => cstArcTan2Mi_5_uid114_atan2Test_q(26)) & cstArcTan2Mi_5_uid114_atan2Test_q));
    aip1E_6sumAHighB_uid125_atan2Test_combproc: PROCESS (aip1E_6sumAHighB_uid125_atan2Test_a, aip1E_6sumAHighB_uid125_atan2Test_b, aip1E_6sumAHighB_uid125_atan2Test_s)
    BEGIN
        IF (aip1E_6sumAHighB_uid125_atan2Test_s = "1") THEN
            aip1E_6sumAHighB_uid125_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_6sumAHighB_uid125_atan2Test_a) + SIGNED(aip1E_6sumAHighB_uid125_atan2Test_b));
        ELSE
            aip1E_6sumAHighB_uid125_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_6sumAHighB_uid125_atan2Test_a) - SIGNED(aip1E_6sumAHighB_uid125_atan2Test_b));
        END IF;
    END PROCESS;
    aip1E_6sumAHighB_uid125_atan2Test_q <= aip1E_6sumAHighB_uid125_atan2Test_o(33 downto 0);

    -- aip1E_uid128_atan2Test(BITSELECT,127)@6
    aip1E_uid128_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_6sumAHighB_uid125_atan2Test_q(32 downto 0));
    aip1E_uid128_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid128_atan2Test_in(32 downto 0));

    -- redist19_aip1E_uid128_atan2Test_b_1(DELAY,295)
    redist19_aip1E_uid128_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 33, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid128_atan2Test_b, xout => redist19_aip1E_uid128_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- aip1E_7NA_uid141_atan2Test(BITJOIN,140)@7
    aip1E_7NA_uid141_atan2Test_q <= redist19_aip1E_uid128_atan2Test_b_1_q & aip1E_2CostZeroPaddingA_uid45_atan2Test_q;

    -- aip1E_7sumAHighB_uid142_atan2Test(ADDSUB,141)@7
    aip1E_7sumAHighB_uid142_atan2Test_s <= invSignOfSelectionSignal_uid136_atan2Test_q;
    aip1E_7sumAHighB_uid142_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((36 downto 35 => aip1E_7NA_uid141_atan2Test_q(34)) & aip1E_7NA_uid141_atan2Test_q));
    aip1E_7sumAHighB_uid142_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((36 downto 28 => cstArcTan2Mi_6_uid135_atan2Test_q(27)) & cstArcTan2Mi_6_uid135_atan2Test_q));
    aip1E_7sumAHighB_uid142_atan2Test_combproc: PROCESS (aip1E_7sumAHighB_uid142_atan2Test_a, aip1E_7sumAHighB_uid142_atan2Test_b, aip1E_7sumAHighB_uid142_atan2Test_s)
    BEGIN
        IF (aip1E_7sumAHighB_uid142_atan2Test_s = "1") THEN
            aip1E_7sumAHighB_uid142_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_7sumAHighB_uid142_atan2Test_a) + SIGNED(aip1E_7sumAHighB_uid142_atan2Test_b));
        ELSE
            aip1E_7sumAHighB_uid142_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_7sumAHighB_uid142_atan2Test_a) - SIGNED(aip1E_7sumAHighB_uid142_atan2Test_b));
        END IF;
    END PROCESS;
    aip1E_7sumAHighB_uid142_atan2Test_q <= aip1E_7sumAHighB_uid142_atan2Test_o(35 downto 0);

    -- aip1E_uid145_atan2Test(BITSELECT,144)@7
    aip1E_uid145_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_7sumAHighB_uid142_atan2Test_q(34 downto 0));
    aip1E_uid145_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid145_atan2Test_in(34 downto 0));

    -- redist16_aip1E_uid145_atan2Test_b_1(DELAY,292)
    redist16_aip1E_uid145_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 35, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid145_atan2Test_b, xout => redist16_aip1E_uid145_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- aip1E_8NA_uid158_atan2Test(BITJOIN,157)@8
    aip1E_8NA_uid158_atan2Test_q <= redist16_aip1E_uid145_atan2Test_b_1_q & aip1E_2CostZeroPaddingA_uid45_atan2Test_q;

    -- aip1E_8sumAHighB_uid159_atan2Test(ADDSUB,158)@8
    aip1E_8sumAHighB_uid159_atan2Test_s <= invSignOfSelectionSignal_uid153_atan2Test_q;
    aip1E_8sumAHighB_uid159_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 37 => aip1E_8NA_uid158_atan2Test_q(36)) & aip1E_8NA_uid158_atan2Test_q));
    aip1E_8sumAHighB_uid159_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 29 => cstArcTan2Mi_7_uid152_atan2Test_q(28)) & cstArcTan2Mi_7_uid152_atan2Test_q));
    aip1E_8sumAHighB_uid159_atan2Test_combproc: PROCESS (aip1E_8sumAHighB_uid159_atan2Test_a, aip1E_8sumAHighB_uid159_atan2Test_b, aip1E_8sumAHighB_uid159_atan2Test_s)
    BEGIN
        IF (aip1E_8sumAHighB_uid159_atan2Test_s = "1") THEN
            aip1E_8sumAHighB_uid159_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_8sumAHighB_uid159_atan2Test_a) + SIGNED(aip1E_8sumAHighB_uid159_atan2Test_b));
        ELSE
            aip1E_8sumAHighB_uid159_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_8sumAHighB_uid159_atan2Test_a) - SIGNED(aip1E_8sumAHighB_uid159_atan2Test_b));
        END IF;
    END PROCESS;
    aip1E_8sumAHighB_uid159_atan2Test_q <= aip1E_8sumAHighB_uid159_atan2Test_o(37 downto 0);

    -- aip1E_uid162_atan2Test(BITSELECT,161)@8
    aip1E_uid162_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_8sumAHighB_uid159_atan2Test_q(36 downto 0));
    aip1E_uid162_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid162_atan2Test_in(36 downto 0));

    -- redist13_aip1E_uid162_atan2Test_b_1(DELAY,289)
    redist13_aip1E_uid162_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid162_atan2Test_b, xout => redist13_aip1E_uid162_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- aip1E_9NA_uid175_atan2Test(BITJOIN,174)@9
    aip1E_9NA_uid175_atan2Test_q <= redist13_aip1E_uid162_atan2Test_b_1_q & aip1E_2CostZeroPaddingA_uid45_atan2Test_q;

    -- aip1E_9sumAHighB_uid176_atan2Test(ADDSUB,175)@9
    aip1E_9sumAHighB_uid176_atan2Test_s <= invSignOfSelectionSignal_uid170_atan2Test_q;
    aip1E_9sumAHighB_uid176_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((40 downto 39 => aip1E_9NA_uid175_atan2Test_q(38)) & aip1E_9NA_uid175_atan2Test_q));
    aip1E_9sumAHighB_uid176_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((40 downto 30 => cstArcTan2Mi_8_uid169_atan2Test_q(29)) & cstArcTan2Mi_8_uid169_atan2Test_q));
    aip1E_9sumAHighB_uid176_atan2Test_combproc: PROCESS (aip1E_9sumAHighB_uid176_atan2Test_a, aip1E_9sumAHighB_uid176_atan2Test_b, aip1E_9sumAHighB_uid176_atan2Test_s)
    BEGIN
        IF (aip1E_9sumAHighB_uid176_atan2Test_s = "1") THEN
            aip1E_9sumAHighB_uid176_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_9sumAHighB_uid176_atan2Test_a) + SIGNED(aip1E_9sumAHighB_uid176_atan2Test_b));
        ELSE
            aip1E_9sumAHighB_uid176_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_9sumAHighB_uid176_atan2Test_a) - SIGNED(aip1E_9sumAHighB_uid176_atan2Test_b));
        END IF;
    END PROCESS;
    aip1E_9sumAHighB_uid176_atan2Test_q <= aip1E_9sumAHighB_uid176_atan2Test_o(39 downto 0);

    -- aip1E_uid179_atan2Test(BITSELECT,178)@9
    aip1E_uid179_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_9sumAHighB_uid176_atan2Test_q(38 downto 0));
    aip1E_uid179_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid179_atan2Test_in(38 downto 0));

    -- redist10_aip1E_uid179_atan2Test_b_1(DELAY,286)
    redist10_aip1E_uid179_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 39, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid179_atan2Test_b, xout => redist10_aip1E_uid179_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- aip1E_10NA_uid192_atan2Test(BITJOIN,191)@10
    aip1E_10NA_uid192_atan2Test_q <= redist10_aip1E_uid179_atan2Test_b_1_q & aip1E_2CostZeroPaddingA_uid45_atan2Test_q;

    -- aip1E_10sumAHighB_uid193_atan2Test(ADDSUB,192)@10
    aip1E_10sumAHighB_uid193_atan2Test_s <= invSignOfSelectionSignal_uid187_atan2Test_q;
    aip1E_10sumAHighB_uid193_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((42 downto 41 => aip1E_10NA_uid192_atan2Test_q(40)) & aip1E_10NA_uid192_atan2Test_q));
    aip1E_10sumAHighB_uid193_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((42 downto 31 => cstArcTan2Mi_9_uid186_atan2Test_q(30)) & cstArcTan2Mi_9_uid186_atan2Test_q));
    aip1E_10sumAHighB_uid193_atan2Test_combproc: PROCESS (aip1E_10sumAHighB_uid193_atan2Test_a, aip1E_10sumAHighB_uid193_atan2Test_b, aip1E_10sumAHighB_uid193_atan2Test_s)
    BEGIN
        IF (aip1E_10sumAHighB_uid193_atan2Test_s = "1") THEN
            aip1E_10sumAHighB_uid193_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_10sumAHighB_uid193_atan2Test_a) + SIGNED(aip1E_10sumAHighB_uid193_atan2Test_b));
        ELSE
            aip1E_10sumAHighB_uid193_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_10sumAHighB_uid193_atan2Test_a) - SIGNED(aip1E_10sumAHighB_uid193_atan2Test_b));
        END IF;
    END PROCESS;
    aip1E_10sumAHighB_uid193_atan2Test_q <= aip1E_10sumAHighB_uid193_atan2Test_o(41 downto 0);

    -- aip1E_uid196_atan2Test(BITSELECT,195)@10
    aip1E_uid196_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_10sumAHighB_uid193_atan2Test_q(40 downto 0));
    aip1E_uid196_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid196_atan2Test_in(40 downto 0));

    -- redist7_aip1E_uid196_atan2Test_b_1(DELAY,283)
    redist7_aip1E_uid196_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 41, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid196_atan2Test_b, xout => redist7_aip1E_uid196_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- aip1E_11NA_uid209_atan2Test(BITJOIN,208)@11
    aip1E_11NA_uid209_atan2Test_q <= redist7_aip1E_uid196_atan2Test_b_1_q & aip1E_2CostZeroPaddingA_uid45_atan2Test_q;

    -- aip1E_11sumAHighB_uid210_atan2Test(ADDSUB,209)@11
    aip1E_11sumAHighB_uid210_atan2Test_s <= invSignOfSelectionSignal_uid204_atan2Test_q;
    aip1E_11sumAHighB_uid210_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((44 downto 43 => aip1E_11NA_uid209_atan2Test_q(42)) & aip1E_11NA_uid209_atan2Test_q));
    aip1E_11sumAHighB_uid210_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((44 downto 32 => cstArcTan2Mi_10_uid203_atan2Test_q(31)) & cstArcTan2Mi_10_uid203_atan2Test_q));
    aip1E_11sumAHighB_uid210_atan2Test_combproc: PROCESS (aip1E_11sumAHighB_uid210_atan2Test_a, aip1E_11sumAHighB_uid210_atan2Test_b, aip1E_11sumAHighB_uid210_atan2Test_s)
    BEGIN
        IF (aip1E_11sumAHighB_uid210_atan2Test_s = "1") THEN
            aip1E_11sumAHighB_uid210_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_11sumAHighB_uid210_atan2Test_a) + SIGNED(aip1E_11sumAHighB_uid210_atan2Test_b));
        ELSE
            aip1E_11sumAHighB_uid210_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_11sumAHighB_uid210_atan2Test_a) - SIGNED(aip1E_11sumAHighB_uid210_atan2Test_b));
        END IF;
    END PROCESS;
    aip1E_11sumAHighB_uid210_atan2Test_q <= aip1E_11sumAHighB_uid210_atan2Test_o(43 downto 0);

    -- aip1E_uid213_atan2Test(BITSELECT,212)@11
    aip1E_uid213_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_11sumAHighB_uid210_atan2Test_q(42 downto 0));
    aip1E_uid213_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid213_atan2Test_in(42 downto 0));

    -- redist5_aip1E_uid213_atan2Test_b_1(DELAY,281)
    redist5_aip1E_uid213_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 43, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid213_atan2Test_b, xout => redist5_aip1E_uid213_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- aip1E_12NA_uid226_atan2Test(BITJOIN,225)@12
    aip1E_12NA_uid226_atan2Test_q <= redist5_aip1E_uid213_atan2Test_b_1_q & aip1E_2CostZeroPaddingA_uid45_atan2Test_q;

    -- aip1E_12sumAHighB_uid227_atan2Test(ADDSUB,226)@12
    aip1E_12sumAHighB_uid227_atan2Test_s <= invSignOfSelectionSignal_uid224_atan2Test_q;
    aip1E_12sumAHighB_uid227_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((46 downto 45 => aip1E_12NA_uid226_atan2Test_q(44)) & aip1E_12NA_uid226_atan2Test_q));
    aip1E_12sumAHighB_uid227_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((46 downto 33 => cstArcTan2Mi_11_uid220_atan2Test_q(32)) & cstArcTan2Mi_11_uid220_atan2Test_q));
    aip1E_12sumAHighB_uid227_atan2Test_combproc: PROCESS (aip1E_12sumAHighB_uid227_atan2Test_a, aip1E_12sumAHighB_uid227_atan2Test_b, aip1E_12sumAHighB_uid227_atan2Test_s)
    BEGIN
        IF (aip1E_12sumAHighB_uid227_atan2Test_s = "1") THEN
            aip1E_12sumAHighB_uid227_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_12sumAHighB_uid227_atan2Test_a) + SIGNED(aip1E_12sumAHighB_uid227_atan2Test_b));
        ELSE
            aip1E_12sumAHighB_uid227_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_12sumAHighB_uid227_atan2Test_a) - SIGNED(aip1E_12sumAHighB_uid227_atan2Test_b));
        END IF;
    END PROCESS;
    aip1E_12sumAHighB_uid227_atan2Test_q <= aip1E_12sumAHighB_uid227_atan2Test_o(45 downto 0);

    -- aip1E_uid230_atan2Test(BITSELECT,229)@12
    aip1E_uid230_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_12sumAHighB_uid227_atan2Test_q(44 downto 0));
    aip1E_uid230_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid230_atan2Test_in(44 downto 0));

    -- redist3_aip1E_uid230_atan2Test_b_1(DELAY,279)
    redist3_aip1E_uid230_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 45, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid230_atan2Test_b, xout => redist3_aip1E_uid230_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- aip1E_13NA_uid243_atan2Test(BITJOIN,242)@13
    aip1E_13NA_uid243_atan2Test_q <= redist3_aip1E_uid230_atan2Test_b_1_q & aip1E_2CostZeroPaddingA_uid45_atan2Test_q;

    -- aip1E_13sumAHighB_uid244_atan2Test(ADDSUB,243)@13
    aip1E_13sumAHighB_uid244_atan2Test_s <= invSignOfSelectionSignal_uid241_atan2Test_q;
    aip1E_13sumAHighB_uid244_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((48 downto 47 => aip1E_13NA_uid243_atan2Test_q(46)) & aip1E_13NA_uid243_atan2Test_q));
    aip1E_13sumAHighB_uid244_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((48 downto 34 => cstArcTan2Mi_12_uid237_atan2Test_q(33)) & cstArcTan2Mi_12_uid237_atan2Test_q));
    aip1E_13sumAHighB_uid244_atan2Test_combproc: PROCESS (aip1E_13sumAHighB_uid244_atan2Test_a, aip1E_13sumAHighB_uid244_atan2Test_b, aip1E_13sumAHighB_uid244_atan2Test_s)
    BEGIN
        IF (aip1E_13sumAHighB_uid244_atan2Test_s = "1") THEN
            aip1E_13sumAHighB_uid244_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_13sumAHighB_uid244_atan2Test_a) + SIGNED(aip1E_13sumAHighB_uid244_atan2Test_b));
        ELSE
            aip1E_13sumAHighB_uid244_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_13sumAHighB_uid244_atan2Test_a) - SIGNED(aip1E_13sumAHighB_uid244_atan2Test_b));
        END IF;
    END PROCESS;
    aip1E_13sumAHighB_uid244_atan2Test_q <= aip1E_13sumAHighB_uid244_atan2Test_o(47 downto 0);

    -- aip1E_uid247_atan2Test(BITSELECT,246)@13
    aip1E_uid247_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_13sumAHighB_uid244_atan2Test_q(46 downto 0));
    aip1E_uid247_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid247_atan2Test_in(46 downto 0));

    -- alphaPreRnd_uid248_atan2Test(BITSELECT,247)@13
    alphaPreRnd_uid248_atan2Test_b <= aip1E_uid247_atan2Test_b(46 downto 33);

    -- redist1_alphaPreRnd_uid248_atan2Test_b_1(DELAY,277)
    redist1_alphaPreRnd_uid248_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => alphaPreRnd_uid248_atan2Test_b, xout => redist1_alphaPreRnd_uid248_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- lowRangeA_uid252_atan2Test_merged_bit_select(BITSELECT,275)@14
    lowRangeA_uid252_atan2Test_merged_bit_select_b <= redist1_alphaPreRnd_uid248_atan2Test_b_1_q(0 downto 0);
    lowRangeA_uid252_atan2Test_merged_bit_select_c <= redist1_alphaPreRnd_uid248_atan2Test_b_1_q(13 downto 1);

    -- alphaPostRnd_uid255_atan2Test(BITJOIN,254)@14
    alphaPostRnd_uid255_atan2Test_q <= alphaPostRndhigh_uid254_atan2Test_q & lowRangeA_uid252_atan2Test_merged_bit_select_b;

    -- atanRes_uid256_atan2Test(BITSELECT,255)@14
    atanRes_uid256_atan2Test_in <= alphaPostRnd_uid255_atan2Test_q(13 downto 0);
    atanRes_uid256_atan2Test_b <= atanRes_uid256_atan2Test_in(13 downto 0);

    -- redist0_atanRes_uid256_atan2Test_b_1(DELAY,276)
    redist0_atanRes_uid256_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => atanRes_uid256_atan2Test_b, xout => redist0_atanRes_uid256_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xNotZero_uid17_atan2Test(LOGICAL,16)@0 + 1
    xNotZero_uid17_atan2Test_qi <= "1" WHEN x /= "00000000000000000000000000000000" ELSE "0";
    xNotZero_uid17_atan2Test_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xNotZero_uid17_atan2Test_qi, xout => xNotZero_uid17_atan2Test_q, ena => en(0), clk => clk, aclr => areset );

    -- redist34_xNotZero_uid17_atan2Test_q_15(DELAY,310)
    redist34_xNotZero_uid17_atan2Test_q_15 : dspba_delay
    GENERIC MAP ( width => 1, depth => 14, reset_kind => "ASYNC" )
    PORT MAP ( xin => xNotZero_uid17_atan2Test_q, xout => redist34_xNotZero_uid17_atan2Test_q_15_q, ena => en(0), clk => clk, aclr => areset );

    -- xZero_uid18_atan2Test(LOGICAL,17)@15
    xZero_uid18_atan2Test_q <= not (redist34_xNotZero_uid17_atan2Test_q_15_q);

    -- yNotZero_uid15_atan2Test(LOGICAL,14)@0 + 1
    yNotZero_uid15_atan2Test_qi <= "1" WHEN y /= "00000000000000000000000000000000" ELSE "0";
    yNotZero_uid15_atan2Test_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yNotZero_uid15_atan2Test_qi, xout => yNotZero_uid15_atan2Test_q, ena => en(0), clk => clk, aclr => areset );

    -- redist35_yNotZero_uid15_atan2Test_q_15(DELAY,311)
    redist35_yNotZero_uid15_atan2Test_q_15 : dspba_delay
    GENERIC MAP ( width => 1, depth => 14, reset_kind => "ASYNC" )
    PORT MAP ( xin => yNotZero_uid15_atan2Test_q, xout => redist35_yNotZero_uid15_atan2Test_q_15_q, ena => en(0), clk => clk, aclr => areset );

    -- yZero_uid16_atan2Test(LOGICAL,15)@15
    yZero_uid16_atan2Test_q <= not (redist35_yNotZero_uid15_atan2Test_q_15_q);

    -- concXZeroYZero_uid263_atan2Test(BITJOIN,262)@15
    concXZeroYZero_uid263_atan2Test_q <= xZero_uid18_atan2Test_q & yZero_uid16_atan2Test_q;

    -- atanResPostExc_uid264_atan2Test(MUX,263)@15
    atanResPostExc_uid264_atan2Test_s <= concXZeroYZero_uid263_atan2Test_q;
    atanResPostExc_uid264_atan2Test_combproc: PROCESS (atanResPostExc_uid264_atan2Test_s, en, redist0_atanRes_uid256_atan2Test_b_1_q, cstZeroOutFormat_uid257_atan2Test_q, constPio2P2u_mergedSignalTM_uid261_atan2Test_q)
    BEGIN
        CASE (atanResPostExc_uid264_atan2Test_s) IS
            WHEN "00" => atanResPostExc_uid264_atan2Test_q <= redist0_atanRes_uid256_atan2Test_b_1_q;
            WHEN "01" => atanResPostExc_uid264_atan2Test_q <= cstZeroOutFormat_uid257_atan2Test_q;
            WHEN "10" => atanResPostExc_uid264_atan2Test_q <= constPio2P2u_mergedSignalTM_uid261_atan2Test_q;
            WHEN "11" => atanResPostExc_uid264_atan2Test_q <= cstZeroOutFormat_uid257_atan2Test_q;
            WHEN OTHERS => atanResPostExc_uid264_atan2Test_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- constantZeroOutFormat_uid268_atan2Test(CONSTANT,267)
    constantZeroOutFormat_uid268_atan2Test_q <= "00000000000000";

    -- redist39_signX_uid7_atan2Test_b_15(DELAY,315)
    redist39_signX_uid7_atan2Test_b_15 : dspba_delay
    GENERIC MAP ( width => 1, depth => 15, reset_kind => "ASYNC" )
    PORT MAP ( xin => signX_uid7_atan2Test_b, xout => redist39_signX_uid7_atan2Test_b_15_q, ena => en(0), clk => clk, aclr => areset );

    -- redist38_signY_uid8_atan2Test_b_15(DELAY,314)
    redist38_signY_uid8_atan2Test_b_15 : dspba_delay
    GENERIC MAP ( width => 1, depth => 15, reset_kind => "ASYNC" )
    PORT MAP ( xin => signY_uid8_atan2Test_b, xout => redist38_signY_uid8_atan2Test_b_15_q, ena => en(0), clk => clk, aclr => areset );

    -- concSigns_uid265_atan2Test(BITJOIN,264)@15
    concSigns_uid265_atan2Test_q <= redist39_signX_uid7_atan2Test_b_15_q & redist38_signY_uid8_atan2Test_b_15_q;

    -- secondOperand_uid272_atan2Test(MUX,271)@15 + 1
    secondOperand_uid272_atan2Test_s <= concSigns_uid265_atan2Test_q;
    secondOperand_uid272_atan2Test_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            secondOperand_uid272_atan2Test_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                CASE (secondOperand_uid272_atan2Test_s) IS
                    WHEN "00" => secondOperand_uid272_atan2Test_q <= constantZeroOutFormat_uid268_atan2Test_q;
                    WHEN "01" => secondOperand_uid272_atan2Test_q <= atanResPostExc_uid264_atan2Test_q;
                    WHEN "10" => secondOperand_uid272_atan2Test_q <= atanResPostExc_uid264_atan2Test_q;
                    WHEN "11" => secondOperand_uid272_atan2Test_q <= constPi_uid267_atan2Test_q;
                    WHEN OTHERS => secondOperand_uid272_atan2Test_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- constPiP2u_uid266_atan2Test(CONSTANT,265)
    constPiP2u_uid266_atan2Test_q <= "11001001000111";

    -- constantZeroOutFormatP2u_uid269_atan2Test(CONSTANT,268)
    constantZeroOutFormatP2u_uid269_atan2Test_q <= "00000000000100";

    -- firstOperand_uid271_atan2Test(MUX,270)@15 + 1
    firstOperand_uid271_atan2Test_s <= concSigns_uid265_atan2Test_q;
    firstOperand_uid271_atan2Test_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            firstOperand_uid271_atan2Test_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                CASE (firstOperand_uid271_atan2Test_s) IS
                    WHEN "00" => firstOperand_uid271_atan2Test_q <= atanResPostExc_uid264_atan2Test_q;
                    WHEN "01" => firstOperand_uid271_atan2Test_q <= constantZeroOutFormatP2u_uid269_atan2Test_q;
                    WHEN "10" => firstOperand_uid271_atan2Test_q <= constPiP2u_uid266_atan2Test_q;
                    WHEN "11" => firstOperand_uid271_atan2Test_q <= atanResPostExc_uid264_atan2Test_q;
                    WHEN OTHERS => firstOperand_uid271_atan2Test_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- outResExtended_uid273_atan2Test(SUB,272)@16
    outResExtended_uid273_atan2Test_a <= STD_LOGIC_VECTOR("0" & firstOperand_uid271_atan2Test_q);
    outResExtended_uid273_atan2Test_b <= STD_LOGIC_VECTOR("0" & secondOperand_uid272_atan2Test_q);
    outResExtended_uid273_atan2Test_o <= STD_LOGIC_VECTOR(UNSIGNED(outResExtended_uid273_atan2Test_a) - UNSIGNED(outResExtended_uid273_atan2Test_b));
    outResExtended_uid273_atan2Test_q <= outResExtended_uid273_atan2Test_o(14 downto 0);

    -- atanResPostRR_uid274_atan2Test(BITSELECT,273)@16
    atanResPostRR_uid274_atan2Test_b <= STD_LOGIC_VECTOR(outResExtended_uid273_atan2Test_q(14 downto 2));

    -- xOut(GPOUT,4)@16
    q <= atanResPostRR_uid274_atan2Test_b;

END normal;
