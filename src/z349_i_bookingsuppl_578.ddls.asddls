@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Suplement - Interface Entity'
@Metadata.ignorePropagatedAnnotations: true
define view entity z349_i_bookingsuppl_578 
    as projection on z349_r_bookingsuppl_578
{
    key BooksupplUUID,
    TravelUUID,
    BookingUUID,
    BookingSupplementID,
    SupplementID,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    Price,
    CurrencyCode,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    LocalLastChangetAt,
    /* Associations */
    _Booking : redirected to parent z349_i_booking_578, 
    _Product,
    _SupplementText,
    _Travel : redirected to z349_i_travel_578
}
