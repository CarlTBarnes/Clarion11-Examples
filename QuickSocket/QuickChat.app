hl职!YLI悍槟񷈭?�筂H槵u摋E�.  :�"�垉B�=�?R7U         @���"       f釼 �1     汊V �1               LOC:MessageOut ��                                                                       @s255                Message Out:        Message Out                                                                             Q    PROMPT('Message Out:'),USE(?LOC:MessageOut:Prompt)
 TEXT,USE(LOC:MessageOut)
     %    STRING(@s255),USE(LOC:MessageOut)
                                                                                                           .  	wXO徎J�'�         濑��"       堚V �1     ｂV �1                �                                                                                                                                                                                                                                                                                                                                                                                                                                                                        �  ~^燾f羖E墇\�� .      .  N���"       S釼 �1     U鏥 �1           +       %ProcedureRoutines     +*    a  UpdateControlsWhenConnectionFail ROUTINE
          !It fails, enable connection
          ?StartClientButton{PROP:Disable} = false
          ?StopClientButton{PROP:Disable} = true
          ?ServerInfGroup{PROP:Disable} = false
          ?ClientInfoGROUP{PROP:Disable}=false
          

          ?StartServerButton{PROP:Disable} = false
          ?SendButton{PROP:Disable} = true
          ?BrodcastNotifyButton{PROP:Disable} = true
          ?BrodcastShutdownButton{PROP:Disable} = true
          ?NotifyButton{PROP:Disable} = true
          
          0{PROP:Text} = 'Chat (Not Connected)'
   x   �        +       %ControlEventHandling     +       ?StartServerButton     +    	   Accepted     +�     +       ?StartClientButton     +    	   Accepted     +�  
   +       ?StopServerButton     +    	   Accepted     +�     +       ?StopClientButton     +    	   Accepted     +�     +       ?ResetServerInfoButton     +    	   Accepted     +*       GLO:Server_Ip=''
 �  �  �      +�     +*       DISPLAY()
 �  �  �      +       ?SendButton     +    	   Accepted     +�  	   +       ?BrodcastNotifyButton     +    	   Accepted     +�     +       ?NotifyButton     +    	   Accepted     +�     +       ?BrodcastShutdownButton     +    	   Accepted     +�     +       ?BUTTONSendQueue     +    	   Accepted     +�     +       ?BUTTONClear     +    	   Accepted     +*       FREE(lQMessage)
DISPLAY()
 �  �  �      +        %WindowManagerMethodCodeSection     +       Init     +       (),BYTE     +*    (   0{PROP:Text} = 'Chat (Not Connected)'
 ^    �      +*    &   Do UpdateControlsWhenConnectionFail
 ^  �  �      +    )   %SVQuickAppConnectServerStartServerError     +       3     +*    C  MESSAGE('The Server Failed to Start|Error:'&LOC:Error)
?StartServerButton{PROP:Disable} = False
?StopServerButton{PROP:Disable} = TRUE
?ResetServerInfoButton{PROP:Disable} = FALSE
?ServerInfGroup{PROP:Disable} = FALSE
    
!Enable client
?StartClientButton{PROP:Disable} = FALSE
?StopClientButton{PROP:Disable} = TRUE
?ClientInfoGROUP{PROP:Disable}= FALSE

?SendButton{PROP:Disable} = TRUE
?BrodcastNotifyButton{PROP:Disable} = TRUE
?BrodcastShutdownButton{PROP:Disable} = TRUE
?NotifyButton{PROP:Disable} = TRUE
   
0{PROP:Text} = 'Chat (Not Connected)'      
 �  �         +    &   %SVQuickAppConnectServerStartServerOk     +       3     +*    Z  ?StartServerButton{PROP:Disable} = TRUE
?StopServerButton{PROP:Disable} = FALSE
?ResetServerInfoButton{PROP:Disable} = TRUE
?ServerInfGroup{PROP:Disable} = TRUE
           
!Disable to Client too
?StartClientButton{PROP:Disable} = TRUE
?StopClientButton{PROP:Disable} = TRUE
           
?ClientInfoGROUP{PROP:Disable}= TRUE
           
?SendButton{PROP:Disable} = FALSE
?BrodcastNotifyButton{PROP:Disable} = FALSE
?BrodcastShutdownButton{PROP:Disable} = FALSE
?NotifyButton{PROP:Disable} = FALSE
          
0{PROP:Text} = 'Chat Server ('&GLO:Server_Name&')'
SELECT(?TABClient)      
 �          +    +   %SVQuickAppConnectServerStartServerAlready     +       3     +*    /   MESSAGE('The Server is already running')    
 �          +    (   %SVQuickAppConnectServerStopServerAfter     +       3     +*    ,  CLEAR(lQMessage)
CLEAR(lQUsers)         

?StartServerButton{PROP:Disable} = FALSE
?StopServerButton{PROP:Disable} = TRUE
?ResetServerInfoButton{PROP:Disable} = FALSE
?ServerInfGroup{PROP:Disable} = FALSE

!Enable client
?StartClientButton{PROP:Disable} = FALSE
?StopClientButton{PROP:Disable} = TRUE
?ClientInfoGROUP{PROP:Disable} = FALSE

?SendButton{PROP:Disable} = TRUE
?BrodcastNotifyButton{PROP:Disable} = TRUE
?BrodcastShutdownButton{PROP:Disable} = TRUE
?NotifyButton{PROP:Disable} = TRUE

0{PROP:Text} = 'Chat (Not Connected)'
 �     3      +    &   %SVQuickAppConnectServerStopServerNot     +       3     +*    +   MESSAGE('The Server is unreachable')    
 �  4  5      +    "   %SVQuickAppConnectClientConnectOk     +       3     +*    �  !Disable re-connection
?StartClientButton{PROP:Disable} = TRUE
?StopClientButton{PROP:Disable} = FALSE
?ClientInfoGROUP{PROP:Disable}= TRUE
?ServerInfGroup{PROP:Disable} = TRUE

!server disable
?StartServerButton{PROP:Disable} = TRUE

?SendButton{PROP:Disable} = FALSE
?BrodcastNotifyButton{PROP:Disable} = FALSE
?BrodcastShutdownButton{PROP:Disable} = FALSE
?NotifyButton{PROP:Disable} = FALSE

0{PROP:Text} = 'Chat Client ('& GLO:Client_Name &')'
 �  >  M  
    +    '   %SVQuickAppConnectClientConnectLoginOk     +       3     +*       SELECT(?TABClient)
 �  R  S      +    )   %SVQuickAppConnectClientConnectLoginFail     +       3     +*    L   Do UpdateControlsWhenConnectionFail
MESSAGE('The Login attempt failed.')
 �  O  Q      +    $   %SVQuickAppConnectClientConnectFail     +       3     +*    ^   Do UpdateControlsWhenConnectionFail
MESSAGE('The attempt to connect to the Server failed')
 �  ;  =  
    +    %   %SVQuickAppConnectClientDisconnectOk     +       3     +*    �  CLEAR(lQMessage)
CLEAR(lQUsers)
FREE(lQUsers)
!It fails, enable connection
?StartClientButton{PROP:Disable} = FALSE
?StopClientButton{PROP:Disable} = TRUE
?ServerInfGroup{PROP:Disable} = TRUE
?ClientInfoGROUP{PROP:Disable}= FALSE

?SendButton{PROP:Disable} = TRUE
?BrodcastNotifyButton{PROP:Disable} = TRUE
?BrodcastShutdownButton{PROP:Disable} = TRUE

?StartServerButton{PROP:Disable} = FALSE
0{PROP:Text} = 'Chat (Not Connected)'
 �  Z  i      +    "   %QuickAppConnectMethodCodeSection     +       3  	   +       Event_BroadcastNotification     +    >   (STRING pFromUserName,LONG pNotificationCode,STRING pMsgText)     +*    �   lQMessage.MessageFrom = 'Notification From: '&pFromUserName &' sent to ALL'
lQMessage.MessageText = 'Code('&pNotificationCode&') '&pMsgText
lQMessage.MessageDate = TODAY()
lQMessage.MessageTime = CLOCK()
ADD(lQMessage)

 �  �  �      +       Event_BroadcastShutdown     +    >   (STRING pFromUserName,LONG pNotificationCode,STRING pMsgText)     +*    �   MESSAGE('The user '&pFromUserName&' is requesting to shutdown the App|Code:('&pNotificationCode&')|'&pMsgText,'Shutdown Request')
 �  �  �      +       Event_LoginOnServer     +    ?   (STRING pUserName,STRING pUserPassword,*BYTE pCancelOperation)     +*    �   !Verify that the pUserName and pUserPassword are correct
IF UPPER(pUserName) = 'GUEST' !Do not allow a GUEST user
   pCancelOperation = true
END
 �  �        +*    �   IF pCancelOperation
!   MESSAGE('the login was cancelled by the server')    
ELSE
 !  MESSAGE('A user has logged in using |User Name: '&pUserName&'|Password: '&pUserPassword,'Login Received')    
END

 �    	      +       Event_Message     +    :   (STRING pFromUserName,STRING pToUserName,STRING pMsgText)     +*    �   lQMessage.MessageFrom = 'From: '&pFromUserName &' to '&pToUserName
lQMessage.MessageText = pMsgText
lQMessage.MessageDate = TODAY()
lQMessage.MessageTime = CLOCK()
ADD(lQMessage)

 �          +       Event_Notification     +    Q   (STRING pFromUserName,STRING pToUserName,LONG pNotificationCode,STRING pMsgText)     +*    I  IF pNotificationCode = 999  !We use a user-defined notification code to know that we sent a GROUP
   LOC:NotificationCode = 999
   SELF.FromJSON(pMsgText,LOC:GroupOfData) !This will parse the JSON String and put the data in the GROUP
   lQMessage.MessageFrom = 'ClientInfo From '&pFromUserName &' to '&pToUserName
   lQMessage.MessageText = 'Id='&LOC:GroupOfData.ClientId&', Name='&LOC:GroupOfData.ClientName&', Address='&CLIP(LOC:GroupOfData.ClientAddress)
   lQMessage.MessageDate = TODAY()
   lQMessage.MessageTime = CLOCK()
   ADD(lQMessage)
ELSE
   !It is a regular notification
   lQMessage.MessageFrom = 'Notification From '&pFromUserName &' to '&pToUserName
   lQMessage.MessageText = '('&pNotificationCode&') '&pMsgText
   lQMessage.MessageDate = TODAY()
   lQMessage.MessageTime = CLOCK()
   ADD(lQMessage)   
END
 �    *      +       Event_NotifyCleanConnected     +       ()     +*    -   CLEAR(lQUsers)
FREE(lQUsers)
DISPLAY()

 �  0  4      +       Event_NotifyConnected     +       (STRING pUserName)     +*    N   CLEAR(lQUsers)  
lQUsers.UserName = pUserName
ADD(lQUsers)    
DISPLAY()
 �  :  >      +       Event_NotifyDisconnected     +       (STRING pUserName)     +*    �   CLEAR(lQUsers)
lQUsers.UserName = pUserName
GET(lQUsers,lQUsers.UserName)
IF NOT ERRORCODE()
   DELETE(lQUsers)
END    
DISPLAY()
 �  D  K      +       Event_ServerResponse     +    4   (LONG pOriginalCommand,LONG pRetVal,STRING pRetMsg)     +*    �  CASE pOriginalCommand
OF QuickSocketCmd:Login
   IF pRetVal<>0
      Do UpdateControlsWhenConnectionFail
      !ELSE
       !   MESSAGE('Login ok: '&pRetMsg)
    END
OF QuickSocketCmd:SendMessage
OF QuickSocketCmd:SendData
OF QuickSocketCmd:SendNotify
OF QuickSocketCmd:BroadcastNotify
OF QuickSocketCmd:BroadcastShutdown
OF QuickSocketCmd:NotifyConnected
OF QuickSocketCmd:NotifyDisconnected
OF QuickSocketCmd:CmdAnswer  
END
 �  R  b      +       %SVQuickAppConnectActionOk     +       5     +*      !Add the message to the Local QUEUE
lQMessage.MessageFrom = 'To All '
lQMessage.MessageText = '('&LOC:NotificationCode&') '&LOC:MessageOut
lQMessage.MessageDate = TODAY()
lQMessage.MessageTime = CLOCK()
ADD(lQMessage)
LOC:MessageOut = ''
DISPLAY()
 �  �   �       +       9     +*    �   lQMessage.MessageFrom = 'To: '&LOC:ToUserName
lQMessage.MessageText = LOC:MessageOut
lQMessage.MessageDate = TODAY()
lQMessage.MessageTime = CLOCK()
ADD(lQMessage)
LOC:MessageOut = ''
DISPLAY()
 �  �   �       +       6     +*      !Add the Shutdown message to the local QUEUE
lQMessage.MessageFrom = 'To All Shutdown'
lQMessage.MessageText = '('&LOC:NotificationCode&') '&LOC:MessageOut
lQMessage.MessageDate = TODAY()
lQMessage.MessageTime = CLOCK()
ADD(lQMessage)
LOC:MessageOut = ''
DISPLAY()
 �  �   �       +       7     +*    X  !Add the Group Information to the QUEUE
lQMessage.MessageFrom = 'ClientInfo To: '&LOC:ToUserName
lQMessage.MessageText = 'Id='&LOC:GroupOfData.ClientId&', Name='&LOC:GroupOfData.ClientName&', Address='&CLIP(LOC:GroupOfData.ClientAddress)

lQMessage.MessageDate = TODAY()
lQMessage.MessageTime = CLOCK()
ADD(lQMessage)       
DISPLAY()
 �  �   �       +       8     +*      !Add the information to the local QUEUE
lQMessage.MessageFrom = 'To: '&LOC:ToUserName
lQMessage.MessageText = 'Code('&LOC:NotificationCode&') '&LOC:MessageOut
lQMessage.MessageDate = TODAY()
lQMessage.MessageTime = CLOCK()
ADD(lQMessage)
LOC:MessageOut = ''
DISPLAY()
 �  �   �       +       %SVQuickAppConnectActionData     +       7     +*             !Set the group information to be sent
       LOC:NotificationCode = 999 !We use a user-defined notification code
       LOC:GroupOfData.ClientId     = 101
       LOC:GroupOfData.ClientName   = 'Arnold Baker'
       LOC:GroupOfData.ClientAddress= '101 Main St.,NY,USA'      
 �  �   �        +       %WindowEventHandling     +       OpenWindow     +*    D     GLO:Client_Name = 'Guest' & RANDOM(1,200000)      
  DISPLAY()
 �  �  �                                                                                     j   �"�*�欵�c�1� _      _  2���"       J釼 �1     ｂV �1        1         %ClassItem %            
                Default             ErrorManager             ErrorStatusManager             FileManager:             FileManager:Messages             FuzzyMatcher
   
       
   INIManager             RelationManager:             RelationManager:Messages
   
       
   Translator       %DefaultBaseClassType %                   %ClassItem                 ErrorManager
   
       
   ErrorClass             ErrorStatusManager             ErrorStatusClass             FileManager:Messages             FileManager             FuzzyMatcher
   
       
   FuzzyClass
   
       
   INIManager             INIClass             RelationManager:Messages             RelationManager
   
       
   Translator             TranslatorClass       %ActualDefaultBaseClassType %                   %ClassItem                 ErrorManager                             ErrorStatusManager                             FileManager:Messages                             FuzzyMatcher                
   
       
   INIManager                             RelationManager:Messages                
   
       
   Translator                       %ClassLines %                  %ClassItem    
   
       
   INIManager   *   *       *   Fetch                  PROCEDURE(),DERIVED*   *       *   Update                 PROCEDURE(),DERIVED       %ProgramAuthor %                                    %ProgramIcon %                                    %MessageDescription                               %GlobalExternal                                %ExternalSource %                          Dynamic Link Library (DLL)       %GenerateEmbedComments                             	   %INIType %                          NVD_INI    	   %INIFile %                          Program Name.INI    	   %ININame %                                    %INIProgramIniLocation %                          APPDIR       %INICSIDLDirectory %                          SV:CSIDL_PERSONAL       %CSIDLCompanyDir %                                    %CSIDLProductDir %                                    %CSIDLCreate                                %INIInAppDirectory                            	   %REGRoot %                          REG_CLASSES_ROOT       %DisableINISaveWindow                                %PreserveVars                                                     %PreserveVar %                   %PreserveVars                           GLO:Server_Ip                       GLO:Server_Port                       GLO:Server_Name       %EnableRunTimeTranslator                                %FuzzyMatchingEnabled                                %IgnoreCase                            
   %WordOnly                                %ButtonMarginsCompatibility                                %UseDefaultXPManifest                                %GenerateXPManifest                               %LinkGenerateXPManifest                                %AddVistaXPManifest                               %VistaManifestExecutionLevel %             	   	       	   asInvoker       %VistaManifestUIAccess                                %NoThemedControlsDependency                                 %VistaManifestDependentAssembly                     $   %VistaManifestDependentAssemblyName %                    %VistaManifestDependentAssembly         '   %VistaManifestDependentAssemblyVersion %                    %VistaManifestDependentAssembly         $   %VistaManifestDependentAssemblyType %                    %VistaManifestDependentAssembly         .   %VistaManifestDependentAssemblyPublicKeyToken %                    %VistaManifestDependentAssembly         (   %VistaManifestDependentAssemblyLanguage %                    %VistaManifestDependentAssembly         5   %VistaManifestDependentAssemblyProcessorArchitecture                     %VistaManifestDependentAssembly            %W7ManifestVista                               %W7ManifestW7                               %W7ManifestW8                               %W7ManifestW81                                %ForceMakeTransparentXPManifest                                %ForceMakeColorXPManifest                                %ForceSHEETNoTheme                                %ExtUIXPMenuEnableGlobal                                %ExtUIXPMenuColorTypeGlobal %                          OFF       %ExtUIXPMenuDisableImageBar                               %ExtUIXPMenuEnableRuntime                                %ExtUIXPMenuRuntimeVar %                                    %ExtUIXPMenuColorLeftGlobal                     祆�        %ExtUIXPMenuColorRightGlobal                     Е�     (   %ExtUIXPMenuColorSelectionBarLeftGlobal                     祆�     )   %ExtUIXPMenuColorSelectionBarRightGlobal                     祆�        %ExtUIXPMenuSelVertical                            '   %ExtUIXPMenuColorSelectionBorderGlobal                     祆�        %ExtUIXPMenuColorHotLeftGlobal                     祆�         %ExtUIXPMenuColorHotRightGlobal                     祆�     $   %ExtUIXPMenuColorSelectedLeftGlobal                     祆�     %   %ExtUIXPMenuColorSelectedRightGlobal                     祆�     %   %ExtUIXPMenuColorNormalBarLeftGlobal                     祆�     &   %ExtUIXPMenuColorNormalBarRightGlobal                     祆�     &   %ExtUIXPMenuColorItemBackgroundGlobal                       �       %ExtUIXPMenuColorNormalText                                %ExtUIXPMenuColorSelectedText                                %ExtUIXPMenuColorHotText                                %ExtUIXPMenuFlat                               %ExtUIXPMenuShowImageBar                                %ExtUIXPMenuSeparator3D                               %ExtUIXPMenuSeparatorFull                                %ExtUIXPMenuVerticalLine                               %ExtUIMDITabGlobal %                          DISABLE       %ExtUIMDITabStyleGlobal %                          Default       %ExtUITabStyleGlobal %                          Squared       %WindowEnableEnhanceFocus                                %SelectedText                               %SelectedRadio                               %SelectedSpin                               %SelectedCheck                               %SelectedDropList                               %SelectedList                               %SelectedDisplayChangeColor                               %SelectedColor                     ��         %SelectedStyle                               %SelectedRequired                                %SelectedRequiredColor                     ��         %SelectedDisplayBox                               %SelectedDisplayBoxFillColor                     ��         %SelectedDisplayBoxBorderColor                                %SelectedDisplayBoxBorderSize %                          2       %SelectedRequiredBox                             %   %SelectedRequiredDisplayBoxFillColor                     �       '   %SelectedRequiredDisplayBoxBorderColor                                %SelectedCaret                               %SelectedCaretColor                     ���        %SelectedCaretCharacter %                          �    "   %SelectedCaretCharacterSeparation %                          8       %ExcludeSelectedDropList                                %EnableOSK %                          OFF       %GlobalUseEnterInsteadTab                             !   %GlobalUseEnterInsteadTabExclude %                        %GlobalUseEnterInsteadTabEnable %                          Enable    %   %GlobalUseEnterInsteadTabEnableValue %                          True       %GlobalInterLine %                          0       %GlobalEnableAutoSizeColumn                                %GlobalEnableListFormatManager                             "   %GlobalUserFieldListFormatManager %                          1       %TableOrigin %                          Application       %FileEquate %             	   	       	   LFM_CFile       %ConfigFilePRE %                          CFG       %ConfigFileOEM                                %ConfigFileTHREAD                               %ConfigFileENCRYPT                                %ConfigFilePASSWORD %                                    %FormatNameSize %                          30       %FormatBufferSize %                          5120       %VariableBufferSize %                          2048       %ConfigFilePath %                                    %UseConfigFileName %                          Default       %ConfigFileNAME %                          Formats.FDB       %ColonCounter %                                    %WrongSymbol %                                    %DictionaryTableOrigin !                     %GlobalLFMSortOrderMenuText %             	   	       	   SortOrder       %GlobalEnableRebase                                %RBDMethod %                          Specify manually       %RBDImageBase %                          10000000       %DefaultGenerate                                %DefaultRILogout                               %LockRecoverTime %                          10       %DefaultThreaded %                          Use File Setting       %DefaultCreate %                          Use File Setting       %DefaultExternal %                          None External       %DefaultLocalExternal                                %DefaultExternalSource %                                    %DefaultExternalAPP                                %DefaultExport                                %DefaultOpenMode %                          Share       %DefaultUserAccess %             
   
       
   Read/Write       %DefaultOtherAccess %             	   	       	   Deny None       %DefaultLazyOpen                               %GeneratePropDataPath                                %PropDataPathLocation %                          CSIDLLIKEINI       %DataPathCSIDLDirectory %                          SV:CSIDL_PERSONAL       %DataPathCSIDLCompanyDir %                                    %DataPathCSIDLProductDir %                                    %DataPathCSIDLCreate                                %DataPathOtherDirectory %                                    %DataPathOtherDirectoryCreate                                %OverrideGenerate                    %File            %OverrideRILogout %                   %File                                 Use Default       %GlobalObject %                   %ClassItem                 ErrorManager             YES             ErrorStatusManager             YES             FileManager:Messages             YES             FuzzyMatcher             YES
   
       
   INIManager             YES             RelationManager:Messages             YES
   
       
   Translator             YES       %ThisObjectName %                   %ClassItem                 ErrorManager             GlobalErrors             ErrorStatusManager             GlobalErrorsStatus             FileManager:Messages             Hide:Access:Messages             FuzzyMatcher             FuzzyMatcher
   
       
   INIManager             INIMgr             RelationManager:Messages             Hide:Relate:Messages
   
       
   Translator
   
       
   Translator       %UseDefaultABCBaseClass                    %ClassItem                 ErrorManager                       ErrorStatusManager                       FileManager:Messages                       FuzzyMatcher          
   
       
   INIManager                       RelationManager:Messages          
   
       
   Translator                 %UseABCBaseClass                    %ClassItem                 ErrorManager                       ErrorStatusManager                       FileManager:Messages                       FuzzyMatcher          
   
       
   INIManager                       RelationManager:Messages          
   
       
   Translator                 %ABCBaseClass %                   %ClassItem                 ErrorManager                             ErrorStatusManager                             FileManager:Messages             ADOBlob             FuzzyMatcher                
   
       
   INIManager                             RelationManager:Messages             ADOBlob
   
       
   Translator                       %ExtBaseClass %                   %ClassItem            %BaseClassIncludeFile %                   %ClassItem            %DeriveFromBaseClass                    %ClassItem                 ErrorManager                        ErrorStatusManager                        FileManager:Messages                        FuzzyMatcher           
   
       
   INIManager                        RelationManager:Messages           
   
       
   Translator                  %NewMethods                   %ClassItem            %NewMethodName %                   %NewMethods            %NewMethodPrototype %                   %NewMethods            %NewClassPropertyItems                   %ClassItem            %NewClassProperty %                   %NewClassPropertyItems            %NewClassDataType %                   %NewClassPropertyItems                 ErrorManager                 FuzzyMatcher    
   
       
   INIManager                 RelationManager:Messages           %NewClassOtherType %                   %NewClassPropertyItems            %NewClassDataIsRef                    %NewClassPropertyItems            %NewClassDataSize %                   %NewClassPropertyItems            %NewClassDataDim1 %                   %NewClassPropertyItems            %NewClassDataDim2 %                   %NewClassPropertyItems            %NewClassDataDim3 %                   %NewClassPropertyItems            %NewClassDataDim4 %                   %NewClassPropertyItems            %ClassMethods                   %ClassItem            %ClassMethodName %                   %ClassMethods            %ClassMethodPrototype %                   %ClassMethods            %ClassPropertyItems                   %ClassItem            %ClassProperty %                   %ClassPropertyItems            %ClassDataType %                   %ClassPropertyItems                 ErrorManager                 FuzzyMatcher    
   
       
   INIManager                 RelationManager:Messages           %ClassOtherType %                   %ClassPropertyItems            %ClassDataIsRef                    %ClassPropertyItems            %ClassDataSize %                   %ClassPropertyItems            %ClassDataDim1 %                   %ClassPropertyItems            %ClassDataDim2 %                   %ClassPropertyItems            %ClassDataDim3 %                   %ClassPropertyItems            %ClassDataDim4 %                   %ClassPropertyItems            %OverrideThreaded %                   %File                                 Use Default       %OverrideCreate %                   %File                                 Use Default       %OverrideExternal %                   %File                                 Use Default       %OverrideLocalExternal                    %File            %OverrideExternalSource %                   %File            %OverrideExternalAPP                    %File            %OverrideExport                    %File            %FileDeclarationMode %                   %File                                 Use User Options       %FileDeclarationType                    %File                                      %FileDeclarationThread                    %File                                      %FileDeclarationBindable                    %File                                     %FileDeclarationName %                   %File            %FileDeclarationOver %                   %File            %OverrideOpenMode %                   %File                                 Use Default       %OverrideUserAccess %                   %File                                 Use Default       %OverrideOtherAccess %                   %File                                 Use Default       %OverrideLazyOpen %                   %File                                 Use Default       %StandardExternalModule                    %Module                                           QuickChat.clw                       QuickChatMain.clw                 %NoGenerateGlobals                                %WindowManagerType %                          WindowManager       %ResetOnGainFocus                                %AutoToolbar                               %AutoRefresh                               %ImageClass %                          ImageManager       %ErrorStatusManagerType %                          ErrorStatusClass       %ErrorManagerType %             
   
       
   ErrorClass       %DefaultErrorCategory %                          ABC       %AllowSelectCopy                                %StoreErrorHistory                                %LimitStoredHistory                                %ErrorHistoryThreshold %                          300       %HistoryViewTrigger %                          Level:Fatal       %PopupClass %             
   
       
   PopupClass       %SelectFileClass %                          SelectFileClass       %ResizerType %                          WindowResizeClass       %ResizerDeFaultFindParents                               %ResizerDefaultOptimizeMoves                               %ResizerDefaultOptimizeRedraws                            
   %INIClass %                          INIClass       %RunTimeTranslatorType %                          TranslatorClass       %ExtractionFilename %                                    %TranslationGroups                        %TranslationFile %                   %TranslationGroups            %TranslationGroup %                   %TranslationGroups            %CalendarManagerType %                          CalendarClass       %GlobalChangeColor                                %GlobalColorSunday                     �          %GlobalColorSaturday                     �          %GlobalColorHoliday                      �         %GlobalColorOther                                %GlobalSelectOnClose %                          Select       %GlobalUseABCClasess                               %FileManagerType %                          FileManager       %ViewManagerType %                          ViewManager       %RelationManagerType %                          RelationManager       %BrowserType %                          BrowseClass       %ActiveInvisible                                %AllowUnfilled                                %RetainRow                               %FileDropManagerType %                          FileDropClass       %FileDropComboManagerType %                          FileDropComboClass       %FormVCRManagerType %                          FormVCRClass       %BrowseEIPManagerType %                          BrowseEIPManager       %EditInPlaceInterface %                          Detailed       %EditInPlaceType %                          EditEntryClass       %EditInPlaceEntryType %                          EditEntryClass       %EditInPlaceTextType %                          EditTextClass       %EditInPlaceCheckType %                          EditCheckClass       %EditInPlaceSpinType %                          EditSpinClass       %EditInPlaceDropListType %                          EditDropListClass       %EditInPlaceDropComboType %                          EditDropComboClass       %EditInPlaceColorType %                          EditColorClass       %EditInPlaceFileType %                          EditFileClass       %EditInPlaceFontType %                          EditFontClass       %EditInPlaceMultiSelectType %                          EditMultiSelectClass       %EditInPlaceCalendarType %                          EditCalendarClass       %EditInPlaceLookupType %                          EditLookupClass       %EditInPlaceOtherType %                          EditEntryClass       %QBEFormType %                          QueryFormClass       %QBEFormVisualType %                          QueryFormVisual       %QBEListType %                          QueryListClass       %QBEListVisualType %                          QueryListVisual       %StepManagerType %             	   	       	   StepClass       %StepManagerLongType %                          StepLongClass       %StepManagerRealType %                          StepRealClass       %StepManagerStringType %                          StepStringClass       %StepManagerCustomType %                          StepCustomClass       %StepLocatorType %                          StepLocatorClass       %EntryLocatorType %                          EntryLocatorClass       %IncrementalLocatorType %                          IncrementalLocatorClass       %FilteredLocatorType %                          FilterLocatorClass       %FuzzyMatcherClass %             
   
       
   FuzzyClass       %GridClass %             	   	       	   GridClass       %SidebarClass %                          SidebarClass       %ProcessType %                          ProcessClass       %PrintPreviewType %                          PrintPreviewClass       %ReportManagerType %                          ReportManager    !   %ReportTargetSelectorManagerType %                          ReportTargetSelectorClass       %BreakManagerType %                          BreakManagerClass       %AsciiViewerClass %                          AsciiViewerClass       %AsciiSearchClass %                          AsciiSearchClass       %AsciiPrintClass %                          AsciiPrintClass       %AsciiFileManagerType %                          AsciiFileClass       %ToolbarClass %                          ToolbarClass       %ToolbarListBoxType %                          ToolbarListboxClass       %ToolbarRelTreeType %                          ToolbarReltreeClass       %ToolbarUpdateClassType %                          ToolbarUpdateClass       %ToolbarFormVCRType %                          ToolbarFormVCRClass       %OverrideAbcSettings                                %AbcSourceLocation %                          LINK       %AbcLibraryName %                                    %AppTemplateFamily %                          ABC       %CWTemplateVersion %                          v10.0       %ABCVersion %                          10000       %CustomGlobalIncludeList                                           %CustomGlobalIncludeFile %                   %CustomGlobalIncludeList                           QuickSock.INC                       JSon.INC                                                   d   ?�筂H槵u摋E�         Z���"       <釼 �1     :骎 �1        "   尓�;K佊礚�vU匧玣蝓廜揔璸
"x�   �8P�1恇C俒鶐挢勀胨讯莼孒⑵9��                �/J=�繧�7⑽Z%Q                  糖R �1 糖R �1      	   ABC$ToDo                        ABC         s s1 僓   �;wT溻V �1        1   SVQuickAppConnectSupport$SVQuickAppConnectGlobal    ����                      %GlobalDisable                             �"�*�欵�c�1�                                                                                              .  叅D枈
欳�	B(�.镝         ���"       ^釼 �1     汊V �1               GLO:Server_Ip �                                                                        @K<<#.<<#.<<#.<<#K                Server Ip:     
   Server Ip                                                                             b    PROMPT('Server Ip:'),USE(?GLO:Server_Ip:Prompt)
 ENTRY(@K<<#.<<#.<<#.<<#K),USE(GLO:Server_Ip)
     1    STRING(@K<<#.<<#.<<#.<<#K),USE(GLO:Server_Ip)
                                                                       .  q釕曝Dⅳ盍2         $���"       V釼 �1     汊V �1               GLO:Client_Name �                                                                        @s20                Message From:        Message From                                                                             [    PROMPT('Message From:'),USE(?GLO:Client_Name:Prompt)
 ENTRY(@s20),USE(GLO:Client_Name)
     %    STRING(@s20),USE(GLO:Client_Name)
                        Mes:MessageFrom                                                       �  屧�\0N瓜釻墿`�         ����"       R釼 �1     ｂV �1                                                                                                                                                                                                                            .  �5z轨5^B�\石"%�         $���"       [釼 �1     汊V �1               GLO:Server_Name �                                                                        @s20                Message From:        Message From                                                                             [    PROMPT('Message From:'),USE(?GLO:Server_Name:Prompt)
 ENTRY(@s20),USE(GLO:Server_Name)
     %    STRING(@s20),USE(GLO:Server_Name)
                        Mes:MessageFrom                                                       .  蕍-鴢褽偓攩��         濑��"       涒V �1     ｂV �1                �                                                                                                                                                                                                                                                                                                                                                                                                                                                                        .  旙pv�CqZ犞         ]���"       �釼 �1     溻V �1               lQUsers �                                                                        @s20                l QU sers:     
   l QU sers                                                                             H    PROMPT('l QU sers:'),USE(?lQUsers:Prompt)
 ENTRY(@s20),USE(lQUsers)
         STRING(@s20),USE(lQUsers)
                                                                                                                                        p   胨讯莼孒⑵9��         L���"       a釼 �1     溻V �1           �/J=�繧�7⑽Z%Q       QuickChatMain.clw                                           ABC$GENERATED           wH簷溻V �1                                                                                      .  璢兽oJ蔕國.喷d�         ��"       g釼 �1     汊V �1               LOC:NotificationCode �                                                                      @n3                Notification Code:        LOC : Notification Code                                                                             r    PROMPT('Notification Code:'),USE(?LOC:NotificationCode:Prompt)
 ENTRY(@n3),USE(LOC:NotificationCode),RIGHT(1)
     2    STRING(@n3),USE(LOC:NotificationCode),RIGHT(1)
                                                                                                                                                                                                                                                                                                       .  瀬涱�
貲lた魆�         )���"       曗V �1     溻V �1               MessageDate �                                                                      @d1                Message Date:        Message Date                                                                             c    PROMPT('Message Date:'),USE(?LQM:MessageDate:Prompt)
 ENTRY(@d1),USE(LQM:MessageDate),RIGHT(1)
     -    STRING(@d1),USE(LQM:MessageDate),RIGHT(1)
                                                                                    .  J�&d驚嶏鰌抅 �         ���"       \釼 �1     汊V �1               GLO:Server_Port �                                                                      @K<<<#K                Server Port:        Server Port                                                                             f    PROMPT('Server Port:'),USE(?GLO:Server_Port:Prompt)
 ENTRY(@K<<<#K),USE(GLO:Server_Port),RIGHT(1)
     1    STRING(@K<<<#K),USE(GLO:Server_Port),RIGHT(1)
                                                                        .  诬E�-怋厕c脐滪|         :���"       掆V �1     溻V �1               MessageText �                                                                        @s255                Message Text:        Message                                                                             \    PROMPT('Message Text:'),USE(?LQM:MessageText:Prompt)
 ENTRY(@s255),USE(LQM:MessageText)
     &    STRING(@s255),USE(LQM:MessageText)
                                                                                                     r   �/J=�繧�7⑽Z%Q 6      6  柺��"      N釼 �1     溻V �1                  Main 胨讯莼孒⑵9��                琯翚L昍錴~贴                 Window        Window                ABC$Window        Window s �1 溻V       溻V �1        +   SVQuickAppConnectSupport$SVQuickAppConnect    ����            ;           %QuickAppConnectClassObjectName %                                    %LocalDisable                                %PromptLocalDisable                                %SupportServer                               %SupportClient                               %LocalServerIP "             叅D枈
欳�	B(�.镝       %LocalServerPort "             J�&d驚嶏鰌抅 �       %LocalServerName "             �5z轨5^B�\石"%�       %LocalServerClientAsServer                               %LocalServerIPCli "             叅D枈
欳�	B(�.镝       %LocalServerPortCli "             J�&d驚嶏鰌抅 �       %LocalServerNameCli "             �5z轨5^B�\石"%�       %LocalClientName "             q釕曝Dⅳ盍2       %LocalClientPwd %                          GLO:Client_Pwd       %QuickAppConnectObjectName %                          QuickAppConnect       %ClassItem %                            Default       %DefaultBaseClassType %                   %ClassItem                 Default             QuickAppConnectClass       %ActualDefaultBaseClassType %                   %ClassItem                 Default                       %ClassLines %                  %ClassItem                 Default	   j   j       j   Event_BroadcastNotification PROCEDURE(STRING pFromUserName,LONG pNotificationCode,STRING pMsgText),DERIVEDf   f       f   Event_BroadcastShutdown PROCEDURE(STRING pFromUserName,LONG pNotificationCode,STRING pMsgText),DERIVEDf   f       f   Event_LoginOnServer    PROCEDURE(STRING pUserName,STRING pUserPassword,*BYTE pCancelOperation),DERIVEDa   a       a   Event_Message          PROCEDURE(STRING pFromUserName,STRING pToUserName,STRING pMsgText),DERIVEDx   x       x   Event_Notification     PROCEDURE(STRING pFromUserName,STRING pToUserName,LONG pNotificationCode,STRING pMsgText),DERIVED.   .       .   Event_NotifyCleanConnected PROCEDURE(),DERIVED:   :       :   Event_NotifyConnected  PROCEDURE(STRING pUserName),DERIVED<   <       <   Event_NotifyDisconnected PROCEDURE(STRING pUserName),DERIVED[   [       [   Event_ServerResponse   PROCEDURE(LONG pOriginalCommand,LONG pRetVal,STRING pRetMsg),DERIVED       %GlobalObject %                   %ClassItem                 Default             NO       %ThisObjectName %                   %ClassItem                 Default             QuickAppConnect       %UseDefaultABCBaseClass                    %ClassItem                 Default                 %UseABCBaseClass                    %ClassItem                 Default                 %ABCBaseClass %                   %ClassItem                 Default                       %ExtBaseClass %                   %ClassItem            %BaseClassIncludeFile %                   %ClassItem            %DeriveFromBaseClass                    %ClassItem                 Default                  %NewMethods                   %ClassItem            %NewMethodName %                   %NewMethods            %NewMethodPrototype %                   %NewMethods            %NewClassPropertyItems                   %ClassItem            %NewClassProperty %                   %NewClassPropertyItems            %NewClassDataType %                   %NewClassPropertyItems                 Default           %NewClassOtherType %                   %NewClassPropertyItems            %NewClassDataIsRef                    %NewClassPropertyItems            %NewClassDataSize %                   %NewClassPropertyItems            %NewClassDataDim1 %                   %NewClassPropertyItems            %NewClassDataDim2 %                   %NewClassPropertyItems            %NewClassDataDim3 %                   %NewClassPropertyItems            %NewClassDataDim4 %                   %NewClassPropertyItems            %ClassMethods                   %ClassItem            %ClassMethodName %                   %ClassMethods            %ClassMethodPrototype %                   %ClassMethods            %ClassPropertyItems                   %ClassItem            %ClassProperty %                   %ClassPropertyItems            %ClassDataType %                   %ClassPropertyItems                 Default           %ClassOtherType %                   %ClassPropertyItems            %ClassDataIsRef                    %ClassPropertyItems            %ClassDataSize %                   %ClassPropertyItems            %ClassDataDim1 %                   %ClassPropertyItems            %ClassDataDim2 %                   %ClassPropertyItems            %ClassDataDim3 %                   %ClassPropertyItems            %ClassDataDim4 %                   %ClassPropertyItems            %LocalEnable                               %InitializeServerVariables                            
   %ErrorVar "             5忷ф彿H�蚸澞�       %ExecuteCodeError %             .   .       .   MESSAGE('Error:'&LOC:Error,'AppConnect Error')       %ExecuteCodeSucceeded %                                    %ExecuteCodeNotConnected %             9   9       9   MESSAGE('The Client is not connected','AppConnect Error')        1   SVQuickAppConnectSupport$SVQuickAppConnectServer    ����                     %ConnectionAction %                          Start����                     %ConnectionAction %                          Stop����                     %ConnectionAction %                          Initialize Information        1   SVQuickAppConnectSupport$SVQuickAppConnectClient    ����
                     %ConnectionAction %                          Connect����                     %ConnectionAction %             
   
       
   Disconnect        7   SVQuickAppConnectSupport$SVQuickAppConnectClientAction    ����                     %ChatAction %                          BroadcastNotification       %MessageContent "             :�"�垉B�=�?R7U       %NotificationCode "             璢兽oJ蔕國.喷d�       %UseRecipient "                  
   %ErrorVar "             5忷ф彿H�蚸澞�       %DisableGlobalCodeError                                %DisableGlobalCodeNotConnected                             "   %DisableGlobalCodeActionSucceeded                        ����                     %ChatAction %                          Shutdown       %MessageContent "             :�"�垉B�=�?R7U       %NotificationCode "             璢兽oJ蔕國.喷d�       %UseRecipient "                  
   %ErrorVar "             5忷ф彿H�蚸澞�       %DisableGlobalCodeError                                %DisableGlobalCodeNotConnected                             "   %DisableGlobalCodeActionSucceeded                        ����                     %ChatAction %                          Notify       %MessageContent "             洡eg妃I�"O牘<�       %NotificationCode "             璢兽oJ蔕國.喷d�       %UseRecipient "             �+�
�=馟旷G"�!f    
   %ErrorVar "             5忷ф彿H�蚸澞�       %DisableGlobalCodeError                                %DisableGlobalCodeNotConnected                             "   %DisableGlobalCodeActionSucceeded                        ����                     %ChatAction %                          Notify       %MessageContent "             :�"�垉B�=�?R7U       %NotificationCode "             璢兽oJ蔕國.喷d�       %UseRecipient "             �+�
�=馟旷G"�!f    
   %ErrorVar "             5忷ф彿H�蚸澞�       %DisableGlobalCodeError                                %DisableGlobalCodeNotConnected                             "   %DisableGlobalCodeActionSucceeded                        ����	                     %ChatAction %                          Message       %MessageContent "             :�"�垉B�=�?R7U       %NotificationCode "                     %UseRecipient "             �+�
�=馟旷G"�!f       %DisableGlobalCodeError                                %DisableGlobalCodeNotConnected                             "   %DisableGlobalCodeActionSucceeded                                   ABC$CancelButton    ����                           ABC$WindowResize    ����            7          %UseAppStrategy %                          1       %AppStrategy %                          Surface       %RestrictMinSize                               %WindowMinWidth %                          0       %WindowMaxWidth %                          0       %ClassItem %                            Default       %DefaultBaseClassType %                   %ClassItem                 Default             WindowResizeClass       %ActualDefaultBaseClassType %                   %ClassItem                 Default                       %ClassLines %                  %ClassItem                 Default   }   }       }   Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)       %WindowMinHeight %                                    %RestrictMaxSize                                %WindowMaxHeight %                                    %AutoFindParents %                          Default       %DeferMoves %                          Default       %OverrideControls                        %OverrideControl %                   %OverrideControls            %DisableResize                    %OverrideControls            %HorizResize %                   %OverrideControls            %VertResize %                   %OverrideControls            %HorizPositional %                   %OverrideControls            %VertPositional %                   %OverrideControls            %GlobalObject %                   %ClassItem                 Default             NO       %ThisObjectName %                   %ClassItem                 Default             Resizer       %UseDefaultABCBaseClass                    %ClassItem                 Default                 %UseABCBaseClass                    %ClassItem                 Default                 %ABCBaseClass %                   %ClassItem                 Default                       %ExtBaseClass %                   %ClassItem            %BaseClassIncludeFile %                   %ClassItem            %DeriveFromBaseClass                    %ClassItem                 Default                  %NewMethods                   %ClassItem            %NewMethodName %                   %NewMethods            %NewMethodPrototype %                   %NewMethods            %NewClassPropertyItems                   %ClassItem            %NewClassProperty %                   %NewClassPropertyItems            %NewClassDataType %                   %NewClassPropertyItems                 Default           %NewClassOtherType %                   %NewClassPropertyItems            %NewClassDataIsRef                    %NewClassPropertyItems            %NewClassDataSize %                   %NewClassPropertyItems            %NewClassDataDim1 %                   %NewClassPropertyItems            %NewClassDataDim2 %                   %NewClassPropertyItems            %NewClassDataDim3 %                   %NewClassPropertyItems            %NewClassDataDim4 %                   %NewClassPropertyItems            %ClassMethods                   %ClassItem            %ClassMethodName %                   %ClassMethods            %ClassMethodPrototype %                   %ClassMethods            %ClassPropertyItems                   %ClassItem            %ClassProperty %                   %ClassPropertyItems            %ClassDataType %                   %ClassPropertyItems                 Default           %ClassOtherType %                   %ClassPropertyItems            %ClassDataIsRef                    %ClassPropertyItems            %ClassDataSize %                   %ClassPropertyItems            %ClassDataDim1 %                   %ClassPropertyItems            %ClassDataDim2 %                   %ClassPropertyItems            %ClassDataDim3 %                   %ClassPropertyItems            %ClassDataDim4 %                   %ClassPropertyItems               %ResizeAnchorTop                 	   %Control            %ResizeAnchorLeft                 	   %Control            %ResizeAnchorRight                 	   %Control            %ResizeAnchorBottom                 	   %Control            %ResizeAnchorGrowTop                 	   %Control            %ResizeAnchorGrowLeft                 	   %Control            %ResizeAnchorGrowRight                 	   %Control            %ResizeAnchorGrowBottom                 	   %Control     )�≌?驝嫚恿U�#~^燾f羖E墇\��   :�"�垉B�=�?R7U璢兽oJ蔕國.喷d侣+�
�=馟旷G"�!f5忷ф彿H�蚸澞贈�eg妃I�"O牘<鷢x4婣茎唔'蓂z�吰嗽麮�65AC�tE鏃�&L烩溑頪(vE�Y戤橬�#"轇旙pv�CqZ犞_�IlE�,槒	wXO徎J�'浾土j殼CVf聎し疻]xD�謘艑7N诬E�-怋厕c脐滪|瀬涱�
貲lた魆鬎纛�墴郉嶳�$軫�蕍-鴢褽偓攩��屧�\0N瓜釻墿`�                                                                                                                                                       .  F纛�墴郉嶳�$軫�         )���"       樷V �1     溻V �1               MessageTime �                                                                      @t1                Message Time:        Message Time                                                                             c    PROMPT('Message Time:'),USE(?LQM:MessageTime:Prompt)
 ENTRY(@t1),USE(LQM:MessageTime),RIGHT(1)
     -    STRING(@t1),USE(LQM:MessageTime),RIGHT(1)
                                                                                    j   )�≌?驝嫚恿U�# D      D  P���"       犫V �1     ｂV �1        �          %ButtonAction %                	   %Control                                 No Special Action             ?BUTTONClear             No Special Action             ?BUTTONSendQueue             No Special Action             ?BrodcastNotifyButton             No Special Action             ?BrodcastShutdownButton             No Special Action             ?Close             No Special Action             ?NotifyButton             No Special Action             ?ResetServerInfoButton             No Special Action             ?SHEET1             No Special Action             ?SendButton             No Special Action             ?StartClientButton             No Special Action             ?StartServerButton             No Special Action             ?StopClientButton             No Special Action             ?StopServerButton             No Special Action
   
       
   ?TABServer             No Special Action       %ButtonRunName %                	   %Control            %ButtonRunParameters %                	   %Control            %ButtonProcedure                  	   %Control            %ButtonThread                 	   %Control            %ButtonThreadStack %                	   %Control                           ╝               ?BUTTONClear             25000             ?BUTTONSendQueue             25000             ?BrodcastNotifyButton             25000             ?BrodcastShutdownButton             25000             ?Close             25000             ?NotifyButton             25000             ?ResetServerInfoButton             25000             ?SHEET1             25000             ?SendButton             25000             ?StartClientButton             25000             ?StartServerButton             25000             ?StopClientButton             25000             ?StopServerButton             25000
   
       
   ?TABServer             25000       %ButtonParameters %                	   %Control            %ButtonRequest %                	   %Control                                 None             ?BUTTONClear             None             ?BUTTONSendQueue             None             ?BrodcastNotifyButton             None             ?BrodcastShutdownButton             None             ?Close             None             ?NotifyButton             None             ?ResetServerInfoButton             None             ?SHEET1             None             ?SendButton             None             ?StartClientButton             None             ?StartServerButton             None             ?StopClientButton             None             ?StopServerButton             None
   
       
   ?TABServer             None       %PreLookupKey #                	   %Control            %PreLookupField $                	   %Control            %PreLookupProcedure                  	   %Control            %PostLookupKey #                	   %Control            %PostLookupField $                	   %Control            %PostLookupProcedure                  	   %Control            %ForceWindowRefresh                 	   %Control            %ClassItem %                            Default             WindowToolbar       %DefaultBaseClassType %                   %ClassItem                 Default             WindowManager             WindowToolbar             ToolbarClass       %ActualDefaultBaseClassType %                   %ClassItem                 Default                             WindowToolbar                       %ClassLines %                  %ClassItem                 Default   4   4       4   Init                   PROCEDURE(),BYTE,PROC,DERIVED4   4       4   Kill                   PROCEDURE(),BYTE,PROC,DERIVED4   4       4   TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED4   4       4   TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED       %ReturnValue "                     %ProcedureOneInstance                                %WindowOperationMode %                          Use WINDOW setting       %INISaveWindow                               %ProcedureDisableEnhanceFocus                             %   %ProcedureUseEnterInsteadTabOverride                                %WindowUseEnterInsteadTab                            -   %ProcedureUseEnterInsteadTabExcludeListCombo                             .   %ProcedureUseEnterInsteadTabEnableNextTabStop                             %   %ProcedureUseEnterInsteadTabExcludeG                            !   %WindowUseEnterInsteadTabExclude %                       %GlobalObject %                   %ClassItem                 Default             NO             WindowToolbar             NO       %ThisObjectName %                   %ClassItem                 Default
   
       
   ThisWindow             WindowToolbar             Toolbar       %UseDefaultABCBaseClass                    %ClassItem                 Default                       WindowToolbar                 %UseABCBaseClass                    %ClassItem                 Default                       WindowToolbar                 %ABCBaseClass %                   %ClassItem                 Default                             WindowToolbar                       %ExtBaseClass %                   %ClassItem            %BaseClassIncludeFile %                   %ClassItem            %DeriveFromBaseClass                    %ClassItem                 Default                        WindowToolbar                  %NewMethods                   %ClassItem            %NewMethodName %                   %NewMethods            %NewMethodPrototype %                   %NewMethods            %NewClassPropertyItems                   %ClassItem            %NewClassProperty %                   %NewClassPropertyItems            %NewClassDataType %                   %NewClassPropertyItems                 Default                 WindowToolbar           %NewClassOtherType %                   %NewClassPropertyItems            %NewClassDataIsRef                    %NewClassPropertyItems            %NewClassDataSize %                   %NewClassPropertyItems            %NewClassDataDim1 %                   %NewClassPropertyItems            %NewClassDataDim2 %                   %NewClassPropertyItems            %NewClassDataDim3 %                   %NewClassPropertyItems            %NewClassDataDim4 %                   %NewClassPropertyItems            %ClassMethods                   %ClassItem            %ClassMethodName %                   %ClassMethods            %ClassMethodPrototype %                   %ClassMethods            %ClassPropertyItems                   %ClassItem            %ClassProperty %                   %ClassPropertyItems            %ClassDataType %                   %ClassPropertyItems                 Default                 WindowToolbar           %ClassOtherType %                   %ClassPropertyItems            %ClassDataIsRef                    %ClassPropertyItems            %ClassDataSize %                   %ClassPropertyItems            %ClassDataDim1 %                   %ClassPropertyItems            %ClassDataDim2 %                   %ClassPropertyItems            %ClassDataDim3 %                   %ClassPropertyItems            %ClassDataDim4 %                   %ClassPropertyItems            %WindowStyles                        %WindowStyleFontName %                   %WindowStyles            %WindowStyleFontNameVariable %                   %WindowStyles            %WindowStyleFontNameIsVariable                    %WindowStyles            %WindowStyleFontSize %                   %WindowStyles            %WindowStyleFontSizeVariable %                   %WindowStyles            %WindowStyleFontSizeIsVariable                    %WindowStyles            %WindowStyleFontStyle %                   %WindowStyles            %WindowStyleFontStyleVariable %                   %WindowStyles             %WindowStyleFontStyleIsVariable                    %WindowStyles            %WindowStyleFontColor %                   %WindowStyles            %WindowStyleFontCharSet %                   %WindowStyles            %WindowStyleForegroundNormal                    %WindowStyles         %   %WindowStyleForegroundNormalVariable %                   %WindowStyles         '   %WindowStyleForegroundNormalIsVariable                    %WindowStyles            %WindowStyleBackgroundNormal                    %WindowStyles         %   %WindowStyleBackgroundNormalVariable %                   %WindowStyles         '   %WindowStyleBackgroundNormalIsVariable                    %WindowStyles            %WindowStyleForegroundSelected                    %WindowStyles         '   %WindowStyleForegroundSelectedVariable %                   %WindowStyles         )   %WindowStyleForegroundSelectedIsVariable                    %WindowStyles            %WindowStyleBackgroundSelected                    %WindowStyles         '   %WindowStyleBackgroundSelectedVariable %                   %WindowStyles         )   %WindowStyleBackgroundSelectedIsVariable                    %WindowStyles            %WindowStylePicture %                   %WindowStyles            %WindowStylePictureVariable %                   %WindowStyles            %WindowStylePictureIsVariable                    %WindowStyles            %WindowStyleOtherListboxes %                       %ProcedureAutoBindFields                        %ProcedureAutoBindField %                   %ProcedureAutoBindFields            %ProcedureAutoBindFieldTPL %                   %ProcedureAutoBindFields            %ProcedureAutoBindProcedures                        %ProcedureAutoBindProcedure %                   %ProcedureAutoBindProcedures            %ProcedureAutoBindProcedureTPL %                   %ProcedureAutoBindProcedures             %ProcedureAutoBindFieldsIgnored                        %ProcedureAutoBindFieldIgnored %                    %ProcedureAutoBindFieldsIgnored         $   %ProcedureAutoBindProceduresIgnored                     #   %ProcedureAutoBindProcedureIgnored %                $   %ProcedureAutoBindProceduresIgnored         "   %ProcedureAutoBindValidToAddField                                %ProcedureUserBindFields                        %ProcedureUserBindField "                   %ProcedureUserBindFields            %ProcedureAutoBindFieldIgnore                    %ProcedureAutoBindFields            %ProcedureUserBindProcedures                        %ProcedureUserBindProcedure                     %ProcedureUserBindProcedures         "   %ProcedureAutoBindProcedureIgnore                    %ProcedureAutoBindProcedures            %ProcedureUserBindExpressions                     !   %ProcedureUserBindExpressionName %                   %ProcedureUserBindExpressions            %ProcedureUserBindExpression %                   %ProcedureUserBindExpressions            %ExtUITabIcon %                	   %Control            %ExtUITabStyleOverrideGlobal                 	   %Control                 ?SHEET1                  %ExtUITabStyle %                	   %Control                                 Default             ?BUTTONSendQueue             Default             ?SHEET1             Default
   
       
   ?TABServer             Default       %FieldGradientColorType %                	   %Control                                 Off             ?BUTTONSendQueue             Off             ?SHEET1             Off
   
       
   ?TABServer             Off        %FieldGradientColorTypeVariable %                	   %Control                                                 ?BUTTONSendQueue                             ?SHEET1                
   
       
   ?TABServer                    "   %FieldGradientColorTypeIsVariable                 	   %Control                                            ?BUTTONSendQueue                        ?SHEET1           
   
       
   ?TABServer                  %FieldGradientColorFrom                 	   %Control                           ����             ?BUTTONSendQueue       ����             ?SHEET1       ����
   
       
   ?TABServer       ����        %FieldGradientColorFromVariable %                	   %Control         "   %FieldGradientColorFromIsVariable                 	   %Control                                            ?BUTTONSendQueue                        ?SHEET1           
   
       
   ?TABServer                  %FieldGradientColorTo                 	   %Control                           ����             ?BUTTONSendQueue       ����             ?SHEET1       ����
   
       
   ?TABServer       ����       %FieldGradientColorToVariable %                	   %Control             %FieldGradientColorToIsVariable                 	   %Control                                            ?BUTTONSendQueue                        ?SHEET1           
   
       
   ?TABServer                  %ButtonReturnValueAssignment "                	   %Control         "   %ButtonReturnValueReferenceAssign                 	   %Control            %ButtonThreadParameters %                	   %Control         #   %ButtonThreadReturnValueAssignment "                	   %Control            %PreLookupProcedureParameters %                	   %Control            %PostLookupProcedureParameters %                	   %Control            %PostLookupDuringValidate                 	   %Control 
                                          ?BUTTONSendQueue                       ?GLO:Client_Name                       ?GLO:Client_Pwd                       ?GLO:Server_Ip:2                       ?GLO:Server_Name                       ?GLO:Server_Port:2                       ?LOC:NotificationCode                       ?SHEET1          
   
       
   ?TABServer                 %LookupAssign                	   %Control            %MoreTarget "                   %LookupAssign            %MoreField %                   %LookupAssign            %CheckedAssigns                	   %Control            %CheckedAssignVariable "                   %CheckedAssigns            %CheckedAssignValue %                   %CheckedAssigns            %CheckedHides                	   %Control            %CheckedControl %                   %CheckedHides            %CheckedControlAction %                   %CheckedHides                                     ?BUTTONSendQueue                 ?SHEET1    
   
       
   ?TABServer           %CheckedEnables                	   %Control            %CheckedControl1 %                   %CheckedEnables            %CheckedControl1Action %                   %CheckedEnables                                     ?BUTTONSendQueue                 ?SHEET1    
   
       
   ?TABServer           %UncheckedAssigns                	   %Control            %UncheckedAssignVariable "                   %UncheckedAssigns            %UncheckedAssignValue %                   %UncheckedAssigns            %UnCheckedHides                	   %Control            %UnCheckedControl %                   %UnCheckedHides            %UnCheckedControlAction %                   %UnCheckedHides                                     ?BUTTONSendQueue                 ?SHEET1    
   
       
   ?TABServer           %UnCheckedEnables                	   %Control            %UnCheckedControl1 %                   %UnCheckedEnables            %UnCheckedControl1Action %                   %UnCheckedEnables                                     ?BUTTONSendQueue                 ?SHEET1    
   
       
   ?TABServer           %CheckedDisables                	   %Control            %CheckedDisableControl %                   %CheckedDisables            %CheckedDisableControlAction %                   %CheckedDisables                                     ?BUTTONSendQueue                 ?SHEET1    
   
       
   ?TABServer           %UnCheckedDisables                	   %Control            %UnCheckedDisableControl %                   %UnCheckedDisables            %UnCheckedDisableControlAction %                   %UnCheckedDisables                                     ?BUTTONSendQueue                 ?SHEET1    
   
       
   ?TABServer                                                                                     �  琯翚L昍錴~贴         沈��"       ｂV �1     ｂV �1                    {         �   �   �
	   	
   
�   �!(�68@   Z�	     �   �   1      �'   (.   3A;   ^L   �   �   �   ��%       �   �   �]   �   �& e   l   �   � w   
      �   9   ��    `�   �
 �      $   C      ��   `�   �� �   Z   %   E   
   �	   
&    ��   ��   �� �   Z   2      
   �	6   
F    ��   �   ��   ��
 �      2   C      ��   `�   ��
      >   C      �   `�	   �� 8  Z   ?   z   
   �	V   
f    ��
   ��	 <  �   %   	   �B  �   ����	 Y  *   V   �f  �   ��	 y  ,   �   ��  �   ��	 �  u   �   .   ��  ,�   ��	 �  u   V   0   ��  ,�   �� �  
   n   �   *   ��   `�   �
 �     z   C      �  `�   ��   T   y   t   
   �	v   
�    ��   ��
 "     �   C      �3  `�   �� J  T   �   t   
   �	�   
�    ��   ������& N  S  �   � E   �   �      �	�   
�    ��   ��
 ^     �   /   �k  `�   �� E   �   m      �	�   
�    �/
   4�  5	�   
�    ��	  
   ���   ��	 �  E   �   @      ��  (�  3�   �� 
      �   d   ��  34�  5	$  
.   ��	>  
N   �	^  
n   ���   ��
 �     �   /   ��  `�   ��
    
   �   �  `�   �� 0  E   �      
   �	~  
�   �   ��   ��	 3  �   �   O      �:  3�   ��	 H  E   �   @      �Y  3�   ��	 o  �   �   O      ��  3�    ��	 �  �   �   O   ��  �!   ��	 �  
   �   2      ��  �"   ��������    �  Chat Segoe UI Semibold Main &Close ?Close WACANCEL.ICO Cancel Operation Cancel Operation ?SHEET1 Server ?TABServer Server Information ?ServerInfGroup Server Ip: ?GLO:Server_Ip:Prompt:2 S50 ?GLO:Server_Ip:2 P<<<#P ?GLO:Server_Port:2 Server Port: ?GLO:Server_Port:Prompt:2 Server Name: ?GLO:Server_Name:Prompt s20 Reset ?ResetServerInfoButton Start Server ?StartServerButton Start Client ?StartClientButton Stop Client ?StopClientButton Stop Server ?StopServerButton Client Information ?ClientInfoGROUP Client Name: ?GLO:Client_Name:Prompt s20 Client Password: ?GLO:Client_Pwd:Prompt s16 Chat ?TABClient Message Out: ?LOC:MessageOut:Prompt 80L(2)|M@s20@ &Send ?SendButton WAOK.ICO ?MessageList [80L(2)|M@s100@/1020L(2)|M@s255@]| Message To: ?LOC:MessageOut:Prompt:2 Notification Code: ?LOC:NotificationCode:Prompt n3 Notify ?NotifyButton Broadcast Notify ?BrodcastNotifyButton Broadcast Shutdown ?BrodcastShutdownButton Send data in a GROUP ?BUTTONSendQueue Clear ?BUTTONClear     �  QuickWindow ?Cancel GLO:Server_Ip 叅D枈
欳�	B(�.镝GLO:Server_Port J�&d驚嶏鰌抅 婫LO:Server_Name �5z轨5^B�\石"%鸊LO:Client_Name q釕曝Dⅳ盍2GLO:Client_Pwd iOE釉|N�9凪�:LOC:MessageOut :�"�垉B�=�?R7ULOC:ToUserName �+�
�=馟旷G"�!flQUsers 旙pv�CqZ犞UserName _�IlE�,槒lQMessage 胀羓殼CVf翷QM:MessageFrom wし疻]xD�謘艑7NLQM:MessageText 诬E�-怋厕c脐滪|LOC:NotificationCode 璢兽oJ蔕國.喷d�                                                                                                                                                                                                          p   �8P�1恇C俒鶐挢勀         ���"       E釼 �1     :骎 �1                                                               ABC$ABC         s �1 汊V       溻V �1          q釕曝Dⅳ盍2iOE釉|N�9凪�:�5z轨5^B�\石"%鸍�&d驚嶏鰌抅 媴枈
欳�	B(�.镝                        .  胀羓殼CVf�         K���"       嬧V �1     溻V �1            
   lQMessage �m                           LQM                                            @s20                l QM essage:        l QM essage                                                                             N    PROMPT('l QM essage:'),USE(?lQMessage:Prompt)
 ENTRY(@s20),USE(lQMessage)
         STRING(@s20),USE(lQMessage)
                                                                                                                      f   尓�;K佊礚�vU         堽��"       ?釼 �1     ＄V �1            C  #system win32 exe
#model clarion lib
#pragma define(_ABCDllMode_=>0) -- GENERATED
#pragma define(_ABCLinkMode_=>1) -- GENERATED
#compile "QuickChat.clw" -- GENERATED
#compile "QuickChatMain.clw" -- GENERATED
#compile "QuickChat_BC0.CLW" -- GENERATED
#compile "QUICKCHAT_BC.CLW" -- GENERATED
#link "QuickChat.EXE"
                                                                                                                                          .  wし疻]xD�謘艑7N         5���"       忊V �1     溻V �1               MessageFrom �e                                                                        @s100                Message From:        Message From                                                                             \    PROMPT('Message From:'),USE(?LQM:MessageFrom:Prompt)
 ENTRY(@s100),USE(LQM:MessageFrom)
     &    STRING(@s100),USE(LQM:MessageFrom)
                                                                                               .  E�Y戤橬�#"轇         濑��"       }釼 �1     ｂV �1                �                                                                                                                                                                                                                                                                                                                                                                                                                                                                        .  洡eg妃I�"O牘<�         ���"       q釼 �1     汊V �1               LOC:GroupOfData �                                                                       @s20                LOC : Group Of Data:        LOC : Group Of Data                                                                             b    PROMPT('LOC : Group Of Data:'),USE(?LOC:GroupOfData:Prompt)
 ENTRY(@s20),USE(LOC:GroupOfData)
     %    STRING(@s20),USE(LOC:GroupOfData)
                                                                          .  _�IlE�,槒         Y���"       勨V �1     溻V �1            	   UserName �                                                                        @s20                User Name:     
   User Name                                                                             J    PROMPT('User Name:'),USE(?UserName:Prompt)
 ENTRY(@s20),USE(UserName)
         STRING(@s20),USE(UserName)
                                                                                                                                    .  �吰嗽麮�65AC�t         K���"       w釼 �1     溻V �1               ClientName �                                                                        @s20                Client Name:        Client Name                                                                             P    PROMPT('Client Name:'),USE(?ClientName:Prompt)
 ENTRY(@s20),USE(ClientName)
          STRING(@s20),USE(ClientName)
                                                                                                                      .  iOE釉|N�9凪�:         ,���"       X釼 �1     汊V �1               GLO:Client_Pwd �                                                                        @s16                GLO : Client Pwd:        GLO : Client Pwd                                                                             ]    PROMPT('GLO : Client Pwd:'),USE(?GLO:Client_Pwd:Prompt)
 ENTRY(@s16),USE(GLO:Client_Pwd)
     $    STRING(@s16),USE(GLO:Client_Pwd)
                                                                                        .  �x4婣茎唔'蓂z         3���"       t釼 �1     溻V �1               ClientAddress ��                                                                        @s250                Client Address:        Client Address                                                                             Z    PROMPT('Client Address:'),USE(?ClientAddress:Prompt)
 ENTRY(@s250),USE(ClientAddress)
     $    STRING(@s250),USE(ClientAddress)
                                                                                              .  E鏃�&L烩溑頪(v         D���"       z釼 �1     溻V �1            	   ClientId �                                                                      @n-14                Client Id:     
   Client Id                                                                             T    PROMPT('Client Id:'),USE(?ClientId:Prompt)
 ENTRY(@n-14),USE(ClientId),RIGHT(1)
     (    STRING(@n-14),USE(ClientId),RIGHT(1)
                                                                                                               .  �+�
�=馟旷G"�!f         &���"       i釼 �1     汊V �1               LOC:ToUserName �                                                                        @s20                LOC : To User Name:        LOC : To User Name                                                                             _    PROMPT('LOC : To User Name:'),USE(?LOC:ToUserName:Prompt)
 ENTRY(@s20),USE(LOC:ToUserName)
     $    STRING(@s20),USE(LOC:ToUserName)
                                                                                 j   匧玣蝓廜揔璸
"x�         ��"       C釼 �1     ｂV �1                  %SaveCreateLocalMap %                          1       %GenerationCompleted %                   %Module                 QuickChat.clw             1             QuickChatMain.clw             1       %LastTarget32 %                          1       %LastProgramExtension %                          EXE       %LastApplicationDebug %                                    %LastApplicationLocalLibrary %                          1                                                                                                                                                                                                                                                         .  5忷ф彿H�蚸澞�         E���"       l釼 �1     汊V �1            
   LOC:Error �                                                                      @n-14                Error:        LOC : Error                                                                             S    PROMPT('Error:'),USE(?LOC:Error:Prompt)
 STRING(@n-14),USE(LOC:Error),RIGHT(1)
     )    STRING(@n-14),USE(LOC:Error),RIGHT(1)
                                                                                                                                            