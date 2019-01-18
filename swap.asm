.data
    v: .word 13, 17, 19, 23, 29 # initialize the array v with elements 13, 17, 19, 23, 29
.text
swap:   
    # the first 2 statements adds the array access offset by 12, which is to array index 3
    sll $t1, $a1, 2 # left shift the value in $a1 by 2 digits and store the result in $t1, which in this case is 3*4=12
    add $t1, $a0, $t1 # add the value in $a0 and $t1 into $t1, which offset the array address access by 12(index 3)
    # these 4 statements essentially swaps the value stored at array index 3 and array index 4
    lw $t0, 0($t1) # load the value of array index 3 (offset 0) at the array address stored at $t1 into $t0
    lw $t2, 4($t1) # load the value of array index 4 (offset 4) at the array address stored at $t1 into $t2
    sw $t2, 0($t1) # store the value in $t2 into array index 3 (offset 0) at the array address stored at $t1
    sw $t0, 4($t1) # store the value in $t0 into array index 4 (offset 4) at the array address stored at $t1
    # exit the program
    li $v0, 10 # load service 10 into $v0, which is to terminate execution
    syscall # execute service
    # all statements combined can be summarized as a process of swapping the 3rd and 4th element in the array v
main:
    la $a0, v # load the address of array v into $a0
    li $a1, 3 # load the number 3 into $a1
    jal swap # jump to swap and put the return address in $ra