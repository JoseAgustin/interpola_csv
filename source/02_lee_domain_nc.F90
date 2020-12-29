!
! lee_domain_nc.F90
!
!>
!>  Created by Agustin on 29/12/20.
!>
subroutine lee_domain_nc
use netcdf
integer :: iexist
integer :: ncid
character (len =12) :: FILE_NAME !New domain
  write (6,*) " *** Reading Domain coordinates  ***"
  FILE_NAME="wrfinput_d01"
  if(nf90_open(FILE_NAME, nf90_nowrite, ncid).eq.0) then
  write (6,*)" *** Reading Lat Lon in file:",FILE_NAME
  else
    write (6,*)"No file ",FILE_NAME
    FILE_NAME="geo_em.d01"
    write(6,*) "Trying ", FILE_NAME
    if(nf90_open(FILE_NAME, nf90_nowrite, ncid).eq.0) then
    write(6,*)" *** Reading Lat Lon in file:",FILE_NAME
    else
      call check(nf90_open(FILE_NAME, nf90_nowrite, ncid))
    end if
  end if


end subroutine
