@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking - Root Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity z349_r_booking_578
  as select from zbooking_a_578
  composition [0..*] of z349_r_bookingsuppl_578 as _BookingSupplement
  
  association to parent z349_r_travel_578 as _Travel on _Travel.TravelUUID = $projection.TravelUUID 
  association [1..1] to /DMO/I_Customer as _Customer on _Customer.CustomerID = $projection.CustomerID
  association [1..1] to /DMO/I_Carrier as _Carrier on _Carrier.AirlineID = $projection.AirlineID
  association [1..1] to /DMO/I_Connection as _Connection on _Connection.AirlineID = $projection.AirlineID
                                                                                                    and _Connection.ConnectionID = $projection.ConnectionID
  association [1..1] to /DMO/I_Booking_Status_VH as _BookingStatus on _BookingStatus.BookingStatus = $projection.BookingStatus
{
  key booking_uuid          as BookingUUID,
      parent_uuid           as TravelUUID,
      
      booking_id            as BookingID,
      booking_date          as BookingDate,
      customer_id           as CustomerID,
      carrier_id            as AirlineID,
      connection_id         as ConnectionID,
      flight_date           as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      flight_price          as FlightPrice,
      currency_code         as CurrencyCode,
      booking_status        as BookingStatus,
      
      //local ETag field (se utilizará en el ODATA para la concurrencia)
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt, 
      
      //Publicar al padre
      _Travel, 
      //Publicar al hijo
      _BookingSupplement,
      //
      _Customer, 
      //
      _Carrier, 
      //
       _Connection, 
       //
       _BookingStatus
}
