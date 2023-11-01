@AbapCatalog.sqlViewName: 'ZAS_6378_V003'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZASENDUR_6378_CDS_003'
define view ZASENDUR_6378_CDS_003 as select from ZASENDUR_6378_CDS_002 as cds1
{
  
  cds1.vbeln,
  @Semantics.amount.currencyCode: 'VBRK.WAERK'
  sum(cds1.conversion_netwr)                                                               as conversion_netwr2,
  cds1.kunnr,
  count(*)                                                                                 as total_billing_items,
  @Semantics.amount.currencyCode: 'VBRK.WAERK'
  division( cast( sum(cds1.conversion_netwr) as netwr), cast ( count(*) as abap.int4 ), 2) as avg_price,

  substring( cds1.fkdat, 1, 4)                                                             as bill_year,
  substring( cds1.fkdat, 5, 2)                                                             as bill_month,
  substring( cds1.fkdat, 7, 2)                                                             as bill_day,
  substring( cds1.fkdat, 1, 3)                                                             as incoterm  
}
group by
  cds1.vbeln,
  cds1.kunnr,
  cds1.fkdat
