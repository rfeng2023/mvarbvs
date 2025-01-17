Test Inverse Performances
================
David Gerard
2016-11-01

Abstract
========

I test three different ways to calculate an inverse to see performance gains.

Code
====

Show that the three inversion formulas I have are the same

``` r
## Moore Penrose --------------------------------------------------------------
set.seed(1824)
M <- 11
L <- 5

diag_lambda <- rchisq(M, df = 1)
Lambda <- diag(diag_lambda)
U <- matrix(rnorm(M * L), nrow = M)
V <- U %*% t(U)

LHS <- solve(diag(M) + V %*% Lambda) %*% V

ULU <- t(U) %*% Lambda %*% U
middle <- V - U %*% solve(diag(L) + ULU ) %*% ULU %*% t(U)

RHS <- V - U %*% solve(solve(t(U) %*% Lambda %*% U) + diag(L)) %*% t(U)

plot(LHS, RHS)
```

![](test_inverse_files/figure-markdown_github/unnamed-chunk-1-1.png)

``` r
plot(middle, LHS)
```

![](test_inverse_files/figure-markdown_github/unnamed-chunk-1-2.png)

``` r
plot(middle, RHS)
```

![](test_inverse_files/figure-markdown_github/unnamed-chunk-1-3.png)

Now test for large M

``` r
rm(list = ls())
M <- 2000
L <- 11

diag_lambda <- rchisq(M, df = 1)
Lambda <- diag(diag_lambda)
U <- matrix(rnorm(M * L), nrow = M)
V <- U %*% t(U)

Sys.sleep(1)
lstart <- proc.time()
LHS <- solve(diag(M) + V %*% Lambda) %*% V
ltot <- proc.time() - lstart

mstart <- proc.time()
ULU <- t(U) %*% Lambda %*% U
middle <- V - U %*% solve(diag(L) + ULU ) %*% ULU %*% t(U)
mtot <- proc.time() - mstart

rstart <- proc.time()
RHS <- V - U %*% solve(solve(t(U) %*% Lambda %*% U) + diag(L)) %*% t(U)
rtot <- proc.time() - rstart

ltot
```

    ##    user  system elapsed 
    ##   3.501   0.012   3.532

``` r
mtot
```

    ##    user  system elapsed 
    ##   0.042   0.000   0.042

``` r
rtot
```

    ##    user  system elapsed 
    ##   0.061   0.000   0.061
