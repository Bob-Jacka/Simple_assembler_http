section .text
global _start
_start:
	mov rax, sys_socket
	mov rdi, AF_INET
	mov rsi, SOCK_STREAM
	mov rdx, IPPROTO_IP
	syscall
	cmp rax, -4095
	jae .error
	mov r12, rax
	
	mov rax, sys_setsockopt
	mov rdi, r12
	mov rsi, SOL_SOCKET
	mov rdx, SO_REUSEADDR
	mov r10, so_reuseaddr
	mov r8, so_reuseaddr.length
	syscall
	cmp rax, -4095
	jae .error
	
	mov rax, sys_bind
	mov rdi, r12
	mov rsi, sockaddr_in
	mov rdx, sockaddr_in.length
	syscall
	cmp rax, -4095
	jae .error
