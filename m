Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F6E455305
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Nov 2021 04:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242392AbhKRDFc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 17 Nov 2021 22:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242292AbhKRDF2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 17 Nov 2021 22:05:28 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74A7C061570;
        Wed, 17 Nov 2021 19:02:28 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso4377980pjb.0;
        Wed, 17 Nov 2021 19:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FdfDVJthM5pyVxZWm3E3cAghysFpOZNuY3ecMXIdjc0=;
        b=pPIn+oNH7I0U6CM4c9jtQlJ/MNsSQZ1BnY8Ik1mg2+LWfY5vWmOHR7b+17llHXnavL
         exL8Q0D9ZDZ+upREC3asPJTSawLPOcChL3qhdduBkxCWt5jYeTULY+fYrwS7vYO1p5YO
         kv3de+tooEE0050mhd8Gjkr1ftjARpfFSmUBTO2Kppy+a5RcI8o6Dpg4LKy5LUlYapWu
         CmScHAaFGPvHnjy9WR9/oyhW0LQKmopPUKZPUMekakqgkWfSQp6xLeLvuXTs/A5jrwiY
         uIAaxP92lWLjr6VGH3D9jrLYMGwfEes1FIwkVA51+JR8VxyxFSSBqMRs5Unz9LGJigcu
         wx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FdfDVJthM5pyVxZWm3E3cAghysFpOZNuY3ecMXIdjc0=;
        b=qT1ywV/mafcUFcrVq6VtCs2sd3ypSpjNES31dcoz/ycknAf2k2SK47qIfJOMZ4COGk
         rDuH14vo3CqFLkyRINn9dYfFd2esqY9xltirXPECqsSciXAJNVXEQwIusqXMMxAkYK6T
         A/LmxrjzgCY/eJOHpMnG/5JS53GmY9Q1P9MGenJuxuyyURDzd+sgJurOtXmkiO83E61g
         gTg6UcrflA0M/WY9JtRfKeMs/mE4kqXNjiBcCQ2PrFvpYesuLyvOJyGIoOpjbCHQGutT
         sReOX9Phudzmp6BSaj97e8uVKM40MFuFj26S6Rs39/4V4VCYo3GVvgBWTy7cZrd5+Tlv
         UY1w==
X-Gm-Message-State: AOAM533p5KnflbC0bxO423IqVXmhsmOmouP7XHlzvmgB4cHkNN6o1Ees
        2W9qXsWgzR9ul160ODQa9f8=
X-Google-Smtp-Source: ABdhPJx4npN9dFxdOsPvhvpv/HYVXZsBAhC13Zy9gQU6YHLgFB+34Eo8heuO5vEz7EKbqgZnK5hlMA==
X-Received: by 2002:a17:90a:1b45:: with SMTP id q63mr6074281pjq.135.1637204545163;
        Wed, 17 Nov 2021 19:02:25 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id mg17sm901119pjb.17.2021.11.17.19.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 19:02:24 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     u.kleine-koenig@pengutronix.de
Cc:     cgel.zte@gmail.com, deng.changcheng@zte.com.cn,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, thierry.reding@gmail.com,
        zealci@zte.com.cn
Subject: [PATCH V3] pwm: rcar: Use div64_ul instead of do_div
Date:   Thu, 18 Nov 2021 03:02:15 +0000
Message-Id: <20211118030215.163306-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211117130144.161788-1-deng.changcheng@zte.com.cn>
References: <20211117130144.161788-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

do_div() does a 64-by-32 division. Here the divisor is an unsigned long
which on some platforms is 64 bit wide. So use div64_ul instead of do_div
to avoid a possible truncation.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/pwm/pwm-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index b437192380e2..fb475c188e1e 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -111,7 +111,7 @@ static int rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div, int duty_ns,
 	u32 cyc, ph;
 
 	one_cycle = (unsigned long long)NSEC_PER_SEC * 100ULL * (1 << div);
-	do_div(one_cycle, clk_rate);
+	one_cycle = div64_ul(one_cycle, clk_rate);
 
 	tmp = period_ns * 100ULL;
 	do_div(tmp, one_cycle);
-- 
2.25.1

