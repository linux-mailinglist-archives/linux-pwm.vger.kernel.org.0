Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0E12AF8C3
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Nov 2020 20:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgKKTO7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Nov 2020 14:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgKKTO6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Nov 2020 14:14:58 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF35C0613D1
        for <linux-pwm@vger.kernel.org>; Wed, 11 Nov 2020 11:14:58 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c9so3246645wml.5
        for <linux-pwm@vger.kernel.org>; Wed, 11 Nov 2020 11:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jd3wbJ3vVNk5UwiBFv65+aM2MiEbeIfcv2k72Ub2E5k=;
        b=QE26x8iCYKuwmH247YGo2r/C+qG+geqi1BUFTawDMsYavUsFsKciesxdSHCSnh3a0Z
         e+1ivhoVjjBgvEX+X3MqxoA74L86njQkSTzQ6PYYYMxy6MOaMazgtXx2u4Wuq+o7iSpS
         zB4rsDEfUXi3/9mTXm55FwgCl0HTzRJGBFY+XX/cWirFztToYGv+JzNdDPI7+RAZSfpJ
         m46LpjRb/RX5nIrVWbeN0IYxHLsn44jw8K7NyLrj4P/Ys+sB74Yd3+RTFitfaGBp7yPi
         +LU5TJ2C1EioTDENHHMuS1ftjnxxKggR0BpRwD0SQCvJgHrnf4iaZgYNIPAY7ERcX9o+
         O0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jd3wbJ3vVNk5UwiBFv65+aM2MiEbeIfcv2k72Ub2E5k=;
        b=IOSq3voyyJU3FjlTA2ygUJXqgnsFUOkuzTiPPYik3KaapPmtWobNgBCm6EsUr1urDw
         HCiTA+lREzVobSTYNvr89WY4iS3FLJr2CaYoKH4YhknAdw34zWHa/Ozlrd+z2505YpN+
         QCweRoGDVfOaxerQqRxyjQbb0Hec+rrPn1zCTpSpVzaQb6oug84JC7oWVeGfr+AlorNe
         obFFoAIo7QV6A0OHbz6jtXLIme21VnfOxXRaEqcoNtjgyXys7251WuHxyZC8GcQTNrxQ
         D9TbojzTzpH6Umo606+qtIwP3aGWFgMpN8/jPRBR3A9bM47X/6Y8d+p9LuJ7TEkFHJk+
         ZxIA==
X-Gm-Message-State: AOAM531GlSMhKwBIKFCzjIFmfl7ofms3y118pNAZfnCSO5Qfk2ieHNXa
        Lh0abVf3ufB2y9RaRZqSBgMsWaSt7ss=
X-Google-Smtp-Source: ABdhPJwEs5lXDzAIgLvkN/ZaRCRQmv7sdajM1AWQr37TRSX32PdHaYptv9uw++fSIjWxBJ29ftIAHg==
X-Received: by 2002:a1c:5f45:: with SMTP id t66mr5805265wmb.20.1605122096699;
        Wed, 11 Nov 2020 11:14:56 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id f17sm3581995wmf.41.2020.11.11.11.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:14:55 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Ajit Pal Singh <ajitpal.singh@st.com>,
        linux-pwm@vger.kernel.org
Subject: [PATCH 1/2] pwm: sti: Avoid conditional gotos
Date:   Wed, 11 Nov 2020 20:14:48 +0100
Message-Id: <20201111191449.409402-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Using gotos for conditional code complicates this code significantly.
Convert the code to simple conditional blocks to increase readability.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/pwm-sti.c | 53 ++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index a1392255955f..c6c82724d327 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -590,48 +590,43 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (!cdata->pwm_num_devs)
-		goto skip_pwm;
-
-	pc->pwm_clk = of_clk_get_by_name(dev->of_node, "pwm");
-	if (IS_ERR(pc->pwm_clk)) {
-		dev_err(dev, "failed to get PWM clock\n");
-		return PTR_ERR(pc->pwm_clk);
-	}
+	if (cdata->pwm_num_devs) {
+		pc->pwm_clk = of_clk_get_by_name(dev->of_node, "pwm");
+		if (IS_ERR(pc->pwm_clk)) {
+			dev_err(dev, "failed to get PWM clock\n");
+			return PTR_ERR(pc->pwm_clk);
+		}
 
-	ret = clk_prepare(pc->pwm_clk);
-	if (ret) {
-		dev_err(dev, "failed to prepare clock\n");
-		goto put_pwm_clk;
+		ret = clk_prepare(pc->pwm_clk);
+		if (ret) {
+			dev_err(dev, "failed to prepare clock\n");
+			goto put_pwm_clk;
+		}
 	}
 
-skip_pwm:
-	if (!cdata->cpt_num_devs)
-		goto skip_cpt;
-
-	pc->cpt_clk = of_clk_get_by_name(dev->of_node, "capture");
-	if (IS_ERR(pc->cpt_clk)) {
-		dev_err(dev, "failed to get PWM capture clock\n");
-		ret = PTR_ERR(pc->cpt_clk);
-		goto unprepare_pwm_clk;
-	}
+	if (cdata->cpt_num_devs) {
+		pc->cpt_clk = of_clk_get_by_name(dev->of_node, "capture");
+		if (IS_ERR(pc->cpt_clk)) {
+			dev_err(dev, "failed to get PWM capture clock\n");
+			ret = PTR_ERR(pc->cpt_clk);
+			goto unprepare_pwm_clk;
+		}
 
-	ret = clk_prepare(pc->cpt_clk);
-	if (ret) {
-		dev_err(dev, "failed to prepare clock\n");
-		goto put_cpt_clk;
+		ret = clk_prepare(pc->cpt_clk);
+		if (ret) {
+			dev_err(dev, "failed to prepare clock\n");
+			goto put_cpt_clk;
+		}
 	}
 
-skip_cpt:
 	pc->chip.dev = dev;
 	pc->chip.ops = &sti_pwm_ops;
 	pc->chip.base = -1;
 	pc->chip.npwm = pc->cdata->pwm_num_devs;
 
 	ret = pwmchip_add(&pc->chip);
-	if (ret < 0) {
+	if (ret < 0)
 		goto unprepare_cpt_clk;
-	}
 
 	for (i = 0; i < cdata->cpt_num_devs; i++) {
 		struct sti_cpt_ddata *ddata;
-- 
2.29.2

