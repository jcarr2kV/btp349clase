class zcl_349_data_gen_rap_578 definition
  public
  final
  create public .

  public section.

    interfaces: if_oo_adt_classrun.

  protected section.
  private section.
endclass.



class zcl_349_data_gen_rap_578 implementation.

  method if_oo_adt_classrun~main.
*********************
    out->write( 'Adding Travel data' ).

    delete from ztravel_a_578.

    insert ztravel_a_578 from (
    select from /dmo/travel
      fields
        " client
        uuid( ) as travel_uuid,
        travel_id,
        agency_id,
        customer_id,
        begin_date,
        end_date,
        booking_fee,
        total_price,
        currency_code,
        description,
        case status when 'B' then 'A'
                    when 'P' then 'O'
                    when 'N' then 'O'
                    else 'X' end as overall_status,
        createdby as local_created_by,
        createdat as local_created_at,
        lastchangedby as local_last_changed_by,
        lastchangedat as local_last_changed_at,
        lastchangedat as last_changed_at

    ).

    out->write( 'Adding Booking data' ).

    delete from zbooking_a_578.

    insert zbooking_a_578 from (

        select
          from /dmo/booking
          join ztravel_a_578 on /dmo/booking~travel_id = ztravel_a_578~travel_id
          join /dmo/travel on /dmo/travel~travel_id = /dmo/booking~travel_id
          fields  "client,
                  uuid( ) as booking_uuid,
                  ztravel_a_578~travel_uuid as parent_uuid,
                  /dmo/booking~booking_id,
                  /dmo/booking~booking_date,
                  /dmo/booking~customer_id,
                  /dmo/booking~carrier_id,
                  /dmo/booking~connection_id,
                  /dmo/booking~flight_date,
                  /dmo/booking~flight_price,
                  /dmo/booking~currency_code,
                  case /dmo/travel~status when 'P' then 'N'
                                                   else /dmo/travel~status end as booking_status,
                  ztravel_a_578~last_changed_at as local_last_changed_at ).


    delete from zbksuppl_a_578.

    out->write( 'Adding Booking Supplements data' ).

    insert zbksuppl_a_578 from (
       select from /dmo/book_suppl as supp
              join ztravel_a_578  as trvl on trvl~travel_id = supp~travel_id
              join zbooking_a_578 as book on book~parent_uuid = trvl~travel_uuid
                                         and book~booking_id = supp~booking_id
              fields
              uuid( )                 as booksuppl_uuid,
              trvl~travel_uuid        as root_uuid,
              book~booking_uuid       as parent_uuid,
              supp~booking_supplement_id,
              supp~supplement_id,
              supp~price,
              supp~currency_code,
              trvl~last_changed_at    as local_last_changed_at

    ).


*********************
  endmethod.

endclass.
