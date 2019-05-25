Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74C872A637
	for <lists+linux-pwm@lfdr.de>; Sat, 25 May 2019 20:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfEYSLx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 25 May 2019 14:11:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34463 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfEYSLx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 25 May 2019 14:11:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id e19so4164408wme.1;
        Sat, 25 May 2019 11:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vh14UlgAUkIljLzMtiNlC8F9kkg89y0/Qk0nPY9Q0wE=;
        b=OjPmG7u32W9bxtU+VPzPQ2qz0WmWIeBCLlAPE1sPJKMDIcVNrBXNHO8lsnVIdo9y45
         h6F8//QMAxceKMyJKGFM9RRrKYieWqB7w3GLxVrX0EvdS26Gg7eWJXpax4v8lqNKr1FA
         KjRZpJpET0Xxy+cqpkr5+ggty2RCtjYF/ctI4KryecNx+wtznDh7jGF6XdYApiUT9pLP
         DfxsTTfB2Nczb7CW7GdDKV1zVu9C9Rm3KsA7V21//c4pfMVUyPfKGSNI76lptF49iBYr
         AS+gKKFj6HSUB05ukiH7B/yF9mYO6ttVAMaYBidN9uw4bvh2MyR5/j/yudLjq+Pd7yTb
         NMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vh14UlgAUkIljLzMtiNlC8F9kkg89y0/Qk0nPY9Q0wE=;
        b=ENJ9KgaCG2zqOOADd3gQGVjSwix9tPXmhd22kzUZqy3LorlB+7zgk0lBZfxeXcwIFF
         /j3PHzmMxbSFUslPGrdDXj3uxx4ew4h0ljSVp1NfsWsCYOsdJm9DT/znZJlo26AeO22G
         gIezgKww10OKMXa3mrU9ZCtGdszKvZP4XKa8K+0sFvBzvcNt2vKBJIRTOgWwAwcnVCvp
         yct50KOfZmTCMrq2ULi+SOmUa4pTlgXr2Kc/JpQJcRDfJpOyImUn3GawfRG0oKz/Iq9H
         LstCxw4+kcO20D+VJ7s5+Q8bIU1pQvPC87zi3UyDPZLqwi3nHfEpZuzbLCXQRaRPq9KG
         1c7g==
X-Gm-Message-State: APjAAAUyY/ScbrL2qefnWUlkpp3pwL+49J3JXP4pCRFBTFpYYGSy4fPF
        AQEHkpiYLk456VoPBG2QtRY=
X-Google-Smtp-Source: APXvYqxA7x6dY6V0ULEhoWOYWuPm0XWiLfS7y9OgJaQ+D2//vYFJ/epu6mol03rolVLlg+EqXN3MIw==
X-Received: by 2002:a1c:b789:: with SMTP id h131mr4004748wmf.71.1558807911278;
        Sat, 25 May 2019 11:11:51 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA4007CB8841254CD64FD.dip0.t-ipconnect.de. [2003:f1:33dd:a400:7cb8:8412:54cd:64fd])
        by smtp.googlemail.com with ESMTPSA id o8sm12794540wra.4.2019.05.25.11.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 11:11:50 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 07/14] pwm: meson: add the meson_pwm_channel data to struct meson_pwm
Date:   Sat, 25 May 2019 20:11:26 +0200
Message-Id: <20190525181133.4875-8-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Make struct meson_pwm_channel accessible from struct meson_pwm.

PWM core has a limitation: per-channel data can only be set after
pwmchip_add() is called. However, pwmchip_add() internally calls
pwm_ops.get_state(). If pwm_ops.get_state() needs access to the
per-channel data it has to obtain it from struct pwm_chip and struct
pwm_device's hwpwm information.

Add a struct meson_pwm_channel for each PWM channel to struct meson_pwm
so the pwm_ops.get_state() callback can be implemented as it needs
access to the clock from struct meson_pwm_channel.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pwm/pwm-meson.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index d6eb4d04d5c9..d1718f54ecec 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -37,6 +37,8 @@
 #define MISC_B_EN		BIT(1)
 #define MISC_A_EN		BIT(0)
 
+#define MESON_NUM_PWMS		2
+
 static const unsigned int mux_reg_shifts[] = {
 	MISC_A_CLK_SEL_SHIFT,
 	MISC_B_CLK_SEL_SHIFT
@@ -62,6 +64,7 @@ struct meson_pwm_data {
 struct meson_pwm {
 	struct pwm_chip chip;
 	const struct meson_pwm_data *data;
+	struct meson_pwm_channel channels[MESON_NUM_PWMS];
 	void __iomem *base;
 	/*
 	 * Protects register (write) access to the REG_MISC_AB register
@@ -435,8 +438,7 @@ static const struct of_device_id meson_pwm_matches[] = {
 };
 MODULE_DEVICE_TABLE(of, meson_pwm_matches);
 
-static int meson_pwm_init_channels(struct meson_pwm *meson,
-				   struct meson_pwm_channel *channels)
+static int meson_pwm_init_channels(struct meson_pwm *meson)
 {
 	struct device *dev = meson->chip.dev;
 	struct clk_init_data init;
@@ -445,7 +447,7 @@ static int meson_pwm_init_channels(struct meson_pwm *meson,
 	int err;
 
 	for (i = 0; i < meson->chip.npwm; i++) {
-		struct meson_pwm_channel *channel = &channels[i];
+		struct meson_pwm_channel *channel = &meson->channels[i];
 
 		snprintf(name, sizeof(name), "%s#mux%u", dev_name(dev), i);
 
@@ -480,18 +482,16 @@ static int meson_pwm_init_channels(struct meson_pwm *meson,
 	return 0;
 }
 
-static void meson_pwm_add_channels(struct meson_pwm *meson,
-				   struct meson_pwm_channel *channels)
+static void meson_pwm_add_channels(struct meson_pwm *meson)
 {
 	unsigned int i;
 
 	for (i = 0; i < meson->chip.npwm; i++)
-		pwm_set_chip_data(&meson->chip.pwms[i], &channels[i]);
+		pwm_set_chip_data(&meson->chip.pwms[i], &meson->channels[i]);
 }
 
 static int meson_pwm_probe(struct platform_device *pdev)
 {
-	struct meson_pwm_channel *channels;
 	struct meson_pwm *meson;
 	struct resource *regs;
 	int err;
@@ -509,18 +509,13 @@ static int meson_pwm_probe(struct platform_device *pdev)
 	meson->chip.dev = &pdev->dev;
 	meson->chip.ops = &meson_pwm_ops;
 	meson->chip.base = -1;
-	meson->chip.npwm = 2;
+	meson->chip.npwm = MESON_NUM_PWM;
 	meson->chip.of_xlate = of_pwm_xlate_with_flags;
 	meson->chip.of_pwm_n_cells = 3;
 
 	meson->data = of_device_get_match_data(&pdev->dev);
 
-	channels = devm_kcalloc(&pdev->dev, meson->chip.npwm,
-				sizeof(*channels), GFP_KERNEL);
-	if (!channels)
-		return -ENOMEM;
-
-	err = meson_pwm_init_channels(meson, channels);
+	err = meson_pwm_init_channels(meson);
 	if (err < 0)
 		return err;
 
@@ -530,7 +525,7 @@ static int meson_pwm_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	meson_pwm_add_channels(meson, channels);
+	meson_pwm_add_channels(meson);
 
 	platform_set_drvdata(pdev, meson);
 
-- 
2.21.0

