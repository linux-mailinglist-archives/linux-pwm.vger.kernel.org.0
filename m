Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F242418AA2
	for <lists+linux-pwm@lfdr.de>; Thu,  9 May 2019 15:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfEIN30 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 May 2019 09:29:26 -0400
Received: from mail-eopbgr10043.outbound.protection.outlook.com ([40.107.1.43]:1620
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbfEIN3Z (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 9 May 2019 09:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMyZSRZWP9Hc0YpaV+W80epMlNnE3Yn644AfS+cx86o=;
 b=f/JFlPyS58l0q8JOcqP5w7tl1zLkgBcxGyQ6nd52Ds0s5CfFBKtvdJzUbsSgwMV0IVCPeMBtKm063h8lgNhWgfAkZbHp8h2bR6S69VvDp1jiLLFrCWorSzICsohOeq6bVzdEmbZYPfonucDXik1NI/dDa5MqI5aB47s2EN1tf2I=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3673.eurprd04.prod.outlook.com (52.134.70.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Thu, 9 May 2019 13:29:19 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1878.022; Thu, 9 May 2019
 13:29:19 +0000
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
Subject: [PATCH V12 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Thread-Topic: [PATCH V12 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Thread-Index: AQHVBms0dpnXU0ejkkq6UgSdEVVQow==
Date:   Thu, 9 May 2019 13:29:19 +0000
Message-ID: <1557408252-21281-2-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: f43042c2-aeed-413b-300f-08d6d482570f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3673;
x-ms-traffictypediagnostic: DB3PR0402MB3673:
x-microsoft-antispam-prvs: <DB3PR0402MB367361749219F4D72DD97629F5330@DB3PR0402MB3673.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39860400002)(346002)(366004)(199004)(189003)(7416002)(6512007)(86362001)(2201001)(6486002)(305945005)(66556008)(66946007)(73956011)(66476007)(64756008)(7736002)(66446008)(316002)(99286004)(2906002)(186003)(6436002)(26005)(53936002)(102836004)(66066001)(50226002)(4326008)(76176011)(36756003)(52116002)(81156014)(386003)(6506007)(2501003)(8936002)(71200400001)(14454004)(81166006)(8676002)(71190400001)(68736007)(110136005)(5660300002)(3846002)(11346002)(446003)(256004)(478600001)(486006)(476003)(25786009)(6116002)(2616005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3673;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ghvkvIUxi5m0LqEzCIjIdZWp/QsmwJNlBdAdqlPkwHA3JhCYNXo9nu6FJZWAAWMneowirbhSAEHNAgGxJIHE04NbzEZetgHBhUYNH1aAEwxJupA+hrNE9s99/NKFqAo05CqOG+S5t8JwF5yEQpgiVcjYD3xDeG+01K7NGEowG7UPRd7UW5eOqKySpnk+8yIsmMU3FnfeXmUhq2r33uzYzVwCE67hZlQaopco7DwQ2Xi0fRE6FVJnMAIKmFheDupeJYIoPULuvk5/jwcgoLK+JZbl6vbiRn9xM8eRqeL3MjSbJ6/mN7AMjwNDdTQ+u2Fq+VtI0miamSKWv0C5fG0maq+f2hq6QwtGolCkjekphhJOUnbQ9mfME9lo03DryeLeCgfYUU+j9Zdkt8oQ50F/JqYUZs170+GH0HV4JARbd/U=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f43042c2-aeed-413b-300f-08d6d482570f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 13:29:19.4836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3673
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

QWRkIGkuTVggVFBNKExvdyBQb3dlciBUaW1lci9QdWxzZSBXaWR0aCBNb2R1bGF0aW9uIE1vZHVs
ZSkgUFdNIGJpbmRpbmcuDQoNClNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFu
Z0BueHAuY29tPg0KUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQot
LS0NCk5vIGNoYW5nZS4NCi0tLQ0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9pbXgtdHBt
LXB3bS50eHQgICAgICAgIHwgMjIgKysrKysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFu
Z2VkLCAyMiBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vaW14LXRwbS1wd20udHh0DQoNCmRpZmYgLS1naXQgYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2lteC10cG0tcHdtLnR4dCBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vaW14LXRwbS1wd20udHh0DQpuZXcg
ZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMC4uM2JhOTU4ZA0KLS0tIC9kZXYvbnVsbA0K
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9pbXgtdHBtLXB3bS50
eHQNCkBAIC0wLDAgKzEsMjIgQEANCitGcmVlc2NhbGUgaS5NWCBUUE0gUFdNIGNvbnRyb2xsZXIN
CisNCitSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KKy0gY29tcGF0aWJsZSA6IFNob3VsZCBiZSAiZnNs
LGlteDd1bHAtcHdtIi4NCistIHJlZzogUGh5c2ljYWwgYmFzZSBhZGRyZXNzIGFuZCBsZW5ndGgg
b2YgdGhlIGNvbnRyb2xsZXIncyByZWdpc3RlcnMuDQorLSAjcHdtLWNlbGxzOiBTaG91bGQgYmUg
My4gU2VlIHB3bS50eHQgaW4gdGhpcyBkaXJlY3RvcnkgZm9yIGEgZGVzY3JpcHRpb24gb2YgdGhl
IGNlbGxzIGZvcm1hdC4NCistIGNsb2NrcyA6IFRoZSBjbG9jayBwcm92aWRlZCBieSB0aGUgU29D
IHRvIGRyaXZlIHRoZSBQV00uDQorLSBpbnRlcnJ1cHRzOiBUaGUgaW50ZXJydXB0IGZvciB0aGUg
UFdNIGNvbnRyb2xsZXIuDQorDQorTm90ZTogVGhlIFRQTSBjb3VudGVyIGFuZCBwZXJpb2QgY291
bnRlciBhcmUgc2hhcmVkIGJldHdlZW4gbXVsdGlwbGUgY2hhbm5lbHMsIHNvIGFsbCBjaGFubmVs
cw0KK3Nob3VsZCB1c2Ugc2FtZSBwZXJpb2Qgc2V0dGluZy4NCisNCitFeGFtcGxlOg0KKw0KK3Rw
bTQ6IHB3bUA0MDI1MDAwMCB7DQorCWNvbXBhdGlibGUgPSAiZnNsLGlteDd1bHAtcHdtIjsNCisJ
cmVnID0gPDB4NDAyNTAwMDAgMHgxMDAwPjsNCisJYXNzaWduZWQtY2xvY2tzID0gPCZwY2MyIElN
WDdVTFBfQ0xLX0xQVFBNND47DQorCWFzc2lnbmVkLWNsb2NrLXBhcmVudHMgPSA8JnNjZzEgSU1Y
N1VMUF9DTEtfU09TQ19CVVNfQ0xLPjsNCisJY2xvY2tzID0gPCZwY2MyIElNWDdVTFBfQ0xLX0xQ
VFBNND47DQorCSNwd20tY2VsbHMgPSA8Mz47DQorfTsNCi0tIA0KMi43LjQNCg0K
