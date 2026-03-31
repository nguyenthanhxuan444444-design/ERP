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
    BWBH: TEdit;
    Button2: TButton;
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
    DBGrid1: TDBGridEh;
    UpXXZLS: TUpdateSQL;
    temp: TQuery;
    XXZLSuserid: TStringField;
    Label1: TLabel;
    Edit1: TEdit;
    XXZLSQty: TFloatField;
    XXZLSARTICLE: TStringField;
    XXZLSDIFF: TFloatField;
    XXZLSbzcc: TStringField;
    XXZLSFormula: TStringField;
    XXZLSVariance: TFloatField;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure BB4Click(Sender: TObject);
    procedure BB5Click(Sender: TObject);
    procedure DBGrid1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure bbt6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BomUsing: TBomUsing;

implementation

uses main1, XieXing1;

{$R *.dfm}

function EvalSimple(const Expr: string): Double;
var
  s: string;
  i: Integer;
  num: Double;
  op: Char;

  function ReadNumber: Double;
  var
    start: Integer;
    t: string;
  begin
    while (i <= Length(s)) and (s[i] = ' ') do Inc(i);
    start := i;
    while (i <= Length(s)) and (s[i] in ['0'..'9', '.', ',']) do Inc(i);
    t := Copy(s, start, i - start);
    t := StringReplace(t, ',', '.', [rfReplaceAll]);
    if t = '' then
      raise Exception.Create('Thieu so trong cong thuc');
    Result := StrToFloat(t);
  end;

begin
  s := Trim(Expr);
  if s = '' then
    raise Exception.Create('Cong thuc rong');

  i := 1;
  Result := ReadNumber;

  while i <= Length(s) do
  begin
    while (i <= Length(s)) and (s[i] = ' ') do Inc(i);
    if i > Length(s) then Break;

    op := s[i];
    if not (op in ['+','-','*','/']) then
      raise Exception.Create('Ky tu khong hop le: ' + op);
    Inc(i);

    num := ReadNumber;

    case op of
      '+': Result := Result + num;
      '-': Result := Result - num;
      '*': Result := Result * num;
      '/':
        begin
          if num = 0 then
            raise Exception.Create('Chia cho 0');
          Result := Result / num;
        end;
    end;
  end;
end;

procedure TBomUsing.FormDestroy(Sender: TObject);
begin
  BomUsing := Nil;
end;

procedure TBomUsing.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := cafree;
end;

procedure TBomUsing.Button2Click(Sender: TObject);
begin
  if Edit1.text = '' then
  begin
    showmessage('Please input Article');
    abort;
  end;

  with temp do
  begin
    Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Insert into MaterialCBD_BomUsing');
    SQL.Add('SELECT');
    SQL.Add('  CASE');
    SQL.Add('    WHEN CHARINDEX(''-'', XXZL.ARTICLE) > 0');
    SQL.Add('    THEN LEFT(XXZL.ARTICLE, CHARINDEX(''-'', XXZL.ARTICLE) - 1)');
    SQL.Add('    ELSE XXZL.ARTICLE');
    SQL.Add('  END AS ARTICLE,');
    SQL.Add('  x.BWBH,');
    SQL.Add('  ''0'',''0'',');
    SQL.Add('  ''system'',');
    SQL.Add('  MAX(x.USERDATE)');
    SQL.Add('FROM dbo.XXZL');
    SQL.Add('LEFT JOIN XXZLS x ON XXZL.XieXing = x.XieXing');
    SQL.Add('WHERE');
    SQL.Add('  (CASE');
    SQL.Add('     WHEN CHARINDEX(''-'', XXZL.ARTICLE) > 0');
    SQL.Add('     THEN LEFT(XXZL.ARTICLE, CHARINDEX(''-'', XXZL.ARTICLE) - 1)');
    SQL.Add('     ELSE XXZL.ARTICLE');
    SQL.Add('   END) = ''' + Trim(Edit1.Text) + '''');
    SQL.Add('  AND NOT EXISTS (');
    SQL.Add('      SELECT 1');
    SQL.Add('      FROM dbo.MaterialCBD_BomUsing n');
    SQL.Add('      WHERE n.ARTICLE =');
    SQL.Add('        (CASE');
    SQL.Add('           WHEN CHARINDEX(''-'', XXZL.ARTICLE) > 0');
    SQL.Add('           THEN LEFT(XXZL.ARTICLE, CHARINDEX(''-'', XXZL.ARTICLE) - 1)');
    SQL.Add('           ELSE XXZL.ARTICLE');
    SQL.Add('         END)');
    SQL.Add('        AND n.BWBH = x.BWBH');
    SQL.Add('  )');
    SQL.Add('GROUP BY');
    SQL.Add('  (CASE');
    SQL.Add('     WHEN CHARINDEX(''-'', XXZL.ARTICLE) > 0');
    SQL.Add('     THEN LEFT(XXZL.ARTICLE, CHARINDEX(''-'', XXZL.ARTICLE) - 1)');
    SQL.Add('     ELSE XXZL.ARTICLE');
    SQL.Add('   END),');
    SQL.Add('  x.BWBH');

    ExecSQL;
  end;

  with XXZLS do
  begin
    Active := false;
    SQL.Clear;
    {SQL.Add('select distinct xxzl.ARTICLE, XXZLS.XH, XXZLS.BWBH, BWZL.ywsm BWMC, XXZLS.CLBH,');
    SQL.Add('       CLZL.YWPM as CLMC, CLZL.ZWPM as CLZW,');
    SQL.Add('       CLZL.DWBH, CLZL.LYCC,XXZLS.CLSL,Round(MaterialCBD_BomUsing.Qty,4) as Qty,MaterialCBD_BomUsing.Formula,Round(MaterialCBD_BomUsing.Qty-XXZLS.CLSL,4) as DIFF, XXZLS.LOSS, ZSZL.ZSYWJC, CLZL.CLZMLB, ');
    SQL.Add('       XXZLS.CCQQ, XXZLS.CCQZ, XXZLS.userdate, XXZLS.BWLB,');
    SQL.Add('        xxzls.USERID,XXZLS.USERDATE, ''Assembly'' as DType, BWZL.zwsm as BWZW, LBZLS.BZ,xxzl.bzcc, ((MaterialCBD_BomUsing.Qty-XXZLS.CLSL)/XXZLS.CLSL*100) as Variance ');
    SQL.Add('FROM XXZLS');
    SQL.Add('left join xxzl on xxzl.XieXing=xxzls.XieXing and xxzl.SheHao=xxzls.SheHao');
    SQL.Add('LEFT JOIN BWZL  ON XXZLS.BWBH = BWZL.bwdh');
    SQL.Add('LEFT JOIN CLZL  ON XXZLS.CLBH = CLZL.cldh');
    SQL.Add('LEFT JOIN LBZLS ON SUBSTRING(XXZLS.CLBH,1,1) = LBZLS.lbdh AND LBZLS.LB=''13''');
    SQL.Add('LEFT JOIN ZSZL  on ZSZL.ZSDH=XXZLS.CSBH');
    SQL.Add('LEFT JOIN MaterialCBD_BomUsing');
    SQL.Add('  ON MaterialCBD_BomUsing.BWBH = XXZLS.BWBH');
    SQL.Add(' AND MaterialCBD_BomUsing.ARTICLE =');
    SQL.Add('     CASE');
    SQL.Add('       WHEN CHARINDEX(''-'', XXZL.ARTICLE) > 0');
    SQL.Add('         THEN LEFT(XXZL.ARTICLE, CHARINDEX(''-'', XXZL.ARTICLE) - 1)');
    SQL.Add('       ELSE XXZL.ARTICLE');
    SQL.Add('     END');
    SQL.Add('where XXZL.ARTICLE like ''%' + Trim(Edit1.Text) + '%'' and xxzls.BWBH like''%'+BWBH.text+'%''');
    SQL.Add('ORDER BY XXZLS.BWBH');  }

SQL.Add('select distinct xxzl.ARTICLE, XXZLS.XH, XXZLS.BWBH, BWZL.ywsm BWMC, XXZLS.CLBH,');
SQL.Add('       CLZL.YWPM as CLMC, CLZL.ZWPM as CLZW,');
SQL.Add('       CLZL.DWBH, CLZL.LYCC, XXZLS.CLSL,');
SQL.Add('       Round(MaterialCBD_BomUsing.Qty,4) as Qty, MaterialCBD_BomUsing.Formula,');
SQL.Add('       Round(MaterialCBD_BomUsing.Qty-XXZLS.CLSL,4) as DIFF,');
SQL.Add('       XXZLS.LOSS, ZSZL.ZSYWJC, CLZL.CLZMLB,');
SQL.Add('       XXZLS.CCQQ, XXZLS.CCQZ, XXZLS.userdate, XXZLS.BWLB,');
SQL.Add('       XXZLS.USERID, XXZLS.USERDATE, ''Assembly'' as DType, BWZL.zwsm as BWZW, LBZLS.BZ, xxzl.bzcc,');
SQL.Add('       CASE');
SQL.Add('         WHEN MaterialCBD_BomUsing.Qty IS NULL OR MaterialCBD_BomUsing.Qty = 0 THEN NULL');
SQL.Add('         WHEN XXZLS.CLSL IS NULL OR XXZLS.CLSL = 0 THEN NULL');
SQL.Add('         ELSE ((MaterialCBD_BomUsing.Qty - XXZLS.CLSL) / XXZLS.CLSL) * 100');
SQL.Add('       END as Variance');
SQL.Add('FROM XXZLS');
SQL.Add('left join xxzl on xxzl.XieXing=xxzls.XieXing and xxzl.SheHao=xxzls.SheHao');
SQL.Add('LEFT JOIN BWZL  ON XXZLS.BWBH = BWZL.bwdh');
SQL.Add('LEFT JOIN CLZL  ON XXZLS.CLBH = CLZL.cldh');
SQL.Add('LEFT JOIN LBZLS ON SUBSTRING(XXZLS.CLBH,1,1) = LBZLS.lbdh AND LBZLS.LB=''13''');
SQL.Add('LEFT JOIN ZSZL  on ZSZL.ZSDH=XXZLS.CSBH');
SQL.Add('LEFT JOIN MaterialCBD_BomUsing');
SQL.Add('  ON MaterialCBD_BomUsing.BWBH = XXZLS.BWBH');
SQL.Add(' AND MaterialCBD_BomUsing.ARTICLE =');
SQL.Add('     CASE');
SQL.Add('       WHEN CHARINDEX(''-'', XXZL.ARTICLE) > 0');
SQL.Add('         THEN LEFT(XXZL.ARTICLE, CHARINDEX(''-'', XXZL.ARTICLE) - 1)');
SQL.Add('       ELSE XXZL.ARTICLE');
SQL.Add('     END');
SQL.Add('where XXZL.ARTICLE like ''%' + Trim(Edit1.Text) + '%'' and xxzls.BWBH like ''%' + BWBH.Text + '%''');
SQL.Add('ORDER BY XXZLS.BWBH');


    Active := true;
  end;
end;

procedure TBomUsing.BB4Click(Sender: TObject);
begin
  if XXZLS.Active = true then
  begin
    with XXZLS do
    begin
      cachedupdates := true;
      requestlive := true;
      edit;
    end;
    BB5.Enabled := true;
    BB6.Enabled := true;
  end;
end;

procedure TBomUsing.BB5Click(Sender: TObject);
var
  F: string;
  V: Double;
begin
  // luu du lieu, neu co Formula thi tinh Qty = ket qua Formula
  with XXZLS do
  begin
    First;
    while not EOF do
    begin
      if UpdateStatus = usModified then
      begin
        if not (State in [dsEdit, dsInsert]) then Edit;

        // lay cong thuc tu field Formula (field nay da co: XXZLSFormula)
        F := Trim(FieldByName('Formula').AsString);

        // neu formula khong rong thi tinh Qty
        if F <> '' then
        begin
          try
            // tinh cong thuc dang don gian: + - * / (khong ngoac)
            V := EvalSimple(F);
            FieldByName('Qty').AsFloat := V;
          except
            on E: Exception do
            begin
              ShowMessage('Cong thuc khong hop le: ' + F + #13#10 + E.Message);
              Exit;
            end;
          end;
        end;

        FieldByName('USERID').AsString := Main.Edit1.Text;
        Post;

        // UpXXZLS can cap nhat ca Formula va Qty trong SQL update
        UpXXZLS.Apply(ukModify);
      end;
      Next;
    end;
  end;

  XXZLS.active := false;
  XXZLS.cachedupdates := false;
  XXZLS.requestlive := false;
  XXZLS.active := true;
  BB5.Enabled := false;
  BB6.Enabled := false;
end;

procedure TBomUsing.DBGrid1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  if XXZLS.FieldByName('CLSL').value > XXZLS.FieldByName('Qty').value then
    dbgrid1.canvas.font.color := clred;
end;

procedure TBomUsing.bbt6Click(Sender: TObject);
var
  eclApp, WorkBook: olevariant;
  i, j: integer;
begin
  if XXZLS.active then
  begin
    try
      eclApp := CreateOleObject('Excel.Application');
      WorkBook := CreateOleObject('Excel.Sheet');
    except
      Application.MessageBox('No Microsoft   Excel', 'Microsoft   Excel', MB_OK+MB_ICONWarning);
      Exit;
    end;
    try
      WorkBook := eclApp.workbooks.Add;
      for i := 0 to XXZLS.fieldcount-1 do
      begin
        eclApp.Cells(1,i+1) := XXZLS.fields[i].FieldName;
      end;

      XXZLS.First;
      j := 2;
      while not XXZLS.Eof do
      begin
        for i := 0 to XXZLS.fieldcount-1 do
        begin
          eclApp.Cells(j,i+1) := XXZLS.Fields[i].Value;
        end;
        XXZLS.Next;
        inc(j);
      end;
      eclapp.columns.autofit;
      eclApp.ActiveSheet.Columns[6].ColumnWidth := 50;
      eclApp.ActiveSheet.Columns[7].ColumnWidth := 50;
      showmessage('Succeed');
      eclApp.Visible := True;

    except
      on F: Exception do
        showmessage(F.Message);
    end;
  end;
end;

end.

