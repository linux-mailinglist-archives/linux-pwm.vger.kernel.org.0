Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3202CB5A7
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Dec 2020 08:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387605AbgLBHQi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Dec 2020 02:16:38 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:50252 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728569AbgLBHQh (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 2 Dec 2020 02:16:37 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 095A944013A;
        Wed,  2 Dec 2020 09:15:54 +0200 (IST)
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
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v3 1/6] gpio: mvebu: fix potential user-after-free on probe
Date:   Wed,  2 Dec 2020 09:15:32 +0200
Message-Id: <f6248a894264d9bc3af3ca040f7cebe5465b67f0.1606892239.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1606892239.git.baruch@tkos.co.il>
References: <cover.1606892239.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

When mvebu_pwm_probe() fails IRQ domain is not released. Move pwm probe
before IRQ domain allocation. Add pwm cleanup code to the failure path.

Fixes: 757642f9a584 ("gpio: mvebu: Add limited PWM support")
Reported-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v3: Move pwm back before irq so that irq_alloc_domain_generic_chips()
    fails last, and we don't need to clean after it

v2: Don't leak pwm resources (Uwe Kleine-König)
---
 drivers/gpio/gpio-mvebu.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 433e2c3f3fd5..2f245594a90a 100644
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
@@ -1206,7 +1213,8 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	if (!mvchip->domain) {
 		dev_err(&pdev->dev, "couldn't allocate irq domain %s (DT).\n",
 			mvchip->chip.label);
-		return -ENODEV;
+		err = -ENODEV;
+		goto err_pwm;
 	}
 
 	err = irq_alloc_domain_generic_chips(
@@ -1254,14 +1262,12 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 						 mvchip);
 	}
 
-	/* Some MVEBU SoCs have simple PWM support for GPIO lines */
-	if (IS_ENABLED(CONFIG_PWM))
-		return mvebu_pwm_probe(pdev, mvchip, id);
-
 	return 0;
 
 err_domain:
 	irq_domain_remove(mvchip->domain);
+err_pwm:
+	pwmchip_remove(&mvchip->mvpwm->chip);
 
 	return err;
 }
-- 
2.29.2

