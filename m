Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE66518AA8
	for <lists+linux-pwm@lfdr.de>; Thu,  9 May 2019 15:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfEIN3k (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 May 2019 09:29:40 -0400
Received: from mail-eopbgr50078.outbound.protection.outlook.com ([40.107.5.78]:10918
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726411AbfEIN3j (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 9 May 2019 09:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tL1asfgJnfRJQWRmFwjJAkpDx+qGtSYGujCPDbswI0I=;
 b=sbZ67ktrPmj8QYKuWabYlZduRLKcpwJlQcRmB7jpAtyForjAXS15/WWD/9qx7pUGIzieZcVFhxCXxtzFzYoHtIHRImLICVUZEks9L5lekBu1CoZ0x1gR2kK+OmPfJ4pynlczNs61PDVxe7X/tvD5n/f1AkkYKQcpO3Nwxr9cTgc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3673.eurprd04.prod.outlook.com (52.134.70.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Thu, 9 May 2019 13:29:36 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1878.022; Thu, 9 May 2019
 13:29:36 +0000
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
Subject: [PATCH V12 3/5] ARM: imx_v6_v7_defconfig: Add TPM PWM support by
 default
Thread-Topic: [PATCH V12 3/5] ARM: imx_v6_v7_defconfig: Add TPM PWM support by
 default
Thread-Index: AQHVBms+5O9OvVGAVUC7vZMW89GO2w==
Date:   Thu, 9 May 2019 13:29:35 +0000
Message-ID: <1557408252-21281-4-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: da602deb-8dab-43c9-e7c2-08d6d4826095
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3673;
x-ms-traffictypediagnostic: DB3PR0402MB3673:
x-microsoft-antispam-prvs: <DB3PR0402MB367378599BC0E4E25E2C1037F5330@DB3PR0402MB3673.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:262;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39860400002)(346002)(366004)(199004)(189003)(7416002)(6512007)(86362001)(2201001)(6486002)(305945005)(66556008)(66946007)(73956011)(66476007)(64756008)(7736002)(66446008)(316002)(99286004)(2906002)(186003)(6436002)(26005)(53936002)(102836004)(66066001)(50226002)(4326008)(76176011)(36756003)(52116002)(81156014)(386003)(6506007)(2501003)(8936002)(71200400001)(14454004)(81166006)(8676002)(71190400001)(68736007)(110136005)(5660300002)(4744005)(3846002)(11346002)(446003)(256004)(478600001)(486006)(476003)(25786009)(6116002)(2616005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3673;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zdXQSfRSRoSBWEMkR+i3sQS5yhTUEGKSXNtzOBOzTyh5yTsAvHjor1aEHle17C/+7iXnScaJbKh+8X7EOVPRIpsxy/Z1JdQd9PrGPyuSOtsIvCUgNJRiE+TPex6t/5F+b5Nz7HzfHeejZzmt88DaDBzcRkweKhK6rK6EWJTspIQ6AAvOxbA3WO0O1EciETc9Vwe/YWV2QWhzmofJiz0YJeN1zWMyWyjdnPC9rAFHxs/tnbr6Px/rhnznIUgI97UKF5J7YsTbwJuVkQYhtPKbiEe7FrVklYyrjdfg+jVpBDOrfNd0UDib6K5JBkPxfI1EHR8uDldyoebkh2aIgfmyaPMFx8T6KKqnzE+juGz38qsn1odreaW7LAIco+EI7nY+GXjdo3YaulPJt4J2+SJ0QKJSUM9Mauf3CChCAi6NQr8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da602deb-8dab-43c9-e7c2-08d6d4826095
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 13:29:35.6061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3673
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

U2VsZWN0IENPTkZJR19QV01fSU1YX1RQTSBieSBkZWZhdWx0IHRvIHN1cHBvcnQgaS5NWDdVTFAN
ClRQTSBQV00uDQoNClNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAu
Y29tPg0KLS0tDQpObyBjaGFuZ2UuDQotLS0NCiBhcmNoL2FybS9jb25maWdzL2lteF92Nl92N19k
ZWZjb25maWcgfCAxICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAt
LWdpdCBhL2FyY2gvYXJtL2NvbmZpZ3MvaW14X3Y2X3Y3X2RlZmNvbmZpZyBiL2FyY2gvYXJtL2Nv
bmZpZ3MvaW14X3Y2X3Y3X2RlZmNvbmZpZw0KaW5kZXggZWEzODdjYi4uY2VlN2M2MSAxMDA2NDQN
Ci0tLSBhL2FyY2gvYXJtL2NvbmZpZ3MvaW14X3Y2X3Y3X2RlZmNvbmZpZw0KKysrIGIvYXJjaC9h
cm0vY29uZmlncy9pbXhfdjZfdjdfZGVmY29uZmlnDQpAQCAtNDAyLDYgKzQwMiw3IEBAIENPTkZJ
R19NUEwzMTE1PXkNCiBDT05GSUdfUFdNPXkNCiBDT05GSUdfUFdNX0ZTTF9GVE09eQ0KIENPTkZJ
R19QV01fSU1YMjc9eQ0KK0NPTkZJR19QV01fSU1YX1RQTT15DQogQ09ORklHX05WTUVNX0lNWF9P
Q09UUD15DQogQ09ORklHX05WTUVNX1ZGNjEwX09DT1RQPXkNCiBDT05GSUdfVEVFPXkNCi0tIA0K
Mi43LjQNCg0K
