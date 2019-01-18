.data
    v: .word 8, 12, 1, 2, 3, 14, 10, 16, 4, 5, 13, 9, 7, 11, 15, 6
.text
main:
    addi $sp, $sp, -20
    sw $s0, 0($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $s3, 12($sp)
    sw $ra, 16($sp)
    la $a0, v
    li $a1, 16
    move $s0, $a0 # $s0 = Array Address
    li $s1, 0 # $s1 = i
    move $s2, $a1 # $s2 = n
sort_outer:
    bge $s1, $s2, exit
    addi $s3, $s1, -1 # $s3 = j
    jal sort_inner
    addi $s1, $s1, 1
    j sort_outer
sort_inner:
    blt $s3, $zero, go_back_outer
    sll $t0, $s3, 2
    add $t1, $t0, $s0
    lw $t2, 0($t1)
    lw $t3, 4($t1)
    ble $t2, $t3, go_back_outer
    la $a0, v
    move $a1, $s3
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal swap
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    addi $s3, $s3, -1
    j sort_inner
go_back_outer:
    jr $ra
swap:   
    sll $t1, $a1, 2
    add $t1, $a0, $t1
    lw $t0, 0($t1)
    lw $t2, 4($t1)
    sw $t2, 0($t1)
    sw $t0, 4($t1)
    jr $ra
exit:
    lw $ra, 16($sp)
    lw $s3, 12($sp)
    lw $s2, 8($sp)
    lw $s1, 4($sp)
    lw $s0, 0($sp)
    addi $sp, $sp, 20
    li $v0, 10
    syscall