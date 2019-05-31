Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 713C230B53
	for <lists+linux-pwm@lfdr.de>; Fri, 31 May 2019 11:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfEaJWI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 31 May 2019 05:22:08 -0400
Received: from mail-eopbgr1400095.outbound.protection.outlook.com ([40.107.140.95]:54583
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726158AbfEaJWI (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 31 May 2019 05:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYOWCuMG14mwz2jB+6ExVZ5dHq1oRlWJmqwcL3NQJqs=;
 b=phV7v9XDsijyZh4s5G+akXCdAMmOktpg3ZD1hH/1Q/x+e5hj4q7IbJCwAwvSSAD3drVFw6yNfp9GemC78960G9VQIublbCR/wMoO2eAHFI7uEmoIDdk9VYEeiItmuo0I3nkaFwd0G5v0KgBYglCD3Qw72nKo2FZhkRKWxvIwiK8=
Received: from OSAPR01MB3089.jpnprd01.prod.outlook.com (52.134.247.150) by
 OSAPR01MB2994.jpnprd01.prod.outlook.com (52.134.247.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Fri, 31 May 2019 09:22:03 +0000
Received: from OSAPR01MB3089.jpnprd01.prod.outlook.com
 ([fe80::4597:5353:28fb:cfd8]) by OSAPR01MB3089.jpnprd01.prod.outlook.com
 ([fe80::4597:5353:28fb:cfd8%7]) with mapi id 15.20.1922.017; Fri, 31 May 2019
 09:22:03 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 1/4] pwm: Add power management descriptions
Thread-Topic: [PATCH v2 1/4] pwm: Add power management descriptions
Thread-Index: AQHVFtFhq6z+bSHcO0CWeYpHfVWWtqaE1OgAgAAgImA=
Date:   Fri, 31 May 2019 09:22:03 +0000
Message-ID: <OSAPR01MB3089658CD2E8DF789BA7737FD8190@OSAPR01MB3089.jpnprd01.prod.outlook.com>
References: <1559211367-25106-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1559211367-25106-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdVjOuvUyX3QJP-DOmYt3wzt3NOioDfm_CQhyZvOnGgy6Q@mail.gmail.com>
In-Reply-To: <CAMuHMdVjOuvUyX3QJP-DOmYt3wzt3NOioDfm_CQhyZvOnGgy6Q@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e703895-3a3b-4784-c0a2-08d6e5a971a9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:OSAPR01MB2994;
x-ms-traffictypediagnostic: OSAPR01MB2994:
x-microsoft-antispam-prvs: <OSAPR01MB29941936F102029F40744A7ED8190@OSAPR01MB2994.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(366004)(136003)(39860400002)(199004)(189003)(102836004)(3846002)(25786009)(446003)(99286004)(8936002)(486006)(86362001)(81156014)(76176011)(74316002)(26005)(6116002)(81166006)(54906003)(68736007)(53546011)(7696005)(11346002)(71200400001)(256004)(478600001)(14454004)(71190400001)(476003)(8676002)(73956011)(76116006)(316002)(229853002)(186003)(33656002)(5660300002)(305945005)(52536014)(7736002)(66476007)(53936002)(6246003)(55016002)(4326008)(6916009)(6436002)(6506007)(66066001)(66946007)(66556008)(64756008)(9686003)(66446008)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:OSAPR01MB2994;H:OSAPR01MB3089.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KlLwmC50g2UKUvvjWuiacTE86FQS75dTjZClz9cIgadWy5uc1NhVc+q33GFhRt40K4NvIDhvUZxeBwaeVfDsuI2A5BG4dh2CkiozoRwMkihg7B/+/lyfq9etnwsGFXKqwaVpTuajL+wVsVmwGpoP7OkZmwtKeLZT/QOZ/VGbwAhdnYANyYRBeKKwqv4OetJaVMf9SkPH6tn40zcOCo5cU15NAkzTuhgszXCjL+b20brgHE0v2NKI4bvGuhQzmxcyVQqlLV9eroBEhMiHI4vRNGScW7rTQbsC/KwwnAQkxp/pgUWwlekruTpnqNEPg5WJriUtkUFCl7fBTlSHKbq14jVKAj/bh7/k/e1fBQ8cat9wTZyhgZ4TjGCcAGpG9c2ZWQH8xOWAQuREa6FFeuxKv8kIbArgQkxujcoeUdlhIGQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e703895-3a3b-4784-c0a2-08d6e5a971a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 09:22:03.7348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoshihiro.shimoda.uh@renesas.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2994
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgR2VlcnQtc2FuLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3IQ0KDQo+IEZyb206IEdl
ZXJ0IFV5dHRlcmhvZXZlbiwgU2VudDogRnJpZGF5LCBNYXkgMzEsIDIwMTkgNDoyMCBQTQ0KPiAN
Cj4gSGkgU2hpbW9kYS1zYW4sDQo+IA0KPiBPbiBUaHUsIE1heSAzMCwgMjAxOSBhdCAxMjoyMSBQ
TSBZb3NoaWhpcm8gU2hpbW9kYQ0KPiA8eW9zaGloaXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+
IHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBwb3dlciBtYW5hZ2VtZW50IGRlc2NyaXB0aW9u
cyB0aGF0IGNvbnN1bWVycyBzaG91bGQNCj4gPiBpbXBsZW1lbnQgaXQuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBZb3NoaWhpcm8gU2hpbW9kYSA8eW9zaGloaXJvLnNoaW1vZGEudWhAcmVuZXNh
cy5jb20+DQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+IA0KPiA+IC0tLSBhL0RvY3Vt
ZW50YXRpb24vcHdtLnR4dA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vcHdtLnR4dA0KPiANCj4g
PiBAQCAtMTQxLDYgKzE0NSw5IEBAIFRoZSBpbXBsZW1lbnRhdGlvbiBvZiAtPmdldF9zdGF0ZSgp
IChhIG1ldGhvZCB1c2VkIHRvIHJldHJpZXZlIGluaXRpYWwgUFdNDQo+ID4gIHN0YXRlKSBpcyBh
bHNvIGVuY291cmFnZWQgZm9yIHRoZSBzYW1lIHJlYXNvbjogbGV0dGluZyB0aGUgUFdNIHVzZXIg
a25vdw0KPiA+ICBhYm91dCB0aGUgY3VycmVudCBQV00gc3RhdGUgd291bGQgYWxsb3cgaGltIHRv
IGF2b2lkIGdsaXRjaGVzLg0KPiA+DQo+ID4gK0RyaXZlcnMgc2hvdWxkIG5vdCBpbXBsZW1lbnQg
YW55IHBvd2VyIG1hbmFnZW1lbnQuIEluIG90aGVyIHdvcmRzLA0KPiA+ICtjb25zdW1lcnMgc2hv
dWxkIGltcGxlbWVudCBpdCBhcyBkZXNjcmliZWQgYXMgdGhlICJVc2luZyBQV01zIiBzZWN0aW9u
Lg0KPiANCj4gcy9hcy9pbi8NCg0KU28sICIuLi4gaW4gZGVzY3JpYmVkIGFzIC4uLiIgPw0KDQpJ
J20gbm90IGEgbmF0aXZlIHNwZWFrZXIsIHNvIHRoYXQgYW55IGNhc2VzIGJlbG93IHNlZW0gbm90
IHNvIGRpZmZlcmVudCB0byBtZSA6KQ0KDQoxLiAiLi4uIGFzIGRlc2NyaWJlZCBhcyAuLi4iDQoy
LiAiLi4uIGluIGRlc2NyaWJlZCBhcyAuLi4iDQozLiAiLi4uIGFzIGRlc2NyaWJlZCBpbiAuLi4i
DQo0LiAiLi4uIGluIGRlc2NyaWJlZCBpbiAuLi4iDQoNCj4gUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5
dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQoNClRoYW5rcyENCg0KQmVzdCBy
ZWdhcmRzLA0KWW9zaGloaXJvIFNoaW1vZGENCg0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJo
b2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4
LW02OGsub3JnDQo+IA0KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2Fs
IHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0DQo+IHdoZW4gSSdtIHRhbGtpbmcg
dG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2Ug
dGhhdC4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxk
cw0K
