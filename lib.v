`define SET_UART_TX \
	always begin \
		#10 ; \
		if(SOC.UART.TX_FLAG)begin \
			$write("%c",SOC.UART.TX_DATA); \
			$fflush(); \
			SOC.UART.TX_FLAG=0; \
		end \
	end
`define SET_UART_RX \
	integer n; \
	reg [100*8-1:0] s; \
	reg [100*8-1:0] ss; \
	always begin \
		#10 ; \
		if(SOC.UART.RX_ENABLE)begin \
			n=$fgets(s,'h8000_0000); \
			ss=s; \
			while(n)begin \
				ss=s; \
				ss=ss>>( (n-1)*8); \
				ss=ss&8'hFF; \
				while(SOC.UART.RX_FLAG)begin \
					#10 ; \
				end \
				SOC.UART.RX_DATA=ss; \
				SOC.UART.RX_FLAG=1; \
				n=n-1; \
			end \
			SOC.UART.RX_ENABLE=0; \
		end \
	end
