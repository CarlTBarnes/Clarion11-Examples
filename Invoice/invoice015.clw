

   MEMBER('invoice.clw')                                   ! This is a MEMBER module


   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('INVOICE015.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('INVOICE014.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! Edit InvoiceDetail. Does not use regular OkButton
!!! </summary>
UpdateInvoiceDetail PROCEDURE 

ProductState         USHORT                                ! 
Window               WINDOW('Form InvoiceDetail'),AT(,,309,183),FONT('Segoe UI',10,COLOR:Black,FONT:regular,CHARSET:DEFAULT), |
  AUTO,CENTER,IMM,MDI,SYSTEM
                       PROMPT('Product Code:'),AT(7,8),USE(?Pro:ProductCode:Prompt)
                       BUTTON,AT(68,8,10,10),USE(?BUTTON:SelectProduct),ICON('Lookup.ico'),FLAT
                       ENTRY(@s100),AT(82,8,65,10),USE(Pro:ProductCode),MSG('User defined Product Number'),REQ
                       ENTRY(@s100),AT(152,8,152,10),USE(Pro:ProductName),READONLY,SKIP,TRN
                       PROMPT('Quantity:'),AT(7,22),USE(?InvDet:Quantity:Prompt),TRN
                       SPIN(@n-14),AT(153,22,79,10),USE(InvDet:Quantity),RIGHT,RANGE(1,99999)
                       PROMPT('Price:'),AT(7,36),USE(?InvDet:Price:Prompt),TRN
                       ENTRY(@n-15.2),AT(153,36,79,10),USE(InvDet:Price),RIGHT,MSG('Enter Product''s Price')
                       PROMPT('Discount:'),AT(7,49),USE(?InvDet:DiscountRate:Prompt),TRN
                       ENTRY(@n9.4~%~B),AT(69,49,79,10),USE(InvDet:DiscountRate),RIGHT,MSG('Enter discount rate')
                       ENTRY(@n-15.2),AT(153,49,79,10),USE(InvDet:Discount),RIGHT,MSG('Enter Product''s Price'),READONLY, |
  SKIP,TRN
                       PROMPT('Subtotal:'),AT(7,63),USE(?InvDet:Subtotal:Prompt),TRN
                       ENTRY(@n-15.2),AT(153,63,79,10),USE(InvDet:Subtotal),RIGHT,READONLY,SKIP,TRN
                       PROMPT('Tax:'),AT(7,76),USE(?InvDet:TaxRate:Prompt),TRN
                       ENTRY(@n9.4~%~B),AT(70,77,79,10),USE(InvDet:TaxRate),RIGHT,MSG('Enter Consumer''s Tax rate')
                       ENTRY(@n-15.2),AT(153,77,79,10),USE(InvDet:TaxPaid),RIGHT,MSG('Enter Product''s Price'),READONLY, |
  SKIP,TRN
                       PROMPT('Total:'),AT(7,91),USE(?InvDet:Total:Prompt),TRN
                       ENTRY(@n-15.2),AT(153,91,79,10),USE(InvDet:Total),RIGHT,READONLY,SKIP,TRN
                       PROMPT('Note:'),AT(7,104),USE(?InvDet:Note:Prompt),TRN
                       TEXT,AT(70,104,235,56),USE(InvDet:Note),VSCROLL,BOXED
                       BUTTON('&OK'),AT(201,164,50,14),USE(?OK),DEFAULT,REQ
                       BUTTON('&Cancel'),AT(254,164,50,14),USE(?Cancel)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
PrimeFields            PROCEDURE(),PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END

CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
? DEBUGHOOK(InvoiceDetail:Record)
? DEBUGHOOK(Product:Record)
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

CalculateTotals               ROUTINE
  InvDet:Discount = InvDet:DiscountRate * InvDet:Price / 100
  InvDet:Subtotal = InvDet:Quantity     * (InvDet:Price - InvDet:Discount)
  InvDet:TaxPaid  = InvDet:TaxRate      * InvDet:Subtotal / 100
  InvDet:Total    = InvDet:Subtotal + InvDet:TaxPaid

AfterLookup                   ROUTINE
  InvDet:Price = Pro:Price
  DO CalculateTotals
  
!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('UpdateInvoiceDetail')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Pro:ProductCode:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:InvoiceDetail.SetOpenRelated()
  Relate:InvoiceDetail.Open()                              ! File InvoiceDetail used by this procedure, so make sure it's RelationManager is open
  Access:Product.UseFile()                                 ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  Access:InvoiceDetail.UseFile(UseType:Returns)
  Access:Product.UseFile(UseType:Returns)
  
  IF SELF.Request = InsertRecord
    SELF.PrimeFields()
  END
  SELF.Open(Window)                                        ! Open window
  !Setting the LineHeight for every control of type LIST/DROP or COMBO in the window using the global setting.
  Do DefineListboxStyle
  IF SELF.Request = ViewRecord                             ! Configure controls for View Only mode
    DISABLE(?BUTTON:SelectProduct)
    ?Pro:ProductCode{PROP:ReadOnly} = True
    ?Pro:ProductName{PROP:ReadOnly} = True
    ?InvDet:Price{PROP:ReadOnly} = True
    ?InvDet:DiscountRate{PROP:ReadOnly} = True
    ?InvDet:Discount{PROP:ReadOnly} = True
    ?InvDet:TaxRate{PROP:ReadOnly} = True
    ?InvDet:TaxPaid{PROP:ReadOnly} = True
    ?InvDet:Total{PROP:ReadOnly} = True
    DISABLE(?OK)
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('UpdateInvoiceDetail',Window)               ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:InvoiceDetail.Close()
  END
  IF SELF.Opened
    INIMgr.Update('UpdateInvoiceDetail',Window)            ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.PrimeFields PROCEDURE

  CODE
  PARENT.PrimeFields
  InvDet:Quantity = 1
  InvDet:TaxRate  = Cfg:TaxRate


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  DO CalculateTotals
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?BUTTON:SelectProduct
      ThisWindow.Update()
        ProductState = Access:Product.SaveFile()           ! Source before Lookup
        GlobalRequest = SelectRecord                       ! Set Action for Lookup
        SelectProduct                                      ! Call the Lookup Procedure
        IF GlobalResponse = RequestCompleted               ! IF Lookup completed
          InvDet:ProductGuid = Pro:Guid; DO AfterLookup; Access:Product.RestoreFile(ProductState, False) ! Source on Completion
        ELSE                                               ! ELSE (IF Lookup NOT...)
          Access:Product.RestoreFile(ProductState)         ! Source on Cancellation
        END                                                ! END (IF Lookup completed)
        GlobalResponse = RequestCancelled                  ! Clear Result
    OF ?Pro:ProductCode
      IF Access:Product.TryFetch(Pro:ProductCodeKey) = Level:Benign
        DO AfterLookup
      ELSE
        CLEAR(Pro:ProductName)
      END
    OF ?OK
      ThisWindow.Update()
      SELF.Response = RequestCompleted
      POST(EVENT:CloseWindow)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

