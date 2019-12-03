Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 652AA10F7A2
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Dec 2019 07:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfLCGEb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Dec 2019 01:04:31 -0500
Received: from mail-eopbgr10045.outbound.protection.outlook.com ([40.107.1.45]:42113
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726521AbfLCGEb (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 3 Dec 2019 01:04:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLT2inD7xdNrHWZf6g3erpw5i8iNwgf2Bdp9TdtulpLTFHPLXPcO8P+8t7l4/PBIhyzm/jEtKTGel690ypiN8XX8KfaAMXPgq6JY/E4gPmXaLXOnOzmIJlOki4qN8faE/ltiJR2tlFdn+T8MW8j5hYhe9WRNaMOCzzWvF84U7tDy2c/MiW7H8mABOEgejMNQc5PMNzLpM599r8SB96zwipMqRHqSi7sbZg+z8URqlAiYqIYylRd08kRcchjHG4UdWf+d7Gt/TECQV3Si5kO/LEEV+2aJbdofkIt/rSI+eYKMHpupdABXLA9BLQfNgTtTs/g0O4zu4xxu7bc5jwTOUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUduKPc7gDVG3wwztu07UiUSTOzq4i8hAbySFMKdy9A=;
 b=OUBhVwDSyZZsbpgGfKBCc8D5aMMejkJX88WQJb0mrJ5YWK9v4hjcLkJjxjzXAO00+bGr77limu8ds6GQa0oi7IBuiGdj3n7GzJ/WwssdDzM+gjtHJjULT4L5ZRkKkikCzMOys0K6M3YJ40R3y4eBBE5CMUX03YKOyvm8fDPvLLghj/zMeqlqkkMo1vjsKSH7+ozmIGl0T/K8cIrOKge8P5JkkAaQXfgHq4C0Vszs4jq2Aic7UZIZc+WrwnuRRVW5S9xg6JGX5v8iKBFxIiEdJba6PfpuwpKPPx+7u0ZEuI66Eh3g9bFjTkHfXDD/3ZbdHQWbBiYihrT/QEQK5377UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUduKPc7gDVG3wwztu07UiUSTOzq4i8hAbySFMKdy9A=;
 b=IWaRWtlTqxJeNOm/IofemwtEk87yHfpRbCEwzqbHnb4EqQABijQJqdctaD7k2RTFtF6u6Qr+Vn/d4ppRvXDDPT5KmDmZ9q6cOiFLy4ITxLrWmHTsyjkOe2xXVbPxCfjwY82ZDyJ6whSSKBpzYQlzELhHFxx1FYUsseLN6CP/aHY=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6993.eurprd04.prod.outlook.com (52.132.212.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Tue, 3 Dec 2019 06:04:27 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 06:04:27 +0000
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
        Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] gpio: bcm-kona: use platform_irq_count
Thread-Topic: [PATCH 2/2] gpio: bcm-kona: use platform_irq_count
Thread-Index: AQHVqZ+EtDMj9Zrebkmeuofu5PHegQ==
Date:   Tue, 3 Dec 2019 06:04:27 +0000
Message-ID: <1575352925-17271-2-git-send-email-peng.fan@nxp.com>
References: <1575352925-17271-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1575352925-17271-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::13) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7ccf880d-c762-48f9-2889-08d777b6a735
x-ms-traffictypediagnostic: AM0PR04MB6993:|AM0PR04MB6993:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6993563F0F8A1DB27D58085888420@AM0PR04MB6993.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(199004)(189003)(102836004)(305945005)(7736002)(71200400001)(81156014)(81166006)(8676002)(71190400001)(86362001)(50226002)(5660300002)(66556008)(2201001)(446003)(66946007)(66476007)(64756008)(66446008)(6486002)(8936002)(66066001)(2501003)(2616005)(36756003)(44832011)(256004)(186003)(6436002)(7416002)(478600001)(76176011)(14454004)(6116002)(4326008)(54906003)(3846002)(110136005)(316002)(25786009)(26005)(2906002)(386003)(6506007)(99286004)(52116002)(6512007)(11346002)(4744005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6993;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tRkslL+qopJ2AYPDZlhb22xpPXcIoO6gQ5hY+BfHbZrnMTsRWYm3L5Ev1+vCJWpjex9asBGx1rSFSLZM4hNjkFBciElry1e5OGbW7xiKB4kgcju0T6c+/3cPmQT1hfXqdHjbx0B9uM4gbOPIs1ZJlzPNuRbliknK108QsCoDVQjAbaBbahL0Oo4jhHnEfD/GBWGjNtefUBHjzbRWMgYMGpla9FSn8sV811VRxPw2Q+LLQHGQmvuihtVNzvdKYDx0arV1pF5hJLkgqOTeuiNEuQn5Q0Rr1xbxTPvCgISm6YDSuorbcoT3iHKER4MioebylYQsvUznXJEBa8qpwtWdeRZHeFwhmLVkIIBGCnVH/ZlGu0hAOeO/3MQGEB+YgWuv7gmU74l7t1YoVw63vLLaBx0KeZCG/31MftuxL+xH6MSOtJFmBsWyORSR1q8uMPMM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ccf880d-c762-48f9-2889-08d777b6a735
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 06:04:27.2894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tBxG6WG05J5MlN/IRznTOcb8FNxoUyqYJW6N7BptsU7z1OyjxVMb/H7mM394ulPhG7BNfhh8o/FN3O0b2ZPL+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6993
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Use platform_irq_count to replace of_irq_count

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 Code inspection, not tested

 drivers/gpio/gpio-bcm-kona.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
index 4122683eb1f9..c50721980a7c 100644
--- a/drivers/gpio/gpio-bcm-kona.c
+++ b/drivers/gpio/gpio-bcm-kona.c
@@ -19,7 +19,6 @@
 #include <linux/io.h>
 #include <linux/gpio/driver.h>
 #include <linux/of_device.h>
-#include <linux/of_irq.h>
 #include <linux/init.h>
 #include <linux/irqdomain.h>
 #include <linux/irqchip/chained_irq.h>
@@ -586,7 +585,7 @@ static int bcm_kona_gpio_probe(struct platform_device *=
pdev)
=20
 	kona_gpio->gpio_chip =3D template_chip;
 	chip =3D &kona_gpio->gpio_chip;
-	kona_gpio->num_bank =3D of_irq_count(dev->of_node);
+	kona_gpio->num_bank =3D platform_irq_count(pdev);
 	if (kona_gpio->num_bank =3D=3D 0) {
 		dev_err(dev, "Couldn't determine # GPIO banks\n");
 		return -ENOENT;
--=20
2.16.4

