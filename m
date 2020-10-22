Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A9D2961FD
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Oct 2020 17:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368888AbgJVP7M (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 22 Oct 2020 11:59:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:48528 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S368870AbgJVP7L (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 22 Oct 2020 11:59:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DC564ADF5;
        Thu, 22 Oct 2020 15:59:08 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     f.fainelli@gmail.com, linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        wahrenst@gmx.net, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org,
        sboyd@kernel.org, linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 03/10] gpio: raspberrypi-exp: Release firmware handle on unbind
Date:   Thu, 22 Oct 2020 17:58:50 +0200
Message-Id: <20201022155858.20867-4-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201022155858.20867-1-nsaenzjulienne@suse.de>
References: <20201022155858.20867-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Upon unbinding the device make sure we release RPi's firmware interface.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/gpio/gpio-raspberrypi-exp.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-raspberrypi-exp.c b/drivers/gpio/gpio-raspberrypi-exp.c
index bb100e0124e6..c008336e1131 100644
--- a/drivers/gpio/gpio-raspberrypi-exp.c
+++ b/drivers/gpio/gpio-raspberrypi-exp.c
@@ -231,8 +231,19 @@ static int rpi_exp_gpio_probe(struct platform_device *pdev)
 	rpi_gpio->gc.get = rpi_exp_gpio_get;
 	rpi_gpio->gc.set = rpi_exp_gpio_set;
 	rpi_gpio->gc.can_sleep = true;
+	platform_set_drvdata(pdev, rpi_gpio);
 
-	return devm_gpiochip_add_data(dev, &rpi_gpio->gc, rpi_gpio);
+	return gpiochip_add_data(&rpi_gpio->gc, rpi_gpio);
+}
+
+static int rpi_exp_gpio_remove(struct platform_device *pdev)
+{
+	struct rpi_exp_gpio *rpi_gpio = platform_get_drvdata(pdev);
+
+	gpiochip_remove(&rpi_gpio->gc);
+	rpi_firmware_put(rpi_gpio->fw);
+
+	return 0;
 }
 
 static const struct of_device_id rpi_exp_gpio_ids[] = {
@@ -247,6 +258,7 @@ static struct platform_driver rpi_exp_gpio_driver = {
 		.of_match_table	= of_match_ptr(rpi_exp_gpio_ids),
 	},
 	.probe	= rpi_exp_gpio_probe,
+	.remove = rpi_exp_gpio_remove,
 };
 module_platform_driver(rpi_exp_gpio_driver);
 
-- 
2.28.0

