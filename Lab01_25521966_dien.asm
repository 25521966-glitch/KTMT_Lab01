# $s0 : Số kWh nhập vào / Số kWh còn lại chưa tính tiền
# $s1 : Tổng tiền điện cộng dồn (đồng)
# $s2 : Con trỏ trỏ tới mảng dung lượng tối đa của các bậc (max)
# $s3 : Con trỏ trỏ tới mảng đơn giá tương ứng của các bậc (price)
# $s4 : Biến đếm số lượng bậc còn lại (khởi tạo = 6)
# $t0 : Dung lượng tối đa của bậc hiện tại đang xét (nạp từ mảng max)
# $t1 : Đơn giá của bậc hiện tại đang xét (nạp từ mảng price)
# $t2 : Số kWh thực tế sẽ tính tiền ở bậc hiện tại
# $t3 : Tiền điện tính riêng cho bậc hiện tại ($t2 * $t1)
# $at : Thanh ghi tạm lưu kết quả kiểm tra miền nhập [0, 9999]	
	
	.data
msg_in: .asciiz "Nhap so kWh: "
msg_err: .asciiz "Gia tri khong hop le, nhap lai di\n"
msg_out1: .asciiz "Tien dien: "
msg_out2: .asciiz " dong\n"
max: 	.word 50, 50, 100, 100, 100, 9999	
price:   .word 1720, 1780, 2070, 2620, 2970, 3120

   	.text
main:
input_loop:
	la $a0, msg_in
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0
	
	slti $at, $s0, 10000
	bne $at, $zero, calc
	
	la $a0, msg_err
	li $v0, 4
	syscall
	j input_loop
calc:
	li $s1, 0
	la $s2, max
	la $s3, price
	li $s4, 6
loop_bac:
	beq $s4, $zero, end_calc
	beq $s0, $zero, end_calc
	lw $t0, 0($s2)
	lw $t1, 0($s3)
	bgt $s0, $t0, use_full
use:
	move $t2, $s0
	j calc_money
use_full:
	move $t2, $t0
calc_money:
	mul $t3, $t2, $t1
	add $s1, $s1, $t3
	sub $s0, $s0, $t2
	addi $s2, $s2, 4
	addi $s3, $s3, 4
	addi $s4, $s4, -1
	j loop_bac
end_calc:
	la $a0, msg_out1
	li $v0, 4
	syscall
	move $a0, $s1
	li $v0, 1
	syscall
	la $a0, msg_out2
	li $v0, 4
	syscall
	li $v0, 10
	syscall

	
	  