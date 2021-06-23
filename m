Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E020A3B1228
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Jun 2021 05:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhFWDaQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Jun 2021 23:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhFWDaP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Jun 2021 23:30:15 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32197C061756
        for <linux-pwm@vger.kernel.org>; Tue, 22 Jun 2021 20:27:58 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id n99-20020a9d206c0000b029045d4f996e62so583966ota.4
        for <linux-pwm@vger.kernel.org>; Tue, 22 Jun 2021 20:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JMuxhTYROjgx5QULq2BZS2oDybm62u2BvUDiK5gZyzc=;
        b=YbNbLV/AthBTeNVil1kpX3c8VOgFAmopKeEmIfPIMPIPYZkoXtnlnfEQ0T/sNnMsf2
         SYtNrDU17OYcxuO8gEDTh1N7YKbOc302add5Coep/i4R3fH1UocRi582IzdC1UomiaIo
         UOgNN69DmXyTcba9boWIxksL17ifBydlbQkgPDxmFK1g7ylObkWYn0G51CeHvgXBPzwD
         LcstrFIGUa7A7vOswuLzp+GxqSTlWd+xj1bm1AwTsfHxJOwOVKB4xBFjrd1fku8zfEI7
         //NsRMqRRs48hrsX3G4vhhSNFaPCblxHaMtZzClLwhUb71dOrgbcE7Y3ujDJlR+J5UqT
         84ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JMuxhTYROjgx5QULq2BZS2oDybm62u2BvUDiK5gZyzc=;
        b=Z4qwathsC61s85b9LP0h60q0Qz6GJN8sG9Ttyk4LfjE3WB3ECpwRjPtyFKl6vBko2k
         IuDDRZORa5JldfhTZzivaMC2jD1dvyw8Hq4IcTUI36JZUntD6XZtI9/XdSxu6tPxmtQ0
         6MrhQLQJiHlfUFbBe0ysbz16VjVmCCRiToEzqTk1edFF4f/OSrGeDJ2i5UGa9lel4PvQ
         ptVhKVsAfvdD7Bo+5SnCNP9aH/lq/gNed8bdzSj4fzEWWwdujlCW4Zbm0oYVEDGmEwFU
         jhw8amFLI1ZRhf8LfggxYJmMcg5GcQff+MlZtsc9vFaowPgrtqljFNvCOxjLK0lodxbE
         NdMg==
X-Gm-Message-State: AOAM5332QNyKMIkYXfVWCLtHzvhh9JZPXSy37KiyubLQZdkz0gWQsFpy
        7GTzYEV1XFPgkjTWSsG1uOnYpQ==
X-Google-Smtp-Source: ABdhPJx5WmbQ9LFZ73FpteNTurW7aGLSMgScI2jKFBUXnJINs1Lb2bS5zsOsgaX5eD2Le60O+oUyQw==
X-Received: by 2002:a05:6830:905:: with SMTP id v5mr6050659ott.280.1624418877306;
        Tue, 22 Jun 2021 20:27:57 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id c205sm4708363oib.20.2021.06.22.20.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 20:27:56 -0700 (PDT)
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
Subject: [PATCH v4 1/2] pwm: Introduce single-PWM of_xlate function
Date:   Tue, 22 Jun 2021 22:27:54 -0500
Message-Id: <20210623032755.1170809-1-bjorn.andersson@linaro.org>
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

Changes since v3:
- None

Changes since v2:
- None

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

