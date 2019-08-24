Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 278E99BE24
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 16:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfHXOKN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Aug 2019 10:10:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:54939 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727679AbfHXOKN (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 24 Aug 2019 10:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566655798;
        bh=p0356BK30yaqXao28qVvueaMUHmiPXaegoIWDiukDy4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FPLvHF3F1eQfEPy73mmnsP53NAh3u0jSpEB6+THailv4zEuzdwna+GR2Qdwomhdbg
         b57U7oFf2mC0Mp1JqCC+7e+h8yQ4TXj3KWUZlQyO1R0CjYS3ucmkUCnNOtwIBFbWpS
         pP0p5ffueiouSsEgYGkVPJTHYLQlZqJzfjJ67JXo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.106]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M9FjR-1i7Jcv1UNL-006NXj; Sat, 24 Aug 2019 16:09:58 +0200
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 2/3] pwm: bcm2835: fix period_ns range check
Date:   Sat, 24 Aug 2019 16:09:47 +0200
Message-Id: <1566655788-24949-3-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566655788-24949-1-git-send-email-wahrenst@gmx.net>
References: <1566655788-24949-1-git-send-email-wahrenst@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k1uKE8Vftkrl/41pYV+oH5xV1tYyIKl3SA79jsJlrEm/znGfmxb
 vPUsPCH8MQooBxIiiEtewqIVeYrGjl3jviqP8jmvZ4IlQI5NOg1gyUr+zVhtmGMIpwqQRZC
 ofGmes5DadQ5HKqt55IRir7pgwGeU17r3lXenKeizqsDayV8WzJd3enSOaz2Q1IHKEoWEZI
 /cEL5M9rYiEhlcyJNz4qg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3tPCBJyhJdI=:xOSDLVNwC7SqyhMgU539A4
 7aeaknVIaXPH9QUXP+JzCWJXnrgxEiPxDbAFFprte/SEx9E41q9NsACEuv/bJIDAz7IgKCQIE
 xsJPJ8Ec/KhuvP59+sQ2DWHqEZUwhxqT+sGpZoQXVnc4P4DcqIhex/hbANU0We4xHbPB0BEHN
 xMHwdeG+q1XRtNy6+fznb3KD83w9M6lgfj0y+fIBzz7q2vqsmNo5rgOPLsGa1/B+K7k3RZZvi
 AEy2V2f0DAGjD2EXt5j9Ad9ZBDlCphG+SfE+OzQLTK1R16jOBAEmheJ5Aen10pfd4MViMz4j8
 Qzt1qWlYi4zIwVcQQop1rN8/E1t+vlC7Pq6xfUJl8fJzGqHjj3kN5oByfs96JSu9sS4EQvdDy
 GSSoJ4HKUj6RJu8RFMSvVsOaanXzxAsTZ2k/5OHrb9af4ftw/0PFjjTEl9U4EIvq03cOOddhN
 5n5f01B0uLJFwK3FcA9vSjmRCmnav5CnXdoOD0YabC/PvHh/lxSFeSPY3icNjKoZH+ftb/iBe
 NuUzTTshP8lvnw1e7FqWF93HaxY90QeMxWJB4QX0Oi6A0saQetB5kbWKizf9UU12Qh5UsUc5B
 j5dR5IQIYUUf7Gutpo6OOXtJMdHPsdkkLin4eKPI2Q2douWFpkNce1ry8wtGqOyLeVZF33+hY
 rp+ao2uxWBjPwH5BjSbBEa9LPh6LdNb8jneD3qfcCeLx5qUswjq8ZUmNnTYMlE10+LmnYwDIt
 HYC7Wrodh/T9+w8Y4OwxVySrPVTgCLmV+6RwXgVHSaquks5+iZQNtMQPoLjGGkrNHsZdJrs5R
 fTi4+mYJhZphoXQWtAb0HJwJR747kG1BTIHruaz8I0U6Pp35OTyPYF4/owfYnqpOcU4Rf5kSy
 dA6fwsSZPEmFv4feyM4a3Kt9RyOZ1pnLzVszETdsgD0C1mf0O0yhuxQVbPivL3qeMBW0xtGzu
 XLYc0UkREnqb4iOAlbGdJyaHwN9Om26iGTDlAC09XYONa70aiaiH3zmGIaXcyk1cUYJYonG8O
 eBBp0XgAyGrNxXKiEZxH6oGoqbetllotSHBodJhn+0AINbHobSTjn+os+2IyqUNnEGkOZ9GsM
 GZmzu6LguSop88VdH8YBidqW6ErftZObrgFaxEKvgLeZjlE1255qNN95ouM7RVMIgTXi8TIyd
 4Jkoo=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The range check for period_ns was written under assumption of a fixed
PWM clock. With clk-bcm2835 driver the PWM clock is a dynamic one.
So fix this by doing the range check on the period register value.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
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

