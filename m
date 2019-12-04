Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6F66112724
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Dec 2019 10:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfLDJYj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Dec 2019 04:24:39 -0500
Received: from mail-eopbgr50074.outbound.protection.outlook.com ([40.107.5.74]:2354
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725922AbfLDJYj (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 4 Dec 2019 04:24:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLCkORnw3wfAY39IIFl5K92sOxN0OthgFb8fMPH3tFnevY9URfP0gjEWxCZ+QUpVjTiuMDInHeL/oH0XYWPxjEk+4fGW5PaQTLrCmrwCRDXu4QkLqekKUj7Kt2x5PFV7FiNAJCD4F1GGvFFRWHadWVnZA+MA1F8wq4LfJBF3WRlTj64Df27bQRnatsgoIzJcVbtB5ejJrxzimq2nkrMJmumbuQQM13tSKMbeCLv1FvsiiWoVN0qa+QTwi4vPCDRjKY6upMXvAQVmeALfpDWLJTM0FFAQnVPmlVKhdLttDVwgucRh2+IM7WtuX0N4fWy1+eCzh0QTTZ34/rMy+fgV0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWtC2nXLlM3gbHrtMYMIsU0P90rPCLA9RvOC271f0R4=;
 b=FBbD9zVRe5nxfxtKzvESrxaIpNUItVhnzpLyQ2uDvNBDk33xxmQroMVQfN7gY0SqWzunIM2n5g2zkcjisEaIVq/qKirbngEBgzHtWzLD717eADDpDYZr3qkwVt4QZpdIsfBshBwfoIPd7w0RpdoBaNcWevLM4YjgbTWU1b49oZh0s8fuCYmDvsKbZCrKrqxI542sbCXtbDFxf/5tzOjme2P5edfg5QOjfoU53ZSkh8wgbjBgmgyWHpHQyVTa4fOa/XFIOmnUKnxr4GvJtTwS7vYFk/hOMzYoKmraV37MP4Ql8Xrbv5TGuQUavga1woIx/HjPKRcJmHsLLvklEWxKkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWtC2nXLlM3gbHrtMYMIsU0P90rPCLA9RvOC271f0R4=;
 b=GNIoMjSsOqz754A2LYyZHL5nD8+QhZ+gjQYBio0kqeKg4sV6iRuKup2R+tZIQ34ylIx1Q2BAwNMIomlW65Qj1/CtKFU71RVoMcwupMJSn8WoegmRADLo2ubiWXphIT9lw0z0BR9Nev86LRRv1fcPIyvkUBe/DvGVH3/uJDBJ2pk=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5812.eurprd04.prod.outlook.com (20.178.119.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Wed, 4 Dec 2019 09:24:35 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 09:24:35 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "rjui@broadcom.com" <rjui@broadcom.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>
CC:     "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3 1/2] gpio: mvebu: use platform_irq_count
Thread-Topic: [PATCH v3 1/2] gpio: mvebu: use platform_irq_count
Thread-Index: AQHVqoSkBJcTHD8ix06RBDAwXsOZyQ==
Date:   Wed, 4 Dec 2019 09:24:35 +0000
Message-ID: <1575451330-11112-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0060.apcprd03.prod.outlook.com
 (2603:1096:202:17::30) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aa00214c-eacd-4496-5cc9-08d7789bc6f8
x-ms-traffictypediagnostic: AM0PR04MB5812:|AM0PR04MB5812:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB58121F69A80ED19B56C7DE1A885D0@AM0PR04MB5812.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:132;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(189003)(199004)(110136005)(14444005)(316002)(2501003)(305945005)(7736002)(50226002)(8676002)(81156014)(81166006)(8936002)(86362001)(2906002)(3846002)(7416002)(6116002)(54906003)(4326008)(6512007)(2201001)(25786009)(52116002)(478600001)(6486002)(5660300002)(6436002)(44832011)(2616005)(102836004)(26005)(6506007)(386003)(186003)(66574012)(71200400001)(66446008)(66476007)(66556008)(64756008)(66946007)(99286004)(71190400001)(36756003)(256004)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5812;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y8nsuZdeStsFsUSYn0+DJYRrZGszenMKK/4YqkG4741KetRx6nYJqL8+4VvAoG8VTCfJP/txt2iUgQRzl03d6X5olfMCJMQiqAzoUL6PKOvk7a+4wxVmYJ/DA+fIkLwYXafxIguZurBZLmgwqlKuwJCPVGI+9EHkkPQPm2lC3ehAbg1321MDqpc+RB2fCQmzoAJoUdIJI3UGJbTrW7gFlSSTcPmzAxxlCdsRsERZk18yMcefMVISUfrBis+3oO5NEBkn+0zYFpAaNBVbN+aofA6Sd4krEqCx6WZ7buyyHfP0VgzoYO4tLNcD8h80HzbQ6Lys/xYafcJ8s+Bmat6HWEsLdVvtFRCbpKJhvH5CdR6bZcDQ8wjZYiDvXtmtkJXk0lZIBia3O0QToZ2Lboy023f6TaWVeMEmlp9KBf9/X0gRWK9UWBwpoM0FJ76eT57M
Content-Type: text/plain; charset="utf-8"
Content-ID: <225D19D2BDA71E469714620A2E966AED@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa00214c-eacd-4496-5cc9-08d7789bc6f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 09:24:35.1782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /8bsLxnmeQp6hpfVu1keAo0FvpVB1lUqFtDhxs6JYXMRE33XJ/44vcG3NQsU6BEvgxvLng2EQSLJyeznZdLLTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5812
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

RnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQoNCnBsYXRmb3JtX2lycV9jb3VudCgp
IGlzIHRoZSBtb3JlIGdlbmVyaWMgd2F5IChpbmRlcGVuZGVudCBvZg0KZGV2aWNlIHRyZWVzKSB0
byBkZXRlcm1pbmUgdGhlIGNvdW50IG9mIGF2YWlsYWJsZSBpbnRlcnJ1cHRzLiBTbw0KdXNlIHRo
aXMgaW5zdGVhZC4NCg0KQXMgcGxhdGZvcm1faXJxX2NvdW50KCkgbWlnaHQgcmV0dXJuIGFuIGVy
cm9yIGNvZGUgKHdoaWNoDQpvZl9pcnFfY291bnQgZG9lc24ndCkgc29tZSBhZGRpdGlvbmFsIGhh
bmRsaW5nIGlzIG5lY2Vzc2FyeS4NCg0KUmV2aWV3ZWQtYW5kLUNvbW1pdC1Mb2ctUHJvdmlkZWQt
Ynk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+DQpT
aWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCi0tLQ0KDQpWMzogQWRk
IHRhZw0KDQpWMjoNCiBVcGRhdGUgY29tbWl0IGxvZywgYWRkIGVyciBoYW5kbGluZw0KIE5vdCB0
ZXN0ZWQsIGp1c3QgY29kZSBpbnNwZWN0aW9uDQoNCg0KIGRyaXZlcnMvZ3Bpby9ncGlvLW12ZWJ1
LmMgfCA3ICsrKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncGlvL2dwaW8tbXZlYnUuYyBiL2RyaXZl
cnMvZ3Bpby9ncGlvLW12ZWJ1LmMNCmluZGV4IDk5M2JiZWIzYzAwNi4uZjBmZDgyYjM0MTdjIDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9ncGlvL2dwaW8tbXZlYnUuYw0KKysrIGIvZHJpdmVycy9ncGlv
L2dwaW8tbXZlYnUuYw0KQEAgLTQ2LDcgKzQ2LDYgQEANCiAjaW5jbHVkZSA8bGludXgvaXJxZG9t
YWluLmg+DQogI2luY2x1ZGUgPGxpbnV4L21mZC9zeXNjb24uaD4NCiAjaW5jbHVkZSA8bGludXgv
b2ZfZGV2aWNlLmg+DQotI2luY2x1ZGUgPGxpbnV4L29mX2lycS5oPg0KICNpbmNsdWRlIDxsaW51
eC9waW5jdHJsL2NvbnN1bWVyLmg+DQogI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5o
Pg0KICNpbmNsdWRlIDxsaW51eC9wd20uaD4NCkBAIC0xMTAyLDcgKzExMDEsMTEgQEAgc3RhdGlj
IGludCBtdmVidV9ncGlvX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCQlz
b2NfdmFyaWFudCA9IE1WRUJVX0dQSU9fU09DX1ZBUklBTlRfT1JJT047DQogDQogCS8qIFNvbWUg
Z3BpbyBjb250cm9sbGVycyBkbyBub3QgcHJvdmlkZSBpcnEgc3VwcG9ydCAqLw0KLQloYXZlX2ly
cXMgPSBvZl9pcnFfY291bnQobnApICE9IDA7DQorCWVyciA9IHBsYXRmb3JtX2lycV9jb3VudChw
ZGV2KTsNCisJaWYgKGVyciA8IDApDQorCQlyZXR1cm4gZXJyOw0KKw0KKwloYXZlX2lycXMgPSBl
cnIgIT0gMDsNCiANCiAJbXZjaGlwID0gZGV2bV9remFsbG9jKCZwZGV2LT5kZXYsIHNpemVvZihz
dHJ1Y3QgbXZlYnVfZ3Bpb19jaGlwKSwNCiAJCQkgICAgICBHRlBfS0VSTkVMKTsNCi0tIA0KMi4x
Ni40DQoNCg==
