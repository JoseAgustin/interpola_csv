!
!  01_principal.F90
!
!>
!>  Created by Agustin on 29/12/20.
!>
program interpola_csv
use vars
implicit none
integer:: ia

  call lee_domain_nc

  do ia=1,nfile
    call lee_csv(ia)
   
    call interpola

    call guarda(ia)

  end do

end program

