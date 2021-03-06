#'  gridBulletGraphH: Horizontale Bullet Graph
#'  
#'  @author Simon Müller
#'  
#'  @param bgData:  data.frame with
#'                     measure  : label of what's being measured
#'                     unit     : label of units of the measure
#'                     high     : the high value for the measure
#'                     mean     : the mean value for the measure
#'                     low      : the low value for the measure
#'                     target   : the target value for the measure
#'                     value    : the actual value of the measure
#'                     
#'  @param nticks:  number of ticks. If single number all bullet graphs have the 
#'                  same number of ticks, else a vector of nrow bgData is needed
#'      
#'  @param format:  format of the ticks. Single or vector. Actually implemented:
#'                    s: standard (do nothing)
#'                    k: komma (decimal point, thousands komma)
#'                    d: point (vice verca to k)
#'                    p: add percent
#'                    
#'  @param bcol:    vector of colours
#'  
#'  @param tcol:    colour of the target bar
#'  
#'  @param vcol:    colour of the vertical bar
#'

gridBulletGraphH <- function(bgData, nticks=3, format="s", bcol=c("red", "yellow", "green"), tcol="black", vcol="black", font=25, scfont=15) {
  
  # Data Prep
  n <- nrow(bgData)
  nam <- c("low", "mean", "high", "target", "value")
  datMat <- as.matrix(bgData[, nam])
  
  # Nticks/Format Prep
  if (length(nticks) == 1) {
    nticks <- rep(nticks, n)
  }
  if (length(format) == 1) {
    format <- rep(format, n)
  }
  
  # Layout
  hl <- rep(1, n + 2)
  hu <- c("lines", rep("null", n), "lines")
  layout <- grid.layout(n + 2, 4, widths = unit(c(1, 1, 5, 2), c("lines", "null", "null", "lines")),
                        heights = unit(hl, hu))
  
  # Set Layout
  grid.newpage()
  pushViewport(plotViewport(c(0, 0, 0, 0), layout = layout))
  for (i in 1:n) {
    #
    vp <- viewport(layout.pos.row = i+1, 
                   layout.pos.col = 3)
    pushViewport(vp)
    
    # Sublayout
    subLayout <- grid.layout(nrow    = 3, 
                             ncol    = 1, 
                             heights = unit(c(1, 2, 1), c("null", "null", "null")))
    pushViewport(plotViewport(c(0, 0, 0, 0), layout=subLayout))
    
    
    vp <- viewport(layout.pos.row = 2, 
                   layout.pos.col = 1, 
                   xscale         = c(0, datMat[i, 3]))
    pushViewport(vp)
    
    # x-Axis Labels
    # Formatierung Label
    if (format[i] == "s") {
      brks <- labels <- round(seq(0, datMat[i, 3], length=nticks[i]), 0)
    } else if (format[i] == "p"){
      brks <- labels <- round(seq(0, datMat[i, 3], length=nticks[i]), 0)
      labels <- paste0(labels, "%")
    } else if (format[i] == "k") {
      brks <- labels <- round(seq(0, datMat[i, 3], length=nticks[i]), 0)
      labels <- format(labels, digits=10, nsmall=0, decimal.mark=".", big.mark=",")
    }
    
    grid.xaxis(at=brks, label=labels, gp=gpar(fontsize=scfont, col="black", fontface="bold"))
    
    grid.rect(x      = c(0, datMat[i, 1:2]) / datMat[i, 3], 
              width  = unit(diff(c(0, datMat[i, 1:3])), "native"),
              y      = rep(0.5, 3), 
              height = 1, 
              just   = "left",
              gp     = gpar(fill=bcol, col=bcol))
    
    grid.rect(x      = c(0, datMat[i, 5]),  
              width  = unit(diff(c(0, datMat[i, 5])), "native"),
              y      = 0.5, 
              height = 0.5, 
              gp     = gpar(fill=vcol, col=vcol), just="left")
    
    a <- datMat[i, 3] * 0.005
    grid.rect(x      = datMat[i, 4] / datMat[i, 3],  
              width  = unit(a, "native"),
              y      = 0.5, 
              height = 0.8, 
              gp     = gpar(fill=tcol, col=tcol), just="left")
    
    upViewport(n=3)
    
    
    # Annotation
    pushViewport(plotViewport(c(0, 0, 0, 0), layout=layout))
    vp <- viewport(layout.pos.row = i+1, 
                   layout.pos.col = 2)
    pushViewport(vp)
    
    # Sublayout 1: Same layout as graph
    subLayout <- grid.layout(nrow    = 3, 
                             ncol    = 1, 
                             heights = unit(c(1, 2, 1), c("null", "null", "null")))
    pushViewport(plotViewport(c(0, 0, 0, 0), layout=subLayout))
    
    vp <- viewport(layout.pos.row = 2, 
                   layout.pos.col = 1)
    pushViewport(vp)
    
    # Sublayout 2: two rows of text; centred middle of graph
    subLayout <- grid.layout(nrow    = 2, 
                             ncol    = 1, 
                             heights = unit(c(1, 1), c("null", "null")))
    pushViewport(plotViewport(c(0, 0, 0, 0), layout=subLayout))
    
    # First Text: Measure
    vp <- viewport(layout.pos.row = 1, 
                   layout.pos.col = 1) 
    pushViewport(vp)
    grid.text(label = bgData$measure[i], 
              just  = "right", 
              gp    = gpar(fontsize=font, col="black", fontface="bold"), 
              x     = .9,
              y     = .5)
    upViewport()
    
    # Second Text: Unit
    vp <- viewport(layout.pos.row = 2, 
                   layout.pos.col = 1) 
    pushViewport(vp)
    grid.text(label = bgData$units[i],
              just  = "right", 
              gp    = gpar(fontsize=font, col="black"), 
              x     = .9,
              y     = .5)
    upViewport(n=5)
  }
}

#'  gridBulletGraphV: Vertical Bullet Graph
#'  
#'  @author Simon Müller
#'  
#'  @param bgData:  data.frame with
#'                     measure  : label of what's being measured
#'                     unit     : label of units of the measure
#'                     high     : the high value for the measure
#'                     mean     : the mean value for the measure
#'                     low      : the low value for the measure
#'                     target   : the target value for the measure
#'                     value    : the actual value of the measure
#'                     
#'  @param nticks:  number of ticks. If single number all bullet graphs have the 
#'                  same number of ticks, else a vector of nrow bgData is needed
#'      
#'  @param format:  format of the ticks. Single or vector. Actually implemented:
#'                    s: standard (do nothing)
#'                    k: komma (decimal point, thousands komma)
#'                    d: point (vice verca to k)
#'                    p: add percent
#'                    
#'  @param bcol:    vector of colours
#'  
#'  @param tcol:    colour of the target bar
#'  
#'  @param vcol:    colour of the vertical bar
#'

gridBulletGraphV <- function(bgData, nticks=3, format="s", bcol=c("red", "yellow", "green"), tcol="black", vcol="black", font=25, scfont=15) {
  
  # Data Prep
  n <- nrow(bgData)
  nam <- c("low", "mean", "high", "target", "value")
  datMat <- as.matrix(bgData[, nam])
  
  # Nticks/Format Prep
  if (length(nticks) == 1) {
    nticks <- rep(nticks, n)
  }
  if (length(format) == 1) {
    format <- rep(format, n)
  }
  
  # Layout
  hl <- rep(1, n + 2)
  hu <- c("lines", rep("null", n), "lines")
  layout <- grid.layout(4, n + 2, widths = unit(hl, hu),
                        heights = unit(c(1, 1, 5, 2), c("lines", "null", "null", "lines")))
  
  # Set Layout
  grid.newpage()
  pushViewport(plotViewport(c(0, 0, 0, 0), layout = layout))
  for (i in 1:n) {
    #
    vp <- viewport(layout.pos.row = 3, 
                   layout.pos.col = i+1)
    pushViewport(vp)
    
    # Sublayout
    subLayout <- grid.layout(nrow    = 1, 
                             widths  = unit(c(1, 2, 1), c("null", "null", "null")),
                             ncol    = 3) 
    pushViewport(plotViewport(c(0, 0, 0, 0), layout=subLayout))
    
    
    vp <- viewport(layout.pos.row = 1, 
                   layout.pos.col = 2, 
                   yscale         = c(0, datMat[i, 3]))
    pushViewport(vp)
    
    # x-Axis Labels
    # Formatierung Label
    if (format[i] == "s") {
      brks <- labels <- round(seq(0, datMat[i, 3], length=nticks[i]), 0)
    } else if (format[i] == "p"){
      brks <- labels <- round(seq(0, datMat[i, 3], length=nticks[i]), 0)
      labels <- paste0(labels, "%")
    } else if (format[i] == "k") {
      brks <- labels <- round(seq(0, datMat[i, 3], length=nticks[i]), 0)
      labels <- format(labels, digits=10, nsmall=0, decimal.mark=".", big.mark=",")
    }
    
    grid.yaxis(at=brks, label=labels, gp=gpar(fontsize=scfont, col="black", fontface="bold"))
    
    grid.rect(y      = c(0, datMat[i, 1:2]) / datMat[i, 3], 
              height = unit(diff(c(0, datMat[i, 1:3])), "native"),
              x      = rep(0.5, 3), 
              width  = 1, 
              just   = "bottom",
              gp     = gpar(fill=bcol, col=bcol))
    
    grid.rect(y      = c(0, datMat[i, 5]),  
              height = unit(diff(c(0, datMat[i, 5])), "native"),
              x      = 0.5, 
              width  = 0.5, 
              gp     = gpar(fill=vcol, col=vcol), just="bottom")
    
    a <- datMat[i, 1] * 0.01
    grid.rect(y      = datMat[i, 4] / datMat[i, 3],  
              height = unit(a, "native"),
              x      = 0.5, 
              width  = 0.8, 
              gp     = gpar(fill=tcol, col=tcol), just="bottom")
    
    upViewport(n=3)
    
    
    # Annotation
    pushViewport(plotViewport(c(0, 0, 0, 0), layout=layout))
    vp <- viewport(layout.pos.row = 2, 
                   layout.pos.col = i+1)
    pushViewport(vp)
    
    # Sublayout 1: Same layout as graph
    subLayout <- grid.layout(nrow    = 1, 
                             ncol    = 3, 
                             widths  = unit(c(1, 2, 1), c("null", "null", "null")))
    pushViewport(plotViewport(c(0, 0, 0, 0), layout=subLayout))
    
    vp <- viewport(layout.pos.row = 1, 
                   layout.pos.col = 2)
    pushViewport(vp)
    
    # Sublayout 2: two rows of text; centred middle of graph
    subLayout <- grid.layout(nrow    = 2, 
                             ncol    = 1, 
                             widths = unit(c(1, 1), c("null", "null")))
    pushViewport(plotViewport(c(0, 0, 0, 0), layout=subLayout))
    
    # First Text: Measure
    vp <- viewport(layout.pos.row = 1, 
                   layout.pos.col = 1) 
    pushViewport(vp)
    grid.text(label = bgData$measure[i], 
              just  = "bottom", 
              gp    = gpar(fontsize=font, col="black", fontface="bold"), 
              x     = .5,
              y     = 0.1)
    upViewport()
    
    # Second Text: Unit
    vp <- viewport(layout.pos.row = 2, 
                   layout.pos.col = 1) 
    pushViewport(vp)
    grid.text(label = bgData$units[i],
              just  = "bottom", 
              gp    = gpar(fontsize=font, col="black"), 
              x     = .5,
              y     = .5)
    upViewport(n=5)
  }
}


ytd2005 <- data.frame(
  measure=c("Revenue", "Profit", "Avg Order Size", "New Customers", "Cust Satisfaction"),
  units=c("U.S. $ (1,000s)", "%", "U.S. $", "Count", "Top Rating of 5"),
  low=c(150, 20, 350, 1400, 3.5), 
  mean=c(225, 25, 500, 2000, 4.25),
  high=c(300, 30, 600, 2500, 5),
  target=c(250, 26, 550, 2100, 4.2),
  value=c(275, 22.5, 310, 1700, 4.5)
)
