#     Author : Alison Sihan Wu 
#              Department of Statistics, North Carolina State University
#      Email : swu11@ncsu.edu 
#     GitHub : https://github.com/alisonswu/shiny-SimNetwork


# install packages if missing
# list.of.packages <- c("shiny","igraph", "reshape","ggplot2","reshape2")
# new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
# if(length(new.packages)) install.packages(new.packages)
# 
# library(igraph)
# library(reshape)
# library(ggplot2)
# library(reshape2)


# true function:
f <- function(x){return(1 -2*(x-0.4)^2)}
# sampled n values from the function
f_sample <- function(x,n, sigma){return(rep(f(x),n) + rnorm(n,0,sigma))}
# simulation 
# simulate agent based SIR model 
SGS <- function(sigma = 0.01, N = 10){
    Xs_list = list()
    # initiate search parameters
    s = 0 
    Cl = 2
    rho = (1+sqrt(5))/2
    x1 = 0; x2 = 1/rho^2; x3 = 1
    
    # for each stage 
    for(s in 1:N){
        set.seed(s)
        ordered = TRUE
        # step 1 
        if(x2-x1 > x3-x2){x4 = x2 - (x2-x1)/rho^2}else{x4 = x2 + (x3-x2)/rho^2}
        if(x2 > x4){x = x2; x2 = x4; x4 = x; ordered = FALSE}
        # step 2 
        epsilon_s = Cl*rho^(-3-s)
        n_s = ceiling(2/epsilon_s^2*log(6*N))
        f1 =  mean(f_sample(x1, n_s, sigma))
        f2 =  mean(f_sample(x2, n_s, sigma))
        f4 =  mean(f_sample(x4, n_s, sigma))
        f3 =  mean(f_sample(x3, n_s, sigma))
        if(ordered){
            Xs =  c(x1, x2, x4, x3, f1, f2, f4, f3)
        }else{
            Xs =  c(x1, x4, x2, x3, f1, f4, f2, f3)
        }
        Xs_list[[s]] = Xs
        
        # step 3
        if(max(f1,f2)>max(f4,f3)){x3 = x4}else{x1 = x2; x2 = x4}
    }   
    return(Xs_list)
}

# plot 
plot_search <- function(Xs_list, t){
    xs = Xs_list[[t]]
    x1 = xs[1]; x2 = xs[2]; x4 = xs[3]; x3 = xs[4]
    f1 = xs[5]; f2 = xs[6]; f4 = xs[7]; f3 = xs[8]
    x = seq(0,1,0.01)
    y = f(x)
    par(mar=c(5,5,5,5))
    plot(x,y, type = "l", ylim = c(0,1), xlab = "x", 
        ylab = expression(paste( hat(mu)[s],"(x)" )), 
        cex.lab = 1.5, cex.main = 1.5, main = paste ("stage s = ", t))
    cord.x <- c(x1, x1, x3, x3) 
    cord.y <- c(-0.1,1.1,1.1,-0.1 ) 
    polygon(cord.x,cord.y,col="skyblue")
    lines(x,y, type = "l", ylim = c(0,1),lwd =2)
    
    points(c(x1,x2,x3), c(f1,f2,f3), type = "p", col="blue",pch=19)
    points(c(x4),c(f4), type ="p", col = "red",pch=19)
    abline(v = c(x1,x2,x3), col= "blue", lwd = 2 )
    abline(v = x4, col = "red", lwd = 2)
   
}



