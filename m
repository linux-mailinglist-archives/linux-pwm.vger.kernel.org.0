Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA95FDEA2F
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2019 12:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfJUK5s (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Oct 2019 06:57:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40311 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbfJUK5s (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 06:57:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id b24so12278731wmj.5
        for <linux-pwm@vger.kernel.org>; Mon, 21 Oct 2019 03:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vg8liwwdmOnv6h7m3dVBoJHFOX5I8jWU6N1kTGf/T3w=;
        b=koSVawHwtnfGqdUUa7CYC2BjChIStgAJ3UDsHIfdl85ly4KdMSriB2UWZG4cffCMtd
         b2AWNZ/vxvOlSD3jcX8XgXjpL4bRgUWZuC6EA+84PNw8bDWVEy57NXo9vfPYzNpmxoe1
         Pa08A7Xr/hOKlnqJydsgPqdkZHi8E09QVprLvSxWL52JDRe8Vajh/+Hw3UCRqmRKY91A
         RRkyrHybusujmDE77AhMv93n1zPjvRXLqhjOseUVA19e1glfyRN+WyYh+b8giy6LzHso
         Sd3QX3AMtvz9sTpOAelUdR6n7wd2qxGJtKejYxb9VQkA1oTSGaoznbDnZTQHoB1HLQJ4
         kUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vg8liwwdmOnv6h7m3dVBoJHFOX5I8jWU6N1kTGf/T3w=;
        b=ESeIoJ7/j2VRa+NhVQkloRD+15hg4y+WlsjIEkMDCkTeRe2IT5LIFBhu7lPuutiFcx
         ub4LEP55kfHlt3mkgaWa/iaD/rGjrsFfQzxl32LTNmnSvc80UkziWdorH027gPqnyKxW
         Bt55VGeuA/96KswCfunjyC2XuKD6XIqZniOOQdm8I6p7vvkMC6xYP82f6Hehl72cEsI3
         zZqjeRRC/+JsQOtnPDpzJTnKXjKdEG2G7LmjnfeNJGdA9QeTKYe2sYcFGPNODSq5bbZH
         wYMAmxRy5UqY7YkKY1y+xrS2IJlQMf/KdQxJ4jFGLopOfm6sc5QRz8r8J8HShUIMpdSQ
         sjAA==
X-Gm-Message-State: APjAAAWXNk13dceQuW041a3QTxtrTxNmI2DtRI7djB6lFBDhGVDUZbXq
        LfVLDl7D+zUL8QK59l7MvZo=
X-Google-Smtp-Source: APXvYqyNwU+JLjYO3ev+IKbJY38YR4DXFOhy18JPEm5FFp0c1jrAR1uzYffzojIm3MTsYVx4p1LG7A==
X-Received: by 2002:a1c:6a07:: with SMTP id f7mr6082484wmc.124.1571655465952;
        Mon, 21 Oct 2019 03:57:45 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id u10sm3168062wmj.0.2019.10.21.03.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 03:57:44 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-pwm@vger.kernel.org
Subject: [PATCH 3/4] pwm: imx27: Cache duty cycle register value
Date:   Mon, 21 Oct 2019 12:57:38 +0200
Message-Id: <20191021105739.1357629-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191021105739.1357629-1-thierry.reding@gmail.com>
References: <20191021105739.1357629-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The hardware register containing the duty cycle value cannot be accessed
when the PWM is disabled. This causes the ->get_state() callback to read
back a duty cycle value of 0, which can confuse consumer drivers.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/pwm-imx27.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index ae11d8577f18..4113d5cd4c62 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -85,6 +85,13 @@ struct pwm_imx27_chip {
 	struct clk	*clk_per;
 	void __iomem	*mmio_base;
 	struct pwm_chip	chip;
+
+	/*
+	 * The driver cannot read the current duty cycle from the hardware if
+	 * the hardware is disabled. Cache the last programmed duty cycle
+	 * value to return in that case.
+	 */
+	unsigned int duty_cycle;
 };
 
 #define to_pwm_imx27_chip(chip)	container_of(chip, struct pwm_imx27_chip, chip)
@@ -155,14 +162,17 @@ static void pwm_imx27_get_state(struct pwm_chip *chip,
 	tmp = NSEC_PER_SEC * (u64)(period + 2);
 	state->period = DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);
 
-	/* PWMSAR can be read only if PWM is enabled */
-	if (state->enabled) {
+	/*
+	 * PWMSAR can be read only if PWM is enabled. If the PWM is disabled,
+	 * use the cached value.
+	 */
+	if (state->enabled)
 		val = readl(imx->mmio_base + MX3_PWMSAR);
-		tmp = NSEC_PER_SEC * (u64)(val);
-		state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);
-	} else {
-		state->duty_cycle = 0;
-	}
+	else
+		val = imx->duty_cycle;
+
+	tmp = NSEC_PER_SEC * (u64)(val);
+	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);
 
 	if (!state->enabled)
 		pwm_imx27_clk_disable_unprepare(chip);
@@ -261,6 +271,13 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
 		writel(period_cycles, imx->mmio_base + MX3_PWMPR);
 
+		/*
+		 * Store the duty cycle for future reference in cases where
+		 * the MX3_PWMSAR register can't be read (i.e. when the PWM
+		 * is disabled).
+		 */
+		imx->duty_cycle = duty_cycles;
+
 		cr = MX3_PWMCR_PRESCALER_SET(prescale) |
 		     MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
 		     FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH) |
-- 
2.23.0

