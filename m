Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD3B1D7060
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2020 07:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgERFbr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 May 2020 01:31:47 -0400
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:17871
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726040AbgERFbr (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 18 May 2020 01:31:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJfAxd0P9Dk4DLE3hfzOyhYv2z0dDuMVO39WrtvDFegZsm4wqHgZnvvpIROFdXnN25dXJ94s9cGYoShsRT6RY0IzENR2FVU60mHzVhmVFmL6gur44hXeuJlfxs5GNdPVXzjJ3EhbYBD8IW1pu+wH+Q58QDdURAPoVd/cg4DCHz/Iue5f4krcitqnkWV0litn9T7sjesNCVQAz+cJm01a8NDq2KvZInpn/Qyj8MLtQsk3uKRFzaFt3p/8uPgVjMwIIZXez0SPz7RIPa1cj6/QP+29Mpd3HXzhjD3/xuIVe12j0MGe9yOShVKpgZmxQjq6FPPciHKezNJSOIraOR8pDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRizpJhk7+qdJh3MbajO9cq3eB/cwAZ4p9CleWXEzdA=;
 b=WISaLMaIjk/8v4qp50tKZEzNSUJ+eBFSc7+CTYkIifwNkoGPOfee+C+7mG4IF1AapEPfqUacEEhifwiB98CNOC0qNzYNwF9X3FwdlhLHIxsJoxda5qumdCel2MTFEye4RS0SQiAmrudIAP0WpGHpAvPfhOcRtNqNqDliXoDrURubGonkFRCaR/NFoe8wJoaWUl683rtGXrxmluODwSBsdVdvtovGA7mO65/G1MxEO/maAyLUXrAERbuW4BXXtdYWTvjZcjxVOqWXX/CSC3WPpygiOC2M5cZE1L41BfTuravRxliNX4kk93ax6WZQuOd+XATjR56n1TaX8QDseFkfIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRizpJhk7+qdJh3MbajO9cq3eB/cwAZ4p9CleWXEzdA=;
 b=jZMmIFRSKAtWd1t8HFjC8k5NkhV33MKh4gDEI1gTB12lQOfjW4scCMJZ7WIt47KXnvACNfDh2FUy1MLUOz4QRbPUjIgmCGnLEM2/RQrgQT1BbnAgFrkT8yKAf1gRpoz2SOgY1UmzTsFoY1/cARBzTuY9neqi4mk9SE+TTdMWyug=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3691.eurprd04.prod.outlook.com (2603:10a6:8:5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.31; Mon, 18 May
 2020 05:31:43 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 05:31:43 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
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
Thread-Index: AQHWKeXnwgIqcPijn06Ta1X0H9EaU6itVJ0AgAAB8bA=
Date:   Mon, 18 May 2020 05:31:43 +0000
Message-ID: <DB3PR0402MB3916B5980C0681BFF3C08FE5F5B80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1589456470-2658-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB4966B92CFFA23DD77748C77680B80@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB4966B92CFFA23DD77748C77680B80@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d7b47085-4ca6-4301-322b-08d7faecc010
x-ms-traffictypediagnostic: DB3PR0402MB3691:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3691DEF429E06F2C6898F056F5B80@DB3PR0402MB3691.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LDX3N41jtK/KebeZZ8f2no2NonKRWpI+w8ru/evEHqix5Xp8hG/S9Xkpgb3/vyCQHPFuIBLkzgx0RLPVvruZgFbW/MCfW6rvwCNW7GWIB8NfcrMA6Wls24SycJF+0BbkFPnKWmNQ7ND4cevA3qG54j7b5Z/Byj7EKetZ9gjbrdJQ57Nw8nLSoI5VrpwgRAeYqEdLDakE24T7paRg/eaqDafnAbqkGFpsyIcCnI/9YpOltb+SHFvvmcwIbrJERenQsCbd33IEEDHLSYFEIsM+d//wtcc5vWozenz4Y5YKNwqKpm/J2sqY4+vXDz0e9P9bqe1ArCPgrG/ymPxrlaWJ3qUGcRIGuOOTzXmgNAi3bKft+RZszZdhw5sChsUd0TYESu+Qwo4aeyqgIL25FV0BMoc4D4XnmvflnXjKeRh6cWMl0z6dA2o6cW9Ca/Hjk9bnDE2YxgSWZmmwNLyGdF2vPoWDiKkQy+/mAOPLCZTU/7w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(66446008)(64756008)(66556008)(66476007)(76116006)(66946007)(86362001)(7696005)(478600001)(5660300002)(4326008)(2906002)(8676002)(6506007)(8936002)(55016002)(44832011)(71200400001)(9686003)(52536014)(26005)(186003)(110136005)(316002)(33656002)(7416002)(4744005)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: zQ5k9qRWnFoebgB+3CUOod6FgKs9wGvonejCjt7F4hR3AW3HR3XSryIPndQK46HgpnTkgXfhjbrA4qaDajy0Gry5UYClTkHWSUMkFpHMqP4bgBYLl529MNhZavZOrUN19MFF/y668LA5Jw3UoeHu0FZszxcyRs7zUq45Fp0VgNVbTD19hxnYqSlGn1afbTIsEK4203KCThLEwpjUF18szXlQCJUiZXGI/XgxgH/SjsyTsPR83H0pebZZrh04uKn0MAlNPkEq6IX9k4y3xocGEEPzVTiPwAvHEIkE7ujxPAfCfLtSZEc9pWS0TgBpTy+4Ta5zNxmjxYUHzbq5oT9AOu7dIjFbAhmIbjQtejL+p8XiDJ4xuMnRzDIlTvgbNM0ts74wFNcdjgt/xYG/SDa6IyZKiI99Z6rgA+wQP8Imu68BwLlIjIqPsE3q4jnKG9SeGHBSgoP6ocHVzznVe8qgegr41/sfL7cy++GH+5bMngxA/xNv4Dic7FcxRseld06a
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b47085-4ca6-4301-322b-08d7faecc010
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 05:31:43.6887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X4pqvJLm0DZQqIl0787b5zod2+kZNjVMvoNBihtvYwyUZTNYYMt1uKcEZiogoLqP/L4esjUeC7mKl3IPsYV5xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3691
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

DQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gZHQtYmluZGluZ3M6IHB3bTogQ29udmVydCBteHMg
cHdtIHRvIGpzb24tc2NoZW1hDQo+IA0KPiA+ICt0aXRsZTogRnJlZXNjYWxlIE1YUyBQV00gY29u
dHJvbGxlcg0KPiA+ICsNCj4gPiArbWFpbnRhaW5lcnM6DQo+ID4gKyAgLSBTaGF3biBHdW8gPHNo
YXduLmd1b0BsaW5hcm8ub3JnPg0KPiA+ICsgIC0gQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54
cC5jb20+DQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4g
KyAgICBlbnVtOg0KPiA+ICsgICAgICAtIGZzbCxpbXgyMy1wd20NCj4gPiArDQo+ID4gKyAgcmVn
Og0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgIiNwd20tY2VsbHMiOg0KPiA+
ICsgICAgY29uc3Q6IDMNCj4gDQo+IFNlZW1zIHlvdSBtaXNzZWQgdGhlIHJlZmVyZW5jZSB0byBw
d20ueWFtbC4NCg0KSXQgaXMgYmVjYXVzZSBtYW55IHB3bSB5YW1sIGZpbGVzIGFsc28gaGFzIG5v
ICIjcHdtLWNlbGxzIiByZWZlcmVuY2UsIHNvIEkNCmFtIE5PVCBzdXJlIGlmIGl0IGlzIGEgTVVT
VDoNCg0KRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9hbGx3aW5uZXIsc3Vu
NGktYTEwLXB3bS55YW1sDQpEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2dv
b2dsZSxjcm9zLWVjLXB3bS55YW1sDQpEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cHdtL2lxczYyMGEtcHdtLnlhbWwNCi4uLg0KDQpBbnNvbg0K
