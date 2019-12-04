Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E81E112209
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Dec 2019 05:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfLDEUp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Dec 2019 23:20:45 -0500
Received: from mail-eopbgr00060.outbound.protection.outlook.com ([40.107.0.60]:40471
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726804AbfLDEUo (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 3 Dec 2019 23:20:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKQJXjI5uMQFbhMRfw2qilb4nwsonJt8t6WmEoD0wkQzv0DG+rEcRigR5kmfMp1JwExe+SsHzdqSdggQh2AphcrZYOE7jOtl8JauYXizqblvDA9qfdYjyTZUT2RjqBq9cjf1ydB1GjNQmeDSF0LpgLnUwXbINVwDBDUoW8um8378jirUX0PrcE9pJF5GfHJ2pqZ8q/EuM3DPSw1TIvdN6nLLMbUEhEN8YFKN+Z1bTKVI1uiZWJQ5iIAbOjivJE53rFDY6gmRBC30dSI8Sa5Ea8ewkCwbBvarhSNrD7quc8qz1TNHkx86O3BzMjXYHV+xe8r1tcBEvpG5Ot8F2ui/XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzkTH+svQqE0tqxjXe103f2sbq7zzei/iIjtSMAOxrc=;
 b=Yn6HHGB7g/CUibMUNpLL2Mdb+GXdaRcKsNVsgQrFAveCP1qzK8T+LZqppzrCAgegfgDFXjpWMDn+8QCP8azTh/ZxJ/CGWziB5nuG69GbHm1zhobaulXAlZCC8CQddqX/ck5BkO+JtX/3aanY+sJpbryRrEJdE0WivG+WxcJWnq+av9nJnWTJIJQs5LvYaH2ufYFQOiS7adTUcRVvMPMb/zyGXyESsZlHYMbHw6aqR4Ry8ESItk+THr5qqUa3LpweKdZvvcjmqxMzN+F0583W5u9orO/jxLonWRP0zEI1L872ColY0UpQFQks6fjdxkI5VW18D+U3q4+G9pH3i+e6mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzkTH+svQqE0tqxjXe103f2sbq7zzei/iIjtSMAOxrc=;
 b=dmNuTER/l0TglfzqIg8ktZPWiqJREb1zM6TFgeyCRto0ddJVRpqX35awokvi9jMTLdqTqd8Tv7q8k+YnZ2w/W9iI8UFEHVL5gHi/obyl5BDLrj+b01/z/nxKWvJTzRw0w0QkUYrpA1UjJtoNk7XV6kLKJWXIm/OFg39qVr/fEJQ=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6210.eurprd04.prod.outlook.com (20.179.33.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Wed, 4 Dec 2019 04:20:41 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 04:20:41 +0000
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
Subject: [PATCH v2 1/2] gpio: mvebu: use platform_irq_count
Thread-Topic: [PATCH v2 1/2] gpio: mvebu: use platform_irq_count
Thread-Index: AQHVqlowWUivP+fqhEySn62hTmdA6Q==
Date:   Wed, 4 Dec 2019 04:20:41 +0000
Message-ID: <1575433106-16171-1-git-send-email-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: 86ed97e6-2fe1-4500-0522-08d7787152bb
x-ms-traffictypediagnostic: AM0PR04MB6210:|AM0PR04MB6210:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB62108D271267C52619C24344885D0@AM0PR04MB6210.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:218;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(189003)(199004)(99286004)(2906002)(5660300002)(25786009)(54906003)(110136005)(316002)(3846002)(66946007)(66476007)(6116002)(4326008)(6486002)(64756008)(66446008)(66556008)(6512007)(2501003)(6436002)(14444005)(256004)(50226002)(305945005)(71200400001)(71190400001)(81156014)(7416002)(8676002)(8936002)(81166006)(7736002)(102836004)(36756003)(14454004)(52116002)(478600001)(386003)(6506007)(86362001)(2616005)(44832011)(186003)(26005)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6210;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f2gP8iwIDAnnthUQWYyWiLddTEaQJvlImzytUpwbELibXL9S2dIl2UK5fj87HmrAfCxA+8DV839GxdLJ/UovGKckYRu3M/Oy5mQZX1ZtCUJ83srBOd3CTXLT/n3sL9luLBsGLr+36JWoisK8oK9Glh1llJgccTNYRxgHzsNa/10n59qPVq52PX9//kHKUbJ79J8t9L9lzV5uqZkTaLloNgBC5jVtTjL7NMa8xKb0tupjfgp0oASgxZt0C43Gb/7Wdjb8aWlymJqdvYdUq4apgLs9rf/cEgGrlkssXUcDuKpKbB8Joi7S/DviylgEGW4NZABlKWl2i7wzvC/obeuzHfKPYGFHu1muRD4XBZki7zpf4IRl/tQ1N511fXF2B8ERAPiNcDrhGVrOQBwe2L39uUjN4cNzvN6wlnkGxrZcEZZ/Hwuxn57BnjpOawJYo5mD
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ed97e6-2fe1-4500-0522-08d7787152bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 04:20:41.4377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1R2e3cEQIeio94TAflSQn3g1Bf+QHlpOveyj3UBXb5e5V36k9Yz8F6YgRYnq0QuKg4c55wEX3uS2sl3SiaGfhw==
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
 Update commit log, add err handling
 Not tested, just code inspection

 drivers/gpio/gpio-mvebu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 993bbeb3c006..f0fd82b3417c 100644
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
@@ -1102,7 +1101,11 @@ static int mvebu_gpio_probe(struct platform_device *=
pdev)
 		soc_variant =3D MVEBU_GPIO_SOC_VARIANT_ORION;
=20
 	/* Some gpio controllers do not provide irq support */
-	have_irqs =3D of_irq_count(np) !=3D 0;
+	err =3D platform_irq_count(pdev);
+	if (err < 0)
+		return err;
+
+	have_irqs =3D err !=3D 0;
=20
 	mvchip =3D devm_kzalloc(&pdev->dev, sizeof(struct mvebu_gpio_chip),
 			      GFP_KERNEL);
--=20
2.16.4

