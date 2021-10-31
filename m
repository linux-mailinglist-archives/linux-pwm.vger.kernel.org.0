Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077FB441128
	for <lists+linux-pwm@lfdr.de>; Sun, 31 Oct 2021 23:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhJaWSZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 31 Oct 2021 18:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhJaWSZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 31 Oct 2021 18:18:25 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AA5C061764
        for <linux-pwm@vger.kernel.org>; Sun, 31 Oct 2021 15:15:52 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id g125so22343548oif.9
        for <linux-pwm@vger.kernel.org>; Sun, 31 Oct 2021 15:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=ahrGibv35CkHD9QWEzZtWa48R45ATn0IgOuUT3/eqfc=;
        b=I97gDV02HD9z6GNpcuq/68Jzcnb6HUZMpT2BHnkvVS2hCs6TQ5wI/3DqovKI5s0F6c
         qaHJ511JfWKPTjlsa86DzzY5cC7l4wVwCMS+YimfISlURspDxFXeITLRpTtNfDsadZmr
         2/HJXF55Pk2j9q3S8FwUyZOvldfHEfLHZtMd9AZ0G+Skh074cy3aj8+aR85BwbqurUXd
         J40XnlJFctPQ7OEGYmwoYIYRj1ari1zBmwGGuH2YgOBYaAW/CuN4wvwzQOyavsc0lhsX
         FrSnmwpJ4zh04Uj6GYxuvyzvSue1FGS08CcTYXiNljc2UxWEI5o1epM6OP8MlcdlY7If
         4sPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=ahrGibv35CkHD9QWEzZtWa48R45ATn0IgOuUT3/eqfc=;
        b=dMzi7eGhbw4zlJuhPMwRYvjaTvDSta3j7ln3Xt6HpcFVezAPusuJvEgwEYbunWccxH
         miwn9LTIp0y+2/hcrbmKnoXwysgjjFz1dhzZV7ZpXxLdR43SsM/B1u16Sw9SgMhFjYOt
         EzLYvVPS6CTvmW1xUJP+x2RjgV+CPi3cElkAudon+zFZYSIVjv3Zwa1QmzjOI6uIGcN2
         PO4TtNoJRAvt9EnAHJHPC+93HLY8qZ/TmLOyUyg9HOIZON42Yp8IKwr32+2aVWm0fx/u
         Yy+cEPZkNbfpXV60H80bOArSgWRZSdz2tEZVr63pnoFUt/iErkbMzzorf+hkJas37Li+
         JvkA==
X-Gm-Message-State: AOAM532TdTkJ+MPkP6TVCVLAWBgev27z9BGKWtgFZdRZsxmBMCbwROZu
        EO1RiMrO6buDjetmBM/2F/Z+tA==
X-Google-Smtp-Source: ABdhPJxVS6VRoBWILO8RW1vB7P3ZlBMpyFzv8jVuUfrkUchFBWjd2yPxep/8okvJ3Hzbsnwz4weiTw==
X-Received: by 2002:a05:6808:1996:: with SMTP id bj22mr2448052oib.69.1635718551756;
        Sun, 31 Oct 2021 15:15:51 -0700 (PDT)
Received: from fedora ([187.64.134.142])
        by smtp.gmail.com with ESMTPSA id l27sm1066967oof.18.2021.10.31.15.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 15:15:51 -0700 (PDT)
Date:   Sun, 31 Oct 2021 19:15:45 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     sean@mess.org, mchehab@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH v2] media: ir-rx51: Switch to atomic PWM API
Message-ID: <YX8VkdCAe6coHC4w@fedora>
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
V1 -> V2: remove conceptually wrong chunk of code and correct the position
of pwm_init_state function
---
 drivers/media/rc/ir-rx51.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/media/rc/ir-rx51.c b/drivers/media/rc/ir-rx51.c
index a0d9c02a7588..41d4a4338072 100644
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
@@ -242,6 +243,7 @@ static int ir_rx51_probe(struct platform_device *dev)
 
 	/* Use default, in case userspace does not set the carrier */
 	ir_rx51.freq = DIV_ROUND_CLOSEST_ULL(pwm_get_period(pwm), NSEC_PER_SEC);
+	pwm_init_state(pwm, ir_rx51.state);
 	pwm_put(pwm);
 
 	hrtimer_init(&ir_rx51.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-- 
2.31.1

