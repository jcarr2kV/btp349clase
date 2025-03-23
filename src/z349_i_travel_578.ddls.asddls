@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel - Interface Entity'
@Metadata.ignorePropagatedAnnotations: true //TRUE: bloquea la HERENCIA o la PROPAGACION de las ANOTACIONES de las inferiores capas

//Definiendo la INTERFAZ RAIZ (root interface) como una PROYECCION de la ENTIDAD RAIZ (ESTADO TRANSACCIONAL)
define root view entity z349_i_travel_578
    provider contract transactional_interface       //Estado Transaccional -> esta dado por la CUD (create, update, delete)
                                                                                //para operaciones INSERT, UPDATE, DELETE, pero, no se va fructificar
                                                                                //si no le habilitamos el BEHAVIOR DEFINITION (BDEF)
    as projection on z349_r_travel_578
{
    key TravelUUID,
    TravelID,
    AgencyID,
    CustomerID,
    BeginDate,
    EndDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    BookingFee,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    TotalPrice,
    CurrencyCode,
    Description,
    OverallStatus,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    LocalLastChangedAt,
    @Semantics.systemDateTime.lastChangedAt : true
    LastChangedAt,
      
    /* Associations */
    _Agency,
    _Booking : redirected to composition child z349_i_booking_578,
    _Currency,
    _Customer,
    _OverStatus
}
