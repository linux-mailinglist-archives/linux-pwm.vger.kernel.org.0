Return-Path: <linux-pwm+bounces-34-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 995E17F2F73
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A9CFB211AE
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2C9537F5;
	Tue, 21 Nov 2023 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2240510EB
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:54 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAO-0005P2-5Q; Tue, 21 Nov 2023 14:51:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAN-00Aayd-OQ; Tue, 21 Nov 2023 14:51:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAN-004xcx-FZ; Tue, 21 Nov 2023 14:51:51 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 035/108] pwm: vt8500: Make use of pwmchip_parent() macro
Date: Tue, 21 Nov 2023 14:49:37 +0100
Message-ID: <20231121134901.208535-36-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3929; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=zhXjRG6kPkwsKyJdTkY5kxiF11Z3mfQ6zxIWD9AQjl0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLVzkgW1eN3Ag6HnZanmXbo3unfuyGN6+imRS BpGh54cwQaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1cwAKCRCPgPtYfRL+ TilgB/9sGwo9fklM+4qQLVzz/moyYU3zeUBWQnccAnJ3g+LwR0K1VnIkGeR2NRikU0Io8tnBjtR fMu3ec50HAm3hdZO6ZN98gQaCqkjjc8yQTAWVsB6rrya6+tC5fPfbhp3bZbTRGGkg53wflEJzc/ bSF3JTihbNr+Xkwlb2ft1fVyM1BVHcAm37QytXs37AbLXk1oR+Ih3h9s/E54n2vPlZ5dGaV3dNP vapViVoXtTJoa+2a4LQMqhrJWB1I9lqSDTzQqM9Iqf8GFI+oilPnU1ZDgEo6rx0xm+qaWATYVRr nsDhnGIEAL5NSY+098BdQjOe5nr3kSVz9KpymUMjzFP2nOHo
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

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


