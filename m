Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A591559646E
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Aug 2022 23:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbiHPVPa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 16 Aug 2022 17:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237564AbiHPVPW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 16 Aug 2022 17:15:22 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3403B7E805
        for <linux-pwm@vger.kernel.org>; Tue, 16 Aug 2022 14:15:05 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bs25so14079506wrb.2
        for <linux-pwm@vger.kernel.org>; Tue, 16 Aug 2022 14:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=vfBwzF4rBTQWX76kzjBGU8pHOvCFE0ZGsFmgL4Ysnj8=;
        b=YTgW1xsIf6ErLzD2iA8TpuGl1vu1Jg42HLk63//faqV0F0fGxWnr8xyqH4xhxe6GMM
         jkXIZPysqJ4iIQEKHm26iMOIp0zNxHP6T5eoPabQlsrh11ohV/jjX0ZI7LTeRGiQ20kI
         2afGCx3PzyvpI6PWWEdsf8kmYHO1vzWqyOAPVkQ3rL/YnJYyHhU9CMX3J+IqvMS2ht/g
         qz0jkwPpqrmR8bt581eEdjqe0PkcYhuX69DkBXsreoxkBYhVVoRtU6qvQRjN4DchphpT
         B9VEJVdoI1guO9Flxt7ivU2j4GdqaILVHiJVyc65NPsUEobDvW6ThpolTeAbpRh6ALQG
         X7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vfBwzF4rBTQWX76kzjBGU8pHOvCFE0ZGsFmgL4Ysnj8=;
        b=1FA7OXc4P6nElvxkmnESgfEv+1d3ETeUOibT6p/tv5akA16rmFC/oAvBwkYmsfVwet
         3cizqREyGx3k4mw8fO9vG/aUL+/r5kEVRasEJcND2urU+IhKdo+gS3bIIBHHDtt5VPjB
         aaDohoWgwd4KEPZVlO8jvAYWhgxvGUzS3kQrwSP0m/GY8+71VC32gATXSGDjHBKXfG35
         I5I+xoqItCCV7CieIli96YJFqbZZUn+dXpA57CUvGKjI9QkGc1BVRkwKaOZ58KrqZ8Ti
         oHDnFDJ6aq/kQvu5u1t7HxX7H/91e7gca0gfFgdNayxH+7ulP4yA6Mogv4NWQxBQEDe3
         bcdg==
X-Gm-Message-State: ACgBeo0kt/By7sSC19pYnWjQgnArM5MgdD4+jqevYSfr5E5S1yLAfz+C
        SmbAFOmLtlvTOw6EZOJFyysCxIx5Fr9U9w==
X-Google-Smtp-Source: AA6agR5yZXOyGj6Ixhwe3p4B5VxRBMFdbaBa9BYBCEq36I0L5rcwum9l7q5l5QZuw2rYF7R1IC+Luw==
X-Received: by 2002:a05:6000:1545:b0:220:61fa:64a with SMTP id 5-20020a056000154500b0022061fa064amr13124840wry.174.1660684503637;
        Tue, 16 Aug 2022 14:15:03 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id r4-20020a1c4404000000b003a3170a7af9sm23913wma.4.2022.08.16.14.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:15:03 -0700 (PDT)
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
Subject: [RFC v4 09/10] pwm: dwc: add snps,pwm-number to limit pwm count
Date:   Tue, 16 Aug 2022 22:14:53 +0100
Message-Id: <20220816211454.237751-10-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220816211454.237751-1-ben.dooks@sifive.com>
References: <20220816211454.237751-1-ben.dooks@sifive.com>
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

Add snps,pwm-number property to indicate if the block does not have
all 8 of the PWM blocks.

Not sure if this should be a general PWM property consider optional
for all PWM types, so have added a specific one here (there is only
one other controller with a property for PWM count at the moment)

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 drivers/pwm/pwm-dwc-of.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pwm/pwm-dwc-of.c b/drivers/pwm/pwm-dwc-of.c
index d18fac287325..65c7e6621bba 100644
--- a/drivers/pwm/pwm-dwc-of.c
+++ b/drivers/pwm/pwm-dwc-of.c
@@ -21,12 +21,20 @@ static int dwc_pwm_plat_probe(struct platform_device *pdev)
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

