unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdHTTP, Vcl.StdCtrls,

  FireDAC.Stan.Intf,  FireDAC.Stan.Option,  FireDAC.Stan.Param,  FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,

  DBGridEhGrouping,  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh,
  Vcl.OleCtrls, SHDocVw,
  EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh, Data.DB,

  FireDAC.Comp.DataSet, FireDAC.Comp.Client,

  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  System.JSON , UWrpAPI_Common, FireDAC.Stan.StorageJSON, Vcl.ComCtrls, FireDAC.Stan.StorageBin, IdHeaderList;

type
  TWrpDBAction = (dbaNone,dbaNew,dbaEdit,dbaDel);

  TForm1 = class(TForm)
    WrpAPI1: TWrpAPI;
    Memo1: TMemo;
    Edit1: TEdit;
    btnAPI_Get: TButton;
    FDMemTable1: TFDMemTable;
    DataSource1: TDataSource;
    DBGridEh1: TDBGridEh;
    btnAPI_PostAll: TButton;
    btnDataDelete: TButton;
    btnDataNew: TButton;
    btnDataEdit: TButton;
    btnDataPost: TButton;
    btnDataCancel: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    Button4: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    mmscript: TMemo;
    WebBrowser1: TWebBrowser;
    procedure WrpAPI1HostResponse(Response: TIdHTTPResponse; ResponseText, ReponseRawHeaderText: string);
    procedure btnAPI_GetClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAPI_PostAllClick(Sender: TObject);
    procedure FDMemTable1AfterDelete(DataSet: TDataSet);
    procedure btnDataNewClick(Sender: TObject);
    procedure btnDataEditClick(Sender: TObject);
    procedure btnDataDeleteClick(Sender: TObject);
    procedure btnDataCancelClick(Sender: TObject);
    procedure btnDataPostClick(Sender: TObject);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh; AFont: TFont; var Background: TColor;
      State: TGridDrawState);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FDMemTable1BeforePost(DataSet: TDataSet);
    procedure Button4Click(Sender: TObject);
  private
    DBAction : TWrpDBAction;
    IDAction : String;

    function CreateDatasetToJSon(goFirst,goNext : Boolean) : TStream;
    procedure PostDataToHost(vAction ,vID : String;Param : TStream);
    procedure PostToHost(vAction ,vID : String;Dataset : TDataset);
    procedure PreviewHTML(const HTMLCode: string);
    function dbStatePrompt(RecordMorethan0: Boolean): Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnAPI_GetClick(Sender: TObject);
begin
    // Delete All Records
    FDMemTable1.EmptyDataSet;
    Memo1.Lines.Clear;
    PreviewHTML('');

    WrpAPI1.Request.ContentType := 'application/json';
    WrpAPI1.API_Host := '';
    WrpAPI1.Request.Method := 'GET';
    WrpAPI1.ModeRedirect   := True;  // Google work with ReDirect
    WrpAPI1.SendToHost(Edit1.Text); // URL
end;

function TForm1.CreateDatasetToJSon(goFirst,goNext : Boolean) : TStream;
var rowData : String;
    JsonObj : TJSONObject; // System.JSON
    JsonArr : TJSONArray;
    JSonValue : TJSONValue;
    bStop,bNeedNext : Boolean;
begin
    bStop := False;

    if goFirst then
      FDMemTable1.First;

    JsonArr := TJSONArray.Create;

    While (NOT(FDMemTable1.EOF)) and (bStop = False)   Do
       begin
          // only dbAction <> ""
          if FDMemTable1.FieldByName('dbaction').AsString <> '' then
             begin
                  JsonObj := TJSONObject.Create;
                  JsonObj.AddPair('id',FDMemTable1.FieldbyName('ID').AsString);
                  JsonObj.AddPair('name',FDMemTable1.FieldbyName('NAME').AsString);
                  JsonObj.AddPair('lastname',FDMemTable1.FieldbyName('LASTNAME').AsString);
                  JsonObj.AddPair('tel',FDMemTable1.FieldbyName('TEL').AsString);
                  JsonObj.AddPair('pay',TJSONNumber.Create(FDMemTable1.FieldbyName('PAID').AsInteger));
                  JsonObj.AddPair('dbaction',FDMemTable1.FieldbyName('dbaction').AsString);

                  JsonArr.Add(JsonObj);

                  JsonObj := NIL;

                  if FDMemTable1.FieldByName('dbaction').AsString = 'del' then
                     begin
                        FDMemTable1.Delete;
                        bNeedNext := False;
                     end
                  else
                  begin
                     FDMemTable1.Edit;
                     FDMemTable1['dbaction'] := '';
                     FDMemTable1.post;

                     bNeedNext := True;
                  end;
             end;


          if (goNext and bNeedNext) then
             FDMemTable1.Next
          else
          bStop := True;
       end;

    if JsonArr.ToJSON = '[]' then
       JSonValue := TJSONString.Create('{"id : "0"}');

    JSonValue := TJSONObject.ParseJSONValue(JsonArr.ToJSON);
    Result := TStringStream.Create( JSonValue.ToJSON , TEncoding.UTF8);

    JSonValue := NIL;
end;

procedure TForm1.DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
    if FDMemTable1.FieldByName('dbaction').AsString = 'del' then
       begin
           AFont.Color := clgray;
       end
    else
    if FDMemTable1.FieldByName('dbaction').AsString = 'edit' then
       begin
           AFont.Color := clRed;
       end;

end;

procedure TForm1.btnAPI_PostAllClick(Sender: TObject);
begin
    Memo1.Lines.Clear;
    PreviewHTML('');

    PostDataToHost('up2date','0', CreateDatasetToJSon(True,True) );
end;

function TForm1.dbStatePrompt(RecordMorethan0 : Boolean) : Boolean;
begin
    Result := (FDMemTable1.State = dsBrowse);
    if RecordMorethan0 then
       Result := Result and (FDMemTable1.RecordCount > 0);
end;

procedure TForm1.btnDataDeleteClick(Sender: TObject);
begin
    if NOT dbStatePrompt(true) then Exit;

    if MessageDlg('¬◊π¬—π°“√≈∫ ‡√§§Õ√Ï¥ ?',
       TMsgDlgType.mtConfirmation,
       [TMsgDlgBtn.mbYes,TMsgDlgBtn.mbNo],0) = mrYES then
        begin
           FDMemTable1.Edit;
           FDMemTable1['dbaction'] := 'del';
           FDMemTable1.post;
        end;
end;

procedure TForm1.btnDataNewClick(Sender: TObject);
begin
    Memo1.Lines.Clear;
    PreviewHTML('');

    FDMemTable1.Append;
    FDMemTable1['dbaction'] := 'new';
end;

procedure TForm1.btnDataEditClick(Sender: TObject);
begin
    if NOT dbStatePrompt(true) then Exit;

    Memo1.Lines.Clear;
    PreviewHTML('');

    FDMemTable1.Edit;
    FDMemTable1['dbaction'] := 'edit';
end;

procedure TForm1.btnDataPostClick(Sender: TObject);
begin
    if FDMemTable1.State <> dsBrowse then
       FDMemTable1.Post;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
    FDMemTable1.Savetofile('D:\dbtemp.json',sfJSON);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    Memo1.Lines.Clear;
    PreviewHTML('');

    PostDataToHost('up2date','0', CreateDatasetToJSon(False,False) );
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
    FDMemTable1.EmptyDataSet;
    FDMemTable1.LoadFromFile('D:\dbtemp.json',sfJSON);
    FDMemTable1.Open;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
    tmpST : TStringStream;
    JSonValue : TJSonValue;
    Jsonstr : String;

begin
    // Delete All Records
    FDMemTable1.EmptyDataSet;
    Memo1.Lines.Clear;
    PreviewHTML('');
    Jsonstr := StringReplace(mmscript.Lines.Text,#9,'',[rfReplaceAll]);
    Jsonstr := Trim(StringReplace(Jsonstr,#$D#$A,'',[rfReplaceAll]));
    Jsonstr := Copy(Jsonstr,2,Length(Jsonstr)-2);

    JSonValue := TJSONObject.ParseJSONValue(Jsonstr) as TJSonObject;
    tmpST := TStringStream.create;
    tmpST := TStringStream.Create( JSonValue.ToJSON , TEncoding.UTF8);


    WrpAPI1.Request.ContentType := 'application/json';
    WrpAPI1.API_Host := '';
    WrpAPI1.Request.Method := 'POST';
    WrpAPI1.ModeRedirect   := False;
    WrpAPI1.SendToHost(Edit1.Text+'?',tmpST); // URL


end;

procedure TForm1.btnDataCancelClick(Sender: TObject);
begin
    if FDMemTable1.State <> dsBrowse then
       FDMemTable1.Cancel;
end;

procedure TForm1.PostDataToHost(vAction ,vID : String;Param : TStream);
begin
    Memo1.Lines.Clear;
    PreviewHTML('');

    WrpAPI1.Request.ContentType := 'application/json';
    WrpAPI1.Request.Method := 'POST';
    try
      WrpAPI1.SendToHost(Edit1.Text+'?action='+vAction+'&id='+vID,Param);
    finally
    end;
end;

procedure TForm1.PostToHost(vAction ,vID : String;Dataset : TDataset);
var bOK : Boolean;
begin
    bOK := False;
    if vAction = 'new' then
       bOK := True
    else
    // locate
    if ((POS('edit',vAction) > 0) or (POS('del',vAction) > 0)) and
        Dataset.Locate('id',vID,[loPartialKey])  then
       begin
          bOK := True;
       end;

    if bOK = True then
       PostDataToHost(vAction,vID, CreateDatasetToJSon(False,False) );

end;

procedure TForm1.FDMemTable1AfterDelete(DataSet: TDataSet);
begin
    IDAction := '';
    DBAction := dbaNone;
end;

procedure TForm1.FDMemTable1BeforePost(DataSet: TDataSet);
begin
    if (Dataset.State = dsInsert) AND (LowerCase(WrpAPI1.Request.Method) = 'post') then
       Dataset['dbaction'] := 'new';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    FDMemTable1.FieldDefs.Add('ID',ftString,10,True);
    FDMemTable1.FieldDefs.Add('NAME',ftString,60);
    FDMemTable1.FieldDefs.Add('LASTNAME',ftString,60);
    FDMemTable1.FieldDefs.Add('TEL',ftString,20);
    FDMemTable1.FieldDefs.Add('PAID',ftInteger,0);
    FDMemTable1.FieldDefs.Add('DBACTION',ftString,10);
    FDMemTable1.AddIndex('pkID','ID','',[TFDSortoption.soPrimary]);
    FDMemTable1.CreateDataSet;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
    FDMemTable1.Open;
    //FDMemTable1.Active;
end;

procedure TForm1.WrpAPI1HostResponse(Response: TIdHTTPResponse;
    ResponseText, ReponseRawHeaderText: string);


var JsonObj ,
    Row : TJSONObject;      //System.JSON
    ResponseObj : TJSonArray;
    JSonVal: TJSONValue;
    JSonpair : TJSONPair;
    ID , Name ,LastName,tel : String;
    pay ,
    xCount, i : Integer;
    KeyName  : String;
    Value    : Variant;
  J: Integer;

begin
    Memo1.Lines.Add('rawdata = '+ResponseText);
   // Memo1.Lines.Add('HEADER = '+ReponseRawHeaderText);
    //Memo1.Lines.Add('JSON = '+ResponseObj.ToString);

    Memo1.Lines.Add('Server >> '+IntToStr(Response.ResponseCode));

    if Response.ResponseCode = 200 then
       begin
          if (POS('<!doctype html>',LowerCase(ResponseText)) = 1) then
             begin
                if (POS(' §√‘ªµÏ∑”ß“π‡ √Á®',ResponseText) = 0) then
                    begin
                       PreviewHTML(ResponseText);
                    end
                else
                Memo1.Lines.Add('Server >> Success ...');
             end
          else
          begin

    // [{"id" : 123 , "name : " ¡™“¬"}]  Array
    ResponseObj := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(ResponseText), 0) as TJSonArray;

    for i := 0 to ResponseObj.Count-1 do  // QTY-Records
        begin
           JSonVal := ResponseObj.Items[i];
           if (JSonVal is TJSonValue) then
               begin
                  // get FieldCount
                  {xFieldCount := (JSonVal as TJSONObject).Count;
                  // Case You Dont Know
                  for J := 0 to xFieldCount-1 do
                      begin
                         KeyName  := ((JSonVal as TJSONObject).Pairs[J] as TJSonPair).Jsonstring.ToString;
                         Value    := ((JSonVal as TJSONObject).Pairs[J] as TJSonPair).JsonValue.Value;
                      end;
                   }

                  // Case You Know √ŸÈ«Ë“¡’ø‘≈¥ÏÕ–‰√∫È“ß
                  ID       := JSonVal.GetValue<string>('id');
                  Name     := JSonVal.GetValue<string>('name');
                  LastName := JSonVal.GetValue<string>('lastname');
                  tel      := JSonVal.GetValue<string>('tel');
                  pay := 0;
                  JSonVal.TryGetValue('pay',pay);
                  {
                  Memo1.Lines.Add('ID = '+ID+
                           ' Name = '+Name+
                           ' LastName = '+LastName +
                           ' Tel  = '+tel +
                           ' Paid = '+formatFloat('#,0',pay)
                           );   }

                  // Append To MemTable
                  FDMemTable1.Append; // add to last record
                  FDMemTable1['ID']       := ID;
                  FDMemTable1['NAME']     := Name;
                  FDMemTable1['LASTNAME'] := LastName;
                  FDMemTable1['TEL']      := tel;
                  FDMemTable1['PAID']     := pay;
                  FDMemTable1.Post;


               end;
        end;

          end;
       end;

end;

procedure TForm1.PreviewHTML(CONST HTMLCode: string);
var
  Doc: Variant;
begin
  if NOT Assigned(WebBrowser1.Document) then
     WebBrowser1.Navigate('about:blank');

  Doc := WebBrowser1.Document;
  Doc.Clear;
  Doc.Write(HTMLCode);
  Doc.Close;
end;

end.
