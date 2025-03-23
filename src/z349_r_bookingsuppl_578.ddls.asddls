@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supplements - Root Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity z349_r_bookingsuppl_578
  as select from zbksuppl_a_578 //los suplementos (gaseosas, galletas, etc.) de los que han reservado (Booking)
  
  association to parent z349_r_booking_578 as _Booking on _Booking.BookingUUID = $projection.BookingUUID
  association [1..1] to z349_r_travel_578 as _Travel on _Travel.TravelUUID = $projection.TravelUUID     //navegando al ABUELO
  association [1..1] to /DMO/I_Supplement as _Product on _Product.SupplementID = $projection.SupplementID
  association [1..*] to /DMO/I_SupplementText as _SupplementText on _SupplementText.SupplementID = $projection.SupplementID
{
  key booksuppl_uuid        as BooksupplUUID,
      root_uuid             as TravelUUID,  //el abuelo
      parent_uuid           as BookingUUID, //el padre
      booking_supplement_id as BookingSupplementID,
      supplement_id         as SupplementID,
      @Semantics.amount.currencyCode : 'CurrencyCode'
      price                 as Price,
      currency_code         as CurrencyCode,

      //local ETag filed
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changet_at as LocalLastChangetAt, 
      
      //publicar mi padre
      _Booking, 
      _Travel, 
      _Product, 
      _SupplementText
}
