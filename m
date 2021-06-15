Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B283A8C54
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Jun 2021 01:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhFOXUg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Jun 2021 19:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbhFOXUf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Jun 2021 19:20:35 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B9FC061760
        for <linux-pwm@vger.kernel.org>; Tue, 15 Jun 2021 16:18:30 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id l15-20020a05683016cfb02903fca0eacd15so603894otr.7
        for <linux-pwm@vger.kernel.org>; Tue, 15 Jun 2021 16:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pth2v3ZNP3bQI72INPpsNym5/y4d3Mf6qoAfH+N+szA=;
        b=EU/DAwTQl9leUMmTrZZsDJD5Uk35zXy/TcEXIrlpTuyhB9pAmmnrNPqsb9I6YBcCQ8
         grHUArQsFzwNCSHwY7sKhhIVIAgnR3aJJOkKfBrexYqtCoG3l8MrlrCcRan2rNUAHOiP
         Urv2m4sSN9nqp/b4b1Pa2gU7C7Y4SvCWOQOMGsgMIPzIm/WMXH9tDzB/BU21nuTSzOwx
         JtVkL+24h0RX6rnnnKeqf/xU8pBHuHpNjy7zUMyZzKv6lU9giGcSBvr23mhSMVu22wXc
         s03lNt2FgbuPExJn2sR7ZG332alnZXrUWfEQ2poVziXMhCRizhp+6CO6XTs08Jvu7DIS
         rnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pth2v3ZNP3bQI72INPpsNym5/y4d3Mf6qoAfH+N+szA=;
        b=kLZrDQFH6qCnzluFxrxScReu638R00guNAKkqcypJ/Fq27AvkXGbG3rarfxs09r4Gi
         ulRrxYoGV7Ge2t4QgE6/VLS2olCUd8t41bTRhbZQ7chJcEtlVJ6kNdsrrrHJaQJGW2ay
         rfMicK5/i9Qy6CBPZ/mPxnxV+Iv6D/cjra8eQ8DrBUOJL80SWzDLdQKZKl4MRMxQrFDL
         77W5wpGd52ttzkLC+etjrTyiYUklPmfIsfeRsvWchz2hGk3htnQxihKR4B+WGMYr3ytc
         KxQo+fRtApWdaak9Q8FtK2eWjYpPLr/SFDUbf1UXX4iCZhH41wk4BNvhUVEf03dD/KrX
         9P/w==
X-Gm-Message-State: AOAM531zc4684u2z5KErGb+2L4pU8pu7hOGIH6SOj3Tq3am0gbG/8PMv
        x2SiMXcPtT+RU4gmcDF/IBQicA==
X-Google-Smtp-Source: ABdhPJynjXWcbExEX+WMCsq8eHaOR2NFHn33OXgBFDL04IufdnkVE9agWXNyimx7bcXxUI3f4LIVZw==
X-Received: by 2002:a9d:1ea5:: with SMTP id n34mr1337303otn.340.1623799109568;
        Tue, 15 Jun 2021 16:18:29 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m18sm96101otr.61.2021.06.15.16.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 16:18:29 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH v2 1/2] pwm: Introduce single-PWM of_xlate function
Date:   Tue, 15 Jun 2021 18:18:27 -0500
Message-Id: <20210615231828.835164-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The existing pxa driver and the upcoming addition of PWM support in the
TI sn565dsi86 DSI/eDP bridge driver both has a single PWM channel and
thereby a need for a of_xlate function with the period as its single
argument.

Introduce a common helper function in the core that can be used as
of_xlate by such drivers and migrate the pxa driver to use this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Pick up the optional flags cell as well

 drivers/pwm/core.c    | 26 ++++++++++++++++++++++++++
 drivers/pwm/pwm-pxa.c | 16 +---------------
 include/linux/pwm.h   |  2 ++
 3 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index a42999f877d2..5e9c876fccc4 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -152,6 +152,32 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
 }
 EXPORT_SYMBOL_GPL(of_pwm_xlate_with_flags);
 
+struct pwm_device *
+of_pwm_single_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
+{
+	struct pwm_device *pwm;
+
+	if (pc->of_pwm_n_cells < 1)
+		return ERR_PTR(-EINVAL);
+
+	/* validate that one cell is specified, optionally with flags */
+	if (args->args_count != 1 && args->args_count != 2)
+		return ERR_PTR(-EINVAL);
+
+	pwm = pwm_request_from_chip(pc, 0, NULL);
+	if (IS_ERR(pwm))
+		return pwm;
+
+	pwm->args.period = args->args[0];
+	pwm->args.polarity = PWM_POLARITY_NORMAL;
+
+	if (args->args_count == 2 && args->args[2] & PWM_POLARITY_INVERTED)
+		pwm->args.polarity = PWM_POLARITY_INVERSED;
+
+	return pwm;
+}
+EXPORT_SYMBOL_GPL(of_pwm_single_xlate);
+
 static void of_pwmchip_add(struct pwm_chip *chip)
 {
 	if (!chip->dev || !chip->dev->of_node)
diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index cfb683827d32..8cd82fb54483 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -148,20 +148,6 @@ static const struct platform_device_id *pxa_pwm_get_id_dt(struct device *dev)
 	return id ? id->data : NULL;
 }
 
-static struct pwm_device *
-pxa_pwm_of_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
-{
-	struct pwm_device *pwm;
-
-	pwm = pwm_request_from_chip(pc, 0, NULL);
-	if (IS_ERR(pwm))
-		return pwm;
-
-	pwm->args.period = args->args[0];
-
-	return pwm;
-}
-
 static int pwm_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *id = platform_get_device_id(pdev);
@@ -187,7 +173,7 @@ static int pwm_probe(struct platform_device *pdev)
 	pwm->chip.npwm = (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1;
 
 	if (IS_ENABLED(CONFIG_OF)) {
-		pwm->chip.of_xlate = pxa_pwm_of_xlate;
+		pwm->chip.of_xlate = of_pwm_single_xlate;
 		pwm->chip.of_pwm_n_cells = 1;
 	}
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 5a73251d28e3..6aff1fa4fe5d 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -411,6 +411,8 @@ struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
 
 struct pwm_device *of_pwm_xlate_with_flags(struct pwm_chip *pc,
 		const struct of_phandle_args *args);
+struct pwm_device *of_pwm_single_xlate(struct pwm_chip *pc,
+				       const struct of_phandle_args *args);
 
 struct pwm_device *pwm_get(struct device *dev, const char *con_id);
 struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
-- 
2.31.0

