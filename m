Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D56B9430A5
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Jun 2019 22:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390632AbfFLUAQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Jun 2019 16:00:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32958 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388658AbfFLT7k (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Jun 2019 15:59:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so18274067wru.0;
        Wed, 12 Jun 2019 12:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9duNzyOXL2uBZFKfNd08dg5Nd2ipcFHbuFioapQa3zU=;
        b=ML6/U/HE7C6uxY+WbpSPSwj/EdxdRkPJPhTthXln6AxEKSv5sAjDcWRnLbSvzA1fia
         3F7igjHrqbLHUiPfG2w5VzBiSmHlXC2eUVTUZzCQtFgGmgY6GvdY/bMbjwH6l6Ip1EmU
         UG3DCre837AEii/jcqMdrsx5fodiF0kciEgusI6IkJsdn/oUyGwuxUELKt3TY67KkC7C
         9jLGy0bpXhc+IdUbv1wRgv0gT3WSU1ZyNJ+Id81DSqdjPpubKcB8iGL6x1/3miD+3ndG
         CLgGBE9GiKbzK5fF4Y4qmM++CtOOQaXUsSXowWadB89iatqMaSswOTwSHKrIA8JYN4EB
         DY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9duNzyOXL2uBZFKfNd08dg5Nd2ipcFHbuFioapQa3zU=;
        b=En7YZrGH45bE1p9qqjWe7Q7WBJ0KYxqKDxeanCNwSinkxt13TQ8mqpdRwsCTmFVRGh
         ZkidnSRjKRAtybNb2X05iZ5tImzmr4Rxz2VxvCfgng8sodeIoa061bqeX/iG+p/m6RZE
         vGPcDtcbxCzu0f15YENJ2tEovL9rxLnYg2wnX2fa9G6jWMoUYmAi+ZJ5oNEhDBx9ca1z
         sSEVQIFOjnijWQi2slfthdOiMUXDyFRsDmL7EnyNbH7K4J9SQP0XpIDAq89QjXs96RRh
         AdgsqJflzhyG0s6YHcUhi2M7yL2nvIBU5yD3liGaWFpiCD82aimXorIX0Kv8Fu5zDY9I
         IItA==
X-Gm-Message-State: APjAAAXGhCjxw5gzy4jJCFksOV5kw7ZLSanDt5Hg7qtGZZGjKSICq2XP
        /OB+dRPil3kcsWJbBNyBT6g=
X-Google-Smtp-Source: APXvYqyfv4Q9YeYUh5AL76YU7U2ZwgDXUrmfUuV/ehx6YrwT4RFMNn6lnvF/KW9z2IvcaxF7CA551Q==
X-Received: by 2002:adf:dd03:: with SMTP id a3mr589247wrm.87.1560369578442;
        Wed, 12 Jun 2019 12:59:38 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:33dd:a400:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id f10sm1026745wrg.24.2019.06.12.12.59.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:59:37 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        u.kleine-koenig@pengutronix.de, narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 07/14] pwm: meson: add the meson_pwm_channel data to struct meson_pwm
Date:   Wed, 12 Jun 2019 21:59:04 +0200
Message-Id: <20190612195911.4442-8-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612195911.4442-1-martin.blumenstingl@googlemail.com>
References: <20190612195911.4442-1-martin.blumenstingl@googlemail.com>
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

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
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
2.22.0

