Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9F4CB6682
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Sep 2019 16:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbfIRO5Y (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Sep 2019 10:57:24 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:42543 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731382AbfIRO5Y (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Sep 2019 10:57:24 -0400
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id B47DC200018;
        Wed, 18 Sep 2019 14:57:20 +0000 (UTC)
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH v2] pwm: atmel: Remove platform_device_id and use only dt bindings
Date:   Wed, 18 Sep 2019 16:57:16 +0200
Message-Id: <20190918145716.32022-1-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Since commit 26202873bb51 ("avr32: remove support for AVR32
architecture") there is no more user of platform_device_id and we
should only use dt bindings

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
---
Changelog:
 v1->v2
 
 - Remove whole function atmel_pwm_get_driver_data and call
 of_device_get_match_data from atmel_pwm_probe

 drivers/pwm/Kconfig     |  2 +-
 drivers/pwm/pwm-atmel.c | 35 +++--------------------------------
 2 files changed, 4 insertions(+), 33 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index a7e57516959e..b51fb1a33aa2 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -44,7 +44,7 @@ config PWM_AB8500
 
 config PWM_ATMEL
 	tristate "Atmel PWM support"
-	depends on ARCH_AT91
+	depends on ARCH_AT91 && OF
 	help
 	  Generic PWM framework driver for Atmel SoC.
 
diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index e5e1eaf372fa..f7cf0a86a37c 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -318,19 +318,6 @@ static const struct atmel_pwm_data mchp_sam9x60_pwm_data = {
 	},
 };
 
-static const struct platform_device_id atmel_pwm_devtypes[] = {
-	{
-		.name = "at91sam9rl-pwm",
-		.driver_data = (kernel_ulong_t)&atmel_sam9rl_pwm_data,
-	}, {
-		.name = "sama5d3-pwm",
-		.driver_data = (kernel_ulong_t)&atmel_sama5_pwm_data,
-	}, {
-		/* sentinel */
-	},
-};
-MODULE_DEVICE_TABLE(platform, atmel_pwm_devtypes);
-
 static const struct of_device_id atmel_pwm_dt_ids[] = {
 	{
 		.compatible = "atmel,at91sam9rl-pwm",
@@ -350,19 +337,6 @@ static const struct of_device_id atmel_pwm_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, atmel_pwm_dt_ids);
 
-static inline const struct atmel_pwm_data *
-atmel_pwm_get_driver_data(struct platform_device *pdev)
-{
-	const struct platform_device_id *id;
-
-	if (pdev->dev.of_node)
-		return of_device_get_match_data(&pdev->dev);
-
-	id = platform_get_device_id(pdev);
-
-	return (struct atmel_pwm_data *)id->driver_data;
-}
-
 static int atmel_pwm_probe(struct platform_device *pdev)
 {
 	const struct atmel_pwm_data *data;
@@ -370,7 +344,7 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 	struct resource *res;
 	int ret;
 
-	data = atmel_pwm_get_driver_data(pdev);
+	data = of_device_get_match_data(&pdev->dev);
 	if (!data)
 		return -ENODEV;
 
@@ -396,10 +370,8 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 	atmel_pwm->chip.dev = &pdev->dev;
 	atmel_pwm->chip.ops = &atmel_pwm_ops;
 
-	if (pdev->dev.of_node) {
-		atmel_pwm->chip.of_xlate = of_pwm_xlate_with_flags;
-		atmel_pwm->chip.of_pwm_n_cells = 3;
-	}
+	atmel_pwm->chip.of_xlate = of_pwm_xlate_with_flags;
+	atmel_pwm->chip.of_pwm_n_cells = 3;
 
 	atmel_pwm->chip.base = -1;
 	atmel_pwm->chip.npwm = 4;
@@ -437,7 +409,6 @@ static struct platform_driver atmel_pwm_driver = {
 		.name = "atmel-pwm",
 		.of_match_table = of_match_ptr(atmel_pwm_dt_ids),
 	},
-	.id_table = atmel_pwm_devtypes,
 	.probe = atmel_pwm_probe,
 	.remove = atmel_pwm_remove,
 };
-- 
2.23.0

