Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675CC37B546
	for <lists+linux-pwm@lfdr.de>; Wed, 12 May 2021 07:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhELFCi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 May 2021 01:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhELFCh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 May 2021 01:02:37 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BEAC061574
        for <linux-pwm@vger.kernel.org>; Tue, 11 May 2021 22:01:29 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id m12so33069664eja.2
        for <linux-pwm@vger.kernel.org>; Tue, 11 May 2021 22:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prusa3d-cz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:content-transfer-encoding:subject:from:to:cc:date
         :message-id:in-reply-to;
        bh=Y5ffXsy5KtLgpsjjrkZZYgh2XBbhziS39BsvMRY9WD4=;
        b=AJAvZ1zd2DTF8Knn8HaPdvYrE50lPPhir8NFHCwI+01YL704XtNoo9lX+7zcnVr5zD
         xxfz/Y5R9HTk6bDmWyI4xL48KATwa7uY16+FQLs9bN8ixX1HDHEOnhoP1KoT6KpthZ/g
         cSJFoyK64iSlbVAJ+W8nPeVZJrQKyRVrEpSI4ul0d/T7xrslEHL0RWAuwkNzL0hXK/m4
         /JDGGY1v5kjOSezDVmmLQBr2gPPwHCXloiSXHEUwGCe2WVOAFYUkZUZ4aMLMZb6Vo8TF
         V91c53jWP0XhTUNRoPgAVNSMw7D3/prqyzXSGZzGzFhSw5Lwv2DFtomhfQHCo8D39IDE
         yxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :from:to:cc:date:message-id:in-reply-to;
        bh=Y5ffXsy5KtLgpsjjrkZZYgh2XBbhziS39BsvMRY9WD4=;
        b=hVDyAhylhyRQhQddwxG6YuXIlevoItLz1b4NuFIk3UFXveHLt/pX6U6hXtpaCYceuH
         +FygYejkJIlO8AyI1jK7r04xLrX8ySu9CTGDEa4Yc6fc7q3M3tyvu3RvIZhimHtmfpyZ
         oqAmvNrEdWmYL84ylIlTXyH431TGkNeelXduMxsFogb7GhDgGwVcR1snZUIGg/o8SKqj
         i2QvwiIe3m7hbXzvoUfd8fQApRXNstx4xtjdj+NXQkZODKI92j4srkyMAOywT8W9vXs5
         D/zuVis4o/VCE+YmCMtN3I6i1A3D6bmogXDcIBp8MeKlLe//eO/284yypGTGeiK1DLcH
         5V+w==
X-Gm-Message-State: AOAM533GwbDzNHkdUto/cJyi4qJbeBva4uf3oI1d56kklHQRYavi8i71
        KdTjbb2p0sAGjFBzEe0EQpQvxw==
X-Google-Smtp-Source: ABdhPJzZW9sR+U3PCCW89H1YIgTzB6/WWrhVImZ/sF2PxVtRiukJPH3q8tdPI9ICuRJni3epNMkD1Q==
X-Received: by 2002:a17:906:3b84:: with SMTP id u4mr35631552ejf.131.1620795688026;
        Tue, 11 May 2021 22:01:28 -0700 (PDT)
Received: from localhost (ip-89-102-194-33.net.upcbroadband.cz. [89.102.194.33])
        by smtp.gmail.com with ESMTPSA id p14sm16250214eds.28.2021.05.11.22.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 22:01:27 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH] pwm: sun4i: Avoid waiting until the next period
From:   "Roman Beranek" <roman.beranek@prusa3d.cz>
To:     "Emil Lenngren" <emil.lenngren@gmail.com>
Cc:     =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        "Lee Jones" <lee.jones@linaro.org>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Chen-Yu Tsai" <wens@csie.org>,
        "Jernej Skrabec" <jernej.skrabec@siol.net>,
        <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-sunxi@googlegroups.com>,
        "Roman Beranek" <roman.beranek@prusa3d.com>
Date:   Wed, 12 May 2021 06:13:36 +0200
Message-Id: <CBAZ3OSXC4KP.2VOXZAM4BL2F3@zen.local>
In-Reply-To: <CAO1O6seU7t==O=yCVBQK0iAkeEyO3dbRQ71obJh3Jm26xxWobw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Emil,

On Wed May 12, 2021 at 2:55 AM CEST, Emil Lenngren wrote:
> But on what hardware do you really need to wait until one full pulse
> cycle ends, before a disable command takes effect?

I have no idea. The value has been there already for nearly 4 years
(since c32c5c50d4fe).

> By closing the gate when the pwm should be disabled, I guess we could
> save some nanoampere or microampere (is this important?)

My guess is that once the last cycle ends, the counter won't get
incremented any longer. But my guess is of course as good as yours,
I don't have an easy access to equipment capable of measurement this
precise.

> On the hardware I've tested on (GR8 and V3s), it's enough to wait at     =
                                                 =20
> most two clock cycles in order for it to take effect before we can       =
                                                 =20
> close the gate. And with clock cycle I mean 24 MHz divided by the        =
                                                 =20
> prescaler. With prescaler 1, that's 84 nanoseconds.

In such case I could easily imagine keeping the clock gate around. Like
this:
---
 drivers/pwm/pwm-sun4i.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index d6d6d43f6e81..3350f6517dbd 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -73,7 +73,7 @@ static const u32 prescaler_table[] =3D {
        72000,
        0,
        0,
-       0, /* Actually 1 but tested separately */
+       1, /* Tested separately */
 };
=20
 struct sun4i_pwm_data {
@@ -91,7 +91,7 @@ struct sun4i_pwm_chip {
 	void __iomem *base;
 	spinlock_t ctrl_lock;
 	const struct sun4i_pwm_data *data;
-	unsigned long next_period[2];
+	u64 ready_to_be_gated[2];
 };
=20
 static inline struct sun4i_pwm_chip *to_sun4i_pwm_chip(struct pwm_chip *ch=
ip)
@@ -237,10 +237,12 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
 	struct pwm_state cstate;
 	u32 ctrl, duty =3D 0, period =3D 0, val;
 	int ret;
-	unsigned int delay_us, prescaler =3D 0;
-	unsigned long now;
+	unsigned int cycle_ns, delay, prescaler =3D 0;
+	u64 now;
 	bool bypass;
=20
+	cycle_ns =3D NSEC_PER_SEC / clk_get_rate(sun4i_pwm->clk);
+
 	pwm_get_state(pwm, &cstate);
=20
 	if (!cstate.enabled) {
@@ -286,8 +288,11 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
=20
 	val =3D (duty & PWM_DTY_MASK) | PWM_PRD(period);
 	sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));
-	sun4i_pwm->next_period[pwm->hwpwm] =3D jiffies +
-		nsecs_to_jiffies(cstate.period + 1000);
+
+	now =3D get_jiffies_64();
+	delay =3D nsecs_to_jiffies(2 * prescaler_table[prescaler] * cycle_ns) + 1=
;
+	if (time_before64(sun4i_pwm->ready_to_be_gated[pwm->hwpwm], now + delay))
+		sun4i_pwm->ready_to_be_gated[pwm->hwpwm] =3D now + delay;
=20
 	if (state->polarity !=3D PWM_POLARITY_NORMAL)
 		ctrl &=3D ~BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
@@ -298,6 +303,8 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struc=
t pwm_device *pwm,
=20
 	if (state->enabled)
 		ctrl |=3D BIT_CH(PWM_EN, pwm->hwpwm);
+	else
+		ctrl &=3D ~BIT_CH(PWM_EN, pwm->hwpwm);
=20
 	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
=20
@@ -306,21 +313,15 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
 	if (state->enabled)
 		return 0;
=20
-	/* We need a full period to elapse before disabling the channel. */
-	now =3D jiffies;
-	if (time_before(now, sun4i_pwm->next_period[pwm->hwpwm])) {
-		delay_us =3D jiffies_to_usecs(sun4i_pwm->next_period[pwm->hwpwm] -
-					   now);
-		if ((delay_us / 500) > MAX_UDELAY_MS)
-			msleep(delay_us / 1000 + 1);
-		else
-			usleep_range(delay_us, delay_us * 2);
+	/* We need 1-2 clock cycles to elapse before disabling the channel. */
+	if (time_before64(now, sun4i_pwm->ready_to_be_gated[pwm->hwpwm])) {
+		delay =3D (unsigned int)(sun4i_pwm->ready_to_be_gated[pwm->hwpwm] - now)=
;
+		msleep(jiffies_to_msecs(delay));
 	}
=20
 	spin_lock(&sun4i_pwm->ctrl_lock);
 	ctrl =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
 	ctrl &=3D ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-	ctrl &=3D ~BIT_CH(PWM_EN, pwm->hwpwm);
 	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
 	spin_unlock(&sun4i_pwm->ctrl_lock);
=20

