Return-Path: <linux-pwm+bounces-275-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F67880081E
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Dec 2023 11:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E60D4281085
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Dec 2023 10:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D791DFFC;
	Fri,  1 Dec 2023 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYYHniC0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E35DC
	for <linux-pwm@vger.kernel.org>; Fri,  1 Dec 2023 02:23:01 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40b3e7f2fd9so18191315e9.0
        for <linux-pwm@vger.kernel.org>; Fri, 01 Dec 2023 02:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701426180; x=1702030980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jk3WHOjngBq6EQqXs+w5HnLqnHD2zHVqGksp8gIPU10=;
        b=iYYHniC0fYdpwoT5XY9SxGbjylZNSvV1MTyGil+o+mj9UuoKESaB37zsuHuWB6Ei39
         OtzriaQNdEBQDAhItqR6MqmEPK3ADP1hz3vAAv4VYlp2WJ8UwjwxcPzB+XbkQN9DJEDi
         YL/mbharyqhk3RB3X//bVTt2RoDLJlEs/zdYn5tkzaY620VhG/9IAILOJ3dPQDSZJNWH
         R1RrZrPpHIrKqSZ+YScIocqgy56ZyqKColboQ0/vUQmFVQy/7/jQ6Vn5DK1NChx77ykp
         v5/adwyuwhtSjoW/Cwbhoz8hGBtu4jpNWec4aWKKo+p4t24d1sX79OVdrevihlQBz+1u
         tpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701426180; x=1702030980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jk3WHOjngBq6EQqXs+w5HnLqnHD2zHVqGksp8gIPU10=;
        b=Dijdy8XLCU4Zqk3DWYGs9wCmNVH7JnhdvefAJf7BLYl/a4tAv/m33trRksAzufchBi
         6m0XGEaBSbCd8l+3hAZyEx1dEtniFrzSmeaozx9hEFvBX0ld/ImJl9BU6o3oIBrTtp3k
         fsnT17saq3FI+iFiDny3L9QgA1v7Pse0d6szXuD5v+7t4Hm6e1UWsxJZcMmHxXBbTJLT
         PIXycV7nOMUGCbq/8gjwW16izTJw0QbeXTcSXP8qlMtovwvsr+g2X5UQd4WP5prdpEoL
         2vk50sSAXYUiSJBoJ4okstdSTaM9HZrBn7l5z67QRKXtEEnzBUhT6P0LTKoF0aU7+e0P
         o4Sg==
X-Gm-Message-State: AOJu0YwNK5eUlLSb9DQTlaF06jhFC7DSZuOHQu6GN0x4CGF4LlkFbkM9
	bGn4X7rU4HwWkgCBunD2NPQ9TLJ9Cxw=
X-Google-Smtp-Source: AGHT+IGFMGjc4rPdowvvsv20G1UHWU4qFU7ZgnqgO+Eur6OolAF51WDnb+UtAyhxBkVlvcwLwky82Q==
X-Received: by 2002:a05:600c:5121:b0:40b:4b29:aa3d with SMTP id o33-20020a05600c512100b0040b4b29aa3dmr210154wms.22.1701426179769;
        Fri, 01 Dec 2023 02:22:59 -0800 (PST)
Received: from localhost (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id q10-20020a5d61ca000000b00332cba50ac3sm3793099wrv.45.2023.12.01.02.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 02:22:59 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-pwm@vger.kernel.org
Subject: [PATCH v2] pwm: Stop referencing pwm->chip
Date: Fri,  1 Dec 2023 11:22:53 +0100
Message-ID: <20231201102253.2352419-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drivers have access to the chip via a function argument already, so
there is no need to reference it via the PWM device.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
Changes in v2:
- add missing cleanup in pwm-jz4740.c (Uwe)

 drivers/pwm/pwm-bcm-kona.c    | 2 +-
 drivers/pwm/pwm-img.c         | 2 +-
 drivers/pwm/pwm-jz4740.c      | 2 +-
 drivers/pwm/pwm-lpc18xx-sct.c | 2 +-
 drivers/pwm/pwm-lpc32xx.c     | 2 +-
 drivers/pwm/pwm-mediatek.c    | 2 +-
 drivers/pwm/pwm-renesas-tpu.c | 2 +-
 drivers/pwm/pwm-sti.c         | 2 +-
 drivers/pwm/pwm-stmpe.c       | 2 +-
 drivers/pwm/pwm-tegra.c       | 2 +-
 drivers/pwm/pwm-twl-led.c     | 4 ++--
 drivers/pwm/pwm-twl.c         | 4 ++--
 drivers/pwm/pwm-vt8500.c      | 2 +-
 13 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 15d6ed03c3ce..45046a5c20a5 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -260,7 +260,7 @@ static int kona_pwmc_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			return err;
 	}
 
-	err = kona_pwmc_config(pwm->chip, pwm, state->duty_cycle, state->period);
+	err = kona_pwmc_config(chip, pwm, state->duty_cycle, state->period);
 	if (err && !pwm->state.enabled)
 		clk_disable_unprepare(kp->clk);
 
diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index 0d218c0b690e..5965ac35b32e 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -196,7 +196,7 @@ static int img_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	err = img_pwm_config(pwm->chip, pwm, state->duty_cycle, state->period);
+	err = img_pwm_config(chip, pwm, state->duty_cycle, state->period);
 	if (err)
 		return err;
 
diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 73f96cef1662..80dcff237a15 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -123,7 +123,7 @@ static void jz4740_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			    const struct pwm_state *state)
 {
-	struct jz4740_pwm_chip *jz = to_jz4740(pwm->chip);
+	struct jz4740_pwm_chip *jz = to_jz4740(chip);
 	unsigned long long tmp = 0xffffull * NSEC_PER_SEC;
 	struct clk *clk = jz->clk[pwm->hwpwm];
 	unsigned long period, duty;
diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index ef7d0da137ed..b3d4a955aa31 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -328,7 +328,7 @@ static int lpc18xx_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	err = lpc18xx_pwm_config(pwm->chip, pwm, state->duty_cycle, state->period);
+	err = lpc18xx_pwm_config(chip, pwm, state->duty_cycle, state->period);
 	if (err)
 		return err;
 
diff --git a/drivers/pwm/pwm-lpc32xx.c b/drivers/pwm/pwm-lpc32xx.c
index 78f664e41e6e..1d9f3e7a2434 100644
--- a/drivers/pwm/pwm-lpc32xx.c
+++ b/drivers/pwm/pwm-lpc32xx.c
@@ -103,7 +103,7 @@ static int lpc32xx_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	err = lpc32xx_pwm_config(pwm->chip, pwm, state->duty_cycle, state->period);
+	err = lpc32xx_pwm_config(chip, pwm, state->duty_cycle, state->period);
 	if (err)
 		return err;
 
diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 373abfd25acb..17d290f847af 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -217,7 +217,7 @@ static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	err = pwm_mediatek_config(pwm->chip, pwm, state->duty_cycle, state->period);
+	err = pwm_mediatek_config(chip, pwm, state->duty_cycle, state->period);
 	if (err)
 		return err;
 
diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 4239f2c3e8b2..ce92db1f8511 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -416,7 +416,7 @@ static int tpu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	err = tpu_pwm_config(pwm->chip, pwm,
+	err = tpu_pwm_config(chip, pwm,
 			     state->duty_cycle, state->period, enabled);
 	if (err)
 		return err;
diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index dc92cea31cd0..6cf55cf34d39 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -407,7 +407,7 @@ static int sti_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	err = sti_pwm_config(pwm->chip, pwm, state->duty_cycle, state->period);
+	err = sti_pwm_config(chip, pwm, state->duty_cycle, state->period);
 	if (err)
 		return err;
 
diff --git a/drivers/pwm/pwm-stmpe.c b/drivers/pwm/pwm-stmpe.c
index a46f5b4dd816..d730631c6583 100644
--- a/drivers/pwm/pwm-stmpe.c
+++ b/drivers/pwm/pwm-stmpe.c
@@ -275,7 +275,7 @@ static int stmpe_24xx_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	err = stmpe_24xx_pwm_config(pwm->chip, pwm, state->duty_cycle, state->period);
+	err = stmpe_24xx_pwm_config(chip, pwm, state->duty_cycle, state->period);
 	if (err)
 		return err;
 
diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 39ea51e08c94..82ee2f0754f9 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -256,7 +256,7 @@ static int tegra_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	err = tegra_pwm_config(pwm->chip, pwm, state->duty_cycle, state->period);
+	err = tegra_pwm_config(chip, pwm, state->duty_cycle, state->period);
 	if (err)
 		return err;
 
diff --git a/drivers/pwm/pwm-twl-led.c b/drivers/pwm/pwm-twl-led.c
index 625233f4703a..8a870d0db3c6 100644
--- a/drivers/pwm/pwm-twl-led.c
+++ b/drivers/pwm/pwm-twl-led.c
@@ -175,7 +175,7 @@ static int twl4030_pwmled_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * pwm_apply_state because of !state->enabled and so the two values in
 	 * pwm->state might not be configured in hardware.
 	 */
-	ret = twl4030_pwmled_config(pwm->chip, pwm,
+	ret = twl4030_pwmled_config(chip, pwm,
 				    state->duty_cycle, state->period);
 	if (ret)
 		return ret;
@@ -275,7 +275,7 @@ static int twl6030_pwmled_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	err = twl6030_pwmled_config(pwm->chip, pwm,
+	err = twl6030_pwmled_config(chip, pwm,
 				    state->duty_cycle, state->period);
 	if (err)
 		return err;
diff --git a/drivers/pwm/pwm-twl.c b/drivers/pwm/pwm-twl.c
index 603d31f27470..68e02c9a6bf9 100644
--- a/drivers/pwm/pwm-twl.c
+++ b/drivers/pwm/pwm-twl.c
@@ -294,7 +294,7 @@ static int twl4030_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	err = twl_pwm_config(pwm->chip, pwm, state->duty_cycle, state->period);
+	err = twl_pwm_config(chip, pwm, state->duty_cycle, state->period);
 	if (err)
 		return err;
 
@@ -319,7 +319,7 @@ static int twl6030_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	err = twl_pwm_config(pwm->chip, pwm, state->duty_cycle, state->period);
+	err = twl_pwm_config(chip, pwm, state->duty_cycle, state->period);
 	if (err)
 		return err;
 
diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index 5568d5312d3c..bdea60389487 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -209,7 +209,7 @@ static int vt8500_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * pwm_apply_state because of !state->enabled and so the two values in
 	 * pwm->state might not be configured in hardware.
 	 */
-	err = vt8500_pwm_config(pwm->chip, pwm, state->duty_cycle, state->period);
+	err = vt8500_pwm_config(chip, pwm, state->duty_cycle, state->period);
 	if (err)
 		return err;
 
-- 
2.42.0


