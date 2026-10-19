
.data
pitches:    .word 64, 64, 65, 67, 67, 65, 64, 62, 60, 60, 62, 64, 64, 62, 62
durations:  .word 2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  3,  1,  4
num_notes:  .word 15

msg_dukien: .asciiz "Tong du kien (ms): "
msg_do: .asciiz "Thoi gian do duoc (ms): "
space:        .asciiz " "
newline:      .asciiz "\n"

        .text
main:
        li   $v0, 30
        syscall
        move $s6, $a0              
        la   $s0, pitches            
        la   $s1, durations
        lw   $s2, num_notes          
        li   $s3, 0                   
        li   $s4, 0
play_loop:
        beq  $s4, $s2, end_play      
        lw   $t0, 0($s0)
        addi $a0, $t0, 6             
        lw   $t1, 0($s1)
        li   $t2, 210
        mul  $a1, $t1, $t2            
        add  $s3, $s3, $a1
        li   $a2, 40                  
        li   $a3, 100                
        move $s5, $a0
        move $s7, $a1
        move $a0, $s5
        li   $v0, 1
        syscall
        la   $a0, space
        li   $v0, 4
        syscall
        move $a0, $s7
        li   $v0, 1
        syscall
        la   $a0, newline
        li   $v0, 4
        syscall
        move $a0, $s5
        move $a1, $s7
        li   $v0, 33
        syscall
        addi $s0, $s0, 4
        addi $s1, $s1, 4
        addi $s4, $s4, 1
        j    play_loop
end_play:
        li   $v0, 30
        syscall
        sub  $s7, $a0, $s6           
        la   $a0, msg_dukien
        li   $v0, 4
        syscall
        move $a0, $s3
        li   $v0, 1
        syscall
        la   $a0, newline
        li   $v0, 4
        syscall
        la   $a0, msg_do
        li   $v0, 4
        syscall
        move $a0, $s7
        li   $v0, 1
        syscall
        la   $a0, newline
        li   $v0, 4
        syscall
        li   $v0, 10
        syscall