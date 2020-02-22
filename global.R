# if(!require('pacman')) install.packages('pacman')
# pacman::p_load(shiny, leaflet, sf, data.table)
library(shiny); library(leaflet); library(sf); library(data.table)

world <- setDT(st_read('ne_50m_admin_0'))