Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5019810F79F
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Dec 2019 07:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfLCGE0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Dec 2019 01:04:26 -0500
Received: from mail-eopbgr140081.outbound.protection.outlook.com ([40.107.14.81]:15454
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726521AbfLCGE0 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 3 Dec 2019 01:04:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdyazBItDTBW8xFeZuo3AV0TCDUD+2aRb0Qci/nH85agMmm3a5nbEKGo4LYmtvoMknbb9EPBTT07jsWu3+40iyivdQ9KSGyAyvii8kik8VPHD2jIEzsse76pvygP5B/fFONwRJ4ISk65tQqYkeGrukGnprBHS8pGigET3j/1Mj08dt9x9tcC1EYzi9rpPTJrqsLJzz3eJBtm7Tb43HQ6p7DzTUm/R7oBQ5t6BmIjdsuKNsz2C0b4fbD2bFoORbit8RQ2kzbd20E2YUNNj8xPvY/3UnOt9pcDXTkkDVqRMS7hX+ZgMGaETjaU1bhK2Gbv6NZK4pJ3T7LaGqHjoxxtHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AJvhOrjWXY8Cde7pIWJ6/TqHSbVnmBTAaREaIxIzYw=;
 b=X6MqI1Gz0xg9LFIg6RtXlturhk8jjdF95JUaz9uRNdbRhkR6gdkpMxkO5wo/KHu5ETYK/DuHfDY88XyohoTAI5e1D0LrI5CkvXhzOFMRIpsetA8bAiQlxvL/zlWdUNM2lx26BoHmwvXW15rMgtzRhJAbDhRpIQY69fERjxiLPvxZt2hLpnt7OHGB/tTd13zlDOAEnGDFcTSpbqZFX+HD2YjjcSm06BaxL4prMKNnMOHwJBkXvL7VY5aA/1KTAYHqmDNIWIljV+I2ZoZ9UvEaZTVIwrbiGfGVDzfmU9hfRwC1KTHI0HZliiopvCqQ0TY9IBe6QPHSbYB//raRcVUnXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AJvhOrjWXY8Cde7pIWJ6/TqHSbVnmBTAaREaIxIzYw=;
 b=e8ncpEu3oY1EsgRbFKL9t/HTz++JBz5X2QN4bCFs8H9WPXTE3xg/fcUzGCLtL0yZLndJDnyB4l+c5hJRyWB718vlQaP8yH7H5b3nb82yIzjCK4If9Yuh+vzcDhhX9I5rPx/mPPa4LYe8Pzcft3LLQBcKFoBPCGi9mQY/z0pa7OQ=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6993.eurprd04.prod.outlook.com (52.132.212.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Tue, 3 Dec 2019 06:04:22 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 06:04:22 +0000
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
Subject: [PATCH 1/2] gpio: mvebu: use platform_irq_count
Thread-Topic: [PATCH 1/2] gpio: mvebu: use platform_irq_count
Thread-Index: AQHVqZ+C2ZbmEZTAyUWwsa6EK7twoQ==
Date:   Tue, 3 Dec 2019 06:04:22 +0000
Message-ID: <1575352925-17271-1-git-send-email-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: d74b764c-9a04-4a83-cd5a-08d777b6a455
x-ms-traffictypediagnostic: AM0PR04MB6993:|AM0PR04MB6993:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6993B5D3BD90B83B70763C6F88420@AM0PR04MB6993.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(199004)(189003)(102836004)(305945005)(7736002)(71200400001)(81156014)(81166006)(8676002)(71190400001)(86362001)(50226002)(5660300002)(66556008)(2201001)(66946007)(66476007)(64756008)(66446008)(6486002)(8936002)(66066001)(2501003)(2616005)(36756003)(44832011)(256004)(186003)(6436002)(7416002)(478600001)(14454004)(6116002)(4326008)(54906003)(3846002)(110136005)(316002)(25786009)(26005)(2906002)(386003)(6506007)(99286004)(52116002)(6512007)(4744005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6993;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qaf5J2slBfkgniPKk0Id/IOwwaLJgaQ/Bd51b2rCfVbnNwgIFRTu3rXlp9FkQTHJg8911WJ8r4lTMjNTBRgUneJxr2ioYaW3Pyt4tEuf21Hru/H41kteBEC6baaPBrRjYLxJkjRrKaDKwJRLMiLG5BwxvQSTbe/FYWeVgM+8f+KuOoBQNVhRd9+iN7lOzZEbTgoAAhAW1RKRsYLERZCW6SCdWHHx4I7cQ08Cz0g7+vaft9NtQEdm/WFslaAxmFgTHZs3ROgpw1RT87P++DH+6VOguOjv+RFDJN3L3wpkKfKI3sXu1wCb9wqgVEeHNUF9ZjYNldbn4B3gMMkXmjXWI6p960PSI7vVLo+fPzHHOhhhKc458dc9rAuewjm9G/z8g9RcIOC1She6ofTATW2s7+N9elnKSsRQVoy/8eQPY3YVD6OGG+2VUrx5s3AOPi6Q
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74b764c-9a04-4a83-cd5a-08d777b6a455
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 06:04:22.5052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UZIQn9dnu93xfFk/PMh1yrtYJMGSeklSeuxSRR3kGMH1/IEof8aZKYCtzE8wmPAtkc5FEZGAmHWi3IX0FS+T9w==
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

 drivers/gpio/gpio-mvebu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 993bbeb3c006..ecfedcdadc0d 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -46,7 +46,6 @@
 #include <linux/irqdomain.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of_device.h>
-#include <linux/of_irq.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
@@ -1102,7 +1101,7 @@ static int mvebu_gpio_probe(struct platform_device *p=
dev)
 		soc_variant =3D MVEBU_GPIO_SOC_VARIANT_ORION;
=20
 	/* Some gpio controllers do not provide irq support */
-	have_irqs =3D of_irq_count(np) !=3D 0;
+	have_irqs =3D platform_irq_count(pdev) !=3D 0;
=20
 	mvchip =3D devm_kzalloc(&pdev->dev, sizeof(struct mvebu_gpio_chip),
 			      GFP_KERNEL);
--=20
2.16.4

