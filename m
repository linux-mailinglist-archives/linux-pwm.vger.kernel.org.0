Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D840112729
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Dec 2019 10:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfLDJYn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Dec 2019 04:24:43 -0500
Received: from mail-eopbgr50077.outbound.protection.outlook.com ([40.107.5.77]:49022
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725922AbfLDJYn (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 4 Dec 2019 04:24:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMk72EJK+p5V0D5JfVvrY1DBZdXz6dDxIB5FMaQYOAHYsqu2EyUIuKL8z9K2FtUuE7m/LDRVTKAOWUiIdsqQL5mo+E36yX63ESopKs7NhebSiGuGbmmL7fHN6eAUa6qYgh1bmKHWbCizlmbDc1D/v9gptV6GRtQtaZRRSPjGPmb/dKT0HLt92wvkc7lBJQiwgScHENGeXBTEv3CX7cQym4BqNQrFIEa57xif88xA5xx8bR7m9ZKe7ZNn8CBvMD5/+fU57ujp+FO21utWZIDIT9QzqBG3ZDjtsFyCbcEDbhf9jxTzOthcH9QdQm147q2GOuqetXP2Wvo6tLP+uqFn7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWL6Y/JuzonP2fKxT1BtzX8ymGZAolCz63+Glcgs960=;
 b=O8RXU9NnJoA2fLO1RyO1+FTnwBG5Qj/nHd8s3VxxnMJoVy/PBAwdEJSCPmC+6F8E3OpiVvh8YIVfJCKc+V6A3P10WDKDdvGE3df0pUnMdM0gZT0TTXkT0ReGieUbQLmf0Ed1GBEQzWPxlYRQRRpuioniFNi7g0GQk6TNo+/m25rmj1zrHv1MvwmoTTZ/HNz8KEYY+R8YTNWxriXgzShfv+jNLl+ECRVpG2C3FNJnGNqPogUghXd5zd/t9KKknl0BE0IXnHEhPDM0TTZiJpzGglUwAVmfBRXTOWPf3DIKh/0J/d6hzKhZ85i3eiYZ9xMypKqaMqJUwu5nYcU7jDHV1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWL6Y/JuzonP2fKxT1BtzX8ymGZAolCz63+Glcgs960=;
 b=TSyhezorWQya6pacCBMUZfkQf21xAIAnYXuJTlWMP2jJtPby1hzP9ssmGfJp8RQLR3MJFiQzZPhpnfZ0G2039NTVoyTZeEPupF0Fjn5vCZNRasaEUZsMkgKi4Bg1Kxm4QfZkcZLy9RI8rEzczrcykf0oC8pui5MNVItaPwdv5s4=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5812.eurprd04.prod.outlook.com (20.178.119.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Wed, 4 Dec 2019 09:24:39 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 09:24:39 +0000
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
Subject: [PATCH v3 2/2] gpio: bcm-kona: use platform_irq_count
Thread-Topic: [PATCH v3 2/2] gpio: bcm-kona: use platform_irq_count
Thread-Index: AQHVqoSnVgd0oV+avUOUZsuBa7eNTw==
Date:   Wed, 4 Dec 2019 09:24:39 +0000
Message-ID: <1575451330-11112-2-git-send-email-peng.fan@nxp.com>
References: <1575451330-11112-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1575451330-11112-1-git-send-email-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: 3dbfcd41-7b3f-4fa1-85fa-08d7789bc9a7
x-ms-traffictypediagnostic: AM0PR04MB5812:|AM0PR04MB5812:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5812BE69EF798C57BE83225D885D0@AM0PR04MB5812.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:196;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(189003)(199004)(110136005)(14444005)(316002)(2501003)(305945005)(7736002)(50226002)(8676002)(81156014)(81166006)(8936002)(86362001)(2906002)(3846002)(7416002)(6116002)(54906003)(4326008)(6512007)(2201001)(25786009)(52116002)(478600001)(6486002)(5660300002)(6436002)(44832011)(2616005)(446003)(11346002)(76176011)(102836004)(26005)(6506007)(386003)(186003)(71200400001)(66446008)(66476007)(66556008)(64756008)(66946007)(99286004)(71190400001)(36756003)(256004)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5812;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tPib5bqkzWLTPipBPqmCstjocwrs4cr6OFfbRZDmvSJAw/Y0WWeFEsIF2F7qlzpoCpBH9snXDGc8c7WTRKsuZh2vmQUN9KzBPT4VZaZj+bsc5uvU9LwETWmSG5ZH8zHtKlzcQzew8qvRIkZkrA4RYuql3PJWsJx4q+V+kF9zdtHhrGdHJB/9dqrlC7PyNhKe32fS0JwZV9peO0ExZWhpBV1d+7WKW+CXCvLOIGdS9OM+3z5BSdro5jRQyMOXtF4EYk+iMWrF1HsVgUFygRV8RlEP368OjGs6VREgHhWMcHN3BqXP7MiLIRjfhM/8zh9hxotgJaHJM0Oj//9vuKTXotvfKVwh1wmHIZug9A14o03iWllfriEthXrjp+kvMvKdk5QI2TGSrXK4rXUb7uIb+a6nPU5Q3fPE9R43axwHycC/hoITZW1SlDDoMXFAOzCp
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dbfcd41-7b3f-4fa1-85fa-08d7789bc9a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 09:24:39.6716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: macVC3OPEqSAGw34i5TgbEyLdWbl3P0kEGXyaiAWahvuKdfNVoQhzEQgvcNCYiXnkcfj5pXhnjz/enSTQpYhhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5812
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

V3:
 Use %pe
V2:
 Update commit log, and add err handling
 Not tested, just code inspection


 drivers/gpio/gpio-bcm-kona.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
index 4122683eb1f9..baee8c3f06ad 100644
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
+			dev_err(dev, "Couldn't determine GPIO banks: (%pe)\n",
+				ERR_PTR(ret));
+		return ret;
 	}
+	kona_gpio->num_bank =3D ret;
+
 	if (kona_gpio->num_bank > GPIO_MAX_BANK_NUM) {
 		dev_err(dev, "Too many GPIO banks configured (max=3D%d)\n",
 			GPIO_MAX_BANK_NUM);
--=20
2.16.4

