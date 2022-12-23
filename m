Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C50655237
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Dec 2022 16:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbiLWPie (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Dec 2022 10:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236422AbiLWPia (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Dec 2022 10:38:30 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CE337F90
        for <linux-pwm@vger.kernel.org>; Fri, 23 Dec 2022 07:38:28 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h7so4897155wrs.6
        for <linux-pwm@vger.kernel.org>; Fri, 23 Dec 2022 07:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SdKoJam1KKdYl+ZS8hBn9qpHaB89KQkUoXzOnMw6QQ=;
        b=eMHE3ifyHwq7DBESvLs+KwGR2m0Y40+X3Frl1shhGCohSAXv3eveeNglOqp/4TzAXC
         HIQBR+9yfIwDQtGvmwVXNW/Fb5xLL6AAfyrC3OawLdGZFzhi7lGFGN8nCRCQ3OYRho5/
         6BpkpttCeD+Js59R0Uf71Ug8omMmf3aN8X6YVDax81g08TBALpsqOUW0ZjoLjpMgrNXS
         PT7d4YYAVmply/EjKxv6AX8D0+fXoTKNRTCh8kxJJaouL/pEphMi4CqDzgHHomDKiihB
         HOT9UHEAsMmIZK1DqeBCkhWVrIcxBRNxb2Zcp3Sa1UWtszTfBH7t20+LIJuf1aTqLGg/
         EVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SdKoJam1KKdYl+ZS8hBn9qpHaB89KQkUoXzOnMw6QQ=;
        b=XXFVvNnYOgzbBGmPSJLrOlG/iK8ZBxa5vnk/G4j+9c0KBwhEoXCUukorkwmTS+Su3O
         8fhsY7t620wH/T9NMp1bPUNXSH7BvwHOPGgSQane6WhmBQV7h7TGLGQBMLFzJzvdk6ny
         N7emMIvQr0Afx3AznKU/mB4pIKcu67/mwIjBnmpqeCf8fV0T0afxpGrTarn+pfwRWdvl
         70Sdlz0wDkN5V+Ctx4Zthe5BmFv/YwAACIvb92VP5fkyaNkXv9UJcxBoflOWKy1ApYxq
         C/Xo7gqn3T6QC1XQUv82kd+thRF7j1XUyH1U66icWEAse5ru3GodNhtYKInP0tbdZ3RF
         4wog==
X-Gm-Message-State: AFqh2kqs4/hrM1VJ2VRmA3ZNxnkSV4SMQ3ThVxGx6RMdzWEIfP7ZO8Kv
        0ji4nr1+mVkirIWiJu/EI/vOVF4rGpBolDQbtOT60tRPJJiZJYFimtHOnh4yAEu3Jmj5Po3ZZu1
        pQi75UU83WHp1q2fGVrbiBRlRomyPIxo5xJFiVatNac7KXxS7hM8qwL0YQPhVNjJM6IirdVXkH+
        AUfQ==
X-Google-Smtp-Source: AMrXdXv/HH3IlYJcA2aohjbZtgVWaSs3osRL51qncwx+0JP9cfrmd0SKMNjjQA30LiRZy3yixwncDQ==
X-Received: by 2002:a05:6000:70a:b0:263:542c:5918 with SMTP id bs10-20020a056000070a00b00263542c5918mr7163867wrb.38.1671809907080;
        Fri, 23 Dec 2022 07:38:27 -0800 (PST)
Received: from rainbowdash.. (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id m5-20020adfc585000000b00236488f62d6sm3491610wrg.79.2022.12.23.07.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 07:38:26 -0800 (PST)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH v7 04/10] pwm: dwc: move memory alloc to own function
Date:   Fri, 23 Dec 2022 15:38:14 +0000
Message-Id: <20221223153820.404565-5-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221223153820.404565-1-ben.dooks@sifive.com>
References: <20221223153820.404565-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

In preparation for adding other bus support, move the allocation
of the pwm struct out of the main driver code.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 drivers/pwm/pwm-dwc.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index c706ef9a7ba1..61f11e0a9319 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -196,13 +196,29 @@ static const struct pwm_ops dwc_pwm_ops = {
 	.owner = THIS_MODULE,
 };
 
+static struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
+{
+	struct dwc_pwm *dwc;
+
+	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
+	if (!dwc)
+		return NULL;
+
+	dwc->chip.dev = dev;
+	dwc->chip.ops = &dwc_pwm_ops;
+	dwc->chip.npwm = DWC_TIMERS_TOTAL;
+
+	dev_set_drvdata(dev, dwc);
+	return dwc;
+}
+
 static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 {
 	struct device *dev = &pci->dev;
 	struct dwc_pwm *dwc;
 	int ret;
 
-	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
+	dwc = dwc_pwm_alloc(dev);
 	if (!dwc)
 		return -ENOMEM;
 
@@ -226,12 +242,6 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 		return -ENOMEM;
 	}
 
-	pci_set_drvdata(pci, dwc);
-
-	dwc->chip.dev = dev;
-	dwc->chip.ops = &dwc_pwm_ops;
-	dwc->chip.npwm = DWC_TIMERS_TOTAL;
-
 	ret = pwmchip_add(&dwc->chip);
 	if (ret)
 		return ret;
-- 
2.35.1

