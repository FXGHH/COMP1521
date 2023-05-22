# read a mark and print the corresponding UNSW grade

main:
    la   $a0, prompt    # printf("Enter a mark: ");
    li   $v0, 4
    syscall

    li   $v0, 5         # scanf("%d", mark);
    syscall

    blt	$v0, 50, FL
    blt	$v0, 65, PS
    blt	$v0, 75, CR
    blt $v0, 85, DN

    la   $a0, hd        # printf("FL\n");
    li   $v0, 4
    syscall
    b    END
    #blt $v0, 50, FL
    

FL:
    la   $a0, fl        # printf("FL\n");
    li   $v0, 4
    syscall
    b    END

PS:
    la   $a0, ps        # printf("FL\n");
    li   $v0, 4
    syscall
    b    END

CR:
    la   $a0, cr        # printf("FL\n");
    li   $v0, 4
    syscall
    b    END

DN:
    la   $a0, dn        # printf("FL\n");
    li   $v0, 4
    syscall
    b    END


END:
     li   $v0, 0        # return 0
     jr   $ra

    .data
prompt:
    .asciiz "Enter a mark: "
fl:
    .asciiz "FL\n"
ps:
    .asciiz "PS\n"
cr:
    .asciiz "CR\n"
dn:
    .asciiz "DN\n"
hd:
    .asciiz "HD\n"
