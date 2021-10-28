Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98EF043E339
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Oct 2021 16:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhJ1OPU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 28 Oct 2021 10:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhJ1OPT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 28 Oct 2021 10:15:19 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1660CC061767
        for <linux-pwm@vger.kernel.org>; Thu, 28 Oct 2021 07:12:53 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id v10so4083895qvb.10
        for <linux-pwm@vger.kernel.org>; Thu, 28 Oct 2021 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=uW58SAoHp5gKtMj6ifGXFk+JxLdoMkUhiHrsFeoWED0=;
        b=zZ/ta4zcx78S1ykzXCOnSW+WYNsFe+FBlOt0zENV5et2S2CahkS7ZIOC3zheDk2nGg
         vjdQYf+krCbAL7FueegDec3werSgU3hvjmVnPBoIcAz/RdD3qzDUkDkvKQ1WcoVfC+hh
         FeeDOw/M5LvhvXnzIlKCL4Q3OF+/F+RmFVOXBlremDHzMl/4j175kLmyPPoPDLC7avkY
         1sq4cOmRbJ6/K8SNUSGSTWzO7H2gcKviqz7rS7SuE675wvRYqK81cyg8fJsWmvffnuV4
         j/p/gkdnR0lanuFtdh3jCowa0BWKwoKT//UzTIWdCN3U4fJGRIw9g3FPR4Pmcr2Vl9Ok
         2wEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=uW58SAoHp5gKtMj6ifGXFk+JxLdoMkUhiHrsFeoWED0=;
        b=7Vs50LMC50Wi+lBECLW0mZPzPaClBU3MZSt6I+vvGEPlAki+qnh4l/X5qiq5tQ7OW4
         uz0EsgdbwMl8VM9MxaRRvPKeSpYkZNqOtffNg3DMuDgoF9NZlKozwNYoTpJiRgDOAiTJ
         9hdR3kjmfKgG0jzsA8okHLqBlPqI6+RgtkIocEQ+bXwUkgY5bQa1EdP0/InKKuASkyUS
         1dGpmi0bC9xTln12KL/65tvPacOYm5Ojr5ACk2pVkzKY6qTFTo98THlN/a4eIb+5U5Ih
         9TRPARMhxk4nyq/5XdJn8yrD5hUtwyQ6nzw5kJXU+RFGr8UjnFYZJz0gWtjjkq0709iT
         PCsA==
X-Gm-Message-State: AOAM533QjRuKe03GPXjhegN/5hjgc17A6J8dxuFO138D4YtHYF9WhTSu
        btRc+Hyllak63vrNirRIodx6Lg==
X-Google-Smtp-Source: ABdhPJzvjeGfiBQ/MFDfr1Y2HOJ/W8Fc8X/sP1RtFracnUJlEZQuBrRJkLpeNUt51rVx5me0ZSJ+1A==
X-Received: by 2002:a05:6214:262d:: with SMTP id gv13mr4305114qvb.40.1635430372183;
        Thu, 28 Oct 2021 07:12:52 -0700 (PDT)
Received: from fedora ([187.64.134.142])
        by smtp.gmail.com with ESMTPSA id bi26sm2010360qkb.102.2021.10.28.07.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 07:12:51 -0700 (PDT)
Date:   Thu, 28 Oct 2021 11:12:47 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     sean@mess.org, mchehab@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH] media: ir-rx51: Switch to atomic PWM API
Message-ID: <YXqv339PJTHcGxJg@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Remove legacy PWM interface (pwm_config, pwm_enable, pwm_disable) and
replace it for the atomic PWM API.

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/media/rc/ir-rx51.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/media/rc/ir-rx51.c b/drivers/media/rc/ir-rx51.c
index a0d9c02a7588..7a643a94e181 100644
--- a/drivers/media/rc/ir-rx51.c
+++ b/drivers/media/rc/ir-rx51.c
@@ -19,6 +19,7 @@
 struct ir_rx51 {
 	struct rc_dev *rcdev;
 	struct pwm_device *pwm;
+	struct pwm_state *state;
 	struct hrtimer timer;
 	struct device	     *dev;
 	wait_queue_head_t     wqueue;
@@ -32,22 +33,22 @@ struct ir_rx51 {
 
 static inline void ir_rx51_on(struct ir_rx51 *ir_rx51)
 {
-	pwm_enable(ir_rx51->pwm);
+	ir_rx51->state->enabled = true;
+	pwm_apply_state(ir_rx51->pwm, ir_rx51->state);
 }
 
 static inline void ir_rx51_off(struct ir_rx51 *ir_rx51)
 {
-	pwm_disable(ir_rx51->pwm);
+	ir_rx51->state->enabled = false;
+	pwm_apply_state(ir_rx51->pwm, ir_rx51->state);
 }
 
 static int init_timing_params(struct ir_rx51 *ir_rx51)
 {
-	struct pwm_device *pwm = ir_rx51->pwm;
-	int duty, period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, ir_rx51->freq);
+	struct pwm_state *state = ir_rx51->state;
 
-	duty = DIV_ROUND_CLOSEST(ir_rx51->duty_cycle * period, 100);
-
-	pwm_config(pwm, duty, period);
+	state->period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, ir_rx51->freq);
+	pwm_set_relative_duty_cycle(state, ir_rx51->duty_cycle, 100);
 
 	return 0;
 }
@@ -154,6 +155,8 @@ static int ir_rx51_open(struct rc_dev *dev)
 		return res;
 	}
 
+	pwm_init_state(ir_rx51->pwm, ir_rx51->state);
+
 	return 0;
 }
 
@@ -232,13 +235,9 @@ static int ir_rx51_probe(struct platform_device *dev)
 	struct rc_dev *rcdev;
 
 	pwm = pwm_get(&dev->dev, NULL);
-	if (IS_ERR(pwm)) {
-		int err = PTR_ERR(pwm);
-
-		if (err != -EPROBE_DEFER)
-			dev_err(&dev->dev, "pwm_get failed: %d\n", err);
-		return err;
-	}
+	if (IS_ERR(pwm))
+		return dev_err_probe(&dev->dev, PTR_ERR(pwm), "pwm_get failed: %ld\n",
+				PTR_ERR(pwm));
 
 	/* Use default, in case userspace does not set the carrier */
 	ir_rx51.freq = DIV_ROUND_CLOSEST_ULL(pwm_get_period(pwm), NSEC_PER_SEC);
-- 
2.31.1

