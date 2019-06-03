Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA74933334
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Jun 2019 17:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbfFCPMe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 3 Jun 2019 11:12:34 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:51379 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbfFCPMd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 3 Jun 2019 11:12:33 -0400
Received: by mail-it1-f193.google.com with SMTP id m3so28081450itl.1;
        Mon, 03 Jun 2019 08:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iRMUqrkWI3Fe1CUQI4+XKYy95CUJBtlWiL3ho3UIqz8=;
        b=h2yRCiUMrFPmLhN+UzJwAb4StZ7I2JrTdWn/Ejed0sMbOt/N2oYXqarRJ8FvBbRyQi
         MAyEEQuAuUyiG1cuhFHGYxMBI6k78/e8Nwh2UfaN0Dx5U9M99dXU/qFunJ0UJ6RltcCF
         LNdKiMK1q57sr7OgnQ0J9eaCXGdwYCfLbu1Yu29SeMQWs4X1KoI33x5O2aF+i07V+rcY
         FErvmmuGCw2yrCdGeVxeN0iJq7MzKgC0vf6upi3CMZrZ/VYU/VxQSfGfR6ZUEvEQBMf/
         DNvKTsRH0YoOqUQWPPDXhZSU2G9TIkhLIGCwqDhUzi0k97uvD+bNWS5KsMi552J4UiMZ
         xehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iRMUqrkWI3Fe1CUQI4+XKYy95CUJBtlWiL3ho3UIqz8=;
        b=MqaFu7iGV48trdUVfuQoWwejtMyk4hApMmNJZQQkVTrm4HUWfjnlDEBadZ2Pl8KM5k
         DxriSOK9pi+lIjNLsN5Xw3hFN2yCq0EIn+aToC8frhoo0+M1qQQB8JFl6ClCDzlTrK8N
         CFY20G6xGhaU6+yzCgLbnz6G7aU9VQxJiCkn/1GrYvhDOryjnhCHgbNA9gIF8oTHhFAb
         V8xFEARl2ie6czvCA/njATNad2sg4N7ZvcBH6rU84YqdXpXDDeZ8bRJStbNKO+OoLVEW
         4MGV8/hn1DbvnkiDUpBlwr9De5KVkiNdpjQUtzCdlMwYW7hDL1MzeyoVso/kXmU5miAM
         iMxA==
X-Gm-Message-State: APjAAAU2H8QHmzeJzatfeKtfSiIBS6ttNDsu1gC5uzBU3cTCd+7edcH6
        3mUJywSJUju3wgPa7RdRMtAJ35iP
X-Google-Smtp-Source: APXvYqyTn580F+PuwgzORP8A3GFbaNeFW65CWCpPGwq5ZJ7CkSvym0Q+hcmNDTUOeOdCmixFVbFpqg==
X-Received: by 2002:a24:2e58:: with SMTP id i85mr4782898ita.174.1559574752550;
        Mon, 03 Jun 2019 08:12:32 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id u187sm4984205iod.37.2019.06.03.08.12.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 08:12:32 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] pwm: pca9685: fix pwm/gpio inter-operation
Date:   Mon,  3 Jun 2019 11:12:23 -0400
Message-Id: <20190603151223.5311-1-TheSven73@gmail.com>
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
Link: https://lkml.org/lkml/2019/5/31/963
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---

This approach will also prevent the request of the "all" pwm channel, if any
other pwm channel is already in use. Is this correct behaviour?

 drivers/pwm/pwm-pca9685.c | 64 +++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 567f5e2771c4..f9927cd106d0 100644
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
+	DECLARE_BITMAP(pwms_inuse, PCA9685_MAXCHAN);
 #endif
 };
 
@@ -97,48 +99,45 @@ static inline struct pca9685 *to_pca(struct pwm_chip *chip)
 static int pca9685_pwm_gpio_request(struct gpio_chip *gpio, unsigned int offset)
 {
 	struct pca9685 *pca = gpiochip_get_data(gpio);
-	struct pwm_device *pwm;
 
 	mutex_lock(&pca->lock);
 
-	pwm = &pca->chip.pwms[offset];
-
-	if (pwm->flags & (PWMF_REQUESTED | PWMF_EXPORTED)) {
+	if (test_and_set_bit(offset, pca->pwms_inuse)) {
 		mutex_unlock(&pca->lock);
 		return -EBUSY;
 	}
 
-	pwm_set_chip_data(pwm, (void *)1);
-
 	mutex_unlock(&pca->lock);
 	pm_runtime_get_sync(pca->chip.dev);
 	return 0;
 }
 
-static bool pca9685_pwm_is_gpio(struct pca9685 *pca, struct pwm_device *pwm)
+static bool
+pca9685_pwm_test_set_inuse(struct pca9685 *pca, struct pwm_device *pwm)
 {
-	bool is_gpio = false;
+	bool is_inuse;
 
 	mutex_lock(&pca->lock);
+	/*
+	 * Check if any of the PWMs are requested and in that case
+	 * prevent using the "all LEDs" channel.
+	 */
+	if (pwm->hwpwm >= PCA9685_MAXCHAN &&
+			!bitmap_empty(pca->pwms_inuse, PCA9685_MAXCHAN))
+		is_inuse = true;
+	else
+		is_inuse = test_and_set_bit(pwm->hwpwm, pca->pwms_inuse);
+	mutex_unlock(&pca->lock);
 
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
+	return is_inuse;
+}
 
+static void pca9685_pwm_clear_inuse(struct pca9685 *pca, struct pwm_device *pwm)
+{
+	mutex_lock(&pca->lock);
+	if (pwm->hwpwm < PCA9685_MAXCHAN)
+		clear_bit(pwm->hwpwm, pca->pwms_inuse);
 	mutex_unlock(&pca->lock);
-	return is_gpio;
 }
 
 static int pca9685_pwm_gpio_get(struct gpio_chip *gpio, unsigned int offset)
@@ -170,12 +169,11 @@ static void pca9685_pwm_gpio_set(struct gpio_chip *gpio, unsigned int offset,
 static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
 {
 	struct pca9685 *pca = gpiochip_get_data(gpio);
-	struct pwm_device *pwm;
 
+	mutex_lock(&pca->lock);
 	pca9685_pwm_gpio_set(gpio, offset, 0);
 	pm_runtime_put(pca->chip.dev);
-	mutex_lock(&pca->lock);
-	pwm = &pca->chip.pwms[offset];
+	clear_bit(offset, pca->pwms_inuse);
 	mutex_unlock(&pca->lock);
 }
 
@@ -228,12 +226,17 @@ static int pca9685_pwm_gpio_probe(struct pca9685 *pca)
 	return devm_gpiochip_add_data(dev, &pca->gpio, pca);
 }
 #else
-static inline bool pca9685_pwm_is_gpio(struct pca9685 *pca,
+static inline bool pca9685_pwm_test_set_inuse(struct pca9685 *pca,
 				       struct pwm_device *pwm)
 {
 	return false;
 }
 
+static inline void
+pca9685_pwm_clear_inuse(struct pca9685 *pca, struct pwm_device *pwm)
+{
+}
+
 static inline int pca9685_pwm_gpio_probe(struct pca9685 *pca)
 {
 	return 0;
@@ -417,7 +420,7 @@ static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct pca9685 *pca = to_pca(chip);
 
-	if (pca9685_pwm_is_gpio(pca, pwm))
+	if (pca9685_pwm_test_set_inuse(pca, pwm))
 		return -EBUSY;
 	pm_runtime_get_sync(chip->dev);
 
@@ -426,8 +429,11 @@ static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 
 static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	struct pca9685 *pca = to_pca(chip);
+
 	pca9685_pwm_disable(chip, pwm);
 	pm_runtime_put(chip->dev);
+	pca9685_pwm_clear_inuse(pca, pwm);
 }
 
 static const struct pwm_ops pca9685_pwm_ops = {
-- 
2.17.1

