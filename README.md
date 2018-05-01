
# nmapr

Perform Network Discovery and Security Auditing with ‘nmap’

## Description

## What’s Inside The Tin

The following functions are implemented:

  - `list_available_scripts`: List available NSE scripts
  - `nmap_version`: Check ‘nmap’ version
  - `nse_descr`: Retrieve descriptioin for an NSE script
  - `nse_list`: List available NSE scripts
  - `read_script_description`: Retrieve descriptioin for an NSE script
  - `test_ssl_strength`: Report SSL Certificate Configuration Strength
    for one or more hosts

## Installation

``` r
devtools::install_github("hrbrmstr/nmapr")
```

## Usage

``` r
library(nmapr)

# current verison
packageVersion("nmapr")
```

    ## [1] '0.1.0'

### SSL Strength

``` r
test_ssl_strength("microsoft.com")
```

    ## $host_meta
    ## # A tibble: 1 x 4
    ##   host           port least_strength n_warnings
    ##   <chr>         <int> <chr>               <int>
    ## 1 microsoft.com   443 A                       3
    ## 
    ## $ciphers
    ## # A tibble: 26 x 5
    ##    host          key     name                               kex_info  strength
    ##    <chr>         <chr>   <chr>                              <chr>     <chr>   
    ##  1 microsoft.com TLSv1.0 TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA secp256r1 A       
    ##  2 microsoft.com TLSv1.0 TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA secp256r1 A       
    ##  3 microsoft.com TLSv1.0 TLS_DHE_RSA_WITH_AES_256_CBC_SHA   dh 1024   A       
    ##  4 microsoft.com TLSv1.0 TLS_DHE_RSA_WITH_AES_128_CBC_SHA   dh 1024   A       
    ##  5 microsoft.com TLSv1.0 TLS_RSA_WITH_AES_256_CBC_SHA       rsa 2048  A       
    ##  6 microsoft.com TLSv1.0 TLS_RSA_WITH_AES_128_CBC_SHA       rsa 2048  A       
    ##  7 microsoft.com TLSv1.1 TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA secp256r1 A       
    ##  8 microsoft.com TLSv1.1 TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA secp256r1 A       
    ##  9 microsoft.com TLSv1.1 TLS_DHE_RSA_WITH_AES_256_CBC_SHA   dh 1024   A       
    ## 10 microsoft.com TLSv1.1 TLS_DHE_RSA_WITH_AES_128_CBC_SHA   dh 1024   A       
    ## # ... with 16 more rows
    ## 
    ## $cipher_pref
    ## # A tibble: 3 x 3
    ##   host          key     cipher_pref
    ##   <chr>         <chr>   <chr>      
    ## 1 microsoft.com TLSv1.0 server     
    ## 2 microsoft.com TLSv1.1 server     
    ## 3 microsoft.com TLSv1.2 server     
    ## 
    ## $warnings
    ## # A tibble: 3 x 3
    ##   host          key     warnings                                                     
    ##   <chr>         <chr>   <chr>                                                        
    ## 1 microsoft.com TLSv1.0 Key exchange (dh 1024) of lower strength than certificate key
    ## 2 microsoft.com TLSv1.1 Key exchange (dh 1024) of lower strength than certificate key
    ## 3 microsoft.com TLSv1.2 Key exchange (dh 1024) of lower strength than certificate key
    ## 
    ## attr(,"class")
    ## [1] "nmap_ssl_enum_ciphers"

``` r
test_ssl_strength(c("rud.is", "rstudio.com"))
```

    ## $host_meta
    ## # A tibble: 2 x 4
    ##   host         port least_strength n_warnings
    ##   <chr>       <int> <chr>               <int>
    ## 1 rud.is        443 A                       0
    ## 2 rstudio.com   443 A                       0
    ## 
    ## $ciphers
    ## # A tibble: 34 x 5
    ##    host        key     name                                  kex_info  strength
    ##    <chr>       <chr>   <chr>                                 <chr>     <chr>   
    ##  1 rud.is      TLSv1.2 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 secp384r1 A       
    ##  2 rud.is      TLSv1.2 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 secp384r1 A       
    ##  3 rud.is      TLSv1.2 TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384 secp384r1 A       
    ##  4 rud.is      TLSv1.2 TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256 secp384r1 A       
    ##  5 rstudio.com TLSv1.0 TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA    secp256r1 A       
    ##  6 rstudio.com TLSv1.0 TLS_DHE_RSA_WITH_AES_256_CBC_SHA      dh 2048   A       
    ##  7 rstudio.com TLSv1.0 TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA    secp256r1 A       
    ##  8 rstudio.com TLSv1.0 TLS_DHE_RSA_WITH_AES_128_CBC_SHA      dh 2048   A       
    ##  9 rstudio.com TLSv1.0 TLS_RSA_WITH_AES_256_CBC_SHA          rsa 2048  A       
    ## 10 rstudio.com TLSv1.0 TLS_RSA_WITH_AES_128_CBC_SHA          rsa 2048  A       
    ## # ... with 24 more rows
    ## 
    ## $cipher_pref
    ## # A tibble: 4 x 3
    ##   host        key     cipher_pref
    ##   <chr>       <chr>   <chr>      
    ## 1 rud.is      TLSv1.2 server     
    ## 2 rstudio.com TLSv1.0 server     
    ## 3 rstudio.com TLSv1.1 server     
    ## 4 rstudio.com TLSv1.2 server     
    ## 
    ## $warnings
    ## # A tibble: 4 x 3
    ##   host        key     warnings
    ##   <chr>       <chr>   <chr>   
    ## 1 rud.is      TLSv1.2 <NA>    
    ## 2 rstudio.com TLSv1.0 <NA>    
    ## 3 rstudio.com TLSv1.1 <NA>    
    ## 4 rstudio.com TLSv1.2 <NA>    
    ## 
    ## attr(,"class")
    ## [1] "nmap_ssl_enum_ciphers"

``` r
test_ssl_strength(c("twitter.com", "def-not.exists"))
```

    ## $host_meta
    ## # A tibble: 1 x 4
    ##   host         port least_strength n_warnings
    ##   <chr>       <int> <chr>               <int>
    ## 1 twitter.com   443 C                       3
    ## 
    ## $ciphers
    ## # A tibble: 26 x 5
    ##    host        key     name                                kex_info  strength
    ##    <chr>       <chr>   <chr>                               <chr>     <chr>   
    ##  1 twitter.com TLSv1.0 TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA  secp256r1 A       
    ##  2 twitter.com TLSv1.0 TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA  secp256r1 A       
    ##  3 twitter.com TLSv1.0 TLS_RSA_WITH_AES_128_CBC_SHA        rsa 2048  A       
    ##  4 twitter.com TLSv1.0 TLS_RSA_WITH_AES_256_CBC_SHA        rsa 2048  A       
    ##  5 twitter.com TLSv1.0 TLS_ECDHE_RSA_WITH_3DES_EDE_CBC_SHA secp256r1 C       
    ##  6 twitter.com TLSv1.0 TLS_RSA_WITH_3DES_EDE_CBC_SHA       rsa 2048  C       
    ##  7 twitter.com TLSv1.1 TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA  secp256r1 A       
    ##  8 twitter.com TLSv1.1 TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA  secp256r1 A       
    ##  9 twitter.com TLSv1.1 TLS_RSA_WITH_AES_128_CBC_SHA        rsa 2048  A       
    ## 10 twitter.com TLSv1.1 TLS_RSA_WITH_AES_256_CBC_SHA        rsa 2048  A       
    ## # ... with 16 more rows
    ## 
    ## $cipher_pref
    ## # A tibble: 3 x 3
    ##   host        key     cipher_pref
    ##   <chr>       <chr>   <chr>      
    ## 1 twitter.com TLSv1.0 server     
    ## 2 twitter.com TLSv1.1 server     
    ## 3 twitter.com TLSv1.2 server     
    ## 
    ## $warnings
    ## # A tibble: 3 x 3
    ##   host        key     warnings                                             
    ##   <chr>       <chr>   <chr>                                                
    ## 1 twitter.com TLSv1.0 64-bit block cipher 3DES vulnerable to SWEET32 attack
    ## 2 twitter.com TLSv1.1 64-bit block cipher 3DES vulnerable to SWEET32 attack
    ## 3 twitter.com TLSv1.2 64-bit block cipher 3DES vulnerable to SWEET32 attack
    ## 
    ## attr(,"class")
    ## [1] "nmap_ssl_enum_ciphers"

``` r
test_ssl_strength("bertelsen.ca")
```

    ## $host_meta
    ## # A tibble: 1 x 4
    ##   host          port least_strength n_warnings
    ##   <chr>        <int> <chr>               <int>
    ## 1 bertelsen.ca   443 C                       9
    ## 
    ## $ciphers
    ## # A tibble: 39 x 5
    ##    host         key     name                                kex_info  strength
    ##    <chr>        <chr>   <chr>                               <chr>     <chr>   
    ##  1 bertelsen.ca TLSv1.0 TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA  secp256r1 A       
    ##  2 bertelsen.ca TLSv1.0 TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA  secp256r1 A       
    ##  3 bertelsen.ca TLSv1.0 TLS_DHE_RSA_WITH_AES_128_CBC_SHA    dh 2048   A       
    ##  4 bertelsen.ca TLSv1.0 TLS_DHE_RSA_WITH_AES_256_CBC_SHA    dh 2048   A       
    ##  5 bertelsen.ca TLSv1.0 TLS_ECDHE_RSA_WITH_3DES_EDE_CBC_SHA secp256r1 C       
    ##  6 bertelsen.ca TLSv1.0 TLS_DHE_RSA_WITH_3DES_EDE_CBC_SHA   dh 2048   C       
    ##  7 bertelsen.ca TLSv1.0 TLS_RSA_WITH_AES_128_CBC_SHA        rsa 4096  A       
    ##  8 bertelsen.ca TLSv1.0 TLS_RSA_WITH_AES_256_CBC_SHA        rsa 4096  A       
    ##  9 bertelsen.ca TLSv1.0 TLS_RSA_WITH_3DES_EDE_CBC_SHA       rsa 4096  C       
    ## 10 bertelsen.ca TLSv1.1 TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA  secp256r1 A       
    ## # ... with 29 more rows
    ## 
    ## $cipher_pref
    ## # A tibble: 3 x 3
    ##   host         key     cipher_pref
    ##   <chr>        <chr>   <chr>      
    ## 1 bertelsen.ca TLSv1.0 server     
    ## 2 bertelsen.ca TLSv1.1 server     
    ## 3 bertelsen.ca TLSv1.2 server     
    ## 
    ## $warnings
    ## # A tibble: 9 x 3
    ##   host         key     warnings                                                       
    ##   <chr>        <chr>   <chr>                                                          
    ## 1 bertelsen.ca TLSv1.0 64-bit block cipher 3DES vulnerable to SWEET32 attack          
    ## 2 bertelsen.ca TLSv1.0 Key exchange (dh 2048) of lower strength than certificate key  
    ## 3 bertelsen.ca TLSv1.0 Key exchange (secp256r1) of lower strength than certificate key
    ## 4 bertelsen.ca TLSv1.1 64-bit block cipher 3DES vulnerable to SWEET32 attack          
    ## 5 bertelsen.ca TLSv1.1 Key exchange (dh 2048) of lower strength than certificate key  
    ## 6 bertelsen.ca TLSv1.1 Key exchange (secp256r1) of lower strength than certificate key
    ## 7 bertelsen.ca TLSv1.2 64-bit block cipher 3DES vulnerable to SWEET32 attack          
    ## 8 bertelsen.ca TLSv1.2 Key exchange (dh 2048) of lower strength than certificate key  
    ## 9 bertelsen.ca TLSv1.2 Key exchange (secp256r1) of lower strength than certificate key
    ## 
    ## attr(,"class")
    ## [1] "nmap_ssl_enum_ciphers"
