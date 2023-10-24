Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E330C7D4D8E
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Oct 2023 12:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbjJXKTY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Oct 2023 06:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbjJXKTW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Oct 2023 06:19:22 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5693F111
        for <linux-pwm@vger.kernel.org>; Tue, 24 Oct 2023 03:19:20 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b709048f32so3427851b3a.0
        for <linux-pwm@vger.kernel.org>; Tue, 24 Oct 2023 03:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1698142759; x=1698747559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+QZY3JTroucCQn86akp4c5eSM8t3MeXGfG/H9g9b2Y=;
        b=T2xp4ZbcoN2/12TwNePmsUhIH7cKeqiI0b8NSjGBrwM/SxubEG8rlZo9IWNnCr0Lmw
         Sn0Px5A5Dg43SU9tLImZyFMLYUfX+9qQ27DCr7MMIXTjYaNp2a0tjWDl4wNYi0/fnK6g
         9bEvJcha3RXbkTwZzcy8Crz1ZIG93QUEaqWyT/+iKxKwDJDKCOgL339iovypdYEQXvDJ
         tGdvPZn3z5Zezdlk7R/mgQLNT+s/W4H9+YOtNuk0/knP01Y/8KXgZFXZYVeibJG46yIj
         ppz0XR2p1Y7dhsoSWvBD8YCq2wt0bRQVqH45SDHOQ7urNaWZY88OUlJ4j4Hk9GQzA2bq
         oWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698142759; x=1698747559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+QZY3JTroucCQn86akp4c5eSM8t3MeXGfG/H9g9b2Y=;
        b=L/ezputnV0W7oQb39Vv27sGOqucWrUhIrflE3vRrpEl49BdusptMIiC2jghAcooc4Q
         vHofZCFrc2BIeN8ndV3rY3gH/D7xkLFZZaKwgVPu1G68dR956ZDJ7b03CfJ7F6/tQhMO
         +Xq2wdWXb9JIo0xA51OH1IqTY8vFKVpBQzsInj1a+YfH2iJPe06swD5vClE67Y4CxWTi
         PKJPJvwp3PShUpYLG8pm15BlDLHXtHEH0mZ6qTQt30OxrhCGxOqEb1WhDfo6+LJrsRqy
         V0sC3D+tOtjkR3pOD9aFLrDB1PDGqxrAN8BDXAhFsgbuA3Yq8CjDUInLDo22cknCcemq
         bN3w==
X-Gm-Message-State: AOJu0YyfVYfe4+lnspbXIxdDE2T6XdGl7zO5p0KkBObb0H6HZyPyuI17
        zmxrZWAUoJ8xPzR9JPJalLFqWOIo+IqiILdSMMMRsgJUPutXz9Rn1s/Wg1IjqeU5c+5yXC6uqnj
        VvN8D0IxvKTBH9yFFAEyohrhWgLr0O7pElvvemMPv2fH+zw/eEuSV7kOEq5LuhV1HvGcVT7gLrm
        eSMoNzGLzs
X-Google-Smtp-Source: AGHT+IFi+LBy3K1fInBf1b4w9fL0mu89D1Uml8OyKSzrTOMcCgH2Wg5GmsKlwoG6/sIn9yhE2ycnEQ==
X-Received: by 2002:a05:6a00:27a0:b0:690:c306:151a with SMTP id bd32-20020a056a0027a000b00690c306151amr9848589pfb.0.1698142759118;
        Tue, 24 Oct 2023 03:19:19 -0700 (PDT)
Received: from hsinchu15.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id u202-20020a6279d3000000b006b3dc56c944sm7708372pfc.133.2023.10.24.03.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 03:19:18 -0700 (PDT)
From:   Nylon Chen <nylon.chen@sifive.com>
To:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, emil.renner.berthing@canonical.com,
        vincent.chen@sifive.com
Cc:     nylon.chen@sifive.com, greentime.hu@sifive.com, zong.li@sifive.com,
        nylon7717@gmail.com
Subject: [v5 2/2] pwm: sifive: change the PWM controlled LED algorithm
Date:   Tue, 24 Oct 2023 18:19:02 +0800
Message-ID: <20231024101902.6689-3-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024101902.6689-1-nylon.chen@sifive.com>
References: <20231024101902.6689-1-nylon.chen@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The `frac` variable represents the pulse inactive time, and the result
of this algorithm is the pulse active time. Therefore, we must reverse the result.

The reference is SiFive FU740-C000 Manual[0]

Link: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b16acba_fu740-c000-manual-v1p6.pdf [0]

Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
---
 drivers/pwm/pwm-sifive.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index eabddb7c7820..353c2342fbf1 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -101,7 +101,7 @@ static void pwm_sifive_update_clock(struct pwm_sifive_ddata *ddata,
 
 	/* As scale <= 15 the shift operation cannot overflow. */
 	num = (unsigned long long)NSEC_PER_SEC << (PWM_SIFIVE_CMPWIDTH + scale);
-	ddata->real_period = div64_ul(num, rate);
+	ddata->real_period = DIV_ROUND_UP_ULL(num, rate);
 	dev_dbg(ddata->chip.dev,
 		"New real_period = %u ns\n", ddata->real_period);
 }
@@ -121,13 +121,14 @@ static int pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 		state->enabled = false;
 
 	state->period = ddata->real_period;
+
+	duty = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - duty;
 	state->duty_cycle =
 		(u64)duty * ddata->real_period >> PWM_SIFIVE_CMPWIDTH;
-	state->polarity = PWM_POLARITY_INVERSED;
+	state->polarity = PWM_POLARITY_NORMAL;
 
 	return 0;
 }
-
 static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			    const struct pwm_state *state)
 {
@@ -139,7 +140,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	int ret = 0;
 	u32 frac;
 
-	if (state->polarity != PWM_POLARITY_INVERSED)
+	if (state->polarity != PWM_POLARITY_NORMAL)
 		return -EINVAL;
 
 	cur_state = pwm->state;
@@ -158,6 +159,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	num = (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
 	frac = DIV64_U64_ROUND_CLOSEST(num, state->period);
 	/* The hardware cannot generate a 100% duty cycle */
+	frac = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
 	frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
 
 	mutex_lock(&ddata->lock);
-- 
2.42.0

