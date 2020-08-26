unit UFinalizaVenda;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.ListBox, FMX.Edit;

type
  TFrmFinaliza = class(TForm)
    Rectangle3: TRectangle;
    Label5: TLabel;
    ComboBox1: TComboBox;
    RectConfirma: TRectangle;
    Label9: TLabel;
    Label1: TLabel;
    EditValor: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    EditParcelas: TEdit;
    Label4: TLabel;
    EditVlrParcela: TEdit;
    procedure FormShow(Sender: TObject);
    procedure RectConfirmaClick(Sender: TObject);
    procedure ComboBox1Exit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    procedure FinalizaVenda;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFinaliza: TFrmFinaliza;

implementation

{$R *.fmx}

uses UDM, UMenu, UVenda;

procedure TFrmFinaliza.ComboBox1Exit(Sender: TObject);
begin

  if ComboBox1.Items[ComboBox1.ItemIndex] = 'A prazo' then
  begin
    Label3.Visible := True;
    Label4.Visible := True;
    EditParcelas.Visible := True;
    EditVlrParcela.Visible := True;
  end
  else
  begin
    Label3.Visible := false;
    Label4.Visible := false;
    EditParcelas.Visible := false;
    EditVlrParcela.Visible := false;
  end;
end;

procedure TFrmFinaliza.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  case Key of
    vkReturn:
      ShowMessage('Enter');
    vkF10:
      begin
        FinalizaVenda;
      end;
  end;
end;

procedure TFrmFinaliza.FinalizaVenda;
begin
  dm.FDQTpagamento.Locate('descricao',
    ComboBox1.Items[ComboBox1.ItemIndex], []);
  dm.FDQVenda.Edit;
  dm.FDQVendaVLR_TOTAL.AsFloat := StrToFloat(EditValor.Text);
  dm.FDQVendaID_TIPOPAGAMENTO.AsInteger := dm.FDQTpagamentoID.AsInteger;
  if dm.FDQTpagamentoDESCRICAO.AsString = 'A prazo' then
    dm.fdqvendaParcela.AsInteger := StrToInt(EditParcelas.Text);

  dm.FDQVenda.Post;
  dm.FDConnection1.CommitRetaining;

  //gerar contas

end;

procedure TFrmFinaliza.FormShow(Sender: TObject);
begin

  EditValor.Text := FloatToStr(FrmVenda.vl_total);

  dm.FDQTpagamento.Open();
  while not dm.FDQTpagamento.Eof do
  begin
    ComboBox1.Items.Add(dm.FDQTpagamentoDESCRICAO.AsString);
    dm.FDQTpagamento.Next;
  end;
end;

procedure TFrmFinaliza.RectConfirmaClick(Sender: TObject);
begin
  FinalizaVenda;
end;

end.
