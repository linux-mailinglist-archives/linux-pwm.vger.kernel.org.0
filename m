Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6794552EA
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Nov 2021 03:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242137AbhKRC4Z (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 17 Nov 2021 21:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240757AbhKRC4Y (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 17 Nov 2021 21:56:24 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFCEC061570;
        Wed, 17 Nov 2021 18:53:25 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id s138so3998465pgs.4;
        Wed, 17 Nov 2021 18:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ydhncPFsv4uTLuZsh+u6JueSvp7B3BRJ0masoTgqhuI=;
        b=mb3zTAth3h1fACQsH7FEUV5uIFnNJXbDFhNSkWGr00eyrTMzC5xd2lVZ87t/FvOcYl
         EBJ8gfU9WDEILAqTcHLjbSoSSyQ8+s00YkgmCu/KyYBg3O5o2qD8/2FEYmTepqKT0Dbe
         qdTf0Imuzb5VB+BPi7KeVIyGxlgZWR6PTmYfnJV7mF25U2VCEGAHjkuaSQWWZoAT/lVY
         Gv2Ar4oGBc0oTisXGFBJscv+82w6itmo8yDfVRXNciPuY/cmM60gXfv120659lq546J1
         rIHxzZfouTTRlUIlk3DmLAf0yAU7f4OGreqiV5gUi47TN0+RwISGiQacpwep6YK0VWqa
         v+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ydhncPFsv4uTLuZsh+u6JueSvp7B3BRJ0masoTgqhuI=;
        b=AJkN2L4JJI1emgIy5beZVkktgoiSe1mqbRmZTe4sq8FiuSUS8jndEZies8pW3QZQmQ
         Tj8ZYx1KIXMhdCF8HwvbW51Z4Epw4U/KSjFYeWoeiIPOVDPKfoSMzcipG3rnLsgJprAP
         vh3fYkmwCATYZQK6HSBPXCtA9ziBqz2uIYXGQVx2l344mXANYWSxEejZIp9AgaTyiUav
         aUZsm9SYAfGX5fW9ukfaRMGHvSMRjeImGC6sfETNfCd9oPaygD2fRVJRBJNRO3ed2nyT
         RL1g3DpX7bPxs+DIqLF2Far+mlX4+hhXoxo9WUKZYhZdNIkSmg/hpdeyZIYxGI3RmaqS
         jmGg==
X-Gm-Message-State: AOAM530qb1wku8IVl38zMVSR4N1eARtu6nbNhd2t3z7tNIKqWLHWJUAE
        1+suGVLiS6ldMKn5Y/ifsv4=
X-Google-Smtp-Source: ABdhPJwKmBuqdEAZY6Gfx5iVVa9wu63f5hwitNcfw9ahQwz7MzdTxRFaRgy0Ml402jwppSqWaLb0TA==
X-Received: by 2002:a62:dd0d:0:b0:494:6e7a:23d with SMTP id w13-20020a62dd0d000000b004946e7a023dmr11798803pff.17.1637204005250;
        Wed, 17 Nov 2021 18:53:25 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x14sm901326pjl.27.2021.11.17.18.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 18:53:24 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     u.kleine-koenig@pengutronix.de
Cc:     alexandre.belloni@bootlin.com, cgel.zte@gmail.com,
        deng.changcheng@zte.com.cn, lee.jones@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, ludovic.desroches@microchip.com,
        nicolas.ferre@microchip.com, thierry.reding@gmail.com,
        zealci@zte.com.cn
Subject: [PATCH V3] pwm: Use div64_ul instead of do_div
Date:   Thu, 18 Nov 2021 02:52:54 +0000
Message-Id: <20211118025254.163231-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211117145419.b4wb6zp42rjdpgn5@pengutronix.de>
References: <20211117145419.b4wb6zp42rjdpgn5@pengutronix.de>
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

