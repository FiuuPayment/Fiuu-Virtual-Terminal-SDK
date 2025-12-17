# Fiuu VT App to App (Deep Link Integration)

This is a Fiuu VT App to App integration demo project example.
It supported SALE, VOID & STATUS operation type for Card & e-wallet payments.
Refer PDF file included in this project for more info.

## Deep Link Request & Response Example

**SALE Operation Type**

* CARD Request:
  razervt://merchant.razer.com?merchantUrlScheme=merchantapp&merchantHost=merchant.example.com&opType=SALE&currency=MYR&amount=1.01&orderId=ABC D1234&channel=CARD
* CARD Response:
  merchantapp://merchant.example.com?opType=SALE&amount=1.01&orderid=ABC D1234&tranID=123456789&status=00&currency=MYR&channel=MYDEBIT_CP&pa yDate=2025-11-17%2012%3A26%3A45

* E-Wallet Request:
  razervt://merchant.razer.com?merchantUrlScheme=merchantapp&merchantHost=merchant.example.com&opType=SALE&currency=MYR&amount=0.10&orderId=DT1763353594548&channel=RPP_DuitNowQR-Offline&payType=2
* E-Wallet Response:
  merchantapp://merchant.example.com?opType=SALE&amount=0.10&orderid=DT1763353594548&tranID=3269813008&status=00&currency=MYR&channel=RPP_DuitNowQR-Offline&payDate=2025-11-17%2012%3A26%3A45

**STATUS Operation Type**

* Request:
  razervt://merchant.razer.com?merchantUrlScheme=merchantapp&merchantHost=merchant.example.com&opType=STATUS&orderId=DT1763353594548
* Response:
  merchantapp://merchant.example.com?opType=STATUS&amount=0.10&orderid=DT1763353594548&tranID=3269813008&status=00&currency=MYR&channel=RPP_DuitNowQR-Offline&payDate=2025-11-17%2012%3A26%3A45

**VOID Operation Type**

* Request:
  razervt://merchant.razer.com?merchantUrlScheme=merchantapp&merchantHost=merchant.example.com&opType=VOID&orderId=DT1763353594548
* Response:
  merchantapp://merchant.example.com?opType=VOID&amount=0.10&orderid=DT1763353594548&tranID=3269813008&status=44&currency=MYR&channel=RPP_DuitNowQR-Offline&payDate=2025-11-17%2012%3A26%3A45

**Error Response Example**

* Request:
  razervt://merchant.razer.com?merchantUrlScheme=merchantapp&merchantHost=merchant.example.com&opType=SALE&currency=MYR&amount=1.10&orderId=DT1234353594789&channel=RPP_DuitNowQR-Offline&payType=2
* Response:
  merchantapp://merchant.example.com?errorCode=310&errorMsg=Time%20out
