unit MassPro_PrintCard1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls, DB, DBTables, jpeg, QRXMLSFilt,
  QRExport, QRPDFFilt, StdCtrls, IniFiles,fununit;


type
  TMassPro_PrintCard = class(TForm)
    QRPDFFilter1: TQRPDFFilter;
    QRXMLSFilter1: TQRXMLSFilter;
    QRCompositeReport1: TQRCompositeReport;
    QRExcelFilter1: TQRExcelFilter;
    QuickRep1: TQuickRep;
    ColumnHeaderBand2: TQRBand;
    PageHeaderBand2: TQRBand;
    QRLabel60: TQRLabel;
    QRLabel46: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRBand2: TQRBand;
    QRLabel1: TQRLabel;
    QRBand3: TQRBand;
    QRDBText5: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRLabel_ViTri: TQRLabel;
    QRAritcle: TQRDBText;
    QRCGBH: TQRDBText;
    QRDBText1: TQRDBText;
    QRLabel13: TQRLabel;
    QRDBText8: TQRDBText;
    QRLabel23: TQRLabel;
    QRDBText2: TQRDBText;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel28: TQRLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure QRCompositeReport1AddReports(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    ComName:String;
    ComNameCH:String;
    WarehouseN37_Card_ISO:string;
    procedure ReadIni();
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MassPro_PrintCard: TMassPro_PrintCard;

implementation

uses main1, StockShoeMonth1;

{$R *.dfm}

procedure TMassPro_PrintCard.ReadIni();
var MyIni :Tinifile;
    AppDir,DBIP,DBUser,DBPass,DBName:string;
begin
  ComName:='CONG TY TNHH TY BACH';
  ComNameCH:='億柏責任有限公司';
  WarehouseN37_Card_ISO:='T-KH-009A';
  //
  AppDir:=ExtractFilePath(Application.ExeName);
  if FileExists(AppDir+'\ComName.ini')=true then
  begin
    try
      MyIni := Tinifile.Create(AppDir+'\ComName.ini');
      ComName:=MyIni.ReadString('ERP','ComName','');
      ComNameCH:=MyIni.ReadString('ERP','ComNameCH','');
      WarehouseN37_Card_ISO:=MyIni.ReadString('ERP','WarehouseN37_Card_ISO','T-KH-009A');
    finally
      MyIni.Free;
    end;
  end;
  QRLabel1.Caption:= WarehouseN37_Card_ISO;
end;

procedure TMassPro_PrintCard.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
end;

procedure TMassPro_PrintCard.FormDestroy(Sender: TObject);
begin
  MassPro_PrintCard:=nil;
end;

procedure TMassPro_PrintCard.QRCompositeReport1AddReports(Sender: TObject);
begin
   MassPro_PrintCard.QRLabel60.Caption:=ComNameCH;
   MassPro_PrintCard.QRLabel46.Caption:=ComName;
end;

procedure TMassPro_PrintCard.FormCreate(Sender: TObject);
var year,month,day:word;
    sYear,sMonth,sDay:String;
begin
  ReadIni();
  decodedate(StockShoeMonth.DTP.Date,Year,Month,Day);   //找庫存相關的數據
  sYear:=floattostr(year);
  sMonth:=floattostr(month);
  if length(sMonth)=1 then
    sMonth:='0'+sMonth;
  QRLabel22.Caption:=' '+sYear+' 年 '+ sMonth+' 月存貨盤點卡';
  QRLabel21.Caption:='THE KIEM KE HANG TON THANG ' +sMonth+' NAM '+ sYear;
  QRLabel_Vitri.caption:='Kho thanh pham '+ StockShoeMonth.Query2.FieldByName('CKBH').Value;
  if StockShoeMonth.chkNgayKK.Checked then
  begin
    QRLabel28.Caption:=DateToStr(StockShoeMonth.DTPKK.Date);
  end else
  begin
    QRLabel28.Caption:=DateToStr(StockShoeMonth.DTP.Date);
  end;
end;


end.
