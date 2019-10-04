Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34861CBBCC
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2019 15:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388635AbfJDNdF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Oct 2019 09:33:05 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38085 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388585AbfJDNdE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Oct 2019 09:33:04 -0400
Received: by mail-lf1-f67.google.com with SMTP id u28so4504845lfc.5
        for <linux-pwm@vger.kernel.org>; Fri, 04 Oct 2019 06:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X6Db+RHzUjtZcLjspCPiiVLnQJwYqeZzGLFvIcIslUs=;
        b=EGVRYZjk/WuzVKJ889bp0hqc2OMOmT3XYKoBXPdA1Vo8S9tycus3E4uyFwntaQNmPZ
         ah6F1kEyygcpepYCQED3SNi4fnY76jnic5yumvljF37O+sFQp84qgT9FeUWGnGJiOnf9
         2MQ+vNE9bqr9v/kHpqcszX8Vk4g2WdcXlhoek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X6Db+RHzUjtZcLjspCPiiVLnQJwYqeZzGLFvIcIslUs=;
        b=NBXJhuLbOcKaH8mnuV+b2IrgfFlc6ZqYoLee/qDI+LESTK1FbNaXkijwpaWbu2tsEv
         64PUgbScQ2P7TdTnRzZseY45EfEfRMQe3VccMZXmcX0CC3xS9vCD7K/gPd+sffJwRHCd
         DoGfxR0nYZXlaVP+SbgGdW+JzT8LbDXPYjOEWBgqssHm5hot1yvfjTM2l/mM2rimtXuY
         I8zuLhMjD8TZW/gp4Oo+K5vMAQ2FPrpXkDuDQAeixZe8S5R+GQ7mPwB/PCqN6UQgjb/A
         mBKwvEWnBCcCzHZjbU/MBC6zEoH7/EYLjNcw8xgoCHZUnCV1iI4hFzo5BQvZX2HvvtFm
         hC0g==
X-Gm-Message-State: APjAAAWIwVcSV4sN38CeLQ82+xSctSFRnAbxeQPXpMnGqxakVNof2V6B
        W2hUlC8ElMaviDAIJsY38DnTdQ==
X-Google-Smtp-Source: APXvYqxC7Pv+rYmTFcsC0EBbRnbvycMrvO0qfUVmimBCi9QF+HY4ZUy2HsXLv8RHkV6gnQAKZZ9s1w==
X-Received: by 2002:ac2:4424:: with SMTP id w4mr8804306lfl.65.1570195982562;
        Fri, 04 Oct 2019 06:33:02 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y26sm1534991ljj.90.2019.10.04.06.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 06:33:01 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] pwm: mxs: add support for inverse polarity
Date:   Fri,  4 Oct 2019 15:32:04 +0200
Message-Id: <20191004133207.6663-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191004133207.6663-1-linux@rasmusvillemoes.dk>
References: <20191004133207.6663-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

If I'm reading of_pwm_xlate_with_flags() right, existing device trees
that set #pwm-cells = 2 will continue to work.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/pwm/pwm-mxs.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index 5a6835e18fc6..57562221c439 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -25,8 +25,11 @@
 #define  PERIOD_PERIOD(p)	((p) & 0xffff)
 #define  PERIOD_PERIOD_MAX	0x10000
 #define  PERIOD_ACTIVE_HIGH	(3 << 16)
+#define  PERIOD_ACTIVE_LOW	(2 << 16)
+#define  PERIOD_INACTIVE_HIGH	(3 << 18)
 #define  PERIOD_INACTIVE_LOW	(2 << 18)
 #define  PERIOD_POLARITY_NORMAL	(PERIOD_ACTIVE_HIGH | PERIOD_INACTIVE_LOW)
+#define  PERIOD_POLARITY_INVERSE	(PERIOD_ACTIVE_LOW | PERIOD_INACTIVE_HIGH)
 #define  PERIOD_CDIV(div)	(((div) & 0x7) << 20)
 #define  PERIOD_CDIV_MAX	8
 
@@ -50,9 +53,7 @@ static int mxs_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned int period_cycles, duty_cycles;
 	unsigned long rate;
 	unsigned long long c;
-
-	if (state->polarity != PWM_POLARITY_NORMAL)
-		return -ENOTSUPP;
+	unsigned int pol_bits;
 
 	/*
 	 * If the PWM channel is disabled, make sure to turn on the
@@ -91,9 +92,12 @@ static int mxs_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * only take effect at the beginning of a new period, avoiding
 	 * glitches.
 	 */
+
+	pol_bits = state->polarity == PWM_POLARITY_NORMAL ?
+		PERIOD_POLARITY_NORMAL : PERIOD_POLARITY_INVERSE;
 	writel(duty_cycles << 16,
 	       mxs->base + PWM_ACTIVE0 + pwm->hwpwm * 0x20);
-	writel(PERIOD_PERIOD(period_cycles) | PERIOD_POLARITY_NORMAL | PERIOD_CDIV(div),
+	writel(PERIOD_PERIOD(period_cycles) | pol_bits | PERIOD_CDIV(div),
 	       mxs->base + PWM_PERIOD0 + pwm->hwpwm * 0x20);
 
 	if (state->enabled) {
@@ -135,6 +139,8 @@ static int mxs_pwm_probe(struct platform_device *pdev)
 
 	mxs->chip.dev = &pdev->dev;
 	mxs->chip.ops = &mxs_pwm_ops;
+	mxs->chip.of_xlate = of_pwm_xlate_with_flags;
+	mxs->chip.of_pwm_n_cells = 3;
 	mxs->chip.base = -1;
 
 	ret = of_property_read_u32(np, "fsl,pwm-number", &mxs->chip.npwm);
-- 
2.20.1

