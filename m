Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3A7311220A
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Dec 2019 05:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfLDEUt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Dec 2019 23:20:49 -0500
Received: from mail-eopbgr150074.outbound.protection.outlook.com ([40.107.15.74]:53094
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726804AbfLDEUs (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 3 Dec 2019 23:20:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRflIoqp0YSpJ7bWOkEMS1zcSvGA6ZXt1cCmVuBDjjizWH37fPCDfa5TrTG/t79XUZheyfQk2/5IKvaq5R1Lon/2O38ZiyLoRlc0/1fF6iYWhdxeWP0P7fkLDwEj//x4PuNO10fpQd82xEmaTRiywoZByyDCgKfUq8MPGjyM6zzjEhme4373vRkqi/3DnxuHNTIhcsuZj2r6RzZwS19bjP9L+XxYtgmBgIIAu0mkrQ/wtjUttJEp3lFMVV9UMAqpxyTkHngcUW0W8CqTwOi39z/FcWZMaWrZKkuPU3HXWHV2gKuQ9ny7RcFoHbd09bShnRjN6jDerFDcttuYohHSYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4T+hAvNkey+ix0CGSWBNEqRk2Q9d3lqzZ+Vr+Qu9wo4=;
 b=dB2po0ehtroeuguCEE0mC6Rh2wHu2gzrhsEAgp129ivVQxkBp5rAykk/b7mp5i4G068UKZ7hP4UabeUnofx1VO1Rwc0Prj25hcaQNlUhEgWbbgcjs2aPb7g/CDluLoZ/lvcJopoAXhkOBG+MGiZncpfzzn+6SJtArCwZj3L0Zr1ssA9g6IWzilWcO5zdmMTRa9DpYWO9b4kh0JHMoL2fKEamzt02CoFWd06iuKD+FGuMD7LdiY9a/8u0C5LT5wIRO8c5grN+a9RGKowLJV2lWUXeTOJ6ms3KbHQJZuZ260zeVqSMsusntfmSv3yuQx+k4pBaQ8Db6PI42+6QJlQLrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4T+hAvNkey+ix0CGSWBNEqRk2Q9d3lqzZ+Vr+Qu9wo4=;
 b=Yer5ofDYTc1/sdCY4pAzsBYm8ApMMMRZMLGEJUgezQ02DQNM9hEupbbOHhzZK3stmbrTWtwY7CTDWGBzg8JO3mbsaRzpmnvGSFXR2r+XKEa35QI9nnyIJnyG67I6K+w4GN7bqGp+Azf96c4oSyfhbudEZ0wDkD6tfUIVajAcndY=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6210.eurprd04.prod.outlook.com (20.179.33.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Wed, 4 Dec 2019 04:20:46 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 04:20:46 +0000
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
Subject: [PATCH v2 2/2] gpio: bcm-kona: use platform_irq_count
Thread-Topic: [PATCH v2 2/2] gpio: bcm-kona: use platform_irq_count
Thread-Index: AQHVqlozVqivwz8NTU6lWRKFCpUzKA==
Date:   Wed, 4 Dec 2019 04:20:45 +0000
Message-ID: <1575433106-16171-2-git-send-email-peng.fan@nxp.com>
References: <1575433106-16171-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1575433106-16171-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2P15301CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::34) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d784b034-23d0-43ee-836a-08d778715588
x-ms-traffictypediagnostic: AM0PR04MB6210:|AM0PR04MB6210:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6210FA861FE1EB7A2ADBF265885D0@AM0PR04MB6210.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:196;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(189003)(199004)(99286004)(2906002)(5660300002)(25786009)(54906003)(110136005)(316002)(3846002)(66946007)(66476007)(6116002)(4326008)(6486002)(64756008)(66446008)(66556008)(6512007)(2501003)(6436002)(14444005)(256004)(50226002)(305945005)(71200400001)(71190400001)(81156014)(7416002)(8676002)(8936002)(446003)(81166006)(7736002)(102836004)(36756003)(14454004)(52116002)(478600001)(386003)(6506007)(86362001)(11346002)(76176011)(2616005)(44832011)(186003)(26005)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6210;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jhYshgDHaG4tU6QHB4TvRC2gAe1t31oNWqtIll/yQEd9CYq5vy0tilCAotMnxfbsChfntM6hmNi7Np5UvvQqZjjpwHTEBJo0BjvMs1ixWr3cZ2Xiv7D0ALpOlb4fv1B15wgoDW9YxV2ilU+SxyXW7Qgx7Ey2GAM7iRtZ4LlZGuqy30m9onWT+XiBkY4kvH/44CdADl4/AAWqJqMeRaNhotazQg/mz/c3R5gLVEkX0GM91iCEOeO18S9G850Dy/0wsccss+yiyStiVrSBwW7scvjgwHOmAIBSGuDPDnQwgkjIrsH+XoeSo3qZ68QNib54NHP6iBD1zx01HNqx9wJLnPUAHj3BdQ04+pEaOEyFBX4TSQHKSfa6TjmWcEB/RihcobqDzCugdF39G6d6H4U5KgAT/ZYxBqeXUmxX2vPcMfA3f3QqNv7C0Uo6naG2Bzdw
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d784b034-23d0-43ee-836a-08d778715588
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 04:20:45.9960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wavSzesxCOZa6u9zhLsM+rg8JTqOg0lR4RJw83rBMNy3GDYqIqQP1A0xQnCbrds7U03PrxkQNyDjx/xXOY5VDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6210
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

platform_irq_count() is the more generic way (independent of
device trees) to determine the count of available interrupts. So
use this instead.

As platform_irq_count() might return an error code (which
of_irq_count doesn't) some additional handling is necessary.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Update commit log, and add err handling
 Not tested, just code inspection

 drivers/gpio/gpio-bcm-kona.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
index 4122683eb1f9..52ff56166263 100644
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
@@ -586,11 +585,18 @@ static int bcm_kona_gpio_probe(struct platform_device=
 *pdev)
=20
 	kona_gpio->gpio_chip =3D template_chip;
 	chip =3D &kona_gpio->gpio_chip;
-	kona_gpio->num_bank =3D of_irq_count(dev->of_node);
-	if (kona_gpio->num_bank =3D=3D 0) {
+	ret =3D platform_irq_count(pdev);
+	if (!ret) {
 		dev_err(dev, "Couldn't determine # GPIO banks\n");
 		return -ENOENT;
+	} else if (ret < 0) {
+		if (ret !=3D -EPROBE_DEFER)
+			dev_err(dev, "Couldn't determine GPIO banks: %d\n",
+				ret);
+		return ret;
 	}
+	kona_gpio->num_bank =3D ret;
+
 	if (kona_gpio->num_bank > GPIO_MAX_BANK_NUM) {
 		dev_err(dev, "Too many GPIO banks configured (max=3D%d)\n",
 			GPIO_MAX_BANK_NUM);
--=20
2.16.4

