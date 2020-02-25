//Code manipulated from https://github.com/Jambie82/CycloneV_HPS_FIFO

interface command;
	logic [3:0] cmd;                  // command number
	logic [13:0] x_value;               // x or t argument
	logic [13:0] y_value;               // y argument
	modport to_set(input cmd, input x_value, input y_value);
	modport to_read(output cmd, output x_value, output y_value);
endinterface : command

module DE1_SoC_Computer (
	////////////////////////////////////
	// FPGA Pins
	////////////////////////////////////

	// Clock pins
	CLOCK_50,
	CLOCK2_50,
	CLOCK3_50,
	CLOCK4_50,

	// ADC
	ADC_CS_N,
	ADC_DIN,
	ADC_DOUT,
	ADC_SCLK,

	// Audio
	AUD_ADCDAT,
	AUD_ADCLRCK,
	AUD_BCLK,
	AUD_DACDAT,
	AUD_DACLRCK,
	AUD_XCK,

	// SDRAM
	DRAM_ADDR,
	DRAM_BA,
	DRAM_CAS_N,
	DRAM_CKE,
	DRAM_CLK,
	DRAM_CS_N,
	DRAM_DQ,
	DRAM_LDQM,
	DRAM_RAS_N,
	DRAM_UDQM,
	DRAM_WE_N,

	// I2C Bus for Configuration of the Audio and Video-In Chips
	FPGA_I2C_SCLK,
	FPGA_I2C_SDAT,

	// 40-Pin Headers
	GPIO_0,
	GPIO_1,
	
	// Seven Segment Displays
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	HEX5,

	// IR
	IRDA_RXD,
	IRDA_TXD,

	// Pushbuttons
	KEY,

	// LEDs
	LEDR,

	// PS2 Ports
	PS2_CLK,
	PS2_DAT,
	
	PS2_CLK2,
	PS2_DAT2,

	// Slider Switches
	SW,

	// Video-In
	TD_CLK27,
	TD_DATA,
	TD_HS,
	TD_RESET_N,
	TD_VS,

	// VGA
	VGA_B,
	VGA_BLANK_N,
	VGA_CLK,
	VGA_G,
	VGA_HS,
	VGA_R,
	VGA_SYNC_N,
	VGA_VS,

	////////////////////////////////////
	// HPS Pins
	////////////////////////////////////
	
	// DDR3 SDRAM
	HPS_DDR3_ADDR,
	HPS_DDR3_BA,
	HPS_DDR3_CAS_N,
	HPS_DDR3_CKE,
	HPS_DDR3_CK_N,
	HPS_DDR3_CK_P,
	HPS_DDR3_CS_N,
	HPS_DDR3_DM,
	HPS_DDR3_DQ,
	HPS_DDR3_DQS_N,
	HPS_DDR3_DQS_P,
	HPS_DDR3_ODT,
	HPS_DDR3_RAS_N,
	HPS_DDR3_RESET_N,
	HPS_DDR3_RZQ,
	HPS_DDR3_WE_N,

	// Ethernet
	HPS_ENET_GTX_CLK,
	HPS_ENET_INT_N,
	HPS_ENET_MDC,
	HPS_ENET_MDIO,
	HPS_ENET_RX_CLK,
	HPS_ENET_RX_DATA,
	HPS_ENET_RX_DV,
	HPS_ENET_TX_DATA,
	HPS_ENET_TX_EN,

	// Flash
	HPS_FLASH_DATA,
	HPS_FLASH_DCLK,
	HPS_FLASH_NCSO,

	// Accelerometer
	HPS_GSENSOR_INT,
		
	// General Purpose I/O
	HPS_GPIO,
		
	// I2C
	HPS_I2C_CONTROL,
	HPS_I2C1_SCLK,
	HPS_I2C1_SDAT,
	HPS_I2C2_SCLK,
	HPS_I2C2_SDAT,

	// Pushbutton
	HPS_KEY,

	// LED
	HPS_LED,
		
	// SD Card
	HPS_SD_CLK,
	HPS_SD_CMD,
	HPS_SD_DATA,

	// SPI
	HPS_SPIM_CLK,
	HPS_SPIM_MISO,
	HPS_SPIM_MOSI,
	HPS_SPIM_SS,

	// UART
	HPS_UART_RX,
	HPS_UART_TX,

	// USB
	HPS_CONV_USB_N,
	HPS_USB_CLKOUT,
	HPS_USB_DATA,
	HPS_USB_DIR,
	HPS_USB_NXT,
	HPS_USB_STP // ,
	
	// new clock
//	PLL0_REFCLK, 
//	PLL0_RESET,
//	MASTERclk

);

//=======================================================
//  PARAMETER declarations
//=======================================================
enum {READ_DATA, AWAIT_DATA, DELAY_READ_DATA, DELAY_AWAIT_DATA} HPS_to_FPGA_states;
//=======================================================
//  PORT declarations
//=======================================================

////////////////////////////////////
// FPGA Pins
////////////////////////////////////

// Clock pins
input						CLOCK_50;
input						CLOCK2_50;
input						CLOCK3_50;
input						CLOCK4_50;

// ADC
inout						ADC_CS_N;
output					ADC_DIN;
input						ADC_DOUT;
output					ADC_SCLK;

// Audio
input						AUD_ADCDAT;
inout						AUD_ADCLRCK;
inout						AUD_BCLK;
output					AUD_DACDAT;
inout						AUD_DACLRCK;
output					AUD_XCK;

// SDRAM
output 		[12: 0]	DRAM_ADDR;
output		[ 1: 0]	DRAM_BA;
output					DRAM_CAS_N;
output					DRAM_CKE;
output					DRAM_CLK;
output					DRAM_CS_N;
inout			[15: 0]	DRAM_DQ;
output					DRAM_LDQM;
output					DRAM_RAS_N;
output					DRAM_UDQM;
output					DRAM_WE_N;

// I2C Bus for Configuration of the Audio and Video-In Chips
output					FPGA_I2C_SCLK;
inout						FPGA_I2C_SDAT;

// 40-pin headers
inout			[35: 0]	GPIO_0;
inout			[35: 0]	GPIO_1;

// Seven Segment Displays
output		[ 6: 0]	HEX0;
output		[ 6: 0]	HEX1;
output		[ 6: 0]	HEX2;
output		[ 6: 0]	HEX3;
output		[ 6: 0]	HEX4;
output		[ 6: 0]	HEX5;

// IR
input						IRDA_RXD;
output					IRDA_TXD;

// Pushbuttons
input			[ 3: 0]	KEY;

// LEDs
output		[ 9: 0]	LEDR;

// PS2 Ports
inout						PS2_CLK;
inout						PS2_DAT;

inout						PS2_CLK2;
inout						PS2_DAT2;

// Slider Switches
input			[ 9: 0]	SW;

// Video-In
input						TD_CLK27;
input			[ 7: 0]	TD_DATA;
input						TD_HS;
output					TD_RESET_N;
input						TD_VS;

// VGA
output		[ 7: 0]	VGA_B;
output					VGA_BLANK_N;
output					VGA_CLK;
output		[ 7: 0]	VGA_G;
output					VGA_HS;
output		[ 7: 0]	VGA_R;
output					VGA_SYNC_N;
output					VGA_VS;



////////////////////////////////////
// HPS Pins
////////////////////////////////////
	
// DDR3 SDRAM
output		[14: 0]	HPS_DDR3_ADDR;
output		[ 2: 0]  HPS_DDR3_BA;
output					HPS_DDR3_CAS_N;
output					HPS_DDR3_CKE;
output					HPS_DDR3_CK_N;
output					HPS_DDR3_CK_P;
output					HPS_DDR3_CS_N;
output		[ 3: 0]	HPS_DDR3_DM;
inout			[31: 0]	HPS_DDR3_DQ;
inout			[ 3: 0]	HPS_DDR3_DQS_N;
inout			[ 3: 0]	HPS_DDR3_DQS_P;
output					HPS_DDR3_ODT;
output					HPS_DDR3_RAS_N;
output					HPS_DDR3_RESET_N;
input						HPS_DDR3_RZQ;
output					HPS_DDR3_WE_N;

// Ethernet
output					HPS_ENET_GTX_CLK;
inout						HPS_ENET_INT_N;
output					HPS_ENET_MDC;
inout						HPS_ENET_MDIO;
input						HPS_ENET_RX_CLK;
input			[ 3: 0]	HPS_ENET_RX_DATA;
input						HPS_ENET_RX_DV;
output		[ 3: 0]	HPS_ENET_TX_DATA;
output					HPS_ENET_TX_EN;

// Flash
inout			[ 3: 0]	HPS_FLASH_DATA;
output					HPS_FLASH_DCLK;
output					HPS_FLASH_NCSO;

// Accelerometer
inout						HPS_GSENSOR_INT;

// General Purpose I/O
inout			[ 1: 0]	HPS_GPIO;

// I2C
inout						HPS_I2C_CONTROL;
inout						HPS_I2C1_SCLK;
inout						HPS_I2C1_SDAT;
inout						HPS_I2C2_SCLK;
inout						HPS_I2C2_SDAT;

// Pushbutton
inout						HPS_KEY;

// LED
inout						HPS_LED;

// SD Card
output					HPS_SD_CLK;
inout						HPS_SD_CMD;
inout			[ 3: 0]	HPS_SD_DATA;

// SPI
output					HPS_SPIM_CLK;
input						HPS_SPIM_MISO;
output					HPS_SPIM_MOSI;
inout						HPS_SPIM_SS;

// UART
input						HPS_UART_RX;
output					HPS_UART_TX;

// USB
inout						HPS_CONV_USB_N;
input						HPS_USB_CLKOUT;
inout			[ 7: 0]	HPS_USB_DATA;
input						HPS_USB_DIR;
input						HPS_USB_NXT;
output					HPS_USB_STP;

wire [13:0] ci2c_x_value;
wire [13:0] ci2c_y_value;
wire [4:0] ci2c_controller_state_reg;
wire c2ci_controller_ready;
wire controller_interface_out_ready;
wire controller_interface_in_ready;
reg memory_ready;

//=======================================================
//  REG/WIRE declarations
//=======================================================

wire			[23: 0]	hex;
//wire			[15: 0]	hex5_hex4;

//assign HEX0 = ~hex[ 6: 0]; // hex[ 6: 0]; 
//assign HEX1 = ~hex[14: 8];
//assign HEX2 = ~hex[22:16];
//assign HEX3 = ~hex[30:24];
//assign HEX4 = 7'b1111111;
//assign HEX5 = 7'b1111111;

HexDigit Digit0(HEX0, hex[3:0]);
HexDigit Digit1(HEX1, hex[7:4]);
HexDigit Digit2(HEX2, hex[11:8]);
HexDigit Digit3(HEX3, hex[15:12]);
HexDigit Digit4(HEX4, hex[19:16]);
HexDigit Digit5(HEX5, hex[23:20]);


//=======================================================
// HPS_to_FPGA FIFO state machine
//=======================================================
// --Check for data
//
// --Read data 
// --add one
// --write to SRAM
// --signal HPS data_ready
//=======================================================
// Controls for Qsys sram slave exported in system module
//=======================================================
wire [31:0] sram_readdata ;
reg [31:0] sram_writedata ;
reg [7:0] sram_address; 
reg sram_write ;
wire sram_clken = 1'b1;
wire sram_chipselect = 1'b1;
reg [7:0] state ;
reg initEnable = 0;

//=======================================================
// Controls for HPS_to_FPGA FIFO
//=======================================================

reg [31:0] hps_to_fpga_readdata ; 
reg hps_to_fpga_read ; // read command
// status addresses
// base => fill level
// base+1 => status bits; 
//           bit0==1 if full
//           bit1==1 if empty
wire [31:0] hps_to_fpga_out_csr_address = 32'd1 ; // fill_level  // should probably init to 0
reg[31:0] hps_to_fpga_out_csr_readdata ;
reg hps_to_fpga_out_csr_read ; // status regs read cmd
reg [7:0] HPS_to_FPGA_state ;
reg [31:0] data_buffer ;
reg data_buffer_valid ;

//=======================================================
// Controls for FPGA_to_HPS FIFO
//=======================================================

reg [31:0] fpga_to_hps_in_writedata ; 
reg fpga_to_hps_in_write ; // write command
// status addresses
// base => fill level
// base+1 => status bits; 
//           bit0==1 if full
//           bit1==1 if empty
wire [31:0] fpga_to_hps_in_csr_address = 32'd1 ; // fill_level  // should probably init to 0
reg[31:0] fpga_to_hps_in_csr_readdata ;
reg fpga_to_hps_in_csr_read ; // status regs read cmd
reg [7:0] FPGA_to_HPS_state ;


command commandIn();   // from HPS
reg [7:0]  commandCount = 8'b0;
wire fastclock;  // this is the clock to drive the timing
reg start_digcount = 1'b0;
reg [3:0] digcount_speed = 4'b1;
reg [31:0]  timecounter = 32'd25000000;
reg oneSecClock = 1'b0;
reg doLedInvert = 1'b0;
reg doLedRun = 1'b0;
reg [11:0] LEDcount = 12'd0;
reg doLedSet = 1'b0;
reg [3:0] setLed;
reg setCondition;
reg wasInverted = 1'b0;



//=======================================================
// do the work outlined above
always @(posedge CLOCK_50) begin 

   //  state machine and read/write controls
	if(initEnable == 0) begin
		sram_write <= 1'b0 ;
		commandCount <= 0 ;
		HPS_to_FPGA_state <= AWAIT_DATA ;
		FPGA_to_HPS_state <= 8'd0 ; 
		data_buffer_valid <= 1'b0;
		initEnable = 1;
		memory_ready <= 0;
		hps_to_fpga_read <= 0;
	end  // if(init_enable == 0)

// changing this to - get 4 32-bit words (command-data)
//                  - act on the command-data	
//                  - send a response as 4 32-bit words
	if(wasInverted == 1'b1)  // handshake to turn the invert function off
	begin
		doLedInvert <= 1'b0;
	end
	// =================================
	// HPS_to_FPGA state machine
	//==================================
	// Is there data in HPS_to_FPGA FIFO
	// and the last transfer is complete
	// data_buffer_valid is only used by the FPGA to HPS FIFO !!
	if (HPS_to_FPGA_state == AWAIT_DATA && !(hps_to_fpga_out_csr_readdata[1]))  begin
		hps_to_fpga_read <= 1'b1 ;
		HPS_to_FPGA_state <= DELAY_READ_DATA ; //
	end
	
	// delay before we read
	if (HPS_to_FPGA_state == DELAY_READ_DATA) begin
		// zero the read request BEFORE the data appears 
		// in the next state!
		hps_to_fpga_read <= 1'b0 ;
		HPS_to_FPGA_state <= READ_DATA;
	end
	
	
	// delay untill controller_interface is ready for new data
	// this test checks to see if we need more fifo read time
	if (HPS_to_FPGA_state == DELAY_AWAIT_DATA) begin
			memory_ready <= 0;
			HPS_to_FPGA_state <= AWAIT_DATA ;
		// Signal that return data is ready
		data_buffer_valid <= 1'b1 ;

	end
	
	// read the word from the FIFO
	if ((HPS_to_FPGA_state == READ_DATA) && (hps_to_fpga_read == 1'b0) && controller_interface_in_ready == 1) begin
		commandIn.cmd <= hps_to_fpga_readdata[3:0] ; // store the data
		commandIn.x_value <= hps_to_fpga_readdata[17:4];
		commandIn.y_value <= hps_to_fpga_readdata[31:18];
		commandCount <= 8'd1;
		hps_to_fpga_read <= 1'b0 ;
		HPS_to_FPGA_state <= DELAY_AWAIT_DATA ; 
		memory_ready <= 1;
	end
		
	// =================================
	// FPGA_to_HPS state machine
	//================================== 
	// is there space in the 
	// FPGA_to_HPS FIFO
	// and data is available
	if (FPGA_to_HPS_state==0 && !(fpga_to_hps_in_csr_readdata[0]) && data_buffer_valid) begin
//		fpga_to_hps_in_writedata <= data_buffer ;	
//		fpga_to_hps_in_write <= 1'b1 ;
//		FPGA_to_HPS_state <= 8'd4 ;
//hex3_hex0[7:4] <= 4'd4;
			fpga_to_hps_in_writedata <= hps_to_fpga_readdata;	
			fpga_to_hps_in_write <= 1'b1 ;
			FPGA_to_HPS_state <= 8'd4 ;

	end
	
	// finish the write to FPGA_to_HPS FIFO
	if ((FPGA_to_HPS_state == 4) && (fpga_to_hps_in_write == 1'b1)) begin
		fpga_to_hps_in_write <= 1'b0 ;
		data_buffer_valid <= 1'b0 ; // used the data, so clear flag
		FPGA_to_HPS_state <= 8'd8 ;
	end
	
	// another delay state to see if we need some write time too
	if ((FPGA_to_HPS_state == 8) && (data_buffer_valid == 1'b0))begin
		data_buffer_valid <= 1'b0 ; // used the data, so clear flag
			FPGA_to_HPS_state <= 8'd0 ;
	end

	
	
	//==================================
end // always @(posedge state_clock)


//=======================================================
//  Structural coding
//=======================================================
// From Qsys


//Fake_Controller fake_controller(
//	.reset(~initEnable),
//	.clk(CLOCK_50),
//	.controller_ready(c2ci_controller_ready),
//	.set_ready(~KEY[0]), 
//	.controller_interface_out_ready(controller_interface_out_ready),
//	.cmd(ci2c_controller_state_reg),
//	.x_value(ci2c_x_value),
//	.y_value(ci2c_y_value),
//	.cmd_word_1(LEDR[3:0]),
//	.cmd_word_2(LEDR[7:4]),
//	.x_value_word_1(hex[11:8]),
//	.x_value_word_2(hex[15:12]),
//	.y_value_word_1(hex[19:16]),
//	.y_value_word_2(hex[23:20])
//);


Controller_Interface controller_interface (
	.clk(CLOCK_50),
	.block(~initEnable),
	.cmd(commandIn.cmd),
	.x_value_in(commandIn.x_value),
	.y_value_in(commandIn.y_value),
	.memory_ready(memory_ready),
	.controller_ready(c2ci_controller_ready),
	.controller_interface_in_ready(controller_interface_in_ready),
	.controller_interface_out_ready(controller_interface_out_ready),
	.controller_state_reg(ci2c_controller_state_reg),
	.x_value(ci2c_x_value),
	.y_value(ci2c_y_value)


);

//TODO: this sucks. Make this an interface or something.
wire [7:0] c2sm1_steps1;
wire c2sm1_dir1;
wire c2sm1_endEffectorState;
wire c2smALL_dataReady;

wire sm12c2_stepperReady;
wire sm22c2_stepperReady;
wire steppersReady;

assign steppersReady = sm12c2_stepperReady & sm22c2_stepperReady;

wire [7:0] c2sm2_steps2;
wire c2sm2_dir2;

ScaraController controller (
	.controlStateReg(ci2c_controller_state_reg),
	.xTarget(ci2c_x_value),
	.yTarget(ci2c_y_value),
	.stepperReady(steppersReady),	//TODO: Connect
	.enable(controller_interface_out_ready),
	.clk(CLOCK_50),
	.reset(~initEnable),
	.steps1(c2sm1_steps1), //TODO: Connect
	.steps2(c2sm2_steps2), //TODO: Connect
	.dir1(c2sm1_dir1), //TODO: Connect
	.dir2(c2sm2_dir2), //TODO: Connect
	.endEffectorState(), //TODO: Connect
	.dataReady(c2smALL_dataReady), //TODO: Connect
	.readyForNewData(c2ci_controller_ready)
);


stepper_motor joint1(
	.clk_50(CLOCK_50),
	.reset_n(~initEnable),
	.new_in(c2smALL_dataReady),
	.num_steps(c2sm2_steps2),
	.fast(0),
	.direction(c2sm2_dir2),
	.enable(1),
	.step(GPIO_0[7]), //STEP1
	.dir(GPIO_0[9]), //DIR1
	.finished(sm12c2_stepperReady),
	.steps_out(hex[7:0])
);
stepper_motor joint2(
	.clk_50(CLOCK_50),
	.reset_n(~initEnable),
	.new_in(c2smALL_dataReady),
	.num_steps(c2sm2_steps2),
	.fast(0),
	.direction(c2sm2_dir2),
	.enable(1),
	.step(GPIO_0[13]), //STEP2
	.dir(GPIO_0[15]), //DIR2
	.finished(sm22c2_stepperReady),
	.steps_out(hex[15:8])
);
assign GPIO_0[5] = 0; // EN_N_1
assign GPIO_0[11] = 0; //EN_N_2



Computer_System The_System (
	////////////////////////////////////
	// FPGA Side
	////////////////////////////////////

	// Global signals
	.system_pll_ref_clk_clk					(CLOCK_50),
	.system_pll_ref_reset_reset			(1'b0),
	
	// SRAM shared block with HPS
	.onchip_sram_s1_address               (sram_address),               
	.onchip_sram_s1_clken                 (sram_clken),                 
	.onchip_sram_s1_chipselect            (sram_chipselect),            
	.onchip_sram_s1_write                 (sram_write),                 
	.onchip_sram_s1_readdata              (sram_readdata),              
	.onchip_sram_s1_writedata             (sram_writedata),             
	.onchip_sram_s1_byteenable            (4'b1111), 

	// 50 MHz clock bridge
	.clock_bridge_0_in_clk_clk            (CLOCK_50), //(CLOCK_50), 
	
	// HPS to FPGA FIFO
	.fifo_hps_to_fpga_out_readdata      (hps_to_fpga_readdata),      //  fifo_hps_to_fpga_out.readdata
	.fifo_hps_to_fpga_out_read          (hps_to_fpga_read),          //   out.read
	.fifo_hps_to_fpga_out_waitrequest   (),                            //   out.waitrequest
	.fifo_hps_to_fpga_out_csr_address   (32'd1), //(hps_to_fpga_out_csr_address),   // fifo_hps_to_fpga_out_csr.address
	.fifo_hps_to_fpga_out_csr_read      (1'b1), //(hps_to_fpga_out_csr_read),      //   csr.read
	.fifo_hps_to_fpga_out_csr_writedata (),                              //   csr.writedata
	.fifo_hps_to_fpga_out_csr_write     (1'b0),                           //   csr.write
	.fifo_hps_to_fpga_out_csr_readdata  (hps_to_fpga_out_csr_readdata),		//   csr.readdata
	
	// FPGA to HPS FIFO
	.fifo_fpga_to_hps_in_writedata      (fpga_to_hps_in_writedata),      // fifo_fpga_to_hps_in.writedata
	.fifo_fpga_to_hps_in_write          (fpga_to_hps_in_write),          //                     .write
	.fifo_fpga_to_hps_in_csr_address    (32'd1), //(fpga_to_hps_in_csr_address),    //  fifo_fpga_to_hps_in_csr.address
	.fifo_fpga_to_hps_in_csr_read       (1'b1), //(fpga_to_hps_in_csr_read),       //                         .read
	.fifo_fpga_to_hps_in_csr_writedata  (),  //                         .writedata
	.fifo_fpga_to_hps_in_csr_write      (1'b0),      //                         .write
	.fifo_fpga_to_hps_in_csr_readdata   (fpga_to_hps_in_csr_readdata),    //                         .readdata
	
	////////////////////////////////////
	// HPS Side
	////////////////////////////////////
	// DDR3 SDRAM
	.memory_mem_a			(HPS_DDR3_ADDR),
	.memory_mem_ba			(HPS_DDR3_BA),
	.memory_mem_ck			(HPS_DDR3_CK_P),
	.memory_mem_ck_n		(HPS_DDR3_CK_N),
	.memory_mem_cke		(HPS_DDR3_CKE),
	.memory_mem_cs_n		(HPS_DDR3_CS_N),
	.memory_mem_ras_n		(HPS_DDR3_RAS_N),
	.memory_mem_cas_n		(HPS_DDR3_CAS_N),
	.memory_mem_we_n		(HPS_DDR3_WE_N),
	.memory_mem_reset_n	(HPS_DDR3_RESET_N),
	.memory_mem_dq			(HPS_DDR3_DQ),
	.memory_mem_dqs		(HPS_DDR3_DQS_P),
	.memory_mem_dqs_n		(HPS_DDR3_DQS_N),
	.memory_mem_odt		(HPS_DDR3_ODT),
	.memory_mem_dm			(HPS_DDR3_DM),
	.memory_oct_rzqin		(HPS_DDR3_RZQ),
		  
	// Ethernet
	.hps_io_hps_io_gpio_inst_GPIO35	(HPS_ENET_INT_N),
	.hps_io_hps_io_emac1_inst_TX_CLK	(HPS_ENET_GTX_CLK),
	.hps_io_hps_io_emac1_inst_TXD0	(HPS_ENET_TX_DATA[0]),
	.hps_io_hps_io_emac1_inst_TXD1	(HPS_ENET_TX_DATA[1]),
	.hps_io_hps_io_emac1_inst_TXD2	(HPS_ENET_TX_DATA[2]),
	.hps_io_hps_io_emac1_inst_TXD3	(HPS_ENET_TX_DATA[3]),
	.hps_io_hps_io_emac1_inst_RXD0	(HPS_ENET_RX_DATA[0]),
	.hps_io_hps_io_emac1_inst_MDIO	(HPS_ENET_MDIO),
	.hps_io_hps_io_emac1_inst_MDC		(HPS_ENET_MDC),
	.hps_io_hps_io_emac1_inst_RX_CTL	(HPS_ENET_RX_DV),
	.hps_io_hps_io_emac1_inst_TX_CTL	(HPS_ENET_TX_EN),
	.hps_io_hps_io_emac1_inst_RX_CLK	(HPS_ENET_RX_CLK),
	.hps_io_hps_io_emac1_inst_RXD1	(HPS_ENET_RX_DATA[1]),
	.hps_io_hps_io_emac1_inst_RXD2	(HPS_ENET_RX_DATA[2]),
	.hps_io_hps_io_emac1_inst_RXD3	(HPS_ENET_RX_DATA[3]),

	// Flash
	.hps_io_hps_io_qspi_inst_IO0	(HPS_FLASH_DATA[0]),
	.hps_io_hps_io_qspi_inst_IO1	(HPS_FLASH_DATA[1]),
	.hps_io_hps_io_qspi_inst_IO2	(HPS_FLASH_DATA[2]),
	.hps_io_hps_io_qspi_inst_IO3	(HPS_FLASH_DATA[3]),
	.hps_io_hps_io_qspi_inst_SS0	(HPS_FLASH_NCSO),
	.hps_io_hps_io_qspi_inst_CLK	(HPS_FLASH_DCLK),

	// Accelerometer
	.hps_io_hps_io_gpio_inst_GPIO61	(HPS_GSENSOR_INT),

	//.adc_sclk                        (ADC_SCLK),
	//.adc_cs_n                        (ADC_CS_N),
	//.adc_dout                        (ADC_DOUT),
	//.adc_din                         (ADC_DIN),

	// General Purpose I/O
	.hps_io_hps_io_gpio_inst_GPIO40	(HPS_GPIO[0]),
	.hps_io_hps_io_gpio_inst_GPIO41	(HPS_GPIO[1]),

	// I2C
	.hps_io_hps_io_gpio_inst_GPIO48	(HPS_I2C_CONTROL),
	.hps_io_hps_io_i2c0_inst_SDA		(HPS_I2C1_SDAT),
	.hps_io_hps_io_i2c0_inst_SCL		(HPS_I2C1_SCLK),
	.hps_io_hps_io_i2c1_inst_SDA		(HPS_I2C2_SDAT),
	.hps_io_hps_io_i2c1_inst_SCL		(HPS_I2C2_SCLK),

	// Pushbutton
	.hps_io_hps_io_gpio_inst_GPIO54	(HPS_KEY),

	// LED
	.hps_io_hps_io_gpio_inst_GPIO53	(HPS_LED),

	// SD Card
	.hps_io_hps_io_sdio_inst_CMD	(HPS_SD_CMD),
	.hps_io_hps_io_sdio_inst_D0	(HPS_SD_DATA[0]),
	.hps_io_hps_io_sdio_inst_D1	(HPS_SD_DATA[1]),
	.hps_io_hps_io_sdio_inst_CLK	(HPS_SD_CLK),
	.hps_io_hps_io_sdio_inst_D2	(HPS_SD_DATA[2]),
	.hps_io_hps_io_sdio_inst_D3	(HPS_SD_DATA[3]),

	// SPI
	.hps_io_hps_io_spim1_inst_CLK		(HPS_SPIM_CLK),
	.hps_io_hps_io_spim1_inst_MOSI	(HPS_SPIM_MOSI),
	.hps_io_hps_io_spim1_inst_MISO	(HPS_SPIM_MISO),
	.hps_io_hps_io_spim1_inst_SS0		(HPS_SPIM_SS),

	// UART
	.hps_io_hps_io_uart0_inst_RX	(HPS_UART_RX),
	.hps_io_hps_io_uart0_inst_TX	(HPS_UART_TX),

	// USB
	.hps_io_hps_io_gpio_inst_GPIO09	(HPS_CONV_USB_N),
	.hps_io_hps_io_usb1_inst_D0		(HPS_USB_DATA[0]),
	.hps_io_hps_io_usb1_inst_D1		(HPS_USB_DATA[1]),
	.hps_io_hps_io_usb1_inst_D2		(HPS_USB_DATA[2]),
	.hps_io_hps_io_usb1_inst_D3		(HPS_USB_DATA[3]),
	.hps_io_hps_io_usb1_inst_D4		(HPS_USB_DATA[4]),
	.hps_io_hps_io_usb1_inst_D5		(HPS_USB_DATA[5]),
	.hps_io_hps_io_usb1_inst_D6		(HPS_USB_DATA[6]),
	.hps_io_hps_io_usb1_inst_D7		(HPS_USB_DATA[7]),
	.hps_io_hps_io_usb1_inst_CLK		(HPS_USB_CLKOUT),
	.hps_io_hps_io_usb1_inst_STP		(HPS_USB_STP),
	.hps_io_hps_io_usb1_inst_DIR		(HPS_USB_DIR),
	.hps_io_hps_io_usb1_inst_NXT		(HPS_USB_NXT) //,
	
);


endmodule // end top level





/// end /////////////////////////////////////////////////////////////////////