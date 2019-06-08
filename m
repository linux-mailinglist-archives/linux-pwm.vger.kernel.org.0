Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 332A53A104
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Jun 2019 20:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfFHSGp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 8 Jun 2019 14:06:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33733 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbfFHSGn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 8 Jun 2019 14:06:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so5252294wru.0;
        Sat, 08 Jun 2019 11:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E2Kzd+gfP4FNDRd81CbW9jNNxdcKoqrgoqbenZAf8Uw=;
        b=XOC6FG3RL+XqM8IRylgcSr4c7yPG45c3Mfkp9EVn9AnzEbDjSC/LqzGfKlU7u+G1Oe
         D77RNYPyjHgGVLDchXgtmbkcBw07+e8Qj02XyS5lAiGJeNICL1BUF89eCiXxTHV37P0U
         LTf3vvrYNE1/YZ0TlbGuepZBJWRUcLuJoGiGjPlu9B/cCOUgwNDjU2fX5C2fv96/P/L9
         Qtidz3IHRMBBY9MgU+hoAJw0NAd4bzAL5qk6FnbXWCjoJnauoA/p3kmhbvfwNSUVZ6Wr
         1eTJ13jRPufn7jCSAmkfPWUyuOfR5tA7t+Py7FRQai3NjwHVAROvxUIrtEgWDgv5WhgY
         Yulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E2Kzd+gfP4FNDRd81CbW9jNNxdcKoqrgoqbenZAf8Uw=;
        b=Rq9CH4/KfVpEXFW8v/zEohK+ez8Zn8ds/Lww7elBUb+A9GFcVg5+kKwN8l0DIOTb9M
         fg9JZsrhDb4jT2hNIU4mV3ssctwMuYvJS+mwTIZv1HO89bei+q7/TuwYVqO0DIA61O6b
         nZdIBrCbxQHJd3c4NPLDgo0QsofAjATdkWfR4buz3C0BvbMaoIzkv8t7E0kdQiJJVTlg
         XZPUQE56ydFvEEbWCO6O7ez5Phnvw8RkfXD3NcB/oztSDTFLPjq2CSwa6nfSV6lf92mu
         wbqVHmRT+XqIRn97/BUa7uKOVNy6nRpB1HmrgbzTeiy/ScfAg3iCFZZW95ogrYMGyKiK
         DV+w==
X-Gm-Message-State: APjAAAWCOYQq5EhN2jFv1ROf4JVk6L4XdWRYYZjlsSNFpHnQ7Gd+t2Nv
        ODHyYXODXh+8//XMjmx384YapavE
X-Google-Smtp-Source: APXvYqzskCpgZHK48bBTIniJ6+KvBh8PtZJL6Yq+Y5wx77jNwRNxtRKXhTqO6wWBOspc2m0wd0b3Ug==
X-Received: by 2002:a5d:4603:: with SMTP id t3mr14944740wrq.315.1560017201326;
        Sat, 08 Jun 2019 11:06:41 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400D12EFF43FED1E981.dip0.t-ipconnect.de. [2003:f1:33dd:a400:d12e:ff43:fed1:e981])
        by smtp.googlemail.com with ESMTPSA id c7sm5143345wrp.57.2019.06.08.11.06.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 11:06:40 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 07/14] pwm: meson: add the meson_pwm_channel data to struct meson_pwm
Date:   Sat,  8 Jun 2019 20:06:19 +0200
Message-Id: <20190608180626.30589-8-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
References: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
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
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pwm/pwm-meson.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index d6eb4d04d5c9..a4ae3587a3ce 100644
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
+	meson->chip.npwm = MESON_NUM_PWMS;
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

