col <- c(
  "DEL" = "#374b88", "AMP" = "#c83934",
  "MUT" = "#adadaa", "SNP" = "#008000", "INS" = "pink", "ONP" = "white", "DNP" = "white", "HOMDEL" = "#374b88",
  "Germline" = "white", "Somatic" = "black", "Fusion" = "#6e3171", "Unknown" = "grey",
  "Missense_Mutation" = "#6a9492", "Truncating_Mutation" = "#724b86", "In_Frame_Mutation" = "#b3653a"
)

alter_fun <- list(
  background = function(x, y, w, h) {
    grid.rect(x, y, w-unit(0.5, "mm"), h-unit(0.5, "mm"), 
              gp = gpar(fill = "grey90", col = "grey90"))
  },
  # big blue
  DEL = function(x, y, w, h) {
    grid.rect(x, y, w-unit(0.5, "mm"), h-unit(0.5, "mm"), 
              gp = gpar(fill = col["DEL"], col = NA))
  },
  # big red
  AMP = function(x, y, w, h) {
    grid.rect(x, y, w-unit(0.5, "mm"), h-unit(0.5, "mm"), 
              gp = gpar(fill = col["AMP"], col = NA))
  },
  # small green
  MUT = function(x, y, w, h) {
    grid.rect(x, y, w-unit(0.5, "mm"), h*0.33, 
              gp = gpar(fill = col["MUT"], col = NA))
  },
  # small green
  SNP = function(x, y, w, h) {
    grid.rect(x, y, w-unit(0.5, "mm"), h*0.33, 
              gp = gpar(fill = col["SNP"], col = NA))
  },
  # small green
  INS = function(x, y, w, h) {
    grid.rect(x, y, w-unit(0.5, "mm"), h*0.33, 
              gp = gpar(fill = col["INS"], col = NA))
  },
  # small green
  ONP = function(x, y, w, h) {
    grid.rect(x, y, w-unit(0.5, "mm"), h*0.33, 
              gp = gpar(fill = col["ONP"], col = NA))
  },
  # small green
  DNP = function(x, y, w, h) {
    grid.rect(x, y, w-unit(0.5, "mm"), h*0.33, 
              gp = gpar(fill = col["DNP"], col = NA))
  },
  # small green
  HOMDEL = function(x, y, w, h) {
    grid.rect(x, y, w-unit(0.5, "mm"), h-unit(0.5, "mm"), 
              gp = gpar(fill = col["HOMDEL"], col = NA))
  },
  # medium purple
  Fusion = function(x, y, w, h) {
    grid.rect(x, y, w-unit(0.5, "mm"), h-unit(0.5, "mm"), 
              gp = gpar(fill = col["Fusion"], col = NA))
  },
  # small green
  Unknown = function(x, y, w, h) {
    grid.rect(x, y, w-unit(0.5, "mm"), h*0.33, 
              gp = gpar(fill = col["Unknown"], col = NA))
  },
  # small green
  Missense_Mutation = function(x, y, w, h) {
    grid.rect(x, y, w-unit(0.5, "mm"), h-unit(0.5, "mm"), 
              gp = gpar(fill = col["MUT"], col = NA))
    grid.rect(x, y, w-unit(0.5, "mm"), h*0.33,
              gp = gpar(fill = col["Missense_Mutation"], col = NA))
  },
  # Missense_Mutation = function(x, y, w, h) {
  #   grid.segments(x - w*0.5, y, x + w*0.5, y, gp = gpar(col = col["Missense_Mutation"], lwd = 2))
  # },
  # small green
  Truncating_Mutation = function(x, y, w, h) {
    grid.rect(x, y, w-unit(0.5, "mm"), h-unit(0.5, "mm"), 
              gp = gpar(fill = col["MUT"], col = NA))
    grid.rect(x, y, w-unit(0.5, "mm"), h*0.33, 
              gp = gpar(fill = col["Truncating_Mutation"], col = NA))
  },
  # small green
  In_Frame_Mutation = function(x, y, w, h) {
    grid.rect(x, y, w-unit(0.5, "mm"), h-unit(0.5, "mm"), 
              gp = gpar(fill = col["MUT"], col = NA))
    grid.rect(x, y, w-unit(0.5, "mm"), h*0.33, 
              gp = gpar(fill = col["In_Frame_Mutation"], col = NA))
  },
  # small white
  # Germline = alter_graphic("rect", height = 0.33, fill = col["Germline"]),
  # Germline = function(x, y, w, h) {
  #   grid.rect(x, y, w-unit(0.5, "mm"), h*0.1,
  #             gp = gpar(fill = col["Germline"], col = NA))
  # },
  Germline = function(x, y, w, h) {
    grid.segments(x - w*0.5, y, x + w*0.5, y, gp = gpar(col = col["Germline"], lwd = 2))
  },
  # Germline = function(x, y, w, h) {
  #   grid.segments(x - w*0.4, y - h*0.4, x + w*0.4, y + h*0.4, gp = gpar(lwd = 2))
  #   grid.segments(x + w*0.4, y - h*0.4, x - w*0.4, y + h*0.4, gp = gpar(lwd = 2))
  # },
  # crossed lines
  Somatic = function(x, y, w, h) {
    grid.segments(x - w*0.4, y - h*0.4, x + w*0.4, y + h*0.4, gp = gpar(lwd = 2))
    grid.segments(x + w*0.4, y - h*0.4, x - w*0.4, y + h*0.4, gp = gpar(lwd = 2))
  }
)

heatmap_legend_alteration_param <- list(
  title = "Alterations",
  at = c("AMP","HOMDEL","MUT","Fusion"), 
  labels = c("Amplification","Deep deletion","Mutation","Fusion"),
  col_fun = col[c("AMP","HOMDEL","MUT","Fusion")]
)

heatmap_legend_mutation_type_param <- list(
  title = "Mutation type",
  at = c("Germline","Somatic","Missense_Mutation","Truncating_Mutation","In_Frame_Mutation"), 
  labels = c("Germline","Somatic","Missense","Truncating","Inframe"),
  col_fun = col[c("Germline","Somatic","Missense_Mutation","Truncating_Mutation","In_Frame_Mutation")], 
  lwd = c(2, 4, 4, 4, 4)
)


plot_oncoprint_heatmap <-
  function(mat,
           top_annotation,
           bottom_annotation,
           right_annotation,
           column_split) {
    column_title <- "MSK SPECTRUM"
    
    role_in_cancer <- list(
      "TSG" = c(
        "TP53",
        "BRCA1",
        "BRCA2",
        "ATM",
        "ATR",
        "BAP1",
        "BARD1",
        "BLM",
        "BRIP1",
        "CHEK1",
        "CHEK2",
        "MRE11",
        "MRE11A",
        "MUTYH",
        "NBN",
        "POLD1",
        "RAD21",
        "RAD50",
        "RAD51",
        "RAD51B",
        "RAD51C",
        "RAD51D",
        "RAD52",
        "RAD54L",
        "PALB2",
        "NF1",
        "PTEN",
        "RB1",
        "XRCC2",
        "CDK12"
      ),
      "oncogene" = c("CCNE1", "ERBB2", "KRAS", "MECOM", "MYC", "PIK3CA")
    ) %>%
      enframe(name = "role_in_cancer", value = "hugo_symbol") %>%
      unnest()
    
    row_split <- rownames(mat) %>%
      enframe(value = "hugo_symbol") %>%
      dplyr::left_join(role_in_cancer, by = "hugo_symbol") %>%
      dplyr::mutate(role_in_cancer = factor(role_in_cancer, levels = c("TSG", "oncogene"))) %>%
      pull(role_in_cancer)
    
    print(rownames(mat))
    
    oncoprint_ht <- oncoPrint(
      mat,
      top_annotation = top_annotation,
      # bottom_annotation = bottom_annotation,
      right_annotation = right_annotation,
      alter_fun = alter_fun,
      col = col,
      row_split = row_split,
      column_split = column_split,
      cluster_row_slices = FALSE,
      cluster_column_slices = FALSE,
      row_order = rownames(mat),
      # column_order = unlist(column_order(inventory_ht)),
      show_column_names = TRUE,
      show_row_names = TRUE,
      remove_empty_columns = FALSE,
      remove_empty_rows = FALSE,
      row_names_side = "left",
      pct_gp = gpar(fontsize = 8), 
      pct_side = "right",
      row_names_gp = gpar(fontface = "italic", fontsize = 8),
      row_title_gp = gpar(fontsize = 0),
      column_title = "",
      column_title_gp = gpar(fontsize = 10),
      show_heatmap_legend = FALSE
      # rect_gp = gpar(col = "white", lwd = 0.5)
      # legend_title_gp = gpar(fontface = "italic")
      # rect_gp = gpar(col = "grey90", lwd = 1)
      # heatmap_legend_param = heatmap_legend_param
    )
    
    oncoprint_ht
    
    # # draw(oncoprint_ht, annotation_legend_list = lgd_list)
    # 
    # ComplexHeatmap::draw(
    #   oncoprint_ht,
    #   merge_legends = TRUE,
    #   heatmap_legend_side = "bottom",
    #   annotation_legend_side = "bottom",
    #   heatmap_legend_list = lgd_list)
    
  }


plot_oncoprint_legend <-
  function(...) {
    
    # lgd1 = Legend(labels = c("AMP","HOMDEL","MUT","Fusion"),
    #               graphics = alter_fun[c("AMP","HOMDEL","MUT","Fusion")])
    lgd1 = Legend(at = heatmap_legend_alteration_param$at,
                  labels = heatmap_legend_alteration_param$labels,
                  # col_fun = heatmap_legend_alteration_param$col,
                  title = heatmap_legend_alteration_param$title,
                  type = "grid",
                  legend_gp = gpar(fill = heatmap_legend_alteration_param$col_fun))
    lgd2 = Legend(at = heatmap_legend_mutation_type_param$at,
                  labels = heatmap_legend_mutation_type_param$labels,
                  # col_fun = col,
                  title = heatmap_legend_mutation_type_param$title,
                  type = "lines", 
                  legend_gp = gpar(col = heatmap_legend_mutation_type_param$col_fun, 
                                   lwd = heatmap_legend_mutation_type_param$lwd), 
                  background = col["MUT"])
    
    oncoprint_lgd_list = packLegend(lgd1, lgd2, direction = "horizontal")
    
  }