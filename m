Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A067818AB0
	for <lists+linux-pwm@lfdr.de>; Thu,  9 May 2019 15:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfEIN34 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 May 2019 09:29:56 -0400
Received: from mail-eopbgr50060.outbound.protection.outlook.com ([40.107.5.60]:22357
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726054AbfEIN3z (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 9 May 2019 09:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeUweS/VZAn2fh4/eFhKzhdwC+uKv8rDe746QlgMp+k=;
 b=h6eNm6DCMbp+SxsobjNt1H9NpbCMt9HW7ePkxYVOzrUiVDwLmdO8uuGOsN8otshAu70OUkX5hUwnTqQQ7W3ltV90TTn4gjC/lQFRjWtPTTjZSPCFgutAU+SCF3oVNPwX+9c6DMvoSvQjYtIRoFoCFk5ymh5AbijRT7nTFAmjQZU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3673.eurprd04.prod.outlook.com (52.134.70.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Thu, 9 May 2019 13:29:50 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1878.022; Thu, 9 May 2019
 13:29:50 +0000
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
Subject: [PATCH V12 5/5] ARM: dts: imx7ulp-evk: Add backlight support
Thread-Topic: [PATCH V12 5/5] ARM: dts: imx7ulp-evk: Add backlight support
Thread-Index: AQHVBmtHFU9Wn9MxQkO02kKidSBEsQ==
Date:   Thu, 9 May 2019 13:29:50 +0000
Message-ID: <1557408252-21281-6-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 315240dc-3388-426a-9fdb-08d6d4826997
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3673;
x-ms-traffictypediagnostic: DB3PR0402MB3673:
x-microsoft-antispam-prvs: <DB3PR0402MB36732CE5BE45F2C45D80E3BBF5330@DB3PR0402MB3673.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:243;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39860400002)(346002)(366004)(199004)(189003)(7416002)(6512007)(86362001)(2201001)(6486002)(305945005)(66556008)(66946007)(73956011)(66476007)(64756008)(7736002)(66446008)(316002)(99286004)(2906002)(186003)(6436002)(26005)(53936002)(102836004)(66066001)(50226002)(4326008)(76176011)(36756003)(52116002)(81156014)(386003)(6506007)(2501003)(8936002)(71200400001)(14454004)(81166006)(8676002)(71190400001)(68736007)(110136005)(5660300002)(3846002)(11346002)(446003)(256004)(478600001)(486006)(476003)(25786009)(6116002)(2616005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3673;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8w6bGnY4IM3nQmWoXfzIT3z6SE38bnGkI29h3ju4H64twWRaTP6e3RPM4G7Te+83UZZWhAlmNDv4DefwRiNzk1tKMGjdE0X9SQr0lCFnCs3ar4BpYHqQA/ml028Iwe9ngQfOLgenZ6n3E6CpgoiW7NZt2SZ2e8vhWXf7frXQKrEmHz3yUqYdf30DHCJS8l0AxmJv/EKw5QxdmfIS+mvCEPOmFNC7vVnNzYMhAvRyMc9FzkuvXCaTI1fd0CtRRhnxiQvgx697juiM55JWv/X8RFZHsDtLvMoDfuKBY8wxANidrjsD0zJ2D+IPoGNWhdkTWAy3vGh2Zgae/7S0E6fuPLOA3kKId53QzWraiQ3mqdd+TDTWGBPjTfQwqwt9Fmz4aut2iq8Whuf/PYcODKntNef/CMig1w3YsnceSgmveDc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 315240dc-3388-426a-9fdb-08d6d4826997
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 13:29:50.6999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3673
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

VGhpcyBwYXRjaCBhZGRzIGkuTVg3VUxQIEVWSyBib2FyZCBNSVBJLURTSSBiYWNrbGlnaHQgc3Vw
cG9ydC4NCg0KU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+
DQotLS0NCk5vIGNoYW5nZS4NCi0tLQ0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDd1bHAtZXZrLmR0
cyB8IDIwICsrKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlv
bnMoKykNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDd1bHAtZXZrLmR0cyBi
L2FyY2gvYXJtL2Jvb3QvZHRzL2lteDd1bHAtZXZrLmR0cw0KaW5kZXggYTA5MDI2YS4uNTlmMDk0
ZSAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDd1bHAtZXZrLmR0cw0KKysrIGIv
YXJjaC9hcm0vYm9vdC9kdHMvaW14N3VscC1ldmsuZHRzDQpAQCAtMjIsNiArMjIsMTQgQEANCiAJ
CXJlZyA9IDwweDYwMDAwMDAwIDB4NDAwMDAwMDA+Ow0KIAl9Ow0KIA0KKwliYWNrbGlnaHQgew0K
KwkJY29tcGF0aWJsZSA9ICJwd20tYmFja2xpZ2h0IjsNCisJCXB3bXMgPSA8JnRwbTQgMSA1MDAw
MCAwPjsNCisJCWJyaWdodG5lc3MtbGV2ZWxzID0gPDAgMjAgMjUgMzAgMzUgNDAgMTAwPjsNCisJ
CWRlZmF1bHQtYnJpZ2h0bmVzcy1sZXZlbCA9IDw2PjsNCisJCXN0YXR1cyA9ICJva2F5IjsNCisJ
fTsNCisNCiAJcmVnX3ZzZF8zdjM6IHJlZ3VsYXRvci12c2QtM3YzIHsNCiAJCWNvbXBhdGlibGUg
PSAicmVndWxhdG9yLWZpeGVkIjsNCiAJCXJlZ3VsYXRvci1uYW1lID0gIlZTRF8zVjMiOw0KQEAg
LTQwLDYgKzQ4LDEyIEBADQogCXN0YXR1cyA9ICJva2F5IjsNCiB9Ow0KIA0KKyZ0cG00IHsNCisJ
cGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCisJcGluY3RybC0wID0gPCZwaW5jdHJsX3B3bTA+
Ow0KKwlzdGF0dXMgPSAib2theSI7DQorfTsNCisNCiAmdXNkaGMwIHsNCiAJcGluY3RybC1uYW1l
cyA9ICJkZWZhdWx0IjsNCiAJcGluY3RybC0wID0gPCZwaW5jdHJsX3VzZGhjMD47DQpAQCAtNTcs
NiArNzEsMTIgQEANCiAJCWJpYXMtcHVsbC11cDsNCiAJfTsNCiANCisJcGluY3RybF9wd20wOiBw
d20wZ3JwIHsNCisJCWZzbCxwaW5zID0gPA0KKwkJCUlNWDdVTFBfUEFEX1BURjJfX1RQTTRfQ0gx
CTB4Mg0KKwkJPjsNCisJfTsNCisNCiAJcGluY3RybF91c2RoYzA6IHVzZGhjMGdycCB7DQogCQlm
c2wscGlucyA9IDwNCiAJCQlJTVg3VUxQX1BBRF9QVEQxX19TREhDMF9DTUQJMHg0Mw0KLS0gDQoy
LjcuNA0KDQo=
