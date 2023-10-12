Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9457C72C6
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347327AbjJLQbR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379610AbjJLQbB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:01 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A4DD3
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:30:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaQ-0004xM-CO; Thu, 12 Oct 2023 18:30:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaP-001C7Z-V0; Thu, 12 Oct 2023 18:30:57 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaP-00F5OV-M2; Thu, 12 Oct 2023 18:30:57 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 036/109] pwm: vt8500: Make use of pwmchip_parent() macro
Date:   Thu, 12 Oct 2023 18:29:04 +0200
Message-ID: <20231012162827.1002444-147-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3929; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=zhXjRG6kPkwsKyJdTkY5kxiF11Z3mfQ6zxIWD9AQjl0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB7WkgW1eN3Ag6HnZanmXbo3unfuyGN6+imRS BpGh54cwQaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSge1gAKCRCPgPtYfRL+ TuGLCACMXhdpezz8nBfWiYtut8FdjYKUbuUi79wvUPQIxKXK55CRXIkAIVSdk4GNLu02E9rGSKQ eEaO48QvqdrlII9f5qy0XuT9iC4q35nYuZuhW7hEMc2LHjUtqvf7dLROrpdlpQmpkrKmJoXwACm oLWImFcumanZ48GokWHfZn0LYPUmmVZ9lVs+PlWa4EV/WHvHmj8vjzr4oqGVihkRNh5TjZt3rkK xAssGmq1q+VAPQTYLd5UXSXC0OoOueaQwr5EB6XH1H1TB587Ra1WhiWIYDV3e7GUOzyieIugoom iHVYcdRJrrDW4stoRpNj8RITmMf+pyccHp2E7P5D2zKtUYnH
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the macro
provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-vt8500.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index 5568d5312d3c..16046f936d98 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -53,8 +53,9 @@ struct vt8500_chip {
 #define to_vt8500_chip(chip)	container_of(chip, struct vt8500_chip, chip)
 
 #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
-static inline void vt8500_pwm_busy_wait(struct vt8500_chip *vt8500, int nr, u8 bitmask)
+static inline void vt8500_pwm_busy_wait(struct pwm_chip *chip, int nr, u8 bitmask)
 {
+	struct vt8500_chip *vt8500 = to_vt8500_chip(chip);
 	int loops = msecs_to_loops(10);
 	u32 mask = bitmask << (nr << 8);
 
@@ -62,7 +63,7 @@ static inline void vt8500_pwm_busy_wait(struct vt8500_chip *vt8500, int nr, u8 b
 		cpu_relax();
 
 	if (unlikely(!loops))
-		dev_warn(vt8500->chip.dev, "Waiting for status bits 0x%x to clear timed out\n",
+		dev_warn(pwmchip_parent(chip), "Waiting for status bits 0x%x to clear timed out\n",
 			 mask);
 }
 
@@ -77,7 +78,7 @@ static int vt8500_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	err = clk_enable(vt8500->clk);
 	if (err < 0) {
-		dev_err(chip->dev, "failed to enable clock\n");
+		dev_err(pwmchip_parent(chip), "failed to enable clock\n");
 		return err;
 	}
 
@@ -103,18 +104,18 @@ static int vt8500_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	dc = div64_u64(c, period_ns);
 
 	writel(prescale, vt8500->base + REG_SCALAR(pwm->hwpwm));
-	vt8500_pwm_busy_wait(vt8500, pwm->hwpwm, STATUS_SCALAR_UPDATE);
+	vt8500_pwm_busy_wait(chip, pwm->hwpwm, STATUS_SCALAR_UPDATE);
 
 	writel(pv, vt8500->base + REG_PERIOD(pwm->hwpwm));
-	vt8500_pwm_busy_wait(vt8500, pwm->hwpwm, STATUS_PERIOD_UPDATE);
+	vt8500_pwm_busy_wait(chip, pwm->hwpwm, STATUS_PERIOD_UPDATE);
 
 	writel(dc, vt8500->base + REG_DUTY(pwm->hwpwm));
-	vt8500_pwm_busy_wait(vt8500, pwm->hwpwm, STATUS_DUTY_UPDATE);
+	vt8500_pwm_busy_wait(chip, pwm->hwpwm, STATUS_DUTY_UPDATE);
 
 	val = readl(vt8500->base + REG_CTRL(pwm->hwpwm));
 	val |= CTRL_AUTOLOAD;
 	writel(val, vt8500->base + REG_CTRL(pwm->hwpwm));
-	vt8500_pwm_busy_wait(vt8500, pwm->hwpwm, STATUS_CTRL_UPDATE);
+	vt8500_pwm_busy_wait(chip, pwm->hwpwm, STATUS_CTRL_UPDATE);
 
 	clk_disable(vt8500->clk);
 	return 0;
@@ -128,14 +129,14 @@ static int vt8500_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	err = clk_enable(vt8500->clk);
 	if (err < 0) {
-		dev_err(chip->dev, "failed to enable clock\n");
+		dev_err(pwmchip_parent(chip), "failed to enable clock\n");
 		return err;
 	}
 
 	val = readl(vt8500->base + REG_CTRL(pwm->hwpwm));
 	val |= CTRL_ENABLE;
 	writel(val, vt8500->base + REG_CTRL(pwm->hwpwm));
-	vt8500_pwm_busy_wait(vt8500, pwm->hwpwm, STATUS_CTRL_UPDATE);
+	vt8500_pwm_busy_wait(chip, pwm->hwpwm, STATUS_CTRL_UPDATE);
 
 	return 0;
 }
@@ -148,7 +149,7 @@ static void vt8500_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	val = readl(vt8500->base + REG_CTRL(pwm->hwpwm));
 	val &= ~CTRL_ENABLE;
 	writel(val, vt8500->base + REG_CTRL(pwm->hwpwm));
-	vt8500_pwm_busy_wait(vt8500, pwm->hwpwm, STATUS_CTRL_UPDATE);
+	vt8500_pwm_busy_wait(chip, pwm->hwpwm, STATUS_CTRL_UPDATE);
 
 	clk_disable(vt8500->clk);
 }
@@ -168,7 +169,7 @@ static int vt8500_pwm_set_polarity(struct pwm_chip *chip,
 		val &= ~CTRL_INVERT;
 
 	writel(val, vt8500->base + REG_CTRL(pwm->hwpwm));
-	vt8500_pwm_busy_wait(vt8500, pwm->hwpwm, STATUS_CTRL_UPDATE);
+	vt8500_pwm_busy_wait(chip, pwm->hwpwm, STATUS_CTRL_UPDATE);
 
 	return 0;
 }
-- 
2.42.0

