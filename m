Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23EF24F677
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Aug 2020 11:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgHXJAi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 05:00:38 -0400
Received: from mail-eopbgr30073.outbound.protection.outlook.com ([40.107.3.73]:1239
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729064AbgHXJAZ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 24 Aug 2020 05:00:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGQLYBAOUvkgGSljhGAu5G6xFtKdD+mfC8RBAb3oeTeOIjXC8PHDBAKZ8lbz72Of1bIdXnRtVo3Dcd2xRgHYYb0Um0EH5/vO3VNoD7v4rAH8BOVlm+jjQ56Vd7vgSmXmc0lKuMDqnF4OUnm8gu7RCGZRjrU9FKwK405Yiy/0UdiGN44hK6GLuOZMFr3GLHBs7tBsXGbt4n9p2Wh7qju4gcfZze37DaPHgMs5/neKCZaugdIFJRXCFet/jmFtIDGhoEzhi8nosnrhobu/51PNNpjVPrc+xe0B9B1AyxBu19XsidWI4Us0lR1QP7WIR/KoQGSk8ZG0ub0464IvUfUAdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Oi07fpJKhwidrgeiwmkna4p8Jzdtdd08CuuGi7iEqQ=;
 b=fiw407YCAcraZ7XGHx6W3vb8cd/a1AXY9+9W1wC+j0DpeX6WPVR00GWsR94SR1xuGxNL35hllUbFQlbweDPet7IDjrQrRy0mxLtspiRevA8pbvZjhKakRzM8ZLFzts6m0Xbj16diyWdTzCN4WwoTVvylLIHjFhKXmoaVgeuiiyJweOeG+aD7rFeP0uo5fsKTXJ8tryM9Oe720aKw44gTvRFHtpTZ5by2KzsNeQnO02MHIdAC/pENZ5xepOC8t0yiTVa3TXZfA99boY+q43z7jbQu7mGsTG/gkeHyXwf4c7KjYfxLo5U+2tCFEUml/OQiAIpjHmt91PnqLdB9LcgsHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Oi07fpJKhwidrgeiwmkna4p8Jzdtdd08CuuGi7iEqQ=;
 b=fOf2jCyrVMDFH/YYVps6YuPEphvx76u90mJYkfArfa82WG0vWO1SIogABWFktWPBB5p4gDX7HUsaYOJDd6l+EI5kHgXVafsBAKNo3b0QF+PwzNjrSN05U/i7ajjZ2uqWItSb8p942iFaEl0cd8QtbpYsJdtvJZtv22cmI6oVtO8=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR0402MB3894.eurprd04.prod.outlook.com (2603:10a6:209:20::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Mon, 24 Aug
 2020 09:00:20 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::99b5:145d:16cc:78ca]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::99b5:145d:16cc:78ca%3]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 09:00:19 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <anson.huang@nxp.com>
Subject: RE: [PATCH 21/22] arm64: dts: imx8qxp: Remove i.MX7 compatible from
 USDHC
Thread-Topic: [PATCH 21/22] arm64: dts: imx8qxp: Remove i.MX7 compatible from
 USDHC
Thread-Index: AQHWeWjs3+F925Bk106zrc9FAFewr6lG9uLw
Date:   Mon, 24 Aug 2020 09:00:19 +0000
Message-ID: <AM6PR04MB49668B0F67B02B2A33603B4880560@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <20200823161550.3981-1-krzk@kernel.org>
 <20200823161550.3981-21-krzk@kernel.org>
In-Reply-To: <20200823161550.3981-21-krzk@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3f9b0d02-acba-4307-918e-08d8480c20c6
x-ms-traffictypediagnostic: AM6PR0402MB3894:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0402MB389430D49307CE2BAA78F7BC80560@AM6PR0402MB3894.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 67I/EcZQbxLD8cgq45bPaFHWiAgYKRlN6FdV/oA7EsQbON53d7MTJrro7YJ+LXT92IfXAgjDJDviHocnXa1xVQ6KI003EMt7a+M/3Q+O1YO39MiQ8T48jwio62qhcOxJC11ugn45a3cudhkehhdoIQhiMxqWy0AyR6HoM4HEmoQWz0uiicUzGX0gOU0NcECeQl3/lAryj/SHhcBNJV3EPMdODrKx5ubPAU3co7eq8AFbRBybfcRNByfzd4J4/J+HPr9pifpgtHg2UaOiUOd1eIwofpB1D2fPH3opy9mGlEHEcGj8iEpBC80qOHH9Jbf/Ewz/5girr/oLsCXmpP7uD8AlbQx/OtWzcq/wDGoZe+dkdYbwTghS75HLbK/dEUis3s+bpaIZKHzo8XwEDiGjKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(316002)(110136005)(44832011)(8936002)(7696005)(9686003)(26005)(4326008)(186003)(7416002)(2906002)(478600001)(8676002)(54906003)(6506007)(66946007)(76116006)(5660300002)(83380400001)(66476007)(33656002)(86362001)(66556008)(66446008)(64756008)(52536014)(55016002)(71200400001)(921003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: RkLyOxMxPiIXid+HwKWJ/5uHIVEUO0bTM+49E57o2YxuyHxmxIDTCZM9HqxdIcxhO3do+NdNJn9+oeQPfkfibdKlIwZD50XB3qvs29Nc6hcTDBSTGcQbrnso1Edpsy75EVL/sv/tfZwxF99WQboSJ7C+FsOIFwKUSHxhGnbUxi7gahLgLK1DcTJi3MSFe8wSTGvtFeu3FuYO+wG0iZV7KDnWAlOzhV36kAXv+skpesA4AuO07q55j8YzXvi1qGqOaubt4lKCRsfujpUjJyBnO6lcCMGm1vt4FA+bb8NTABeppxdgPxz3Bi9tuW7oDAiDXW7I94magYMUK18jLl93q2IrUEmU11K8TLuPbXh79UV5ncUPBN3eu/tKQxGPSYn9DJdPAOjEUz8K5P4XO3W8PAcIYWtXc6Hr4XS9FsI2uxKI994TJYZSRC+tV94+OQ+R4hnqfClFA1uie90Al4IprD9pz5cey2/NDNRlDc/lhymVzr2zj0VmmZuDzAVsxHoNXlCmXwNwWBRIVdYePOxwL229UjoiXmn0gBFUs73cI7H7FKIl+xQbkic1L59HhVBij3kfmaOBb3tWy5IufVKpsdWEeLuZNYP6Wf8a8H0h7PDMWEXYlHV0i88O4tq+jfD5B1vub5G1lX3kZ6mtgOPaKw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9b0d02-acba-4307-918e-08d8480c20c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2020 09:00:19.7937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P2X+PmlpoE6tIjOjAM2mB1F0wDKpA7ypCLWmTpoFTCbMfQwijkKRz6eEFG8L0wjQUMC78JXRWFpB0AC1geZxeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3894
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IE1v
bmRheSwgQXVndXN0IDI0LCAyMDIwIDEyOjE2IEFNDQo+IA0KPiBUaGUgVVNESEMgb24gaS5NWCA4
UVhQIGhhcyBpdHMgb3duIGNvbXBhdGlibGUgZGVzY3JpYmVkIGluIGJpbmRpbmdzIGFuZA0KPiB1
c2VkIGluIHRoZSBkcml2ZXIgKHdpdGggaXRzIG93biBxdWlya3MpLiAgUmVtb3ZlIGFkZGl0aW9u
YWwgZnNsLGlteDdkLXVzZGhjDQo+IGNvbXBhdGlibGUgdG8gZml4IGR0YnNfY2hlY2sgd2Fybmlu
Z3MgbGlrZToNCj4gDQo+ICAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC1h
aV9tbC5kdC55YW1sOiBtbWNANWIwMTAwMDA6DQo+ICAgICBjb21wYXRpYmxlOiBbJ2ZzbCxpbXg4
cXhwLXVzZGhjJywgJ2ZzbCxpbXg3ZC11c2RoYyddIGlzIHRvbyBsb25nDQo+ICAgICBGcm9tIHNj
aGVtYToNCj4gL29jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9mc2wtaW14LWVz
ZGhjLnlhbWwNCj4gDQo+ICAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC1h
aV9tbC5kdC55YW1sOiBtbWNANWIwMTAwMDA6DQo+ICAgICBjb21wYXRpYmxlOiBBZGRpdGlvbmFs
IGl0ZW1zIGFyZSBub3QgYWxsb3dlZCAoJ2ZzbCxpbXg3ZC11c2RoYycgd2FzDQo+IHVuZXhwZWN0
ZWQpDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5l
bC5vcmc+DQoNCkZvciBQYXRjaCAxOS0yMiwgSSB0aGluayB3ZSBzaG91bGQgZml4IGR0IGJpbmRp
bmcgZG9jLg0KDQpSZWdhcmRzDQpBaXNoZW5nDQoNCj4gLS0tDQo+ICBhcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kgfCA2ICsrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kNCj4gYi9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kNCj4gaW5kZXggNjFiY2NiNjlmMDllLi4yNmM0
ZmNkZmUyOTAgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lt
eDhxeHAuZHRzaQ0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhw
LmR0c2kNCj4gQEAgLTM2Miw3ICszNjIsNyBAQA0KPiAgCQl9Ow0KPiANCj4gIAkJdXNkaGMxOiBt
bWNANWIwMTAwMDAgew0KPiAtCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OHF4cC11c2RoYyIsICJm
c2wsaW14N2QtdXNkaGMiOw0KPiArCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OHF4cC11c2RoYyI7
DQo+ICAJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMjMyIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0K
PiAgCQkJcmVnID0gPDB4NWIwMTAwMDAgMHgxMDAwMD47DQo+ICAJCQljbG9ja3MgPSA8JmNvbm5f
bHBjZyBJTVhfQ09OTl9MUENHX1NESEMwX0lQR19DTEs+LCBAQA0KPiAtMzc0LDcgKzM3NCw3IEBA
DQo+ICAJCX07DQo+IA0KPiAgCQl1c2RoYzI6IG1tY0A1YjAyMDAwMCB7DQo+IC0JCQljb21wYXRp
YmxlID0gImZzbCxpbXg4cXhwLXVzZGhjIiwgImZzbCxpbXg3ZC11c2RoYyI7DQo+ICsJCQljb21w
YXRpYmxlID0gImZzbCxpbXg4cXhwLXVzZGhjIjsNCj4gIAkJCWludGVycnVwdHMgPSA8R0lDX1NQ
SSAyMzMgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ICAJCQlyZWcgPSA8MHg1YjAyMDAwMCAweDEw
MDAwPjsNCj4gIAkJCWNsb2NrcyA9IDwmY29ubl9scGNnIElNWF9DT05OX0xQQ0dfU0RIQzFfSVBH
X0NMSz4sIEBADQo+IC0zODgsNyArMzg4LDcgQEANCj4gIAkJfTsNCj4gDQo+ICAJCXVzZGhjMzog
bW1jQDViMDMwMDAwIHsNCj4gLQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhxeHAtdXNkaGMiLCAi
ZnNsLGlteDdkLXVzZGhjIjsNCj4gKwkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhxeHAtdXNkaGMi
Ow0KPiAgCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDIzNCBJUlFfVFlQRV9MRVZFTF9ISUdIPjsN
Cj4gIAkJCXJlZyA9IDwweDViMDMwMDAwIDB4MTAwMDA+Ow0KPiAgCQkJY2xvY2tzID0gPCZjb25u
X2xwY2cgSU1YX0NPTk5fTFBDR19TREhDMl9JUEdfQ0xLPiwNCj4gLS0NCj4gMi4xNy4xDQoNCg==
