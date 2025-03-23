@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel - Consumption Entity'
@Metadata.ignorePropagatedAnnotations: true

@Metadata.allowExtensions: true         //delegando elementos de UI al METADATA
@Search.searchable: true                    //activando la capacidad avanzada de la BD HANA
define root view entity z349_c_travel_578
    provider contract transactional_query       //para operaciones SELECT
  as projection on z349_r_travel_578
{
  key TravelUUID,
      //definiendo elementos sobre los cuales buscar el mismo que se visualizará en la UI
      @Search.defaultSearchElement: true
      TravelID,
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: [ 'AgencyName' ]
      //vinculando la AYUDA de BUSQUEDA para el AgencyID, asimismo, se asegura que lo ingresado por el usuario
      //se encuentre en la interface I_Agency_StdVH, si no coincide salta un error. La validación salta en la UI, mas no, en APIs
      @Consumption.valueHelpDefinition: [{  entity: { name: '/DMO/I_Agency_StdVH',
                                                                                element: 'AgencyID' }, 
                                                                      useForValidation: true }]
      AgencyID,
      _Agency.Name as AgencyName, 
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
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,
      /* Associations */
      _Agency,
      _Booking,
      _Currency,
      _Customer,
      _OverStatus
}
