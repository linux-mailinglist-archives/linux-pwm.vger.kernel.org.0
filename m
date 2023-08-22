Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EED7844D4
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Aug 2023 16:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbjHVO4s (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Aug 2023 10:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236994AbjHVO4s (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Aug 2023 10:56:48 -0400
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4491E126;
        Tue, 22 Aug 2023 07:56:46 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 9D5C21000CF; Tue, 22 Aug 2023 15:56:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1692716204; bh=PBQsppeEQf9CLGbA3nVtyxod687pgnw/ziALrDWwy8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ryJPv/ztLG67vUsRjICGcH7g5ZzEq7ABxwwVlbaBYkr7blWYbWmX1QZe+grrJk2dt
         PBAnDTZvi6ryWofWnhmVief3ERnBCsFat8y9j6k7iH1bKa0nIMX57UM8ZH3XPyzuyr
         8KDTsxwnC3ogAcEGGgVRkbzucNmbGAoH3Hyjj/flEUf8z/J+nfLFavaEG+ScyUzexw
         TVYhBvzfFbWrk9FD8Ep628hWPifEQNgKZRgnulOuDrTQxaBJoYlOSKsz9aGMfVLnQ6
         W1BcfoOqoDo+mJSGJO4jag62VrOBYWcBsc8nCJlppKAOEj7N3LzjDm7SnRun1KYxGK
         xbcg54+HVYeoQ==
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Cc:     "Sicelo A . Mhlongo" <absicsz@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Timo Kokkonen <timo.t.kokkonen@iki.fi>
Subject: [PATCH v3 1/2] media: rc: remove ir-rx51 in favour of generic pwm-ir-tx
Date:   Tue, 22 Aug 2023 15:56:43 +0100
Message-Id: <20230822145644.213589-2-sean@mess.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230822145644.213589-1-sean@mess.org>
References: <20230822145644.213589-1-sean@mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The ir-rx51 is a pwm-based TX driver specific to the N900. This can be
handled entirely by the generic pwm-ir-tx driver, and in fact the
pwm-ir-tx driver has been compatible with ir-rx51 from the start.

Note that the suspend code in the ir-rx51 driver is unnecessary, since
during transmit, the process is not in interruptable sleep. The process
is not put to sleep until the transmit completes.

Tested-by: Sicelo A. Mhlongo <absicsz@gmail.com>
Signed-off-by: Sean Young <sean@mess.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-pwm@vger.kernel.org
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Pali Rohár <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Timo Kokkonen <timo.t.kokkonen@iki.fi>
---
 arch/arm/configs/omap2plus_defconfig |   1 -
 drivers/media/rc/Kconfig             |  10 -
 drivers/media/rc/Makefile            |   1 -
 drivers/media/rc/ir-rx51.c           | 285 ---------------------------
 drivers/media/rc/pwm-ir-tx.c         |   1 +
 5 files changed, 1 insertion(+), 297 deletions(-)
 delete mode 100644 drivers/media/rc/ir-rx51.c

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 9bd36dd39bd0..b4e3a6d7b606 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -484,7 +484,6 @@ CONFIG_LIRC=y
 CONFIG_RC_DEVICES=y
 CONFIG_IR_GPIO_TX=m
 CONFIG_IR_PWM_TX=m
-CONFIG_IR_RX51=m
 CONFIG_IR_SPI=m
 CONFIG_MEDIA_SUPPORT=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
diff --git a/drivers/media/rc/Kconfig b/drivers/media/rc/Kconfig
index 07bdf649c60d..2afe67ffa285 100644
--- a/drivers/media/rc/Kconfig
+++ b/drivers/media/rc/Kconfig
@@ -338,16 +338,6 @@ config IR_REDRAT3
 	   To compile this driver as a module, choose M here: the
 	   module will be called redrat3.
 
-config IR_RX51
-	tristate "Nokia N900 IR transmitter diode"
-	depends on (OMAP_DM_TIMER && PWM_OMAP_DMTIMER && ARCH_OMAP2PLUS || COMPILE_TEST) && RC_CORE
-	help
-	   Say Y or M here if you want to enable support for the IR
-	   transmitter diode built in the Nokia N900 (RX51) device.
-
-	   The driver uses omap DM timers for generating the carrier
-	   wave and pulses.
-
 config IR_SERIAL
 	tristate "Homebrew Serial Port Receiver"
 	depends on HAS_IOPORT
diff --git a/drivers/media/rc/Makefile b/drivers/media/rc/Makefile
index a9285266e944..2bca6f7f07bc 100644
--- a/drivers/media/rc/Makefile
+++ b/drivers/media/rc/Makefile
@@ -43,7 +43,6 @@ obj-$(CONFIG_IR_MTK) += mtk-cir.o
 obj-$(CONFIG_IR_NUVOTON) += nuvoton-cir.o
 obj-$(CONFIG_IR_PWM_TX) += pwm-ir-tx.o
 obj-$(CONFIG_IR_REDRAT3) += redrat3.o
-obj-$(CONFIG_IR_RX51) += ir-rx51.o
 obj-$(CONFIG_IR_SERIAL) += serial_ir.o
 obj-$(CONFIG_IR_SPI) += ir-spi.o
 obj-$(CONFIG_IR_STREAMZAP) += streamzap.o
diff --git a/drivers/media/rc/ir-rx51.c b/drivers/media/rc/ir-rx51.c
deleted file mode 100644
index 13e81bf8005d..000000000000
--- a/drivers/media/rc/ir-rx51.c
+++ /dev/null
@@ -1,285 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  Copyright (C) 2008 Nokia Corporation
- *
- *  Based on lirc_serial.c
- */
-#include <linux/clk.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/wait.h>
-#include <linux/pwm.h>
-#include <linux/of.h>
-#include <linux/hrtimer.h>
-
-#include <media/rc-core.h>
-
-#define WBUF_LEN 256
-
-struct ir_rx51 {
-	struct rc_dev *rcdev;
-	struct pwm_device *pwm;
-	struct pwm_state state;
-	struct hrtimer timer;
-	struct device	     *dev;
-	wait_queue_head_t     wqueue;
-
-	unsigned int	freq;		/* carrier frequency */
-	unsigned int	duty_cycle;	/* carrier duty cycle */
-	int		wbuf[WBUF_LEN];
-	int		wbuf_index;
-	unsigned long	device_is_open;
-};
-
-static inline void ir_rx51_on(struct ir_rx51 *ir_rx51)
-{
-	ir_rx51->state.enabled = true;
-	pwm_apply_state(ir_rx51->pwm, &ir_rx51->state);
-}
-
-static inline void ir_rx51_off(struct ir_rx51 *ir_rx51)
-{
-	ir_rx51->state.enabled = false;
-	pwm_apply_state(ir_rx51->pwm, &ir_rx51->state);
-}
-
-static int init_timing_params(struct ir_rx51 *ir_rx51)
-{
-	ir_rx51->state.period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, ir_rx51->freq);
-	pwm_set_relative_duty_cycle(&ir_rx51->state, ir_rx51->duty_cycle, 100);
-
-	return 0;
-}
-
-static enum hrtimer_restart ir_rx51_timer_cb(struct hrtimer *timer)
-{
-	struct ir_rx51 *ir_rx51 = container_of(timer, struct ir_rx51, timer);
-	ktime_t now;
-
-	if (ir_rx51->wbuf_index < 0) {
-		dev_err_ratelimited(ir_rx51->dev,
-				    "BUG wbuf_index has value of %i\n",
-				    ir_rx51->wbuf_index);
-		goto end;
-	}
-
-	/*
-	 * If we happen to hit an odd latency spike, loop through the
-	 * pulses until we catch up.
-	 */
-	do {
-		u64 ns;
-
-		if (ir_rx51->wbuf_index >= WBUF_LEN)
-			goto end;
-		if (ir_rx51->wbuf[ir_rx51->wbuf_index] == -1)
-			goto end;
-
-		if (ir_rx51->wbuf_index % 2)
-			ir_rx51_off(ir_rx51);
-		else
-			ir_rx51_on(ir_rx51);
-
-		ns = US_TO_NS(ir_rx51->wbuf[ir_rx51->wbuf_index]);
-		hrtimer_add_expires_ns(timer, ns);
-
-		ir_rx51->wbuf_index++;
-
-		now = timer->base->get_time();
-
-	} while (hrtimer_get_expires_tv64(timer) < now);
-
-	return HRTIMER_RESTART;
-end:
-	/* Stop TX here */
-	ir_rx51_off(ir_rx51);
-	ir_rx51->wbuf_index = -1;
-
-	wake_up_interruptible(&ir_rx51->wqueue);
-
-	return HRTIMER_NORESTART;
-}
-
-static int ir_rx51_tx(struct rc_dev *dev, unsigned int *buffer,
-		      unsigned int count)
-{
-	struct ir_rx51 *ir_rx51 = dev->priv;
-
-	if (count > WBUF_LEN)
-		return -EINVAL;
-
-	memcpy(ir_rx51->wbuf, buffer, count * sizeof(unsigned int));
-
-	/* Wait any pending transfers to finish */
-	wait_event_interruptible(ir_rx51->wqueue, ir_rx51->wbuf_index < 0);
-
-	init_timing_params(ir_rx51);
-	if (count < WBUF_LEN)
-		ir_rx51->wbuf[count] = -1; /* Insert termination mark */
-
-	/*
-	 * REVISIT: Adjust latency requirements so the device doesn't go in too
-	 * deep sleep states with pm_qos_add_request().
-	 */
-
-	ir_rx51_on(ir_rx51);
-	ir_rx51->wbuf_index = 1;
-	hrtimer_start(&ir_rx51->timer,
-		      ns_to_ktime(US_TO_NS(ir_rx51->wbuf[0])),
-		      HRTIMER_MODE_REL);
-	/*
-	 * Don't return back to the userspace until the transfer has
-	 * finished
-	 */
-	wait_event_interruptible(ir_rx51->wqueue, ir_rx51->wbuf_index < 0);
-
-	/* REVISIT: Remove pm_qos constraint, we can sleep again */
-
-	return count;
-}
-
-static int ir_rx51_open(struct rc_dev *dev)
-{
-	struct ir_rx51 *ir_rx51 = dev->priv;
-
-	if (test_and_set_bit(1, &ir_rx51->device_is_open))
-		return -EBUSY;
-
-	ir_rx51->pwm = pwm_get(ir_rx51->dev, NULL);
-	if (IS_ERR(ir_rx51->pwm)) {
-		int res = PTR_ERR(ir_rx51->pwm);
-
-		dev_err(ir_rx51->dev, "pwm_get failed: %d\n", res);
-		return res;
-	}
-
-	return 0;
-}
-
-static void ir_rx51_release(struct rc_dev *dev)
-{
-	struct ir_rx51 *ir_rx51 = dev->priv;
-
-	hrtimer_cancel(&ir_rx51->timer);
-	ir_rx51_off(ir_rx51);
-	pwm_put(ir_rx51->pwm);
-
-	clear_bit(1, &ir_rx51->device_is_open);
-}
-
-static struct ir_rx51 ir_rx51 = {
-	.duty_cycle	= 50,
-	.wbuf_index	= -1,
-};
-
-static int ir_rx51_set_duty_cycle(struct rc_dev *dev, u32 duty)
-{
-	struct ir_rx51 *ir_rx51 = dev->priv;
-
-	ir_rx51->duty_cycle = duty;
-
-	return 0;
-}
-
-static int ir_rx51_set_tx_carrier(struct rc_dev *dev, u32 carrier)
-{
-	struct ir_rx51 *ir_rx51 = dev->priv;
-
-	if (carrier > 500000 || carrier < 20000)
-		return -EINVAL;
-
-	ir_rx51->freq = carrier;
-
-	return 0;
-}
-
-#ifdef CONFIG_PM
-
-static int ir_rx51_suspend(struct platform_device *dev, pm_message_t state)
-{
-	/*
-	 * In case the device is still open, do not suspend. Normally
-	 * this should not be a problem as lircd only keeps the device
-	 * open only for short periods of time. We also don't want to
-	 * get involved with race conditions that might happen if we
-	 * were in a middle of a transmit. Thus, we defer any suspend
-	 * actions until transmit has completed.
-	 */
-	if (test_and_set_bit(1, &ir_rx51.device_is_open))
-		return -EAGAIN;
-
-	clear_bit(1, &ir_rx51.device_is_open);
-
-	return 0;
-}
-
-static int ir_rx51_resume(struct platform_device *dev)
-{
-	return 0;
-}
-
-#else
-
-#define ir_rx51_suspend	NULL
-#define ir_rx51_resume	NULL
-
-#endif /* CONFIG_PM */
-
-static int ir_rx51_probe(struct platform_device *dev)
-{
-	struct pwm_device *pwm;
-	struct rc_dev *rcdev;
-
-	pwm = pwm_get(&dev->dev, NULL);
-	if (IS_ERR(pwm))
-		return dev_err_probe(&dev->dev, PTR_ERR(pwm), "pwm_get failed\n");
-
-	/* Use default, in case userspace does not set the carrier */
-	ir_rx51.freq = DIV_ROUND_CLOSEST_ULL(pwm_get_period(pwm), NSEC_PER_SEC);
-	pwm_init_state(pwm, &ir_rx51.state);
-	pwm_put(pwm);
-
-	hrtimer_init(&ir_rx51.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	ir_rx51.timer.function = ir_rx51_timer_cb;
-
-	ir_rx51.dev = &dev->dev;
-
-	rcdev = devm_rc_allocate_device(&dev->dev, RC_DRIVER_IR_RAW_TX);
-	if (!rcdev)
-		return -ENOMEM;
-
-	rcdev->priv = &ir_rx51;
-	rcdev->open = ir_rx51_open;
-	rcdev->close = ir_rx51_release;
-	rcdev->tx_ir = ir_rx51_tx;
-	rcdev->s_tx_duty_cycle = ir_rx51_set_duty_cycle;
-	rcdev->s_tx_carrier = ir_rx51_set_tx_carrier;
-	rcdev->driver_name = KBUILD_MODNAME;
-
-	ir_rx51.rcdev = rcdev;
-
-	return devm_rc_register_device(&dev->dev, ir_rx51.rcdev);
-}
-
-static const struct of_device_id ir_rx51_match[] = {
-	{
-		.compatible = "nokia,n900-ir",
-	},
-	{},
-};
-MODULE_DEVICE_TABLE(of, ir_rx51_match);
-
-static struct platform_driver ir_rx51_platform_driver = {
-	.probe		= ir_rx51_probe,
-	.suspend	= ir_rx51_suspend,
-	.resume		= ir_rx51_resume,
-	.driver		= {
-		.name	= KBUILD_MODNAME,
-		.of_match_table = ir_rx51_match,
-	},
-};
-module_platform_driver(ir_rx51_platform_driver);
-
-MODULE_DESCRIPTION("IR TX driver for Nokia RX51");
-MODULE_AUTHOR("Nokia Corporation");
-MODULE_LICENSE("GPL");
diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
index 7732054c4621..c5f37c03af9c 100644
--- a/drivers/media/rc/pwm-ir-tx.c
+++ b/drivers/media/rc/pwm-ir-tx.c
@@ -23,6 +23,7 @@ struct pwm_ir {
 
 static const struct of_device_id pwm_ir_of_match[] = {
 	{ .compatible = "pwm-ir-tx", },
+	{ .compatible = "nokia,n900-ir" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, pwm_ir_of_match);
-- 
2.41.0

