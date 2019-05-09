Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45C4018AAB
	for <lists+linux-pwm@lfdr.de>; Thu,  9 May 2019 15:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfEIN3q (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 May 2019 09:29:46 -0400
Received: from mail-eopbgr150083.outbound.protection.outlook.com ([40.107.15.83]:29201
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726411AbfEIN3p (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 9 May 2019 09:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipLgI9uG2Y7Pc4oX1E95+VFiySIHuha+r3gUbt2/7lo=;
 b=oc1g4Zn9oCC0ZtJ179Z0/dyXSxjYLLlmhBQRQ+Wvk5CHOE6dZLTGATZw1X9Ks4zIG6smec8YQZg3i6q4CuuuCDNYRHyn+hKhoRhEKYJGdm60HH/eB9M5s0HoIdwV0RcXE24z13gBvPm39MtXGEhQdcgCvGc4hvmZPCqTV6pKmJA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3788.eurprd04.prod.outlook.com (52.134.72.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Thu, 9 May 2019 13:29:41 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1878.022; Thu, 9 May 2019
 13:29:41 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V12 4/5] ARM: dts: imx7ulp: Add tpm pwm support
Thread-Topic: [PATCH V12 4/5] ARM: dts: imx7ulp: Add tpm pwm support
Thread-Index: AQHVBmtCFtUJ7C74WE+uBYxCWcYNvA==
Date:   Thu, 9 May 2019 13:29:41 +0000
Message-ID: <1557408252-21281-5-git-send-email-Anson.Huang@nxp.com>
References: <1557408252-21281-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557408252-21281-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0001.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::13) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be6e1344-6f9a-46de-6f9a-08d6d4826457
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3788;
x-ms-traffictypediagnostic: DB3PR0402MB3788:
x-microsoft-antispam-prvs: <DB3PR0402MB3788EB399F64E0E74ABDA760F5330@DB3PR0402MB3788.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:243;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(39860400002)(136003)(376002)(199004)(189003)(256004)(99286004)(102836004)(2201001)(14444005)(14454004)(66066001)(25786009)(305945005)(486006)(476003)(4326008)(478600001)(71200400001)(71190400001)(86362001)(316002)(6436002)(66946007)(66476007)(64756008)(66556008)(73956011)(66446008)(110136005)(386003)(6506007)(68736007)(52116002)(6512007)(76176011)(26005)(7416002)(8676002)(81156014)(81166006)(6116002)(8936002)(50226002)(6486002)(2501003)(3846002)(53936002)(7736002)(4744005)(186003)(36756003)(2906002)(5660300002)(446003)(2616005)(11346002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3788;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5aIvzgepYQqD5Ktv3maEbiZV2e+f6hz7zG8srGLESqemp1KETLi+TnbN9zoCBBMlWm1k/VH5AiOR+/dm5TMXqVnNrWZuzIH29SGst2oufgd1uS8x9WNIIzf09QOX47UBlsPSXA57wEWlk3w30ep5iyA3Y8UUrhYuLP/zhHe4ZsDcwdA+BwY2ljGrNakie3qpOtv8VTJZ6lGQkdvsFwj10A9lSS08rOU2GwccM8tHKjiC8uL+biPP514mJXo8eNBelvJcfRaSJQ1u0IyhpnhjWWYHXGbor2A2K7rys+IVS6lE5jpv8wjAZgNLYvytLZIHHNtz/do57P55QsCEo8NIH0xtLqLwIa9lGghrimntwt46otvd2IS5soahCcgB516vww8oGrFm+v0Vmu4SJOnDJsBdz5WgD0u0FDjG4ZY5yRU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be6e1344-6f9a-46de-6f9a-08d6d4826457
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 13:29:41.8826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3788
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

QWRkIGkuTVg3VUxQIEVWSyBib2FyZCBQV00gc3VwcG9ydC4NCg0KU2lnbmVkLW9mZi1ieTogQW5z
b24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQotLS0NCk5vIGNoYW5nZS4NCi0tLQ0KIGFy
Y2gvYXJtL2Jvb3QvZHRzL2lteDd1bHAuZHRzaSB8IDEwICsrKysrKysrKysNCiAxIGZpbGUgY2hh
bmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMv
aW14N3VscC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14N3VscC5kdHNpDQppbmRleCBkNmI3
MTEwLi44ZmI5NTU5IDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14N3VscC5kdHNp
DQorKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg3dWxwLmR0c2kNCkBAIC0xMjQsNiArMTI0LDE2
IEBADQogCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJCX07DQogDQorCQl0cG00OiBwd21ANDAy
NTAwMDAgew0KKwkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDd1bHAtcHdtIjsNCisJCQlyZWcgPSA8
MHg0MDI1MDAwMCAweDEwMDA+Ow0KKwkJCWFzc2lnbmVkLWNsb2NrcyA9IDwmcGNjMiBJTVg3VUxQ
X0NMS19MUFRQTTQ+Ow0KKwkJCWFzc2lnbmVkLWNsb2NrLXBhcmVudHMgPSA8JnNjZzEgSU1YN1VM
UF9DTEtfU09TQ19CVVNfQ0xLPjsNCisJCQljbG9ja3MgPSA8JnBjYzIgSU1YN1VMUF9DTEtfTFBU
UE00PjsNCisJCQkjcHdtLWNlbGxzID0gPDM+Ow0KKwkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQor
CQl9Ow0KKw0KIAkJdHBtNTogdHBtQDQwMjYwMDAwIHsNCiAJCQljb21wYXRpYmxlID0gImZzbCxp
bXg3dWxwLXRwbSI7DQogCQkJcmVnID0gPDB4NDAyNjAwMDAgMHgxMDAwPjsNCi0tIA0KMi43LjQN
Cg0K
