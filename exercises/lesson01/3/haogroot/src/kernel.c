#include "mini_uart.h"

static unsigned int semaphore = 0;

void kernel_main(unsigned int processorId)
{
	while(processorId != semaphore) {}
	if(semaphore == 0)
	{
		uart_init();
	}

	uart_send_string("Hello, world! This is processor ");
	uart_send((char) (processorId + '0'));
	uart_send_string("\r\n");
	semaphore++;

	if(processorId == 0)
	{
		while (1) 
		{
			uart_send(uart_recv());
		}
	}
	else
	{
		while(1) {}
	}
}
