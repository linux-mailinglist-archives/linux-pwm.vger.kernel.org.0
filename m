Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAC71D704D
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2020 07:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgERFVo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 May 2020 01:21:44 -0400
Received: from mail-vi1eur05on2057.outbound.protection.outlook.com ([40.107.21.57]:55188
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726040AbgERFVo (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 18 May 2020 01:21:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRcU9Xt8GqkC9WLWoCbkX8WZ0T0zFQnyDENxEpHCGY/7S1/Kj4bIQCoZDXCsASGtGTgr9PVXtCcPA1iuFqKxy+Ocz3nMVLvQ6TWeilEPm7eRR/zTBqkIoOMW7+4xX2IO6RMUprr6JjsJV2sCU/dA6fz98vUnKcMHQ4lqcD+INorTbTcvK8WxG/OUeKC1+XStMiGp2BFD6wt5/XMYbFvy9nLL+R1san/aPfVXI3uBfcnNXfZCfYWyMfR0yxY0SvtoZHA+0/AOM1P1egLu+JHYPRgKjYZ5DGTUybiieFjy69HagSg7UnLBFymYpN8gONdHS7gzKOyDATW8hAXTIV9n9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oc6qIUXHz5IOosWzRmHZ6tUmHdy6uSb0rhM345nEyVI=;
 b=oK+GCbMuJesfuJdEq2LH/RsyFslZcWBtDUbETTEHtd63xIzs0wbyU2eYRMapK2w12leIl92SCsY2Ic28NUAgW9mVtxrJWEtASwRw2fp0Dqvq2c+2nCRehcMbPG+erkEh9BLI9DK4jq9FhOgRYgQqLX+miCYuDClLT3eF+9JM0/QrR9LJKyu9ywoO5p7dsTH4y+yc3Lch6mzXEi9MZmL5Pe9Hv7eA2/aqH7g3CUfmRLgY7NUhJRK4ZPN+18FUNteBzjDhc9FvCD0+BRRCr/Xjlxb2+Op82jVWc18Vo4hI+xTtLDY/2ZYCzrW3H4mEEnBiv6MWwO4xfS1V3In+l3ZUbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oc6qIUXHz5IOosWzRmHZ6tUmHdy6uSb0rhM345nEyVI=;
 b=R9WyFrIS31IffWf7D2iChOB03xOwb2HdK3Tde0GQP4QHSSlqUbEvVFJGnj/F/DwPMwpG3m6lwmZ5ktMxVAS+IyT2E9ZLUxTHCQ2eQXOOjCUQ8tamXlVc3OYacsnBZUnULCaNZYC6R7gbXaKua0VddBg38mH5VG7qNUsmVFerAHw=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5687.eurprd04.prod.outlook.com (2603:10a6:20b:a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 05:21:39 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 05:21:39 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] dt-bindings: pwm: Convert mxs pwm to json-schema
Thread-Topic: [PATCH] dt-bindings: pwm: Convert mxs pwm to json-schema
Thread-Index: AQHWKeXny41UDiiW/0yEHY+vY7fj6qitPUug
Date:   Mon, 18 May 2020 05:21:38 +0000
Message-ID: <AM6PR04MB4966B92CFFA23DD77748C77680B80@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589456470-2658-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1589456470-2658-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e29da2b0-9a82-4d0c-3c5f-08d7faeb57b4
x-ms-traffictypediagnostic: AM6PR04MB5687:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB5687A428288EA2E84E3EAD4880B80@AM6PR04MB5687.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hcHSH6zlbJBkCbeXQXL8I4GkuwMuPxw1OsB16bniWkhrJzcd+kKtdJomQXmquMsHotO+k00Z8VF8m+BVpmpMqcND6RH6AywDXOk1sIaoQe5pdNGmDKJlT0ZmFciFcb6OdAwAOKhW73mTBMLQhPvVt1L8jvMrF9+/W7dq8y5mbVlq7KFezEXPxDFG+FtqU8WBL1D9IkUAQVdQybJr+88aZERyNKO+4eua6sRWJ7rRXCxCY4oArH3U8t2hFlRUZRAultNmLrwSH4AH1ZgzbrbQxNkba1EsauQEyNTfHX6MAS3C8E+iOdrzljLDIHYVUZn2PgZuEi1DxVtWBn7TWhe+N7tkvfEpYmwn25fIVXeY2rCLRMJac5WCM1/rr2YmHxqIWY0bDUHJ6NKZ4KLXB2k8S8WwCyPpvuZcwdqWrPpijaZ+Ik9+Zhu8+PZv8AHnMC+xHamfqYs1LgMjArEMbiv0TW5s7H1SOvDt5N8BCBt7xVI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(8936002)(44832011)(71200400001)(8676002)(7416002)(7696005)(4744005)(186003)(26005)(5660300002)(33656002)(6506007)(86362001)(110136005)(55016002)(316002)(9686003)(66446008)(64756008)(478600001)(76116006)(66946007)(66476007)(66556008)(4326008)(52536014)(2906002)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: o4yrkKHSYK6pSpfr9uIV+UuFx9kkMyZ/l+aUjtG3oZXj+y9/fdhZ7dJL4ei7g30oi23mb5u6v/oqK8gze4KobC1PyZfZTzv1aEwLtC9RpyROL9vu2yn7qmKH6UuaQ+l9a9ZaJbCpPP87isfO8qGnKapzGt1p+Sv5eW2dYfeAktGWQCfGb0vLTjSCE96qdrFEgiCFB4zW9lPNvhTF4BV8TlKpHVBvrHXP3lRITFEgaBlUG+U20gcAQOZFHZwMyQOIoeiVAIAsZMGJPZB6m/1rLDA9WEw37Yy2ZWbo4+sf5Dr6Ef2N3GcWZylyaCEYGOnosNRuRaDmykE+e1hQbTadQbDUddhvrtnsKCrkRx96bUugHDrkfCgeTZBpDwNB7gsKLNIhwZJ+l6Y6YLDKnP73bDFVUtgx4qc/taPgycPUwCpY0BIGE+tOzIuHkEu+UhKTck2l6jNY1kLO8Tu+KGAI0OGQfeD/CQ/7QT5N93ANAys=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e29da2b0-9a82-4d0c-3c5f-08d7faeb57b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 05:21:38.7595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FRJm/gm3TQMINLWoUx9CsH/SnLfBhZSIbFKXcPI0s/qQtc9yBYMTqLQ/l0pZrew08p153rLe+yCrg22xcMgOdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5687
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

PiArdGl0bGU6IEZyZWVzY2FsZSBNWFMgUFdNIGNvbnRyb2xsZXINCj4gKw0KPiArbWFpbnRhaW5l
cnM6DQo+ICsgIC0gU2hhd24gR3VvIDxzaGF3bi5ndW9AbGluYXJvLm9yZz4NCj4gKyAgLSBBbnNv
biBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gKw0KPiArcHJvcGVydGllczoNCj4gKyAg
Y29tcGF0aWJsZToNCj4gKyAgICBlbnVtOg0KPiArICAgICAgLSBmc2wsaW14MjMtcHdtDQo+ICsN
Cj4gKyAgcmVnOg0KPiArICAgIG1heEl0ZW1zOiAxDQo+ICsNCj4gKyAgIiNwd20tY2VsbHMiOg0K
PiArICAgIGNvbnN0OiAzDQoNClNlZW1zIHlvdSBtaXNzZWQgdGhlIHJlZmVyZW5jZSB0byBwd20u
eWFtbC4NCg0KUmVnYXJkcw0KQWlzaGVuZw0KDQo+ICsNCj4gKyAgZnNsLHB3bS1udW1iZXI6DQo+
ICsgICAgJHJlZjogJy9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMicNCj4g
KyAgICBkZXNjcmlwdGlvbjogdTMyIHZhbHVlIHJlcHJlc2VudGluZyB0aGUgbnVtYmVyIG9mIFBX
TSBkZXZpY2VzDQo+ICsNCj4gK3JlcXVpcmVkOg0KPiArICAtIGNvbXBhdGlibGUNCj4gKyAgLSBy
ZWcNCj4gKyAgLSAiI3B3bS1jZWxscyINCj4gKyAgLSBmc2wscHdtLW51bWJlcg0KPiArDQo+ICth
ZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4gKw0KPiArZXhhbXBsZXM6DQo+ICsgIC0gfA0K
PiArICAgIHB3bUA4MDA2NDAwMCB7DQo+ICsgICAgICAgIGNvbXBhdGlibGUgPSAiZnNsLGlteDIz
LXB3bSI7DQo+ICsgICAgICAgIHJlZyA9IDwweDgwMDY0MDAwIDB4MjAwMD47DQo+ICsgICAgICAg
ICNwd20tY2VsbHMgPSA8Mz47DQo+ICsgICAgICAgIGZzbCxwd20tbnVtYmVyID0gPDg+Ow0KPiAr
ICAgIH07DQo+IC0tDQo+IDIuNy40DQoNCg==
