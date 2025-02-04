

   MEMBER('invoice.clw')                                   ! This is a MEMBER module


   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('INVOICE017.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('INVOICE015.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('INVOICE016.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! Form Invoice
!!! </summary>
UpdateInvoice PROCEDURE 

                              MAP
TakeCustomerSelected            PROCEDURE
                              END

InvoiceDetailView   VIEW(InvoiceDetail)
                      JOIN(Pro:GuidKey,InvDet:ProductGuid)
                      END
                    END

InvoiceDetailReader           CLASS,TYPE
Error                           STRING(256)
ErrorCode                       LONG
FileError                       STRING(256)
FileErrorCode                   LONG
Process                         PROCEDURE
ClearErrors                     PROCEDURE
SetErrors                       PROCEDURE
TakeRecord                      PROCEDURE,VIRTUAL
                              END

InvoiceDetailCache  CLASS
AssignQueueToRecord   PROCEDURE
AssignRecordToQueue   PROCEDURE
LoadDetail            PROCEDURE
SaveDetail            PROCEDURE
InsertRecord          PROCEDURE
ChangeRecord          PROCEDURE
DeleteRecord          PROCEDURE
CallUpdateForm        PROCEDURE(LONG pRequest),LONG
                    END

LoadDetailReader    CLASS(InvoiceDetailReader)
TakeRecord            PROCEDURE,DERIVED
                    END

SaveDetailReader    CLASS(InvoiceDetailReader)
TakeRecord            PROCEDURE,DERIVED
                    END
DummyColumn          STRING(1)                             ! 
CurrentTab           STRING(80)                            ! 
ActionMessage        CSTRING(40)                           ! 
InvoiceDetailQueue   QUEUE,PRE(InvDetQ)                    ! 
ProductCode          LIKE(Pro:ProductCode)                 ! 
ProductName          LIKE(Pro:ProductName)                 ! 
Quantity             LIKE(InvDet:Quantity)                 ! 
Price                LIKE(InvDet:Price)                    ! 
DiscountRate         LIKE(InvDet:DiscountRate)             ! 
Discount             LIKE(InvDet:Discount)                 ! 
Subtotal             LIKE(InvDet:Subtotal)                 ! 
TaxRate              LIKE(InvDet:TaxRate)                  ! 
TaxPaid              LIKE(InvDet:TaxPaid)                  ! 
Total                LIKE(InvDet:Total)                    ! 
Note                 LIKE(InvDet:Note)                     ! 
GUID                 LIKE(InvDet:GUID)                     ! 
ProductGuid          LIKE(InvDet:ProductGuid)              ! 
LineNumber           LIKE(InvDet:LineNumber)               ! 
                     END                                   ! 
History::Inv:Record  LIKE(Inv:RECORD),THREAD
Window               WINDOW('Invoice'),AT(,,577,277),FONT('Segoe UI',10,COLOR:Black,FONT:regular,CHARSET:DEFAULT), |
  RESIZE,AUTO,CENTER,IMM,MDI,SYSTEM
                       PROMPT('Invoice Number:'),AT(9,3),USE(?Inv:InvoiceNumber:Prompt)
                       ENTRY(@n07),AT(68,3,60,10),USE(Inv:InvoiceNumber),MSG('Invoice number for each order'),READONLY, |
  SKIP,TRN
                       PROMPT('Date:'),AT(9,16),USE(?Inv:Date:Prompt)
                       ENTRY(@d10),AT(68,17,60,10),USE(Inv:Date),REQ
                       PROMPT('&First Name:'),AT(9,30),USE(?Inv:FirstName:Prompt)
                       BUTTON,AT(54,31,10,10),USE(?BUTTON:SelectCustomer),ICON('Lookup.ico'),FLAT
                       ENTRY(@s100),AT(68,31,176,10),USE(Inv:FirstName),MSG('Enter the first name of customer'),REQ
                       PROMPT('&Last Name:'),AT(9,44),USE(?Inv:LastName:Prompt)
                       ENTRY(@s100),AT(68,44,176,10),USE(Inv:LastName),MSG('Enter the last name of customer'),REQ
                       PROMPT('&Street:'),AT(254,2),USE(?Inv:Street:Prompt)
                       TEXT,AT(313,3,257,37),USE(Inv:Street),MSG('Enter the first line address of customer')
                       PROMPT('&City:'),AT(254,42),USE(?Inv:City:Prompt)
                       ENTRY(@s100),AT(313,43,257,10),USE(Inv:City),MSG('Enter  city of customer')
                       PROMPT('&State:'),AT(254,56),USE(?Inv:State:Prompt)
                       ENTRY(@s100),AT(313,56,257,10),USE(Inv:State),MSG('Enter state of customer')
                       PROMPT('&Zip Code:'),AT(254,69),USE(?Inv:PostalCode:Prompt)
                       ENTRY(@s100),AT(313,70,257,10),USE(Inv:PostalCode),MSG('Enter zipcode of customer'),TIP('Enter zipc' & |
  'ode of customer')
                       PROMPT('Mobile Phone:'),AT(254,83),USE(?Inv:Phone:Prompt)
                       ENTRY(@s100),AT(313,84,257,10),USE(Inv:Phone)
                       PROMPT('Customer Order Number:'),AT(254,97,55,16),USE(?Inv:CustomerOrderNumber:Prompt)
                       ENTRY(@s100),AT(313,97,257,10),USE(Inv:CustomerOrderNumber)
                       CHECK('Order Shipped'),AT(175,3),USE(Inv:OrderShipped),MSG('Checked if order is shipped')
                       LIST,AT(10,116,560,123),USE(?InvoiceDetailList),FORMAT('50L(2)|M~Product Code~C(0)@s100' & |
  '@100L(2)|M~Product Name~C(0)@s100@50R(2)|M~Quantity~C(0)@n-14@50R(2)|M~Price~C(0)@n-' & |
  '15.2@50R(2)|M~Discount %~C(0)@n7.4B@50R(2)|M~Discount~C(0)@n-15.2@50R(2)|M~Subtotal~' & |
  'C(0)@n-15.2@50R(2)|M~Tax %~C(0)@n7.4B@50R(2)|M~Tax Paid~C(0)@n-15.2@50R(2)|M~Total~C' & |
  '(0)@n-15.2@4L(2)|M@p p@'),FROM(InvoiceDetailQueue)
                       BUTTON('Insert'),AT(415,242,50,14),USE(?InsertInvoiceDetail),KEY(InsertKey)
                       BUTTON('Change'),AT(469,242,50),USE(?ChangeInvoiceDetail),KEY(EnterKey)
                       BUTTON('Delete'),AT(521,242,50,14),USE(?DeleteInvoiceDetail),KEY(DeleteKey)
                       BUTTON('&OK'),AT(469,259,50,14),USE(?OK),DEFAULT
                       BUTTON('&Cancel'),AT(521,259,50,14),USE(?Cancel)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeCompleted          PROCEDURE(),BYTE,PROC,DERIVED
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
? DEBUGHOOK(Invoice:Record)
? DEBUGHOOK(InvoiceDetail:Record)
? DEBUGHOOK(Product:Record)
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'View Record'
  OF InsertRecord
    ActionMessage = 'Record Will Be Added'
  OF ChangeRecord
    ActionMessage = 'Record Will Be Changed'
  END
  Window{PROP:Text} = ActionMessage                        ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('UpdateInvoice')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Inv:InvoiceNumber:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(Inv:Record,History::Inv:Record)
  SELF.AddHistoryField(?Inv:InvoiceNumber,3)
  SELF.AddHistoryField(?Inv:Date,4)
  SELF.AddHistoryField(?Inv:FirstName,7)
  SELF.AddHistoryField(?Inv:LastName,8)
  SELF.AddHistoryField(?Inv:Street,9)
  SELF.AddHistoryField(?Inv:City,10)
  SELF.AddHistoryField(?Inv:State,11)
  SELF.AddHistoryField(?Inv:PostalCode,12)
  SELF.AddHistoryField(?Inv:Phone,13)
  SELF.AddHistoryField(?Inv:CustomerOrderNumber,5)
  SELF.AddHistoryField(?Inv:OrderShipped,6)
  SELF.AddUpdateFile(Access:Invoice)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Invoice.SetOpenRelated()
  Relate:Invoice.Open()                                    ! File Invoice used by this procedure, so make sure it's RelationManager is open
  Access:Product.UseFile()                                 ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:InvoiceDetail.UseFile()                           ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Invoice
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.CancelAction = Cancel:Cancel+Cancel:Query         ! Confirm cancel
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  If Self.Request <> InsertRecord
    InvoiceDetailCache.LoadDetail()
  End
  SELF.Open(Window)                                        ! Open window
  !Setting the LineHeight for every control of type LIST/DROP or COMBO in the window using the global setting.
  ?InvoiceDetailList{PROP:LineHeight} = 11
  Do DefineListboxStyle
  IF SELF.Request = ViewRecord                             ! Configure controls for View Only mode
    ?Inv:InvoiceNumber{PROP:ReadOnly} = True
    ?Inv:Date{PROP:ReadOnly} = True
    DISABLE(?BUTTON:SelectCustomer)
    ?Inv:FirstName{PROP:ReadOnly} = True
    ?Inv:LastName{PROP:ReadOnly} = True
    ?Inv:City{PROP:ReadOnly} = True
    ?Inv:State{PROP:ReadOnly} = True
    ?Inv:PostalCode{PROP:ReadOnly} = True
    ?Inv:Phone{PROP:ReadOnly} = True
    ?Inv:CustomerOrderNumber{PROP:ReadOnly} = True
    DISABLE(?InsertInvoiceDetail)
    DISABLE(?ChangeInvoiceDetail)
    DISABLE(?DeleteInvoiceDetail)
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('UpdateInvoice',Window)                     ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Invoice.Close()
  END
  IF SELF.Opened
    INIMgr.Update('UpdateInvoice',Window)                  ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?BUTTON:SelectCustomer
      ThisWindow.Update()
        GlobalRequest = SelectRecord                       ! Set Action for Lookup
        SelectCustomer                                     ! Call the Lookup Procedure
        IF GlobalResponse = RequestCompleted               ! IF Lookup completed
          TakeCustomerSelected()                           ! Source on Completion
        END                                                ! END (IF Lookup completed)
        GlobalResponse = RequestCancelled                  ! Clear Result
    OF ?InsertInvoiceDetail
      ThisWindow.Update()
      InvoiceDetailCache.InsertRecord()
    OF ?ChangeInvoiceDetail
      ThisWindow.Update()
      InvoiceDetailCache.ChangeRecord()
    OF ?DeleteInvoiceDetail
      ThisWindow.Update()
      InvoiceDetailCache.DeleteRecord()
    OF ?OK
      ThisWindow.Update()
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeCompleted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeCompleted()
    If ReturnValue = Level:Benign
      InvoiceDetailCache.SaveDetail()
    End
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!==============================================================================
TakeCustomerSelected          PROCEDURE
  CODE
  Inv:CustomerGuid = Cus:GUID
  Inv:FirstName    = Cus:FirstName
  Inv:LastName     = Cus:LastName
  Inv:Street       = Cus:Street
  Inv:City         = Cus:City
  Inv:State        = Cus:State
  Inv:PostalCode   = Cus:PostalCode
  Inv:Phone        = Cus:Phone

!==============================================================================
!==============================================================================
InvoiceDetailReader.Process   PROCEDURE
  CODE
  SELF.ClearErrors()

  OPEN(InvoiceDetailView)
  InvoiceDetailView{PROP:Filter} = 'UPPER(InvDet:InvoiceGuid) = <39>'& UPPER(Inv:Guid) &'<39>'
  SET(InvoiceDetailView)
  LOOP WHILE SELF.Errorcode = NoError
    NEXT(InvoiceDetailView)
    IF ERRORCODE() <> NoError THEN BREAK.
    SELF.TakeRecord()
  END
  CLOSE(InvoiceDetailView)
  
InvoiceDetailReader.TakeRecord    PROCEDURE
  CODE
  !Empty Virtual

InvoiceDetailReader.ClearErrors   PROCEDURE
  CODE
  SELF.Error         = ''
  SELF.ErrorCode     = NoError
  SELF.FileError     = ''
  SELF.FileErrorCode = 0

InvoiceDetailReader.SetErrors PROCEDURE
  CODE
  SELF.Error         = GlobalErrors.GetError    (ErrClarion)
  SELF.ErrorCode     = GlobalErrors.GetErrorCode(ErrClarion)
  SELF.FileError     = GlobalErrors.GetError    (ErrFile)
  SELF.FileErrorCode = GlobalErrors.GetErrorCode(ErrFile)
  Trace('SetErrors: '& SELF.ErrorCode & ' - '& Clip(SELF.Error) &' - '& SELF.FileErrorCode &' - '& Clip(SELF.FileError))
  
!==============================================================================
!==============================================================================
InvoiceDetailCache.AssignQueueToRecord    PROCEDURE
  CODE
  CLEAR(InvoiceDetail)
  InvDet:Record     :=: InvoiceDetailQueue
  InvDet:InvoiceGuid = Inv:GUID
  Pro:ProductCode    = InvDetQ:ProductCode
  Pro:ProductName    = InvDetQ:ProductName

!==============================================================================
InvoiceDetailCache.AssignRecordToQueue    PROCEDURE
  CODE
  CLEAR(InvoiceDetailQueue)
  InvoiceDetailQueue :=: InvDet:Record
  InvDetQ:ProductCode = Pro:ProductCode
  InvDetQ:ProductName = Pro:ProductName

!==============================================================================
InvoiceDetailCache.LoadDetail PROCEDURE
  CODE
  FREE(InvoiceDetailQueue)
  LoadDetailReader.Process()

LoadDetailReader.TakeRecord   PROCEDURE
  CODE
  InvoiceDetailCache.AssignRecordToQueue()
  ADD(InvoiceDetailQueue) !ADD(Queue) never fails, except when your computer is about to crash anyway!!!!
  
!==============================================================================
InvoiceDetailCache.SaveDetail PROCEDURE
  CODE
  LOGOUT(5, InvoiceDetail)
  IF ERRORCODE() <> NoError
    MESSAGE('Cannot begin transaction!|' |
        &     '|Error #'& ERRORCODE()     &' - '& CLIP(ERROR()) | 
        &'|File Error #'& FILEERRORCODE() &' - '& CLIP(FILEERROR()) | 
        ,'Error!', ICON:Exclamation)
    RETURN
  END
  SaveDetailReader.Process()
  !Trace('InvoiceDetailCache.SaveDetail: After Process: '& SaveDetailReader.Errorcode &' - Records='& RECORDS(InvoiceDetailQueue))
  IF SaveDetailReader.Errorcode = NoError
    LOOP WHILE RECORDS(InvoiceDetailQueue)
      GET(InvoiceDetailQueue, 1)
      InvoiceDetailCache.AssignQueueToRecord()
      InvDet:InvoiceGuid = Inv:GUID
      !Trace('Before TryInsert')
      IF Access:InvoiceDetail.TryInsert() <> Level:Benign
        SaveDetailReader.SetErrors()
        BREAK
      END
      DELETE(InvoiceDetailQueue)
    END
  END
  IF SaveDetailReader.Errorcode = NoError
    COMMIT()
    Trace('Error: '& ERRORCODE() &'-'& ERROR() &', '& FILEERRORCODE() &'-'& FILEERROR())
  ELSE
    ROLLBACK()
    MESSAGE('Unexpected error!|' |
        &     '|Error #'& SaveDetailReader.ErrorCode     &' - '& CLIP(SaveDetailReader.Error) | 
        &'|File Error #'& SaveDetailReader.FileErrorCode &' - '& CLIP(SaveDetailReader.FileError) | 
        ,'Error!', ICON:Exclamation)
  END

SaveDetailReader.TakeRecord   PROCEDURE
QueueBuffer                     STRING(SIZE(InvoiceDetailQueue))
  CODE
  InvoiceDetailQueue.GUID = InvDet:GUID
  GET(InvoiceDetailQueue, InvoiceDetailQueue.GUID)
  IF ERRORCODE() <> NoError
    IF Access:InvoiceDetail.TryFetch(InvDet:GuidKey) = Level:Benign
      IF Access:InvoiceDetail.DeleteRecord(False) <> Level:Benign
        SELF.SetErrors()
      END
    END
  ELSE
    QueueBuffer = InvoiceDetailQueue
    InvoiceDetailCache.AssignRecordToQueue()
    If InvoiceDetailQueue = QueueBuffer
      DELETE(InvoiceDetailQueue)
    ELSE
      IF Access:InvoiceDetail.TryFetch(InvDet:GuidKey) = Level:Benign
        InvoiceDetailQueue = QueueBuffer
        InvoiceDetailCache.AssignQueueToRecord()
        !Trace('SaveDetailReader.TakeRecord: InvDet:GUID='& InvDet:GUID &' - InvDet:InvoiceGuid='& InvDet:InvoiceGuid &' - InvDet:ProductGuid='& InvDet:ProductGuid)
        IF Access:InvoiceDetail.TryUpdate() <> Level:Benign
          SELF.SetErrors()
        END
      END
    END  
  END

!==============================================================================
InvoiceDetailCache.InsertRecord   PROCEDURE
  CODE
  Clear(InvoiceDetail)
  Clear(Product)
  IF Access:InvoiceDetail.PrimeRecord() = Level:Benign
    IF SELF.CallUpdateForm(InsertRecord) = RequestCompleted
      SELF.AssignRecordToQueue()
      ADD(InvoiceDetailQueue) !ADD(Queue) never fails, except when your computer is about to crash anyway!!!!
      SELECT(?InvoiceDetailList, POINTER(InvoiceDetailQueue))
    END
  END
  
!==============================================================================
InvoiceDetailCache.ChangeRecord   PROCEDURE
  CODE
  GET(InvoiceDetailQueue, Choice(?InvoiceDetailList))
  IF ERRORCODE() = NoError
    SELF.AssignQueueToRecord()
    IF SELF.CallUpdateForm(ChangeRecord) = RequestCompleted
      SELF.AssignRecordToQueue()
      PUT(InvoiceDetailQueue)
    END
    SELECT(?InvoiceDetailList)
  END
  
!==============================================================================
InvoiceDetailCache.DeleteRecord   PROCEDURE
  CODE
  GET(InvoiceDetailQueue, Choice(?InvoiceDetailList))
  IF ERRORCODE() = NoError
    IF MESSAGE('Are you sure you want to delete this item?', 'Delete Item?', ICON:Question, BUTTON:Yes+BUTTON:No, BUTTON:No) = BUTTON:Yes
      DELETE(InvoiceDetailQueue)
    END
    SELECT(?InvoiceDetailList)
  END
  
!==============================================================================
InvoiceDetailCache.CallUpdateForm PROCEDURE(LONG pRequest)
  CODE
  GlobalRequest = pRequest
  UpdateInvoiceDetail()
  Return GlobalResponse
  
