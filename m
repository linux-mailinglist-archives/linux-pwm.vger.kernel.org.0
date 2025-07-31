Return-Path: <linux-pwm+bounces-6916-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8789BB16DE7
	for <lists+linux-pwm@lfdr.de>; Thu, 31 Jul 2025 10:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7B9A7AFFDE
	for <lists+linux-pwm@lfdr.de>; Thu, 31 Jul 2025 08:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00021DA5F;
	Thu, 31 Jul 2025 08:47:37 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F401E7C19
	for <linux-pwm@vger.kernel.org>; Thu, 31 Jul 2025 08:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753951657; cv=none; b=KfHfYIv4P6ioY3FX1jHd99/Sw4yJQhTIbVVIYfdaWQifNbGCpJIXrA46KTo8YKuxRk4wrnWyOIsffKs6I7/ax4cGRyrnPovB8ytLbHHYl7IahjFSsRG7kLB6Ym+VY0+mn0OV7JoOLoeC2HEfD2NC+uX5lnyrNn4Vys/yumkBHO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753951657; c=relaxed/simple;
	bh=bOmDtkbd0RHffi0gOqZgUXs/Axzd8xlgdMd6KON8a7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jyZNY3KrNT9DW04S5s0zjVVy4yUwFU05WHDmQRwqMzPLyCVRKolP0RkjwFXf9aZhg72EofAggiqDEGtEgUonDnE5BB1DpizLO3ZM8Mv8H82Ona5EL6KqAAy22twR7BhyJ4TXEeWmJQzuIYLowujvFAE9GjkDAeR8GxTvvk4tMCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1uhOwf-0007I2-K4; Thu, 31 Jul 2025 10:47:25 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1uhOwf-00BBL9-0K;
	Thu, 31 Jul 2025 10:47:25 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1uhOwf-00ENqd-05;
	Thu, 31 Jul 2025 10:47:25 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Thu, 31 Jul 2025 10:47:18 +0200
Subject: [PATCH] backlight: pwm_bl: apply the initial backlight state with
 sane defaults
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-blpwm-v1-1-0171fd31bff9@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAJUti2gC/x2MSQqAMBDAviJztmBd0PoV8dBl1IFapcUFxL87e
 EwIeSBhJEzQZw9EPCnRFhhknoFddJhRkGOGsiiboq2kMH6/VtGoDq12qrK1A26NTihM1MEuXIf
 De5Z7xInufz6M7/sBizVVlWwAAAA=
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: Pengutronix <kernel@pengutronix.de>, linux-pwm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2042;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=bOmDtkbd0RHffi0gOqZgUXs/Axzd8xlgdMd6KON8a7Q=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBoiy2c+7jsNb6oW5if001bv1SF04cbIfTveDwqA
 ZfjiWLs9MGJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCaIstnAAKCRC/aVhE+XH0
 q6+LD/9G4mbLXal5Mo9BUyS72SWmZYnXX6CGHACo9HiLFRQbANW9bJZ2oYPp8n4oRljM2RxnkyY
 uQ3mPrdwE9FEkfAi3YyKM0Mob0T7Smci66r1iN0raJeaw8g6i6m7gWf4eRs4Tm0OsNlIxBMHk15
 9HN3yx8AlShEwY73dSy9CGT8Kc03A+TwvLVep4ykNtkCoH5g9cji9ydU4bzB8Bl/NLGqs/bepmS
 RLxuhkQlgLQCk766Dlwafm11I6aez3Zc1g70WcHu+Fq+Qd2cE8T5HRMivBDLhfmT1yToRZNq/q+
 m1qj0RKXlwva2E9TW/WZve8WVqemfJBPzCkws3tY21mumDA8Iz5NYaoBt/LBCa1epp6ProOjfBl
 WZ0LOXicoP+q8vtx9i4A0Nl/eiLXk/ptox2fV2ldQe5gktJ+d3FaydcbR+PyRUCRh+oAV+c7Ha7
 LWb4rV+l42E8yF3CzqXbVggxZLys0m87b2BgCD1NuYX0xS1Y+YeOWzqVlHwgqNGZy+x38Bexpwe
 p1dsZXM8Vte16ZVjCNqkyjjbfOkwmmVHVJ2Qj+r/4S0HSW5Zzso9sC59dOeuknyNXcJ1L+tzaeq
 Cj3p/KLVrl8lXZjJHtcXI728PonvVXv8Vj2XZy+WrJfF+UtFl0t2sbLT7/BlXyznTp1x/LfryY9
 vITN1nvyJzpWTkA==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Currently when calling pwm_apply_might_sleep in the probe routine
the pwm will be configured with an not fully defined state.

The duty_cycle is not yet set in that moment. There is a final
backlight_update_status call that will have a properly setup state.
However this change in the backlight can create a short flicker if the
backlight was already preinitialised.

We fix the flicker by moving the pwm_apply after the default duty_cycle
can be calculated.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/video/backlight/pwm_bl.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 237d3d3f3bb1a..5924e0b9f01e7 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -518,13 +518,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	if (!state.period && (data->pwm_period_ns > 0))
 		state.period = data->pwm_period_ns;
 
-	ret = pwm_apply_might_sleep(pb->pwm, &state);
-	if (ret) {
-		dev_err_probe(&pdev->dev, ret,
-			      "failed to apply initial PWM state");
-		goto err_alloc;
-	}
-
 	memset(&props, 0, sizeof(struct backlight_properties));
 
 	if (data->levels) {
@@ -582,6 +575,15 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	pb->lth_brightness = data->lth_brightness * (div_u64(state.period,
 				pb->scale));
 
+	state.duty_cycle = compute_duty_cycle(pb, data->dft_brightness, &state);
+
+	ret = pwm_apply_might_sleep(pb->pwm, &state);
+	if (ret) {
+		dev_err_probe(&pdev->dev, ret,
+			      "failed to apply initial PWM state");
+		goto err_alloc;
+	}
+
 	props.type = BACKLIGHT_RAW;
 	props.max_brightness = data->max_brightness;
 	bl = backlight_device_register(dev_name(&pdev->dev), &pdev->dev, pb,

---
base-commit: 739a6c93cc755c0daf3a7e57e018a8c61047cd90
change-id: 20250731-blpwm-598ecad93c4d

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>


