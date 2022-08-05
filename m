Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7131958AE79
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Aug 2022 18:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240963AbiHEQvF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Aug 2022 12:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240988AbiHEQuy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Aug 2022 12:50:54 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4AD1C125
        for <linux-pwm@vger.kernel.org>; Fri,  5 Aug 2022 09:50:50 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso1516772wmq.3
        for <linux-pwm@vger.kernel.org>; Fri, 05 Aug 2022 09:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=MnRM0/0IvgGtmALzay+KKuxuL9L7ec4/ENnxhkmEu0Q=;
        b=jPNeDsvM9ON44JSlp39pKrw4+Qw+Wmp0x7j1vZHjc9WudWV8dVShaQsp8qS2bKEnh6
         r+Ru+w9wNlXfFOmq09dJhq5OzqbB/Zc3U2D/XEqmYCo+GCAaG6egbHak0rtaQOZYX1vM
         wuVVnNRQ0PtWAMHh4OAjoFL/3U55OTR6R2Stv0jIeB9r6uQduC/yWuUjvWqTCvgxUAsF
         eN1Shm5ES65XWq32IzZ0Dg6xiHuvp4z8e1Mf0Z6+wJLNfoWF5Z+GyZhFpFWCFMd2eQvi
         emQeHVs8/8HzRfYy/ZBls7NCtc6KWuDSFAimESy5FW3Awho530DJHRYTWWn+xIpJ9gNe
         AQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=MnRM0/0IvgGtmALzay+KKuxuL9L7ec4/ENnxhkmEu0Q=;
        b=wnRg2Iz5pUQ83ohgzJ96ULybkmpJ3bhPZJ2niwfhzhwLpCJY2GUX/99WADTk6A/cJW
         rwa3zLAPE2zI8+1iaCf3iZaCu5VAsdTkajhtDPxDEu6D/To1zr6xM8qK9RVIPkbDStrn
         6pHuEzuQkxJ4ueTGAX9GeJSrCHmaAh0G8ydeL8RZm1qk8VKmRw55mK0kek/XmAC9fvdH
         X+4z3WyJidBlGTvrKkZF6uwLWZwuFJBuX4ZnNu44lmdnnxelt5rlX2/wPf7z1O6Q9DEW
         NpcbmV7HMjIJwtnYWPTJlGdV96R8cJo7GA5zKdAkyQR6m5mx8ASyVSqofTAe1o7g0Y0u
         SpAA==
X-Gm-Message-State: ACgBeo0p5ClIk/8+/jBny1CwyS4BJhECfW5RfX8XBq+dffu43Eq3pxKK
        +UdXl706yNUkklVBpt+dlQfRK3MP9Rrq4fHR
X-Google-Smtp-Source: AA6agR44ih/XPWj1ROUhl3PpcKPXw9THsTAXfnCoTFP9AsDJXUtGec86TVYz2HmjLlz96qab7qg1aw==
X-Received: by 2002:a05:600c:4e94:b0:3a3:455b:a277 with SMTP id f20-20020a05600c4e9400b003a3455ba277mr5226727wmq.198.1659718248877;
        Fri, 05 Aug 2022 09:50:48 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id h28-20020a05600c2cbc00b003a4f08495b7sm11325374wmc.34.2022.08.05.09.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 09:50:48 -0700 (PDT)
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
        Jude Onyenegecha --subject-prefix=PATCH v3 
        <jude.onyenegecha@sifive.com>, Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH 7/8] pwm: dwc: add snps,pwm-number to limit pwm count
Date:   Fri,  5 Aug 2022 17:50:32 +0100
Message-Id: <20220805165033.140958-8-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220805165033.140958-1-ben.dooks@sifive.com>
References: <20220805165033.140958-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index 5c319d0e3d52..5edfb8f8acbf 100644
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

