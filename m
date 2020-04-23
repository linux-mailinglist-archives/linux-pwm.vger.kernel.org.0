Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D82F1B6276
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Apr 2020 19:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbgDWRqh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 23 Apr 2020 13:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730038AbgDWRqg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Apr 2020 13:46:36 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A98C09B042;
        Thu, 23 Apr 2020 10:46:36 -0700 (PDT)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9540923D06;
        Thu, 23 Apr 2020 19:46:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1587663995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C0mwyzOpo4Hci45ys2sqCNcGyNGL1Gk5vpcSqV75bMI=;
        b=PYtnpbyTDsSqVeej+oE4e4zzVxtag/2m9gR5aKhsA3zDrg6by5LPTvZzbF3wOVLhN0z6x0
        NygYN2o92Xy9emcFz/5e4kcOyuconkSayIrYiVFOGhn7vW4e/q14pAtyslZJ74QR3ROrnU
        dwjFBKewH9NREEGCg8dEGoz8TF/O3H4=
From:   Michael Walle <michael@walle.cc>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v3 09/16] gpiolib: Introduce gpiochip_irqchip_add_domain()
Date:   Thu, 23 Apr 2020 19:45:36 +0200
Message-Id: <20200423174543.17161-10-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423174543.17161-1-michael@walle.cc>
References: <20200423174543.17161-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Spam-Level: ******
X-Rspamd-Server: web
X-Spam-Status: Yes, score=6.40
X-Spam-Score: 6.40
X-Rspamd-Queue-Id: 9540923D06
X-Spamd-Result: default: False [6.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_SPAM(0.00)[1.007];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[25];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c:8000::/33, country:DE];
         FREEMAIL_CC(0.00)[linaro.org,baylibre.com,kernel.org,suse.com,roeck-us.net,gmail.com,pengutronix.de,linux-watchdog.org,nxp.com,linutronix.de,lakedaemon.net,linuxfoundation.org,walle.cc];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This connects an IRQ domain to a gpiochip and reuses gpiochip_to_irq().

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/gpio/gpiolib.c      | 20 ++++++++++++++++++++
 include/linux/gpio/driver.h |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 40f2d7f69be2..7b3d7f496b9a 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2722,6 +2722,26 @@ int gpiochip_irqchip_add_key(struct gpio_chip *gc,
 }
 EXPORT_SYMBOL_GPL(gpiochip_irqchip_add_key);
 
+/**
+ * gpiochip_irqchip_add_key() - adds an irqdomain to a gpiochip
+ * @gc: the gpiochip to add the irqchip to
+ * @domain: the irqdomain to add to the gpiochip
+ *
+ * This function adds an IRQ domain to the gpiochip.
+ */
+int gpiochip_irqchip_add_domain(struct gpio_chip *gc,
+				struct irq_domain *domain)
+{
+	if (!domain)
+		return -EINVAL;
+
+	gc->to_irq = gpiochip_to_irq;
+	gc->irq.domain = domain;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gpiochip_irqchip_add_domain);
+
 #else /* CONFIG_GPIOLIB_IRQCHIP */
 
 static inline int gpiochip_add_irqchip(struct gpio_chip *gc,
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index b8fc92c177eb..dfb1aa0ad4dc 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -599,6 +599,9 @@ int gpiochip_irqchip_add_key(struct gpio_chip *gc,
 bool gpiochip_irqchip_irq_valid(const struct gpio_chip *gc,
 				unsigned int offset);
 
+int gpiochip_irqchip_add_domain(struct gpio_chip *gc,
+				struct irq_domain *domain);
+
 #ifdef CONFIG_LOCKDEP
 
 /*
-- 
2.20.1

