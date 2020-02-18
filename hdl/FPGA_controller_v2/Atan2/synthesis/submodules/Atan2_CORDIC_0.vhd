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
-- VHDL created on Tue Feb 18 09:52:02 2020


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
        x : in std_logic_vector(31 downto 0);  -- sfix32_en15
        y : in std_logic_vector(31 downto 0);  -- sfix32_en15
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
    signal redist1_concSigns_uid265_atan2Test_q_8_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist2_alphaPreRnd_uid248_atan2Test_b_1_q : STD_LOGIC_VECTOR (13 downto 0);
    signal redist3_twoToMiSiXip_uid218_atan2Test_b_1_q : STD_LOGIC_VECTOR (34 downto 0);
    signal redist4_aip1E_uid213_atan2Test_b_1_q : STD_LOGIC_VECTOR (42 downto 0);
    signal redist5_yip1_11_uid212_atan2Test_b_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist6_aip1E_uid179_atan2Test_b_1_q : STD_LOGIC_VECTOR (38 downto 0);
    signal redist7_yip1_9_uid178_atan2Test_b_1_q : STD_LOGIC_VECTOR (38 downto 0);
    signal redist8_xip1_9_uid177_atan2Test_b_1_q : STD_LOGIC_VECTOR (45 downto 0);
    signal redist9_aip1E_uid145_atan2Test_b_1_q : STD_LOGIC_VECTOR (34 downto 0);
    signal redist10_yip1_7_uid144_atan2Test_b_1_q : STD_LOGIC_VECTOR (40 downto 0);
    signal redist11_xip1_7_uid143_atan2Test_b_1_q : STD_LOGIC_VECTOR (45 downto 0);
    signal redist12_aip1E_uid107_atan2Test_b_1_q : STD_LOGIC_VECTOR (30 downto 0);
    signal redist13_yip1_5_uid106_atan2Test_b_1_q : STD_LOGIC_VECTOR (39 downto 0);
    signal redist14_xip1_5_uid105_atan2Test_b_1_q : STD_LOGIC_VECTOR (42 downto 0);
    signal redist15_aip1E_uid69_atan2Test_b_1_q : STD_LOGIC_VECTOR (26 downto 0);
    signal redist16_yip1_3_uid68_atan2Test_b_1_q : STD_LOGIC_VECTOR (34 downto 0);
    signal redist17_xip1_3_uid67_atan2Test_b_1_q : STD_LOGIC_VECTOR (35 downto 0);
    signal redist18_xNotZero_uid17_atan2Test_q_7_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist19_yNotZero_uid15_atan2Test_q_7_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_atanResPostRR_uid274_atan2Test_b_5_mem_reset0 : std_logic;
    signal redist0_atanResPostRR_uid274_atan2Test_b_5_mem_ia : STD_LOGIC_VECTOR (12 downto 0);
    signal redist0_atanResPostRR_uid274_atan2Test_b_5_mem_aa : STD_LOGIC_VECTOR (1 downto 0);
    signal redist0_atanResPostRR_uid274_atan2Test_b_5_mem_ab : STD_LOGIC_VECTOR (1 downto 0);
    signal redist0_atanResPostRR_uid274_atan2Test_b_5_mem_iq : STD_LOGIC_VECTOR (12 downto 0);
    signal redist0_atanResPostRR_uid274_atan2Test_b_5_mem_q : STD_LOGIC_VECTOR (12 downto 0);
    signal redist0_atanResPostRR_uid274_atan2Test_b_5_rdcnt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist0_atanResPostRR_uid274_atan2Test_b_5_rdcnt_i : UNSIGNED (1 downto 0);
    attribute preserve : boolean;
    attribute preserve of redist0_atanResPostRR_uid274_atan2Test_b_5_rdcnt_i : signal is true;
    signal redist0_atanResPostRR_uid274_atan2Test_b_5_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_atanResPostRR_uid274_atan2Test_b_5_rdmux_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist0_atanResPostRR_uid274_atan2Test_b_5_wraddr_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist0_atanResPostRR_uid274_atan2Test_b_5_mem_last_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist0_atanResPostRR_uid274_atan2Test_b_5_cmp_b : STD_LOGIC_VECTOR (2 downto 0);
    signal redist0_atanResPostRR_uid274_atan2Test_b_5_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_atanResPostRR_uid274_atan2Test_b_5_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_atanResPostRR_uid274_atan2Test_b_5_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_atanResPostRR_uid274_atan2Test_b_5_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_atanResPostRR_uid274_atan2Test_b_5_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute dont_merge : boolean;
    attribute dont_merge of redist0_atanResPostRR_uid274_atan2Test_b_5_sticky_ena_q : signal is true;
    signal redist0_atanResPostRR_uid274_atan2Test_b_5_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- redist0_atanResPostRR_uid274_atan2Test_b_5_notEnable(LOGICAL,303)
    redist0_atanResPostRR_uid274_atan2Test_b_5_notEnable_q <= STD_LOGIC_VECTOR(not (en));

    -- redist0_atanResPostRR_uid274_atan2Test_b_5_nor(LOGICAL,304)
    redist0_atanResPostRR_uid274_atan2Test_b_5_nor_q <= not (redist0_atanResPostRR_uid274_atan2Test_b_5_notEnable_q or redist0_atanResPostRR_uid274_atan2Test_b_5_sticky_ena_q);

    -- redist0_atanResPostRR_uid274_atan2Test_b_5_mem_last(CONSTANT,300)
    redist0_atanResPostRR_uid274_atan2Test_b_5_mem_last_q <= "010";

    -- redist0_atanResPostRR_uid274_atan2Test_b_5_cmp(LOGICAL,301)
    redist0_atanResPostRR_uid274_atan2Test_b_5_cmp_b <= STD_LOGIC_VECTOR("0" & redist0_atanResPostRR_uid274_atan2Test_b_5_rdmux_q);
    redist0_atanResPostRR_uid274_atan2Test_b_5_cmp_q <= "1" WHEN redist0_atanResPostRR_uid274_atan2Test_b_5_mem_last_q = redist0_atanResPostRR_uid274_atan2Test_b_5_cmp_b ELSE "0";

    -- redist0_atanResPostRR_uid274_atan2Test_b_5_cmpReg(REG,302)
    redist0_atanResPostRR_uid274_atan2Test_b_5_cmpReg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist0_atanResPostRR_uid274_atan2Test_b_5_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                redist0_atanResPostRR_uid274_atan2Test_b_5_cmpReg_q <= STD_LOGIC_VECTOR(redist0_atanResPostRR_uid274_atan2Test_b_5_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist0_atanResPostRR_uid274_atan2Test_b_5_sticky_ena(REG,305)
    redist0_atanResPostRR_uid274_atan2Test_b_5_sticky_ena_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist0_atanResPostRR_uid274_atan2Test_b_5_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (redist0_atanResPostRR_uid274_atan2Test_b_5_nor_q = "1") THEN
                redist0_atanResPostRR_uid274_atan2Test_b_5_sticky_ena_q <= STD_LOGIC_VECTOR(redist0_atanResPostRR_uid274_atan2Test_b_5_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist0_atanResPostRR_uid274_atan2Test_b_5_enaAnd(LOGICAL,306)
    redist0_atanResPostRR_uid274_atan2Test_b_5_enaAnd_q <= redist0_atanResPostRR_uid274_atan2Test_b_5_sticky_ena_q and en;

    -- redist0_atanResPostRR_uid274_atan2Test_b_5_rdcnt(COUNTER,297)
    -- low=0, high=3, step=1, init=0
    redist0_atanResPostRR_uid274_atan2Test_b_5_rdcnt_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist0_atanResPostRR_uid274_atan2Test_b_5_rdcnt_i <= TO_UNSIGNED(0, 2);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                redist0_atanResPostRR_uid274_atan2Test_b_5_rdcnt_i <= redist0_atanResPostRR_uid274_atan2Test_b_5_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist0_atanResPostRR_uid274_atan2Test_b_5_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist0_atanResPostRR_uid274_atan2Test_b_5_rdcnt_i, 2)));

    -- redist0_atanResPostRR_uid274_atan2Test_b_5_rdmux(MUX,298)
    redist0_atanResPostRR_uid274_atan2Test_b_5_rdmux_s <= en;
    redist0_atanResPostRR_uid274_atan2Test_b_5_rdmux_combproc: PROCESS (redist0_atanResPostRR_uid274_atan2Test_b_5_rdmux_s, redist0_atanResPostRR_uid274_atan2Test_b_5_wraddr_q, redist0_atanResPostRR_uid274_atan2Test_b_5_rdcnt_q)
    BEGIN
        CASE (redist0_atanResPostRR_uid274_atan2Test_b_5_rdmux_s) IS
            WHEN "0" => redist0_atanResPostRR_uid274_atan2Test_b_5_rdmux_q <= redist0_atanResPostRR_uid274_atan2Test_b_5_wraddr_q;
            WHEN "1" => redist0_atanResPostRR_uid274_atan2Test_b_5_rdmux_q <= redist0_atanResPostRR_uid274_atan2Test_b_5_rdcnt_q;
            WHEN OTHERS => redist0_atanResPostRR_uid274_atan2Test_b_5_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- constPi_uid267_atan2Test(CONSTANT,266)
    constPi_uid267_atan2Test_q <= "11001001000100";

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- constPiP2uE_uid258_atan2Test(CONSTANT,257)
    constPiP2uE_uid258_atan2Test_q <= "1100100100100";

    -- constPio2P2u_mergedSignalTM_uid261_atan2Test(BITJOIN,260)@7
    constPio2P2u_mergedSignalTM_uid261_atan2Test_q <= GND_q & constPiP2uE_uid258_atan2Test_q;

    -- cstZeroOutFormat_uid257_atan2Test(CONSTANT,256)
    cstZeroOutFormat_uid257_atan2Test_q <= "00000000000010";

    -- alphaPostRndhigh_uid254_atan2Test(ADD,253)@7
    alphaPostRndhigh_uid254_atan2Test_a <= STD_LOGIC_VECTOR("0" & lowRangeA_uid252_atan2Test_merged_bit_select_c);
    alphaPostRndhigh_uid254_atan2Test_b <= STD_LOGIC_VECTOR("0000000000000" & VCC_q);
    alphaPostRndhigh_uid254_atan2Test_o <= STD_LOGIC_VECTOR(UNSIGNED(alphaPostRndhigh_uid254_atan2Test_a) + UNSIGNED(alphaPostRndhigh_uid254_atan2Test_b));
    alphaPostRndhigh_uid254_atan2Test_q <= alphaPostRndhigh_uid254_atan2Test_o(13 downto 0);

    -- xMSB_uid214_atan2Test(BITSELECT,213)@6
    xMSB_uid214_atan2Test_b <= STD_LOGIC_VECTOR(redist5_yip1_11_uid212_atan2Test_b_1_q(36 downto 36));

    -- xMSB_uid180_atan2Test(BITSELECT,179)@5
    xMSB_uid180_atan2Test_b <= STD_LOGIC_VECTOR(redist7_yip1_9_uid178_atan2Test_b_1_q(38 downto 38));

    -- xMSB_uid146_atan2Test(BITSELECT,145)@4
    xMSB_uid146_atan2Test_b <= STD_LOGIC_VECTOR(redist10_yip1_7_uid144_atan2Test_b_1_q(40 downto 40));

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

    -- yip1E_1_uid24_atan2Test(SUB,23)@0 + 1
    yip1E_1_uid24_atan2Test_a <= STD_LOGIC_VECTOR("0" & absY_uid14_atan2Test_b);
    yip1E_1_uid24_atan2Test_b <= STD_LOGIC_VECTOR("0" & absX_uid13_atan2Test_b);
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

    -- xMSB_uid32_atan2Test(BITSELECT,31)@1
    xMSB_uid32_atan2Test_b <= STD_LOGIC_VECTOR(yip1E_1_uid24_atan2Test_q(32 downto 32));

    -- xip1E_1_uid23_atan2Test(ADD,22)@0 + 1
    xip1E_1_uid23_atan2Test_a <= STD_LOGIC_VECTOR("0" & absX_uid13_atan2Test_b);
    xip1E_1_uid23_atan2Test_b <= STD_LOGIC_VECTOR("0" & absY_uid14_atan2Test_b);
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

    -- yip1E_2NA_uid42_atan2Test(BITJOIN,41)@1
    yip1E_2NA_uid42_atan2Test_q <= yip1E_1_uid24_atan2Test_q & GND_q;

    -- yip1E_2sumAHighB_uid43_atan2Test(ADDSUB,42)@1
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

    -- yip1_2_uid49_atan2Test(BITSELECT,48)@1
    yip1_2_uid49_atan2Test_in <= STD_LOGIC_VECTOR(yip1E_2sumAHighB_uid43_atan2Test_q(33 downto 0));
    yip1_2_uid49_atan2Test_b <= STD_LOGIC_VECTOR(yip1_2_uid49_atan2Test_in(33 downto 0));

    -- xMSB_uid51_atan2Test(BITSELECT,50)@1
    xMSB_uid51_atan2Test_b <= STD_LOGIC_VECTOR(yip1_2_uid49_atan2Test_b(33 downto 33));

    -- invSignOfSelectionSignal_uid37_atan2Test(LOGICAL,36)@1
    invSignOfSelectionSignal_uid37_atan2Test_q <= not (xMSB_uid32_atan2Test_b);

    -- xip1E_2NA_uid39_atan2Test(BITJOIN,38)@1
    xip1E_2NA_uid39_atan2Test_q <= xip1E_1_uid23_atan2Test_q & GND_q;

    -- xip1E_2sumAHighB_uid40_atan2Test(ADDSUB,39)@1
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

    -- xip1_2_uid48_atan2Test(BITSELECT,47)@1
    xip1_2_uid48_atan2Test_in <= xip1E_2sumAHighB_uid40_atan2Test_q(33 downto 0);
    xip1_2_uid48_atan2Test_b <= xip1_2_uid48_atan2Test_in(33 downto 0);

    -- aip1E_2CostZeroPaddingA_uid45_atan2Test(CONSTANT,44)
    aip1E_2CostZeroPaddingA_uid45_atan2Test_q <= "00";

    -- yip1E_3NA_uid61_atan2Test(BITJOIN,60)@1
    yip1E_3NA_uid61_atan2Test_q <= yip1_2_uid49_atan2Test_b & aip1E_2CostZeroPaddingA_uid45_atan2Test_q;

    -- yip1E_3sumAHighB_uid62_atan2Test(ADDSUB,61)@1
    yip1E_3sumAHighB_uid62_atan2Test_s <= xMSB_uid51_atan2Test_b;
    yip1E_3sumAHighB_uid62_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((37 downto 36 => yip1E_3NA_uid61_atan2Test_q(35)) & yip1E_3NA_uid61_atan2Test_q));
    yip1E_3sumAHighB_uid62_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & xip1_2_uid48_atan2Test_b));
    yip1E_3sumAHighB_uid62_atan2Test_combproc: PROCESS (yip1E_3sumAHighB_uid62_atan2Test_a, yip1E_3sumAHighB_uid62_atan2Test_b, yip1E_3sumAHighB_uid62_atan2Test_s)
    BEGIN
        IF (yip1E_3sumAHighB_uid62_atan2Test_s = "1") THEN
            yip1E_3sumAHighB_uid62_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_3sumAHighB_uid62_atan2Test_a) + SIGNED(yip1E_3sumAHighB_uid62_atan2Test_b));
        ELSE
            yip1E_3sumAHighB_uid62_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_3sumAHighB_uid62_atan2Test_a) - SIGNED(yip1E_3sumAHighB_uid62_atan2Test_b));
        END IF;
    END PROCESS;
    yip1E_3sumAHighB_uid62_atan2Test_q <= yip1E_3sumAHighB_uid62_atan2Test_o(36 downto 0);

    -- yip1_3_uid68_atan2Test(BITSELECT,67)@1
    yip1_3_uid68_atan2Test_in <= STD_LOGIC_VECTOR(yip1E_3sumAHighB_uid62_atan2Test_q(34 downto 0));
    yip1_3_uid68_atan2Test_b <= STD_LOGIC_VECTOR(yip1_3_uid68_atan2Test_in(34 downto 0));

    -- redist16_yip1_3_uid68_atan2Test_b_1(DELAY,292)
    redist16_yip1_3_uid68_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 35, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_3_uid68_atan2Test_b, xout => redist16_yip1_3_uid68_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xMSB_uid70_atan2Test(BITSELECT,69)@2
    xMSB_uid70_atan2Test_b <= STD_LOGIC_VECTOR(redist16_yip1_3_uid68_atan2Test_b_1_q(34 downto 34));

    -- invSignOfSelectionSignal_uid56_atan2Test(LOGICAL,55)@1
    invSignOfSelectionSignal_uid56_atan2Test_q <= not (xMSB_uid51_atan2Test_b);

    -- xip1E_3NA_uid58_atan2Test(BITJOIN,57)@1
    xip1E_3NA_uid58_atan2Test_q <= xip1_2_uid48_atan2Test_b & aip1E_2CostZeroPaddingA_uid45_atan2Test_q;

    -- xip1E_3sumAHighB_uid59_atan2Test(ADDSUB,58)@1
    xip1E_3sumAHighB_uid59_atan2Test_s <= invSignOfSelectionSignal_uid56_atan2Test_q;
    xip1E_3sumAHighB_uid59_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & xip1E_3NA_uid58_atan2Test_q));
    xip1E_3sumAHighB_uid59_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 34 => yip1_2_uid49_atan2Test_b(33)) & yip1_2_uid49_atan2Test_b));
    xip1E_3sumAHighB_uid59_atan2Test_combproc: PROCESS (xip1E_3sumAHighB_uid59_atan2Test_a, xip1E_3sumAHighB_uid59_atan2Test_b, xip1E_3sumAHighB_uid59_atan2Test_s)
    BEGIN
        IF (xip1E_3sumAHighB_uid59_atan2Test_s = "1") THEN
            xip1E_3sumAHighB_uid59_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_3sumAHighB_uid59_atan2Test_a) + SIGNED(xip1E_3sumAHighB_uid59_atan2Test_b));
        ELSE
            xip1E_3sumAHighB_uid59_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_3sumAHighB_uid59_atan2Test_a) - SIGNED(xip1E_3sumAHighB_uid59_atan2Test_b));
        END IF;
    END PROCESS;
    xip1E_3sumAHighB_uid59_atan2Test_q <= xip1E_3sumAHighB_uid59_atan2Test_o(37 downto 0);

    -- xip1_3_uid67_atan2Test(BITSELECT,66)@1
    xip1_3_uid67_atan2Test_in <= xip1E_3sumAHighB_uid59_atan2Test_q(35 downto 0);
    xip1_3_uid67_atan2Test_b <= xip1_3_uid67_atan2Test_in(35 downto 0);

    -- redist17_xip1_3_uid67_atan2Test_b_1(DELAY,293)
    redist17_xip1_3_uid67_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 36, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_3_uid67_atan2Test_b, xout => redist17_xip1_3_uid67_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xip1E_4CostZeroPaddingA_uid76_atan2Test(CONSTANT,75)
    xip1E_4CostZeroPaddingA_uid76_atan2Test_q <= "000";

    -- yip1E_4NA_uid80_atan2Test(BITJOIN,79)@2
    yip1E_4NA_uid80_atan2Test_q <= redist16_yip1_3_uid68_atan2Test_b_1_q & xip1E_4CostZeroPaddingA_uid76_atan2Test_q;

    -- yip1E_4sumAHighB_uid81_atan2Test(ADDSUB,80)@2
    yip1E_4sumAHighB_uid81_atan2Test_s <= xMSB_uid70_atan2Test_b;
    yip1E_4sumAHighB_uid81_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((39 downto 38 => yip1E_4NA_uid80_atan2Test_q(37)) & yip1E_4NA_uid80_atan2Test_q));
    yip1E_4sumAHighB_uid81_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & redist17_xip1_3_uid67_atan2Test_b_1_q));
    yip1E_4sumAHighB_uid81_atan2Test_combproc: PROCESS (yip1E_4sumAHighB_uid81_atan2Test_a, yip1E_4sumAHighB_uid81_atan2Test_b, yip1E_4sumAHighB_uid81_atan2Test_s)
    BEGIN
        IF (yip1E_4sumAHighB_uid81_atan2Test_s = "1") THEN
            yip1E_4sumAHighB_uid81_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_4sumAHighB_uid81_atan2Test_a) + SIGNED(yip1E_4sumAHighB_uid81_atan2Test_b));
        ELSE
            yip1E_4sumAHighB_uid81_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_4sumAHighB_uid81_atan2Test_a) - SIGNED(yip1E_4sumAHighB_uid81_atan2Test_b));
        END IF;
    END PROCESS;
    yip1E_4sumAHighB_uid81_atan2Test_q <= yip1E_4sumAHighB_uid81_atan2Test_o(38 downto 0);

    -- yip1_4_uid87_atan2Test(BITSELECT,86)@2
    yip1_4_uid87_atan2Test_in <= STD_LOGIC_VECTOR(yip1E_4sumAHighB_uid81_atan2Test_q(36 downto 0));
    yip1_4_uid87_atan2Test_b <= STD_LOGIC_VECTOR(yip1_4_uid87_atan2Test_in(36 downto 0));

    -- xMSB_uid89_atan2Test(BITSELECT,88)@2
    xMSB_uid89_atan2Test_b <= STD_LOGIC_VECTOR(yip1_4_uid87_atan2Test_b(36 downto 36));

    -- invSignOfSelectionSignal_uid75_atan2Test(LOGICAL,74)@2
    invSignOfSelectionSignal_uid75_atan2Test_q <= not (xMSB_uid70_atan2Test_b);

    -- xip1E_4NA_uid77_atan2Test(BITJOIN,76)@2
    xip1E_4NA_uid77_atan2Test_q <= redist17_xip1_3_uid67_atan2Test_b_1_q & xip1E_4CostZeroPaddingA_uid76_atan2Test_q;

    -- xip1E_4sumAHighB_uid78_atan2Test(ADDSUB,77)@2
    xip1E_4sumAHighB_uid78_atan2Test_s <= invSignOfSelectionSignal_uid75_atan2Test_q;
    xip1E_4sumAHighB_uid78_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & xip1E_4NA_uid77_atan2Test_q));
    xip1E_4sumAHighB_uid78_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((41 downto 35 => redist16_yip1_3_uid68_atan2Test_b_1_q(34)) & redist16_yip1_3_uid68_atan2Test_b_1_q));
    xip1E_4sumAHighB_uid78_atan2Test_combproc: PROCESS (xip1E_4sumAHighB_uid78_atan2Test_a, xip1E_4sumAHighB_uid78_atan2Test_b, xip1E_4sumAHighB_uid78_atan2Test_s)
    BEGIN
        IF (xip1E_4sumAHighB_uid78_atan2Test_s = "1") THEN
            xip1E_4sumAHighB_uid78_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_4sumAHighB_uid78_atan2Test_a) + SIGNED(xip1E_4sumAHighB_uid78_atan2Test_b));
        ELSE
            xip1E_4sumAHighB_uid78_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_4sumAHighB_uid78_atan2Test_a) - SIGNED(xip1E_4sumAHighB_uid78_atan2Test_b));
        END IF;
    END PROCESS;
    xip1E_4sumAHighB_uid78_atan2Test_q <= xip1E_4sumAHighB_uid78_atan2Test_o(40 downto 0);

    -- xip1_4_uid86_atan2Test(BITSELECT,85)@2
    xip1_4_uid86_atan2Test_in <= xip1E_4sumAHighB_uid78_atan2Test_q(38 downto 0);
    xip1_4_uid86_atan2Test_b <= xip1_4_uid86_atan2Test_in(38 downto 0);

    -- xip1E_5CostZeroPaddingA_uid95_atan2Test(CONSTANT,94)
    xip1E_5CostZeroPaddingA_uid95_atan2Test_q <= "0000";

    -- yip1E_5NA_uid99_atan2Test(BITJOIN,98)@2
    yip1E_5NA_uid99_atan2Test_q <= yip1_4_uid87_atan2Test_b & xip1E_5CostZeroPaddingA_uid95_atan2Test_q;

    -- yip1E_5sumAHighB_uid100_atan2Test(ADDSUB,99)@2
    yip1E_5sumAHighB_uid100_atan2Test_s <= xMSB_uid89_atan2Test_b;
    yip1E_5sumAHighB_uid100_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((42 downto 41 => yip1E_5NA_uid99_atan2Test_q(40)) & yip1E_5NA_uid99_atan2Test_q));
    yip1E_5sumAHighB_uid100_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & xip1_4_uid86_atan2Test_b));
    yip1E_5sumAHighB_uid100_atan2Test_combproc: PROCESS (yip1E_5sumAHighB_uid100_atan2Test_a, yip1E_5sumAHighB_uid100_atan2Test_b, yip1E_5sumAHighB_uid100_atan2Test_s)
    BEGIN
        IF (yip1E_5sumAHighB_uid100_atan2Test_s = "1") THEN
            yip1E_5sumAHighB_uid100_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_5sumAHighB_uid100_atan2Test_a) + SIGNED(yip1E_5sumAHighB_uid100_atan2Test_b));
        ELSE
            yip1E_5sumAHighB_uid100_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_5sumAHighB_uid100_atan2Test_a) - SIGNED(yip1E_5sumAHighB_uid100_atan2Test_b));
        END IF;
    END PROCESS;
    yip1E_5sumAHighB_uid100_atan2Test_q <= yip1E_5sumAHighB_uid100_atan2Test_o(41 downto 0);

    -- yip1_5_uid106_atan2Test(BITSELECT,105)@2
    yip1_5_uid106_atan2Test_in <= STD_LOGIC_VECTOR(yip1E_5sumAHighB_uid100_atan2Test_q(39 downto 0));
    yip1_5_uid106_atan2Test_b <= STD_LOGIC_VECTOR(yip1_5_uid106_atan2Test_in(39 downto 0));

    -- redist13_yip1_5_uid106_atan2Test_b_1(DELAY,289)
    redist13_yip1_5_uid106_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 40, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_5_uid106_atan2Test_b, xout => redist13_yip1_5_uid106_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xMSB_uid108_atan2Test(BITSELECT,107)@3
    xMSB_uid108_atan2Test_b <= STD_LOGIC_VECTOR(redist13_yip1_5_uid106_atan2Test_b_1_q(39 downto 39));

    -- invSignOfSelectionSignal_uid94_atan2Test(LOGICAL,93)@2
    invSignOfSelectionSignal_uid94_atan2Test_q <= not (xMSB_uid89_atan2Test_b);

    -- xip1E_5NA_uid96_atan2Test(BITJOIN,95)@2
    xip1E_5NA_uid96_atan2Test_q <= xip1_4_uid86_atan2Test_b & xip1E_5CostZeroPaddingA_uid95_atan2Test_q;

    -- xip1E_5sumAHighB_uid97_atan2Test(ADDSUB,96)@2
    xip1E_5sumAHighB_uid97_atan2Test_s <= invSignOfSelectionSignal_uid94_atan2Test_q;
    xip1E_5sumAHighB_uid97_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & xip1E_5NA_uid96_atan2Test_q));
    xip1E_5sumAHighB_uid97_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((45 downto 37 => yip1_4_uid87_atan2Test_b(36)) & yip1_4_uid87_atan2Test_b));
    xip1E_5sumAHighB_uid97_atan2Test_combproc: PROCESS (xip1E_5sumAHighB_uid97_atan2Test_a, xip1E_5sumAHighB_uid97_atan2Test_b, xip1E_5sumAHighB_uid97_atan2Test_s)
    BEGIN
        IF (xip1E_5sumAHighB_uid97_atan2Test_s = "1") THEN
            xip1E_5sumAHighB_uid97_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_5sumAHighB_uid97_atan2Test_a) + SIGNED(xip1E_5sumAHighB_uid97_atan2Test_b));
        ELSE
            xip1E_5sumAHighB_uid97_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_5sumAHighB_uid97_atan2Test_a) - SIGNED(xip1E_5sumAHighB_uid97_atan2Test_b));
        END IF;
    END PROCESS;
    xip1E_5sumAHighB_uid97_atan2Test_q <= xip1E_5sumAHighB_uid97_atan2Test_o(44 downto 0);

    -- xip1_5_uid105_atan2Test(BITSELECT,104)@2
    xip1_5_uid105_atan2Test_in <= xip1E_5sumAHighB_uid97_atan2Test_q(42 downto 0);
    xip1_5_uid105_atan2Test_b <= xip1_5_uid105_atan2Test_in(42 downto 0);

    -- redist14_xip1_5_uid105_atan2Test_b_1(DELAY,290)
    redist14_xip1_5_uid105_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 43, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_5_uid105_atan2Test_b, xout => redist14_xip1_5_uid105_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- twoToMiSiXip_uid112_atan2Test(BITSELECT,111)@3
    twoToMiSiXip_uid112_atan2Test_b <= redist14_xip1_5_uid105_atan2Test_b_1_q(42 downto 2);

    -- yip1E_6NA_uid120_atan2Test(BITJOIN,119)@3
    yip1E_6NA_uid120_atan2Test_q <= redist13_yip1_5_uid106_atan2Test_b_1_q & xip1E_4CostZeroPaddingA_uid76_atan2Test_q;

    -- yip1E_6sumAHighB_uid121_atan2Test(ADDSUB,120)@3
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

    -- yip1_6_uid127_atan2Test(BITSELECT,126)@3
    yip1_6_uid127_atan2Test_in <= STD_LOGIC_VECTOR(yip1E_6sumAHighB_uid121_atan2Test_q(41 downto 0));
    yip1_6_uid127_atan2Test_b <= STD_LOGIC_VECTOR(yip1_6_uid127_atan2Test_in(41 downto 0));

    -- xMSB_uid129_atan2Test(BITSELECT,128)@3
    xMSB_uid129_atan2Test_b <= STD_LOGIC_VECTOR(yip1_6_uid127_atan2Test_b(41 downto 41));

    -- invSignOfSelectionSignal_uid136_atan2Test(LOGICAL,135)@3
    invSignOfSelectionSignal_uid136_atan2Test_q <= not (xMSB_uid129_atan2Test_b);

    -- twoToMiSiYip_uid134_atan2Test(BITSELECT,133)@3
    twoToMiSiYip_uid134_atan2Test_b <= STD_LOGIC_VECTOR(yip1_6_uid127_atan2Test_b(41 downto 6));

    -- invSignOfSelectionSignal_uid115_atan2Test(LOGICAL,114)@3
    invSignOfSelectionSignal_uid115_atan2Test_q <= not (xMSB_uid108_atan2Test_b);

    -- twoToMiSiYip_uid113_atan2Test(BITSELECT,112)@3
    twoToMiSiYip_uid113_atan2Test_b <= STD_LOGIC_VECTOR(redist13_yip1_5_uid106_atan2Test_b_1_q(39 downto 2));

    -- xip1E_6NA_uid117_atan2Test(BITJOIN,116)@3
    xip1E_6NA_uid117_atan2Test_q <= redist14_xip1_5_uid105_atan2Test_b_1_q & xip1E_4CostZeroPaddingA_uid76_atan2Test_q;

    -- xip1E_6sumAHighB_uid118_atan2Test(ADDSUB,117)@3
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

    -- xip1_6_uid126_atan2Test(BITSELECT,125)@3
    xip1_6_uid126_atan2Test_in <= xip1E_6sumAHighB_uid118_atan2Test_q(45 downto 0);
    xip1_6_uid126_atan2Test_b <= xip1_6_uid126_atan2Test_in(45 downto 0);

    -- xip1E_7_uid137_atan2Test(ADDSUB,136)@3
    xip1E_7_uid137_atan2Test_s <= invSignOfSelectionSignal_uid136_atan2Test_q;
    xip1E_7_uid137_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & xip1_6_uid126_atan2Test_b));
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

    -- xip1_7_uid143_atan2Test(BITSELECT,142)@3
    xip1_7_uid143_atan2Test_in <= xip1E_7_uid137_atan2Test_q(45 downto 0);
    xip1_7_uid143_atan2Test_b <= xip1_7_uid143_atan2Test_in(45 downto 0);

    -- redist11_xip1_7_uid143_atan2Test_b_1(DELAY,287)
    redist11_xip1_7_uid143_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 46, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_7_uid143_atan2Test_b, xout => redist11_xip1_7_uid143_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- twoToMiSiXip_uid150_atan2Test(BITSELECT,149)@4
    twoToMiSiXip_uid150_atan2Test_b <= redist11_xip1_7_uid143_atan2Test_b_1_q(45 downto 7);

    -- twoToMiSiXip_uid133_atan2Test(BITSELECT,132)@3
    twoToMiSiXip_uid133_atan2Test_b <= xip1_6_uid126_atan2Test_b(45 downto 6);

    -- yip1E_7_uid138_atan2Test(ADDSUB,137)@3
    yip1E_7_uid138_atan2Test_s <= xMSB_uid129_atan2Test_b;
    yip1E_7_uid138_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((43 downto 42 => yip1_6_uid127_atan2Test_b(41)) & yip1_6_uid127_atan2Test_b));
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

    -- yip1_7_uid144_atan2Test(BITSELECT,143)@3
    yip1_7_uid144_atan2Test_in <= STD_LOGIC_VECTOR(yip1E_7_uid138_atan2Test_q(40 downto 0));
    yip1_7_uid144_atan2Test_b <= STD_LOGIC_VECTOR(yip1_7_uid144_atan2Test_in(40 downto 0));

    -- redist10_yip1_7_uid144_atan2Test_b_1(DELAY,286)
    redist10_yip1_7_uid144_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 41, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_7_uid144_atan2Test_b, xout => redist10_yip1_7_uid144_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- yip1E_8_uid155_atan2Test(ADDSUB,154)@4
    yip1E_8_uid155_atan2Test_s <= xMSB_uid146_atan2Test_b;
    yip1E_8_uid155_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((42 downto 41 => redist10_yip1_7_uid144_atan2Test_b_1_q(40)) & redist10_yip1_7_uid144_atan2Test_b_1_q));
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

    -- yip1_8_uid161_atan2Test(BITSELECT,160)@4
    yip1_8_uid161_atan2Test_in <= STD_LOGIC_VECTOR(yip1E_8_uid155_atan2Test_q(39 downto 0));
    yip1_8_uid161_atan2Test_b <= STD_LOGIC_VECTOR(yip1_8_uid161_atan2Test_in(39 downto 0));

    -- xMSB_uid163_atan2Test(BITSELECT,162)@4
    xMSB_uid163_atan2Test_b <= STD_LOGIC_VECTOR(yip1_8_uid161_atan2Test_b(39 downto 39));

    -- invSignOfSelectionSignal_uid170_atan2Test(LOGICAL,169)@4
    invSignOfSelectionSignal_uid170_atan2Test_q <= not (xMSB_uid163_atan2Test_b);

    -- twoToMiSiYip_uid168_atan2Test(BITSELECT,167)@4
    twoToMiSiYip_uid168_atan2Test_b <= STD_LOGIC_VECTOR(yip1_8_uid161_atan2Test_b(39 downto 8));

    -- invSignOfSelectionSignal_uid153_atan2Test(LOGICAL,152)@4
    invSignOfSelectionSignal_uid153_atan2Test_q <= not (xMSB_uid146_atan2Test_b);

    -- twoToMiSiYip_uid151_atan2Test(BITSELECT,150)@4
    twoToMiSiYip_uid151_atan2Test_b <= STD_LOGIC_VECTOR(redist10_yip1_7_uid144_atan2Test_b_1_q(40 downto 7));

    -- xip1E_8_uid154_atan2Test(ADDSUB,153)@4
    xip1E_8_uid154_atan2Test_s <= invSignOfSelectionSignal_uid153_atan2Test_q;
    xip1E_8_uid154_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & redist11_xip1_7_uid143_atan2Test_b_1_q));
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

    -- xip1_8_uid160_atan2Test(BITSELECT,159)@4
    xip1_8_uid160_atan2Test_in <= xip1E_8_uid154_atan2Test_q(45 downto 0);
    xip1_8_uid160_atan2Test_b <= xip1_8_uid160_atan2Test_in(45 downto 0);

    -- xip1E_9_uid171_atan2Test(ADDSUB,170)@4
    xip1E_9_uid171_atan2Test_s <= invSignOfSelectionSignal_uid170_atan2Test_q;
    xip1E_9_uid171_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & xip1_8_uid160_atan2Test_b));
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

    -- xip1_9_uid177_atan2Test(BITSELECT,176)@4
    xip1_9_uid177_atan2Test_in <= xip1E_9_uid171_atan2Test_q(45 downto 0);
    xip1_9_uid177_atan2Test_b <= xip1_9_uid177_atan2Test_in(45 downto 0);

    -- redist8_xip1_9_uid177_atan2Test_b_1(DELAY,284)
    redist8_xip1_9_uid177_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 46, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_9_uid177_atan2Test_b, xout => redist8_xip1_9_uid177_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- twoToMiSiXip_uid184_atan2Test(BITSELECT,183)@5
    twoToMiSiXip_uid184_atan2Test_b <= redist8_xip1_9_uid177_atan2Test_b_1_q(45 downto 9);

    -- twoToMiSiXip_uid167_atan2Test(BITSELECT,166)@4
    twoToMiSiXip_uid167_atan2Test_b <= xip1_8_uid160_atan2Test_b(45 downto 8);

    -- yip1E_9_uid172_atan2Test(ADDSUB,171)@4
    yip1E_9_uid172_atan2Test_s <= xMSB_uid163_atan2Test_b;
    yip1E_9_uid172_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((41 downto 40 => yip1_8_uid161_atan2Test_b(39)) & yip1_8_uid161_atan2Test_b));
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

    -- yip1_9_uid178_atan2Test(BITSELECT,177)@4
    yip1_9_uid178_atan2Test_in <= STD_LOGIC_VECTOR(yip1E_9_uid172_atan2Test_q(38 downto 0));
    yip1_9_uid178_atan2Test_b <= STD_LOGIC_VECTOR(yip1_9_uid178_atan2Test_in(38 downto 0));

    -- redist7_yip1_9_uid178_atan2Test_b_1(DELAY,283)
    redist7_yip1_9_uid178_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 39, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_9_uid178_atan2Test_b, xout => redist7_yip1_9_uid178_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- yip1E_10_uid189_atan2Test(ADDSUB,188)@5
    yip1E_10_uid189_atan2Test_s <= xMSB_uid180_atan2Test_b;
    yip1E_10_uid189_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((40 downto 39 => redist7_yip1_9_uid178_atan2Test_b_1_q(38)) & redist7_yip1_9_uid178_atan2Test_b_1_q));
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

    -- yip1_10_uid195_atan2Test(BITSELECT,194)@5
    yip1_10_uid195_atan2Test_in <= STD_LOGIC_VECTOR(yip1E_10_uid189_atan2Test_q(37 downto 0));
    yip1_10_uid195_atan2Test_b <= STD_LOGIC_VECTOR(yip1_10_uid195_atan2Test_in(37 downto 0));

    -- xMSB_uid197_atan2Test(BITSELECT,196)@5
    xMSB_uid197_atan2Test_b <= STD_LOGIC_VECTOR(yip1_10_uid195_atan2Test_b(37 downto 37));

    -- invSignOfSelectionSignal_uid204_atan2Test(LOGICAL,203)@5
    invSignOfSelectionSignal_uid204_atan2Test_q <= not (xMSB_uid197_atan2Test_b);

    -- twoToMiSiYip_uid202_atan2Test(BITSELECT,201)@5
    twoToMiSiYip_uid202_atan2Test_b <= STD_LOGIC_VECTOR(yip1_10_uid195_atan2Test_b(37 downto 10));

    -- invSignOfSelectionSignal_uid187_atan2Test(LOGICAL,186)@5
    invSignOfSelectionSignal_uid187_atan2Test_q <= not (xMSB_uid180_atan2Test_b);

    -- twoToMiSiYip_uid185_atan2Test(BITSELECT,184)@5
    twoToMiSiYip_uid185_atan2Test_b <= STD_LOGIC_VECTOR(redist7_yip1_9_uid178_atan2Test_b_1_q(38 downto 9));

    -- xip1E_10_uid188_atan2Test(ADDSUB,187)@5
    xip1E_10_uid188_atan2Test_s <= invSignOfSelectionSignal_uid187_atan2Test_q;
    xip1E_10_uid188_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & redist8_xip1_9_uid177_atan2Test_b_1_q));
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

    -- xip1_10_uid194_atan2Test(BITSELECT,193)@5
    xip1_10_uid194_atan2Test_in <= xip1E_10_uid188_atan2Test_q(45 downto 0);
    xip1_10_uid194_atan2Test_b <= xip1_10_uid194_atan2Test_in(45 downto 0);

    -- xip1E_11_uid205_atan2Test(ADDSUB,204)@5
    xip1E_11_uid205_atan2Test_s <= invSignOfSelectionSignal_uid204_atan2Test_q;
    xip1E_11_uid205_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & xip1_10_uid194_atan2Test_b));
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

    -- xip1_11_uid211_atan2Test(BITSELECT,210)@5
    xip1_11_uid211_atan2Test_in <= xip1E_11_uid205_atan2Test_q(45 downto 0);
    xip1_11_uid211_atan2Test_b <= xip1_11_uid211_atan2Test_in(45 downto 0);

    -- twoToMiSiXip_uid218_atan2Test(BITSELECT,217)@5
    twoToMiSiXip_uid218_atan2Test_b <= xip1_11_uid211_atan2Test_b(45 downto 11);

    -- redist3_twoToMiSiXip_uid218_atan2Test_b_1(DELAY,279)
    redist3_twoToMiSiXip_uid218_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 35, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => twoToMiSiXip_uid218_atan2Test_b, xout => redist3_twoToMiSiXip_uid218_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- twoToMiSiXip_uid201_atan2Test(BITSELECT,200)@5
    twoToMiSiXip_uid201_atan2Test_b <= xip1_10_uid194_atan2Test_b(45 downto 10);

    -- yip1E_11_uid206_atan2Test(ADDSUB,205)@5
    yip1E_11_uid206_atan2Test_s <= xMSB_uid197_atan2Test_b;
    yip1E_11_uid206_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((39 downto 38 => yip1_10_uid195_atan2Test_b(37)) & yip1_10_uid195_atan2Test_b));
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

    -- yip1_11_uid212_atan2Test(BITSELECT,211)@5
    yip1_11_uid212_atan2Test_in <= STD_LOGIC_VECTOR(yip1E_11_uid206_atan2Test_q(36 downto 0));
    yip1_11_uid212_atan2Test_b <= STD_LOGIC_VECTOR(yip1_11_uid212_atan2Test_in(36 downto 0));

    -- redist5_yip1_11_uid212_atan2Test_b_1(DELAY,281)
    redist5_yip1_11_uid212_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_11_uid212_atan2Test_b, xout => redist5_yip1_11_uid212_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- yip1E_12_uid223_atan2Test(ADDSUB,222)@6
    yip1E_12_uid223_atan2Test_s <= xMSB_uid214_atan2Test_b;
    yip1E_12_uid223_atan2Test_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 37 => redist5_yip1_11_uid212_atan2Test_b_1_q(36)) & redist5_yip1_11_uid212_atan2Test_b_1_q));
    yip1E_12_uid223_atan2Test_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & redist3_twoToMiSiXip_uid218_atan2Test_b_1_q));
    yip1E_12_uid223_atan2Test_combproc: PROCESS (yip1E_12_uid223_atan2Test_a, yip1E_12_uid223_atan2Test_b, yip1E_12_uid223_atan2Test_s)
    BEGIN
        IF (yip1E_12_uid223_atan2Test_s = "1") THEN
            yip1E_12_uid223_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_12_uid223_atan2Test_a) + SIGNED(yip1E_12_uid223_atan2Test_b));
        ELSE
            yip1E_12_uid223_atan2Test_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_12_uid223_atan2Test_a) - SIGNED(yip1E_12_uid223_atan2Test_b));
        END IF;
    END PROCESS;
    yip1E_12_uid223_atan2Test_q <= yip1E_12_uid223_atan2Test_o(37 downto 0);

    -- yip1_12_uid229_atan2Test(BITSELECT,228)@6
    yip1_12_uid229_atan2Test_in <= STD_LOGIC_VECTOR(yip1E_12_uid223_atan2Test_q(35 downto 0));
    yip1_12_uid229_atan2Test_b <= STD_LOGIC_VECTOR(yip1_12_uid229_atan2Test_in(35 downto 0));

    -- xMSB_uid231_atan2Test(BITSELECT,230)@6
    xMSB_uid231_atan2Test_b <= STD_LOGIC_VECTOR(yip1_12_uid229_atan2Test_b(35 downto 35));

    -- invSignOfSelectionSignal_uid241_atan2Test(LOGICAL,240)@6
    invSignOfSelectionSignal_uid241_atan2Test_q <= not (xMSB_uid231_atan2Test_b);

    -- cstArcTan2Mi_12_uid237_atan2Test(CONSTANT,236)
    cstArcTan2Mi_12_uid237_atan2Test_q <= "0111111111111111111111111101010101";

    -- invSignOfSelectionSignal_uid224_atan2Test(LOGICAL,223)@6
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

    -- highBBits_uid26_atan2Test(BITSELECT,25)@1
    highBBits_uid26_atan2Test_b <= STD_LOGIC_VECTOR(cstArcTan2Mi_0_uid22_atan2Test_q(21 downto 21));

    -- lowRangeB_uid25_atan2Test(BITSELECT,24)@1
    lowRangeB_uid25_atan2Test_in <= cstArcTan2Mi_0_uid22_atan2Test_q(20 downto 0);
    lowRangeB_uid25_atan2Test_b <= lowRangeB_uid25_atan2Test_in(20 downto 0);

    -- aip1E_1_uid28_atan2Test(BITJOIN,27)@1
    aip1E_1_uid28_atan2Test_q <= STD_LOGIC_VECTOR((2 downto 1 => highBBits_uid26_atan2Test_b(0)) & highBBits_uid26_atan2Test_b) & lowRangeB_uid25_atan2Test_b;

    -- aip1E_uid31_atan2Test(BITSELECT,30)@1
    aip1E_uid31_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_1_uid28_atan2Test_q(22 downto 0));
    aip1E_uid31_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid31_atan2Test_in(22 downto 0));

    -- aip1E_2NA_uid46_atan2Test(BITJOIN,45)@1
    aip1E_2NA_uid46_atan2Test_q <= aip1E_uid31_atan2Test_b & aip1E_2CostZeroPaddingA_uid45_atan2Test_q;

    -- aip1E_2sumAHighB_uid47_atan2Test(ADDSUB,46)@1
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

    -- aip1E_uid50_atan2Test(BITSELECT,49)@1
    aip1E_uid50_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_2sumAHighB_uid47_atan2Test_q(24 downto 0));
    aip1E_uid50_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid50_atan2Test_in(24 downto 0));

    -- aip1E_3NA_uid65_atan2Test(BITJOIN,64)@1
    aip1E_3NA_uid65_atan2Test_q <= aip1E_uid50_atan2Test_b & aip1E_2CostZeroPaddingA_uid45_atan2Test_q;

    -- aip1E_3sumAHighB_uid66_atan2Test(ADDSUB,65)@1
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

    -- aip1E_uid69_atan2Test(BITSELECT,68)@1
    aip1E_uid69_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_3sumAHighB_uid66_atan2Test_q(26 downto 0));
    aip1E_uid69_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid69_atan2Test_in(26 downto 0));

    -- redist15_aip1E_uid69_atan2Test_b_1(DELAY,291)
    redist15_aip1E_uid69_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 27, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid69_atan2Test_b, xout => redist15_aip1E_uid69_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- aip1E_4NA_uid84_atan2Test(BITJOIN,83)@2
    aip1E_4NA_uid84_atan2Test_q <= redist15_aip1E_uid69_atan2Test_b_1_q & aip1E_2CostZeroPaddingA_uid45_atan2Test_q;

    -- aip1E_4sumAHighB_uid85_atan2Test(ADDSUB,84)@2
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

    -- aip1E_uid88_atan2Test(BITSELECT,87)@2
    aip1E_uid88_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_4sumAHighB_uid85_atan2Test_q(28 downto 0));
    aip1E_uid88_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid88_atan2Test_in(28 downto 0));

    -- aip1E_5NA_uid103_atan2Test(BITJOIN,102)@2
    aip1E_5NA_uid103_atan2Test_q <= aip1E_uid88_atan2Test_b & aip1E_2CostZeroPaddingA_uid45_atan2Test_q;

    -- aip1E_5sumAHighB_uid104_atan2Test(ADDSUB,103)@2
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

    -- aip1E_uid107_atan2Test(BITSELECT,106)@2
    aip1E_uid107_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_5sumAHighB_uid104_atan2Test_q(30 downto 0));
    aip1E_uid107_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid107_atan2Test_in(30 downto 0));

    -- redist12_aip1E_uid107_atan2Test_b_1(DELAY,288)
    redist12_aip1E_uid107_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 31, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid107_atan2Test_b, xout => redist12_aip1E_uid107_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- aip1E_6NA_uid124_atan2Test(BITJOIN,123)@3
    aip1E_6NA_uid124_atan2Test_q <= redist12_aip1E_uid107_atan2Test_b_1_q & aip1E_2CostZeroPaddingA_uid45_atan2Test_q;

    -- aip1E_6sumAHighB_uid125_atan2Test(ADDSUB,124)@3
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

    -- aip1E_uid128_atan2Test(BITSELECT,127)@3
    aip1E_uid128_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_6sumAHighB_uid125_atan2Test_q(32 downto 0));
    aip1E_uid128_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid128_atan2Test_in(32 downto 0));

    -- aip1E_7NA_uid141_atan2Test(BITJOIN,140)@3
    aip1E_7NA_uid141_atan2Test_q <= aip1E_uid128_atan2Test_b & aip1E_2CostZeroPaddingA_uid45_atan2Test_q;

    -- aip1E_7sumAHighB_uid142_atan2Test(ADDSUB,141)@3
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

    -- aip1E_uid145_atan2Test(BITSELECT,144)@3
    aip1E_uid145_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_7sumAHighB_uid142_atan2Test_q(34 downto 0));
    aip1E_uid145_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid145_atan2Test_in(34 downto 0));

    -- redist9_aip1E_uid145_atan2Test_b_1(DELAY,285)
    redist9_aip1E_uid145_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 35, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid145_atan2Test_b, xout => redist9_aip1E_uid145_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- aip1E_8NA_uid158_atan2Test(BITJOIN,157)@4
    aip1E_8NA_uid158_atan2Test_q <= redist9_aip1E_uid145_atan2Test_b_1_q & aip1E_2CostZeroPaddingA_uid45_atan2Test_q;

    -- aip1E_8sumAHighB_uid159_atan2Test(ADDSUB,158)@4
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

    -- aip1E_uid162_atan2Test(BITSELECT,161)@4
    aip1E_uid162_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_8sumAHighB_uid159_atan2Test_q(36 downto 0));
    aip1E_uid162_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid162_atan2Test_in(36 downto 0));

    -- aip1E_9NA_uid175_atan2Test(BITJOIN,174)@4
    aip1E_9NA_uid175_atan2Test_q <= aip1E_uid162_atan2Test_b & aip1E_2CostZeroPaddingA_uid45_atan2Test_q;

    -- aip1E_9sumAHighB_uid176_atan2Test(ADDSUB,175)@4
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

    -- aip1E_uid179_atan2Test(BITSELECT,178)@4
    aip1E_uid179_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_9sumAHighB_uid176_atan2Test_q(38 downto 0));
    aip1E_uid179_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid179_atan2Test_in(38 downto 0));

    -- redist6_aip1E_uid179_atan2Test_b_1(DELAY,282)
    redist6_aip1E_uid179_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 39, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid179_atan2Test_b, xout => redist6_aip1E_uid179_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- aip1E_10NA_uid192_atan2Test(BITJOIN,191)@5
    aip1E_10NA_uid192_atan2Test_q <= redist6_aip1E_uid179_atan2Test_b_1_q & aip1E_2CostZeroPaddingA_uid45_atan2Test_q;

    -- aip1E_10sumAHighB_uid193_atan2Test(ADDSUB,192)@5
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

    -- aip1E_uid196_atan2Test(BITSELECT,195)@5
    aip1E_uid196_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_10sumAHighB_uid193_atan2Test_q(40 downto 0));
    aip1E_uid196_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid196_atan2Test_in(40 downto 0));

    -- aip1E_11NA_uid209_atan2Test(BITJOIN,208)@5
    aip1E_11NA_uid209_atan2Test_q <= aip1E_uid196_atan2Test_b & aip1E_2CostZeroPaddingA_uid45_atan2Test_q;

    -- aip1E_11sumAHighB_uid210_atan2Test(ADDSUB,209)@5
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

    -- aip1E_uid213_atan2Test(BITSELECT,212)@5
    aip1E_uid213_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_11sumAHighB_uid210_atan2Test_q(42 downto 0));
    aip1E_uid213_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid213_atan2Test_in(42 downto 0));

    -- redist4_aip1E_uid213_atan2Test_b_1(DELAY,280)
    redist4_aip1E_uid213_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 43, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid213_atan2Test_b, xout => redist4_aip1E_uid213_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- aip1E_12NA_uid226_atan2Test(BITJOIN,225)@6
    aip1E_12NA_uid226_atan2Test_q <= redist4_aip1E_uid213_atan2Test_b_1_q & aip1E_2CostZeroPaddingA_uid45_atan2Test_q;

    -- aip1E_12sumAHighB_uid227_atan2Test(ADDSUB,226)@6
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

    -- aip1E_uid230_atan2Test(BITSELECT,229)@6
    aip1E_uid230_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_12sumAHighB_uid227_atan2Test_q(44 downto 0));
    aip1E_uid230_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid230_atan2Test_in(44 downto 0));

    -- aip1E_13NA_uid243_atan2Test(BITJOIN,242)@6
    aip1E_13NA_uid243_atan2Test_q <= aip1E_uid230_atan2Test_b & aip1E_2CostZeroPaddingA_uid45_atan2Test_q;

    -- aip1E_13sumAHighB_uid244_atan2Test(ADDSUB,243)@6
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

    -- aip1E_uid247_atan2Test(BITSELECT,246)@6
    aip1E_uid247_atan2Test_in <= STD_LOGIC_VECTOR(aip1E_13sumAHighB_uid244_atan2Test_q(46 downto 0));
    aip1E_uid247_atan2Test_b <= STD_LOGIC_VECTOR(aip1E_uid247_atan2Test_in(46 downto 0));

    -- alphaPreRnd_uid248_atan2Test(BITSELECT,247)@6
    alphaPreRnd_uid248_atan2Test_b <= aip1E_uid247_atan2Test_b(46 downto 33);

    -- redist2_alphaPreRnd_uid248_atan2Test_b_1(DELAY,278)
    redist2_alphaPreRnd_uid248_atan2Test_b_1 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => alphaPreRnd_uid248_atan2Test_b, xout => redist2_alphaPreRnd_uid248_atan2Test_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- lowRangeA_uid252_atan2Test_merged_bit_select(BITSELECT,275)@7
    lowRangeA_uid252_atan2Test_merged_bit_select_b <= redist2_alphaPreRnd_uid248_atan2Test_b_1_q(0 downto 0);
    lowRangeA_uid252_atan2Test_merged_bit_select_c <= redist2_alphaPreRnd_uid248_atan2Test_b_1_q(13 downto 1);

    -- alphaPostRnd_uid255_atan2Test(BITJOIN,254)@7
    alphaPostRnd_uid255_atan2Test_q <= alphaPostRndhigh_uid254_atan2Test_q & lowRangeA_uid252_atan2Test_merged_bit_select_b;

    -- atanRes_uid256_atan2Test(BITSELECT,255)@7
    atanRes_uid256_atan2Test_in <= alphaPostRnd_uid255_atan2Test_q(13 downto 0);
    atanRes_uid256_atan2Test_b <= atanRes_uid256_atan2Test_in(13 downto 0);

    -- xNotZero_uid17_atan2Test(LOGICAL,16)@0 + 1
    xNotZero_uid17_atan2Test_qi <= "1" WHEN x /= "00000000000000000000000000000000" ELSE "0";
    xNotZero_uid17_atan2Test_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xNotZero_uid17_atan2Test_qi, xout => xNotZero_uid17_atan2Test_q, ena => en(0), clk => clk, aclr => areset );

    -- redist18_xNotZero_uid17_atan2Test_q_7(DELAY,294)
    redist18_xNotZero_uid17_atan2Test_q_7 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "ASYNC" )
    PORT MAP ( xin => xNotZero_uid17_atan2Test_q, xout => redist18_xNotZero_uid17_atan2Test_q_7_q, ena => en(0), clk => clk, aclr => areset );

    -- xZero_uid18_atan2Test(LOGICAL,17)@7
    xZero_uid18_atan2Test_q <= not (redist18_xNotZero_uid17_atan2Test_q_7_q);

    -- yNotZero_uid15_atan2Test(LOGICAL,14)@0 + 1
    yNotZero_uid15_atan2Test_qi <= "1" WHEN y /= "00000000000000000000000000000000" ELSE "0";
    yNotZero_uid15_atan2Test_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yNotZero_uid15_atan2Test_qi, xout => yNotZero_uid15_atan2Test_q, ena => en(0), clk => clk, aclr => areset );

    -- redist19_yNotZero_uid15_atan2Test_q_7(DELAY,295)
    redist19_yNotZero_uid15_atan2Test_q_7 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "ASYNC" )
    PORT MAP ( xin => yNotZero_uid15_atan2Test_q, xout => redist19_yNotZero_uid15_atan2Test_q_7_q, ena => en(0), clk => clk, aclr => areset );

    -- yZero_uid16_atan2Test(LOGICAL,15)@7
    yZero_uid16_atan2Test_q <= not (redist19_yNotZero_uid15_atan2Test_q_7_q);

    -- concXZeroYZero_uid263_atan2Test(BITJOIN,262)@7
    concXZeroYZero_uid263_atan2Test_q <= xZero_uid18_atan2Test_q & yZero_uid16_atan2Test_q;

    -- atanResPostExc_uid264_atan2Test(MUX,263)@7 + 1
    atanResPostExc_uid264_atan2Test_s <= concXZeroYZero_uid263_atan2Test_q;
    atanResPostExc_uid264_atan2Test_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            atanResPostExc_uid264_atan2Test_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                CASE (atanResPostExc_uid264_atan2Test_s) IS
                    WHEN "00" => atanResPostExc_uid264_atan2Test_q <= atanRes_uid256_atan2Test_b;
                    WHEN "01" => atanResPostExc_uid264_atan2Test_q <= cstZeroOutFormat_uid257_atan2Test_q;
                    WHEN "10" => atanResPostExc_uid264_atan2Test_q <= constPio2P2u_mergedSignalTM_uid261_atan2Test_q;
                    WHEN "11" => atanResPostExc_uid264_atan2Test_q <= cstZeroOutFormat_uid257_atan2Test_q;
                    WHEN OTHERS => atanResPostExc_uid264_atan2Test_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- constantZeroOutFormat_uid268_atan2Test(CONSTANT,267)
    constantZeroOutFormat_uid268_atan2Test_q <= "00000000000000";

    -- concSigns_uid265_atan2Test(BITJOIN,264)@0
    concSigns_uid265_atan2Test_q <= signX_uid7_atan2Test_b & signY_uid8_atan2Test_b;

    -- redist1_concSigns_uid265_atan2Test_q_8(DELAY,277)
    redist1_concSigns_uid265_atan2Test_q_8 : dspba_delay
    GENERIC MAP ( width => 2, depth => 8, reset_kind => "ASYNC" )
    PORT MAP ( xin => concSigns_uid265_atan2Test_q, xout => redist1_concSigns_uid265_atan2Test_q_8_q, ena => en(0), clk => clk, aclr => areset );

    -- secondOperand_uid272_atan2Test(MUX,271)@8
    secondOperand_uid272_atan2Test_s <= redist1_concSigns_uid265_atan2Test_q_8_q;
    secondOperand_uid272_atan2Test_combproc: PROCESS (secondOperand_uid272_atan2Test_s, en, constantZeroOutFormat_uid268_atan2Test_q, atanResPostExc_uid264_atan2Test_q, constPi_uid267_atan2Test_q)
    BEGIN
        CASE (secondOperand_uid272_atan2Test_s) IS
            WHEN "00" => secondOperand_uid272_atan2Test_q <= constantZeroOutFormat_uid268_atan2Test_q;
            WHEN "01" => secondOperand_uid272_atan2Test_q <= atanResPostExc_uid264_atan2Test_q;
            WHEN "10" => secondOperand_uid272_atan2Test_q <= atanResPostExc_uid264_atan2Test_q;
            WHEN "11" => secondOperand_uid272_atan2Test_q <= constPi_uid267_atan2Test_q;
            WHEN OTHERS => secondOperand_uid272_atan2Test_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- constPiP2u_uid266_atan2Test(CONSTANT,265)
    constPiP2u_uid266_atan2Test_q <= "11001001000111";

    -- constantZeroOutFormatP2u_uid269_atan2Test(CONSTANT,268)
    constantZeroOutFormatP2u_uid269_atan2Test_q <= "00000000000100";

    -- firstOperand_uid271_atan2Test(MUX,270)@8
    firstOperand_uid271_atan2Test_s <= redist1_concSigns_uid265_atan2Test_q_8_q;
    firstOperand_uid271_atan2Test_combproc: PROCESS (firstOperand_uid271_atan2Test_s, en, atanResPostExc_uid264_atan2Test_q, constantZeroOutFormatP2u_uid269_atan2Test_q, constPiP2u_uid266_atan2Test_q)
    BEGIN
        CASE (firstOperand_uid271_atan2Test_s) IS
            WHEN "00" => firstOperand_uid271_atan2Test_q <= atanResPostExc_uid264_atan2Test_q;
            WHEN "01" => firstOperand_uid271_atan2Test_q <= constantZeroOutFormatP2u_uid269_atan2Test_q;
            WHEN "10" => firstOperand_uid271_atan2Test_q <= constPiP2u_uid266_atan2Test_q;
            WHEN "11" => firstOperand_uid271_atan2Test_q <= atanResPostExc_uid264_atan2Test_q;
            WHEN OTHERS => firstOperand_uid271_atan2Test_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- outResExtended_uid273_atan2Test(SUB,272)@8
    outResExtended_uid273_atan2Test_a <= STD_LOGIC_VECTOR("0" & firstOperand_uid271_atan2Test_q);
    outResExtended_uid273_atan2Test_b <= STD_LOGIC_VECTOR("0" & secondOperand_uid272_atan2Test_q);
    outResExtended_uid273_atan2Test_o <= STD_LOGIC_VECTOR(UNSIGNED(outResExtended_uid273_atan2Test_a) - UNSIGNED(outResExtended_uid273_atan2Test_b));
    outResExtended_uid273_atan2Test_q <= outResExtended_uid273_atan2Test_o(14 downto 0);

    -- atanResPostRR_uid274_atan2Test(BITSELECT,273)@8
    atanResPostRR_uid274_atan2Test_b <= STD_LOGIC_VECTOR(outResExtended_uid273_atan2Test_q(14 downto 2));

    -- redist0_atanResPostRR_uid274_atan2Test_b_5_wraddr(REG,299)
    redist0_atanResPostRR_uid274_atan2Test_b_5_wraddr_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist0_atanResPostRR_uid274_atan2Test_b_5_wraddr_q <= "11";
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist0_atanResPostRR_uid274_atan2Test_b_5_wraddr_q <= STD_LOGIC_VECTOR(redist0_atanResPostRR_uid274_atan2Test_b_5_rdmux_q);
        END IF;
    END PROCESS;

    -- redist0_atanResPostRR_uid274_atan2Test_b_5_mem(DUALMEM,296)
    redist0_atanResPostRR_uid274_atan2Test_b_5_mem_ia <= STD_LOGIC_VECTOR(atanResPostRR_uid274_atan2Test_b);
    redist0_atanResPostRR_uid274_atan2Test_b_5_mem_aa <= redist0_atanResPostRR_uid274_atan2Test_b_5_wraddr_q;
    redist0_atanResPostRR_uid274_atan2Test_b_5_mem_ab <= redist0_atanResPostRR_uid274_atan2Test_b_5_rdmux_q;
    redist0_atanResPostRR_uid274_atan2Test_b_5_mem_reset0 <= areset;
    redist0_atanResPostRR_uid274_atan2Test_b_5_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 13,
        widthad_a => 2,
        numwords_a => 4,
        width_b => 13,
        widthad_b => 2,
        numwords_b => 4,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken1 => redist0_atanResPostRR_uid274_atan2Test_b_5_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clk,
        aclr1 => redist0_atanResPostRR_uid274_atan2Test_b_5_mem_reset0,
        clock1 => clk,
        address_a => redist0_atanResPostRR_uid274_atan2Test_b_5_mem_aa,
        data_a => redist0_atanResPostRR_uid274_atan2Test_b_5_mem_ia,
        wren_a => en(0),
        address_b => redist0_atanResPostRR_uid274_atan2Test_b_5_mem_ab,
        q_b => redist0_atanResPostRR_uid274_atan2Test_b_5_mem_iq
    );
    redist0_atanResPostRR_uid274_atan2Test_b_5_mem_q <= redist0_atanResPostRR_uid274_atan2Test_b_5_mem_iq(12 downto 0);

    -- xOut(GPOUT,4)@13
    q <= redist0_atanResPostRR_uid274_atan2Test_b_5_mem_q;

END normal;
