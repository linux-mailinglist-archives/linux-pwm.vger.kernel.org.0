Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC847CC584
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Oct 2023 16:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbjJQOES (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Oct 2023 10:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbjJQOES (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Oct 2023 10:04:18 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C1BF5
        for <linux-pwm@vger.kernel.org>; Tue, 17 Oct 2023 07:04:16 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c503da4fd6so58672061fa.1
        for <linux-pwm@vger.kernel.org>; Tue, 17 Oct 2023 07:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697551454; x=1698156254; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TsrDGDEum/5uA7iQIpJCzRkScaB2QGiVp3IoiHcOdaw=;
        b=TnZB0Wqc0VzP+t6Cuyzy1nn5obwWHM4YDtOYMO5GPpwlADzXEFqaR8rterAPwn6lQr
         Oz1WHrVsUKReOroHp2+1VUKr2CklRjVIXTNQ6//ylL/lLeKVW0JeoGQMOvebd/2R40q7
         sQR9j6I/knjsPPCQqOnZy1m1QIBDJ3K1sOE81JVsDrGNiM29puiYbqKaaXvbLGusJeZx
         d7lbme7HXNkZ1DvKdAAoetqSRg6rjxa85tN0VMdlbNQbw8su2bUzQsemr3D5Di9QTyoy
         pvg54g/lUmyEvXSL7d4cttLwBOHyAsNZuLMdv4CvsZBlEN299GfHkGgvZoup2/QJ+IkS
         TCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697551454; x=1698156254;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TsrDGDEum/5uA7iQIpJCzRkScaB2QGiVp3IoiHcOdaw=;
        b=lH8ntRBNGOE4MVuk6sz2bt28krGpvHVkEQ70pN1nckIYM5ze4fnYjWCZldn3Q52Oem
         asqepRvM1YzUl/cZCZ7yDCdw2QUObLo94WpQ+lkmueHH/PL2F8+ScaIyIfwLfx5fFHIh
         gFUaW1BcfonSQLfQawS70hfATf8IqycyI6RzVINjEuwFebKVXxLqYlYVVjY6sdLPLoHH
         csUrEvaxcJQZb+hcAjg04OJajF2JYQNyKumug9f1+TvvR5yOo766E8nR8x0M97V5sM7K
         2BLTbndDeNt96oSVYiwcJkO0azSsTUGIlXNya4psP3uF3+VOC+9UT8SHG/nLXk6CdN8J
         j8uw==
X-Gm-Message-State: AOJu0YxRiYUA6R3H2BjbXT3dUPJf5eZvP4n/Fuo8WvhT0OlhwBvmKhEH
        5zpncX5548rdvKoFVaBQe8I1QQ==
X-Google-Smtp-Source: AGHT+IG3knXmy/5vJWYi5wyeUzPAbczRcRkMPFoeND1u5tpRwFY2sHAcBNusoVs8ClImAyYJzR9CHA==
X-Received: by 2002:a05:651c:1a0f:b0:2c5:16c0:6239 with SMTP id by15-20020a05651c1a0f00b002c516c06239mr2087490ljb.51.1697551454222;
        Tue, 17 Oct 2023 07:04:14 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c234300b0040813e14b49sm1390701wmq.30.2023.10.17.07.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 07:04:13 -0700 (PDT)
Date:   Tue, 17 Oct 2023 17:04:08 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] pwm: samsung: Fix a bit test
Message-ID: <917e3890-7895-4b1c-bcee-4eecb3b7fe09@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This code has two problems.  First, it passes the wrong bit parameter to
test_bit().  Second, it mixes using PWMF_REQUESTED in test_bit() and in
open coded bit tests.

The test_bit() function takes a bit number.  In other words,
"if (test_bit(0, &flags))" is the equivalent of "if (flags & (1 << 0))".
Passing (1 << 0) to test_bit() is like writing BIT(BIT(0)).  It's a
double shift bug.

In pwm_samsung_resume() these issues mean that the flag is never set and
the function is essentially a no-op.

Fixes: 4c9548d24c0d ("pwm: samsung: Put per-channel data into driver data")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From static analysis and not tested.

 drivers/pwm/pwm-samsung.c | 2 +-
 include/linux/pwm.h       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index 10fe2c13cd80..acf4a0d8d990 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -630,7 +630,7 @@ static int pwm_samsung_resume(struct device *dev)
 		struct pwm_device *pwm = &chip->pwms[i];
 		struct samsung_pwm_channel *chan = &our_chip->channel[i];
 
-		if (!(pwm->flags & PWMF_REQUESTED))
+		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
 			continue;
 
 		if (our_chip->variant.output_mask & BIT(i))
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index e3b437587b32..3eee5bf367fb 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -41,8 +41,8 @@ struct pwm_args {
 };
 
 enum {
-	PWMF_REQUESTED = 1 << 0,
-	PWMF_EXPORTED = 1 << 1,
+	PWMF_REQUESTED = 0,
+	PWMF_EXPORTED  = 1,
 };
 
 /*
-- 
2.39.2

