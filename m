Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430B92C85A5
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Nov 2020 14:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgK3Nht (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Nov 2020 08:37:49 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:46455 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbgK3Nht (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 30 Nov 2020 08:37:49 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id DDC0F440281;
        Mon, 30 Nov 2020 15:37:05 +0200 (IST)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Baruch Siach <baruch@tkos.co.il>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] gpio: mvebu: fix potential user-after-free on probe
Date:   Mon, 30 Nov 2020 15:33:23 +0200
Message-Id: <c27a61d66a9ec4e52e0d1820ce9528ffa18ca539.1606743203.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

When mvebu_pwm_probe() fails IRQ domain is not released. Move
mvebu_pwm_probe() before IRQ domain registration.

Fixes: 757642f9a584 ("gpio: mvebu: Add limited PWM support")
Reported-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---

This is split out of the "gpio: mvebu: Armada 8K/7K PWM support" series.
I'll rebase the series v2 on top on this fix.
---
 drivers/gpio/gpio-mvebu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 433e2c3f3fd5..4a331c8f6b06 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -1197,6 +1197,13 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 
 	devm_gpiochip_add_data(&pdev->dev, &mvchip->chip, mvchip);
 
+	/* Some MVEBU SoCs have simple PWM support for GPIO lines */
+	if (IS_ENABLED(CONFIG_PWM)) {
+		err = mvebu_pwm_probe(pdev, mvchip, id);
+		if (err)
+			return err;
+	}
+
 	/* Some gpio controllers do not provide irq support */
 	if (!have_irqs)
 		return 0;
@@ -1254,10 +1261,6 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 						 mvchip);
 	}
 
-	/* Some MVEBU SoCs have simple PWM support for GPIO lines */
-	if (IS_ENABLED(CONFIG_PWM))
-		return mvebu_pwm_probe(pdev, mvchip, id);
-
 	return 0;
 
 err_domain:
-- 
2.29.2

