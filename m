Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341F04459FD
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Nov 2021 19:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhKDSxF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 4 Nov 2021 14:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbhKDSxE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 4 Nov 2021 14:53:04 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56F1C061714
        for <linux-pwm@vger.kernel.org>; Thu,  4 Nov 2021 11:50:25 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id bk22so6621386qkb.6
        for <linux-pwm@vger.kernel.org>; Thu, 04 Nov 2021 11:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=oSIkf0OBVIKHsiRflQs3qBY9N9D25QVn/L+ip9zPG0M=;
        b=JnB7Nezi9c6EVYLCOSBafzIJoUEf06ZJD2JkrqTkFmnDAt36E3n4XYngMhcTGR6bjy
         CK47tGOWh7e4hV6lp9/E28w9ElDJF+NQ4x4P1BgexczvBaMLwEtJ3Sh5o4UWWBy1HKx0
         TRVMB3QW4aG2rbvgdfJLA0eVTCozDJiJu41USj+pYb2xFCqEgvywGbb5Rg4gBCBeKwLE
         WZDHnGY8GNLmazHu0V6E0sW7mR1Nt3A7ApuGhVML67wH6HaSb0iMtxZX1fuUzCvYaZaW
         vBJAFVL0zzTG9+yaOW4ogMzY5Pn/jd4ldegpFV0vld1hyUSXddMdmyTktLbj9FI20pJq
         TzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=oSIkf0OBVIKHsiRflQs3qBY9N9D25QVn/L+ip9zPG0M=;
        b=mqdvGb1sZPdlhT38ntB9nUejPyRxdiXruepHNa0BR8NHj58nOHizjsSOwTFCuq8dm6
         EFTD35s0myJUSTxpOgPlO15ZhrFDxDEnEumad/1ooU+LuYsE/9X+0UW0e5D+GShsQI06
         FRcGjP5HVA+IJKjYdiCSvK+c80uH//5c4Era0Z0/p+Fnin78qn1uG4F4X2zy4Nqp8KrA
         n9J/K3UnkKQn94m/bdqY1hg98SbnoPvODHGY71bHsRpoXSzej0H/4WY/JLO5KXaP83dl
         Uoo5UVytNWufkSKA8SVnwpu8b0zJ5g6AIR0ocknyXx5G28w4+UHKDQpOrEGaD+B+xOQ+
         /n+Q==
X-Gm-Message-State: AOAM530lb143O+yxI3p+zfgiwvdW3la4ZetUiSU4c5LmefAUMYG8irJb
        AJN2SOpa71hhVwdvLesUh01dFg==
X-Google-Smtp-Source: ABdhPJxAFXqaPyN8lvZ2B3OvO3LFlEpDqRLxXtmDaev1jGiweXgxtvEQfgUDeJmHRd6bh5JDavYRxg==
X-Received: by 2002:a37:f90a:: with SMTP id l10mr41017877qkj.402.1636051825113;
        Thu, 04 Nov 2021 11:50:25 -0700 (PDT)
Received: from fedora ([187.64.134.142])
        by smtp.gmail.com with ESMTPSA id f3sm4462330qtf.55.2021.11.04.11.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 11:50:23 -0700 (PDT)
Date:   Thu, 4 Nov 2021 15:50:18 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     sean@mess.org, mchehab@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH v3] media: ir-rx51: Switch to atomic PWM API
Message-ID: <YYQrano1G7cBDf+v@fedora>
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
V1 -> V2: Remove conceptually wrong chunk of code and correct the position
of pwm_init_state function
V2 -> V3: Fix NULL pointer exception
---
 drivers/media/rc/ir-rx51.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/media/rc/ir-rx51.c b/drivers/media/rc/ir-rx51.c
index a0d9c02a7588..a3b145183260 100644
--- a/drivers/media/rc/ir-rx51.c
+++ b/drivers/media/rc/ir-rx51.c
@@ -19,6 +19,7 @@
 struct ir_rx51 {
 	struct rc_dev *rcdev;
 	struct pwm_device *pwm;
+	struct pwm_state state;
 	struct hrtimer timer;
 	struct device	     *dev;
 	wait_queue_head_t     wqueue;
@@ -32,22 +33,20 @@ struct ir_rx51 {
 
 static inline void ir_rx51_on(struct ir_rx51 *ir_rx51)
 {
-	pwm_enable(ir_rx51->pwm);
+	ir_rx51->state.enabled = true;
+	pwm_apply_state(ir_rx51->pwm, &ir_rx51->state);
 }
 
 static inline void ir_rx51_off(struct ir_rx51 *ir_rx51)
 {
-	pwm_disable(ir_rx51->pwm);
+	ir_rx51->state.enabled = false;
+	pwm_apply_state(ir_rx51->pwm, &ir_rx51->state);
 }
 
 static int init_timing_params(struct ir_rx51 *ir_rx51)
 {
-	struct pwm_device *pwm = ir_rx51->pwm;
-	int duty, period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, ir_rx51->freq);
-
-	duty = DIV_ROUND_CLOSEST(ir_rx51->duty_cycle * period, 100);
-
-	pwm_config(pwm, duty, period);
+	ir_rx51->state.period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, ir_rx51->freq);
+	pwm_set_relative_duty_cycle(&ir_rx51->state, ir_rx51->duty_cycle, 100);
 
 	return 0;
 }
@@ -242,6 +241,7 @@ static int ir_rx51_probe(struct platform_device *dev)
 
 	/* Use default, in case userspace does not set the carrier */
 	ir_rx51.freq = DIV_ROUND_CLOSEST_ULL(pwm_get_period(pwm), NSEC_PER_SEC);
+	pwm_init_state(pwm, &ir_rx51.state);
 	pwm_put(pwm);
 
 	hrtimer_init(&ir_rx51.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-- 
2.31.1

