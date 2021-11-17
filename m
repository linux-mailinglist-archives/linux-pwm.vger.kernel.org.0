Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71663453E2B
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Nov 2021 03:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhKQCHb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 16 Nov 2021 21:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhKQCHb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 16 Nov 2021 21:07:31 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC27DC061570;
        Tue, 16 Nov 2021 18:04:32 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id y8so812378plg.1;
        Tue, 16 Nov 2021 18:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YYMHnZa4Fp6R7ZiPAO18RAWUjsp4BQMceKJYPJ4DltQ=;
        b=S4pi1LL4pavZLpbNUg3TolR1Y5PKk1BGAAQRh+PuCponARsSOaQnduNZofi/d+vR+r
         Dv3wZwQ4EcXb7DhRxdarSyFUdR/Rab9PfB91bhb/VtkQFVYbEHqn85UCQ6ZkC8eZ/5Yl
         vu6nF7sy0u1pZM1uHTF6SsO32NVbS8kwfJP1fT3qjuNDgWzhqZhNDJQ7AXS1Mm2XWYQK
         yhyrK+ZKlAYSeBdzaLLhRBov7z9gLT2/Y3Fb1CmrZXP1JDfP0H3rf0wzXjTSPkhdbTKf
         740JXdmysFzBvYCKu3lmBslOnPUyd1+ri5oy2clN9E51BNeTdBhjplQ/io+8qX4rPCZ1
         ohgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YYMHnZa4Fp6R7ZiPAO18RAWUjsp4BQMceKJYPJ4DltQ=;
        b=UQ3jN1ecsXPLWnsgNwpXNBkY8FOj/gqpq+8pkQILuvYCI6+dsdyLbiVGm/zU4dLvCo
         Jf3BQ5Qg/HOatNwdfg9tndXJuVqvEB2daVqJVqT/++56m8k2KyUNXfvlZgNgZFD8VvVc
         Hm7HegyKO25lhEqo05j2fz0UgvhPBdSdimuTG+44d9LUEarXAUnL9BSp5vA2v6QnTC7m
         bGmxVb5NK+yEFUdrEB+uwL33g8wMBiJMq2Nk1W0QsQcW5sUpTMzSa/eUsFcshMqBJhUR
         Xfsjxq5BfeTsnVw6rxQzW/Il0rD2dYk/hNuEMexW7QjT8wxscIUqbwpbL4Hoc7NV1cM6
         thUw==
X-Gm-Message-State: AOAM530LekqQJGh4KJdfIi0EsWczSLonWEL83e5oKAipon1/s4/ZGNO5
        j2o9D0dqzyVxETIMZrXAKO0=
X-Google-Smtp-Source: ABdhPJzyh5zPVtB9+tCMvKMv8KGMLDWWuGOrzRHDdHi7r5uLZ18d0EzrEbh2jUwr2gI1LVaE+YHEsg==
X-Received: by 2002:a17:903:1103:b0:143:a593:dc41 with SMTP id n3-20020a170903110300b00143a593dc41mr49644868plh.5.1637114672465;
        Tue, 16 Nov 2021 18:04:32 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g1sm19586851pfm.25.2021.11.16.18.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 18:04:32 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] pwm: Use div64_ul instead of do_div
Date:   Wed, 17 Nov 2021 02:04:26 +0000
Message-Id: <20211117020426.159242-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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
+			div64_ul(clk_period_ns, clk_freq);
 		}
 
 		/* Errata: cannot use slow clk on some IP revisions */
@@ -72,7 +72,7 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
 				return -EINVAL;
 
 			clk_period_ns = (u64)NSEC_PER_SEC * 256;
-			do_div(clk_period_ns, clk_freq);
+			div64_ul(clk_period_ns, clk_freq);
 		}
 
 		for (pres = 0; pres <= ATMEL_HLCDC_PWMPS_MAX; pres++) {
-- 
2.25.1

