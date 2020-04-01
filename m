Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 101C419B473
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Apr 2020 19:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732316AbgDARBg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 1 Apr 2020 13:01:36 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:57696 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732304AbgDARBg (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 1 Apr 2020 13:01:36 -0400
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 708BCC45B56;
        Wed,  1 Apr 2020 19:01:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1585760493;
        bh=NfVkgcJwROCOa0Gvoa39DfTa9hL2ePWFTZdlOJfOves=;
        h=From:To:Cc:Subject:Date:From;
        b=0b7o4o8opumpRq8uti0QY+/V4D9f9CZxr/+OVdWXHS6y6lCGnYY4WrG1x255L6bgW
         Qs77vBu629FCX61mDhm4DFrnYDaXL0p0vhjTqJLWocA4+eT7uogqDKA9y56w5EbMfW
         RYcHqBpxnepFTV/QkvqTrMMUVUGpTiJm1HZf5524=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH v2 REBASED] pwm: pca9685: fix pwm/gpio inter-operation
Date:   Wed,  1 Apr 2020 19:01:06 +0200
Message-Id: <20200401170106.134037-1-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Sven Van Asbroeck <TheSven73@gmail.com>

This driver allows pwms to be requested as gpios via gpiolib.
Obviously, it should not be allowed to request a gpio when its
corresponding pwm is already requested (and vice versa).
So it requires some exclusion code.

Given that the pwm and gpio cores are not synchronized with
respect to each other, this exclusion code will also require
proper synchronization.

Such a mechanism was in place, but was inadvertently removed
by Uwe's clean-up patch.

Upon revisiting the synchronization mechanism, we found that
theoretically, it could allow two threads to successfully
request conflicting pwms / gpios.

Replace with a bitmap which tracks pwm in-use, plus a mutex.
As long as pwm and gpio's respective request/free functions
modify the in-use bitmap while holding the mutex, proper
synchronization will be guaranteed.

Reported-by: YueHaibing <yuehaibing@huawei.com>
Fixes: e926b12c611c ("pwm: Clear chip_data in pwm_put()")
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: YueHaibing <yuehaibing@huawei.com>
Link: https://lkml.org/lkml/2019/5/31/963
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Tested-by: Clemens Gruber <clemens.gruber@pqgruber.com>
[cg: Tested on an i.MX6Q board with two NXP PCA9685 chips]

---
 drivers/pwm/pwm-pca9685.c | 85 ++++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 37 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 20bdc59a0cbb..76cd22bd6614 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -20,6 +20,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
+#include <linux/bitmap.h>
 
 /*
  * Because the PCA9685 has only one prescaler per chip, changing the period of
@@ -73,6 +74,7 @@ struct pca9685 {
 #if IS_ENABLED(CONFIG_GPIOLIB)
 	struct mutex lock;
 	struct gpio_chip gpio;
+	DECLARE_BITMAP(pwms_inuse, PCA9685_MAXCHAN + 1);
 #endif
 };
 
@@ -82,51 +84,51 @@ static inline struct pca9685 *to_pca(struct pwm_chip *chip)
 }
 
 #if IS_ENABLED(CONFIG_GPIOLIB)
-static int pca9685_pwm_gpio_request(struct gpio_chip *gpio, unsigned int offset)
+static bool pca9685_pwm_test_and_set_inuse(struct pca9685 *pca, int pwm_idx)
 {
-	struct pca9685 *pca = gpiochip_get_data(gpio);
-	struct pwm_device *pwm;
+	bool is_inuse;
 
 	mutex_lock(&pca->lock);
-
-	pwm = &pca->chip.pwms[offset];
-
-	if (pwm->flags & (PWMF_REQUESTED | PWMF_EXPORTED)) {
-		mutex_unlock(&pca->lock);
-		return -EBUSY;
+	if (pwm_idx >= PCA9685_MAXCHAN) {
+		/*
+		 * "all LEDs" channel:
+		 * pretend already in use if any of the PWMs are requested
+		 */
+		if (!bitmap_empty(pca->pwms_inuse, PCA9685_MAXCHAN)) {
+			is_inuse = true;
+			goto out;
+		}
+	} else {
+		/*
+		 * regular channel:
+		 * pretend already in use if the "all LEDs" channel is requested
+		 */
+		if (test_bit(PCA9685_MAXCHAN, pca->pwms_inuse)) {
+			is_inuse = true;
+			goto out;
+		}
 	}
-
-	pwm_set_chip_data(pwm, (void *)1);
-
+	is_inuse = test_and_set_bit(pwm_idx, pca->pwms_inuse);
+out:
 	mutex_unlock(&pca->lock);
-	pm_runtime_get_sync(pca->chip.dev);
-	return 0;
+	return is_inuse;
 }
 
-static bool pca9685_pwm_is_gpio(struct pca9685 *pca, struct pwm_device *pwm)
+static void pca9685_pwm_clear_inuse(struct pca9685 *pca, int pwm_idx)
 {
-	bool is_gpio = false;
-
 	mutex_lock(&pca->lock);
+	clear_bit(pwm_idx, pca->pwms_inuse);
+	mutex_unlock(&pca->lock);
+}
 
-	if (pwm->hwpwm >= PCA9685_MAXCHAN) {
-		unsigned int i;
-
-		/*
-		 * Check if any of the GPIOs are requested and in that case
-		 * prevent using the "all LEDs" channel.
-		 */
-		for (i = 0; i < pca->gpio.ngpio; i++)
-			if (gpiochip_is_requested(&pca->gpio, i)) {
-				is_gpio = true;
-				break;
-			}
-	} else if (pwm_get_chip_data(pwm)) {
-		is_gpio = true;
-	}
+static int pca9685_pwm_gpio_request(struct gpio_chip *gpio, unsigned int offset)
+{
+	struct pca9685 *pca = gpiochip_get_data(gpio);
 
-	mutex_unlock(&pca->lock);
-	return is_gpio;
+	if (pca9685_pwm_test_and_set_inuse(pca, offset))
+		return -EBUSY;
+	pm_runtime_get_sync(pca->chip.dev);
+	return 0;
 }
 
 static int pca9685_pwm_gpio_get(struct gpio_chip *gpio, unsigned int offset)
@@ -161,6 +163,7 @@ static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
 
 	pca9685_pwm_gpio_set(gpio, offset, 0);
 	pm_runtime_put(pca->chip.dev);
+	pca9685_pwm_clear_inuse(pca, offset);
 }
 
 static int pca9685_pwm_gpio_get_direction(struct gpio_chip *chip,
@@ -212,12 +215,17 @@ static int pca9685_pwm_gpio_probe(struct pca9685 *pca)
 	return devm_gpiochip_add_data(dev, &pca->gpio, pca);
 }
 #else
-static inline bool pca9685_pwm_is_gpio(struct pca9685 *pca,
-				       struct pwm_device *pwm)
+static inline bool pca9685_pwm_test_and_set_inuse(struct pca9685 *pca,
+						  int pwm_idx)
 {
 	return false;
 }
 
+static inline void
+pca9685_pwm_clear_inuse(struct pca9685 *pca, int pwm_idx)
+{
+}
+
 static inline int pca9685_pwm_gpio_probe(struct pca9685 *pca)
 {
 	return 0;
@@ -399,7 +407,7 @@ static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct pca9685 *pca = to_pca(chip);
 
-	if (pca9685_pwm_is_gpio(pca, pwm))
+	if (pca9685_pwm_test_and_set_inuse(pca, pwm->hwpwm))
 		return -EBUSY;
 	pm_runtime_get_sync(chip->dev);
 
@@ -408,8 +416,11 @@ static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 
 static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	struct pca9685 *pca = to_pca(chip);
+
 	pca9685_pwm_disable(chip, pwm);
 	pm_runtime_put(chip->dev);
+	pca9685_pwm_clear_inuse(pca, pwm->hwpwm);
 }
 
 static const struct pwm_ops pca9685_pwm_ops = {
-- 
2.26.0

