@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supplements - Consumption Entity'
@Metadata.ignorePropagatedAnnotations: true

@Metadata.allowExtensions: true         //delegando elementos de UI al METADATA
@Search.searchable: true                    //activando la capacidad avanzada de la BD HANA
define view entity z349_c_bookingsuppl_578
  as projection on z349_r_bookingsuppl_578
{
  key BooksupplUUID,
      TravelUUID,
      BookingUUID,
      
      @Search.defaultSearchElement: true
      BookingSupplementID,
      
      @ObjectModel.text.element: [ 'SupplementDescription' ]      
      @Consumption.valueHelpDefinition: [{  entity: { name: '/DMO/I_Supplement_StdVH',
                                                                                element: 'SupplementID' }, 
                                                                    additionalBinding: [{  localElement: 'Price', 
                                                                                                    element : 'Price', 
                                                                                                    usage: #RESULT }, 
                                                                                                    {  localElement: 'CurrencyCode', 
                                                                                                    element : 'CurrencyCode', 
                                                                                                    usage: #RESULT }], 
                                                                      useForValidation: true }]         
      SupplementID,
      _SupplementText.Description as SupplementDescription : localized, 
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,
      @Consumption.valueHelpDefinition: [{  entity: { name: 'I_CurrencyStdVH',
                                                                                element: 'Currency' }, 
                                                                      useForValidation: true }]      
      CurrencyCode,
      LocalLastChangetAt,
      /* Associations */
      _Booking : redirected to parent z349_c_booking_578,
      _Product,
      _SupplementText,
      _Travel : redirected to z349_c_travel_578
}
