mov rax, sys_listen
mov rdi, r12
mov rsi, 10
syscall
cmp rax, -4095
jae .error

mov rax, sys_write
mov rdi, STDOUT_FILENO
mov rsi, listening_msg
mov rdx, listening_msg.length
syscall

.accept_connection:
mov rax, sys_accept
mov rdi, r12
mov rsi, 0
mov rdx, 0
syscall
mov r13, rax

mov rax, sys_write
mov rdi, r13
mov rsi, http_msg
mov rdx, http_msg.length
syscall

mov rax, sys_close
mov rdi, r13
syscall
jmp .accept_connection

.error:
mov rdi, rax
mov rax, sys_exit
syscall
