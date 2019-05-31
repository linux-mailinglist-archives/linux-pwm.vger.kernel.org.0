Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7073830B64
	for <lists+linux-pwm@lfdr.de>; Fri, 31 May 2019 11:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfEaJYu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 31 May 2019 05:24:50 -0400
Received: from mail-eopbgr1400138.outbound.protection.outlook.com ([40.107.140.138]:39264
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726002AbfEaJYu (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 31 May 2019 05:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/ne1xRapNZEhnOv7WhMtaNYYSHqEB6mi+cjfTXPMXg=;
 b=dEbW0y01UOdLDYQxDXvP9YZL5dkoVPXiDrcVP63q2c3sWxfyN/NCLQ+2ou6zrbQ6wv29gcC4VrVTl7G2Qxb5oqShlX3RYONau0ObrVmEujg7RxEx4ElrkBrUbddhisfDaKg9yfmVOspF2IEGd1suv97QkHlHqwB4vP61+liBFqA=
Received: from OSAPR01MB3089.jpnprd01.prod.outlook.com (52.134.247.150) by
 OSAPR01MB4452.jpnprd01.prod.outlook.com (20.179.178.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Fri, 31 May 2019 09:24:05 +0000
Received: from OSAPR01MB3089.jpnprd01.prod.outlook.com
 ([fe80::4597:5353:28fb:cfd8]) by OSAPR01MB3089.jpnprd01.prod.outlook.com
 ([fe80::4597:5353:28fb:cfd8%7]) with mapi id 15.20.1922.017; Fri, 31 May 2019
 09:24:05 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 3/4] pwm: sysfs: Add suspend/resume support
Thread-Topic: [PATCH v2 3/4] pwm: sysfs: Add suspend/resume support
Thread-Index: AQHVFtFgelJOStFD7EqEp2TCIHDKpKaE2OiAgAAeOdA=
Date:   Fri, 31 May 2019 09:24:05 +0000
Message-ID: <OSAPR01MB3089E0190A76CBB56FBA3932D8190@OSAPR01MB3089.jpnprd01.prod.outlook.com>
References: <1559211367-25106-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1559211367-25106-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdXVVOvoZ4S9LC=RD_8r-XJ6tPt512rONjv8QEK0L=akww@mail.gmail.com>
In-Reply-To: <CAMuHMdXVVOvoZ4S9LC=RD_8r-XJ6tPt512rONjv8QEK0L=akww@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7a9c806-ce23-4817-3bfa-08d6e5a9ba24
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:OSAPR01MB4452;
x-ms-traffictypediagnostic: OSAPR01MB4452:
x-microsoft-antispam-prvs: <OSAPR01MB445278715F95F39DD2A9A507D8190@OSAPR01MB4452.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(346002)(366004)(39860400002)(199004)(189003)(305945005)(74316002)(81166006)(2906002)(8936002)(9686003)(7736002)(8676002)(81156014)(256004)(478600001)(229853002)(14444005)(14454004)(86362001)(55016002)(316002)(6916009)(68736007)(76116006)(5660300002)(6116002)(26005)(25786009)(15650500001)(102836004)(66946007)(6436002)(6506007)(52536014)(66476007)(66446008)(76176011)(71200400001)(476003)(71190400001)(486006)(446003)(186003)(53936002)(7696005)(3846002)(11346002)(64756008)(53546011)(6246003)(54906003)(73956011)(99286004)(33656002)(66556008)(4326008)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:OSAPR01MB4452;H:OSAPR01MB3089.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PfU6JkPp9T/8MDq3/KmR5nKZt2ZqCkMYyHw1ee/MMU3s/WeTN/HOkQ7Dr+D4jK98o4KQ9L19+BGcc0TG87C5UWoAKyEiOVelGiv6/ldCPnlEWeMtrHxp7TCUZ2i2Ammqlsn5aiB5sZ9ikPqH5dstoiV4ZuplR7HL6KeAXcWMkeMlQ2XmGZnf+yckm4U92gRZF1O0IvMiNVn76PCx2X0pPoY76zMDbIsYAoGi0zBqrDN2bQhLNrODZ5YoSgbIINDamElzvPTqj5u8VIJpEbQSat1aqK3u5+6wn9q/dbPRpl1tmHOzX8+OQ5YjAlzQST4UIyj6b0x3xanZxqyd2BKblCukJAcxpewHYsHEA2WMuf3z2MqxPexeDQ6AtfGQ25CghxAljYwRXu9cG0GbyCbwUB8Sjl5QeD434qLSNaruh1M=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a9c806-ce23-4817-3bfa-08d6e5a9ba24
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 09:24:05.3175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoshihiro.shimoda.uh@renesas.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4452
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgR2VlcnQtc2FuLA0KDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiwgU2VudDogRnJpZGF5
LCBNYXkgMzEsIDIwMTkgNDozNCBQTQ0KPiANCj4gSGkgU2hpbW9kYS1zYW4sDQo+IA0KPiBPbiBU
aHUsIE1heSAzMCwgMjAxOSBhdCAxMjoyMSBQTSBZb3NoaWhpcm8gU2hpbW9kYQ0KPiA8eW9zaGlo
aXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+IEFjY29yZGluZyB0byB0aGUg
RG9jdW1lbnRhdGlvbi9wd20udHh0LCBhbGwgUFdNIGNvbnN1bWVycyBzaG91bGQgaGF2ZQ0KPiA+
IHBvd2VyIG1hbmFnZW1lbnQuIFNpbmNlIHRoaXMgc3lzZnMgaW50ZXJmYWNlIGlzIG9uZSBvZiBj
b25zdW1lcnMgc28gdGhhdA0KPiA+IHRoaXMgcGF0Y2ggYWRkcyBzdXNwZW5kL3Jlc3VtZSBzdXBw
b3J0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWW9zaGloaXJvIFNoaW1vZGEgPHlvc2hpaGly
by5zaGltb2RhLnVoQHJlbmVzYXMuY29tPg0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0K
PiANCj4gUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlk
ZXIuYmU+DQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXZpZXchDQpJJ2xsIGFkZCBjb21tZW50cyB5
b3UgZGVzY3JpYmVkIG9uIHYzIHBhdGNoLg0KDQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8gU2hp
bW9kYQ0KDQo+ID4gLS0tIGEvZHJpdmVycy9wd20vc3lzZnMuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
cHdtL3N5c2ZzLmMNCj4gDQo+ID4gQEAgLTM3MiwxMCArMzczLDEwOSBAQCBzdGF0aWMgc3RydWN0
IGF0dHJpYnV0ZSAqcHdtX2NoaXBfYXR0cnNbXSA9IHsNCj4gPiAgfTsNCj4gPiAgQVRUUklCVVRF
X0dST1VQUyhwd21fY2hpcCk7DQo+ID4NCj4gDQo+IFlvdSBtYXkgd2FudCB0byBhZGQgYSBjb21t
ZW50ICJ0YWtlcyBleHBvcnQtPmxvY2sgb24gc3VjY2VzcyIgaGVyZS4uLg0KPiANCj4gPiArc3Rh
dGljIHN0cnVjdCBwd21fZXhwb3J0ICpwd21fY2xhc3NfZ2V0X3N0YXRlKHN0cnVjdCBkZXZpY2Ug
KnBhcmVudCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc3RydWN0IHB3bV9kZXZpY2UgKnB3bSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHB3bV9zdGF0ZSAqc3RhdGUpDQo+ID4gK3sNCj4g
PiArICAgICAgIHN0cnVjdCBkZXZpY2UgKmNoaWxkOw0KPiA+ICsgICAgICAgc3RydWN0IHB3bV9l
eHBvcnQgKmV4cG9ydDsNCj4gPiArDQo+ID4gKyAgICAgICBpZiAoIXRlc3RfYml0KFBXTUZfRVhQ
T1JURUQsICZwd20tPmZsYWdzKSkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7DQo+
ID4gKw0KPiA+ICsgICAgICAgY2hpbGQgPSBkZXZpY2VfZmluZF9jaGlsZChwYXJlbnQsIHB3bSwg
cHdtX3VuZXhwb3J0X21hdGNoKTsNCj4gPiArICAgICAgIGlmICghY2hpbGQpDQo+ID4gKyAgICAg
ICAgICAgICAgIHJldHVybiBOVUxMOw0KPiA+ICsNCj4gPiArICAgICAgIGV4cG9ydCA9IGNoaWxk
X3RvX3B3bV9leHBvcnQoY2hpbGQpOw0KPiA+ICsgICAgICAgcHV0X2RldmljZShjaGlsZCk7ICAg
ICAgLyogZm9yIGRldmljZV9maW5kX2NoaWxkKCkgKi8NCj4gPiArDQo+ID4gKyAgICAgICBtdXRl
eF9sb2NrKCZleHBvcnQtPmxvY2spOw0KPiA+ICsgICAgICAgcHdtX2dldF9zdGF0ZShwd20sIHN0
YXRlKTsNCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gZXhwb3J0Ow0KPiA+ICt9DQo+ID4gKw0K
PiA+ICtzdGF0aWMgaW50IHB3bV9jbGFzc19hcHBseV9zdGF0ZShzdHJ1Y3QgcHdtX2V4cG9ydCAq
ZXhwb3J0LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBwd21f
ZGV2aWNlICpwd20sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IHB3bV9zdGF0ZSAqc3RhdGUpDQo+ID4gK3sNCj4gPiArICAgICAgIGludCByZXQgPSBwd21fYXBw
bHlfc3RhdGUocHdtLCBzdGF0ZSk7DQo+ID4gKw0KPiANCj4gLi4uIGFuZCAicmVsZWFzZSBsb2Nr
IHRha2VuIGluIHB3bV9jbGFzc19nZXRfc3RhdGUoKSIgaGVyZS4NCj4gDQo+ID4gKyAgICAgICBt
dXRleF91bmxvY2soJmV4cG9ydC0+bG9jayk7DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0dXJuIHJl
dDsNCj4gPiArfQ0KPiANCj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+IA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICBHZWVydA0KPiANCj4gLS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJl
J3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC1tNjhrLm9yZw0KPiAN
Cj4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2Fs
bCBteXNlbGYgYSBoYWNrZXIuIEJ1dA0KPiB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3Rz
IEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==
