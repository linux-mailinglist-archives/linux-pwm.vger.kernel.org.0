Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F299077197
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jul 2019 20:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388236AbfGZStA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 26 Jul 2019 14:49:00 -0400
Received: from mailoutvs33.siol.net ([185.57.226.224]:56306 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388222AbfGZSs7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 26 Jul 2019 14:48:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 628C652303F;
        Fri, 26 Jul 2019 20:41:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id K7nmLpb6mIDb; Fri, 26 Jul 2019 20:41:06 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 1607052303B;
        Fri, 26 Jul 2019 20:41:06 +0200 (CEST)
Received: from localhost.localdomain (cpe-194-152-11-237.cable.triera.net [194.152.11.237])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id BCFB7523040;
        Fri, 26 Jul 2019 20:41:03 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     thierry.reding@gmail.com, mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 5/6] pwm: sun4i: Add support to output source clock directly
Date:   Fri, 26 Jul 2019 20:40:44 +0200
Message-Id: <20190726184045.14669-6-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726184045.14669-1-jernej.skrabec@siol.net>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

PWM core has an option to bypass whole logic and output unchanged source
clock as PWM output. This is achieved by enabling bypass bit.

Note that when bypass is enabled, no other setting has any meaning, not
even enable bit.

This mode of operation is needed to achieve high enough frequency to
serve as clock source for AC200 chip, which is integrated into same
package as H6 SoC.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/pwm/pwm-sun4i.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 9e0eca79ff88..848cff26f385 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -120,6 +120,19 @@ static void sun4i_pwm_get_state(struct pwm_chip *chi=
p,
=20
 	val =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
=20
+	/*
+	 * PWM chapter in H6 manual has a diagram which explains that if bypass
+	 * bit is set, no other setting has any meaning. Even more, experiment
+	 * proved that also enable bit is ignored in this case.
+	 */
+	if (val & BIT_CH(PWM_BYPASS, pwm->hwpwm)) {
+		state->period =3D DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC, clk_rate);
+		state->duty_cycle =3D state->period / 2;
+		state->polarity =3D PWM_POLARITY_NORMAL;
+		state->enabled =3D true;
+		return;
+	}
+
 	if ((PWM_REG_PRESCAL(val, pwm->hwpwm) =3D=3D PWM_PRESCAL_MASK) &&
 	    sun4i_pwm->data->has_prescaler_bypass)
 		prescaler =3D 1;
@@ -211,7 +224,8 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
 {
 	struct sun4i_pwm_chip *sun4i_pwm =3D to_sun4i_pwm_chip(chip);
 	struct pwm_state cstate;
-	u32 ctrl;
+	u32 ctrl, clk_rate;
+	bool bypass;
 	int ret;
 	unsigned int delay_us;
 	unsigned long now;
@@ -226,6 +240,16 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
 		}
 	}
=20
+	/*
+	 * Although it would make much more sense to check for bypass in
+	 * sun4i_pwm_calculate(), value of bypass bit also depends on "enabled"=
.
+	 * Period is allowed to be rounded up or down.
+	 */
+	clk_rate =3D clk_get_rate(sun4i_pwm->clk);
+	bypass =3D (state->period =3D=3D NSEC_PER_SEC / clk_rate ||
+		 state->period =3D=3D DIV_ROUND_UP(NSEC_PER_SEC, clk_rate)) &&
+		 state->enabled;
+
 	spin_lock(&sun4i_pwm->ctrl_lock);
 	ctrl =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
=20
@@ -273,6 +297,11 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
 		ctrl &=3D ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
 	}
=20
+	if (bypass)
+		ctrl |=3D BIT_CH(PWM_BYPASS, pwm->hwpwm);
+	else
+		ctrl &=3D ~BIT_CH(PWM_BYPASS, pwm->hwpwm);
+
 	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
=20
 	spin_unlock(&sun4i_pwm->ctrl_lock);
--=20
2.22.0

