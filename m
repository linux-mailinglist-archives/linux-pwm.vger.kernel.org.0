Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 493B718A9C
	for <lists+linux-pwm@lfdr.de>; Thu,  9 May 2019 15:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfEIN3S (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 May 2019 09:29:18 -0400
Received: from mail-eopbgr50046.outbound.protection.outlook.com ([40.107.5.46]:6909
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbfEIN3S (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 9 May 2019 09:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9S/xOMjnk7ZKf6QCTutMbkGfiUHY8BuESlUdrIGZTKI=;
 b=EPvy0e4/fm14j4Tpz3qn7SCmqUGwqU7qK66cBUq8ITk+fsWZx4IBj6uBO16G+FBSbGZjLeZLbHJBBAA5++Ivu9FSA25PVOWlvynxr/xSpkqQP5nkKCPkqb/W/fzc47t8nchpn8FXaELQ+fDCu7zSf8vZxoZ89DSMMUDqPjGgAnk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3673.eurprd04.prod.outlook.com (52.134.70.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Thu, 9 May 2019 13:29:13 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1878.022; Thu, 9 May 2019
 13:29:13 +0000
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
Subject: [PATCH V12 0/5] Add i.MX7ULP EVK PWM backlight support
Thread-Topic: [PATCH V12 0/5] Add i.MX7ULP EVK PWM backlight support
Thread-Index: AQHVBmsxwh623BuViUe0ncJayF5mqA==
Date:   Thu, 9 May 2019 13:29:13 +0000
Message-ID: <1557408252-21281-1-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: c91750da-671e-4c49-c625-08d6d482535c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3673;
x-ms-traffictypediagnostic: DB3PR0402MB3673:
x-microsoft-antispam-prvs: <DB3PR0402MB3673F1E53FDF78B2965C9521F5330@DB3PR0402MB3673.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39860400002)(346002)(366004)(199004)(189003)(7416002)(6512007)(86362001)(2201001)(6486002)(305945005)(66556008)(66946007)(73956011)(66476007)(64756008)(7736002)(66446008)(316002)(99286004)(2906002)(186003)(6436002)(26005)(53936002)(102836004)(66066001)(50226002)(4326008)(36756003)(52116002)(81156014)(386003)(6506007)(2501003)(8936002)(71200400001)(14454004)(81166006)(8676002)(71190400001)(68736007)(110136005)(5660300002)(4744005)(3846002)(256004)(478600001)(486006)(476003)(25786009)(6116002)(2616005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3673;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rhzY5pnIcTDmWHgrIguqEqaa/CMXTWnFLqnAiv2VbP5ykAhy83ka5GS5HLCUJYtgsbol7Dy5dEpwhFULm/eVxwYr6cr9vvDJW56QJk2iE5d49qIcRu2nqK/Vjpetz9MihF6OPhED2PqHp+6ueUJTsGTmIvVBlHLrcKGei+mmgl7KLAg1PGa0mW6wEw8+dB/h9v2Bat93NGmdIT3P3DyjyppeLCkzd5Isy2fDgTYYlqW60tSSo4nipOy2y4nJURhsHSep/zoxNhggSu5fUjOy0FYo9YDvuXu+Ka1kin9EeMNpZYULeqLA/TLCzWlnaA2Gljq2O1d+VhJdwRwbMwTih4oobdO+V+DWCuZqVtvwGwVNUOdfFAZ5ugR4HQibuDsEKBbBApzFdNVcLr08p0OruesB/p6anYD7qNZYOmnr/Ng=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BFDBDD87FCB2A4DBC40095AB7F40CD8@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c91750da-671e-4c49-c625-08d6d482535c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 13:29:13.4553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3673
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

aS5NWDdVTFAgRVZLIGJvYXJkIGhhcyBNSVBJLURTSSBkaXNwbGF5LCBpdHMgYmFja2xpZ2h0IGlz
IHN1cHBsaWVkIGJ5DQpUUE0gUFdNIG1vZHVsZSwgdGhpcyBwYXRjaCBzZXQgZW5hYmxlcyBpLk1Y
N1VMUCBUUE0gUFdNIGRyaXZlciBzdXBwb3J0DQphbmQgYWxzbyBhZGQgYmFja2xpZ2h0IHN1cHBv
cnQgZm9yIE1JUEktRFNJIGRpc3BsYXkuDQoNCkNoYW5nZXMgc2luY2UgVjExOg0KCS0gT05MWSBh
ZGQgYSBmdW5jdGlvbiBjb21tZW50IGluIGRyaXZlcnMvcHdtL3B3bS1pbXgtdHBtLmMNCg0KQW5z
b24gSHVhbmcgKDUpOg0KICBkdC1iaW5kaW5nczogcHdtOiBBZGQgaS5NWCBUUE0gUFdNIGJpbmRp
bmcNCiAgcHdtOiBBZGQgaS5NWCBUUE0gUFdNIGRyaXZlciBzdXBwb3J0DQogIEFSTTogaW14X3Y2
X3Y3X2RlZmNvbmZpZzogQWRkIFRQTSBQV00gc3VwcG9ydCBieSBkZWZhdWx0DQogIEFSTTogZHRz
OiBpbXg3dWxwOiBBZGQgdHBtIHB3bSBzdXBwb3J0DQogIEFSTTogZHRzOiBpbXg3dWxwLWV2azog
QWRkIGJhY2tsaWdodCBzdXBwb3J0DQoNCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vaW14
LXRwbS1wd20udHh0ICAgICAgICB8ICAyMiArDQogYXJjaC9hcm0vYm9vdC9kdHMvaW14N3VscC1l
dmsuZHRzICAgICAgICAgICAgICAgICAgfCAgMjAgKw0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDd1
bHAuZHRzaSAgICAgICAgICAgICAgICAgICAgIHwgIDEwICsNCiBhcmNoL2FybS9jb25maWdzL2lt
eF92Nl92N19kZWZjb25maWcgICAgICAgICAgICAgICB8ICAgMSArDQogZHJpdmVycy9wd20vS2Nv
bmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTEgKw0KIGRyaXZlcnMvcHdt
L01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCiBkcml2ZXJz
L3B3bS9wd20taW14LXRwbS5jICAgICAgICAgICAgICAgICAgICAgICAgICB8IDQ0OCArKysrKysr
KysrKysrKysrKysrKysNCiA3IGZpbGVzIGNoYW5nZWQsIDUxMyBpbnNlcnRpb25zKCspDQogY3Jl
YXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vaW14
LXRwbS1wd20udHh0DQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcHdtL3B3bS1pbXgtdHBt
LmMNCg0KLS0gDQoyLjcuNA0KDQo=
