get_sample_inventory <- function(inventory, unique = TRUE) {
  if (unique == TRUE) {
    sample_inventory <- inventory %>%
      dplyr::select(
        patient_id,
        tumor_type,
        tumor_supersite,
        tumor_site,
        tumor_subsite,
        therapy,
        technique,
        is_site_matched
      ) %>%
      dplyr::mutate(technique_status = 1) %>%
      distinct(
        patient_id,
        tumor_supersite,
        tumor_site,
        tumor_subsite,
        therapy,
        technique,
        .keep_all = TRUE
      ) %>%
      spread(technique, technique_status, fill = 0)
  } else {
    sample_inventory <- inventory %>%
      dplyr::select(
        patient_id,
        tumor_type,
        tumor_supersite,
        tumor_site,
        tumor_subsite,
        therapy,
        technique,
        is_site_matched
      ) %>%
      dplyr::mutate(technique_status = 1) %>%
      group_by(
        patient_id,
        tumor_type,
        tumor_supersite,
        tumor_site,
        tumor_subsite,
        therapy,
        technique,
        is_site_matched
      ) %>%
      summarise(n_samples = n()) %>%
      ungroup() %>%
      spread(technique, n_samples, fill = 0)
  }
  
}


# plot_inventory_heatmap <-
#   function(inventory_mat,
#            bottom_annotation,
#            left_annotation,
#            column_order,
#            row_split = "technique",
#            column_split = "consensus_signature") {
#     patient_id_col = clrs$patient_id
#     tumor_supersite_col = list("Site" = clrs$tumor_supersite)
#     signature_col = list("Mutational\nsignature" = clrs$consensus_signature)
#     chemo_intent_col = list("Setting" = clrs$chemo_intent)
#     pathology_stage_col = list("Stage" = clrs$pathology_stage)
#     age_col_fun = circlize::colorRamp2(seq(30, 90, 20), brewer.pal(4, "YlOrRd"))
#
#     row_split = left_annotation[[row_split]]
#     column_split = bottom_annotation[[column_split]]
#
#     column_gap = unit(4, "mm")
#
#     signature_colors = plyr::mapvalues(
#       bottom_annotation$consensus_signature,
#       from = names(clrs$consensus_signature),
#       to = clrs$consensus_signature
#     ) %>% as.character
#     site_colors = plyr::mapvalues(
#       left_annotation$tumor_supersite,
#       from = names(clrs$tumor_supersite),
#       to = clrs$tumor_supersite
#     ) %>% as.character
#
#     column_title = "MSK SPECTRUM"
#
#     patient_count = colSums(inventory_mat)
#
#     top_annotation <- ComplexHeatmap::columnAnnotation(
#       "# samples\nper patient" = anno_barplot(
#         patient_count,
#         gp = gpar(col = signature_colors, fill = signature_colors),
#         # axis_param = list(side = "right"),
#         border = FALSE
#       ),
#       annotation_name_gp = list(fontsize = 10),
#       annotation_width = unit(c(1, 4), "cm")
#     )
#
#     bottom_df = bottom_annotation %>% dplyr::select(
#       patient_age,
#       gyn_chemo_intent_description,
#       gyn_primary_pathology_stage_description,
#       consensus_signature
#     ) %>% as.data.frame
#     colnames(bottom_df) <- c("Age", "Setting", "Stage", "Signature")
#
#     bottom_annotation <- ComplexHeatmap::columnAnnotation(
#       df = bottom_df,
#       col = list(
#         "Age" = age_col_fun,
#         "Setting" = clrs$chemo_intent,
#         "Stage" = clrs$pathology_stage,
#         "Signature" = clrs$consensus_signature[names(clrs$consensus_signature) !=
#                                                    "NA"]
#       ),
#       show_annotation_name = TRUE,
#       annotation_name_side = "left",
#       annotation_name_gp = list(fontsize = 10),
#       # annotation_legend_param = list(
#       #     signature = list(title = "Signature")),
#       simple_anno_size = unit(0.35, "cm")
#       # na_col = "white", gp = gpar(col = "white")
#     )
#
#     left_df = left_annotation %>% dplyr::select(tumor_supersite) %>% as.data.frame
#     colnames(left_df) <- c("Site")
#
#     left_annotation <- ComplexHeatmap::rowAnnotation(
#       df = left_df,
#       col = list("Site" = clrs$tumor_supersite),
#       # "Site" = clrs$tumor_supersite[names(clrs$tumor_supersite)!="Unknown"]),
#       show_annotation_name = TRUE,
#       annotation_name_side = "top",
#       annotation_name_gp = list(fontsize = 10),
#       # annotation_legend_param = list(
#       #     tumor_supersite = list(title = "Site")),
#       # annotation_name_rot = 0,
#       simple_anno_size = unit(0.35, "cm")
#       # na_col = "white", gp = gpar(col = "white")
#     )
#
#     site_count = rowSums(inventory_mat)
#
#     right_annotation <- ComplexHeatmap::rowAnnotation(
#       "# samples\nper site" = anno_barplot(
#         site_count,
#         gp = gpar(col = site_colors, fill = site_colors),
#         border = FALSE
#         # name = "Number of\nsamples"
#       ),
#       annotation_name_gp = list(fontsize = 10)
#       # annotation_width = unit(c(1, 4), "cm"),
#       # name = "Number of\nsamples"
#     )
#
#     at = seq(0, 4, by = 1)
#     col_fun = circlize::colorRamp2(c(0, 1, 2, 3, 4),
#                                    c("grey90", "grey70", "grey50", "grey20", "black"))
#
#     heatmap_legend_param = list(
#       at = at,
#       color_bar = "discrete",
#       legend_gp = gpar(fill = col_fun)
#     )
#
#     ht <- ComplexHeatmap::Heatmap(
#       inventory_mat,
#       name = "# samples",
#       heatmap_legend_param = heatmap_legend_param,
#       col = col_fun,
#       show_row_dend = FALSE,
#       show_column_dend = FALSE,
#       show_row_names = FALSE,
#       show_column_names = TRUE,
#       border = FALSE,
#       # top_annotation = top_annotation,
#       #bottom_annotation = bottom_annotation,
#       left_annotation = left_annotation,
#       right_annotation = right_annotation,
#       row_order = rownames(inventory_mat),
#       row_names_side = "left",
#       column_names_side = "bottom",
#       # row_names_rot = 180, column_names_rot = NULL,
#       row_split = row_split,
#       column_order = column_order,
#       #bottom_annotation[[column_order]],
#       column_split = column_split,
#       cluster_row_slices = FALSE,
#       cluster_column_slices = FALSE,
#       row_title_gp = gpar(fontsize = 10),
#       row_title_rot = 0,
#       column_title = column_title,
#       column_title_gp = gpar(fontsize = 10, fontface = "bold"),
#       # row_title_gp = gpar(col = "#FFFFFF00"),
#       # column_gap = column_gap
#       # cell_fun = function(j, i, x, y, width, height, fill) {
#       #     grid.text(sprintf("%d", mat[i, j]), x, y, gp = gpar(col = "white",fontsize = 10))
#       # },
#       rect_gp = gpar(col = "grey90", lwd = 1)
#     )
#
#     return(ht)
#   }

plot_inventory_heatmap <-
  function(inventory_mat,
           bottom_annotation,
           left_annotation,
           column_order,
           row_split = "technique",
           column_split = "consensus_signature" ,
           column_split_shared = NULL) {
    patient_id_col = clrs$patient_id
    tumor_supersite_col = list("Site" = clrs$tumor_supersite[names(clrs$tumor_supersite)!="Unknown"])
    signature_col = list("Mutational\nsignature" = clrs$consensus_signature[names(clrs$consensus_signature)!="NA"])
    chemo_intent_col = list("Setting" = clrs$chemo_intent)
    pathology_stage_col = list("Stage" = clrs$pathology_stage)
    age_col_fun = circlize::colorRamp2(seq(30, 90, 20), brewer.pal(4, "YlOrRd"))
    
    row_split = left_annotation[[row_split]]
    column_split = bottom_annotation[[column_split]]
    
    column_gap = unit(4, "mm")
    
    signature_colors = plyr::mapvalues(
      bottom_annotation$consensus_signature,
      from = names(signature_col$`Mutational\nsignature`),
      to = signature_col$`Mutational\nsignature`
    ) %>% as.character
    site_colors = plyr::mapvalues(
      left_annotation$tumor_supersite,
      from = names(tumor_supersite_col$`Site`),
      to = tumor_supersite_col$`Site`
    ) %>% as.character
    
    column_title = "MSK SPECTRUM"
    
    top_df = as_tibble(colSums(inventory_mat), rownames = "patient_id") %>%
      # arrange(match(patient_id, colnames(inventory_mat))) %>%
      column_to_rownames(var = "patient_id") %>%
      as.matrix
    
    top_annotation <- ComplexHeatmap::columnAnnotation(
      "# samples\nper patient" = anno_barplot(
        top_df,
        gp = gpar(col = signature_colors, fill = signature_colors),
        # axis_param = list(side = "right"),
        border = FALSE
      ),
      annotation_name_gp = list(fontsize = 10),
      annotation_width = unit(c(1, 4), "cm")
    )
    
    bottom_df <- bottom_annotation %>%
      # arrange(match(patient_id, colnames(inventory_mat))) %>%
      dplyr::select(
        patient_age,
        gyn_diagnosis_chemo_intent_description,
        gyn_diagnosis_figo_stage,
        consensus_signature
      ) %>%
      as.data.frame
    colnames(bottom_df) <- c("Age", "Setting", "Stage", "Signature")
    
    print(bottom_df)
    
    bottom_annotation <- ComplexHeatmap::columnAnnotation(
      df = bottom_df,
      col = list(
        "Age" = age_col_fun,
        "Setting" = clrs$chemo_intent[names(clrs$chemo_intent) != "Salvage"],
        "Stage" = clrs$pathology_stage,
        "Signature" = clrs$consensus_signature[names(clrs$consensus_signature) != "NA"]
      ),
      show_annotation_name = TRUE,
      annotation_name_side = "left",
      annotation_name_gp = list(fontsize = 10),
      # annotation_legend_param = list(
      #     signature = list(title = "Signature")),
      simple_anno_size = unit(0.35, "cm")
      # na_col = "white", gp = gpar(col = "white")
    )
    
    left_df <- left_annotation %>%
      dplyr::select(tumor_supersite) %>%
      as.data.frame
    colnames(left_df) <- c("Site")
    
    left_annotation <- ComplexHeatmap::rowAnnotation(
      df = left_df,
      # col = list("Site" = clrs$tumor_supersite),
      col = list("Site" = clrs$tumor_supersite[names(clrs$tumor_supersite) !=
                                                   "Unknown"]),
      # "Site" = clrs$tumor_supersite[names(clrs$tumor_supersite)!="Unknown"]),
      show_annotation_name = TRUE,
      annotation_name_side = "bottom",
      annotation_name_gp = list(fontsize = 10),
      # annotation_legend_param = list(
      #     tumor_supersite = list(title = "Site")),
      # annotation_name_rot = 0,
      simple_anno_size = unit(0.35, "cm")
      # na_col = "white", gp = gpar(col = "white")
    )
    
    site_count = rowSums(inventory_mat)
    
    right_annotation <- ComplexHeatmap::rowAnnotation(
      "test" = anno_text(
        site_count, 
        gp = gpar(fontsize = 8)),
      "# samples\nper site" = anno_barplot(
        site_count,
        gp = gpar(col = site_colors, fill = site_colors),
        border = FALSE),
        # name = "Number of\nsamples"),
      annotation_name_gp = list(fontsize = 10)
      # annotation_width = unit(c(1, 4), "cm"),
      # name = "Number of\nsamples"
    )
    
    at = seq(0, 2, by = 1)
    col_fun = circlize::colorRamp2(c(0, 1, 2),
                                   c("grey90", "grey70", "grey50"))
    
    heatmap_legend_param = list(
      at = at,
      color_bar = "discrete",
      legend_gp = gpar(fill = col_fun)
    )
    
    ht <- ComplexHeatmap::Heatmap(
      inventory_mat,
      name = "# samples",
      heatmap_legend_param = heatmap_legend_param,
      col = col_fun,
      show_row_dend = FALSE,
      show_column_dend = FALSE,
      show_row_names = FALSE,
      show_column_names = TRUE,
      border = FALSE,
      # top_annotation = top_annotation, bottom_annotation = bottom_annotation,
      left_annotation = left_annotation,
      right_annotation = right_annotation,
      row_order = rownames(inventory_mat),
      # row_title = "Site",
      column_title = "Patient",
      column_title_side = "bottom",
      row_names_side = "left",
      column_names_side = "bottom",
      # row_names_rot = 180, column_names_rot = NULL,
      row_split = row_split,
      column_order = column_order,
      #unlist(column_order(oncoprint_ht)),#column_order,#bottom_annotation[[column_order]],
      # column_split = bottom_df$Signature,#column_split_shared,
      cluster_row_slices = FALSE,
      cluster_column_slices = FALSE,
      cluster_rows = FALSE,
      cluster_columns = FALSE,
      row_title_gp = gpar(fontsize = 10),
      row_title_rot = 0,
      # column_title = column_title,
      column_title_gp = gpar(fontsize = 12),
      column_names_gp = gpar(fontsize = 10),
      # row_title_gp = gpar(col = "#FFFFFF00"),
      # column_gap = column_gap
      # cell_fun = function(j, i, x, y, width, height, fill) {
      #     grid.text(sprintf("%d", mat[i, j]), x, y, gp = gpar(col = "white",fontsize = 10))
      # },
      rect_gp = gpar(col = "white", lwd = 0.5)
    )
    
    return(ht)
  }