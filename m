Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B023954C3
	for <lists+linux-pwm@lfdr.de>; Mon, 31 May 2021 06:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhEaEsK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 May 2021 00:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhEaEsA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 May 2021 00:48:00 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A1FC06174A
        for <linux-pwm@vger.kernel.org>; Sun, 30 May 2021 21:46:19 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r11so11920268edt.13
        for <linux-pwm@vger.kernel.org>; Sun, 30 May 2021 21:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prusa3d-cz.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZZgT3an2EYN+ktsS5FyP/IHOGumhn4A6v5jkyh2PmDY=;
        b=wpY9kpNjSEvT08pGSQrDGw0X81R1U+ELe4rSYN4gAc5EiLySzHZ2+gyidq33uOfqz1
         VcwJCkB6Iq4yi+7JOpOk/ANqsTFZKZYvBI0NDRYCYzfE5M1pO2s9DE78P5oQrymB70zG
         YOjCCdoyci1c+1mvnfRyG5Pyl3SkV48swzf/S8mEDsiLa9Jj+Z0S9lzytTOCC9zhN6Ci
         vCBWuypX9sjpAGtu3+KiSaui4cV8fdg5AW70nm38du+SLf/UvdZ9d+Mu17S88yGRKiyt
         V2fnMzLUxwSGPeh5HnnZx0oopltic8yOpy3s31Ml81pX1igjtEGQIVK5qXUED8nYXfwL
         i/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZZgT3an2EYN+ktsS5FyP/IHOGumhn4A6v5jkyh2PmDY=;
        b=GZmM9Tghi9QgCQjMRID7pAwO9PPF2m8qytfCpyaQqQtTpHTnmi+la60sRj/aoIK1ph
         vIMciehoG14VJxrzYhEy9bf7wEi2dzzBQVFrG4jrj/wjj0wxJ7HH8JoMLRp9jrHlppi0
         UO7VOLZPhFGDY9WFfDrTS/kbdIqsSWhvya9BaTXAV+/4ey0DQT/yi28550e7hWvtOVXI
         +SmkQ+20O3BS/vVU6ov52rlVSyXI3G5WjrhDwN/e3ZhhPJaNEO4ELZuxZgwADIHPHoP1
         Q+zcf0EnkDBdzS8l+nxNu1b9CSkrna4V73pbOegifu2h2m3muN4elaFN8mHyedfF7sXn
         IpMg==
X-Gm-Message-State: AOAM532PWBLT/4pTFZVREMCVlpjGx3YxfZkuJdfDUX1sC7zuXF+Omj8d
        QDcJwz27P3xNV6S3tIJKIzjx8Q==
X-Google-Smtp-Source: ABdhPJy1X788ZAmo8YDlVmNC0s+UtsAcz2syqXiIwPHdlqPt5f2EkG6qg8LD7Aa9c5iMnmc0Jwxc+w==
X-Received: by 2002:a05:6402:3587:: with SMTP id y7mr22761532edc.360.1622436378450;
        Sun, 30 May 2021 21:46:18 -0700 (PDT)
Received: from zen.local (ip-89-103-215-157.net.upcbroadband.cz. [89.103.215.157])
        by smtp.gmail.com with ESMTPSA id h9sm6238376edt.18.2021.05.30.21.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 21:46:18 -0700 (PDT)
From:   Roman Beranek <roman.beranek@prusa3d.cz>
X-Google-Original-From: Roman Beranek <roman.beranek@prusa3d.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Emil Lenngren <emil.lenngren@gmail.com>,
        Pascal Roeleven <dev@pascalroeleven.nl>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-sunxi@googlegroups.com
Subject: [PATCH 1/6] pwm: sun4i: enable clk prior to getting its rate
Date:   Mon, 31 May 2021 06:46:03 +0200
Message-Id: <20210531044608.1006024-2-roman.beranek@prusa3d.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210531044608.1006024-1-roman.beranek@prusa3d.com>
References: <20210531044608.1006024-1-roman.beranek@prusa3d.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Ensure the PWM clock is enabled prior to retrieving its rate, as is
already being done in sun4i_pwm_apply.

Signed-off-by: Roman Beranek <roman.beranek@prusa3d.com>
---
 drivers/pwm/pwm-sun4i.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index e01becd102c0..3721b9894cf6 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -117,8 +117,15 @@ static void sun4i_pwm_get_state(struct pwm_chip *chip,
 	u64 clk_rate, tmp;
 	u32 val;
 	unsigned int prescaler;
+	int ret;
 
+	ret = clk_prepare_enable(sun4i_pwm->clk);
+	if (ret) {
+		dev_err(chip->dev, "failed to enable PWM clock\n");
+		return;
+	}
 	clk_rate = clk_get_rate(sun4i_pwm->clk);
+	clk_disable_unprepare(sun4i_pwm->clk);
 
 	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
 
-- 
2.31.1

