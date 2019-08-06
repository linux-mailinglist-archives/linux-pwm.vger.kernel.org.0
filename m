Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 930B1830CB
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Aug 2019 13:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbfHFLia (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Aug 2019 07:38:30 -0400
Received: from mail-eopbgr1400108.outbound.protection.outlook.com ([40.107.140.108]:22208
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726783AbfHFLia (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 6 Aug 2019 07:38:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBTu1D6W/isQ7QfZtveB+N8IthR+i27J0VP96KXhwCk39uW1WQ470BSReG9aJPlSVxOEf410fXER1lKkLNvlEnys/qgDdWv4u5n8PRxfVhK4xk6Z6HYY1Xm+SClD/PoxqrdTsrlN5aNzg0rRnfOEyvyxvF+P6KREOYInB1jZNkFrKtk5Xo40XTywekJ0NFL4vD5GNQe8jLq1fvcmeoCzzM7Fnqu+WcT1g7kSBo6rZsDt8rlo3i+sMMb4ir5xt+6GswzDcrsmdhoPyWwOKdo5FYdbjyI8nyzpBdg2fovN4DCxIvykR1oAOfoK2QyLKlJ91XKJc6QSCKahKtaunwsvTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCG9UeMOzQtcXIOhWaV0HHr6QziKGLFthWi0p9PGI2I=;
 b=i5t6kZ3Ai0UoOLMIE91tDShcY9Y+Rz2x/CICyJ2bkOQNrjf0hvmdkJOkngQZyB61muqwobQHisEY+hv3tu1m/rzEFnNe1Vuq53pndr/ihmnT5widVOfjsrkuKP24ngnUqpSDJfHIu5j/kmKDnIkNWSobd+hWrS4HCJ5Sm198HsNsq6V9qw2EjouuEjWxM+fT8RmJU8v3EypfkQUHHerwO3+ge6JVqhdmBjwB8jg6VUGB4vg9yLtB1ZuK942o0Fie1UaW2qUVklCdo40gaomsjQct4bUr8xXsaBS3sCjBWD6mBnK6rWMqgv6cGg6e0tiuCzxjfdNSjiDtk95jhOXPGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=renesas.com;dmarc=pass action=none
 header.from=renesas.com;dkim=pass header.d=renesas.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCG9UeMOzQtcXIOhWaV0HHr6QziKGLFthWi0p9PGI2I=;
 b=D+9d9lecneP8m8LwwVigkNdnSsd6J4DR2Ff2eSN4x6huKkGzt5EyfRqcPTstzYKo1rLlDblyjSpZxNb+gEwgdNh2qiZRbrvpJh8wMXvBScc/lHwVMV1mx8Wx7R9typby7OyAUhklIwAU3DQTyf4mwgtg8zyajPDtzzqfwGoTUF4=
Received: from OSBPR01MB4536.jpnprd01.prod.outlook.com (20.179.180.215) by
 OSBPR01MB2197.jpnprd01.prod.outlook.com (52.134.243.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Tue, 6 Aug 2019 11:38:26 +0000
Received: from OSBPR01MB4536.jpnprd01.prod.outlook.com
 ([fe80::106b:32d9:ab57:e8f3]) by OSBPR01MB4536.jpnprd01.prod.outlook.com
 ([fe80::106b:32d9:ab57:e8f3%3]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 11:38:26 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH RFC 3/7] pinctrl: sh-pfc: Rollback to mux if requires when
 the gpio is freed
Thread-Topic: [PATCH RFC 3/7] pinctrl: sh-pfc: Rollback to mux if requires
 when the gpio is freed
Thread-Index: AQHVNWy6eHnOvgkEkUeqA+2lf9UeCabuAJWAgAAhzqA=
Date:   Tue, 6 Aug 2019 11:38:25 +0000
Message-ID: <OSBPR01MB4536870EEEE634B06199722ED8D50@OSBPR01MB4536.jpnprd01.prod.outlook.com>
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1562576868-8124-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdUAVGbvn0D=UkqhY6RpO70MR-4GBC8i931a+fV9f6+njg@mail.gmail.com>
In-Reply-To: <CAMuHMdUAVGbvn0D=UkqhY6RpO70MR-4GBC8i931a+fV9f6+njg@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e7def66-c597-47f6-426e-08d71a62985c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:OSBPR01MB2197;
x-ms-traffictypediagnostic: OSBPR01MB2197:
x-microsoft-antispam-prvs: <OSBPR01MB2197AEE887A9293A19EBD98ED8D50@OSBPR01MB2197.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(52314003)(199004)(189003)(76176011)(53936002)(33656002)(76116006)(6436002)(81156014)(8676002)(52536014)(86362001)(316002)(6506007)(7696005)(53546011)(54906003)(5660300002)(186003)(55016002)(81166006)(229853002)(102836004)(99286004)(9686003)(8936002)(71190400001)(476003)(14454004)(66066001)(4326008)(25786009)(6116002)(3846002)(68736007)(486006)(14444005)(26005)(446003)(478600001)(66556008)(66476007)(66946007)(64756008)(7736002)(305945005)(7416002)(6246003)(6916009)(71200400001)(2906002)(256004)(74316002)(11346002)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2197;H:OSBPR01MB4536.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Mt7gtxma2edl5oWjpgzvuMLTbPokCZuZSOotfJ6Huj9eAe1ZjyUoN+cV/l+Lu9Ld+0dfXhjf/v2J61LewmTbevHnTShBGO6r2z/YSWlEsLSEhCPlMuLw6MFbZftrf7cvqeU4FmCoCrg2hl1Y1eNIOHgOC1IQ5qIqq1hiWPkU73RDPxlu6l35Ac5SBUOvUbNV2yZJ2CCfgFSDty1Go0UudMO3nr+Uj1i4ELuasDojyVhgk9dBvxONvgITOHGHJLxbS1JWy55cFhFBpLMgyGwZb+Rwy2a6e7EMhc7m0FLj9FfK1DA6uDu4DtYLJYXBTeHfF6m6VuYf5Ykt7HhZpF5CCIQVba/KeA92dmUeTMGN6Z7m2DREUWv4Yx/Qya+KjznkPtPsjvrgVXB0fM/lTT0EW0nkFmOGwyqi/5zoVxMsTXY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e7def66-c597-47f6-426e-08d71a62985c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 11:38:25.9585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoshihiro.shimoda.uh@renesas.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2197
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgR2VlcnQtc2FuLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3IQ0KDQo+IEZyb206IEdl
ZXJ0IFV5dHRlcmhvZXZlbiwgU2VudDogVHVlc2RheSwgQXVndXN0IDYsIDIwMTkgNjowMyBQTQ0K
PiANCj4gSGkgU2hpbW9kYS1zYW4sDQo+IA0KPiBPbiBNb24sIEp1bCA4LCAyMDE5IGF0IDExOjA4
IEFNIFlvc2hpaGlybyBTaGltb2RhDQo+IDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNv
bT4gd3JvdGU6DQo+ID4gUi1DYXIgUFdNIGNvbnRyb2xsZXIgcmVxdWlyZXMgdGhlIGdwaW8gdG8g
b3V0cHV0IHplcm8gZHV0eSwNCj4gPiB0aGlzIHBhdGNoIGFsbG93cyB0byByb2xsIGl0IGJhY2sg
ZnJvbSBncGlvIHRvIG11eCB3aGVuIHRoZSBncGlvDQo+ID4gaXMgZnJlZWQuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBZb3NoaWhpcm8gU2hpbW9kYSA8eW9zaGloaXJvLnNoaW1vZGEudWhAcmVu
ZXNhcy5jb20+DQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+IA0KPiA+IC0tLSBhL2Ry
aXZlcnMvcGluY3RybC9zaC1wZmMvcGluY3RybC5jDQo+ID4gKysrIGIvZHJpdmVycy9waW5jdHJs
L3NoLXBmYy9waW5jdHJsLmMNCj4gPiBAQCAtMjYsNiArMjYsNyBAQA0KPiA+ICAjaW5jbHVkZSAi
Li4vcGluY29uZi5oIg0KPiA+DQo+ID4gIHN0cnVjdCBzaF9wZmNfcGluX2NvbmZpZyB7DQo+ID4g
KyAgICAgICB1bnNpZ25lZCBpbnQgbXV4X21hcms7DQo+IA0KPiBEdWUgdG8gcGFkZGluZywgYWRk
aW5nIHRoaXMgZmllbGQgd2lsbCBpbmNyZWFzZSBtZW1vcnkgY29uc3VtcHRpb24gYnkNCj4gNiBi
eXRlcyBwZXIgcGluLg0KDQpJIHNlZS4NCg0KPiBQcm9iYWJseSBzaF9wZmNfcGluX2dyb3VwLntw
aW5zLG11eH0gc2hvdWxkIGJlIGNoYW5nZWQgZnJvbSB1bnNpZ25lZCBpbnQNCj4gdG8gdTE2LCBi
dXQgdGhhdCdzIG91dCBvZiBzY29wZSBmb3IgdGhpcyBwYXRjaC4NCg0KSSBnb3QgaXQuDQoNCj4g
PiAgICAgICAgIGJvb2wgbXV4X3NldDsNCj4gPiAgICAgICAgIGJvb2wgZ3Bpb19lbmFibGVkOw0K
PiA+ICB9Ow0KPiA+IEBAIC0zNTMsNiArMzU0LDE1IEBAIHN0YXRpYyBpbnQgc2hfcGZjX2Z1bmNf
c2V0X211eChzdHJ1Y3QgcGluY3RybF9kZXYgKnBjdGxkZXYsIHVuc2lnbmVkIHNlbGVjdG9yLA0K
PiA+ICAgICAgICAgc3Bpbl9sb2NrX2lycXNhdmUoJnBmYy0+bG9jaywgZmxhZ3MpOw0KPiA+DQo+
ID4gICAgICAgICBmb3IgKGkgPSAwOyBpIDwgZ3JwLT5ucl9waW5zOyArK2kpIHsNCj4gPiArICAg
ICAgICAgICAgICAgaW50IGlkeCA9IHNoX3BmY19nZXRfcGluX2luZGV4KHBmYywgZ3JwLT5waW5z
W2ldKTsNCj4gPiArICAgICAgICAgICAgICAgc3RydWN0IHNoX3BmY19waW5fY29uZmlnICpjZmcg
PSAmcG14LT5jb25maWdzW2lkeF07DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICAvKg0KPiA+
ICsgICAgICAgICAgICAgICAgKiBUaGlzIGRvZXNuJ3QgYXNzdW1lIHRoZSBvcmRlciB3aGljaCBn
cGlvcyBhcmUgZW5hYmxlZA0KPiA+ICsgICAgICAgICAgICAgICAgKiBhbmQgdGhlbiBtdXggaXMg
c2V0Lg0KPiANCj4gSSdtIHNvcnJ5LCBJIGRvbid0IHVuZGVyc3RhbmQgd2hhdCB5b3UgbWVhbj8N
Cj4gQ2FuIHlvdSBwbGVhc2UgcmV3b3JkIG9yIGVsYWJvcmF0ZT8NCg0KSSB3YXMgYWxzbyBkaWZm
aWN1bHQgdG8gcmVtZW1iZXIgd2hhdCBJIG1lYW50Li4uDQpBbnl3YXksIHRoaXMgbWVhbnQsDQog
MSkgaWYgYSBkZXZpY2UgaGFzIHRoZSBkZWZhdWx0IHBpbmN0cmwtMCBwcm9wZXJ0eSwgdGhlIHNl
dF9tdXgoKSBvcHMgaXMgY2FsbGVkDQogICAgYmVmb3JlIHRoZSBkZXZpY2UgZHJpdmVyJ3MgcHJv
YmUoKSBmdW5jdGlvbiBpcyBjYWxsZWQgYnkgcGluY3RybF9iaW5kX3BpbnMoKSBmaXJzdCwNCiAy
KSBzbyB0aGF0IGFueSBkZXZpY2UgZHJpdmVycyBjYW5ub3QgY2FsbCBncGlvZF9nZXQoKSBiZWZv
cmUgdGhlIDEpLg0KDQpIb3dldmVyLCB0aGlzIGNvbW1lbnRzIGRvbid0IGNvdmVyIGFuIGltYmFs
YW5jZSBwaW5jdHJsL2dwaW8gaGFuZGxpbmcuDQpGb3IgZXhhbXBsZSAoYXMgcHNldWRvKToNCiAt
IFNDSUYgZHJpdmVyIHVzZXMgU0NJRjIgcGluY3RybCwNCiAtIGJ1dCwgSU9NTVUgZHJpdmVyIGdl
dHMgdGhlIFNDSUYyIHBpbnMgYmVmb3JlIFNDSUYgZHJpdmVyIGlzIHByb2JlZC4NCg0KU28sIEkn
ZCBsaWtlIHRvIHJldmlzZSB0aGUgY29tbWVudHMgYXMgZm9sbG93aW5nLiBXaGF0IGRvIHlvdSB0
aGluaz8NCg0KLS0NClRoaXMgZHJpdmVyIGNhbm5vdCBtYW5hZ2UgYm90aCBncGlvIGFuZCBtdXgg
d2hlbiB0aGUgZ3BpbyBwaW4NCmlzIGFscmVhZHkgZW5hYmxlZC4gU28sIHRoaXMgZnVuY3Rpb24g
ZmFpbGVkLg0KLS0NCg0KPiA+ICsgICAgICAgICAgICAgICAgKi8NCj4gPiArICAgICAgICAgICAg
ICAgV0FSTl9PTihjZmctPmdwaW9fZW5hYmxlZCk7DQo+IA0KPiBDYW4gdGhpcyBhY3R1YWxseSBo
YXBwZW4/DQoNClRoaXMgY2Fubm90IGhhcHBlbiBhY3R1YWxseS4NCg0KPiBTaG91bGQgdGhpcyBj
YXVzZSBhIGZhaWx1cmUgaW5zdGVhZD8NCg0KSSB0aGluayBzby4NCg0KPiA+ICsNCj4gPiAgICAg
ICAgICAgICAgICAgcmV0ID0gc2hfcGZjX2NvbmZpZ19tdXgocGZjLCBncnAtPm11eFtpXSwgUElO
TVVYX1RZUEVfRlVOQ1RJT04pOw0KPiA+ICAgICAgICAgICAgICAgICBpZiAocmV0IDwgMCkNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGRvbmU7DQo+ID4gQEAgLTM2NCw2ICszNzQs
NyBAQCBzdGF0aWMgaW50IHNoX3BmY19mdW5jX3NldF9tdXgoc3RydWN0IHBpbmN0cmxfZGV2ICpw
Y3RsZGV2LCB1bnNpZ25lZCBzZWxlY3RvciwNCj4gPiAgICAgICAgICAgICAgICAgc3RydWN0IHNo
X3BmY19waW5fY29uZmlnICpjZmcgPSAmcG14LT5jb25maWdzW2lkeF07DQo+ID4NCj4gPiAgICAg
ICAgICAgICAgICAgY2ZnLT5tdXhfc2V0ID0gdHJ1ZTsNCj4gPiArICAgICAgICAgICAgICAgY2Zn
LT5tdXhfbWFyayA9IGdycC0+bXV4W2ldOw0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4gIGRvbmU6
DQo+ID4gQEAgLTQxNyw2ICs0MjgsOSBAQCBzdGF0aWMgdm9pZCBzaF9wZmNfZ3Bpb19kaXNhYmxl
X2ZyZWUoc3RydWN0IHBpbmN0cmxfZGV2ICpwY3RsZGV2LA0KPiA+DQo+ID4gICAgICAgICBzcGlu
X2xvY2tfaXJxc2F2ZSgmcGZjLT5sb2NrLCBmbGFncyk7DQo+ID4gICAgICAgICBjZmctPmdwaW9f
ZW5hYmxlZCA9IGZhbHNlOw0KPiA+ICsgICAgICAgLyogSWYgbXV4IGlzIGFscmVhZHkgc2V0LCB0
aGlzIGNvbmZpZ3VyZSBpdCBoZXJlICovDQo+IA0KPiBjb25maWd1cmVzDQoNCk9vcHMhIEknbGwg
Zml4IGl0Lg0KDQo+ID4gKyAgICAgICBpZiAoY2ZnLT5tdXhfc2V0KQ0KPiA+ICsgICAgICAgICAg
ICAgICBzaF9wZmNfY29uZmlnX211eChwZmMsIGNmZy0+bXV4X21hcmssIFBJTk1VWF9UWVBFX0ZV
TkNUSU9OKTsNCj4gDQo+IEhhdmUgeW91IGNvbnNpZGVyZWQgdGhlIGNhc2Ugd2hlcmUgbW9yZSB0
aGFuIG9uZSBwaW4gb2YgYSBwaW5tdXggZ3JvdXANCj4gd2FzIHVzZWQgYXMgYSBHUElPPyBJbiB0
aGF0IGNhc2Ugc2hfcGZjX2dwaW9fZGlzYWJsZV9mcmVlKCkgd2lsbCBiZSBjYWxsZWQNCj4gbXVs
dGlwbGUgdGltZXMsIHBvc3NpYmx5IHdpdGggdGhlIHNhbWUgbXV4X21hcmsuDQoNCkkgaGF2ZW4n
dCBjb25zaWRlcmVkIHRoZSBjYXNlLiBCdXQsIGFib3V0IHRoZSBtdXhfbWFyaywgSSBjaGVja2Vk
IHRoZSB2YWx1ZXMgYW5kIHRoZW4NCnRoZXkgYXJlIG5vdCB0aGUgc2FtZS4NCg0KRm9yIGV4YW1w
bGUgKGRlYnVnIHByaW50ayBwYXRjaCk6DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9waW5jdHJsL3No
LXBmYy9waW5jdHJsLmMgYi9kcml2ZXJzL3BpbmN0cmwvc2gtcGZjL3BpbmN0cmwuYw0KaW5kZXgg
YmMyOTA2Ni4uZmRhYzcxYiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcGluY3RybC9zaC1wZmMvcGlu
Y3RybC5jDQorKysgYi9kcml2ZXJzL3BpbmN0cmwvc2gtcGZjL3BpbmN0cmwuYw0KQEAgLTM0OSw3
ICszNDksNyBAQCBzdGF0aWMgaW50IHNoX3BmY19mdW5jX3NldF9tdXgoc3RydWN0IHBpbmN0cmxf
ZGV2ICpwY3RsZGV2LCB1bnNpZ25lZCBzZWxlY3RvciwNCiAJdW5zaWduZWQgaW50IGk7DQogCWlu
dCByZXQgPSAwOw0KIA0KLQlkZXZfZGJnKHBjdGxkZXYtPmRldiwgIkNvbmZpZ3VyaW5nIHBpbiBn
cm91cCAlc1xuIiwgZ3JwLT5uYW1lKTsNCisJZGV2X2luZm8ocGN0bGRldi0+ZGV2LCAiQ29uZmln
dXJpbmcgcGluIGdyb3VwICVzXG4iLCBncnAtPm5hbWUpOw0KIA0KIAlzcGluX2xvY2tfaXJxc2F2
ZSgmcGZjLT5sb2NrLCBmbGFncyk7DQogDQpAQCAtMzc1LDYgKzM3NSw3IEBAIHN0YXRpYyBpbnQg
c2hfcGZjX2Z1bmNfc2V0X211eChzdHJ1Y3QgcGluY3RybF9kZXYgKnBjdGxkZXYsIHVuc2lnbmVk
IHNlbGVjdG9yLA0KIA0KIAkJY2ZnLT5tdXhfc2V0ID0gdHJ1ZTsNCiAJCWNmZy0+bXV4X21hcmsg
PSBncnAtPm11eFtpXTsNCisJCWRldl9pbmZvKHBjdGxkZXYtPmRldiwgIiVkOiAleFxuIiwgaSwg
Y2ZnLT5tdXhfbWFyayk7DQogCX0NCiANCiBkb25lOg0KLS0gDQoyLjcuNA0KDQpGb3IgZXhhbXBs
ZSAobG9nKToNClsgICAgMC40OTc2NDddIHNoLXBmYyBlNjA2MDAwMC5waW4tY29udHJvbGxlcjog
Q29uZmlndXJpbmcgcGluIGdyb3VwIHNjaWYyX2RhdGFfYQ0KWyAgICAwLjQ5NzcxMV0gc2gtcGZj
IGU2MDYwMDAwLnBpbi1jb250cm9sbGVyOiAwOiA3N2INClsgICAgMC40OTc3MTVdIHNoLXBmYyBl
NjA2MDAwMC5waW4tY29udHJvbGxlcjogMTogNzYwDQoNCkJlc3QgcmVnYXJkcywNCllvc2hpaGly
byBTaGltb2RhDQoNCj4gSSBkb24ndCB0aGluayB0aGlzIHdpbGwgY2F1c2UgaXNzdWVzLCB0aG91
Z2guDQo+IA0KPiA+ICAgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcGZjLT5sb2NrLCBm
bGFncyk7DQo+ID4gIH0NCj4gDQo+IFRoYW5rcyENCj4gDQo+IEdye29ldGplLGVldGluZ31zLA0K
PiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQNCj4gDQo+IC0tDQo+IEdlZXJ0IFV5
dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRA
bGludXgtbTY4ay5vcmcNCj4gDQo+IEluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNo
bmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLiBCdXQNCj4gd2hlbiBJJ20gdGFs
a2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcg
bGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRv
cnZhbGRzDQo=
