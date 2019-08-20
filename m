Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9904F95703
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Aug 2019 07:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbfHTF4p (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 20 Aug 2019 01:56:45 -0400
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:6251
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728878AbfHTF4o (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 20 Aug 2019 01:56:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUwEY7tb/RbfNk6/646no1pIpFlTmY1u67I08zdfjBziu4qmZaEnLGEmEDcKNu82HBoItOUk9A3biVREE4efsYEHSiTfCAd0ICvSUj2oOzz7AVquw3F5XUT3DDPMqISC+sZZ768g7ZkmFvJm7uwunob8ynuwKegJHRTpWE//sC58Hpyu2wJsuPdGL828IKjVIbUAihjXyzqE1SHbE2iHWHlYxwhvaWJeKHqT6Sw6KzhCyLvOldhXkp+uLGwxJgdC8lABvgdyv/Be3vDAPnmwJ8BIXs3jQYOFIOuSH5amyksU8B/OcCaxlHvlv/T1tflQ89U8tVeCG+A9Q2xcZjUa2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuTTLkQWm+BW7NTa3WJWdm9fMGHe5C2RQzAhXSUjuJ8=;
 b=fNrOXGYcrI4pgGhV01aREIEs8YDmkwYhHlmNmPZ7zWyK9YmGvp5e9xIFvQT/ybhbhzbyuvmBEjohiw9GZ63lBwDPmc4ugD9M+1gBsOhmU2SRSxQ0noMfB1SLa0U3ybXvZcuExF9FGV/ZM+9LTBqYdbxTELx3/TwNiA7lqlFeVRyF9oeVs1I154AntjE/ToDrPhTD0AscADAFIR3IMKPUbB9XSmBqb5tJQFgRo9CPoySmw2EREVWIqfcoa/lzPRThv2L+yd5OvqukmddDiwL25gDIHqb3a963+eYvTv8ziHnBAtU2HLmcUeMK1xJIShVWkYRRVKDpg54Bo/rd8Lyb5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuTTLkQWm+BW7NTa3WJWdm9fMGHe5C2RQzAhXSUjuJ8=;
 b=J+7GVeLEkhNWktV0vcP3JgTV52mmFQx08xZdvI1IwAWHerAvauhBuEfe/FazDRExHyPVcIpf7ditKLBvoWzy4VTzohrlG0n+fNPcDyNL3k9ctSv2ozIrtCFrF6VQAug3rSEi74iQh58CVml0bZU4g4CfSpt4dZ74smftfRn8K5M=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3836.eurprd04.prod.outlook.com (52.134.71.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 05:56:40 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e%4]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 05:56:40 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
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
Subject: RE: [PATCH] pwm: mxs: use devm_platform_ioremap_resource() to
 simplify code
Thread-Topic: [PATCH] pwm: mxs: use devm_platform_ioremap_resource() to
 simplify code
Thread-Index: AQHVPQnp3vOphZGlaUm/vNIIqkC+RKbPuYMAgDQEZAA=
Date:   Tue, 20 Aug 2019 05:56:40 +0000
Message-ID: <DB3PR0402MB3916423A6E334EDD4C06B884F5AB0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190718013205.24919-1-Anson.Huang@nxp.com>
 <AM0PR04MB42116F0753C9C6A619A2D8EC80C80@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB42116F0753C9C6A619A2D8EC80C80@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24ae674c-b55e-436e-6ef9-08d725332c18
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3836;
x-ms-traffictypediagnostic: DB3PR0402MB3836:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB383666A63D8A14708B5B761BF5AB0@DB3PR0402MB3836.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:446;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(199004)(189003)(52536014)(44832011)(229853002)(9686003)(486006)(26005)(446003)(25786009)(11346002)(305945005)(55016002)(186003)(33656002)(74316002)(6436002)(7736002)(86362001)(256004)(2201001)(6116002)(3846002)(53936002)(478600001)(4744005)(476003)(76176011)(316002)(110136005)(81156014)(99286004)(8676002)(81166006)(71190400001)(71200400001)(2906002)(102836004)(4326008)(8936002)(66446008)(14454004)(66946007)(66476007)(66556008)(64756008)(76116006)(66066001)(5660300002)(2501003)(6246003)(6506007)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3836;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sFRvB4KPU/Zzbs2AAX+CsemkWtHdhjjSk6rtYcDawN9H/YabBwHqDbl36vjMFzYoVVNPvZnA7nBz6Wk/l2GAhaqYpBd/WpGI61p3dSSqNQvzg4/FAzvyV7FvjSyc10tL+mcILxRBiyOy2GpayeyA5jXMqp9lM2MsXCrr+PR+bvN0UTrNwA24az3TQLbxkrzCjQbbdsUAgIrr/yog6XYzRRXWyjIwV+eAyfL00HxwEPRcNHumMnyWbMTKlvB2PoFXD5o4iWZAQZD0lJqbu7ioJzxMsQJ8YdI8xG41TTS+8+JqU4V7kl1tUXMr7P6dxC9Ugg8Foe/vuMnPGaFdJWFOur4j1o5hd4ZfMFl8BEwbuDjWcshI3wdzBVf1ESIQ7ms3QRE9YF3LoTNwMxxWr9AxqI3xfhnvLxwzTodD/+imEbo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ae674c-b55e-436e-6ef9-08d725332c18
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 05:56:40.8353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JIKu1LigEsV1VdNxZ+ULPEQ+th0/u2zVolUQKhKFEc0SggLA7WqoGtFUF2RGVWeh6j74kORaBrHONXD+4SYNlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3836
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

R2VudGxlIHBpbmcuLi4NCg0KPiA+IEZyb206IEFuc29uLkh1YW5nQG54cC5jb20gPEFuc29uLkh1
YW5nQG54cC5jb20+DQo+ID4gU2VudDogVGh1cnNkYXksIEp1bHkgMTgsIDIwMTkgOTozMiBBTQ0K
PiA+DQo+ID4gVXNlIHRoZSBuZXcgaGVscGVyIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJj
ZSgpIHdoaWNoIHdyYXBzIHRoZQ0KPiA+IHBsYXRmb3JtX2dldF9yZXNvdXJjZSgpIGFuZCBkZXZt
X2lvcmVtYXBfcmVzb3VyY2UoKSB0b2dldGhlciwgdG8NCj4gPiBzaW1wbGlmeSB0aGUgY29kZS4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29t
Pg0KPiANCj4gUmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+
DQo+IA0KPiBSZWdhcmRzDQo+IEFpc2hlbmcNCg==
