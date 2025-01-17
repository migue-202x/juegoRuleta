unit Type_ALMACEN;

interface

USES
  Sysutils, dateutils;

Const
  //movimientos ctacte
  _creacionCtaCte = 'Creacion de cuenta';
  _bajaCtaCte = 'Baja de la cuenta';
  _CompraFicha = 'Compra de fichas';
  _PremioJuego = 'Premio por juego nro. ';
  _RegaloCredito = 'Regalo de credito';
  _Apuesta = 'Apuesta juego N� ';


type
   tClave = string[8];
   tFecha = TDateTime;
   tConcepto = string[50];
   tImporte = 0..maxint;

   tipoRegAlmacen = record
        Nick: Type_ALMACEN.tClave;
        FechaHora: Type_ALMACEN.tFecha;
        Concepto: Type_ALMACEN.tConcepto;
        Debe, haber, saldo: Type_ALMACEN.tImporte;
       end;

   tipoArchAlmacen = file of TipoRegAlmacen; //Archivo donde se almacenan los datos de la cuenta corriente

   //Tipo de conceptos
  tipoConceptos = record
                    const Creacion_Cuenta = _creacionCtaCte;
                    const Baja_cuenta  = _bajaCtaCte;
                    const Compra_Fichas = _CompraFicha;
                    const Premio_Juego    = _PremioJuego;
                    const Credito_Regalado = _RegaloCredito;
                    const Numero_Apuesta = _Apuesta;
                 end;

implementation

end.



