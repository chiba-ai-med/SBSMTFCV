library("dcTensor")
library("nnTensor")
library("tidyverse")

# Symmetric Matrix Tri-Factorization
SMTF <- function(A, M=NULL, J, num.iter, Bin_U=0, Beta=2){
	U <- matrix(runif(nrow(A)*J), nrow=nrow(A), ncol=J)
	S <- matrix(runif(J*J), nrow=J, ncol=J)
	S <- S %*% t(S)
	RecError <- rep(0, length=num.iter)
	TestRecError <- rep(0, length=num.iter)
	RelChange <- rep(0, length=num.iter)
	for(i in seq_len(num.iter)){
		if(is.null(M)){
			# Update U
			out <- dNMTF(A, initU=U, initV=U, initS=S,
				fixS=TRUE, fixV=TRUE, rank=c(J,J), num.iter=1, Bin_U=Bin_U, Beta=Beta)
			U <- out$U
			# Update S
			out <- dNMTF(A, initU=U, initV=U, initS=S,
				fixU=TRUE, fixV=TRUE, rank=c(J,J), num.iter=1, Bin_U=Bin_U, Beta=Beta)
			S <- out$S
		}else{
			# Update U
			out <- dNMTF(A, M=M, initU=U, initV=U, initS=S,
				fixS=TRUE, fixV=TRUE, rank=c(J,J), num.iter=1, Bin_U=Bin_U, Beta=Beta)
			U <- out$U
			# Update S
			out <- dNMTF(A, M=M, initU=U, initV=U, initS=S,
				fixU=TRUE, fixV=TRUE, rank=c(J,J), num.iter=1, Bin_U=Bin_U, Beta=Beta)
			S <- out$S
		}
		# Log
		RecError[i] <- out$RecError[2]
		TestRecError[i] <- out$TestRecError[2]
		RelChange[i] <- out$RelChange[2]
	}
	list(U=U, S=S, RecError=RecError, RelChange=RelChange,
		TestRecError=TestRecError)
}



# {0,1} percentage
zero_one_percentage <- function(U){
	no_zero_candidate <- length(intersect(which(U > -0.2), which(U < 0.2)))
	no_one_candidate <- length(intersect(which(U > 0.8), which(U < 1.2)))
	100 * (no_zero_candidate + no_one_candidate) / length(U)
}