class ZCL_IM_E_ACC_DOCUMENT definition
  public
  final
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_EX_ACC_DOCUMENT .
protected section.
private section.
ENDCLASS.



CLASS ZCL_IM_E_ACC_DOCUMENT IMPLEMENTATION.


  method if_ex_acc_document~change.
    data: ls_extension   type bapiparex,
          ext_value(960) type c,
          ls_accit       type accit,
          l_ref          type ref to data.

    field-symbols: <l_struc> type any,
                   <l_field> type any.

    sort c_extension2 by structure.

    if sy-uname = 'XIAOPENG.WEI'.
      BREAK-POINT.
    ENDIF.

    loop at c_extension2 into ls_extension.
      at new structure.
        create data l_ref type (ls_extension-structure).
        assign l_ref->* to <l_struc>.
      endat.
      concatenate ls_extension-valuepart1 ls_extension-valuepart2
                  ls_extension-valuepart3 ls_extension-valuepart4
             into ext_value.
      move ext_value to <l_struc>.
      assign component 'POSNR' of structure <l_struc> to <l_field>.
      read table c_accit with key posnr = <l_field>
            into ls_accit.
      if sy-subrc is initial.
        move-corresponding <l_struc> to ls_accit.
        modify c_accit from ls_accit index sy-tabix.
      endif.
    endloop.

  endmethod.


  method IF_EX_ACC_DOCUMENT~FILL_ACCIT.
  endmethod.
ENDCLASS.
