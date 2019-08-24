Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24FFC9BC4F
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 09:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbfHXHIA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Aug 2019 03:08:00 -0400
Received: from mout.gmx.net ([212.227.15.15]:44397 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfHXHIA (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 24 Aug 2019 03:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566630464;
        bh=cNfgDpMsStRYRSGRVwwso2ry+d80CNC09Rh9sIRN7vw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=J1GxJSMmHdiU1WDp/v4RUmwUYaEIFwwSDi1JYNxNf8nmqDiS8zkt4vFLugCEGzB1X
         Sxib9CZaMZH+lR29y4qm6xZKM+LaAkdc5BHvXG9iYPxWn/6YN7tjt4qe1anlNoSCrr
         V8B+qsbivnBDHKIvwwMJi27z3Kt6IvvHgGMluWFo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.106]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N7zFZ-1iFDlE4AC3-014xl1; Sat, 24 Aug 2019 09:07:44 +0200
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 2/3] pwm: bcm2835: fix period_ns range check
Date:   Sat, 24 Aug 2019 09:07:24 +0200
Message-Id: <1566630445-4599-3-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566630445-4599-1-git-send-email-wahrenst@gmx.net>
References: <1566630445-4599-1-git-send-email-wahrenst@gmx.net>
X-Provags-ID: V03:K1:wUJTwdwF8cbSJSzQyvUcO+97RrgtJK5jY47JakdXyNBlfDeOxA6
 TBAht+wgvDofDruqZXGrLWEv2DVBWSagz9wvqFyNzDLYSgDQxR2YeTlVnE/AACzCmLDg3H2
 y2tAIeLE8VhFrevaflCxKgDr2UtjYnm2/NZK2OgSsqpVDimelHf1bUBP7/P96i2rzq9tpY0
 UGJ6xYsNWhDsqxU85wPrA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mFZRJEsZ2DQ=:LIXA2QWwfPvnGU149PBboe
 NWy7nrmfyj+6creVK/QOPaH4wkW+A99q1w0zdS6lz+L1cU6fx8YdZWT9xuCd8KFjEDP+0iyp9
 pSHANrQfRbAHmBOKdLC3LuQQhN89xbSmCM8rXZGqAwSvPGAsH9fPDYH/BwWHIB/jpUhvOhYIA
 fQcJCyvIihpPMTIhS5CH9n65bhiyYZ/8u7t7ZGymwPyV5JASGeyX6n5LInZ3OYcquBLQxtWPS
 hh5mRMnfT7MixloKkP2FtuYFPmICd7ZjDPKmUSkmCba8rd9+TWACGv39ubEnGVTo1XMHIa5UI
 sjq+Ob8W0+9n5QDmGzhEnQCdczWqmbrGGNPPlldJ4RWKfkZR4tK7xefeVJYFZhQU+qvcj7lBa
 ZsEIz9rVk7nOWVNp2d1AHg8B+EwA1p1iywVx+4f94TaOntwkQteCkopEq4b4DIAbxvdR1jIJR
 Y+yhEW98EwiD9E/Cmf1RQnS4ntHai7V+4W8lLDMBy+2TM91BAKG0N7hZT/tg1sKWmAYqkVZfB
 eCffwGU18xSqO81x2XspLRXYZmH1T8ThgjF2NOitDtg+JguWvhzj+iNvxkpfcr3Wvr04IYcwc
 QNWejTllsgnf7plqKBv6eZ+weJFz/8Yv7FuzuxPuX0U1rXQmKCynz1nQKXy83/XEhu6ArkZWR
 qx7IUSlx5gUaXssrk8wBlvXSHaM/akmDKlKe0RJ2U9XhaRxAFAaer8p5w3wcLPy88/gB7v/nE
 qEHmOJ+m1F+rfPd7dG35w/eCTCqXKAIneqg6imBwpVoaczEgVW6KAk3tGN03abyiYFLxJvJCO
 ConYRnMvgn1Vqvdd1NewXZ32Ot+b0oeVVC4PcNIhbMFgDM1zMKQCCn0SrCDDvbvvfKEJmIhbA
 PQLD9Eqn+n6/eaevv7pMgDpQQ+n4YsIgX/nI8uFGM3PoH9aJ7C9yY8sUsfHnKgK1G9c3ThKTX
 5I0GXQb/47uasEuqft9yowe3ze7kE6H3KVRHT2gVTdWZXLjytz8rYFly5Fs7kh8JGvOiPRMKA
 otQ1bQ3LojJtdTg0TkVqd2C/uBOMTXSa3CncjK54QfPoQWoi77NLrluJf2XvGUg5CyNHg8mzf
 CDZu0eDxaWH0SnKdDOzI3vb/J0J52GUqeZuw34DbjUBpdCC4y/0pHB50A==
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The range check for period_ns was written under assumption of a fixed
PWM clock. With clk-bcm2835 driver the PWM clock is a dynamic one.
So fix this by doing the range check on the period register value.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/pwm/pwm-bcm2835.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index 5276306..2c82386 100644
=2D-- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -21,7 +21,7 @@
 #define PERIOD(x)		(((x) * 0x10) + 0x10)
 #define DUTY(x)			(((x) * 0x10) + 0x14)

-#define MIN_PERIOD		108		/* 9.2 MHz max. PWM clock */
+#define PERIOD_MIN		0x2

 struct bcm2835_pwm {
 	struct pwm_chip chip;
@@ -64,6 +64,7 @@ static int bcm2835_pwm_config(struct pwm_chip *chip, str=
uct pwm_device *pwm,
 	struct bcm2835_pwm *pc =3D to_bcm2835_pwm(chip);
 	unsigned long rate =3D clk_get_rate(pc->clk);
 	unsigned long scaler;
+	u32 period;

 	if (!rate) {
 		dev_err(pc->dev, "failed to get clock rate\n");
@@ -71,14 +72,14 @@ static int bcm2835_pwm_config(struct pwm_chip *chip, s=
truct pwm_device *pwm,
 	}

 	scaler =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, rate);
+	period =3D DIV_ROUND_CLOSEST(period_ns, scaler);

-	if (period_ns <=3D MIN_PERIOD)
+	if (period < PERIOD_MIN)
 		return -EINVAL;

 	writel(DIV_ROUND_CLOSEST(duty_ns, scaler),
 	       pc->base + DUTY(pwm->hwpwm));
-	writel(DIV_ROUND_CLOSEST(period_ns, scaler),
-	       pc->base + PERIOD(pwm->hwpwm));
+	writel(period, pc->base + PERIOD(pwm->hwpwm));

 	return 0;
 }
=2D-
2.7.4

