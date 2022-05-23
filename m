Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D944531BEE
	for <lists+linux-pwm@lfdr.de>; Mon, 23 May 2022 22:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241227AbiEWSDO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 May 2022 14:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243447AbiEWSBq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 May 2022 14:01:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60860A5019
        for <linux-pwm@vger.kernel.org>; Mon, 23 May 2022 10:46:41 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ntC7J-0005ZD-6Y; Mon, 23 May 2022 19:45:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ntC7J-0047dD-P9; Mon, 23 May 2022 19:45:16 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ntC7G-00BeVi-M1; Mon, 23 May 2022 19:45:14 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 3/3] pwm: Make capture support optional
Date:   Mon, 23 May 2022 19:45:02 +0200
Message-Id: <20220523174502.987113-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220523174502.987113-1-u.kleine-koenig@pengutronix.de>
References: <20220523174502.987113-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5988; h=from:subject; bh=jie8naGnqM/OMsAz089Z86F2v+KiF0bn9n7xQnB4CrY=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBii8ga0pttUA8v4/XRk93OT0BgdCeQq8NqFCsFYm0n qizbz+KJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYovIGgAKCRDB/BR4rcrsCbDqB/ 4rppm+nbCUrIgs8b2uvvlzxj4CNtPsL0U36jrq/vkkyNJDjRwcp+3g5wLNKOIkDy5bMXUhQnKIfpWO 7NAzCWSPaJVPwaWaUqhiL4IiQeZzY9KIjRV4t4Cp/7Qic3VnEtM9Qi+Nowg4m1yDa2GkhSYf8hIvpA K2L4yceh/YQlPxC6p9QjD89JsX60H/8g+WS/h1PH2r7wP8MtBmLv9oiDX/hXLOfOfUZV5MvHD4jYmG t/3bZwWMlJfh7hjForEAsoC2Bw7t1S4vmQeYlxazg8j1hj1+WSncHvfv0GQxKV3YbNPy4lOpCAMZtV PmSHyHydnemCWgKSnyNU1wNm97CjuN
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The only code making use of the capture functionality is the sysfs code
in the PWM framework. I suspect there are no real users and would like to
deprecate it in favor of the counter framework. So introduce a kconfig
symbol to remove the capture support and make the sysfs file a stub.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/Kconfig     | 12 ++++++++++++
 drivers/pwm/core.c      |  3 ++-
 drivers/pwm/pwm-sti.c   |  4 ++++
 drivers/pwm/pwm-stm32.c |  4 ++++
 drivers/pwm/sysfs.c     |  4 ++++
 include/linux/pwm.h     |  5 +++++
 6 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 904de8d61828..0686dbb07fa5 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -42,6 +42,18 @@ config PWM_DEBUG
 	  It is expected to introduce some runtime overhead and diagnostic
 	  output to the kernel log, so only enable while working on a driver.
 
+config PWM_CAPTURE
+	bool "PWM capture support"
+	help
+	  A few drivers support capturing an input PWM signal. This is unused
+	  by mainline drivers, and only exposed in sysfs. This doesn't match
+	  the main purpose of the PWM framework and there is a superior
+	  alternative (the counter framework) this might get removed at some
+	  point. So if you need it, select Y here and speak up about your
+	  use-case.
+
+	  If unsure, say no.
+
 config PWM_AB8500
 	tristate "AB8500 PWM support"
 	depends on AB8500_CORE && ARCH_U8500
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index c7552df32082..7bc47f94685f 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -668,6 +668,7 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 }
 EXPORT_SYMBOL_GPL(pwm_apply_state);
 
+#ifdef CONFIG_PWM_CAPTURE
 /**
  * pwm_capture() - capture and report a PWM signal
  * @pwm: PWM device
@@ -693,7 +694,7 @@ int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
 
 	return err;
 }
-EXPORT_SYMBOL_GPL(pwm_capture);
+#endif
 
 /**
  * pwm_adjust_config() - adjust the current PWM config to the PWM arguments
diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 44b1f93256b3..709dcf207291 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -309,6 +309,7 @@ static void sti_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	clear_bit(pwm->hwpwm, &pc->configured);
 }
 
+#ifdef CONFIG_PWM_CAPTURE
 static int sti_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 			   struct pwm_capture *result, unsigned long timeout)
 {
@@ -390,6 +391,7 @@ static int sti_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 	mutex_unlock(&ddata->lock);
 	return ret;
 }
+#endif
 
 static int sti_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			 const struct pwm_state *state)
@@ -417,7 +419,9 @@ static int sti_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 }
 
 static const struct pwm_ops sti_pwm_ops = {
+#ifdef CONFIG_PWM_CAPTURE
 	.capture = sti_pwm_capture,
+#endif
 	.apply = sti_pwm_apply,
 	.free = sti_pwm_free,
 	.owner = THIS_MODULE,
diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 794ca5b02968..da192a32b570 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -67,6 +67,7 @@ static int write_ccrx(struct stm32_pwm *dev, int ch, u32 value)
 	return -EINVAL;
 }
 
+#ifdef CONFIG_PWM_CAPTURE
 #define TIM_CCER_CC12P (TIM_CCER_CC1P | TIM_CCER_CC2P)
 #define TIM_CCER_CC12E (TIM_CCER_CC1E | TIM_CCER_CC2E)
 #define TIM_CCER_CC34P (TIM_CCER_CC3P | TIM_CCER_CC4P)
@@ -318,6 +319,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	return ret;
 }
+#endif
 
 static int stm32_pwm_config(struct stm32_pwm *priv, int ch,
 			    int duty_ns, int period_ns)
@@ -485,7 +487,9 @@ static int stm32_pwm_apply_locked(struct pwm_chip *chip, struct pwm_device *pwm,
 static const struct pwm_ops stm32pwm_ops = {
 	.owner = THIS_MODULE,
 	.apply = stm32_pwm_apply_locked,
+#ifdef CONFIG_PWM_CAPTURE
 	.capture = IS_ENABLED(CONFIG_DMA_ENGINE) ? stm32_pwm_capture : NULL,
+#endif
 };
 
 static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 9903c3a7eced..b74b8140308f 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -204,6 +204,7 @@ static ssize_t capture_show(struct device *child,
 			    struct device_attribute *attr,
 			    char *buf)
 {
+#ifdef CONFIG_PWM_CAPTURE
 	struct pwm_device *pwm = child_to_pwm_device(child);
 	struct pwm_capture result;
 	int ret;
@@ -213,6 +214,9 @@ static ssize_t capture_show(struct device *child,
 		return ret;
 
 	return sprintf(buf, "%u %u\n", result.period, result.duty_cycle);
+#else
+	return -ENOSYS;
+#endif
 }
 
 static DEVICE_ATTR_RW(period);
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 219db73956d1..d2d2be59beae 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -276,8 +276,10 @@ struct pwm_capture {
 struct pwm_ops {
 	int (*request)(struct pwm_chip *chip, struct pwm_device *pwm);
 	void (*free)(struct pwm_chip *chip, struct pwm_device *pwm);
+#ifdef CONFIG_PWM_CAPTURE
 	int (*capture)(struct pwm_chip *chip, struct pwm_device *pwm,
 		       struct pwm_capture *result, unsigned long timeout);
+#endif
 	int (*apply)(struct pwm_chip *chip, struct pwm_device *pwm,
 		     const struct pwm_state *state);
 	void (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -395,8 +397,11 @@ static inline void pwm_disable(struct pwm_device *pwm)
 }
 
 /* PWM provider APIs */
+#ifdef CONFIG_PWM_CAPTURE
 int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
 		unsigned long timeout);
+#endif
+
 int pwm_set_chip_data(struct pwm_device *pwm, void *data);
 void *pwm_get_chip_data(struct pwm_device *pwm);
 
-- 
2.35.1

