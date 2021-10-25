Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405E8439D1F
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Oct 2021 19:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbhJYRMO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 13:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbhJYRLb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Oct 2021 13:11:31 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DFAC061243
        for <linux-pwm@vger.kernel.org>; Mon, 25 Oct 2021 10:07:48 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id o26-20020a4abe9a000000b002b74bffdef0so3875927oop.12
        for <linux-pwm@vger.kernel.org>; Mon, 25 Oct 2021 10:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uGYjCOpl0+eswN9o3EVAbp0e5FxZjoodPge+J7gLiw4=;
        b=JVgdIxy6sniCI1Jza4syS2VrjwpO8z/1jGj1B0vfu6zfWYnWCykxcXA4YAYa8i3frR
         dEaBMgZIcUtIkBZ+DkPGphdyxQw8SPEX6huf0qoWjkGeFqoZpRZ7OvBtzKt4emkkM0dH
         +fFjrHH5IL6AkKiD4LErTOj63Znc4TT4Z3MvFQ7oyA8diRwVggEN9PoTimqN/j+Yf4lp
         FB5chTQ5CLfT20uwQE7VQOT0IIiFrQ9cfNuFlwxCHPsukTVLZpkFY1YDFOhYkUW/a7LP
         ZicYWsTJc03eFTSv7pikefiXahPzjan4v51GlBMlBPBwQ6Yz9OyVi5S1dO0/iel7Rrr+
         s6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uGYjCOpl0+eswN9o3EVAbp0e5FxZjoodPge+J7gLiw4=;
        b=8Kn8UFOJ1puq4NS8p1KbeKLNXe3krpwKYEAlNhIyFRGYaC1ZsWUxc+eQ7uVqFW+5WN
         7MPcNMeGlzfT++V5Aic4OFc6JeKYi6AA11SNVzDhpcLeJgmXar+0/dNCCRACOx3bmYjZ
         GsevfLYL1boSx3IOZ6v4l0IrFMI9d9aNzr4dXpprvcca6P8cQ/loqKg8FWe/NnKr2blw
         4+fvRV+1gVgN9HOVsHFN/9bB95Jq9h9ceqrG285fYspLIfGGeFzGHL0Ta8MgYyWnk+/U
         KNJ+4Dt2zHI5ZjblOUcn5JTnS+34OODXfcB7tDnIeqxLF00BMid96PHLLq/hB4ffksGr
         s8DA==
X-Gm-Message-State: AOAM530pCQgAIIU1AN7yi/BGoL5xC92+GiabirZQxr/7RIBTC3TSKG+a
        VIWWMpHI6IbsoDIEKcTMob/EQg==
X-Google-Smtp-Source: ABdhPJwF78iWwFkA9CuEMKBBAnLBRgaRoiwHCv29CmQ7CbnrCkWmzSL4r14o2hFk5gviC0G9tBHIEA==
X-Received: by 2002:a4a:4fcf:: with SMTP id c198mr13330118oob.26.1635181667796;
        Mon, 25 Oct 2021 10:07:47 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id q2sm3076003ooe.12.2021.10.25.10.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 10:07:47 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Robert Foss <robert.foss@linaro.org>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Steev Klimaszewski <steev@kali.org>
Subject: [PATCH v7 1/3] pwm: Introduce single-PWM of_xlate function
Date:   Mon, 25 Oct 2021 10:09:23 -0700
Message-Id: <20211025170925.3096444-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Tested-by: Steev Klimaszewski <steev@kali.org>
---

Changes since v6:
- None

 drivers/pwm/core.c    | 26 ++++++++++++++++++++++++++
 drivers/pwm/pwm-pxa.c | 16 +---------------
 include/linux/pwm.h   |  2 ++
 3 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 4527f09a5c50..2c6b155002a2 100644
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
index a9efdcf839ae..238ec88c130b 100644
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
 	pc->chip.npwm = (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1;
 
 	if (IS_ENABLED(CONFIG_OF)) {
-		pc->chip.of_xlate = pxa_pwm_of_xlate;
+		pc->chip.of_xlate = of_pwm_single_xlate;
 		pc->chip.of_pwm_n_cells = 1;
 	}
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 725c9b784e60..dd51d4931fdc 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -414,6 +414,8 @@ struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
 
 struct pwm_device *of_pwm_xlate_with_flags(struct pwm_chip *pc,
 		const struct of_phandle_args *args);
+struct pwm_device *of_pwm_single_xlate(struct pwm_chip *pc,
+				       const struct of_phandle_args *args);
 
 struct pwm_device *pwm_get(struct device *dev, const char *con_id);
 struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
-- 
2.29.2

