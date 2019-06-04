Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1F734FA5
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Jun 2019 20:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfFDSNx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 4 Jun 2019 14:13:53 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45498 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfFDSNx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 4 Jun 2019 14:13:53 -0400
Received: by mail-io1-f68.google.com with SMTP id e3so18095568ioc.12;
        Tue, 04 Jun 2019 11:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dGSsW8Ao/tRLmi/QZzRT3Q7h2dCLCK16CHOjhabkhac=;
        b=lGhE8dWo78aPDnJJTq2KYG6HTf8jhF3fmAjd1UY65GrQ0xOOyaH2GSz0CXAJIJS6YR
         5FK2QaGPERBNCBYl5c6C0xtQtWV4avgdm++VzGCHD9a+ntESkIZuyrHrcBmvfmvQwet6
         B32kmuK6UlqVVDz9ro8CxEs/w5E0o+TW3xVcFkpXZK1kgqBXUulDEb10gh17kXfO+ITt
         343nLkLsbw6gRIj7nCT9vu6UBv7MtLz/a9B8FZKBz+3JTXWEVhYkLeQ1pQWP4wWP3ieX
         KVJg19aLCEQnhZk34xXycGHbr/n7W78KqZhkf4rzSN02wskU/Qia4JwseGdLrAyfjmNU
         OVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dGSsW8Ao/tRLmi/QZzRT3Q7h2dCLCK16CHOjhabkhac=;
        b=RmbJ6jsJgaF3SBj4MoUxVqyVk7cnJHAnah7tB1/8b+9WT1wmiVMis1WsvptI/Lliff
         s7NPbPbK1mo5MTCBu90Wkwk0Ct3mHgDLSU9xGe3anRn22c3Q3uOD2b0PByyKADOGn9+r
         EXi0ZczHolfNkwNgMOm9bbuHvytCnnQTuJo1xcHb7YaZsqzJ5jT048qcelmjEDse3C4C
         VEDD6AIT+WBvlGC86kpn/T8+8VQaUaC1WZi4KDTV3lj5RcDCjrLOnAY0knE/8gWyYDgk
         oURUYHPU0bUIzePgxcif8zZQLdmu0yGS4/GmaVFGUvcGTAoSn7btzVkm+6bum1XOvrAr
         GSwA==
X-Gm-Message-State: APjAAAXpRtJovgHXKYkB2nq+AisACggSoiX59EZm2rb1CbdaL79zt8eI
        0wLTcl7+0Y9pWOiGrdJXkeaxh7DI
X-Google-Smtp-Source: APXvYqziwAoPHhUTvZK7FN6Gl1lKhpzhnnuaIkaqQv6EsPmDIq5Oczwb73mappcHmQ2XUCVYrfGcHg==
X-Received: by 2002:a5d:9812:: with SMTP id a18mr8336186iol.289.1559672032130;
        Tue, 04 Jun 2019 11:13:52 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id p11sm1558265itc.2.2019.06.04.11.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 11:13:51 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2] pwm: pca9685: fix pwm/gpio inter-operation
Date:   Tue,  4 Jun 2019 14:13:45 -0400
Message-Id: <20190604181345.9107-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

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
---

WARNING:
	Untested on a real system, I do not have any test h/w.
	This patch should get someone's Tested-by tag.

v1 -> v2:
	applied suggestions from Mika Westerberg:
		rename pca9685_pwm_test_set_inuse -> pca9685_pwm_test_and_set_inuse
		use test_set_inuse and clear_inuse functions for both pwm and gpio
	improve exclusion policy so "all LEDs" channel cannot conflict with the
		other channels, for pwm and gpio alike

 drivers/pwm/pwm-pca9685.c | 89 +++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 41 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 567f5e2771c4..259fd58812ae 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -31,6 +31,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
+#include <linux/bitmap.h>
 
 /*
  * Because the PCA9685 has only one prescaler per chip, changing the period of
@@ -85,6 +86,7 @@ struct pca9685 {
 #if IS_ENABLED(CONFIG_GPIOLIB)
 	struct mutex lock;
 	struct gpio_chip gpio;
+	DECLARE_BITMAP(pwms_inuse, PCA9685_MAXCHAN + 1);
 #endif
 };
 
@@ -94,51 +96,51 @@ static inline struct pca9685 *to_pca(struct pwm_chip *chip)
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
@@ -170,13 +172,10 @@ static void pca9685_pwm_gpio_set(struct gpio_chip *gpio, unsigned int offset,
 static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
 {
 	struct pca9685 *pca = gpiochip_get_data(gpio);
-	struct pwm_device *pwm;
 
 	pca9685_pwm_gpio_set(gpio, offset, 0);
 	pm_runtime_put(pca->chip.dev);
-	mutex_lock(&pca->lock);
-	pwm = &pca->chip.pwms[offset];
-	mutex_unlock(&pca->lock);
+	pca9685_pwm_clear_inuse(pca, offset);
 }
 
 static int pca9685_pwm_gpio_get_direction(struct gpio_chip *chip,
@@ -228,12 +227,17 @@ static int pca9685_pwm_gpio_probe(struct pca9685 *pca)
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
@@ -417,7 +421,7 @@ static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct pca9685 *pca = to_pca(chip);
 
-	if (pca9685_pwm_is_gpio(pca, pwm))
+	if (pca9685_pwm_test_and_set_inuse(pca, pwm->hwpwm))
 		return -EBUSY;
 	pm_runtime_get_sync(chip->dev);
 
@@ -426,8 +430,11 @@ static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 
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
2.17.1

