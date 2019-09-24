Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D84BABC55A
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Sep 2019 12:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504417AbfIXKDY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Sep 2019 06:03:24 -0400
Received: from mail-eopbgr70071.outbound.protection.outlook.com ([40.107.7.71]:23111
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2504358AbfIXKDX (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 24 Sep 2019 06:03:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4G7fFWd4yvx/gZcq9RgVexL3RL0TXZCInTwQZc162QR+w8iKKkq5fqQEWMIFHUB3JlZjPCh0wZhh4FuRt2I/PKkZeekv6KjwA7346CuXUQszUijq5BWTYwf0En3iUNCap+OhHRJ1yOrH7jF4weipPdVopjgAXSZ0OQCnRJYfBbKbpJJ2ficpaJQVXDfzc17KEzdQ9afOvs4+rgLmX1Yzvs2T4IrDQoUK4LFUBc08HRdb+oVxs7hr2fikhGDgHUIScPWoX9ilyx//JGiQHR4vYOgErZVM9++++zVYYoNSaIaHu+MZTvl5k0qbxdqPQxLInUDf3PipVd4lwH3oJ/26w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NdzP6YDLfy/KAS5c7wZ1b+lg1003n02W6hpsoc08SI=;
 b=j+Yfuj05VlpA4mvVInWTZTeCkJRle1yd82z8oQIwR5/Xs3A5V/3bLuGN1V96UNYAMPzbf6c2P0sNlvIsk4aFg5yH39Z3dT6/qo0nUvQ1K35j4jMpC2mkNXBDkCz2nMMmRVla3bQgwtOejI56pwKk7Bnpa6sYUtnv4JT5AsGfN/sm1WABIc2ssJCKQTOHCKTcEMPV4tlQoiWmjUL2ittUmbFRYBowKBMd9rjkjZqG52qlYQUwO5A6AWRgC4WXDoqjFj4ffZmpiD2hgRjgSXiwZ6iEZlDfA34AqoWHmJdEsjlvItMJSXwnguQ17tBfM6q1Q/slprbJ4KrB+5tvxMQi/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NdzP6YDLfy/KAS5c7wZ1b+lg1003n02W6hpsoc08SI=;
 b=ZCEv624489daZXcQKYVvDkPr0US6SSPidTBsSxcr90Y+vdctCmqysfspUcWEeIxx6gkaSvOpA1269i7VZTo6HTOFXXIJju/HWyy6/ZjsLQMJ+3zGTtorCjC9EEGyf8DhqvXFlvOlew+g/E5nBkIEerHZVISWT0jFNgAxHl7jcWA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3641.eurprd04.prod.outlook.com (52.134.69.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Tue, 24 Sep 2019 10:03:18 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 10:03:18 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     David Laight <David.Laight@ACULAB.COM>,
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
Thread-Index: AQHVcra4SlIMDowCwkO5fDgX0dE1dKc6lGgAgAADXwA=
Date:   Tue, 24 Sep 2019 10:03:18 +0000
Message-ID: <DB3PR0402MB3916FFD66797DAC0AB1110D8F5840@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1569315593-769-1-git-send-email-Anson.Huang@nxp.com>
 <6cfb1595992b46dc884731555e6f0334@AcuMS.aculab.com>
In-Reply-To: <6cfb1595992b46dc884731555e6f0334@AcuMS.aculab.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79b46d9f-f78f-4196-64ef-08d740d66c8e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3641;
x-ms-traffictypediagnostic: DB3PR0402MB3641:|DB3PR0402MB3641:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB36417682AB408E7E0A81E200F5840@DB3PR0402MB3641.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(199004)(189003)(76116006)(7736002)(2906002)(66556008)(66476007)(7696005)(66946007)(6116002)(305945005)(25786009)(3846002)(66066001)(478600001)(64756008)(33656002)(66446008)(446003)(11346002)(99286004)(2201001)(486006)(186003)(86362001)(76176011)(26005)(81156014)(81166006)(8676002)(2501003)(102836004)(6506007)(44832011)(52536014)(14454004)(5660300002)(6436002)(110136005)(6246003)(74316002)(476003)(71200400001)(9686003)(229853002)(55016002)(4326008)(256004)(14444005)(316002)(8936002)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3641;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iYun5GqQBQc3nzoGHU1tnfK2lggOMZAVKaCpY8kT9uOME+ntQtVj4lqvYFwbESMOiJZYT68n/RZ/bVRKiLSdlF6hFXVtlr3OUKydWKYEewn7MzgF9bT7cFrj6mt00OcqmHVA7oDDPjZmxSFbWdSBCKDQLpw+gOfgwvWwmKBth5Aoah92tCKbgNzx4GDEdGx6DaeO3M5tTuDYEhRSyOUeDXoT5gK43DoNKLF+dDIfIPIsnpDJU4FlBGJ+x6yO2er+2r3JhrjgnZeOWx9VUuPyC7WzLqJNeEYz9jMUJHredLl8gwItF1yYK67oOGPqZ5Jnr3dpNcXCg2urotSpTTpXsPgZ2JG6vlk+9PvpKX5yXj3AfDhz2+ed1zL3ev5qccwsBIKVE67EkBkWTS6tu4E2qRLS4XLiogMtRlvFous6+DM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b46d9f-f78f-4196-64ef-08d740d66c8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 10:03:18.4085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xNvCIcJm+bwZ+IjdjRSvTLcVlupW1dn0wnwwbUdc4eDHRp6o3rnBIQt3LXYxLpmMOZWC4rcRfTFCAH2hLlVtcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3641
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGksIERhdmlkDQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gcHdtOiBwd20taW14Mjc6IFVzZSAn
ZGV2JyBpbnN0ZWFkIG9mIGRlcmVmZXJlbmNpbmcgaXQNCj4gcmVwZWF0ZWRseQ0KPiANCj4gRnJv
bTogQW5zb24gSHVhbmcNCj4gPiBTZW50OiAyNCBTZXB0ZW1iZXIgMjAxOSAxMDowMA0KPiA+IEFk
ZCBoZWxwZXIgdmFyaWFibGUgZGV2ID0gJnBkZXYtPmRldiB0byBzaW1wbHkgdGhlIGNvZGUuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wd20vcHdtLWlteDI3LmMgfCAxMyArKysrKysrLS0tLS0t
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wd20vcHdtLWlteDI3LmMgYi9kcml2ZXJzL3B3
bS9wd20taW14MjcuYyBpbmRleA0KPiA+IDQzNGEzNTEuLjNhZmVlMjkgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9wd20vcHdtLWlteDI3LmMNCj4gPiArKysgYi9kcml2ZXJzL3B3bS9wd20taW14
MjcuYw0KPiA+IEBAIC0yOTAsMjcgKzI5MCwyOCBAQCBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLA0K
PiBwd21faW14MjdfZHRfaWRzKTsNCj4gPg0KPiA+ICBzdGF0aWMgaW50IHB3bV9pbXgyN19wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KSAgew0KPiA+ICsJc3RydWN0IGRldmljZSAq
ZGV2ID0gJnBkZXYtPmRldjsNCj4gPiAgCXN0cnVjdCBwd21faW14MjdfY2hpcCAqaW14Ow0KPiA+
DQo+ID4gLQlpbXggPSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwgc2l6ZW9mKCppbXgpLCBHRlBf
S0VSTkVMKTsNCj4gPiArCWlteCA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqaW14KSwgR0ZQ
X0tFUk5FTCk7DQo+ID4gIAlpZiAoaW14ID09IE5VTEwpDQo+ID4gIAkJcmV0dXJuIC1FTk9NRU07
DQo+ID4NCj4gPiAgCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIGlteCk7DQo+ID4NCj4gPiAt
CWlteC0+Y2xrX2lwZyA9IGRldm1fY2xrX2dldCgmcGRldi0+ZGV2LCAiaXBnIik7DQo+ID4gKwlp
bXgtPmNsa19pcGcgPSBkZXZtX2Nsa19nZXQoZGV2LCAiaXBnIik7DQo+ID4gIAlpZiAoSVNfRVJS
KGlteC0+Y2xrX2lwZykpIHsNCj4gPiAtCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJnZXR0aW5nIGlw
ZyBjbG9jayBmYWlsZWQgd2l0aCAlbGRcbiIsDQo+ID4gKwkJZGV2X2VycihkZXYsICJnZXR0aW5n
IGlwZyBjbG9jayBmYWlsZWQgd2l0aCAlbGRcbiIsDQo+ID4gIAkJCQlQVFJfRVJSKGlteC0+Y2xr
X2lwZykpOw0KPiA+ICAJCXJldHVybiBQVFJfRVJSKGlteC0+Y2xrX2lwZyk7DQo+ID4gIAl9DQo+
ID4NCj4gPiAtCWlteC0+Y2xrX3BlciA9IGRldm1fY2xrX2dldCgmcGRldi0+ZGV2LCAicGVyIik7
DQo+ID4gKwlpbXgtPmNsa19wZXIgPSBkZXZtX2Nsa19nZXQoZGV2LCAicGVyIik7DQo+ID4gIAlp
ZiAoSVNfRVJSKGlteC0+Y2xrX3BlcikpIHsNCj4gPiAgCQlpbnQgcmV0ID0gUFRSX0VSUihpbXgt
PmNsa19wZXIpOw0KPiA+DQo+ID4gIAkJaWYgKHJldCAhPSAtRVBST0JFX0RFRkVSKQ0KPiA+IC0J
CQlkZXZfZXJyKCZwZGV2LT5kZXYsDQo+ID4gKwkJCWRldl9lcnIoZGV2LA0KPiA+ICAJCQkJImZh
aWxlZCB0byBnZXQgcGVyaXBoZXJhbCBjbG9jazogJWRcbiIsDQo+ID4gIAkJCQlyZXQpOw0KPiAN
Cj4gSG9wZWZ1bGx5IHRoZSBjb21waWxlciB3aWxsIG9wdGltaXNlIHRoaXMgYmFjayBvdGhlcndp
c2UgeW91J3ZlIGFkZGVkDQo+IGFub3RoZXIgbG9jYWwgdmFyaWFibGUgd2hpY2ggbWF5IGNhdXNl
IHNwaWxsaW5nIHRvIHN0YWNrLg0KPiBGb3IgYSBzZXR1cCBmdW5jdGlvbiBpdCBwcm9iYWJseSBk
b2Vzbid0IG1hdHRlciwgYnV0IGluIGdlbmVyYWwgaXQgbWlnaHQgaGF2ZSBhDQo+IHNtYWxsIG5l
Z2F0aXZlIHBlcmZvcm1hbmNlIGltcGFjdC4NCj4gDQo+IEluIGFueSBjYXNlIHRoaXMgZG9lc24n
dCBzaG9ydGVuIGFueSBsaW5lcyBlbm91Z2ggdG8gcmVtb3ZlIGxpbmUtd3JhcCBhbmQNCj4gdXNp
bmcgJnBkZXYtPmRldiBpcyByZWFsbHkgb25lIGxlc3MgdmFyaWFibGUgdG8gbWVudGFsbHkgdHJh
Y2sgd2hlbiByZWFkaW5nDQo+IHRoZSBjb2RlLg0KDQpEbyB3ZSBrbm93IHdoaWNoIGNvbXBpbGVy
IHdpbGwgb3B0aW1pemUgdGhpcz8gSSBzYXcgbWFueSBvZiB0aGUgcGF0Y2hlcyBkb2luZw0KdGhp
cyB0byBhdm9pZCBhIGxvdCBvZiBkZXJlZmVyZW5jZSwgSSB1bmRlcnN0YW5kIGl0IGRvZXMgTk9U
IHNhdmUgbGluZXMsIGJ1dCBteSBpbnRlbnRpb24NCmlzIHRvIGF2b2lkIGRlcmVmZXJlbmNlIHdo
aWNoIG1pZ2h0IHNhdmUgc29tZSBpbnN0cnVjdGlvbnMuDQoNCkkgdGhvdWdodCBzYXZpbmcgaW5z
dHJ1Y3Rpb25zIGlzIG1vcmUgaW1wb3J0YW50LiBTbyBub3cgdGhlcmUgYXJlIGRpZmZlcmVudCBv
cGluaW9uIGFib3V0DQpkb2luZyB0aGlzPw0KDQpBbnNvbiANCg==
