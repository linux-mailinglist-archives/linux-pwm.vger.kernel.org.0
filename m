Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 031CB2A64E
	for <lists+linux-pwm@lfdr.de>; Sat, 25 May 2019 20:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfEYSNB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 25 May 2019 14:13:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43024 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfEYSLq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 25 May 2019 14:11:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id l17so4550936wrm.10;
        Sat, 25 May 2019 11:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3846hpA0VZMszmYc1Od49f4w97KJgiyEWxP34Iw+ZOI=;
        b=OyX8MuNvfMozqpjcWk85AijY5aGyCBnJ+ElHglWl19+arEUmY2zSi/hOQI73ILV5/c
         hM/vKqcAfRjelxp/tfzddetGO8gSlXmfEgrYICHsyxLFBtLDNwCy6jyTtLF4maK8Y2Ox
         637QHArHJeamZp7+cQheJX5gnLcrUnK694X5vJPQzKHqkD3tKHUGkyqtCPWAyoIe0/m3
         PyVMzInd+JWvTSQa9Plw/HRaAwwPH214WBhQnkgXPn8VQBZuYdtXgIYqxmsI8XaeobH5
         EVGFcPq4Z6PybieiNqHuEmGfkGXi/8gSd/aQuyTzJ14SQWy8d5xauxyDA4+hUOZeO3i9
         qUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3846hpA0VZMszmYc1Od49f4w97KJgiyEWxP34Iw+ZOI=;
        b=HB/lhqiSBTBfCwgFfrMZY0fW8zy6EEjJ8ObADreOtSRanMOum30jDheJ3byP6W2PRe
         clVlnXjvlJB5//9l6nOG1PEdQwFJqg22ehgaGQlCD4V4RZBlCj0b3eiY59xSSmhXeRmy
         4Jn+xMUCJ37+K9ItgU6JYK+i3O7UF0AkicxGcepZWIKXYUUQUGcRWfT+PqxKMHn+NeD6
         E+a/a5Zx6GTrTKxkA6+DaRfuE23rGopQR9W/FTa7YDWkeIUrxbfAsGYw47JNoOaOUytL
         wa6xQCeIWa4leLMRFbj+0Hrl/QmhNY+IxyyUEAx8NX8/UO+l1qLOeLePkTPe5+huxbJp
         gJdw==
X-Gm-Message-State: APjAAAUi6LkCnnNXAUtDrhurbvMI3GwG5OPffp4zY0xgz6ECKm1tasdN
        z7MUSLwXGxLMPSfx1IT+QLs=
X-Google-Smtp-Source: APXvYqxiEfQUfycp8WtTaBUuBjs1RcNwjRJBotfEUd51P4MlDVWY5N1voIp3VdWZ9thnCsPEH/s33g==
X-Received: by 2002:a5d:6189:: with SMTP id j9mr3534497wru.151.1558807905134;
        Sat, 25 May 2019 11:11:45 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA4007CB8841254CD64FD.dip0.t-ipconnect.de. [2003:f1:33dd:a400:7cb8:8412:54cd:64fd])
        by smtp.googlemail.com with ESMTPSA id o8sm12794540wra.4.2019.05.25.11.11.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 11:11:44 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 01/14] pwm: meson: unify the parameter list of meson_pwm_{enable,disable}
Date:   Sat, 25 May 2019 20:11:20 +0200
Message-Id: <20190525181133.4875-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This is a preparation for a future cleanup. Pass struct pwm_device
instead of passing the individual values required by each function as
these can be obtained for each struct pwm_device instance.

As a nice side-effect the driver now uses "switch (pwm->hwpwm)"
everywhere. Before some functions used "switch (id)" while others used
"switch (pwm->hwpwm)".

No functional changes.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pwm/pwm-meson.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 5fef7e925282..3fbbc4128ce8 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -183,15 +183,14 @@ static int meson_pwm_calc(struct meson_pwm *meson,
 	return 0;
 }
 
-static void meson_pwm_enable(struct meson_pwm *meson,
-			     struct meson_pwm_channel *channel,
-			     unsigned int id)
+static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
 {
+	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
 	u32 value, clk_shift, clk_enable, enable;
 	unsigned int offset;
 	unsigned long flags;
 
-	switch (id) {
+	switch (pwm->hwpwm) {
 	case 0:
 		clk_shift = MISC_A_CLK_DIV_SHIFT;
 		clk_enable = MISC_A_CLK_EN;
@@ -228,12 +227,12 @@ static void meson_pwm_enable(struct meson_pwm *meson,
 	spin_unlock_irqrestore(&meson->lock, flags);
 }
 
-static void meson_pwm_disable(struct meson_pwm *meson, unsigned int id)
+static void meson_pwm_disable(struct meson_pwm *meson, struct pwm_device *pwm)
 {
 	u32 value, enable;
 	unsigned long flags;
 
-	switch (id) {
+	switch (pwm->hwpwm) {
 	case 0:
 		enable = MISC_A_EN;
 		break;
@@ -266,7 +265,7 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return -EINVAL;
 
 	if (!state->enabled) {
-		meson_pwm_disable(meson, pwm->hwpwm);
+		meson_pwm_disable(meson, pwm);
 		channel->state.enabled = false;
 
 		return 0;
@@ -293,7 +292,7 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	if (state->enabled && !channel->state.enabled) {
-		meson_pwm_enable(meson, channel, pwm->hwpwm);
+		meson_pwm_enable(meson, pwm);
 		channel->state.enabled = true;
 	}
 
-- 
2.21.0

