Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDBE22A64D
	for <lists+linux-pwm@lfdr.de>; Sat, 25 May 2019 20:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfEYSMo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 25 May 2019 14:12:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40376 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfEYSL4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 25 May 2019 14:11:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id t4so4675866wrx.7;
        Sat, 25 May 2019 11:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sl7WM07hR08H8EVlL8BEDz+//aYuTyGwlSt+xVLLPA4=;
        b=O9vmAF+kUMYIvRHKCOfkAeLiseR0j9hjltBcchi7dPoB1PdjYN/fh4BGKbMFqWJ4fq
         e9hoZDAqwcd2LSGT2Jc/wze2oAt7dwfuAFkmI97eCraeCt3P4VNt5oOTE9P1tSPaKzr/
         zDG7D/Cgur2Xzbpe5HDWRAKdJkF0adTJbSjiLMJZPrIxlHLn+1xtLcVelB23HCcDA2pa
         cXNVEGslH5NPNCl2kjZG9k93tbyRYibtycc90au0J73llwos3miKLJNkfZ+2f258CI1k
         HkbXBRucsaazWpeFmzpVLs99R7G9/7ncEaUSiLczsOAq9sSuVXP+yPrxVFXmCrqsbyyJ
         JPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sl7WM07hR08H8EVlL8BEDz+//aYuTyGwlSt+xVLLPA4=;
        b=ZD1o1vX4o8m42c9WRZ4skIcA1g2XJoZgESmpb6Gpz9hINuV2iY3Er0nL0ZXYFgsVcY
         Czu0eKpuGX+8EVbE9ZTVmm346Q7XTUYlr93SUtoOTv72Xh7ap7GUcY/yNMtoOyAfzqNO
         H/002RvTzzGCjo6hBQFdqftFp9ck/XMVftTkyGv06ZeWJMRyYA6akgm6AwbyfNy5ZiOK
         d4fmbO2IY/4xmHPFZzilVORFu8zN69dzrPhKx9CqjRW5r/JQcebxVJQhhtCKq0xkCm6C
         vAqfYD7OZFEqsdASIJCLm6w43Knfq1BOiTUH/HG1y87es9lCmdjzxPYkqmN4YpcnamBl
         SPVg==
X-Gm-Message-State: APjAAAW6L84m6fXUDo3jf6maDiqRqPq2AApqNnHuz+ap/xzm5MMYXCCj
        iFZZ0KV++HVMzxby9Oc0Mx4=
X-Google-Smtp-Source: APXvYqwz71MupkKANwKXksSJkIrXoMmQ+E9SpGbvVw8Rc58UkwUoghdumGcrzpipFiQqlugZA/dc5g==
X-Received: by 2002:adf:f6cb:: with SMTP id y11mr9814990wrp.67.1558807914809;
        Sat, 25 May 2019 11:11:54 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA4007CB8841254CD64FD.dip0.t-ipconnect.de. [2003:f1:33dd:a400:7cb8:8412:54cd:64fd])
        by smtp.googlemail.com with ESMTPSA id o8sm12794540wra.4.2019.05.25.11.11.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 11:11:54 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 09/14] pwm: meson: move pwm_set_chip_data() to meson_pwm_request()
Date:   Sat, 25 May 2019 20:11:28 +0200
Message-Id: <20190525181133.4875-10-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

All existing PWM drivers (except pwm-meson and two other ones) call
pwm_set_chip_data() from their pwm_ops.request() callback. Now that we
can access the struct meson_pwm_channel from struct meson_pwm we can do
the same.

Move the call to pwm_set_chip_data() to meson_pwm_request() and drop the
custom meson_pwm_add_channels(). This makes the implementation
consistent with other drivers and makes it slightly more obvious
thatpwm_get_chip_data() cannot be used from pwm_ops.get_state() (because
that's called by the PWM core before pwm_ops.request()).

No functional changes intended.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pwm/pwm-meson.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index ac7e188155fd..27915d6475e3 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -98,12 +98,16 @@ static inline struct meson_pwm *to_meson_pwm(struct pwm_chip *chip)
 
 static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
+	struct meson_pwm *meson = to_meson_pwm(chip);
+	struct meson_pwm_channel *channel;
 	struct device *dev = chip->dev;
 	int err;
 
-	if (!channel)
-		return -ENODEV;
+	channel = pwm_get_chip_data(pwm);
+	if (channel)
+		return 0;
+
+	channel = &meson->channels[pwm->hwpwm];
 
 	if (channel->clk_parent) {
 		err = clk_set_parent(channel->clk, channel->clk_parent);
@@ -124,7 +128,7 @@ static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	chip->ops->get_state(chip, pwm, &channel->state);
 
-	return 0;
+	return pwm_set_chip_data(pwm, channel);
 }
 
 static void meson_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -460,14 +464,6 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
 	return 0;
 }
 
-static void meson_pwm_add_channels(struct meson_pwm *meson)
-{
-	unsigned int i;
-
-	for (i = 0; i < meson->chip.npwm; i++)
-		pwm_set_chip_data(&meson->chip.pwms[i], &meson->channels[i]);
-}
-
 static int meson_pwm_probe(struct platform_device *pdev)
 {
 	struct meson_pwm *meson;
@@ -503,8 +499,6 @@ static int meson_pwm_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	meson_pwm_add_channels(meson);
-
 	platform_set_drvdata(pdev, meson);
 
 	return 0;
-- 
2.21.0

