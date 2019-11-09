# How to boot all CPU for ARMv8

## Note

### Get Processor Id

We can get the processor ID from the mpidr_el1 system register. If the current processor ID is 0, then execution need to init .bss section.

```asm
    mrs     x0, mpidr_el1
    and     x0, x0, 0xFF
```

### Use semaphore to synchronize

Because We need first processor to init uart first, we use a counter to delay the other processor.

### Question to be further discussed

* Why only the first processor need to initialize .bss section?
The `.bss` section is for unintialized data. All cores will share all of this data to use. Just image that like the global variable in our program.


## Reference

* [[1]](http://infocenter.arm.com/help/topic/com.arm.doc.dai0527a/DAI0527A_baremetal_boot_code_for_ARMv8_A_processors.pdf) Bere-metal Boot Code for ARMv8-A Processors Application Note 527
