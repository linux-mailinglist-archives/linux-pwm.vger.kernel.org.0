Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A7B4546CC
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Nov 2021 14:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237353AbhKQNF1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 17 Nov 2021 08:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237224AbhKQNF1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 17 Nov 2021 08:05:27 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7646C061570;
        Wed, 17 Nov 2021 05:02:28 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso2591620pjb.0;
        Wed, 17 Nov 2021 05:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T9wFYxQtaBLY+620FBB4AOdc1g1L+gWeoP+IDYOuvB0=;
        b=BcGsBKzjpfT2cfhVXPrxaTgTJ6P2hxflSdDTUeB4SFzOvrGTGHnDOmDBLkf3LbNzuy
         Sj8m4ZlmSfBxNMasl100OtEZKRwcq9M5cRWUSl1sAfWLtfQREkUEJUryGAohg8ITokMt
         zbMSh9xipRY2nzmJeTpCPbVjMQsfkdEizPVMr+R+5luUL0JAGUb3MZ93YOxP+tNyHW6k
         mSkv3XeS/MlEgFcTsZUG+wM1wijCDhpp+KswGwNNQmygO2AGd/nscMbQnjAzp+o9buin
         JwZARNRQ/wxA6wz6hYIL7MoT9mY75ZiwXWlBMRRab/yhES57Vx37nMvkc3OWAoJxTrD8
         3MCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T9wFYxQtaBLY+620FBB4AOdc1g1L+gWeoP+IDYOuvB0=;
        b=EinE86QQMGlyK+Ly/+5UxWUFQcciDtCby8Kg5YqrywdKonjXsFxmFpoMRG0zFz37Tv
         Psl0PMkVnoWWKvqZZOND+t6O9DGnwjnFWMpk+4F8Pb57E+pKlCRBs/vEQWVwxYWrTQJ0
         TIqCDShjBLOujBd0x/r6dyGFqRf92jIpECMeAtsvqpy8DRjLtRbTLVELDDjK+ooPf1AJ
         S8r23VxmHEEyLCCOh4AiBlzO29AkNquKysDzT7ybBMkb5QKMITNoc+8liMlTvPsNiPxO
         wWu8gpnYy2qdPOP9wUpqgodk/rnaWKQuFtJYV9pqoMyQqx2fXf0heyDs5uLrdkuOmy4y
         Jx2Q==
X-Gm-Message-State: AOAM532Ec3kCyGlom+zG2dZhZaw1Ho8/GlV5AiTcloqEzCdot312ZZe8
        YBtf6KWJTl44BVEBRYi2IwM=
X-Google-Smtp-Source: ABdhPJw2olpTDo73SDdNXQZ99Vt9E6aBTbKoMzeHqCL1I0bUJDSJokzIal1MceB3KbTIP0/xiM/85g==
X-Received: by 2002:a17:902:bc85:b0:143:954e:8548 with SMTP id bb5-20020a170902bc8500b00143954e8548mr53668515plb.82.1637154148313;
        Wed, 17 Nov 2021 05:02:28 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c16sm16929626pgl.82.2021.11.17.05.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 05:02:28 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     u.kleine-koenig@pengutronix.de
Cc:     cgel.zte@gmail.com, deng.changcheng@zte.com.cn,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, thierry.reding@gmail.com,
        zealci@zte.com.cn
Subject: [PATCH V2] pwm: rcar: Use div64_ul instead of do_div
Date:   Wed, 17 Nov 2021 13:01:44 +0000
Message-Id: <20211117130144.161788-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211117112559.jix3hmx7uwqmuryg@pengutronix.de>
References: <20211117112559.jix3hmx7uwqmuryg@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

do_div() does a 64-by-32 division. If the divisor is unsigned long, using
div64_ul can avoid truncation to 32-bit.

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

