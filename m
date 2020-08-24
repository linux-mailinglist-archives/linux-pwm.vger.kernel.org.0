Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C635D24FB70
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Aug 2020 12:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgHXKbl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 06:31:41 -0400
Received: from mail-eopbgr50086.outbound.protection.outlook.com ([40.107.5.86]:49444
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725968AbgHXKbh (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 24 Aug 2020 06:31:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=df8+NkJsbhUhenBGbX/zZTpv/IpZpws6+kPg5VOEvGHwvIwXuJNTeDO/bp0kl617tp6bmuvTLZEr/FLSYw/EZQNhOVQ1MHY8Gz3qsGS1hJfWiRCnyUeT0tRmK9bHHoJWcr9ip9lXaQrIqjl/Jyq/FXr1numiEZi8pAguHXc1dbUy2WVDmLSq8tsz0CDsvuYBJ0iskuRzeb1kywIGm4SFQ02KsICIsxRYa2IyaeJeazwhmrC08dCh4C324eXufKXY5/1YbHKjO3ZEtQcfNmW08D+eucyNmT1BpTLYT8cVM4vk4TEmCFWcyM9B63MSo7iY+EPpB5wL2HZD0/iGh0EsWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssmwyUDa2b18KTkZi0U6sNkwx448wivDzaj9fvTNFCo=;
 b=C7h6uUEtkzvcHtMP50Za6u3R0so//ZbSRilwnUnFGVTKQ8RP0YxqQdGF0PTb85OXN1p3Q4S4mvTkWhjwqh5rMoNjt9EJ/uhdZWRxaEFLxZeZTzUm3jAcF/bBh1zzrhkBE6/vuDvFItQUHWph+L76rYy/i0Z2BqhOfvQX0Ge7loZRSym79JqNnF04loOrxhGPN14H5E8aYKyc57W8y9hefwMc/Rmy/sXlmJy7dAEj/MDT89CPsCTde+OxzTS4k2hhFPLK9uBJZYCqJVs6nHAGW0mqTuAK4ZQdh2hYZtTOEcgNuo2Wh1aBQiLvjB2t78JVhEi8V2WNNPYRh865ctC7Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssmwyUDa2b18KTkZi0U6sNkwx448wivDzaj9fvTNFCo=;
 b=gza07bK5Wdiq6CxLNE0+sQ5nbVe72QragR5UIIKj6Nn1Ft75O7w4v5gGdfO/dBBFXWtkeEZuX6zMKIH0hCIrokLrApcU8snc7XYfcfF8wszgC/zLp/ndARXQr8BuIPAkzwCloZo+0qYaarOvX5xdgRaUYO/9ebcV8G9HBXJFiUc=
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com (2603:10a6:803:5a::22)
 by VI1PR0402MB3407.eurprd04.prod.outlook.com (2603:10a6:803:5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Mon, 24 Aug
 2020 10:31:31 +0000
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::f858:cc14:2a9f:e8ed]) by VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::f858:cc14:2a9f:e8ed%4]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 10:31:31 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Dong Aisheng <dongas86@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
CC:     Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: RE: [PATCH 21/22] arm64: dts: imx8qxp: Remove i.MX7 compatible from
 USDHC
Thread-Topic: [PATCH 21/22] arm64: dts: imx8qxp: Remove i.MX7 compatible from
 USDHC
Thread-Index: AQHWeWjsuUxS6VpMA0mT/uguiDafj6lG9ymAgAAC/wCAAAmUgIAACw9w
Date:   Mon, 24 Aug 2020 10:31:31 +0000
Message-ID: <VI1PR04MB52949085DFA5D29C2858094290560@VI1PR04MB5294.eurprd04.prod.outlook.com>
References: <20200823161550.3981-1-krzk@kernel.org>
 <20200823161550.3981-21-krzk@kernel.org>
 <AM6PR04MB49668B0F67B02B2A33603B4880560@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <20200824091102.GA20819@kozik-lap>
 <CAA+hA=S=2SoF8egOq8h-eB9wZGDqrAw66VtW-bU9oBmzFSj9Bw@mail.gmail.com>
In-Reply-To: <CAA+hA=S=2SoF8egOq8h-eB9wZGDqrAw66VtW-bU9oBmzFSj9Bw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bb29dfb9-03d5-4273-7455-08d84818de05
x-ms-traffictypediagnostic: VI1PR0402MB3407:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB34076B5AA4D24639AB13069F90560@VI1PR0402MB3407.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jpjIbUqCLu8e2pM0Htig62Sqgc7xb81ttkL4a51RjnK+OUrc0SoEHvX8ywj7BT3PbH8bZ8yfC+xDDFCNYRMDoLPEmED82jeVTQliCjZBaebnu6ROGEPGq3Bb+rlKpllKKDfG4BHOlMHEp67WqCk8rFIBjxfH271a5ZxnzHHCgvVY84eSEum+6hn5tQps0DikGDNhx1Dl2pl6qHry8c/NFesYzJvUN6ozAFnx60Jm1T1tb8jjA5pfVLT89q4AgKK36YrXywfieG0E74W76jjDhz+O0vhep9/6lh4SV6NyYlm7lkkU2H4nhvtQsORjTO4c3hOAQFe4OSbFaCj5zsyQ16Ssfx6daCzN4cODeCbaf61MRorYMWrOWwokQnmpgg8C0HrGz42TgU8K/dRbshKG9NDt+9mBD/LFbTcqXq97Hu5xpzpliizghtYD4zjb2gmt4JSHrSup/LO2DcGt2MzcRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5294.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(76116006)(9686003)(33656002)(64756008)(966005)(2906002)(7416002)(66476007)(55016002)(66946007)(186003)(478600001)(26005)(66446008)(66556008)(54906003)(83380400001)(52536014)(110136005)(71200400001)(6506007)(316002)(8936002)(7696005)(45080400002)(8676002)(83080400001)(4326008)(5660300002)(53546011)(86362001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: eYvq0hOcy+jXWiAjDcAbnZXrYNXLln+PkVSiYzKZWmsB+iWpqoNgfdcto8LsPEZbqdQ3pUnROVDL114rObBCNISDZPakO8pC16pbN0a0vwVik2NxbnQxZGAuR4J4z8+Y7WJh3mdl1MSH9KcWrwcKjhVgIGu9F49nJ1BdfoNIGytouAYsdQnAPn1CWVIjYlxpWvlgi7B3IYMiZMy+31aeK4T/kKxDvKnYfIMooSPg6A7YsiugfJPZgFufopYGZV8Ov94gA4fhwQDdaIjpHFNXZc/pGmpGbTjmQB9cB6NPm31yk3CzDOoZbameP78i6tVSfQMN95lIHnclT566tjo39+YPQrLB4pUmZiD+CkWXbkIU/Td413M8sl4ydVSZgqXlF0+wILinc5e/nLM/t+JyzLoqS9qymQWHsL2L9yDOq1G/+oUT1NsIF++5RfEcQDRzH5J838ZaGAF0Y5VyiCwP5c5uK6/kdQTjolxqqZsNP4dNItubO9geDgumVnbIiIeYiv1pziKwdbOi5XoN0663wNr3bx3LiOGrN7laapdvkdY2TqpjyWT1FK0YiuDTbzqjDmh1NvMzWKK1U+XkrD3KfWcFSx4JxPjKKFWylrh5fPbIpHv0qZ5ELty7yzcnv1rSz6v0nqtjbwxTXdfIabcoIg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5294.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb29dfb9-03d5-4273-7455-08d84818de05
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2020 10:31:31.2950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 42fwKeMxZuqtaX5NcwU/OIVHqfopzrx/RtLRoYmagR9EktTLILMKhFWkccWVErXvkP2hJBRba3jdhHAeSEAK0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3407
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEb25nIEFpc2hlbmcgW21haWx0
bzpkb25nYXM4NkBnbWFpbC5jb21dDQo+IFNlbnQ6IDIwMjDlubQ45pyIMjTml6UgMTc6NDUNCj4g
VG86IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj4gQ2M6IEFpc2hlbmcg
RG9uZyA8YWlzaGVuZy5kb25nQG54cC5jb20+OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsN
Cj4gbGludXgtc2VyaWFsQHZnZXIua2VybmVsLm9yZzsgQW5zb24gSHVhbmcgPGFuc29uLmh1YW5n
QG54cC5jb20+Ow0KPiBsaW51eC1ncGlvQHZnZXIua2VybmVsLm9yZzsgRmFiaW8gRXN0ZXZhbSA8
ZmVzdGV2YW1AZ21haWwuY29tPjsgTGludXMNCj4gV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5h
cm8ub3JnPjsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1tbWNAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1wd21Admdlci5r
ZXJuZWwub3JnOyBCYXJ0b3N6IEdvbGFzemV3c2tpDQo+IDxiZ29sYXN6ZXdza2lAYmF5bGlicmUu
Y29tPjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47DQo+IGxpbnV4LW10ZEBsaXN0
cy5pbmZyYWRlYWQub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgUGVuZ3V0
cm9uaXgNCj4gS2VybmVsIFRlYW0gPGtlcm5lbEBwZW5ndXRyb25peC5kZT47IFRoaWVycnkgUmVk
aW5nDQo+IDx0aGllcnJ5LnJlZGluZ0BnbWFpbC5jb20+OyBTaGF3biBHdW8gPHNoYXduZ3VvQGtl
cm5lbC5vcmc+OyBTYXNjaGENCj4gSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+OyBsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LXdhdGNoZG9nQHZnZXIu
a2VybmVsLm9yZzsgQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIDIxLzIyXSBhcm02NDogZHRzOiBpbXg4cXhwOiBSZW1vdmUgaS5NWDcgY29tcGF0
aWJsZQ0KPiBmcm9tIFVTREhDDQo+IA0KPiBPbiBNb24sIEF1ZyAyNCwgMjAyMCBhdCA1OjE1IFBN
IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj4gd3JvdGU6DQo+ID4NCj4g
PiBPbiBNb24sIEF1ZyAyNCwgMjAyMCBhdCAwOTowMDoxOUFNICswMDAwLCBBaXNoZW5nIERvbmcg
d3JvdGU6DQo+ID4gPiA+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9y
Zz4NCj4gPiA+ID4gU2VudDogTW9uZGF5LCBBdWd1c3QgMjQsIDIwMjAgMTI6MTYgQU0NCj4gPiA+
ID4NCj4gPiA+ID4gVGhlIFVTREhDIG9uIGkuTVggOFFYUCBoYXMgaXRzIG93biBjb21wYXRpYmxl
IGRlc2NyaWJlZCBpbg0KPiA+ID4gPiBiaW5kaW5ncyBhbmQgdXNlZCBpbiB0aGUgZHJpdmVyICh3
aXRoIGl0cyBvd24gcXVpcmtzKS4gIFJlbW92ZQ0KPiA+ID4gPiBhZGRpdGlvbmFsIGZzbCxpbXg3
ZC11c2RoYyBjb21wYXRpYmxlIHRvIGZpeCBkdGJzX2NoZWNrIHdhcm5pbmdzIGxpa2U6DQo+ID4g
PiA+DQo+ID4gPiA+ICAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC1haV9t
bC5kdC55YW1sOg0KPiBtbWNANWIwMTAwMDA6DQo+ID4gPiA+ICAgICBjb21wYXRpYmxlOiBbJ2Zz
bCxpbXg4cXhwLXVzZGhjJywgJ2ZzbCxpbXg3ZC11c2RoYyddIGlzIHRvbyBsb25nDQo+ID4gPiA+
ICAgICBGcm9tIHNjaGVtYToNCj4gPiA+ID4gL29jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21tYy9mc2wtaW14LWVzZGhjLnlhbWwNCj4gPiA+ID4NCj4gPiA+ID4gICBhcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLWFpX21sLmR0LnlhbWw6DQo+IG1tY0A1YjAxMDAw
MDoNCj4gPiA+ID4gICAgIGNvbXBhdGlibGU6IEFkZGl0aW9uYWwgaXRlbXMgYXJlIG5vdCBhbGxv
d2VkDQo+ID4gPiA+ICgnZnNsLGlteDdkLXVzZGhjJyB3YXMNCj4gPiA+ID4gdW5leHBlY3RlZCkN
Cj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6
a0BrZXJuZWwub3JnPg0KPiA+ID4NCj4gPiA+IEZvciBQYXRjaCAxOS0yMiwgSSB0aGluayB3ZSBz
aG91bGQgZml4IGR0IGJpbmRpbmcgZG9jLg0KPiA+DQo+ID4gQXJlIHlvdSBzdXJlIHRoYXQgdGhl
c2UgVVNESEMgY29udHJvbGxlcnMgYXJlIGNvbXBhdGlibGUgd2l0aCBpLk1YIDdEPw0KPiA+IENv
dWxkIHRoZXkgcmVhbGx5IHJ1biB3aXRoIGZzbCxpbXg3ZC11c2RoYyBjb21wYXRpYmxlPw0KPiAN
Cj4gQUZBSUsgdVNESEMgb24gUVhQIGlzIGRlcml2ZWQgZnJvbSB0aGUgZm9ybWVyIHBsYXRmb3Jt
cyB3aXRoIGFkZGluZyBhIGZldw0KPiBtb3JlIG5ldyBmZWF0dXJlcy4gZS5nLiBIUzQwMEVTL0NN
RFEuDQo+IExldCBtZSBsb29wIGluIHVTREhDIGRyaXZlciBvd25lciBIYWlibyBDaGVuIHRvIGRv
dWJsZSBjb25maXJtLg0KDQpZZXMsIHVzZGhjIG9mIGlteDhxeHAgY2FuIHdvcmsgYnkgdXNpbmcg
dGhlIGNvbXBhdGlibGUgImZzbCwgaW14N2QtdXNkaGMiLCBidXQgd2lsbCBub3Qgc3VwcG9ydCBI
UzQwMEVTL0NvbW1hbmQgUXVldWUgYW55IG1vcmUuIEFsc28gaW14OHF4cCBzdXBwb3J0IEF1dG8g
Q01EMjMsIGJ1dCBpbXg3ZCBub3QuDQpBbmQgaW14OHF4cCBuZWVkIHRvIHJlLWNvbmZpZyB0aGUg
Y2xvY2sgcmF0ZSBhZnRlciBzeXN0ZW0gUE0sIGlteDdkIGRvIG5vdCBuZWVkIHRvIGRvIHRoaXMu
DQoNCg0KPiANCj4gUmVnYXJkcw0KPiBBaXNoZW5nDQo+IA0KPiA+IFRoZSBpbXBsZW1lbnRhdGlv
biAoTGludXgga2VybmVsIGRyaXZlcikgaXMgZGlmZmVyZW50LCBJIGd1ZXNzIG9uDQo+ID4gcHVy
cG9zZS4uLg0KPiA+DQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+IEtyenlzenRvZg0KPiA+DQo+ID4g
Pg0KPiA+ID4gUmVnYXJkcw0KPiA+ID4gQWlzaGVuZw0KPiA+ID4NCj4gPiA+ID4gLS0tDQo+ID4g
PiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kgfCA2ICsrKy0t
LQ0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDhxeHAuZHRzaQ0KPiA+ID4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDhxeHAuZHRzaQ0KPiA+ID4gPiBpbmRleCA2MWJjY2I2OWYwOWUuLjI2YzRmY2RmZTI5
MCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14
OHF4cC5kdHNpDQo+ID4gPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lt
eDhxeHAuZHRzaQ0KPiA+ID4gPiBAQCAtMzYyLDcgKzM2Miw3IEBADQo+ID4gPiA+ICAgICAgICAg
ICAgIH07DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAgICAgIHVzZGhjMTogbW1jQDViMDEwMDAw
IHsNCj4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImZzbCxpbXg4cXhw
LXVzZGhjIiwNCj4gImZzbCxpbXg3ZC11c2RoYyI7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgY29tcGF0aWJsZSA9ICJmc2wsaW14OHF4cC11c2RoYyI7DQo+ID4gPiA+ICAgICAgICAgICAg
ICAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDIzMg0KPiBJUlFfVFlQRV9MRVZFTF9ISUdI
PjsNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHg1YjAxMDAwMCAweDEwMDAw
PjsNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICBjbG9ja3MgPSA8JmNvbm5fbHBjZw0KPiA+
ID4gPiBJTVhfQ09OTl9MUENHX1NESEMwX0lQR19DTEs+LCBAQA0KPiA+ID4gPiAtMzc0LDcgKzM3
NCw3IEBADQo+ID4gPiA+ICAgICAgICAgICAgIH07DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAg
ICAgIHVzZGhjMjogbW1jQDViMDIwMDAwIHsNCj4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICBj
b21wYXRpYmxlID0gImZzbCxpbXg4cXhwLXVzZGhjIiwNCj4gImZzbCxpbXg3ZC11c2RoYyI7DQo+
ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJmc2wsaW14OHF4cC11c2Ro
YyI7DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDIz
Mw0KPiBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICBy
ZWcgPSA8MHg1YjAyMDAwMCAweDEwMDAwPjsNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICBj
bG9ja3MgPSA8JmNvbm5fbHBjZw0KPiA+ID4gPiBJTVhfQ09OTl9MUENHX1NESEMxX0lQR19DTEs+
LCBAQA0KPiA+ID4gPiAtMzg4LDcgKzM4OCw3IEBADQo+ID4gPiA+ICAgICAgICAgICAgIH07DQo+
ID4gPiA+DQo+ID4gPiA+ICAgICAgICAgICAgIHVzZGhjMzogbW1jQDViMDMwMDAwIHsNCj4gPiA+
ID4gLSAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImZzbCxpbXg4cXhwLXVzZGhjIiwN
Cj4gImZzbCxpbXg3ZC11c2RoYyI7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgY29tcGF0
aWJsZSA9ICJmc2wsaW14OHF4cC11c2RoYyI7DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAg
aW50ZXJydXB0cyA9IDxHSUNfU1BJIDIzNA0KPiBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gPiA+
ID4gICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHg1YjAzMDAwMCAweDEwMDAwPjsNCj4gPiA+
ID4gICAgICAgICAgICAgICAgICAgICBjbG9ja3MgPSA8JmNvbm5fbHBjZw0KPiA+ID4gPiBJTVhf
Q09OTl9MUENHX1NESEMyX0lQR19DTEs+LA0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAyLjE3LjENCj4g
PiA+DQo+ID4NCj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXw0KPiA+IGxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0DQo+ID4gbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+ID4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJv
dGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZsaXN0cw0KPiA+IC5pbmZyYWRl
YWQub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGbGludXgtYXJtLWtlcm5lbCZhbXA7ZGF0YT0w
MiU3DQo+IEMwDQo+ID4NCj4gMSU3Q2hhaWJvLmNoZW4lNDBueHAuY29tJTdDMjVkMzU5NjlhNTkw
NGQyY2Q0OWUwOGQ4NDgxNDhiNDklN0M2DQo+IDg2ZWExZDMNCj4gPg0KPiBiYzJiNGM2ZmE5MmNk
OTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzNzMzODYwMDM5ODc0MDg4OCZhbXA7c2RhdGENCj4gPU9W
cnlMZA0KPiA+IDRxN0x2RW9TbDZkcVFoYlI0VldnaTZUcUJZRSUyQlM5YkkxTTZaWSUzRCZhbXA7
cmVzZXJ2ZWQ9MA0K
