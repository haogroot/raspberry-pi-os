#include "mm.h"

.section ".text.boot"

.globl _start
_start:
	mrs	x0, mpidr_el1		
	and	x0, x0, #0xFF		// Check processor id
	cbz x0, init_bss
	b  init_stack_pointer 

init_bss:
	adr	x0, bss_begin
	adr	x1, bss_end
	sub	x1, x1, x0
	bl 	memzero

/* Each core shall has sp = (LOW_MEMORY + (core_num * SECTION_SIZE)) */
init_stack_pointer:
	mrs	x0, mpidr_el1
	and	x0, x0, #0xFF		// Check processor id
	mov x1, x0
	mov x2, #SECTION_SIZE
	mul x1, x1, x2
	add x1, x1, #LOW_MEMORY
	mov	sp, x1
	bl	kernel_main