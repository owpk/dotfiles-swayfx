#!/usr/bin/python3

import sys, subprocess, re

f1 = 0.00000000093132257    # 1/(1024*1024*1024) Converts bytes to GB

# Get the pagesize since it varies between x86 and apple silicon
pagesize = int(subprocess.Popen(['pagesize'], stdout=subprocess.PIPE).communicate()[0].decode())

# Get memory info from VM_STAT andprocess into a dictionary
vm = subprocess.Popen(['vm_stat'], stdout=subprocess.PIPE).communicate()[0]
# Process vm_stat
vmLines = vm.decode().split('\n')
sep = re.compile(':[\s]+')
vmStats = {}
for row in range(1,len(vmLines)-2):
    rowElements = sep.split(vmLines[row].strip())
    vmStats[(rowElements[0])] = int(rowElements[1].strip('\.')) * pagesize

# 2 quantities from sysctl
sy = subprocess.Popen(['sysctl','vm.page_pageable_internal_count'], stdout=subprocess.PIPE).communicate()[0]
p1 = sy.decode().find(':')
page_pageable_internal_count = float(sy[p1+1:50]) * pagesize
sy = subprocess.Popen(['sysctl','vm.swapusage'], stdout=subprocess.PIPE).communicate()[0]
p1 = sy.decode().find('used')
p2 = sy.decode().find('M',p1)
swapUsed = float(sy[p1+7:p2])   # MBytes

# Pressure - just get the pressure value
sy = subprocess.Popen(['memory_pressure'], stdout=subprocess.PIPE).communicate()[0]
p1 = sy.decode().find('tage:')
p2 = sy.decode().find('%')
mp = 100 - int(sy[p1+6:p2])

# There are 2 tricks to get Activity Monitor's App Memory (which is best?)
#appMemory = page_pageable_internal_count - vmStats["Pages purgeable"] 
appMemory = vmStats["Anonymous pages"] - vmStats["Pages purgeable"] 

print('Traditional memory:')
print ('Wired Memory:\t\t%9.3f GB' % ( vmStats["Pages wired down"] * f1 ))
print ('Active Memory:\t\t%9.3f GB' % ( vmStats["Pages active"] * f1 ))
print ('Inactive Memory:\t%9.3f GB' % ( vmStats["Pages inactive"] * f1 ))
print ('Speculative:\t\t%9.3f GB' % ( vmStats["Pages speculative"] * f1 ))
print ('Throttled:\t\t%9.3f GB' % ( vmStats["Pages throttled"] * f1 ))
print ('Free Memory:\t\t%9.3f GB' % ( vmStats["Pages free"] * f1 ))
print ('Compressed:\t\t%9.3f GB' % ( vmStats["Pages occupied by compressor"] * f1 ))
# These add up close to phyical RAM
print ('Total:\t\t\t%9.3f GB' % ( (vmStats["Pages free"] + vmStats["Pages wired down"] + vmStats["Pages active"] + vmStats["Pages inactive"] + vmStats["Pages speculative"] + vmStats["Pages throttled"] + vmStats["Pages occupied by compressor"]) * f1 ))
print ('')
print ('Activity Monitor memory')
print ('App Memory:\t\t%9.3f GB' % ( appMemory * f1 ))
print ('Wired Memory:\t\t%9.3f GB' % ( vmStats["Pages wired down"] * f1 ))
print ('Compressed:\t\t%9.3f GB' % ( vmStats["Pages occupied by compressor"] * f1 ))
print ('Memory Used:\t\t%9.3f GB' % ( (appMemory + vmStats["Pages wired down"] + vmStats["Pages occupied by compressor"] ) * f1 ))
print ('Cached Files:\t\t%9.3f GB' % ( (vmStats["File-backed pages"] + vmStats["Pages purgeable"]) * f1 ))
# and these add up to physical rAM
print ('Total:\t\t\t%9.3f GB' % ( (appMemory + vmStats["Pages wired down"] + vmStats["Pages occupied by compressor"] + vmStats["File-backed pages"] + vmStats["Pages purgeable"] + vmStats["Pages free"]) * f1))
print ('')
print ('Swap Used:\t\t%9.3f GB  %9.3f MB' % ( swapUsed * 0.0009765625, swapUsed ))
print ('Memory Pressure:\t%7.1f   GB %6.0f percent' % ( (appMemory + vmStats["Pages wired down"] + vmStats["Pages occupied by compressor"] + vmStats["File-backed pages"] + vmStats["Pages purgeable"] + vmStats["Pages free"]) * f1 * mp / 100, mp) )
    
sys.exit(0);
