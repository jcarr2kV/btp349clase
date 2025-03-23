@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel - Root Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity z349_r_travel_578       //entidad z349_r_travel_578 (la entidad siempre esta por encima de las tablas)
  as select from ztravel_a_578
  composition [0..*] of z349_r_booking_578 as _Booking      //0 ó muchas reservas (_Bookings) para 1 viaje (Travel)
  association [0..1] to /DMO/I_Agency as _Agency on _Agency.AgencyID = $projection.AgencyID
  association [0..1] to /DMO/I_Customer as _Customer on _Customer.CustomerID = $projection.CustomerID
  association [1..1] to /DMO/I_Overall_Status_VH as _OverStatus on _OverStatus.OverallStatus = $projection.OverallStatus
  association [0..1] to I_Currency as _Currency on _Currency.Currency = $projection.CurrencyCode
{
    /*SECCION PROYECCION*/
  key travel_uuid           as TravelUUID,
      travel_id             as TravelID,
      agency_id             as AgencyID,
      customer_id           as CustomerID,
      begin_date            as BeginDate,
      end_date              as EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      booking_fee           as BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price           as TotalPrice,
      currency_code         as CurrencyCode,
      description           as Description,
      overall_status        as OverallStatus,

      @Semantics.user.createdBy: true
      local_created_by      as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at      as LocalCreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,

      //local Etag field (utilizado en la concurrencia de las multiples llamadas que se pueden utilizar en el mismo
      //                    momento al servicio ODATA ETag); el ETAG se utilizará en el cálculo del algoritmo
      //                    que el propio sistema va a gestionar para no tener inconsistencia cuando tenemos CONCURRENCIA
      //                    practicamente lo podemos asimilar como un OBJETO DE BLOQUEO
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      //total ETag field
      @Semantics.systemDateTime.lastChangedAt : true
      last_changed_at       as LastChangedAt,

       /*SECCION PUBLICACION*/
      //Publicando las relaciones Padre-Hijo -- COMPOSICION
      _Booking,
      _Agency, 
      _Customer, 
      _OverStatus, 
      _Currency
      
}
