Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21799627385
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Nov 2022 00:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbiKMXg5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 13 Nov 2022 18:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbiKMXg5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 13 Nov 2022 18:36:57 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6DDCE2A
        for <linux-pwm@vger.kernel.org>; Sun, 13 Nov 2022 15:36:56 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id h14so8911479pjv.4
        for <linux-pwm@vger.kernel.org>; Sun, 13 Nov 2022 15:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Kyvw31TgLffj7HAZf1IK3Or+xdvZYADxQVyVGeC+sM=;
        b=N+2owV/06cxVuwWWOH6E2/XJgD7bgJJo5PLjkrDciNlZOS4uhDPhc4fEs6fuUqZ00i
         gR9zJq8dKYiXzP4tqxfQIk1iPLgXuQdibHhwkv9P1omnHepoBMetEWeSFGyP8WZJuOZT
         YIFEDJzxPAJgClUFkiwG0KFuUshQvznwyJp1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Kyvw31TgLffj7HAZf1IK3Or+xdvZYADxQVyVGeC+sM=;
        b=1cqNGhBmqwXlc7857Zed6c6mVYrco6ks3waUFZI4YotyEVyhqJnFtkdIUZQfBZL3sn
         njxG9+UdJH/u9ygb/OgTxG0C2U1zDdGoYbYkS4wmv95tjJFpxZb5+hB9DQs+NnZAbjxj
         vX00XkYHfd6rTY7kHR8cLH6LtE3w38oPlCYxtE9OmsIJ6QLTo8fI67Pcp+WY+uDBjeE9
         9fIW+rvmcHIBK0N71cM3JHGOZmE7UCV11EZ0wH054x4vJKblj8+5sXeO/xhEBffOuCnd
         KUV2q3Ry1lofMcStnSnoH8zExHlV8QJ+YDVrJn5QMCBluI7nSDgVnQ65vmODfbtZ41a8
         BUqw==
X-Gm-Message-State: ANoB5pmculsMhOHSFtNQbGU3qgmplQGpis/d2EleOhwvoyOKE+7TRcVP
        8GaXGMXN9cxG67fHjQ8N7Z9uDw==
X-Google-Smtp-Source: AA0mqf41quJ8U+vXHa5URPajEA7I7bM+ukphrv5tbi6vNT+5eqyKmD1oF6nO1EENN3giJozmyYJUiQ==
X-Received: by 2002:a17:902:c385:b0:16e:e703:2186 with SMTP id g5-20020a170902c38500b0016ee7032186mr11520054plg.90.1668382615677;
        Sun, 13 Nov 2022 15:36:55 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id q14-20020a635c0e000000b004597e92f99dsm4641990pgb.66.2022.11.13.15.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 15:36:55 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Doug Brown <doug@schmorgal.com>
Subject: [PATCH v3 4/6] pwm: pxa: Use abrupt shutdown mode
Date:   Sun, 13 Nov 2022 15:36:37 -0800
Message-Id: <20221113233639.24244-5-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113233639.24244-1-doug@schmorgal.com>
References: <20221113233639.24244-1-doug@schmorgal.com>
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

Switch to abrupt shutdown mode in order to stop the clock as soon as
possible when PWM is disabled. This minimizes the possibility of the
clock being re-enabled while it is still in the process of turning off,
which will result in the clock ending up erroneously disabled.

Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 drivers/pwm/pwm-pxa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index cf4d22c91929..00063ead7c0a 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -85,7 +85,7 @@ static int pxa_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	else
 		dc = mul_u64_u64_div_u64(pv + 1, duty_ns, period_ns);
 
-	writel(prescale, pc->mmio_base + offset + PWMCR);
+	writel(prescale | PWMCR_SD, pc->mmio_base + offset + PWMCR);
 	writel(dc, pc->mmio_base + offset + PWMDCR);
 	writel(pv, pc->mmio_base + offset + PWMPCR);
 
-- 
2.34.1

