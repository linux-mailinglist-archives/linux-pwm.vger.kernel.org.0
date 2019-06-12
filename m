Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 659F74308F
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Jun 2019 22:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389155AbfFLT7f (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Jun 2019 15:59:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34408 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388658AbfFLT7d (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Jun 2019 15:59:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so50754wrl.1;
        Wed, 12 Jun 2019 12:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DbdAX0bV85Dko/n1L+nFmKMabI9Kh0fLOwLLV1IH53M=;
        b=i98jcwEgONXb3ZOPIzPaDduImuV0oAvjS9qfSmC5tx3AcS2Ny/sC+OFo8VMuEFDyN9
         8kO0wtjx655Rhp9mXl4zeUa2GVSWhqtq7n2yidRk4ED+WXElWp2iY11rpMjQvLzvS4rm
         VoHVs7TMtYOj7i25xCkTxoJKzPkdS8smwL7tmtAkI/LrVrplmn1MW6jkMpTmzk5PGL17
         8zn0ZraSMPZcl4EQFRuMmHyhziVAiswTUj4qoARxdWiVw8Ugj6A40BQSdzWhVHg+pF/f
         GTZaz8DuBDTGXA4qWGfQZ+Bn/+bcO3zDmCfeARHURfoOn8UAqxoydYC1adaol1wSMEW5
         snzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DbdAX0bV85Dko/n1L+nFmKMabI9Kh0fLOwLLV1IH53M=;
        b=QDB91pjWwIp1V59jGejr4lw0xFWdyB666c1cMb2vH+SSjLSfxNX4LRdZ7FopF3fD0C
         uF4uVmAHUXvDA06GNIv8y9ia3amhlyc/RvX/m59ZVtMe7IIyxM7DUZesVz4xg8QQHBP3
         sEVuydd7JAEQCOVffsyfK4OGDMrg0qFdOXLJ6aD4Z4SmbmFiu0zvw+D5tgEDA+SxeZC8
         qIBQ3kXbiztPOkOtb+E+O2HiDMk8/rHDzXFaEHicULy64Sdpeojochf7AFRopOoUfhpj
         lB18QWAi48XFv8DAW+J2JEh/aIDG5TIREP9Eq+psum4n5olVh8XOTs0YGnp0mWi2UsYz
         B1LQ==
X-Gm-Message-State: APjAAAWVAYsz6UjzxovP63dDj+VCbocX3y9FIr7VVF/9MgHL9w0I0sVQ
        wkKDa8dW20JnhOINcO0SYX0=
X-Google-Smtp-Source: APXvYqz8FPKyN4u6g2XV8ExWl7unahV+eyESFia516NWg/4YKZGCKK1sV/9qmYUtmXKVI4t10SWXMg==
X-Received: by 2002:adf:a38b:: with SMTP id l11mr3832905wrb.325.1560369571376;
        Wed, 12 Jun 2019 12:59:31 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:33dd:a400:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id f10sm1026745wrg.24.2019.06.12.12.59.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:59:30 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        u.kleine-koenig@pengutronix.de, narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 01/14] pwm: meson: unify the parameter list of meson_pwm_{enable,disable}
Date:   Wed, 12 Jun 2019 21:58:58 +0200
Message-Id: <20190612195911.4442-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612195911.4442-1-martin.blumenstingl@googlemail.com>
References: <20190612195911.4442-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
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
2.22.0

