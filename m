Return-Path: <linux-pwm+bounces-2798-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D21B893102A
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 10:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600FE1F22083
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 08:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A56186E43;
	Mon, 15 Jul 2024 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhdyzPcL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2209B186E28;
	Mon, 15 Jul 2024 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721032805; cv=none; b=pyDkidqKktoEfGNyIj2zJn3C38kbbz+PjrLEuMYhELqK9uXafHv2BsMG2YzXgz0xWhCYDYAh2Msvs2RcMG0jV2BhpTTJnPTXY9W6DJq6ogZ76Vltzt3Fx1LjN3wPrkVAhemamXVHiTwatdSOHg4Rd/tEHG3AFcwd53UBCuYcp70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721032805; c=relaxed/simple;
	bh=TLn4iY9WirIpra11C90u3n8gyc+H+7TAKuLu1AUc2WY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AoqbpcUqqRBZNs813EwXrO1Ama7hEJK+EtxmFnSOe00h+iwEzREaLBHkeXOxzetQ47BPhsvcYJnr+XbRIZ4+j4GmFpw46ux2Ve4epJktjflIIa9uy0pdKhCw4s/XT5ffhGhVHiL3l8K+SJdY7L4FwAPndWceanxue/EUxEN1OSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhdyzPcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1842C4AF65;
	Mon, 15 Jul 2024 08:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721032805;
	bh=TLn4iY9WirIpra11C90u3n8gyc+H+7TAKuLu1AUc2WY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JhdyzPcLTjs0J1c7jhPsFqiTZXF6+x4FrFnt/fQT+QoKvdR/ZQ2kk1hU1i90W689N
	 mlA0M04vEkedWTs4CQiDGVbtt0V4nBWaFyNBbBrXTk6FSwQzu4XGm2hEAAIKtEzrzf
	 Xs+Hc91PsLwaxF3LiU6aqvrUgiTF+V756k8RlC17+/s6LTLfvTsmMSZXeZoA6sjfMf
	 0iGDL80JRiKgmfcDv0szg0WbKE6mNxMzHLsNeh61smiZ5GSLE0QVAZWhwdUDFmRRCQ
	 +icJR6fYXWEuYOiAOfu6ZftpFFeE0DFtTaKHpgjvZqn3l/oyElfg0SijDVw8QnrWRz
	 3AKwJUZy4OOMQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8702C3DA59;
	Mon, 15 Jul 2024 08:40:04 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 15 Jul 2024 11:38:37 +0300
Subject: [PATCH v11 33/38] pwm: ep93xx: drop legacy pinctrl
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240715-ep93xx-v11-33-4e924efda795@maquefel.me>
References: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me>
In-Reply-To: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me>
To: Hartley Sweeten <hsweeten@visionengravers.com>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Nikita Shubin <nikita.shubin@maquefel.me>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Sergey Shtylyov <s.shtylyov@omp.ru>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721032800; l=4449;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=9tWs5wPLeKECQlcQ9rkIh26LRGvwgfxOpMK+JfxreaE=;
 b=qRTr7TBUoWCa+2fq+nDOeJXUxuaasbBBBlRoqSicurr/ryj0YAZVf8iLuc+fe0aJkoPgAf9qYf+l
 X3bZoYBlBT57fTBtb/PA/GT1lb1jmFadTlOE2i7t6k2/eXFBgL2x
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

Drop legacy gpio request/free since we are using
pinctrl for this now.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ep93xx/core.c       | 42 ---------------------------------------
 drivers/pwm/pwm-ep93xx.c          | 18 -----------------
 include/linux/soc/cirrus/ep93xx.h |  4 ----
 3 files changed, 64 deletions(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index b99c46d22c4d..4ddf1a4cba33 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -577,48 +577,6 @@ void __init ep93xx_register_pwm(int pwm0, int pwm1)
 		platform_device_register(&ep93xx_pwm1_device);
 }
 
-int ep93xx_pwm_acquire_gpio(struct platform_device *pdev)
-{
-	int err;
-
-	if (pdev->id == 0) {
-		err = 0;
-	} else if (pdev->id == 1) {
-		err = gpio_request(EP93XX_GPIO_LINE_EGPIO14,
-				   dev_name(&pdev->dev));
-		if (err)
-			return err;
-		err = gpio_direction_output(EP93XX_GPIO_LINE_EGPIO14, 0);
-		if (err)
-			goto fail;
-
-		/* PWM 1 output on EGPIO[14] */
-		ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_PONG);
-	} else {
-		err = -ENODEV;
-	}
-
-	return err;
-
-fail:
-	gpio_free(EP93XX_GPIO_LINE_EGPIO14);
-	return err;
-}
-EXPORT_SYMBOL(ep93xx_pwm_acquire_gpio);
-
-void ep93xx_pwm_release_gpio(struct platform_device *pdev)
-{
-	if (pdev->id == 1) {
-		gpio_direction_input(EP93XX_GPIO_LINE_EGPIO14);
-		gpio_free(EP93XX_GPIO_LINE_EGPIO14);
-
-		/* EGPIO[14] used for GPIO */
-		ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_PONG);
-	}
-}
-EXPORT_SYMBOL(ep93xx_pwm_release_gpio);
-
-
 /*************************************************************************
  * EP93xx video peripheral handling
  *************************************************************************/
diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
index 67c3fdbf7ae3..994f89ac43b4 100644
--- a/drivers/pwm/pwm-ep93xx.c
+++ b/drivers/pwm/pwm-ep93xx.c
@@ -27,8 +27,6 @@
 
 #include <asm/div64.h>
 
-#include <linux/soc/cirrus/ep93xx.h>	/* for ep93xx_pwm_{acquire,release}_gpio() */
-
 #define EP93XX_PWMx_TERM_COUNT	0x00
 #define EP93XX_PWMx_DUTY_CYCLE	0x04
 #define EP93XX_PWMx_ENABLE	0x08
@@ -44,20 +42,6 @@ static inline struct ep93xx_pwm *to_ep93xx_pwm(struct pwm_chip *chip)
 	return pwmchip_get_drvdata(chip);
 }
 
-static int ep93xx_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct platform_device *pdev = to_platform_device(pwmchip_parent(chip));
-
-	return ep93xx_pwm_acquire_gpio(pdev);
-}
-
-static void ep93xx_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct platform_device *pdev = to_platform_device(pwmchip_parent(chip));
-
-	ep93xx_pwm_release_gpio(pdev);
-}
-
 static int ep93xx_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			    const struct pwm_state *state)
 {
@@ -156,8 +140,6 @@ static int ep93xx_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 }
 
 static const struct pwm_ops ep93xx_pwm_ops = {
-	.request = ep93xx_pwm_request,
-	.free = ep93xx_pwm_free,
 	.apply = ep93xx_pwm_apply,
 };
 
diff --git a/include/linux/soc/cirrus/ep93xx.h b/include/linux/soc/cirrus/ep93xx.h
index 8942bfaf1545..f6376edc1b33 100644
--- a/include/linux/soc/cirrus/ep93xx.h
+++ b/include/linux/soc/cirrus/ep93xx.h
@@ -37,8 +37,6 @@ struct ep93xx_regmap_adev {
 	container_of((_adev), struct ep93xx_regmap_adev, adev)
 
 #ifdef CONFIG_ARCH_EP93XX
-int ep93xx_pwm_acquire_gpio(struct platform_device *pdev);
-void ep93xx_pwm_release_gpio(struct platform_device *pdev);
 int ep93xx_ide_acquire_gpio(struct platform_device *pdev);
 void ep93xx_ide_release_gpio(struct platform_device *pdev);
 int ep93xx_i2s_acquire(void);
@@ -46,8 +44,6 @@ void ep93xx_i2s_release(void);
 unsigned int ep93xx_chip_revision(void);
 
 #else
-static inline int ep93xx_pwm_acquire_gpio(struct platform_device *pdev) { return 0; }
-static inline void ep93xx_pwm_release_gpio(struct platform_device *pdev) {}
 static inline int ep93xx_ide_acquire_gpio(struct platform_device *pdev) { return 0; }
 static inline void ep93xx_ide_release_gpio(struct platform_device *pdev) {}
 static inline int ep93xx_i2s_acquire(void) { return 0; }

-- 
2.43.2



