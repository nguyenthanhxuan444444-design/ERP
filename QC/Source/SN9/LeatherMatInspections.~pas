unit LeatherMatInspections;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBTables, DB, GridsEh, DBGridEh, Mask, DBCtrls, ComCtrls,
  StdCtrls, Buttons, ExtCtrls;

type
  TLeatherMatInspection = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    BB1: TBitBtn;
    BB2: TBitBtn;
    BB3: TBitBtn;
    BB4: TBitBtn;
    BB5: TBitBtn;
    BB6: TBitBtn;
    Button1: TButton;
    bbt6: TBitBtn;
    edtPONo: TEdit;
    bExcel: TBitBtn;
    bExF: TBitBtn;
    cbPDF: TCheckBox;
    edtZSBH: TEdit;
    ckUSERDate: TCheckBox;
    dtpUSERDate: TDateTimePicker;
    MenuCode: TEdit;
    edtRID: TEdit;
    dtpTime: TDateTimePicker;
    edtStyle: TEdit;
    edtMatName: TEdit;
    btClear: TButton;
    ckTime: TCheckBox;
    DBGrid1: TDBGridEh;
    Query1: TQuery;
    DS1: TDataSource;
    UpSQL1: TUpdateSQL;
    Qtemp: TQuery;
    OpenDialog1: TOpenDialog;
    SaveDialog: TSaveDialog;
    QGetID: TQuery;
    QSig: TQuery;
    OpenPictureDialog1: TOpenDialog;
    Query1ReportID: TIntegerField;
    Query1Cont: TStringField;
    Query1Time: TDateTimeField;
    Query1IQty: TStringField;
    Query1MatName: TStringField;
    Query1PONo: TStringField;
    Query1ThickStand: TStringField;
    Query1Reality: TStringField;
    Query1Color: TStringField;
    Query1AA: TStringField;
    Query1BB: TStringField;
    Query1CC: TStringField;
    Query1DD: TStringField;
    Query1Grade: TStringField;
    Query1TotalSF: TFloatField;
    Query1PercentGrade: TIntegerField;
    Query1UseSF: TFloatField;
    Query1PercentNCU: TIntegerField;
    Query1CompenSF: TFloatField;
    Query1TestCon: TStringField;
    Query1IsCompen: TStringField;
    Query1CompenQty: TStringField;
    Query1SCFID: TStringField;
    Query1SCFDate: TDateTimeField;
    Query1LCFID: TStringField;
    Query1LCFDate: TDateTimeField;
    Query1PreparedID: TStringField;
    Query1PreparedDate: TDateTimeField;
    Query1USERID: TStringField;
    Query1USERDate: TDateTimeField;
    Query1MSCFID: TStringField;
    Query1MSCFDate: TDateTimeField;
    Query1YN: TIntegerField;
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure SetColumnsReadOnly;
    procedure BB1Click(Sender: TObject);
    procedure BB3Click(Sender: TObject);
    procedure BB5Click(Sender: TObject);
    procedure BB4Click(Sender: TObject);
    function NewID: string;
    procedure Query1AfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LeatherMatInspection: TLeatherMatInspection;

implementation

uses main1;

{$R *.dfm}

function TLeatherMatInspection.NewID: string;
var
  Prefix, LastID: string;
  Seq: Integer;
begin
  Prefix := FormatDateTime('yymm', Date);

  with QGetID do
  begin
    Active := false;
    SQL.Clear;
    SQL.Add(
      'select top 1 ReportID ' +
      'from QC_LeatherInspec ' +
      'where left(ReportID, 4) = :P ' +
      'order by ReportID desc');
    ParamByName('P').AsString := Prefix;
    Active := true;
  end;

  if QGetID.IsEmpty then
    Seq := 1
  else
  begin
    LastID := QGetID.FieldByName('ReportID').AsString;
    Seq := StrToInt(Copy(LastID, 5, 4)) + 1;
  end;

  Result := Prefix + FormatFloat('0000', Seq);
end;

procedure TLeatherMatInspection.SetColumnsReadOnly;
begin
  if MenuCode.Text = 'N981' then
  begin
  DBGrid1.FieldColumns['ReportID'].ReadOnly      := True;
  DBGrid1.FieldColumns['SCFID'].ReadOnly         := True;
  DBGrid1.FieldColumns['SCFDate'].ReadOnly       := True;
  DBGrid1.FieldColumns['LCFID'].ReadOnly         := True;
  DBGrid1.FieldColumns['LCFDate'].ReadOnly       := True;
  DBGrid1.FieldColumns['PreparedID'].ReadOnly    := True;
  DBGrid1.FieldColumns['PreparedDate'].ReadOnly  := True;
  DBGrid1.FieldColumns['USERID'].ReadOnly        := True;
  DBGrid1.FieldColumns['USERDate'].ReadOnly      := True;
  DBGrid1.FieldColumns['MSCFID'].ReadOnly        := True;
  DBGrid1.FieldColumns['MSCFDate'].ReadOnly      := True;
  end;

  if MenuCode.Text = 'N982' then
  begin
  DBGrid1.FieldColumns['ReportID'].ReadOnly      := True;
  DBGrid1.FieldColumns['Cont'].ReadOnly          := True;
  DBGrid1.FieldColumns['Time'].ReadOnly          := True;
  DBGrid1.FieldColumns['IQty'].ReadOnly          := True;
  DBGrid1.FieldColumns['MatName'].ReadOnly       := True;
  DBGrid1.FieldColumns['PONo'].ReadOnly          := True;
  DBGrid1.FieldColumns['ThickStand'].ReadOnly    := True;
  DBGrid1.FieldColumns['Reality'].ReadOnly       := True;
  DBGrid1.FieldColumns['Color'].ReadOnly         := True;
  DBGrid1.FieldColumns['AA'].ReadOnly            := True;
  DBGrid1.FieldColumns['BB'].ReadOnly            := True;
  DBGrid1.FieldColumns['CC'].ReadOnly            := True;
  DBGrid1.FieldColumns['DD'].ReadOnly            := True;
  DBGrid1.FieldColumns['Grade'].ReadOnly         := True;
  DBGrid1.FieldColumns['TotalSF'].ReadOnly       := True;
  DBGrid1.FieldColumns['PercentGrade'].ReadOnly  := True;
  DBGrid1.FieldColumns['PercentNCU'].ReadOnly    := True;
  DBGrid1.FieldColumns['TestCon'].ReadOnly       := True;
  DBGrid1.FieldColumns['IsCompen'].ReadOnly      := True;
  DBGrid1.FieldColumns['CompenQty'].ReadOnly     := True;
  DBGrid1.FieldColumns['SCFDate'].ReadOnly       := True;
  DBGrid1.FieldColumns['LCFID'].ReadOnly         := True;
  DBGrid1.FieldColumns['LCFDate'].ReadOnly       := True;
  DBGrid1.FieldColumns['PreparedID'].ReadOnly    := True;
  DBGrid1.FieldColumns['PreparedDate'].ReadOnly  := True;
  DBGrid1.FieldColumns['USERID'].ReadOnly        := True;
  DBGrid1.FieldColumns['USERDate'].ReadOnly      := True;
  DBGrid1.FieldColumns['MSCFID'].ReadOnly        := True;
  DBGrid1.FieldColumns['MSCFDate'].ReadOnly      := True;
  end;
  if MenuCode.Text = 'N983' then
  begin
  DBGrid1.FieldColumns['ReportID'].ReadOnly      := True;
  DBGrid1.FieldColumns['Cont'].ReadOnly          := True;
  DBGrid1.FieldColumns['Time'].ReadOnly          := True;
  DBGrid1.FieldColumns['IQty'].ReadOnly          := True;
  DBGrid1.FieldColumns['MatName'].ReadOnly       := True;
  DBGrid1.FieldColumns['PONo'].ReadOnly          := True;
  DBGrid1.FieldColumns['ThickStand'].ReadOnly    := True;
  DBGrid1.FieldColumns['Reality'].ReadOnly       := True;
  DBGrid1.FieldColumns['Color'].ReadOnly         := True;
  DBGrid1.FieldColumns['AA'].ReadOnly            := True;
  DBGrid1.FieldColumns['BB'].ReadOnly            := True;
  DBGrid1.FieldColumns['CC'].ReadOnly            := True;
  DBGrid1.FieldColumns['DD'].ReadOnly            := True;
  DBGrid1.FieldColumns['Grade'].ReadOnly         := True;
  DBGrid1.FieldColumns['TotalSF'].ReadOnly       := True;
  DBGrid1.FieldColumns['PercentGrade'].ReadOnly  := True;
  DBGrid1.FieldColumns['PercentNCU'].ReadOnly    := True;
  DBGrid1.FieldColumns['TestCon'].ReadOnly       := True;
  DBGrid1.FieldColumns['IsCompen'].ReadOnly      := True;
  DBGrid1.FieldColumns['CompenQty'].ReadOnly     := True;
  DBGrid1.FieldColumns['SCFID'].ReadOnly         := True;
  DBGrid1.FieldColumns['SCFDate'].ReadOnly       := True;
  DBGrid1.FieldColumns['LCFDate'].ReadOnly       := True;
  DBGrid1.FieldColumns['PreparedID'].ReadOnly    := True;
  DBGrid1.FieldColumns['PreparedDate'].ReadOnly  := True;
  DBGrid1.FieldColumns['USERID'].ReadOnly        := True;
  DBGrid1.FieldColumns['USERDate'].ReadOnly      := True;
  DBGrid1.FieldColumns['MSCFID'].ReadOnly        := True;
  DBGrid1.FieldColumns['MSCFDate'].ReadOnly      := True;
  end;
  if MenuCode.Text = 'N984' then
  begin
  DBGrid1.FieldColumns['ReportID'].ReadOnly      := True;
  DBGrid1.FieldColumns['Cont'].ReadOnly          := True;
  DBGrid1.FieldColumns['Time'].ReadOnly          := True;
  DBGrid1.FieldColumns['IQty'].ReadOnly          := True;
  DBGrid1.FieldColumns['MatName'].ReadOnly       := True;
  DBGrid1.FieldColumns['PONo'].ReadOnly          := True;
  DBGrid1.FieldColumns['ThickStand'].ReadOnly    := True;
  DBGrid1.FieldColumns['Reality'].ReadOnly       := True;
  DBGrid1.FieldColumns['Color'].ReadOnly         := True;
  DBGrid1.FieldColumns['AA'].ReadOnly            := True;
  DBGrid1.FieldColumns['BB'].ReadOnly            := True;
  DBGrid1.FieldColumns['CC'].ReadOnly            := True;
  DBGrid1.FieldColumns['DD'].ReadOnly            := True;
  DBGrid1.FieldColumns['Grade'].ReadOnly         := True;
  DBGrid1.FieldColumns['TotalSF'].ReadOnly       := True;
  DBGrid1.FieldColumns['PercentGrade'].ReadOnly  := True;
  DBGrid1.FieldColumns['PercentNCU'].ReadOnly    := True;
  DBGrid1.FieldColumns['TestCon'].ReadOnly       := True;
  DBGrid1.FieldColumns['IsCompen'].ReadOnly      := True;
  DBGrid1.FieldColumns['CompenQty'].ReadOnly     := True;
  DBGrid1.FieldColumns['SCFID'].ReadOnly         := True;
  DBGrid1.FieldColumns['SCFDate'].ReadOnly       := True;
  DBGrid1.FieldColumns['MSCFDate'].ReadOnly      := True;
  DBGrid1.FieldColumns['LCFID'].ReadOnly         := True;
  DBGrid1.FieldColumns['LCFDate'].ReadOnly       := True;
  DBGrid1.FieldColumns['PreparedID'].ReadOnly    := True;
  DBGrid1.FieldColumns['PreparedDate'].ReadOnly  := True;
  DBGrid1.FieldColumns['USERID'].ReadOnly        := True;
  DBGrid1.FieldColumns['USERDate'].ReadOnly      := True;
  end;
end;

procedure TLeatherMatInspection.DBGrid1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if DBGrid1.SelectedField.FieldName = 'Grade' then
  begin
    // chan het ky tu ngoai tru Enter de mo picklist
    Key := #0;
  end;
end;

procedure TLeatherMatInspection.Button1Click(Sender: TObject);
begin
 SetColumnsReadOnly;
 with Query1 do
 begin
  Active:=false;
  SQL.Clear;
  SQL.Add('SELECT ReportID, Cont, Time, IQty, MatName, PONo,');
  SQL.Add('ThickStand, Reality, Color, AA, BB, CC, DD, Grade, TotalSF, PercentGrade,');
  SQL.Add('CONVERT(numeric(18,2), TotalSF*PercentGrade/100) as UseSF, PercentNCU,');
  SQL.Add('CONVERT(numeric(18,2), (PercentGrade-PercentNCU)*TotalSF/100) as CompenSF,');
  SQL.Add('TestCon, IsCompen, CompenQty, SCFID, SCFDate, LCFID, LCFDate, PreparedID, ');
  SQL.Add('PreparedDate, USERID, USERDate, MSCFID, MSCFDate, YN');
  SQL.Add('FROM QC_LeatherInspec');
  SQL.Add('where 1=1 ');

  if edtPONo.Text <> '' then
  SQL.Add('and PONo like '''+edtPONo.Text+'%'' ');
  if edtRID.Text <> '' then
    SQL.Add('and ReportID like '''+edtRID.Text+'%'' ');
  if edtMatName.Text <> '' then
    SQL.Add('and MatName like '''+edtMatName.Text+'%'' ');
  if ckTime.Checked then
    SQL.Add('and CAST(Time as DATE) = '''+FormatDateTime('yyyy-mm-dd', dtpTime.Date)+''' ');
  if ckUSERDate.Checked then
    SQL.Add('and CAST(QC_ProMatFail.USERDate as DATE) = '''+FormatDateTime('yyyy-mm-dd', dtpUSERDate.Date)+''' ');

  SQL.Add('order by ReportID');
  Active:=true;
 end;
end;

procedure TLeatherMatInspection.BB1Click(Sender: TObject);
begin
  with query1 do
  begin
  RequestLive :=  true;
  CachedUpdates:= true;
  Insert;
  end;
bb4.enabled:=true;
bb5.enabled:=true;
end;

procedure TLeatherMatInspection.BB3Click(Sender: TObject);
begin
with query1 do
  begin
    cachedupdates:=true;
    requestlive:=true;
    query1.edit;
  end;
bb4.enabled:=true;
bb5.enabled:=true;
end;

procedure TLeatherMatInspection.BB5Click(Sender: TObject);
begin
  with Query1 do
  begin
    CachedUpdates := false;
    RequestLive := false;
    BB4.Enabled := false;
    BB5.Enabled := false;
    dbgrid1.ReadOnly := false;
  end;
end;

procedure TLeatherMatInspection.BB4Click(Sender: TObject);
var i: integer;
begin
  if not QGetID.Active then QGetID.Active;
  try
    query1.first;
    for i:=1 to query1.RecordCount do
      begin
        case query1.updatestatus of
          usinserted:
            begin
              if Query1.FieldByName('MatName').IsNull then
              begin
                query1.delete;
              end else
              begin
                Query1.Edit;
                Query1.FieldByName('ReportID').Value := NewID;
                Query1.FieldByName('USERID').Value := main.Edit1.Text;
                Query1.FieldByName('USERDate').Value := FormatDateTime('yyyy-mm-dd hh:nn:ss', Now);
                Query1.FieldByName('YN').Value := 1;
                upsql1.apply(ukinsert);
              end;
            end;
          usmodified:
             begin
               if query1.FieldByName('YN').value='0' then
                 begin
                   if messagedlg('Are you sure you want to delete?',mtconfirmation,[mbYes,mbNo],0)=mrYes then
                   begin
                    Query1.Edit;
                    Query1.FieldByName('USERID').Value := main.Edit1.Text;
                    UpSQL1.Apply(ukdelete)
                   end;
                 end else
                 begin
                  Query1.Edit;
                  if MenuCode.Text = 'N981' then
                    begin
                      Query1.FieldByName('USERID').Value := main.Edit1.Text;
                      Query1.FieldByName('USERDate').Value := FormatDateTime('yyyy-mm-dd hh:nn:ss', Now);
                    end;
                  if MenuCode.Text = 'N982' then
                    begin
                      Query1.FieldByName('SCFDate').Value := FormatDateTime('yyyy-mm-dd hh:nn:ss', Now);
                    end;
                  if MenuCode.Text = 'N983' then
                    begin
                      Query1.FieldByName('LCFDate').Value := FormatDateTime('yyyy-mm-dd hh:nn:ss', Now);
                    end;
                  if MenuCode.Text = 'N984' then
                    begin
                      Query1.FieldByName('MSCFDate').Value := FormatDateTime('yyyy-mm-dd hh:nn:ss', Now);
                    end;
                  upsql1.apply(ukmodify);
                 end;
              end;
        end;
        query1.next;
      end;
    query1.active:=false;
    query1.cachedupdates:=false;
    query1.requestlive:=false;
    query1.active:=true;
    bb4.enabled:=false;
    bb5.enabled:=false;
    dbgrid1.ReadOnly := false;
  except
   Messagedlg('Have wrong, can not save data!',mtwarning,[mbyes],0);
  end;
end;

procedure TLeatherMatInspection.Query1AfterOpen(DataSet: TDataSet);
begin
  BB1.Enabled:=true;
  BB2.Enabled:=true;
  BB3.Enabled:=true;
  bbt6.Enabled:=true;
  bExcel.Enabled := true;
  bExF.Enabled := true;
end;

end.
