Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2BA369C10
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Apr 2021 23:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbhDWVdo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Apr 2021 17:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhDWVdn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Apr 2021 17:33:43 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1293FC061574
        for <linux-pwm@vger.kernel.org>; Fri, 23 Apr 2021 14:33:06 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id u16so33200150oiu.7
        for <linux-pwm@vger.kernel.org>; Fri, 23 Apr 2021 14:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SCQMPElA0WHlgUF2PvhQ3Cu0lyVrRmp2lWXbo4Z3WV8=;
        b=x1bDHHRuDlQ+knBxxOjwQ6+gpr3D1n66l9uKhtvhJOdGqAb6/laF3Ysbo21kiRMxYz
         OoOgaF0aY/ZgZoUFWtv7im6qa83S3cADRd7hop5oogSadf4z1tZehLRPSWiSX1EBPMVa
         W06J15SCe6R5ZEcKmIFqjkoa/kXQfx7s4xX5brvJ7VnF+2ls6pXRAtawy0nLdzaVeYxL
         MpXhaTFIcYqGqbWa3Hl2+X3N4n/6csqeADi1mXcYNgFJxrKAnx7VRs0GmeVezdf0w/Qd
         H3Yb3S8GeSO02IaVoVVyPuH7pumgc6IJctGxkLMO+pNrYmV8mx19s8afLllx0Co98oGe
         rLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SCQMPElA0WHlgUF2PvhQ3Cu0lyVrRmp2lWXbo4Z3WV8=;
        b=bleLObEbplVFhpfWZ3/wx4vlQq9hmZMvlYBmciQIME5TZWT9dtXtXKjxUI0Rtf7MPa
         iPaqeBKYEwBhpclC0kekw4p8gxxneMQptsuK0aIf+kZbTLTdtqouE6UFfg2JMbw+iqn5
         tkdnes7wbH266Woxu36ddmX7ehGIUbsJcxpu31Crz47nGsJOsbRQDI6GAqZe+/L0Jdgp
         mUCfzVv38HMjE9ZqgnxFbqIyvx6vBsqYemT4Tx8DaWfqOIOK/d/7IO4N8I5A25tJATbX
         pXDMmUKjPCCtwzaqezGf9NggzkDkceYGha2KTonrO0KrURNSHC4yHWxPUPxeR++07291
         +NEg==
X-Gm-Message-State: AOAM533dmFpLvZGRSbaaAWH9bHNk6+xsSHrzwYadVGrjTykekuOyKRHD
        d2jbGJk/REyU9D+Pxqqfw+CYFYGSYcwf2w==
X-Google-Smtp-Source: ABdhPJzscdZhFyTFiR9k17dKZYLfujVNwIT+PP8DQHzVaqsvux2IjQjZgADO1BMOOJwgoN6TH9c4NQ==
X-Received: by 2002:a05:6808:10cc:: with SMTP id s12mr4266218ois.148.1619213585404;
        Fri, 23 Apr 2021 14:33:05 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 34sm1679951otf.38.2021.04.23.14.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 14:33:05 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] pwm: Introduce single-PWM of_xlate function
Date:   Fri, 23 Apr 2021 16:33:04 -0500
Message-Id: <20210423213304.1371143-1-bjorn.andersson@linaro.org>
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
- Included the pwm.h change in the commit...

 drivers/pwm/core.c    | 24 ++++++++++++++++++++++++
 drivers/pwm/pwm-pxa.c | 16 +---------------
 include/linux/pwm.h   |  2 ++
 3 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index c4d5c0667137..25ed23cdf0d3 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -176,6 +176,30 @@ of_pwm_simple_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
 	return pwm;
 }
 
+struct pwm_device *
+of_pwm_single_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
+{
+	struct pwm_device *pwm;
+
+	/* sanity check driver is single PWM */
+	if (pc->of_pwm_n_cells != 1)
+		return ERR_PTR(-EINVAL);
+
+	/* validate that one cell is specified */
+	if (args->args_count != 1)
+		return ERR_PTR(-EINVAL);
+
+	pwm = pwm_request_from_chip(pc, 0, NULL);
+	if (IS_ERR(pwm))
+		return pwm;
+
+	pwm->args.period = args->args[0];
+	pwm->args.polarity = PWM_POLARITY_NORMAL;
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
index 5bb90af4997e..0ac242a5b5e4 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -405,6 +405,8 @@ struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
 
 struct pwm_device *of_pwm_xlate_with_flags(struct pwm_chip *pc,
 		const struct of_phandle_args *args);
+struct pwm_device *of_pwm_single_xlate(struct pwm_chip *pc,
+				       const struct of_phandle_args *args);
 
 struct pwm_device *pwm_get(struct device *dev, const char *con_id);
 struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
-- 
2.31.0

