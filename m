Return-Path: <linux-pwm+bounces-247-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BB07FDCFD
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Nov 2023 17:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A1A6282792
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Nov 2023 16:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3ED37159;
	Wed, 29 Nov 2023 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQYby0rA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02765D5E
	for <linux-pwm@vger.kernel.org>; Wed, 29 Nov 2023 08:28:51 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a00cbb83c82so995056666b.2
        for <linux-pwm@vger.kernel.org>; Wed, 29 Nov 2023 08:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701275329; x=1701880129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e1gSDdiz6PQ7ZA4cXCNEGZg5xEcA/Di0r/Ixh06/wtQ=;
        b=DQYby0rALa1oKUZ7/N5UCpGu3in8K5vBsT59D0cUg9Jflb4tZZflmW5bxWL01RN+qN
         v7OiEvtdEbhT10pgZQXyLXwPO5eugEdBxL7etPf217B3kA0pBtOqWpKbqKAxASk1m4D7
         YBbkYA4IMQWcJwtCx/kRT/owa/k730eN/KMJ7vHiuDrcHans2aOc3YuWMzkOUmba+WA7
         84ASjge9YmmtnTUaxq+baN63Lo8nTM/PrSNCvf3BCW4bG81DMbRYAIPVWSPYgCpnKGZs
         yUfC812mYCqQZbyvd5PYubaFWR1F4YL2m2gECJdc7wjw8P7UojxLtj2h3dici4WKr0xu
         BJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701275329; x=1701880129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1gSDdiz6PQ7ZA4cXCNEGZg5xEcA/Di0r/Ixh06/wtQ=;
        b=A9AuDSzVyiEzgxEipkaPqjq2obaCbZzTd4BNoZxKt0ARQWn6MCulvIIr7J7Xho5hMw
         z25hNe+Rkl9C/bkrJPiLA2CE2Ea9w1PvLx/ruDK0YFdVF25CFVzsL8pG91DRU2iAWHsd
         qNhg4Nb8OknmPhoYD80HiqOn0N+xWGEp1FkAWI70JTDzSM7QauYr3CvlUO3O659rNi4X
         +EmwhcneQu1/OPO6VWxYaU398uE6mBxR1aL0KeSM31FSmB64IOGLXwCXtdJtldblxHDN
         WUdFOsgG1ZIv9Wq9M3TXdQxZAZXqjD9Vze5QoEcgBzONs/GgV0I1632CtaDCLNEpeJtQ
         Vbnw==
X-Gm-Message-State: AOJu0YxFmouwXAP1XaXLBnfsvuY4xVZezTt5cnmyrXTqdIbGWE5QJw+L
	dg1pN6UZAzvPP759uhctsUokUrWbhyg=
X-Google-Smtp-Source: AGHT+IFcT+blkPHXGUv2kU/nt/D0TxpTR3zl3kTnff8iXaT76gWSRmo5vRaDuqmKGCQoFkyhCo1Jtg==
X-Received: by 2002:a17:906:38da:b0:a02:4a97:8b3c with SMTP id r26-20020a17090638da00b00a024a978b3cmr13475899ejd.58.1701275329232;
        Wed, 29 Nov 2023 08:28:49 -0800 (PST)
Received: from localhost (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id kk9-20020a170907766900b00a0aca3de09fsm5864151ejc.184.2023.11.29.08.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 08:28:48 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: Stop referencing pwm->chip
Date: Wed, 29 Nov 2023 17:28:47 +0100
Message-ID: <20231129162847.568780-1-thierry.reding@gmail.com>
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
 drivers/pwm/pwm-bcm-kona.c    | 2 +-
 drivers/pwm/pwm-img.c         | 2 +-
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
 12 files changed, 14 insertions(+), 14 deletions(-)

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


