Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D6C774BBD
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 22:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjHHUys (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 16:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjHHUyh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 16:54:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF8C74AF6
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:19:45 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMx-0006ma-06; Tue, 08 Aug 2023 19:19:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMw-00222r-9U; Tue, 08 Aug 2023 19:19:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMv-00BTAF-KT; Tue, 08 Aug 2023 19:19:41 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 001/101] pwm: Provide devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:17:51 +0200
Message-Id: <20230808171931.944154-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5136; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=8xdAvOchTBo6atds19KaLWTsBo4nmEtzxAxFWrezJ34=; b=owGbwMvMwMXY3/A7olbonx/jabUkhpRLFRuZV64rz2fn9P/zWb51S8E5kU0Sy9Yq2/3RimqZK Jov+K2kk9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJTJvN/j/TWfNks5LQve09 E1MurPxh0hJud2qu2347jx/+auvcI9UN3Nf92lvimOH1Zxr/BZHkZB7HIKbG3b1+NXOr3z6WXir uX6qzp3f3GoEUlyxL/VBWRsZUvsDjTuxOLs+jz3y5eGoln9yj/ImFBx2fh2808bjX+Nbic3Vyoe 0/7amx5e+V7Zvy3XiY+f+Gv2CV4U5j2vGvuH/5+oVd7gKzWWdrqSV6KW7i33npQMyW+J4sFbmXl vvmz9yozxhea9t5pUdG4vF669ILpk/l3x22u710hkzJj6TurZYV2xTUNQ1uqZ00nVZ993mObbb+ uiTH4/O6X3We5SvqPujx5zzrvvxLAtmrlAQFE5K7NwsCAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 Documentation/driver-api/pwm.rst              | 10 +++----
 drivers/pwm/core.c                            | 30 ++++++++++++++++---
 include/linux/pwm.h                           |  5 ++++
 4 files changed, 37 insertions(+), 9 deletions(-)

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
index 8aa3feec12a9..cfcddf62ab01 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -196,6 +196,31 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
 	return true;
 }
 
+void *pwmchip_priv(struct pwm_chip *chip)
+{
+	return &chip[1];
+}
+EXPORT_SYMBOL_GPL(pwmchip_priv);
+
+struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, size_t sizeof_priv)
+{
+	struct pwm_chip *chip;
+	size_t alloc_size;
+	unsigned int i;
+
+	alloc_size = sizeof(*chip) + sizeof_priv;
+
+	chip = devm_kzalloc(parent, alloc_size, GFP_KERNEL);
+	if (!chip)
+		return ERR_PTR(-ENOMEM);
+
+	chip->dev = parent;
+	chip->npwm = npwm;
+
+	return chip;
+}
+EXPORT_SYMBOL_GPL(devm_pwmchip_alloc);
+
 /**
  * __pwmchip_add() - register a new PWM chip
  * @chip: the PWM chip to add
@@ -208,8 +233,6 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
  */
 int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 {
-	struct pwm_device *pwm;
-	unsigned int i;
 	int ret;
 
 	if (!chip || !chip->dev || !chip->ops || !chip->npwm)
@@ -234,9 +257,8 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 	}
 
 	chip->id = ret;
-
 	for (i = 0; i < chip->npwm; i++) {
-		pwm = &chip->pwms[i];
+		struct pwm_device *pwm = &chip->pwms[i];
 
 		pwm->chip = chip;
 		pwm->hwpwm = i;
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 6f139784d6f5..3c0da17e193c 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -5,6 +5,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/compiler_attributes.h>
 
 struct pwm_chip;
 
@@ -380,6 +381,10 @@ static inline void pwm_disable(struct pwm_device *pwm)
 int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
 		unsigned long timeout);
 
+void *pwmchip_priv(struct pwm_chip *chip) __attribute_const__;
+
+struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, size_t sizeof_priv);
+
 int __pwmchip_add(struct pwm_chip *chip, struct module *owner);
 #define pwmchip_add(chip) __pwmchip_add(chip, THIS_MODULE)
 void pwmchip_remove(struct pwm_chip *chip);
-- 
2.40.1

