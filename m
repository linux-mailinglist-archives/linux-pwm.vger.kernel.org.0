Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6B1580669
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Jul 2022 23:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237235AbiGYVW0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Jul 2022 17:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbiGYVWU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Jul 2022 17:22:20 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E428240B5
        for <linux-pwm@vger.kernel.org>; Mon, 25 Jul 2022 14:22:13 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id g2so9645645wru.3
        for <linux-pwm@vger.kernel.org>; Mon, 25 Jul 2022 14:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ePtuqWqYPBhdJN8WEi4SlaJQh1A+CofKVMmsD2hEro=;
        b=flMATs9FfZNHejSZRDXownmgiZVQaZXXqj82E3QjGjUtLcgTr6HqgiMeUq9SUrUCsd
         dz6IgGaXEX/QZXYlFduIdfiprt8Vps5ATJ8aiM9/eCkuKj1uwEFhBOeSAAvzu4+kVev4
         7gIz/z/MKHKYlTRVWVaZSDLDdA496tiGN9d9RO+l4ceTeIexNH2oLWY/rM66/N2JKRuU
         w0Ps6gBIWlNtb8s/X0Kp7F6NOiFMabjzrJhjac4Pv/BvFVinifJcOFpNgEG4TMshfQEt
         rOdT/K+CTQoCvs+fXx5TFsBcr0uBq/ny5sOffn/2dfMR7sFL9j9RnGXQF0VOpav7iewL
         U/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ePtuqWqYPBhdJN8WEi4SlaJQh1A+CofKVMmsD2hEro=;
        b=1L0BIB4u/QmFhJnXVQ8EFOnbKeN+CNCEXxxpYZ9hFhzXv0t4j+E8XMXUQr+smIJkQx
         4X6aO5iLysNMjvNxs1eU8Z1fy1DorGS9gLkR+17ienV8tXGJBgW0dW4QjspOhq48R1N9
         h/tEtRGg/AkrBqz0+bohGSncGe6tqKDb/bcN+F1VlPbBGaFQGAPkZPs1M4LoEblULpSQ
         X19jxoHysoYxqM8z+/BmM49t15P/92LqhFOLtb5M+HNt4Hhxr07VZkRZOFmo9Bzq7V7E
         BaqA4x0/PjwHornMa+sUXtAumWgiDuvc9OR1IJHLWs8XfEaD04vYbcoW9h/lGoDCM3gm
         2A/A==
X-Gm-Message-State: AJIora980eTmCwPgEJpQPHn/4YaK4rTEsB7eT8SuWwfyFS24VQ6bfdvu
        eCD5v365Oy8R9xqd5UYYxPq8GUaSu5tmdQ==
X-Google-Smtp-Source: AGRyM1s2Cl3ll8cI3X1ZTYAsH2vBZ9VLfAjoQ6zdxqCDeWJMCSDZX/lOyLsRL5M0u4LIgABeI8gXKg==
X-Received: by 2002:a5d:40d1:0:b0:21e:7596:65bf with SMTP id b17-20020a5d40d1000000b0021e759665bfmr7094282wrq.533.1658784131249;
        Mon, 25 Jul 2022 14:22:11 -0700 (PDT)
Received: from localhost.localdomain (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id i13-20020a05600011cd00b0021d6924b777sm12656348wrx.115.2022.07.25.14.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:22:10 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [[PATCH v2] 8/9] pwm: dwc: add snps,pwm-number to limit pwm count
Date:   Mon, 25 Jul 2022 22:21:39 +0100
Message-Id: <20220725212140.741644-8-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725212140.741644-1-ben.dooks@sifive.com>
References: <20220725212140.741644-1-ben.dooks@sifive.com>
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

Add snps,pwm-number property to indicate if the block does not have
all 8 of the PWM blocks.

Not sure if this should be a general PWM property consider optional
for all PWM types, so have added a specific one here (there is only
one other controller with a property for PWM count at the moment)

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 drivers/pwm/pwm-dwc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 9067f32869f8..da325133d297 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -328,12 +328,20 @@ static int dwc_pwm_plat_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct dwc_pwm *dwc;
+	u32 nr_pwm;
 	int ret;
 
 	dwc = dwc_pwm_alloc(dev);
 	if (!dwc)
 		return -ENOMEM;
 
+	if (!device_property_read_u32(dev, "snps,pwm-number", &nr_pwm)) {
+		if (nr_pwm > DWC_TIMERS_TOTAL)
+			dev_err(dev, "too many PWMs specified (%d)\n", nr_pwm);
+		else
+			dwc->chip.npwm = nr_pwm;
+	}
+
 	dwc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dwc->base))
 		return dev_err_probe(dev, PTR_ERR(dwc->base),
-- 
2.35.1

