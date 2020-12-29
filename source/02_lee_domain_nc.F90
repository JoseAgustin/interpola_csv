!
! lee_domain_nc.F90
!
!> @brief Reads coordinates from wrfinput or geo_em.d01 input file
!> @details Readsfrom wrfinput or geo_em.d01 input the
!>  coordinates and stores the new coordinates @c XLAT, @c XLON
!>
!> @author Agustin Garcia
!> @date 29/12/2020
!>   @version  1.0
!>   @copyright Universidad Nacional Autonoma de Mexico.
!
!***************************************************************************
subroutine lee_domain_nc
use vars
use netcdf
integer :: iexist
integer :: ncid
integer :: lat_varid
integer :: lon_varid
integer :: west_east_id
integer :: south_north_id
integer :: nvars
integer :: nglobalatts
integer :: west_east_len
integer :: south_north_len

character (len =12) :: FILE_NAME !New domain
character (len=6)::LAT_NAME
character (len=7)::LON_NAME
character (len= NF90_MAX_NAME ) :: dimname

  write (6,*) " *** Reading Domain coordinates  ***"
  FILE_NAME="wrfinput_d01"
  if(nf90_open(FILE_NAME, nf90_nowrite, ncid).eq.0) then
    write (6,*)" *** Reading Lat Lon in file:",FILE_NAME
    LAT_NAME="XLAT"
    LON_NAME="XLONG"
  else
    write (6,*)"     No file ",FILE_NAME
    FILE_NAME="geo_em.d01"
    write(6,*) " Trying ", FILE_NAME
    if(nf90_open(FILE_NAME, nf90_nowrite, ncid).eq.0) then
    write(6,*)" *** Reading Lat Lon in file:",FILE_NAME
    LAT_NAME="XLAT_M"
    LON_NAME="XLONG_M"
    else
      call check(nf90_open(FILE_NAME, nf90_nowrite, ncid))
    end if
  end if
! Get the vars ID of the latitude and longitude coordinate variables.
    call check( nf90_inq_varid(ncid, LAT_NAME, lat_varid) )
    call check( nf90_inq_varid(ncid, LON_NAME, lon_varid) )
!  Get dims ID and dimension values
    call check(nf90_inq_dimid(ncid,"west_east", west_east_id))
    call check(nf90_inq_dimid(ncid,"south_north", south_north_id))
    !print *,west_east_id,south_north_id,lat_varid,lon_varid
    call check(nf90_inquire_dimension(ncid,west_east_id,name=dimname,len=west_east_len))
    call check(nf90_inquire_dimension(ncid,south_north_id,name=dimname,len=south_north_len))
!print *,west_east_len,south_north_len
    if(.not.ALLOCATED(XLAT)) allocate(XLAT(west_east_len,south_north_len))
    if(.not.ALLOCATED(XLON)) allocate(XLON(west_east_len,south_north_len))

!   Get lat and lon values.
    write(6,*)" * Get lat and lon values"
    call check(nf90_get_var(ncid, lat_varid, XLAT,start = (/ 1, 1,1 /)))
    call check(nf90_get_var(ncid, lon_varid, XLON,start = (/ 1, 1,1 /)))
    !write(6,*)minval(xlat),minval(xlon)
  call check( nf90_close(ncid) )
  print * ,' ** Done reading ',FILE_NAME,' *****'
end subroutine
