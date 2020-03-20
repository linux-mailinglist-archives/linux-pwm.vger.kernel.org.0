Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1965318D782
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2020 19:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgCTSmo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 20 Mar 2020 14:42:44 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:47312 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726953AbgCTSmo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Mar 2020 14:42:44 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-175-Rpihu1x7PlGFiVtSHu5gzQ-1; Fri, 20 Mar 2020 18:42:40 +0000
X-MC-Unique: Rpihu1x7PlGFiVtSHu5gzQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 20 Mar 2020 18:42:39 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 20 Mar 2020 18:42:39 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@arndb.de>,
        Guru Das Srinagesh <gurus@codeaurora.org>
CC:     Linux PWM List <linux-pwm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Subject: RE: [PATCH v11 11/12] clk: pwm: Assign u64 divisor to unsigned int
 before use
Thread-Topic: [PATCH v11 11/12] clk: pwm: Assign u64 divisor to unsigned int
 before use
Thread-Index: AQHV/tkrw1kYAaX6uEKWXuZ3TfBb1KhR0DSQ
Date:   Fri, 20 Mar 2020 18:42:39 +0000
Message-ID: <9943d663c74046d798f4614343f25187@AcuMS.aculab.com>
References: <cover.1584667964.git.gurus@codeaurora.org>
 <ab7b568b1d287949276b3b1c9efdb1cad1f92004.1584667964.git.gurus@codeaurora.org>
 <CAK8P3a0XrYGYBQ_hTKF4fVBr7DDZsLnR+8o=09cig_gAje=v3w@mail.gmail.com>
In-Reply-To: <CAK8P3a0XrYGYBQ_hTKF4fVBr7DDZsLnR+8o=09cig_gAje=v3w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAyMCBNYXJjaCAyMDIwIDE3OjAxDQo+IE9uIEZy
aSwgTWFyIDIwLCAyMDIwIGF0IDI6NDIgQU0gR3VydSBEYXMgU3JpbmFnZXNoIDxndXJ1c0Bjb2Rl
YXVyb3JhLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBTaW5jZSB0aGUgUFdNIGZyYW1ld29yayBpcyBz
d2l0Y2hpbmcgc3RydWN0IHB3bV9hcmdzLnBlcmlvZCdzIGRhdGF0eXBlDQo+ID4gdG8gdTY0LCBw
cmVwYXJlIGZvciB0aGlzIHRyYW5zaXRpb24gYnkgYXNzaWduaW5nIHRoZSA2NC1iaXQgZGl2aXNv
ciB0bw0KPiA+IGFuIHVuc2lnbmVkIGludCB2YXJpYWJsZSB0byB1c2UgYXMgdGhlIGRpdmlzb3Iu
IFRoaXMgaXMgYmVpbmcgZG9uZQ0KPiA+IGJlY2F1c2UgdGhlIGRpdmlzb3IgaXMgYSAzMi1iaXQg
Y29uc3RhbnQgYW5kIHRoZSBxdW90aWVudCB3aWxsIGJlIHplcm8NCj4gPiBpZiB0aGUgZGl2aXNv
ciBleGNlZWRzIDJeMzIuDQo+ID4NCj4gPiBDYzogTWljaGFlbCBUdXJxdWV0dGUgPG10dXJxdWV0
dGVAYmF5bGlicmUuY29tPg0KPiA+IENjOiBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+
DQo+ID4gQ2M6IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmcNCj4gPiBDYzogRGF2aWQgTGFpZ2h0
IDxEYXZpZC5MYWlnaHRAQUNVTEFCLkNPTT4NCj4gPg0KPiA+IFJlcG9ydGVkLWJ5OiBrYnVpbGQg
dGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBHdXJ1IERhcyBT
cmluYWdlc2ggPGd1cnVzQGNvZGVhdXJvcmEub3JnPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2Ns
ay9jbGstcHdtLmMgfCA0ICsrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2Nsay1w
d20uYyBiL2RyaXZlcnMvY2xrL2Nsay1wd20uYw0KPiA+IGluZGV4IDg3ZmUwYjBlLi5jMGI1ZGEz
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL2Nsay1wd20uYw0KPiA+ICsrKyBiL2RyaXZl
cnMvY2xrL2Nsay1wd20uYw0KPiA+IEBAIC03Miw2ICs3Miw3IEBAIHN0YXRpYyBpbnQgY2xrX3B3
bV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAgICAgICAgc3RydWN0
IHB3bV9kZXZpY2UgKnB3bTsNCj4gPiAgICAgICAgIHN0cnVjdCBwd21fYXJncyBwYXJnczsNCj4g
PiAgICAgICAgIGNvbnN0IGNoYXIgKmNsa19uYW1lOw0KPiA+ICsgICAgICAgdW5zaWduZWQgaW50
IHBlcmlvZDsNCj4gPiAgICAgICAgIGludCByZXQ7DQo+ID4NCj4gPiAgICAgICAgIGNsa19wd20g
PSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwgc2l6ZW9mKCpjbGtfcHdtKSwgR0ZQX0tFUk5FTCk7
DQo+ID4gQEAgLTg4LDggKzg5LDkgQEAgc3RhdGljIGludCBjbGtfcHdtX3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFM
Ow0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4gKyAgICAgICBwZXJpb2QgPSBwYXJncy5wZXJpb2Q7
DQo+ID4gICAgICAgICBpZiAob2ZfcHJvcGVydHlfcmVhZF91MzIobm9kZSwgImNsb2NrLWZyZXF1
ZW5jeSIsICZjbGtfcHdtLT5maXhlZF9yYXRlKSkNCj4gPiAtICAgICAgICAgICAgICAgY2xrX3B3
bS0+Zml4ZWRfcmF0ZSA9IE5TRUNfUEVSX1NFQyAvIHBhcmdzLnBlcmlvZDsNCj4gPiArICAgICAg
ICAgICAgICAgY2xrX3B3bS0+Zml4ZWRfcmF0ZSA9IE5TRUNfUEVSX1NFQyAvIHBlcmlvZDsNCj4g
Pg0KPiA+ICAgICAgICAgaWYgKHBhcmdzLnBlcmlvZCAhPSBOU0VDX1BFUl9TRUMgLyBjbGtfcHdt
LT5maXhlZF9yYXRlICYmDQo+ID4gICAgICAgICAgICAgcGFyZ3MucGVyaW9kICE9IERJVl9ST1VO
RF9VUChOU0VDX1BFUl9TRUMsIGNsa19wd20tPmZpeGVkX3JhdGUpKSB7DQo+IA0KPiBEb2Vzbid0
IHRoaXMgb25lIG5lZWQgYSBjaGVjayBmb3IgInBhcmdzLnBlcmlvZD5VSU5UX01BWCIgb3INCj4g
InBhcmdzLnBlcmlvZCA+IE5TRUNfUEVSX1NFQyI/DQo+IA0KPiBJdCBsb29rcyBsaWtlIHRydW5j
YXRpbmcgdGhlIDY0LWJpdCB2YWx1ZSB0byBhIDMyLWJpdCB0eXBlIGNhbiByZXN1bHQgaW4NCj4g
dW5leHBlY3RlZCBiZWhhdmlvci4NCg0KSSBhbHNvIHN1c3BlY3QgdGhlIGxhc3QgdHdvIGxpbmVz
IG91Z2h0IHRvIHVzZSB0aGUgMzJiaXQgY29weS4NCkFuZCB0aGVyZSBpcyBhIGNoYW5jZSB0aGF0
IHRoZSBkaXZpc2lvbiB3aWxsIGV4cGxvZGUuDQoNClRoaXMgd2hvbGUgc2VyaWVzIGlzIGZhaWxp
bmcgdG8gZGlmZmVyZW50aWF0ZSBiZXR3ZWVuIHRoZSB0eXBlIG9mDQp0aGUgdmFyaWFibGVzIGFu
ZCB0aGUgZG9tYWluIG9uIHRoZSB2YWxpZCB2YWx1ZXMuDQoNCglEYXZpZA0KDQotDQpSZWdpc3Rl
cmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtl
eW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

