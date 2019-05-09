Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4C318353
	for <lists+linux-pwm@lfdr.de>; Thu,  9 May 2019 03:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfEIBo7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 8 May 2019 21:44:59 -0400
Received: from mail-eopbgr50079.outbound.protection.outlook.com ([40.107.5.79]:46311
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725832AbfEIBo6 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 8 May 2019 21:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BR4GmPXL/fG4byVM9M1vgEpnvIfOqiAJA8lFd/D9Crw=;
 b=QAFGE+TypN1xOBqHMvB7XcvKmlU4gJNWJ5BymkowHr0Jka2K0KOAspXmiypgwcpL+UCgeMr0emuHgszp06JrsFksXOmKPRxAfOUQaPbTAcLJYALzrxplu7hiwbRT1V9JWCKw4AUxSYCaHo6bYI7gQs2lWQLglPhU6uwcm/SlWuY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3929.eurprd04.prod.outlook.com (52.134.70.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.20; Thu, 9 May 2019 01:44:53 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1878.022; Thu, 9 May 2019
 01:44:53 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V11 0/5] Add i.MX7ULP EVK PWM backlight support
Thread-Topic: [PATCH V11 0/5] Add i.MX7ULP EVK PWM backlight support
Thread-Index: AQHU7z9bBIw0J0eEykuFfv84e8UBB6ZKtMlwgBd+SBA=
Date:   Thu, 9 May 2019 01:44:53 +0000
Message-ID: <DB3PR0402MB39166E774B176ADCA82EE46BF5330@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1554860547-18237-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR0402MB39113C3CA7E1AB8969882B41F53C0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR0402MB39113C3CA7E1AB8969882B41F53C0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 586725a8-bc2d-4837-4882-08d6d41feea6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3929;
x-ms-traffictypediagnostic: DB3PR0402MB3929:
x-microsoft-antispam-prvs: <DB3PR0402MB39298BB16AB6543E873FE528F5330@DB3PR0402MB3929.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:107;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(376002)(346002)(396003)(189003)(199004)(13464003)(5660300002)(316002)(52536014)(7696005)(99286004)(229853002)(478600001)(76176011)(68736007)(8936002)(102836004)(11346002)(53546011)(476003)(446003)(9686003)(81156014)(44832011)(55016002)(81166006)(33656002)(53936002)(73956011)(8676002)(2501003)(486006)(26005)(6436002)(76116006)(66946007)(64756008)(66446008)(66476007)(66556008)(110136005)(14454004)(86362001)(4326008)(66066001)(6246003)(25786009)(186003)(2201001)(6506007)(2906002)(7736002)(305945005)(7416002)(256004)(71200400001)(71190400001)(3846002)(6116002)(74316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3929;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FX43mK3u2WtM9J9rbqHdknoYL/Kb14cn0aOfoMVNiAkkkerZwxP+M8PtDSTYrk4V/UPT+VFkQqL08DsiKkAFI0Kiy+LnPtMRWC05xW0Mn5uJnOI85gN/4inwSpZZDQKy24fL9sx9fkk0dj8J9tZCFwU6VWPFKB8NpJThaEuEzrdKtDQEmMk43GsqMo5sZCn7JqSfakZ0kRxMspGEZdsYnTylMRIa+P3pRP0M0/PWwRiLoFvQQsL/Lg4vNaOHUy3fkcLXeY6LGfWvlsL1qvFvGzEJJDqmWQifvPDg0/H6CNQHIZsPXPQIMY0n9u7CJ8ip0ozhmcd/CtgNusrUCPgzu1aj7ji4wYZTOOQtZoCLoCGm24mU9m3t6c05N/nbbEeb/3l3mXN5JISVTVPG9D73+dX6X25VDnGAJEu+/Qu4qRE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 586725a8-bc2d-4837-4882-08d6d41feea6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 01:44:53.1342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3929
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

UGluZy4uLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuc29uIEh1
YW5nDQo+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMjQsIDIwMTkgMTA6NTkgQU0NCj4gVG86IHRo
aWVycnkucmVkaW5nQGdtYWlsLmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRA
YXJtLmNvbTsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsg
a2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IGxpbnV4QGFybWxp
bnV4Lm9yZy51azsgc3RlZmFuQGFnbmVyLmNoOw0KPiBvdGF2aW9Ab3NzeXN0ZW1zLmNvbS5icjsg
TGVvbmFyZCBDcmVzdGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT47DQo+IFJvYmluIEdvbmcg
PHlpYmluLmdvbmdAbnhwLmNvbT47IHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZTsgbGlu
dXgtDQo+IHB3bUB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnDQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBT
dWJqZWN0OiBSRTogW1BBVENIIFYxMSAwLzVdIEFkZCBpLk1YN1VMUCBFVksgUFdNIGJhY2tsaWdo
dCBzdXBwb3J0DQo+IA0KPiBHZW50bGUgcGluZy4uLg0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+IEZyb206IEFuc29uIEh1YW5nDQo+ID4gU2VudDogV2VkbmVzZGF5LCBB
cHJpbCAxMCwgMjAxOSA5OjQ3IEFNDQo+ID4gVG86IHRoaWVycnkucmVkaW5nQGdtYWlsLmNvbTsg
cm9iaCtkdEBrZXJuZWwub3JnOw0KPiA+IG1hcmsucnV0bGFuZEBhcm0uY29tOyBzaGF3bmd1b0Br
ZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiA+IGtlcm5lbEBwZW5ndXRyb25p
eC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBsaW51eEBhcm1saW51eC5vcmcudWs7DQo+ID4gc3Rl
ZmFuQGFnbmVyLmNoOyBvdGF2aW9Ab3NzeXN0ZW1zLmNvbS5icjsgTGVvbmFyZCBDcmVzdGV6DQo+
ID4gPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPjsgUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAu
Y29tPjsNCj4gPiB1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU7IGxpbnV4LSBwd21Admdl
ci5rZXJuZWwub3JnOw0KPiA+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0t
IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNCj4gPiBDYzogZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gPiBTdWJq
ZWN0OiBbUEFUQ0ggVjExIDAvNV0gQWRkIGkuTVg3VUxQIEVWSyBQV00gYmFja2xpZ2h0IHN1cHBv
cnQNCj4gPg0KPiA+IGkuTVg3VUxQIEVWSyBib2FyZCBoYXMgTUlQSS1EU0kgZGlzcGxheSwgaXRz
IGJhY2tsaWdodCBpcyBzdXBwbGllZCBieQ0KPiA+IFRQTSBQV00gbW9kdWxlLCB0aGlzIHBhdGNo
IHNldCBlbmFibGVzIGkuTVg3VUxQIFRQTSBQV00gZHJpdmVyDQo+IHN1cHBvcnQNCj4gPiBhbmQg
YWxzbyBhZGQgYmFja2xpZ2h0IHN1cHBvcnQgZm9yIE1JUEktRFNJIGRpc3BsYXkuDQo+ID4NCj4g
PiBDaGFuZ2VzIHNpbmNlIFYxMDoNCj4gPiAJLSBPTkxZIGNoYW5nZSB0aGUgcHdtIGRyaXZlciBw
YXRjaC4NCj4gPg0KPiA+IEFuc29uIEh1YW5nICg1KToNCj4gPiAgIGR0LWJpbmRpbmdzOiBwd206
IEFkZCBpLk1YIFRQTSBQV00gYmluZGluZw0KPiA+ICAgcHdtOiBBZGQgaS5NWCBUUE0gUFdNIGRy
aXZlciBzdXBwb3J0DQo+ID4gICBBUk06IGlteF92Nl92N19kZWZjb25maWc6IEFkZCBUUE0gUFdN
IHN1cHBvcnQgYnkgZGVmYXVsdA0KPiA+ICAgQVJNOiBkdHM6IGlteDd1bHA6IEFkZCB0cG0gcHdt
IHN1cHBvcnQNCj4gPiAgIEFSTTogZHRzOiBpbXg3dWxwLWV2azogQWRkIGJhY2tsaWdodCBzdXBw
b3J0DQo+ID4NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2lteC10cG0tcHdtLnR4
dCAgICAgICAgfCAgMjIgKw0KPiA+ICBhcmNoL2FybS9ib290L2R0cy9pbXg3dWxwLWV2ay5kdHMg
ICAgICAgICAgICAgICAgICB8ICAyMSArDQo+ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDd1bHAu
ZHRzaSAgICAgICAgICAgICAgICAgICAgIHwgIDEwICsNCj4gPiAgYXJjaC9hcm0vY29uZmlncy9p
bXhfdjZfdjdfZGVmY29uZmlnICAgICAgICAgICAgICAgfCAgIDEgKw0KPiA+ICBkcml2ZXJzL3B3
bS9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxMSArDQo+ID4gIGRy
aXZlcnMvcHdtL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsN
Cj4gPiAgZHJpdmVycy9wd20vcHdtLWlteC10cG0uYyAgICAgICAgICAgICAgICAgICAgICAgICAg
fCA0NDINCj4gKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDcgZmlsZXMgY2hhbmdlZCwgNTA4
IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9wd20vaW14LXRwbS0NCj4gPiBwd20udHh0DQo+ID4gIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL3B3bS9wd20taW14LXRwbS5jDQo+ID4NCj4gPiAtLQ0KPiA+IDIu
Ny40DQoNCg==
