unit BomUsing1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, StdCtrls, DB, DBTables, Buttons, ExtCtrls, Comobj;

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
    Panel4: TPanel;
    Label12: TLabel;
    Button3: TButton;
    Article: TEdit;
    DBGrid1: TDBGridEh;
    CLZLQry: TQuery;
    DS1: TDataSource;
    UpCLZL: TUpdateSQL;
    CLZLQryARTICLE: TStringField;
    CLZLQryXieXing: TStringField;
    CLZLQryBWBH: TStringField;
    CLZLQryUSERID: TStringField;
    CLZLQryUSERDATE: TDateTimeField;
    CB1: TCheckBox;
    CLZLQryPrice: TFloatField;
    Label1: TLabel;
    Label2: TLabel;
    BWBH: TEdit;
    Xiexing: TEdit;
    opendialog: TOpenDialog;
    Button1: TButton;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
    procedure BB4Click(Sender: TObject);
    procedure BB5Click(Sender: TObject);
    procedure bbt6Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
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

procedure TBomUsing.Button3Click(Sender: TObject);
begin
   with CLZLQry do
   begin
     Active:=false;
     SQL.Clear;
     SQL.Add('select * ');
     SQL.Add('from MaterialCBD_BomUsing');
     SQL.Add('where Article like ''%'+Article.Text+'%'' ');
     SQL.Add('and BWBH like ''%'+BWBH.Text+'%'' ');
     SQL.Add('and XieXing like ''%'+XieXing.Text+'%'' ');
     if cb1.Checked then  sql.Add('order by userdate,xiexing,Article desc')
     else
      SQL.Add('order by xiexing,Article ');
     Active:=true;
   end;
   BBT6.Enabled:=true;
end;

procedure TBomUsing.BB4Click(Sender: TObject);
begin
  if CLZLQry.Active=true then
  begin
    with CLZLQry do
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
  with CLZLQry do
  begin
    First;
    for i:=1 to RecordCount do
    begin
      case updatestatus of
       usmodified:
         UpCLZL.Apply(ukmodify);
       end;
      Next;
    end;
  end;
  //
  CLZLQry.active:=false;
  CLZLQry.cachedupdates:=false;
  CLZLQry.requestlive:=false;
  CLZLQry.active:=true;
  BB5.Enabled:=false;
  BB6.Enabled:=false;
  //
end;

procedure TBomUsing.bbt6Click(Sender: TObject);
var  eclApp,WorkBook:olevariant;
     i,j:integer;
begin
    if  CLZLQry.active  then
    begin
    try
      eclApp:=CreateOleObject('Excel.Application');
      WorkBook:=CreateOleObject('Excel.Sheet');
    except
      Application.MessageBox('No Microsoft   Excel','Microsoft   Excel',MB_OK+MB_ICONWarning);
      Exit;
    end;
    try
        WorkBook:=eclApp.workbooks.Add;
        for   i:=0   to   CLZLQry.fieldcount-1   do
        begin
            eclApp.Cells(1,i+1):=CLZLQry.fields[i].FieldName;
        end;

        CLZLQry.First;
        j:=2;
        while   not   CLZLQry.Eof   do
        begin
          for   i:=0   to  CLZLQry.fieldcount-1  do
          begin
            eclApp.Cells(j,i+1):=CLZLQry.Fields[i].Value;
          end;
        CLZLQry.Next;
        inc(j);
        end;
       eclapp.columns.autofit;
       showmessage('Succeed');
       eclApp.Visible:=True;

      except
        on   F:Exception   do
          showmessage(F.Message);
      end;
    end;

end;

procedure TBomUsing.Button1Click(Sender: TObject);
var ExcelApp: Variant;
    OrderExcFN,ColumnNM,ARTICLE,XieXing,BWBH,Price: string;
    Article_index,xiexing_index,bwbh_index, Price_index:integer;
    offset,RowSIndex:integer;
    Isbreak:boolean;
begin
  try
    ExcelApp:=CreateOleObject('Excel.Application');
  except
    on E:Exception do
    begin
      Application.MessageBox(PChar('NO EXCEL'+E.Message),'', MB_OK);
      Exit;
    end;
  end;
  //================================================================================
  try
    if OpenDialog.Execute=true then
    begin
      Article_index:=-1;
      xiexing_index:=-1;
      bwbh_index:=-1;
      Price_index:=-1;
      //
      OrderExcFN:=OpenDialog.FileName;
      ExcelApp.WorkBooks.Open(OpenDialog.FileName);
      ExcelApp.WorkSheets[1].Activate;
      //
      offset:=0;
      RowSIndex:=1;
      ColumnNM:=ExcelApp.Cells[RowSIndex+offset,1];
        if ColumnNM='ARTICLE' then Article_index:=1;
      ColumnNM:=ExcelApp.Cells[RowSIndex+offset,2];
        if ColumnNM='XieXing' then xiexing_index:=2;
      ColumnNM:=ExcelApp.Cells[RowSIndex+offset,3];
        if ColumnNM='BWBH' then bwbh_index:=3;
      ColumnNM:=ExcelApp.Cells[RowSIndex+offset,4];
        if ColumnNM='Price' then Price_index:=4;
      //
      if (Article_index>0) then
      begin
        Isbreak:=false;
        RowSIndex:=1;
        repeat
           Application.ProcessMessages;
           RowSIndex:=RowSIndex+1;
           ARTICLE:=ExcelApp.Cells[RowSIndex+offset,Article_index];
           XieXing:=ExcelApp.Cells[RowSIndex+offset,xiexing_index];
           BWBH:=ExcelApp.Cells[RowSIndex+offset,bwbh_index];
           Price:=ExcelApp.Cells[RowSIndex+offset,Price_index];
           //=========================================
           if (trim(ARTICLE)<>'') then
           begin
              CLZLQry.active:=false;
              CLZLQry.SQL.Clear;
              CLZLQry.SQL.Add('select * from MaterialCBD_BomUsing ');
              CLZLQry.SQL.Add('where Article like ''%'+ARTICLE+'%'' ');
              CLZLQry.SQL.Add('and BWBH like ''%'+BWBH+'%'' ');
              CLZLQry.SQL.Add('and XieXing like ''%'+XieXing+'%'' ');
              CLZLQry.Open;
              CLZLQry.active:=true;
              if CLZLQry.RecordCount>0 then
              begin
                  CLZLQry.active:=false;
                  CLZLQry.SQL.Clear;
                  CLZLQry.SQL.Add(' update MaterialCBD_BomUsing set Price='''+trim(Price)+'''  ');
                  CLZLQry.SQL.Add(' ,UserDate=getdate()');
                  CLZLQry.SQL.Add(' ,UserID ='''+main.Edit1.Text+''' ');
                  CLZLQry.SQL.Add(' where Article='''+trim(ARTICLE)+''' AND BWBH='''+trim(BWBH)+''' AND XieXing ='''+trim(XieXing)+''' ');
                  CLZLQry.ExecSQL;
              end else
              begin
                 CLZLQry.active:=false;
                 CLZLQry.SQL.Clear;
                 CLZLQry.SQL.Add(' insert into MaterialCBD_BomUsing(Article,XieXing,BWBH,Price,Userid,UserDate) ');
                 CLZLQry.SQL.Add(' values ('''+trim(ARTICLE)+''','''+trim(Xiexing)+''','''+trim(BWBH)+''','''+trim(Price)+''','''+main.Edit1.Text+''',getdate()) ');
                 CLZLQry.ExecSQL;
              end;
           end;
           //==========================================
           if (trim(ARTICLE)='') then  Isbreak:=true;
           //
        until IsBreak=true;
        //
        ExcelApp.WorkBooks.Close;
        ExcelApp.Quit;
        Showmessage('Success.');
      end else
      begin
        ExcelApp.WorkBooks.Close;
        ExcelApp.Quit;
        Showmessage('Excel not exact format!');
      end;
    end;
  except
    on E:Exception do
    begin
      Application.MessageBox(PChar('NO EXCEL'+E.Message),'', MB_OK);
      ExcelApp.WorkBooks.Close;
      ExcelApp.Quit;
      Exit;
    end;
  end;
end;

end.
