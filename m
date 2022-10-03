Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D185F278F
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Oct 2022 03:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiJCB4U (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 2 Oct 2022 21:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJCB4T (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 2 Oct 2022 21:56:19 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1066A2F3B0
        for <linux-pwm@vger.kernel.org>; Sun,  2 Oct 2022 18:56:18 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id 10so4857562pli.0
        for <linux-pwm@vger.kernel.org>; Sun, 02 Oct 2022 18:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=pcaiLPT+DubPy9DtRxKsi+x1RvZhYRraLwIeAIcWiCA=;
        b=SQ6h3lF1dfN1IsZsHGCNSqIIJxO6IKipqeoGZ27AQd/lqoStmpFEA7g1QeHrOQmHCd
         4kV+LiV0yzqDRB96WFURQrPbqVxNPmprHKrCq4rYjAdjGGYfGE6eMEch7Jgy3Hrrvwl3
         9xdggZwPEGi91a1KMH5pUYZK0NBdaoi9R0LZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pcaiLPT+DubPy9DtRxKsi+x1RvZhYRraLwIeAIcWiCA=;
        b=tksgrkHOa0cd1dtT0Z1Vc4gjnkJBG4VMSbfXI+QR1NveAPguNL47VVj8SKpoaMIS4M
         vrz+JkK2nASaOT3NEfAH5IVjpj0hxZR9pyy7zlaZgPtENCk6G30AP1JejRNB36hpAiQz
         DhIr49iVdz5TBvdI/Y7z3PVR1o0g3HDqyyeD+rwnpEnqQ+LQEhHnyhE+33EhjWmmjpqq
         FNE/59/RO4N4hHv+fagvqiD7W5spnyCca3VuQPYaFpkMpVnBdTgbJPonGjro3/iRfU8I
         CL4X8ijEGl+F3twFXGRQQ5pB65Jdq9ENoTV+mFeoWfBFccdsLDivGfiMT3BhqKVKwmcC
         qa0A==
X-Gm-Message-State: ACrzQf3aIbKOkqFT9t9waNW1jT4YRgCvclSI/0Tz75wKdzR0zMLAUIph
        Ia0vs2okE5kRWvU2j2GjwTF+5g==
X-Google-Smtp-Source: AMsMyM7ojz1D74xtu+mYbxZpVxaePnSlkRhekMevnYE1t51qkyCXYts3XlD95UoALpOCmxdmJkbNdw==
X-Received: by 2002:a17:90a:f286:b0:20a:b521:7bbe with SMTP id fs6-20020a17090af28600b0020ab5217bbemr331750pjb.246.1664762177526;
        Sun, 02 Oct 2022 18:56:17 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.45.132.124])
        by smtp.gmail.com with ESMTPSA id s9-20020a17090302c900b0017b69f99321sm5893786plk.219.2022.10.02.18.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 18:56:17 -0700 (PDT)
From:   Doug Brown <doug@schmorgal.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Doug Brown <doug@schmorgal.com>
Subject: [PATCH v2 4/5] pwm: pxa: Wait for final PWM period to finish
Date:   Sun,  2 Oct 2022 18:55:45 -0700
Message-Id: <20221003015546.202308-5-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221003015546.202308-1-doug@schmorgal.com>
References: <20221003015546.202308-1-doug@schmorgal.com>
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

If the clock is turned on too quickly after being turned off, it won't
actually turn back on. Work around this problem by waiting for the final
period to complete when disabling the PWM. The delay logic is borrowed
from the pwm-sun4i driver.

To avoid unnecessary delays, skip the whole config process if the PWM is
already disabled and staying disabled.

Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 drivers/pwm/pwm-pxa.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index cf4d22c91929..edcef67f7ffe 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/pwm.h>
 #include <linux/of_device.h>
+#include <linux/delay.h>
 
 #include <asm/div64.h>
 
@@ -96,12 +97,16 @@ static int pxa_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			 const struct pwm_state *state)
 {
 	struct pxa_pwm_chip *pc = to_pxa_pwm_chip(chip);
+	unsigned int delay_us;
 	u64 duty_cycle;
 	int err;
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		return -EINVAL;
 
+	if (!state->enabled && !pwm->state.enabled)
+		return 0;
+
 	err = clk_prepare_enable(pc->clk);
 	if (err)
 		return err;
@@ -122,6 +127,18 @@ static int pxa_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (!state->enabled && pwm->state.enabled)
 		clk_disable_unprepare(pc->clk);
 
+	if (state->enabled)
+		return 0;
+
+	/* Wait for the final PWM period to finish. This prevents it from
+	 * being re-enabled too quickly (which can fail silently).
+	 */
+	delay_us = DIV_ROUND_UP_ULL(state->period, NSEC_PER_USEC);
+	if ((delay_us / 500) > MAX_UDELAY_MS)
+		msleep(delay_us / 1000 + 1);
+	else
+		usleep_range(delay_us, delay_us * 2);
+
 	return 0;
 }
 
-- 
2.34.1

