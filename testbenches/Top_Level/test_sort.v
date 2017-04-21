`timescale 1 ns / 1 ps

// for (i = 0; i < SIZE - 2; i++) {
	// high = i;
	// for (j = i+1; j < SIZE - 1; j++) {
		// if (array[j] > array[high]) {
			// high = j;
		// }
	// }
	// temp = array[high]
	// array[high] = array[i]
	// array[i] = temp;
// }

// MAIN: 		LW $2, 0($0)		; Load Size of Array
			// ADDI $3, $0, 1		; Pointer to start of array
			// JL ITR_ARR			; Iterate through unsorted array
			// JL SORT				; Sort array
			// LW $2, 0($0)		    ; Load Size of Array
            // ADDI $3, $0, 1        ; Pointer to start of array
			// JL ITR_ARR			; Iterate through sorted array
			// HALT
// ITR_ARR: 	ADD $4, $3, $0    ; $4 = &array[0]
			// ADD $5, $2, $4    ; $5 = &array[SIZE]
	// NXT: 	BEQ $4, $5, END
			// LW $1, 0($4)	   ; $1 = array[$4]
			// ADDI $4, $4, 1    ; $4++
			// J NXT
	// END:	JR 	$7
// SORT:		SW $7, 31($0) 		; Push LR to "stack"
			// ADD $4, $0, 0 		; $4 = 0
	// LOOP1:	ADD $1, $4, $0 		; $1 = $4
			// ADDI $5, $4, 1 		; $5 = $4 + 1
			// SW 	$4, 30($0)		; Push i to "stack"
	// LOOP2:	ADD $6, $5, $3		; $6 = &array[$5]
			// LW $6, 0($6)		; $6 = array[$5]
			// ADD $7, $1, $3		; $7 = &array[$1]
			// LW $7, 0($7)		; $7 = array[$1]
			// SLT $4, $7, $6		; if (array[$5] > array[$1]){
			// BEQ $4, $0, END2
			// ADD $1, $5, $0		; 	$1 = $5}
	// END2	ADDI $5, $5, 1		; $5++
			// BNE $5, $2, LOOP2	; for($5 < SIZE)
			// LW $4, 30($0)		; Pop i from "stack"
			// ADD $5, $1, $3		; $5 = &array[$1]
			// ADD $6, $4, $3		; $6 = &array[$4]
			// LW 	$1, 0($5)		; $1 = array[$1]
			// LW $7, 0($6)		; $7 = array[$4]
			// SW $1, 0($6)		; array[$4] = array[$1]
			// SW $7, 0($5)		; array[$1] = array[$4]
			// ADDI $4, $4, 1 		; $4++
			// ADDI $6, $2, -1		; $6 = SIZE - 1
			// BNE $4, $6, LOOP1	; for($4 < SIZE - 1)
			// LW $7, 31($0)		; Pop LR from "stack"
			// JR $7

module test_sort;

parameter RegAddrBits = 3;
parameter DataWidth = 16;
parameter TotalReg = 8;
parameter TestFile = "../../testbenches/Test_Programs/test_sort.txt";
parameter DataFile = "../../testbenches/Test_Programs/test_sort_data.txt";

integer j;
reg CLK;
reg RST;
reg [RegAddrBits-1:0] inr;
wire [DataWidth-1:0] out_value;


Pipelined_Processor #(.FileName(TestFile), .DataFileName(DataFile)) p1 (
	.CLK(CLK),
	.RST(RST),
	.inr(inr),
	.out_value(out_value)
);

initial
begin
	#0 CLK = 0;
	#0 inr = 0;
	#0 RST = 1;
	#0 $display ("Time, inr, out_value,");
	#10 RST = 0;
	#7200 $monitor ("%t, %x, %x,", $time, inr, out_value);
	for (j=0; j<TotalReg; j=j+1)
	begin
		inr = j;
		#10;
	end
	#0 $finish;	
end

always
begin
	#5 CLK = !CLK;
end

endmodule

