Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B72655242
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Dec 2022 16:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbiLWPit (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Dec 2022 10:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236513AbiLWPif (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Dec 2022 10:38:35 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1CB4497F
        for <linux-pwm@vger.kernel.org>; Fri, 23 Dec 2022 07:38:32 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id l10so1494754wrv.7
        for <linux-pwm@vger.kernel.org>; Fri, 23 Dec 2022 07:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phcPBaGxOFAemR9YFsCDrE8yrlHvz+AvjsJ/jn+/KmI=;
        b=c1dW6fswqOk88Gf/Gfe0CipTkkN7B8IgXCJ91XtahUgCbDvyINz+s60nE+cNPvGYiq
         KuaO3sKmR8RlS5sCFXVEr7+A3xmEY0eaqV9GRw2b9laGJtkk6VHoPkf3PXvdqLfGjZES
         ttN7plU8rbZEuEpD/z6iJY3jvhjWytKe/6BFI8XJKvxJ4mDSzmu4OgJO5N3KFh4LzjS0
         hcnRtrDynE39dGiK1w5CnOCaqpjPMseXNoKrEftJzI0xb5+vT4cceaoOGoi2m3HtRXsi
         HLw5whmCyx3Yp8wR1CRUvUeVSHmHl0psYouf1sGi8H8KLe1mNPUiAAEcdQMIXcReFrGV
         GIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phcPBaGxOFAemR9YFsCDrE8yrlHvz+AvjsJ/jn+/KmI=;
        b=fhc1knlboHuRFRQexSvnzUyqJC2vDth6vrgs5oRk06w5s3yt+FRWMrILgTFJyPBIID
         OIa49zOyWtOHxLYwXKOWIGrHqGP0hXG9oRnEHBHB3k0KSNeNSAibqslcUDFJIhJ+FZcS
         Rz53ZDgGqEN28wVe+JfDB9iixHIbPIXQXmgEC/0ptlRPb1ufwQi9MPUzx8y3QwGIHmEF
         3/OAafdNj1POx7vXc+AGcBrPAWQrVsqPu7Vti/klRrb5PYTVIdkof14uf9oUnFTAy7DT
         s6vvcEpqX2PYadp3mBMRlY9QM/Nks43BWrgLC/IH6/XA5gm/u07NGIZM2Ec4VnLflc+s
         lwkg==
X-Gm-Message-State: AFqh2kqhBBBaHN8DOwBZK2XZzOUTGO/KBA2N87mTDrUheOFJnvM5T8Ub
        QtZWAmvj1PvRpLflH4cwZj2Wu/t9IgIMCdEP8p9a/JstdmqV1kCfiib7mXwi9B27Pj2PlAqRLVi
        3KvPLZj+S3RhCRd6sli6MIRaeE06KbFH1LrM20BpxL5B2mbXvqueu0sUrH/rUpcI7kxs9qfkY/K
        Js2A==
X-Google-Smtp-Source: AMrXdXvzRg5tkfF5mEKX29JXvprwKj7fgR8r4UAplyzSiteMPRrJxyXiKfyBtrlb56vxysLaSHPf4w==
X-Received: by 2002:a5d:4d8c:0:b0:241:fb7d:2f15 with SMTP id b12-20020a5d4d8c000000b00241fb7d2f15mr5331850wru.29.1671809911556;
        Fri, 23 Dec 2022 07:38:31 -0800 (PST)
Received: from rainbowdash.. (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id m5-20020adfc585000000b00236488f62d6sm3491610wrg.79.2022.12.23.07.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 07:38:31 -0800 (PST)
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
Subject: [PATCH v7 09/10] pwm: dwc: add PWM bit unset in get_state call
Date:   Fri, 23 Dec 2022 15:38:19 +0000
Message-Id: <20221223153820.404565-10-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221223153820.404565-1-ben.dooks@sifive.com>
References: <20221223153820.404565-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

If we are not in PWM mode, then the output is technically a 50%
output based on a single timer instead of the high-low based on
the two counters. Add a check for the PWM mode in dwc_pwm_get_state()
and if DWC_TIM_CTRL_PWM is not set, then return a 50% cycle.

This may only be an issue on initialisation, as the rest of the
code currently assumes we're always going to have the extended
PWM mode using two counters.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
v4:
 - fixed review comment on mulit-line calculations
---
 drivers/pwm/pwm-dwc.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 1251620ab771..5ef0fe7ea3e9 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -121,23 +121,30 @@ static void dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct dwc_pwm *dwc = to_dwc_pwm(chip);
 	u64 duty, period;
+	u32 ctrl, ld, ld2;
 
 	pm_runtime_get_sync(chip->dev);
 
-	state->enabled = !!(dwc_pwm_readl(dwc,
-				DWC_TIM_CTRL(pwm->hwpwm)) & DWC_TIM_CTRL_EN);
+	ctrl = dwc_pwm_readl(dwc, DWC_TIM_CTRL(pwm->hwpwm));
+	ld = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
+	ld2 = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
 
-	duty = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
-	duty += 1;
-	duty *= dwc->clk_ns;
-	state->duty_cycle = duty;
+	state->enabled = !!(ctrl & DWC_TIM_CTRL_EN);
 
-	period = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
-	period += 1;
-	period *= dwc->clk_ns;
-	period += duty;
-	state->period = period;
+	/* If we're not in PWM, technically the output is a 50-50
+	 * based on the timer load-count only.
+	 */
+	if (ctrl & DWC_TIM_CTRL_PWM) {
+		duty = (ld + 1) * dwc->clk_ns;
+		period = (ld2 + 1)  * dwc->clk_ns;
+		period += duty;
+	} else {
+		duty = (ld + 1) * dwc->clk_ns;
+		period = duty * 2;
+	}
 
+	state->period = period;
+	state->duty_cycle = duty;
 	state->polarity = PWM_POLARITY_INVERSED;
 
 	pm_runtime_put_sync(chip->dev);
-- 
2.35.1

