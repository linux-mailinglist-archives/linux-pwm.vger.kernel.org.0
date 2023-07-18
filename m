Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9991F75847C
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jul 2023 20:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjGRSTX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Jul 2023 14:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjGRSTW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Jul 2023 14:19:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD4A10B
        for <linux-pwm@vger.kernel.org>; Tue, 18 Jul 2023 11:19:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHo-0001ns-EY; Tue, 18 Jul 2023 20:19:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHj-000QmQ-Rx; Tue, 18 Jul 2023 20:18:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHj-005unT-9J; Tue, 18 Jul 2023 20:18:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        James Clark <james.clark@arm.com>
Cc:     linux-doc@vger.kernel.org, kernel@pengutronix.de,
        linux-pwm@vger.kernel.org
Subject: [PATCH 01/18] pwm: Provide devm_pwmchip_alloc() function
Date:   Tue, 18 Jul 2023 20:18:32 +0200
Message-Id: <20230718181849.3947851-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4520; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=TKVgLtf5gColk18OkwLza2/HJ7pw09i8jZEvHcwXgpA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkttboXaaUw3bRtUP9CmjrriG6LdFD+1tYcHLY9 gRoCdvY3q6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLbW6AAKCRCPgPtYfRL+ TnkXB/9J2DZMRqQBuHEDgigZUNh9x+wqfkwIal0Vfb82YwrUurnqyhojMseWRBIcDQbhpXtoHKd sr4OoFKC8R4CRrX/WmJVtVtby3plkTO4QRoMk13NZ0WuuG38L3Caigl/5D0WtSiu9CNujvPRKdj +JVuLwq0M57/UyJsAf4GPf+eIMPhbw8Mmp8lMOf5mK4bSY28nt+EUZaDaX+OLyZB/4gR1J4qfCy X9QXvJxzPP0XK2zo8+ApsCUvdP27CWucMYJM9ELwBGQHpC+Qu+GC1Pf4lvB8RK6teTnG0jK4451 hvCg+CDEqQl5y7eLsHhV1fUDTWlmuTa6qkNRCfgBenOcUcX0
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This function allocates a struct pwm_chip and driver data. Compared to
the status quo the split into pwm_chip and driver data is new, otherwise
it doesn't change anything relevant (yet).

The intention is that after all drivers are switched to use this
allocation function, its possible to add a struct device to struct
pwm_chip to properly track the latter's lifetime without touching all
drivers again. Proper lifetime tracking is a necessary precondition to
introduce character device support for PWMs (that implements atomic
setting and doesn't suffer from the sysfs overhead of the /sys/class/pwm
userspace support).

The new function pwmchip_priv() (obviously?) only works for chips
allocated with devm_pwmchip_alloc().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 .../driver-api/driver-model/devres.rst        |  1 +
 Documentation/driver-api/pwm.rst              | 10 ++++----
 drivers/pwm/core.c                            | 23 +++++++++++++++++++
 include/linux/pwm.h                           |  4 ++++
 4 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 8be086b3f829..73a9ee074737 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -414,6 +414,7 @@ POWER
   devm_reboot_mode_unregister()
 
 PWM
+  devm_pwmchip_alloc()
   devm_pwmchip_add()
   devm_pwm_get()
   devm_fwnode_pwm_get()
diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/pwm.rst
index 3fdc95f7a1d1..a3824bd58e4c 100644
--- a/Documentation/driver-api/pwm.rst
+++ b/Documentation/driver-api/pwm.rst
@@ -134,11 +134,11 @@ to implement the pwm_*() functions itself. This means that it's impossible
 to have multiple PWM drivers in the system. For this reason it's mandatory
 for new drivers to use the generic PWM framework.
 
-A new PWM controller/chip can be added using pwmchip_add() and removed
-again with pwmchip_remove(). pwmchip_add() takes a filled in struct
-pwm_chip as argument which provides a description of the PWM chip, the
-number of PWM devices provided by the chip and the chip-specific
-implementation of the supported PWM operations to the framework.
+A new PWM controller/chip can be allocated using devm_pwmchip_alloc, then added
+using pwmchip_add() and removed again with pwmchip_remove(). pwmchip_add()
+takes a filled in struct pwm_chip as argument which provides a description of
+the PWM chip, the number of PWM devices provided by the chip and the
+chip-specific implementation of the supported PWM operations to the framework.
 
 When implementing polarity support in a PWM driver, make sure to respect the
 signal conventions in the PWM framework. By definition, normal polarity
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 81d176142403..3f4c2d940d64 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -304,6 +304,29 @@ void pwmchip_remove(struct pwm_chip *chip)
 }
 EXPORT_SYMBOL_GPL(pwmchip_remove);
 
+void *pwmchip_priv(struct pwm_chip *chip)
+{
+	return (char *)chip + ALIGN(sizeof(*chip), 32);
+}
+EXPORT_SYMBOL_GPL(pwmchip_priv);
+
+struct pwm_chip *devm_pwmchip_alloc(struct device *parent, size_t sizeof_priv)
+{
+	struct pwm_chip *chip;
+	size_t alloc_size;
+
+	alloc_size = ALIGN(sizeof(*chip), 32) + sizeof_priv;
+
+	chip = devm_kzalloc(parent, alloc_size, GFP_KERNEL);
+	if (!chip)
+		return NULL;
+
+	chip->dev = parent;
+
+	return chip;
+}
+EXPORT_SYMBOL_GPL(devm_pwmchip_alloc);
+
 static void devm_pwmchip_remove(void *data)
 {
 	struct pwm_chip *chip = data;
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 10bea923a1d5..648009c8499b 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -5,6 +5,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/compiler_attributes.h>
 
 struct pwm_chip;
 
@@ -385,6 +386,9 @@ int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
 int pwmchip_add(struct pwm_chip *chip);
 void pwmchip_remove(struct pwm_chip *chip);
 
+void *pwmchip_priv(struct pwm_chip *chip) __attribute_const__;
+
+struct pwm_chip *devm_pwmchip_alloc(struct device *parent, size_t sizeof_priv);
 int devm_pwmchip_add(struct device *dev, struct pwm_chip *chip);
 
 struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
-- 
2.39.2

