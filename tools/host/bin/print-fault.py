#!/usr/bin/env python

#
#    Copyright (c) 2013-2018 Nest Labs, Inc.
#    All rights reserved.
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.


import sys

SCB_HFSR_VECTTBL_Msk = 0x1 << 1
SCB_HFSR_FORCED_Msk = 0x1 << 30
SCB_CFSR_IACCVIOL = (0x00000001)
SCB_CFSR_DACCVIOL = (0x00000002)
SCB_CFSR_MUNSTKERR = (0x00000008)
SCB_CFSR_MSTKERR = (0x00000010)
SCB_CFSR_MMARVALID = (0x00000080)
SCB_CFSR_IBUSERR = (0x00000100)
SCB_CFSR_PRECISERR = (0x00000200)
SCB_CFSR_IMPRECISERR = (0x00000400)
SCB_CFSR_UNSTKERR = (0x00000800)
SCB_CFSR_STKERR = (0x00001000)
SCB_CFSR_BFARVALID = (0x00008000)
SCB_CFSR_UNDEFINSTR = (0x00010000)
SCB_CFSR_INVSTATE = (0x00020000)
SCB_CFSR_INVPC = (0x00040000)
SCB_CFSR_NOCP = (0x00080000)
SCB_CFSR_UNALIGNED = (0x01000000)
SCB_CFSR_DIVBYZERO = (0x02000000)

stringArray = sys.stdin.readline().rstrip().split(" ")
stringArray = stringArray[1:]
if len(stringArray) != 4:
    print "Invalid input"
else:
    HFSR = int(stringArray[0], 16)
    CFSR = int (stringArray[1], 16)
    MMFAR = int(stringArray[2], 16)
    BFAR = int(stringArray[3], 16)
    print("-----------------") 

    if ((HFSR & SCB_HFSR_VECTTBL_Msk) != 0):
       print("Vector Table Hard Fault") 
    elif ((HFSR & SCB_HFSR_FORCED_Msk) != 0):
        print("Other Hard Fault")
        if ((CFSR & SCB_CFSR_MMARVALID    ) != 0):
    		print("Memory Management Fault") 
    		print("mmfar = " + hex(MMFAR)) 
        elif ((CFSR & SCB_CFSR_BFARVALID    ) != 0):
            print("Bus Fault")   
    	    print("bfar = " + hex(BFAR)) 
        elif ((CFSR & SCB_CFSR_IACCVIOL ) != 0):
    		print("Instruction Access Violation Fault") 
        elif ((CFSR & SCB_CFSR_DACCVIOL     ) != 0):
    		print("Data Access Violation Fault") 
    		print("mmfar = " + hex(MMFAR)) 
        elif ((CFSR & SCB_CFSR_MUNSTKERR    ) != 0):
    		print("Memory Unstacking Fault") 
        elif ((CFSR & SCB_CFSR_MSTKERR      ) != 0):
    		print("Memory Stacking Fault") 
        elif ((CFSR & SCB_CFSR_IBUSERR      ) != 0):
    		print("Instruction Bus Fault") 
        elif ((CFSR & SCB_CFSR_PRECISERR    ) != 0):
    		print("Precise Data Bus Error Fault") 
    		print("bfar = " + hex(BFAR)) 
        elif ((CFSR & SCB_CFSR_IMPRECISERR  ) != 0):
    		print("Imprecise Data Bus Error Fault") 
        elif ((CFSR & SCB_CFSR_UNSTKERR     ) != 0):
    		print("Bus Unstacking Fault") 
        elif ((CFSR & SCB_CFSR_STKERR       ) != 0):
    		print("Bus Stacking Fault") 
        elif ((CFSR & SCB_CFSR_UNDEFINSTR   ) != 0):
    		print("Undefined Instruction Usage Fault") 
        elif ((CFSR & SCB_CFSR_INVSTATE     ) != 0):
    		print("Invalid State Fault")
        elif ((CFSR & SCB_CFSR_INVPC        ) != 0):
    		print("Invalid Program Counter Fault") 
        elif ((CFSR & SCB_CFSR_NOCP         ) != 0):
    		print("No Coprocessor Fault") 
        elif ((CFSR & SCB_CFSR_UNALIGNED   ) != 0):
    		print("Unaligned Access Fault") 
        elif ((CFSR & SCB_CFSR_DIVBYZERO    ) != 0):
    		print("Divide By Zero Fault") 
        else:
    		print("Unknown Fault") 
    else:
    	print("Unknown Hard Fault") 
