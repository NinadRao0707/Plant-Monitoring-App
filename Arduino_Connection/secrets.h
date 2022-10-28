#include <pgmspace.h>

#define SECRET

const char WIFI_SSID[] = "";
const char WIFI_PASSWORD[] = "";

#define THINGNAME "ESP8266"

int8_t TIME_ZONE = -5; // NYC(USA): -5 UTC

const char MQTT_HOST[] = "a1n0zq7k1z3sqk-ats.iot.ap-south-1.amazonaws.com";

static const char cacert[] PROGMEM = R"EOF(
-----BEGIN CERTIFICATE-----
MIIDQTCCAimgAwIBAgITBmyfz5m/jAo54vB4ikPmljZbyjANBgkqhkiG9w0BAQsF
ADA5MQswCQYDVQQGEwJVUzEPMA0GA1UEChMGQW1hem9uMRkwFwYDVQQDExBBbWF6
b24gUm9vdCBDQSAxMB4XDTE1MDUyNjAwMDAwMFoXDTM4MDExNzAwMDAwMFowOTEL
MAkGA1UEBhMCVVMxDzANBgNVBAoTBkFtYXpvbjEZMBcGA1UEAxMQQW1hem9uIFJv
b3QgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALJ4gHHKeNXj
ca9HgFB0fW7Y14h29Jlo91ghYPl0hAEvrAIthtOgQ3pOsqTQNroBvo3bSMgHFzZM
9O6II8c+6zf1tRn4SWiw3te5djgdYZ6k/oI2peVKVuRF4fn9tBb6dNqcmzU5L/qw
IFAGbHrQgLKm+a/sRxmPUDgH3KKHOVj4utWp+UhnMJbulHheb4mjUcAwhmahRWa6
VOujw5H5SNz/0egwLX0tdHA114gk957EWW67c4cX8jJGKLhD+rcdqsq08p8kDi1L
93FcXmn/6pUCyziKrlA4b9v7LWIbxcceVOF34GfID5yHI9Y/QCB/IIDEgEw+OyQm
jgSubJrIqg0CAwEAAaNCMEAwDwYDVR0TAQH/BAUwAwEB/zAOBgNVHQ8BAf8EBAMC
AYYwHQYDVR0OBBYEFIQYzIU07LwMlJQuCFmcx7IQTgoIMA0GCSqGSIb3DQEBCwUA
A4IBAQCY8jdaQZChGsV2USggNiMOruYou6r4lK5IpDB/G/wkjUu0yKGX9rbxenDI
U5PMCCjjmCXPI6T53iHTfIUJrU6adTrCC2qJeHZERxhlbI1Bjjt/msv0tadQ1wUs
N+gDS63pYaACbvXy8MWy7Vu33PqUXHeeE6V/Uq2V8viTO96LXFvKWlJbYK8U90vv
o/ufQJVtMVT8QtPHRh8jrdkPSHCa2XV4cdFyQzR1bldZwgJcJmApzyMZFo6IQ6XU
5MsI+yMRQ+hDKXJioaldXgjUkK642M4UwtBV8ob2xJNDd2ZhwLnoQdeXeGADbkpy
rqXRfboQnoZsG4q5WTP468SQvvG5
-----END CERTIFICATE-----
)EOF";

static const char client_cert[] PROGMEM = R"KEY(
-----BEGIN CERTIFICATE-----
MIIDWjCCAkKgAwIBAgIVAN49fBHXaQqHJBzjwRlnVzC/qLZAMA0GCSqGSIb3DQEB
CwUAME0xSzBJBgNVBAsMQkFtYXpvbiBXZWIgU2VydmljZXMgTz1BbWF6b24uY29t
IEluYy4gTD1TZWF0dGxlIFNUPVdhc2hpbmd0b24gQz1VUzAeFw0yMjA4MjMxNzIz
MzVaFw00OTEyMzEyMzU5NTlaMB4xHDAaBgNVBAMME0FXUyBJb1QgQ2VydGlmaWNh
dGUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCXKOBnk3OXQX7gD+nH
BrQ2QoWRdrOUnvz5tAL1ppYMoIWzqB9jxPbMkdOC5xVMnXu68dC7/aI4nZN1HwuT
XWiYGN2DsQSpOR2KZusEcmJwzPR5rOPwAx5QGv2HiY/JmTZrpnHZma7jLkmdlqRB
2kaHqqRgaY4n5CF5JcITfoxGKJFKKpIurlNAiXvKuvqCcm0z/Nwb0CKBZFv4+cMJ
L09/qe0Fbwxi7UIVTl80LzakKNbhkh1dFdKv6LxDy5OqqYQX7D5TM9dQv+DQ0Hjc
/MBD7RAtbzkQVK2yTiiMlrxNCpRVrSjhlJJvzxqFWpzDUMKJuwgGyRAXFbQJTwxk
69nrAgMBAAGjYDBeMB8GA1UdIwQYMBaAFJ+eIABfY1b0LNI2VzY/cFlfbq/WMB0G
A1UdDgQWBBSmiMB1U0DNTy1RF8kJPxeIRHDLXTAMBgNVHRMBAf8EAjAAMA4GA1Ud
DwEB/wQEAwIHgDANBgkqhkiG9w0BAQsFAAOCAQEAQ0XqC4OoTJwQ50ezvNvxCShM
Ja7yemd9ndO6/8bKsaaDi+F2xvP2Sc3coM00+7VRCYP7gmp7MWYLWBjBw9j1HV8F
kP+CsdAXa9GPJtHbom+lbFflKeWy7LncdeOd+7DixoEOjm6rmL/RC+3QS42Hyh91
R15HpnaTab07K4ON7liEoVQDRFscT+FfsE28NR8Z24LEiI33iTGRxjyVZveLcTiz
bmn8fciPBB+0c+NwH478Ka/XQxd//y6vcm/Q9UASowOh+KIMwkzXEMASxl60sgdx
znzPL7e5Op0opygLd2YbiD+NM/cwA4slbRELgK5SzOgjhnXQqX7pLkA7fEQhXw==
-----END CERTIFICATE-----
 
)KEY";

// Copy contents from  XXXXXXXX-private.pem.key here â–¼
static const char privkey[] PROGMEM = R"KEY(
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAlyjgZ5Nzl0F+4A/pxwa0NkKFkXazlJ78+bQC9aaWDKCFs6gf
Y8T2zJHTgucVTJ17uvHQu/2iOJ2TdR8Lk11omBjdg7EEqTkdimbrBHJicMz0eazj
8AMeUBr9h4mPyZk2a6Zx2Zmu4y5JnZakQdpGh6qkYGmOJ+QheSXCE36MRiiRSiqS
Lq5TQIl7yrr6gnJtM/zcG9AigWRb+PnDCS9Pf6ntBW8MYu1CFU5fNC82pCjW4ZId
XRXSr+i8Q8uTqqmEF+w+UzPXUL/g0NB43PzAQ+0QLW85EFStsk4ojJa8TQqUVa0o
4ZSSb88ahVqcw1DCibsIBskQFxW0CU8MZOvZ6wIDAQABAoIBACLXdzIomKIqpJX8
1QPdFbjUCHmJBMejBeiAh5YbucZbUbYhcGrMwZ5RlpE7tnscaaKjjltmkPe/ynda
mo5zH2K/iH+MU+i1k4uNQWqa+vnJJCjPoxJ1hY0tS3bsTEpJmHOjv+ZKODeBOdKr
IF1VdKBcwtq+OdgUC2sjOuLHbonVAUdUWw1NQPDoyt53ESduA3Qs5wBsAkF0x3wo
sbieVhtLtaR0ETKApM22IF5kc76EoSsgFwFEH2HGAqTIDLrl9hteoOfKazx3VxmW
QNKyp3w1PM7y9fvyCVSs1fVD6W20Dp46PTFiCgJAdyN6CtbIlCjg4WXi7DXB3LWH
SCK7JwECgYEAxugHR8syWl1Yr2IGFxzVLJxDvyKMty8c4Rw0iOt2YdV0eDlb0kCd
SZBE6zrZBh1Pc6WDtHP/QzZ/q4OdBT3NIifcFIPATJSP9+wqhCtOocm3uAc4H3Uy
F/NV5p2g+y0Yqi9wQIuAn3rTUZyXOjtusmk0HUsYLu72hJs60lMk4sECgYEAwoxX
g7V33fBp6c66YrGVnHnBQvroMxEVeHlSqv6BVInx7IHi7y9l6W5P82frFTEgGG9i
VCT+SA/OvWR0FLJMLmWG0idiIxKj+DKMFoEEejacoq26BBoZ2kRoKgldjzSprnUg
0cT1Jl5z+4wt37h2d9FEAX8vXp6/u31U1YpII6sCgYEAxKa+G/L/c2v6tFr7nno5
IIPWTvA/oxSHPuB96CizwAIjxoEfEP4lA4gJO2/RBUSROssXLZ/JbZBCJTZYVchG
OVCjO/0OcCgpNnpdhpKyiS4/30fz6tYZkqhX80tAz1REoG2KU6YYopPyvStOMJp1
1RpCFfwairxjKbO3Mh5Vx4ECgYEAkJjKuuP3sYds0RCLy6r97g04rVXbm4kJEj/q
R5ld+r2EiCqJxwjNkFAjMGB+g4O9vSucQ7ozHNBS8sVk2bUjliBzsmL/N9407NZ0
9Iz0DPnmNas15LKZoHbTjNrlJPkZXMdFm2PuaZQuVDp+JhfuRWPOTeaACK2pB+tB
UG207H0CgYAfjmqSfX7g9PsKgcEm+mGl1qNp6W0ycYvl88kdkzEtPiBjBVYHCgWP
jxk/hccX0eDJJvCoqQ3IZuOMwJEmdwQID9e5BzN+nMuFLwAuR5Kvskc8rFJFgaa5
AEXyQ0FfyOB89yOiaTj0Rjc9w7si9JKVn8YoQ4bq4yfNvat9Ac4bUA==
-----END RSA PRIVATE KEY-----

)KEY";