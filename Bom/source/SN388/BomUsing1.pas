unit BomUsing1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, StdCtrls, DB, DBTables, Buttons, ExtCtrls, Comobj,
  DBCtrls, ComCtrls;

type
  TBomUsing = class(TForm)
    Panel1: TPanel;
    BB2: TBitBtn;
    BB3: TBitBtn;
    BB4: TBitBtn;
    BB5: TBitBtn;
    BB6: TBitBtn;
    BB7: TBitBtn;
    BB1: TBitBtn;
    bbt6: TBitBtn;
    Button1: TButton;
    PC1: TPageControl;
    TS1: TTabSheet;
    Panel2: TPanel;
    Label5: TLabel;
    Label23: TLabel;
    BWBH: TEdit;
    Button2: TButton;
    Xiexing: TEdit;
    DS2: TDataSource;
    XXZLS: TQuery;
    XXZLSXH: TStringField;
    XXZLSBWBH: TStringField;
    XXZLSBWMC: TStringField;
    XXZLSCLBH: TStringField;
    XXZLSDType: TStringField;
    XXZLSCLMC: TStringField;
    XXZLSCLZW: TStringField;
    XXZLSBWZW: TStringField;
    XXZLSDWBH: TStringField;
    XXZLSLYCC: TStringField;
    XXZLSBZ: TStringField;
    XXZLSBWLB: TStringField;
    XXZLSZSYWJC: TStringField;
    XXZLSLOSS: TFloatField;
    XXZLSCLSL: TFloatField;
    XXZLSCCQQ: TStringField;
    XXZLSCCQZ: TStringField;
    XXZLSCLZMLB: TStringField;
    XXZLSuserdate: TDateTimeField;
    XXZLSCLBH_Log: TStringField;
    XXZLSCLSL_Log: TStringField;
    DBGrid1: TDBGridEh;
    UpXXZLS: TUpdateSQL;
    XXZLSXieXing: TStringField;
    XXZLSPrice: TFloatField;
    temp: TQuery;
    XXZLSuserid: TStringField;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure BB4Click(Sender: TObject);
    procedure BB5Click(Sender: TObject);
    procedure DBGrid1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BomUsing: TBomUsing;

implementation

uses main1;

{$R *.dfm}

procedure TBomUsing.FormDestroy(Sender: TObject);
begin
  BomUsing:=Nil;
end;

procedure TBomUsing.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=cafree;
end;

procedure TBomUsing.Button2Click(Sender: TObject);
begin
 if xiexing.text='' then
  begin
    showmessage('Please input Xiexing');
    abort;
  end;
 with temp do
begin
  Active := False;
  Close;
  SQL.Clear;

  SQL.Add('INSERT INTO dbo.MaterialCBD_BomUsing');
  SQL.Add('SELECT x.XieXing, x.BWBH, 0, ''system'', MAX(x.USERDATE)');
  SQL.Add('FROM dbo.XXZLS x');
  SQL.Add('WHERE x.XieXing = ''' + Trim(XieXing.Text) + '''');
  SQL.Add('  AND NOT EXISTS (');
  SQL.Add('      SELECT 1');
  SQL.Add('      FROM dbo.MaterialCBD_BomUsing n');
  SQL.Add('      WHERE n.XieXing = x.XieXing');
  SQL.Add('        AND n.BWBH    = x.BWBH');
  SQL.Add('  )');
  SQL.Add('GROUP BY x.XieXing, x.BWBH');

  ExecSQL;
end;


 with XXZLS do
     begin
       Active:=false;
       SQL.Clear;
       SQL.Add('select XXZLS.XH, XXZLS.BWBH,BWZL.ywsm BWMC,XXZLS.CLBH,''Assembly'' as DType,');
       SQL.Add('       CLZL.YWPM as CLMC, CLZL.ZWPM as CLZW,BWZL.zwsm  as BWZW,');
       SQL.Add('       CLZL.DWBH,CLZL.LYCC,LBZLS.BZ,XXZLS.BWLB,ZSZL.ZSYWJC,XXZLS.LOSS,XXZLS.CLSL,');
       SQL.Add('       XXZLS.CCQQ,XXZLS.CCQZ,CLZL.CLZMLB,XXZLS.userdate');
       SQL.Add('       ,(case when XXZLS.CLBH<>XXZLS_Log.CLBH then XXZLS_Log.Log_DateTime end) as ''CLBH_Log''');
       SQL.Add('       ,(case when XXZLS.CLSL<>XXZLS_Log.CLSL then XXZLS_Log.Log_DateTime end) as ''CLSL_Log''');
       SQL.Add('        ,MaterialCBD_BomUsing.Price,MaterialCBD_BomUsing.userid, xxzls.xiexing');
       SQL.Add('FROM XXZLS');
       SQL.Add('LEFT join (select XieXing,SheHao,BWBH,Max(CLBH) as CLBH,Max(CLSL) as CLSL,Max(Log_DateTime) as Log_DateTime from XXZLS_Log');
       SQL.Add('            where XXZLS_Log.XieXing='''+Xiexing.Text+'''');
       SQL.Add('           Group by XieXing,SheHao,BWBH');
       SQL.Add('          )  XXZLS_Log on XXZLS_Log.XieXing=XXZLS.XieXing and XXZLS_Log.SheHao=XXZLS.SheHao and XXZLS_Log.BWBH=XXZLS.BWBH');
       SQL.Add('LEFT JOIN BWZL  ON XXZLS.BWBH = BWZL.bwdh');
       SQL.Add('LEFT JOIN CLZL   ON XXZLS.CLBH = CLZL.cldh');
       SQL.Add('LEFT JOIN LBZLS ON SUBSTRING(XXZLS.CLBH,1,1) = LBZLS.lbdh AND LBZLS.LB=''13''');
       SQL.Add('LEFT JOIN ZSZL on ZSZL.ZSDH=XXZLS.CSBH');
       SQL.Add('LEFT JOIN MaterialCBD_BomUsing on MaterialCBD_BomUsing.XieXing =XXZLS.XieXing and MaterialCBD_BomUsing.BWBH=XXZLS.BWBH');
       SQL.Add('where XXZLS.XieXing like''%'+Xiexing.Text+'%''');
       SQL.Add('and XXZLS.BWBH like''%'+BWBH.Text+'%''');
       SQL.Add('ORDER BY XXZLS.BWBH');
       //funcObj.WriteErrorLog(sql.Text);
       Active:=true;
     end;
 end;
procedure TBomUsing.BB4Click(Sender: TObject);
begin
  if XXZLS.Active=true then
  begin
    with XXZLS do
    begin
      cachedupdates:=true;
      requestlive:=true;
      edit;
    end;
    BB5.Enabled:=true;
    BB6.Enabled:=true;
  end;
end;

procedure TBomUsing.BB5Click(Sender: TObject);
var i:integer;
begin
  //
with XXZLS do
begin
  First;
  while not EOF do
  begin
    if UpdateStatus = usModified then
    begin
      if not (State in [dsEdit, dsInsert]) then Edit;
      FieldByName('USERID').AsString := Main.Edit1.Text;
      Post;
      UpXXZLS.Apply(ukModify);
    end;
    Next;
  end;
end;
  //
  XXZLS.active:=false;
  XXZLS.cachedupdates:=false;
  XXZLS.requestlive:=false;
  XXZLS.active:=true;
  BB5.Enabled:=false;
  BB6.Enabled:=false;
  //
end;

procedure TBomUsing.DBGrid1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
if XXZLS.FieldByName('CLSL').value>XXZLS.FieldByName('Price').value then
  dbgrid1.canvas.font.color:=clred;
end;

end.
