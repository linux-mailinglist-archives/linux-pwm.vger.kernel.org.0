Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE082C8773
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Nov 2020 16:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgK3PKl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Nov 2020 10:10:41 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:46529 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbgK3PKl (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 30 Nov 2020 10:10:41 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 776C0440A96;
        Mon, 30 Nov 2020 17:09:58 +0200 (IST)
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
Subject: [PATCH v2] gpio: mvebu: fix potential user-after-free on probe
Date:   Mon, 30 Nov 2020 17:09:53 +0200
Message-Id: <4db704460547d715a1d9cf86d51612b347e38a7b.1606748993.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

When mvebu_pwm_probe() fails IRQ domain is not released. Goto the
err_domain label on failure to release IRQ domain.

Fixes: 757642f9a584 ("gpio: mvebu: Add limited PWM support")
Reported-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v2: Don't leak pwm resources (Uwe Kleine-König)

This is split out of the "gpio: mvebu: Armada 8K/7K PWM support" series.
I'll rebase the series v2 on top on this fix.
---
 drivers/gpio/gpio-mvebu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 433e2c3f3fd5..c53ed975a180 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -1255,8 +1255,11 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	}
 
 	/* Some MVEBU SoCs have simple PWM support for GPIO lines */
-	if (IS_ENABLED(CONFIG_PWM))
-		return mvebu_pwm_probe(pdev, mvchip, id);
+	if (IS_ENABLED(CONFIG_PWM)) {
+		err = mvebu_pwm_probe(pdev, mvchip, id);
+		if (err)
+			goto err_domain;
+	}
 
 	return 0;
 
-- 
2.29.2

