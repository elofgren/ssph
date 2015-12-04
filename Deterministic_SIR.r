require(deSolve)

SIR.model <- function (t, x, params) {
  S <- x[1]
  I <- x[2]
  R <- x[3]
  with (
    as.list(params),
{
	dS <- -beta*S*I/(S+I+R)
	dI <- beta*S*I/(S+I+R) - gamma*I
	dR <- gamma*I
  res <- c(dS,dI,dR)
  list(res)
}
  )
}

times <- seq(0,80,by=0.05)
params <- c(
 beta <- 0.50,
 gamma <- 1/10
)

xstart <- c(S = 999, I = 1, R= 0)

out <- as.data.frame(lsoda(xstart,times,SIR.model,params))

plot(I~time, data=out, ylim=c(0,1150), type="l", col="red", lwd=2, ylab="People", xlab="Time (Days)",lty=2)
lines(S~time, data=out, type="l", col="darkgreen", lwd=2,lty=1)
lines(R~time, data=out, type="l", col="blue", lwd=2,lty=3)
legend("topleft", c("Susceptible","Infected","Recovered"), col=c("darkgreen","red","blue"),lty=c(1,2,3), lwd=c(3,3,3), bty='y', ncol=3)
