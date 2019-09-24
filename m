Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2906FBC5C3
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Sep 2019 12:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409538AbfIXKni (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Sep 2019 06:43:38 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:28798 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404483AbfIXKni (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Sep 2019 06:43:38 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-116-9Hi8Jc8kPpqqOwcPCfmVPQ-1; Tue, 24 Sep 2019 11:43:36 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 24 Sep 2019 11:43:35 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 24 Sep 2019 11:43:35 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Anson Huang' <anson.huang@nxp.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] pwm: pwm-imx27: Use 'dev' instead of dereferencing it
 repeatedly
Thread-Topic: [PATCH] pwm: pwm-imx27: Use 'dev' instead of dereferencing it
 repeatedly
Thread-Index: AQHVcra7p8HS4HCHSk+GwFkUo51L56c6k17Q///1BACAABgw0A==
Date:   Tue, 24 Sep 2019 10:43:35 +0000
Message-ID: <37b2481ac9094f27bf21325e2770abdb@AcuMS.aculab.com>
References: <1569315593-769-1-git-send-email-Anson.Huang@nxp.com>
 <6cfb1595992b46dc884731555e6f0334@AcuMS.aculab.com>
 <DB3PR0402MB3916FFD66797DAC0AB1110D8F5840@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916FFD66797DAC0AB1110D8F5840@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 9Hi8Jc8kPpqqOwcPCfmVPQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

RnJvbTogQW5zb24gSHVhbmcNCj4gU2VudDogMjQgU2VwdGVtYmVyIDIwMTkgMTE6MDMNCj4gSGks
IERhdmlkDQo+IA0KPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIHB3bTogcHdtLWlteDI3OiBVc2Ug
J2RldicgaW5zdGVhZCBvZiBkZXJlZmVyZW5jaW5nIGl0DQo+ID4gcmVwZWF0ZWRseQ0KPiA+DQo+
ID4gRnJvbTogQW5zb24gSHVhbmcNCj4gPiA+IFNlbnQ6IDI0IFNlcHRlbWJlciAyMDE5IDEwOjAw
DQo+ID4gPiBBZGQgaGVscGVyIHZhcmlhYmxlIGRldiA9ICZwZGV2LT5kZXYgdG8gc2ltcGx5IHRo
ZSBjb2RlLg0KPiA+ID4NCi4uLg0KPiA+ID4gIHN0YXRpYyBpbnQgcHdtX2lteDI3X3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpICB7DQo+ID4gPiArCXN0cnVjdCBkZXZpY2UgKmRl
diA9ICZwZGV2LT5kZXY7DQo+ID4gPiAgCXN0cnVjdCBwd21faW14MjdfY2hpcCAqaW14Ow0KPiA+
ID4NCj4gPiA+IC0JaW14ID0gZGV2bV9remFsbG9jKCZwZGV2LT5kZXYsIHNpemVvZigqaW14KSwg
R0ZQX0tFUk5FTCk7DQo+ID4gPiArCWlteCA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqaW14
KSwgR0ZQX0tFUk5FTCk7DQouLi4NCj4gPiBIb3BlZnVsbHkgdGhlIGNvbXBpbGVyIHdpbGwgb3B0
aW1pc2UgdGhpcyBiYWNrIG90aGVyd2lzZSB5b3UndmUgYWRkZWQNCj4gPiBhbm90aGVyIGxvY2Fs
IHZhcmlhYmxlIHdoaWNoIG1heSBjYXVzZSBzcGlsbGluZyB0byBzdGFjay4NCj4gPiBGb3IgYSBz
ZXR1cCBmdW5jdGlvbiBpdCBwcm9iYWJseSBkb2Vzbid0IG1hdHRlciwgYnV0IGluIGdlbmVyYWwg
aXQgbWlnaHQgaGF2ZSBhDQo+ID4gc21hbGwgbmVnYXRpdmUgcGVyZm9ybWFuY2UgaW1wYWN0Lg0K
PiA+DQo+ID4gSW4gYW55IGNhc2UgdGhpcyBkb2Vzbid0IHNob3J0ZW4gYW55IGxpbmVzIGVub3Vn
aCB0byByZW1vdmUgbGluZS13cmFwIGFuZA0KPiA+IHVzaW5nICZwZGV2LT5kZXYgaXMgcmVhbGx5
IG9uZSBsZXNzIHZhcmlhYmxlIHRvIG1lbnRhbGx5IHRyYWNrIHdoZW4gcmVhZGluZw0KPiA+IHRo
ZSBjb2RlLg0KPiANCj4gRG8gd2Uga25vdyB3aGljaCBjb21waWxlciB3aWxsIG9wdGltaXplIHRo
aXM/IEkgc2F3IG1hbnkgb2YgdGhlIHBhdGNoZXMgZG9pbmcNCj4gdGhpcyB0byBhdm9pZCBhIGxv
dCBvZiBkZXJlZmVyZW5jZSwgSSB1bmRlcnN0YW5kIGl0IGRvZXMgTk9UIHNhdmUgbGluZXMsIGJ1
dCBteSBpbnRlbnRpb24NCj4gaXMgdG8gYXZvaWQgZGVyZWZlcmVuY2Ugd2hpY2ggbWlnaHQgc2F2
ZSBzb21lIGluc3RydWN0aW9ucy4NCj4gDQo+IEkgdGhvdWdodCBzYXZpbmcgaW5zdHJ1Y3Rpb25z
IGlzIG1vcmUgaW1wb3J0YW50LiBTbyBub3cgdGhlcmUgYXJlIGRpZmZlcmVudCBvcGluaW9uIGFi
b3V0DQo+IGRvaW5nIHRoaXM/DQoNClJlbWVtYmVyICZwZGV2LT5kZXYgaXMganVzdCAncGRldiAr
IGNvbnN0YW50Jy4NCkFzc3VtaW5nICdwZGV2JyBpcyBoZWxkIGluIGEgY2FsbGVlIHNhdmVkIHJl
Z2lzdGVyICh3aGljaCB5b3Ugd2FudCBpdCB0byBiZSkgdGhlbiB0byBhY2Nlc3MNCmRldi0+Zm9v
IHRoZSBjb21waWxlciBjYW4gcmVtZW1iZXIgdGhlIGNvbnN0YW50IGFuZCB1c2UgYW4gb2Zmc2V0
IGZyb20gJ3BkZXYnIGluc3RlYWQgb2YNCmFuIGV4dHJhICdkZXYnIHZhcmlhYmxlLg0KT24gbW9z
dCBtb2Rlcm4gQUJJIHRoZSBmaXJzdCBmdW5jdGlvbiBjYWxsIGFyZ3VtZW50cyBhcmUgcGFzc2Vk
IGluIHJlZ2lzdGVycy4NClNvIGFuIGFkZCAgaW5zdHJ1Y3Rpb24gKHByb2JhYmx5IGxlYSkgY2Fu
IGJlIHVzZWQgdG8gYWRkIHRoZSBjb25zdGFudCBvZmZzZXQgYXQgdGhlIHNhbWUNCnRpbWUgYXMg
dGhlIHZhbHVlIGlzIG1vdmVkIGludG8gdGhlIGFyZ3VtZW50IHJlZ2lzdGVyLg0KDQpIb3dldmVy
IHlvdXIgZXh0cmEgdmFyaWFibGUgY291bGQgZWFzaWx5IGdldCBzcGlsbGVkIG91dCB0byB0aGUg
c3RhY2suDQpTbyB5b3UgZ2V0IGFuIGV4dHJhIG1lbW9yeSByZWFkIHJhdGhlciB0aGFuIChhdCBt
b3N0KSBhbiBleHRyYSAnYWRkJyBpbnN0cnVjdGlvbi4NCg0KRXZlbiBpZiBwZGV2LT5kZXYgd2Vy
ZSBhIHBvaW50ZXIsIHJlcGVhdGVkbHkgcmVhZGluZyBpdCBmcm9tIHBkZXYtPmRldiBjb3VsZA0K
ZWFzaWx5IGdlbmVyYXRlIGJldHRlciBjb2RlIHRoYW4gaGF2aW5nIGFuIGV4dHJhIHZhcmlhYmxl
IHRoYXQgd291bGQgbWVhbiB0aGUNCnZhbHVlIHdhcyByZXBlYXRlZGx5IHJlYWQgZnJvbSB0aGUg
c3RhY2suDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1s
ZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJh
dGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

