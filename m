Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D124546A1
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Nov 2021 13:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbhKQMxU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 17 Nov 2021 07:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237002AbhKQMxU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 17 Nov 2021 07:53:20 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23877C061570;
        Wed, 17 Nov 2021 04:50:20 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id b4so2138581pgh.10;
        Wed, 17 Nov 2021 04:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gg/M1YVJkeyGFjtOIOCWHjykInAEd9/M87sMnEMdxkQ=;
        b=Hz5kWjsgDl/G6zSXLQzxJSOiSjCZI/IvH8nrak30G+9TPdYqo8Ev2hnJrKZ87cvtwC
         t/Btk9XT8XNWmipdQwm2t26tTDOIJls3KQJCn6FUQumqgNTGBuWHZm52tfiBeekV9h87
         ZwK7M8IXqI2E1mijt37AxuRmuL/oWHInS6Wqs0w00zc3rRdNzY9JmOVujGxY6NlrAy2P
         iBhLxWgwvmsQMrf6B0iTbSXPe2GDnnxJ9MDysKKiqckfOfAI4F5ZeyNGta+d6EOGka2V
         i59IvZ6BqoLsXsrL/k/Zf41zq+MlOlNKR9WA/KjdtXueLdtbAs9VziZ8qO9vz8zu/6LT
         dVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gg/M1YVJkeyGFjtOIOCWHjykInAEd9/M87sMnEMdxkQ=;
        b=2yUfkCgaKvJRfKIulQ5hiGbrEk47oCZuGXCyeK0G9uhxSM5rr3A75bUeLtBu1zJOU1
         2GN61FY+8xKFjNkjsb8XFWGbDh9P8k7rBfpQojZJ91UjNtiOXYI3IwZe7XSUruIj3SCU
         3V+LPF75kFm8DOydd1C1IA+03gSyvKwr8xEP4dlayo2nr8UA+FoO0E+xUEbrAarPFeZg
         GyzRr5eHA9Jgcrr0SzpaAKRRjU+wsgkj7RpsQUzL3zp3uHSMdTDnElZAxEVUak8qF+vs
         X1cklb64g7eNodMGR5PP0vjwB5CW7MqX2fHk40VGU1VlPLjTS/RdYVpFrJ2uGie81MdB
         eaNw==
X-Gm-Message-State: AOAM5310AdJishIYMruG7iQNoKsN/Dx5lZjlaeOvogIQDJLlg29Yi2el
        KqqPkl94gnIV7GmJ5gc7AHc=
X-Google-Smtp-Source: ABdhPJyqUyAIIZqrR90bTv3uwpRZqs8y76gI35MmCV9Bx4R15Xc9e1uPaAH5wdPq95uYcc2vfNtceQ==
X-Received: by 2002:aa7:9a4e:0:b0:4a2:71f9:21e0 with SMTP id x14-20020aa79a4e000000b004a271f921e0mr6909185pfj.77.1637153419752;
        Wed, 17 Nov 2021 04:50:19 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id o16sm24725281pfu.72.2021.11.17.04.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 04:50:18 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     u.kleine-koenig@pengutronix.de
Cc:     alexandre.belloni@bootlin.com, cgel.zte@gmail.com,
        deng.changcheng@zte.com.cn, lee.jones@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, ludovic.desroches@microchip.com,
        nicolas.ferre@microchip.com, thierry.reding@gmail.com,
        zealci@zte.com.cn
Subject: [PATCH V2] pwm: Use div64_ul instead of do_div
Date:   Wed, 17 Nov 2021 12:46:53 +0000
Message-Id: <20211117124653.161699-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211117112400.bkscb2pyavonpfsn@pengutronix.de>
References: <20211117112400.bkscb2pyavonpfsn@pengutronix.de>
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
 drivers/pwm/pwm-atmel-hlcdc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index a43b2babc809..1ae3d73b9832 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -60,7 +60,7 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
 				return -EINVAL;
 
 			clk_period_ns = (u64)NSEC_PER_SEC * 256;
-			do_div(clk_period_ns, clk_freq);
+			clk_period_ns = div64_ul(clk_period_ns, clk_freq);
 		}
 
 		/* Errata: cannot use slow clk on some IP revisions */
@@ -72,7 +72,7 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
 				return -EINVAL;
 
 			clk_period_ns = (u64)NSEC_PER_SEC * 256;
-			do_div(clk_period_ns, clk_freq);
+			clk_period_ns = div64_ul(clk_period_ns, clk_freq);
 		}
 
 		for (pres = 0; pres <= ATMEL_HLCDC_PWMPS_MAX; pres++) {
-- 
2.25.1

