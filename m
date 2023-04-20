Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480AA6E8E28
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Apr 2023 11:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjDTJfl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Apr 2023 05:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbjDTJfR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Apr 2023 05:35:17 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC4935AA
        for <linux-pwm@vger.kernel.org>; Thu, 20 Apr 2023 02:35:14 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-52160f75920so582060a12.2
        for <linux-pwm@vger.kernel.org>; Thu, 20 Apr 2023 02:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1681983314; x=1684575314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ryva+FQmb09SgOiCE7P4pQBiT6BdeSdh3y4Qn91oZ9M=;
        b=d4ER6huQjMtUV4wHdMb9ME9KpU3d2FGtvqsgiDTUlUyLvDePcXJ0PKh98S6NEnsa2G
         XpQA1rCPbkz2/bCmmRIw/iKSY7Jc/iG598aSV3OIGqyeUx4IBcGUZKtO4vIBwSqT9r0P
         p5FSKMM0VYyfyGjMat2EmIyNNAimvy6yE8WNCYrKGxEhDc/YAWf+Pc70ybdNvL8zO+JA
         QpNju3Pf0hJEFC4gFdxrSa9X6mz6r/WWX5OMVqulCgrYK2qAWDlWa525eBQUcoKAVN9a
         K70k1rCm/C/aU30qmXDSBl7EG/LeuOhixKwJILpFQprjgRGLNArBduUmQD/Zx6K1YSUy
         l2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681983314; x=1684575314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ryva+FQmb09SgOiCE7P4pQBiT6BdeSdh3y4Qn91oZ9M=;
        b=jCgbEpS0uaAKWOR18ArUCYhBeYl0f2dAhLS4vBiuog94yao9N65OXOkJRJarVOFrWY
         RDuOygNrM7O5ZWefM4iA9UG2+LICx+pWnqHtNP9J7apzzAXP/cymCAuEXt9L//nvRCx+
         wZsQQoj0PZXp6UKz7nZ7DNcUpiLr7TCsETKkj9hXtcgcDUE5bWWXWPBqxzHTh9+hpMiZ
         4SPYxyjQyjKKf4yGWYYmwYgQrpsMk0nzPoJCapZE6rSig0PNX8F6R/vfU3BXsJMMZJzQ
         WGJlOsdbKkmxf6hjdMUgvKL3iwioiRX1mYeyTqVeF3mie6PC1vKtgorgF9BvcHbuRZmO
         zGUQ==
X-Gm-Message-State: AAQBX9epDwon6c4jJtUZsd4enXnNqVp6/vCuyVoMFnZrO9SQExFaQ08/
        XQ3yDaO8r9SUzM6+Dblan6HpiQ==
X-Google-Smtp-Source: AKy350br6fKdRCr0Nj4YKMv9Nvtjoq+VqjzrOMC15lETcCmUtAqFU5evu54VS9v+FLXPiour7tCHKQ==
X-Received: by 2002:a17:90b:10c:b0:23f:9fac:6b35 with SMTP id p12-20020a17090b010c00b0023f9fac6b35mr1017558pjz.39.1681983313820;
        Thu, 20 Apr 2023 02:35:13 -0700 (PDT)
Received: from hsinchu15.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id p5-20020a63c145000000b0051ba9d772f9sm781551pgi.59.2023.04.20.02.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 02:35:13 -0700 (PDT)
From:   Nylon Chen <nylon.chen@sifive.com>
To:     aou@eecs.berkeley.edu, conor@kernel.org,
        emil.renner.berthing@canonical.com, geert+renesas@glider.be,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nylon.chen@sifive.com, nylon7717@gmail.com, zong.li@sifive.com,
        greentime.hu@sifive.com, vincent.chen@sifive.com,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 2/2] pwm: sifive: change the PWM controlled LED algorithm
Date:   Thu, 20 Apr 2023 17:34:57 +0800
Message-Id: <20230420093457.18936-3-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230420093457.18936-1-nylon.chen@sifive.com>
References: <20230420093457.18936-1-nylon.chen@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The `frac` variable represents the pulse inactive time, and the result of
this algorithm is the pulse active time. Therefore, we must reverse the
result.

The reference is SiFive FU740-C000 Manual[0]

Link: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b16acba_fu740-c000-manual-v1p6.pdf [0]

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
---
 drivers/pwm/pwm-sifive.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index 393a4b97fc19..d5d5f36da297 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -132,13 +132,13 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct pwm_sifive_ddata *ddata = pwm_sifive_chip_to_ddata(chip);
 	struct pwm_state cur_state;
-	unsigned int duty_cycle;
+	unsigned int duty_cycle, period;
 	unsigned long long num;
 	bool enabled;
 	int ret = 0;
 	u32 frac;
 
-	if (state->polarity != PWM_POLARITY_INVERSED)
+	if (state->polarity != PWM_POLARITY_NORMAL && state->polarity != PWM_POLARITY_INVERSED)
 		return -EINVAL;
 
 	cur_state = pwm->state;
@@ -154,10 +154,13 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * calculating the register values first and then writing them
 	 * consecutively
 	 */
+	period = max(state->period, ddata->approx_period);
 	num = (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
 	frac = DIV64_U64_ROUND_CLOSEST(num, state->period);
-	/* The hardware cannot generate a 100% duty cycle */
 	frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
+	/* The hardware cannot generate a 100% duty cycle */
+	frac = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
+
 
 	mutex_lock(&ddata->lock);
 	if (state->period != ddata->approx_period) {
-- 
2.40.0

