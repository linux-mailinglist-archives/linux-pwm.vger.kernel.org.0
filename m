Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD9143096
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Jun 2019 22:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389733AbfFLT7n (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Jun 2019 15:59:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43487 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389642AbfFLT7m (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Jun 2019 15:59:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so8125798wru.10;
        Wed, 12 Jun 2019 12:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZO2I0nc2ZuC8lo4fZqPZLu1ILdKFupecX1fpt0vJbX8=;
        b=s2k7UPtXJrKmRqewFzECaggm0X0f1LVk4ve6wyxIHpM/+aaRLVzCL0oIPaATv+7icK
         giRfO3MeaQ9+0n7NZZKRcmKvneynm/p6mx4DFiVUi1qWjWuddVUJwW+DdtgQX38MAcTf
         ofWXa05BtJwNhTgJF3NYhy7Mkh2RdMIo1OizJgCep9waUpq80XvJrIrb5EDYSlDSERzh
         /+8VRIOvbTxqBexLHe9TC2QuBcvlwywgIZYYG+Uh9u0OKbQv+qpvIotcFOD3g7ngDbeZ
         slhUjjFhv5pebPc/uYry4PoYjy9qhGo5Q18RvGAxVRpRbaHbkQclZi00i2RvbaM/9xmt
         a/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZO2I0nc2ZuC8lo4fZqPZLu1ILdKFupecX1fpt0vJbX8=;
        b=ACJ7Yqmg2lMG9vfx/OVeqqeK1B7TmoTUw7pAEfj7LkzUtDk9e+pww3Y0sISebrWadF
         7bWcpFUeX9DR07G3DTWBUCsgTdfq0af+SG1o72mkr00ukqnYaImcMFTbsm7zMkQUzjie
         ky6azZtjgIfFsAJ+hweNVgjx95TW5igWhEbLj+lelzSLGrdfi1kzn8mESH3Sq5d60ZNo
         5zY/5PsiQQW3Sh1H33OoQtbS5Quo2SJSY/Cu6LYNPT4olrjdJ6ldt/yX/NSn2nuXq0ek
         bZ8cjorRpykKFPvVuLHlmkt7pdCFu4dmFNV2enj8DWlolN7GDN9L1z2mswBWbteuSrTW
         dPIQ==
X-Gm-Message-State: APjAAAXJoJbPpJRZekykrSg5lMO+KML2gbBejmy4LfPhF+kpGLrgKoI7
        jcAX1SUygxGv/N/IF+KOhFA=
X-Google-Smtp-Source: APXvYqwsZeC2xWn46wSwc6F1FRQQkyg4g9mdYUrvu06Wn8TkkSHFCVkYpWEmZcaG6bt4PqKqBTkDYQ==
X-Received: by 2002:a5d:6312:: with SMTP id i18mr16038992wru.203.1560369580608;
        Wed, 12 Jun 2019 12:59:40 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:33dd:a400:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id f10sm1026745wrg.24.2019.06.12.12.59.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:59:39 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        u.kleine-koenig@pengutronix.de, narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 09/14] pwm: meson: move pwm_set_chip_data() to meson_pwm_request()
Date:   Wed, 12 Jun 2019 21:59:06 +0200
Message-Id: <20190612195911.4442-10-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612195911.4442-1-martin.blumenstingl@googlemail.com>
References: <20190612195911.4442-1-martin.blumenstingl@googlemail.com>
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

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
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
2.22.0

