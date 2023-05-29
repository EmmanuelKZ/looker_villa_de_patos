connection: "zubale_-_zombie"

datagroup: villa_de_patos_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: villa_de_patos_default_datagroup

include: "/views/**/*.view"

access_grant: view_deprecated {
  user_attribute: view_deprecated
  allowed_values: ["yes"]
}

explore: villa_de_patos_store {
  required_access_grants: [view_deprecated]
  from: location_store

  join: retail {
    from: location_retailer
    type: left_outer
    relationship: many_to_one
    sql_on: ${villa_de_patos_store.retailer_id} = ${retail.id} ;;
  }

  join: company {
    from: location_company
    type: left_outer
    relationship: many_to_one
    sql_on: ${company.id} = ${retail.company_id} ;;
  }

  join: submissionmetadata {
    from: submission_submissionmetadata
    type: inner
    relationship: one_to_many
    sql_on: ${submissionmetadata.store_id} = ${villa_de_patos_store.id} AND ${submissionmetadata.approved} = 'Yes' AND
      ${submissionmetadata.brand_id} = 290;;
  }

  join: skudata {
    from: sku_manager_skudata
    type: left_outer
    relationship: one_to_many
    sql_on: ${skudata.meta_data_id} = ${submissionmetadata.id} AND ${skudata.name_string} NOT LIKE '71%'
      AND ${skudata.name_string} NOT LIKE '63%'
      AND ${skudata.name_string} NOT LIKE '64%'
      AND ${skudata.name_string} NOT LIKE '46%'
      AND ${skudata.name_string} NOT LIKE '34%'
      AND ${skudata.name_string} NOT LIKE '40%'
      AND ${skudata.name_string} NOT LIKE '78%'
      AND ${skudata.name_string} NOT LIKE '41%'
      AND ${skudata.name_string} NOT LIKE '60%'
      AND ${skudata.name_string} NOT LIKE '71%'
      AND ${skudata.name_string} NOT LIKE '75%'
      AND ${skudata.name_string} != 'MARCA'
      AND ${skudata.name_string} != 'TAREA';;
  }

  join: availability {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_one
    sql_on: ${availability.sku_id} = ${skudata.id} AND ${availability.key} = 'disponibilidad' ;;
  }

  join: spent {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_one
    sql_on: ${spent.sku_id} = ${skudata.id} AND ${spent.key} = 'agotado_foto' ;;
  }

  join: spent_picture {
    from: submission_submissionimage
    type: left_outer
    relationship: one_to_one
    sql_on: ${spent_picture.id} = ${spent.value}::integer ;;
  }

  join: price {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_one
    sql_on: ${price.sku_id} = ${skudata.id} AND ${price.key} = 'precio' ;;
  }

  join: shalves {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_one
    sql_on: ${shalves.sku_id} = ${skudata.id} AND ${shalves.key} = 'anaqueles' ;;
  }

  join: expired {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_one
    sql_on: ${expired.sku_id} = ${skudata.id} AND ${expired.key} = 'caducadas' ;;
  }

  join: fecha {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_one
    sql_on: ${fecha.sku_id} = ${skudata.id} AND ${fecha.key} = 'fecha' ;;
  }

  join: fecha_picture {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_one
    sql_on: ${fecha_picture.sku_id} = ${skudata.id} AND ${fecha_picture.key} = 'fecha_foto' ;;
  }

  join: fecha_picture_2 {
    from: submission_submissionimage
    type: left_outer
    relationship: one_to_one
    sql_on: ${fecha_picture_2.id} = ${fecha_picture.value}::integer ;;
  }

  join: products {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_one
    sql_on: ${products.sku_id} = ${skudata.id} AND ${products.key} = 'productos' ;;
  }

  join: expiration_date {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_one
    sql_on: ${expiration_date.sku_id} = ${skudata.id} AND ${expiration_date.key} = 'vigencia' ;;
  }

  join: front {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_one
    sql_on: ${front.sku_id} = ${skudata.id} AND ${front.key} = 'frentes' ;;
  }

  join: capture {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_one
    sql_on: ${capture.sku_id} = ${skudata.id} AND ${capture.key} = 'captura' ;;
  }

  join: checkout {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_one
    sql_on: ${checkout.sku_id} = ${skudata.id} AND ${checkout.key} = 'caja' ;;
  }

  join: warehouse {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_one
    sql_on: ${warehouse.sku_id} = ${skudata.id} AND ${warehouse.key} = 'bodega_foto' ;;
  }

  join: warehouse_picture {
    from: submission_submissionimage
    type: left_outer
    relationship: one_to_one
    sql_on: ${warehouse_picture.id} = ${warehouse.value}::integer ;;
  }

  join: specific {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_one
    sql_on: ${specific.sku_id} = ${skudata.id} AND ${specific.key} = 'especifica' ;;
  }

  join: exhibition_data {
    from: sku_manager_skudata
    type: left_outer
    relationship: one_to_many
    fields: []
    sql_on: ${exhibition_data.meta_data_id} = ${submissionmetadata.id} AND ${exhibition_data.name_string} = 'TAREA' ;;
  }

  join: exhibition {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_one
    sql_on: ${exhibition.sku_id} = ${exhibition_data.id} AND ${exhibition.key} = 'exhibiciones_foto';;
  }

  join: exhibition_picture {
    from: submission_submissionimage
    type: left_outer
    relationship: one_to_one
    sql_on: ${exhibition_picture.id} = ${exhibition.value}::integer ;;
  }

  join: comment_data {
    from: sku_manager_skudata
    type: left_outer
    relationship: one_to_many
    fields: []
    sql_on: ${comment_data.meta_data_id} = ${submissionmetadata.id} AND ${comment_data.name_string} = 'MARCA';;
  }
  join: comment {
    from: sku_manager_skudatapoint
    type: left_outer
    relationship: one_to_one
    sql_on: ${comment.sku_id} = ${comment_data.id} AND ${comment.key} = 'comentario' ;;
  }



  }
