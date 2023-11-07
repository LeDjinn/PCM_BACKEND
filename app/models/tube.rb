class Tube < ApplicationRecord
    belongs_to :quotation
   
    COEFF_TEPHANE = 0.013
    EPVOILE_AC = 0.3
    EPMAT = 0.7
    POIDS_VOILE_M2 = 0.02
    POIDS_MAT = 0.3
    TAUX_ABS_VOILE = 15
    TAUX_ABS_MAT = 2.5
    POURCENTAGE_MAJ_MATIERE = 0.05
    POURCENTAGE_MAJ_VOILE = 0.15
    EP_FIL_PROJ = 0.55
    POIDS_FIL_PROJ_M2 = 0.3
    TAUX_ABS_FIBRE_PROJ = 2.5
    POIDS_UD = 0.04
    POIDS_UD_M2 = 0.3
    LARGEUR_NAPPE = 0.23
    POURCENTAGE_MAJ_FIL_DIRECT = 0.01
    POIDS_FILS_TEX = 2.4
    EPAISSEUR_NAPPE_MVP = 0.7
    EPAISSEUR_NAPPE_PLASTREX = 1.1
    EPAISSEUR_VOILE_FINITION = 0.2
    RATIO_COLORANT = "3%"
    CHARGE_ANTI_ABRASION = "1%"
    AUTRE_CHARGE_AC = "1%"
    ANTI_UV_326 = "0.2451%"
    AUTRE_CHARGE = "0.20%"
    RATIO_LPT = 0.02
    RATIO_COBALT = 0.003
    RATIO_DMA = 0.001

   
  
    def f_1
       qt = self.quantity.to_f
       dn = self.dn
       aray_dn_values = find_dn_values(dn)
       useful_quantity = aray_dn_values[0].to_f
       nmbr_tube = (qt / useful_quantity).ceil
       return nmbr_tube
    end


    def f_2
      dn = self.dn
      qt = self.quantity.to_f
      type_piece = self.type_piece
      rm = self.rm 
      
      if type_piece == "TUBE ORTHO"
        aray_dn_values = find_dn_values(dn)
        coef_loss = aray_dn_values[1]
      else
        aray_dn_values = find_dn_values(dn)
        coef_loss = aray_dn_values[2]
      end
      rm_loss = coeff_pert(type_piece,rm)

      return   coef_loss * rm_loss

    end


    def f_3
       dn = self.dn
       qt = self.quantity.to_f
       reel_loss = self.f_2()
       nmbr_tube = self.f_1()
       type_piece = self.type_piece
       rm = self.rm
       array_dn_values = find_dn_values(dn)
       lenght_useful = array_dn_values[0]

       if dn <600 && dn !=450
          qt_calculation = qt*(lenght_useful+reel_loss)
       else
        qt_calculation= nmbr_tube*reel_loss + qt
       end

    end


    def f_4
       dn = self.dn
       qt_calculation = self.f_3()
       surface = (Math::PI * dn / 1000 *qt_calculation).round(2)
    end


    def f_5
        dn = self.dn
        surface = self.f_4
        coeff_demoulant_f57_ncp = 0.0085
        coeff_terphane = 0.013
        percentage_maj_matter = 0.2
    
        if dn < 600
           demoulant= (surface * coeff_demoulant_f57_ncp).round(2)
           matter_demoulant = "DEMOULANT F57 NCP"
        else
            demoulant = (surface * coeff_terphane * (1+percentage_maj_matter)).round(2)
            matter_demoulant = "Terphane lg 50 MM-EP 36µ"
        end
       return demoulant, matter_demoulant
    end


    def f6_7
      if self.dn && self.dn < 600
        f6
      else
        f7
      end

    end

    def f8_9
     if self.type_piece == "TUBE ORTHO"
      f8()
     else
      f9()
     end
    end

    def f_10 #VERIFY 
      dn = self.dn
      qt_calcul=self.f_3
      ac = self.ac
      rm = self.rm
      surface_voile_fin = qt_calcul * (dn + 2 * ac + 2* rm ) * Math::PI * (1 + POURCENTAGE_MAJ_VOILE)/1000
      poids_resine_voile = surface_voile_fin * POIDS_VOILE_M2 * TAUX_ABS_VOILE * (1+ POURCENTAGE_MAJ_MATIERE)
      if self.type_piece =="TUBE ORTHO" 
        poids = f8()
        poids_rm = poids[3]
      else
        poids= f9()
        poids_rm = poids[3]
      end
      poids_total = poids_resine_voile + poids_rm

      return surface_voile_fin.round, poids_resine_voile.round, poids_total.round
    end

    def f_11
        charge_ac = self.charge_ac
        charge_rm = self.charge_rm
        couleur = self.color
        if color != "AUCUN"
          ratio_pate_couleur = 0.03
        end
        if charge_ac =="CHARGE ANTI ABRASION" || charge_ac == "autre charge"
          ratio_charge_ac = 0.01
        else
          ratio_charge_ac = 0
        end
        if charge_rm == "ANTI UV 326" || charge_rm == "autre charge"
          ratio_charge_rm = 0.002
        else
          ratio_charge_rm = 0
        end
        poids = f6_7()
        poids_resine_acvr = poids[1]
        poids_rm = f8_9()
        poids_resine_rm = poids_rm[2]

        poids_charge_ac = poids_resine_acvr * ratio_charge_ac
        poids_charge_rm = poids_resine_rm * ratio_charge_rm
        poids_charge_color = poids_resine_rm * ratio_pate_couleur

        return poids_charge_ac.round(3), poids_charge_rm, poids_charge_color
    end
 
    def f_12
       poids_total_ac = f6_7()[3]
       poids_total_rm = f8_9()[3]
       dn = self.dn 
       nmbr_tube = f_1()
       tps_demand = find_ratios_by_dn(dn)[0]
   
       ratio_ac = find_ratios_by_dn(dn)[1]
       ratio_rm = find_ratios_by_dn(dn)[2]
       mo = ratio_ac * poids_total_ac + ratio_rm * poids_total_rm + nmbr_tube * tps_demand
     return mo.round
    end
 
    def f_13
        poids_resine_ac = f6_7()[1] 
        poids_resin_rm = f8_9()[2]

        poids_butanox = (poids_resine_ac + poids_resin_rm) * RATIO_LPT
        poids_cobalt = (poids_resine_ac + poids_resin_rm) * RATIO_COBALT
        poids_dma = (poids_resine_ac + poids_resin_rm) * RATIO_DMA
        return poids_butanox.round(2), poids_cobalt.round(3), poids_dma.round(3)
    end
    #### PRICE INTERMEDIATE CALCULATION ##########
    def calculation 
      designiation = self.barear_ac
      matter_ac ||= Matter.find_by(name: designiation)# || { id: 4, name: "RESINE EQUIVALENTE 470", price_local: 7.29, price_export: 6.69, category_id: 1 }   
      price_ac = self.country == 'export' ? matter_ac[:price_export] :  matter_ac[:price_local]
      quantity_ac = f6_7()[1] 
      price_ac_total = quantity_ac.round() * price_ac

      designation_rm = self.resine_rm
      matter_rm ||= Matter.find_by(name: designation_rm)# || { id: 4, name: "RESINE EQUIVALENTE 411", price_local: 4.87, price_export: 4.47, category_id: 1 }
      price_rm =  self.country == 'export' ? matter_rm[:price_export] :  matter_rm[:price_local]
      quantity_rm = f_10()[1]+f8_9()[2]
      price_rm_total = quantity_rm.round() * price_rm

      surface_voile = f_10()[0]
      matter_surface = Matter.find_by(name: '1702 lg 50 MM')# || { id: 4, name: "1702 lg 50 MM", price_local: 1.27, price_export: 1.10, category_id: 1 }
      price_matter_surface =  self.country == 'export' ? matter_surface[:price_export] :  matter_surface[:price_local]
      price_matter_surface_total = surface_voile * price_matter_surface
    
      designation_voile_ac = self.voile_ac
      surface_voile_ac = f6_7()[0]
      matter_voile_ac = Matter.find_by(name: designation_voile_ac) #|| { id: 4, name: "1777 lg 50 MM", price_local: 0.95, price_export: 0.83, category_id: 1 }
      price_matter_voile_ac = self.country == 'export' ? matter_voile_ac[:price_export] :  matter_voile_ac[:price_local]
      price_matter_voile_ac_total = surface_voile_ac * price_matter_voile_ac

      if f_5()[1]==  "Terphane lg 50 MM-EP 36µ"
        terphane = Matter.find_by(name:  "Terphane lg 50 MM-EP 36µ")
        terphane_price = self.country == 'export' ? 5 : 5.75
        terphane_weight = f_5()[0]
        price_terphane_total = terphane_price * terphane_weight
      else
        price_terphane_total = 0
      end
      if self.dn < 600
        matter_poudre = Matter.find_by(name:  "MAT  POUDRE 300 lg 100" )
        matter_poudre_price = self.country == 'export' ? 3.31 : 3.80
        matter_poudre_weight = f6_7()[2]
        matter_poudre_price_total = matter_poudre_price * matter_poudre_weight  
      else
        matter_poudre_price_total= 0
      end

      if self.type_piece == "TUBE ORTHO"
        qt_tissu_unidrect = f8_9()[0]
        matter_tissu_undirect = Matter.find_by(name:  "TISSU UNIDIRECTIONNEL" )
        price_matter_tissu_undirect = self.country == 'export' ? 2.45 :2.82
        price_matter_tissu_undirect_total = price_matter_tissu_undirect * qt_tissu_unidrect

        qt_fil = f8_9()[1]
        matter_fil = Matter.find_by(name:   "FIL 2400 TEX ENROULEMENT")
        price_matter_fil =  self.country == 'export' ? 1.50 : 1.73
        price_matter_fil_total = qt_fil *  price_matter_fil

        if  self.dn >= 600
          qt_fil_projection = f6_7()[2]
          matter_fill_projection = Matter.find_by(name:   "FIL 2400 TEX PROJECTION")
          price_matter_fil_projection =  self.country == 'export' ? 1.95 : 2.25
          price_matter_fil_projection_total=  price_matter_fil_projection * qt_fil_projection

        else
          price_matter_fil_projection_total = 0
        end

      else
        price_matter_tissu_undirect_total= 0
        price_matter_fil_total = 0
        price_matter_fil_projection_total= 0
      end
      
       poids_dma= f_13()[2]
       matter_dma = Matter.find_by(name:    "ACCELERATEUR DMA 100%")
       price_matter_dma = self.country == 'export' ? 9.03 : 9.03
       price_matter_dma_total = poids_dma *  price_matter_dma

        
       poids_cobalt= f_13()[1]
       matter_cobalt = Matter.find_by(name:    "ACCELERATEUR COBALT 6%")
       price_matter_cobalt = self.country == 'export' ? 9.94 : 9.94
       price_matter_cobalt_total = poids_cobalt *  price_matter_cobalt

       poids_catalyseur_lpt = f_13()[0]
       matter_catalyseur_lpt =  Matter.find_by(name:    "CATALYSEUR LPT")
       price_catalyseur_lpt = self.country == 'export' ?  5.93 : 5.93
       price_catalyseur_lpt_total= price_catalyseur_lpt * poids_catalyseur_lpt
      
       
      if self.charge_rm == "ANTI UV 326"
        qt_anti_uv = f_11()[1]
        matter_anti_uv = Matter.find_by(name:    "ANTI UV 326")
        price_matter_anti_uv =  self.country == 'export' ?  30.25 : 30.25
        price_matter_anti_uv_total =  price_matter_anti_uv *  qt_anti_uv

      else
        price_matter_anti_uv_total= 0 
      end
      if f_5()[1]==  "DEMOULANT F57 NCP"
      qt_demoulant = f_5()[0]
      matter_demoulant = Matter.find_by(name:   "DEMOULANT F57 NCP"  )
      price_matter_demoulant =  self.country == 'export' ?  12.52 : 12.52
      price_matter_demoulant_total=  price_matter_demoulant * qt_demoulant
      else
        price_matter_demoulant_total= 0
      end
      

      if self.color ==   "PATE COLORANTE 7035"
        qt_pate_col = f_11()[2]
        matter_pate_col = Matter.find_by(name:  "PATE COLORANTE 7035"  )
        price_matter_pate_col = self.country == 'export' ?  5.83 : 5.83
        price_matter_pate_col_total = price_matter_pate_col *   qt_pate_col
      else
        price_matter_pate_col_total =0
      end
      price_mo = f_12()
      price_mo_per_h = 10

      price_mo_total = price_mo_per_h * price_mo

      calculation_total = price_ac_total +price_rm_total +
      price_matter_surface_total +
      price_matter_voile_ac_total +
      price_terphane_total +
      matter_poudre_price_total +
      price_matter_tissu_undirect_total +
      price_matter_fil_total +
      price_matter_fil_projection_total +
      price_matter_dma_total +
      price_matter_cobalt_total +
      price_catalyseur_lpt_total +
      price_matter_anti_uv_total +
      price_matter_demoulant_total +
      price_matter_pate_col_total  
      
      return   [
             price_ac_total,
             price_rm_total,
             price_matter_surface_total,
             price_matter_voile_ac_total,
             price_terphane_total, 
             matter_poudre_price_total,
             price_matter_tissu_undirect_total,
             price_matter_fil_total,
             price_matter_fil_projection_total,
             price_matter_dma_total,
             price_matter_cobalt_total,
             price_catalyseur_lpt_total,
             price_matter_anti_uv_total, 
             price_matter_demoulant_total,
             price_matter_pate_col_total ,
             price_mo_total,
             calculation_total      
            ] 
    end 
         
    ##### END #####################################

    def price_mp  
      calculation()[16] 
    end

    def mo
      calculation()[15]/10
    end

    def price_total
      calculation()[16] +   calculation()[15]
    end

   
    def price_mmp
      calculation()[16] / 0.85
    end


    def price_mo_method
      calculation()[15]
    end


    def price_total_big
      self.price_mmp + calculation()[15]
    end


    def price_mgcom
      self.price_total_big/0.8
    end

    def price_unit
      self.price_mgcom / self.quantity 
    end

   private 
   

   #Functions
   def f6
    @materials = {
      "Coeff_TEPHANE" => 0.013,
      "EpvoileAC" => 0.3,
      "Epmat" => 0.7,
      "Poids_voile_m²" => 0.02,
      "Poids_mat" => 0.3,
      "Taux_abs_voile" => 15,
      "Taux_abs_mat" => 2.5,
      "Pourcentage_maj_matiere" => 0.05,
      "Pourcentage_maj_voile" => 0.15,
      "Ep_fil_proj" => 0.55,
      "Poids_fil_proj_au_m²" => 0.3,
      "Taux_abs_fibre_proj" => 2.5,
      "Poids_UD" => 0.04,
      "Poids_au_m²_de_UD" => 0.3,
      "Largeur_de_nappe" => 0.23,
      "Pourcentage_maj_fil_direct" => 0.01,
      "Poids_fils_tex" => 2.4,
      "Epaisseur_nappe_MVP" => 0.7,
      "Epaisseur_nappe_plastrex" => 1.1,
      "Epaisseur_voile_finition" => 0.2,
      "Ratio_colorant" => "3%",
      "Charge_anti_abrasion" => "1%",
      "Autre_charge_AC" => "1%",
      "Anti_UV_326" => "0.2451%",
      "Autre_charge" => "0.20%",
      "Ratio_LPT" => "2%",
      "Ratio_cobalt" => "0.30%",
      "Ratio_DMA" => "0.10%"
    }
    dn = self.dn
    surface = self.f_4
    nmbr_voile = self.number_voile_ac
    ac = self.ac
    percentage_maj_voile = 1+ @materials["Pourcentage_maj_voile"]

    surface_voile= surface * nmbr_voile * percentage_maj_voile
    nmbr_mats=((ac-(nmbr_voile * @materials["EpvoileAC"]))/@materials["Epmat"]).ceil
    poids_mats = surface * @materials["Poids mat"] * nmbr_mats * (1+@materials["Pourcentage_maj_matiere"])    
    poids_resine = ((surface_voile * @materials["Poids_voile_m²"] * @materials[ "Taux_abs_voile"])+(poids_mats * @materials[ "Taux_abs_mat"])) * (1+@materials["Pourcentage_maj_matiere"])    
    poids_total = poids_resine + poids_mats + surface_voile *  @materials["Poids_voile_m²"]
    return surface_voile.round(1), poids_resine.round(2), poids_mats.round(2), poids_total.round(2)
    end

    def f7 
      @materials = {
        "Coeff_TEPHANE" => 0.013,
        "EpvoileAC" => 0.3,
        "Epmat" => 0.7,
        "Poids_voile_m²" => 0.02,
        "Poids_mat" => 0.3,
        "Taux_abs_voile" => 15,
        "Taux_abs_mat" => 2.5,
        "Pourcentage_maj_matiere" => 0.05,
        "Pourcentage_maj_voile" => 0.15,
        "Ep_fil_proj" => 0.55,
        "Poids_fil_proj_au_m²" => 0.3,
        "Taux_abs_fibre_proj" => 2.5,
        "Poids_UD" => 0.04,
        "Poids_au_m²_de_UD" => 0.3,
        "Largeur_de_nappe" => 0.23,
        "Pourcentage_maj_fil_direct" => 0.01,
        "Poids_fils_tex" => 2.4,
        "Epaisseur_nappe_MVP" => 0.7,
        "Epaisseur_nappe_plastrex" => 1.1,
        "Epaisseur_voile_finition" => 0.2,
        "Ratio_colorant" => "3%",
        "Charge_anti_abrasion" => "1%",
        "Autre_charge_AC" => "1%",
        "Anti_UV_326" => "0.2451%",
        "Autre_charge" => "0.20%",
        "Ratio_LPT" => "2%",
        "Ratio_cobalt" => "0.30%",
        "Ratio_DMA" => "0.10%"
      }
      dn = self.dn
      surface = self.f_4
      nmbr_voile = self.number_voile_ac
      ac = self.ac
      percentage_maj_voile = 1+ @materials["Pourcentage_maj_voile"].to_f
      surface_voile= surface * nmbr_voile * percentage_maj_voile
      nmbr_mats=((ac-(nmbr_voile * @materials["EpvoileAC"]))/@materials["Epmat"]).ceil
      poids_fil = surface * @materials[ "Poids_fil_proj_au_m²"].to_f * nmbr_mats * (1+@materials["Pourcentage_maj_matiere"].to_f)  
      poids_resine = ((surface_voile * @materials["Poids_voile_m²"].to_f * @materials[ "Taux_abs_voile"].to_f)+(poids_fil * @materials[ "Taux_abs_mat"].to_f)) * (1+@materials["Pourcentage_maj_matiere"])    
      poids_total = poids_resine + poids_fil + surface_voile *  @materials["Poids_voile_m²"]
      return surface_voile.round(1), poids_resine.round(2), poids_fil.round(2), poids_total.round(2) 
   
    end

  def f8
    qt_calcul=self.f_3
    dn = self.dn
    ac = self.ac
    rm = self.rm
    surface = self.f_4
    nmbr_pass_fil = (rm + 0.8) / 0.85
    nmbr_pass_ud = nmbr_pass_fil - 2 
    tissu_undirect = surface *  POIDS_UD_M2 * nmbr_pass_ud
    developpe = (Math.sqrt((Math::PI * (dn+ ac + rm))**2 + 220**2)).round
    km_fil = developpe * 60 * (qt_calcul/LARGEUR_NAPPE)/1000
    fil_tex_2400 = km_fil * nmbr_pass_fil * POIDS_FILS_TEX.to_f * (1 + POURCENTAGE_MAJ_FIL_DIRECT.to_f)/1000
    qt_resine_rm = (tissu_undirect.round + fil_tex_2400) * 0.35 / (1 - 0.35)
    poids_total = tissu_undirect + fil_tex_2400 + qt_resine_rm

    return  tissu_undirect.round, fil_tex_2400.round, qt_resine_rm.round, poids_total.round 

  end

  def f9
    qt_calcul=self.f_3
    dn = self.dn.to_f
    ac = self.ac
    rm = self.rm
    epaisseur_nappe = dn >= 600 ?   EPAISSEUR_NAPPE_MVP : EPAISSEUR_NAPPE_PLASTREX
    nmbr_napp = ((rm - EPAISSEUR_VOILE_FINITION)/epaisseur_nappe)# rajouter les 2 mm de voiles add ceil ()
    rapport = dn/1000.0
    avance = (3.14 * rapport ) / 1.376382 
    developpe = (Math.sqrt(avance**2 +(Math::PI * dn / 1000)**2)).round(2)
    metre_1_nappe = ((qt_calcul/0.0045) * (developpe * 2)) /1000
    poids_fil_direct = (metre_1_nappe * nmbr_napp * POIDS_FILS_TEX) * (1 + POURCENTAGE_MAJ_FIL_DIRECT)
    poids_resin_rm = (poids_fil_direct * 0.35) * (1+ POURCENTAGE_MAJ_MATIERE)
    poids_total = poids_fil_direct + poids_resin_rm
    just_to_eq_the_array = 1

    return just_to_eq_the_array, poids_fil_direct, poids_resin_rm, poids_total
  end

 

  def find_ratios_by_dn(dn)
    ratios = [
      { dn: 15, tps_demand: 2, ratio_ac: 0.102, ratio_rm: 0.037 },
      { dn: 80, tps_demand: 2, ratio_ac: 0.102, ratio_rm: 0.037 },
      { dn: 100, tps_demand: 2, ratio_ac: 0.102, ratio_rm: 0.037 },
      { dn: 125, tps_demand: 2, ratio_ac: 0.102, ratio_rm: 0.037 },
      { dn: 150, tps_demand: 2, ratio_ac: 0.09, ratio_rm: 0.034 },
      { dn: 200, tps_demand: 2, ratio_ac: 0.085, ratio_rm: 0.032 },
      { dn: 250, tps_demand: 2, ratio_ac: 0.08, ratio_rm: 0.027 },
      { dn: 300, tps_demand: 2, ratio_ac: 0.07, ratio_rm: 0.018 },
      { dn: 350, tps_demand: 2, ratio_ac: 0.072, ratio_rm: 0.018 },
      { dn: 400, tps_demand: 2, ratio_ac: 0.072, ratio_rm: 0.018 },
      { dn: 450, tps_demand: 2, ratio_ac: 0.072, ratio_rm: 0.018 },
      { dn: 500, tps_demand: 3, ratio_ac: 0.062, ratio_rm: 0.022 },
      { dn: 560, tps_demand: 3, ratio_ac: 0.062, ratio_rm: 0.026 },
      { dn: 600, tps_demand: 3, ratio_ac: 0.062, ratio_rm: 0.026 },
      { dn: 630, tps_demand: 3, ratio_ac: 0.062, ratio_rm: 0.026 },
      { dn: 650, tps_demand: 3, ratio_ac: 0.06, ratio_rm: 0.012 },
      { dn: 700, tps_demand: 3, ratio_ac: 0.06, ratio_rm: 0.01 },
      { dn: 750, tps_demand: 3, ratio_ac: 0.056, ratio_rm: 0.01 },
      { dn: 800, tps_demand: 3, ratio_ac: 0.055, ratio_rm: 0.009 },
      { dn: 900, tps_demand: 3, ratio_ac: 0.055, ratio_rm: 0.009 },
      { dn: 1000, tps_demand: 5, ratio_ac: 0.055, ratio_rm: 0.009 },
      { dn: 1100, tps_demand: 5, ratio_ac: 0.055, ratio_rm: 0.009 },
      { dn: 1200, tps_demand: 5, ratio_ac: 0.055, ratio_rm: 0.009 },
      { dn: 1300, tps_demand: 5, ratio_ac: 0.055, ratio_rm: 0.009 },
      { dn: 1400, tps_demand: 5, ratio_ac: 0.055, ratio_rm: 0.009 },
      { dn: 1500, tps_demand: 5, ratio_ac: 0.055, ratio_rm: 0.009 },
      { dn: 1600, tps_demand: 5, ratio_ac: 0.055, ratio_rm: 0.009 },
      { dn: 1800, tps_demand: 5, ratio_ac: 0.055, ratio_rm: 0.009 },
      { dn: 2000, tps_demand: 5, ratio_ac: 0.055, ratio_rm: 0.009 },
      { dn: 2500, tps_demand: 5, ratio_ac: 0.055, ratio_rm: 0.009 },
      { dn: 2700, tps_demand: 10, ratio_ac: 0.055, ratio_rm: 0.009 },
      { dn: 3000, tps_demand: 10, ratio_ac: 0.055, ratio_rm: 0.009 },
      { dn: 3500, tps_demand: 10, ratio_ac: 0.055, ratio_rm: 0.009 },
      { dn: 4000, tps_demand: 15, ratio_ac: 0.055, ratio_rm: 0.009 },
      { dn: 6000, tps_demand: 15, ratio_ac: 0.055, ratio_rm: 0.009 }
    ]
  
    match = ratios.find { |ratio| ratio[:dn] == dn }
  tps_demand = match ? match[:tps_demand] : nil
  ratio_ac = match ? match[:ratio_ac] : nil
  ratio_rm = match ? match[:ratio_rm] : nil

  
    return tps_demand, ratio_ac, ratio_rm
  end
  
   def find_dn_values( dn)
    lenght_useful =0
    loss_ortho=0
    loss_heli=0
    data = [
        { DN: 80,  'Longueur utile': 9,   'Perte ortho': 0.25, 'Perte heli': 0.5 },
        { DN: 100, 'Longueur utile': 9,   'Perte ortho': 0.25, 'Perte heli': 0.5 },
        { DN: 125, 'Longueur utile': 9,   'Perte ortho': 0.25, 'Perte heli': 0.5 },
        { DN: 150, 'Longueur utile': 9,   'Perte ortho': 0.25, 'Perte heli': 0.5 },
        { DN: 200, 'Longueur utile': 9,   'Perte ortho': 0.25, 'Perte heli': 0.5 },
        { DN: 250, 'Longueur utile': 9,   'Perte ortho': 0.25, 'Perte heli': 0.5 },
        { DN: 300, 'Longueur utile': 9,   'Perte ortho': 0.25, 'Perte heli': 0.5 },
        { DN: 350, 'Longueur utile': 9,   'Perte ortho': 0.25, 'Perte heli': 0.5 },
        { DN: 400, 'Longueur utile': 9,   'Perte ortho': 0.25, 'Perte heli': 0.5 },
        { DN: 450, 'Longueur utile': 9,   'Perte ortho': 0.25 },
        { DN: 500, 'Longueur utile': 9,   'Perte ortho': 0.25, 'Perte heli': 0.5 },
        { DN: 560, 'Longueur utile': 9,   'Perte ortho': 0.25, 'Perte heli': 0.5 },
        { DN: 600, 'Longueur utile': 12.2,'Perte ortho': 0.25, 'Perte heli': 0.7 },
        { DN: 630, 'Longueur utile': 4.2, 'Perte ortho': 0.25, 'Perte heli': 0.7 },
        { DN: 650, 'Longueur utile': 6,   'Perte ortho': 0.25, 'Perte heli': 0.7 },
        { DN: 700, 'Longueur utile': 12.2,'Perte ortho': 0.25, 'Perte heli': 0.7 },
        { DN: 750, 'Longueur utile': 8.5, 'Perte ortho': 0.25 },
        { DN: 800, 'Longueur utile': 12.2,'Perte ortho': 0.25, 'Perte heli': 0.7 },
        { DN: 900, 'Longueur utile': 5.7, 'Perte ortho': 0.25 },
        { DN: 1000,'Longueur utile': 12.2,'Perte ortho': 0.25, 'Perte heli': 0.7 },
        { DN: 1100,'Longueur utile': 12.2,'Perte ortho': 0.25, 'Perte heli': 0.7 },
        { DN: 1200,'Longueur utile': 12.2,'Perte ortho': 0.25, 'Perte heli': 0.7 },
        { DN: 1300,'Longueur utile': 11,  'Perte ortho': 0.25, 'Perte heli': 0.7 },
        { DN: 1400,'Longueur utile': 11,  'Perte ortho': 0.25, 'Perte heli': 0.7 },
        { DN: 1500,'Longueur utile': 12.2,'Perte ortho': 0.25, 'Perte heli': 0.7 },
        { DN: 1600,'Longueur utile': 12.2,'Perte ortho': 0.25, 'Perte heli': 0.7 },
        { DN: 1800,'Longueur utile': 12.2,'Perte ortho': 0.25, 'Perte heli': 0.7 },
        { DN: 2000,'Longueur utile': 9,   'Perte ortho': 0.25, 'Perte heli': 0.7 },
        { DN: 2500,'Longueur utile': 9,   'Perte ortho': 0.25, 'Perte heli': 0.7 },
        { DN: 2700,'Longueur utile': 11,  'Perte ortho': 0.25, 'Perte heli': 0.7 },
        { DN: 3000,'Longueur utile': 9,   'Perte ortho': 0.25, 'Perte heli': 0.7 },
        { DN: 4000,'Longueur utile': 9.6, 'Perte ortho': 0.25, 'Perte heli': 0.7 },
        { DN: 3500,'Longueur utile': 9.6, 'Perte ortho': 0.25, 'Perte heli': 0.7 },
        { DN: 6000,'Longueur utile': 4.6, 'Perte ortho': 0.25, 'Perte heli': 0.7 }
      ]
      

        match = data.find { |item| item[:DN] == dn }
        if match
          lenght_useful = match[:'Longueur utile']
          loss_ortho = match[:'Perte ortho']
          loss_heli = match[:'Perte heli']
        end
      
        return lenght_useful, loss_ortho, loss_heli
    end

    def coeff_pert(type_piece,rm)
        case rm
        when 0..10
          type_piece == "TUBE ORTHO" ? 0.5 : 1
        when 10..20
          type_piece ==  "TUBE ORTHO"  ? 0.6 : 1.2
        when 20..30
          type_piece ==  "TUBE ORTHO"  ?  0.8 : 1.5
        when 30..40
          type_piece ==  "TUBE ORTHO"  ? 1 : 2
        else
          type_piece ==  "TUBE ORTHO"  ? 1 : 2.5 
        end
    end
    #CONSTANTS
  
        
end
 