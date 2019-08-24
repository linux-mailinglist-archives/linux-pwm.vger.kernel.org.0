Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83B279BE22
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 16:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfHXOKJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Aug 2019 10:10:09 -0400
Received: from mout.gmx.net ([212.227.15.19]:36031 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727665AbfHXOKJ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 24 Aug 2019 10:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566655798;
        bh=Gw0uvY9zV94pNModeowkG7ft0KsjTu+9nSEiRmDoueo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=I/KsoGp7RsJ91JRFXS5dPd+dcnqIL2qgjjBYovEMV0dNcvw7qQ1UHZywX5j08VKDs
         njcR2bXyTHzj3q8LkH7zu3mi9oqNFV48pPAUaKbJtHcm67rYNWNKi5BjJl9VeCQ3D5
         nwxu2raHO3CFo8I3fDGr4aaof2cpF9AWVqFT6IF0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.106]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N95e9-1iGDcv05OJ-0169B9; Sat, 24 Aug 2019 16:09:58 +0200
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 1/3] pwm: bcm2835: suppress error message for invalid period_ns
Date:   Sat, 24 Aug 2019 16:09:46 +0200
Message-Id: <1566655788-24949-2-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566655788-24949-1-git-send-email-wahrenst@gmx.net>
References: <1566655788-24949-1-git-send-email-wahrenst@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fddocn95lqFR/2NouKKedgB4+IDR2qPI8KHoNbsqdP4ouU+F1eh
 j6b5ucNtQpz6aal5CGHWp1O5FRd6jNVF2ZI4swmnGYJ28hsEgBez/rEjJUs0aiXH22/bdG9
 0VxfIZbWDaxlSCGLLJ/7heooFlTXal24wuswUrhH9k/170U1dFs4xnJrTbvzIWapZ/ubujW
 EUunYkaCatNkUsQPGf0jQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4sKyPc6fcIg=:UKPqGFFRGs8RbS/7w3zeZn
 GZPqkRoyMOXlWVCiZ6oJ6GlcnyOK1ij6VzRJ/30QxMLbtW0kPyAsGMDPh6HlFw0ayWG4TG+dr
 ynrSl6w85sfUK6VhlWALYmWe5w1QdarIL0Uy0sm/G3MUxqfWkkgGhBRRoCYvMdWx8sGevH4hz
 bPL3I5H3diXukgRYox+xIZ9DLxt6hUO/0jGqYMgrgEPjQ3bTODcrmTcbsOga1fb750Vkv0MH3
 46xDmjtiYIQJCLPYIRTRBjdeF53HMk4Qa/5QfNE2x7q54mAAdcvVQ2jXFqrqA/VtCUXuBLHhz
 ZvNe5OuGZEYZOhzyqGCo0UgFWuEYAAt0dz//emGhReYxlUkBTGyDEHMzsYamyDl51d8VnJV+B
 gEub3ivyGSrGKD5zPmOODmdy49L0QTLoxYHnKZ/hxLy7nBI+vM00eIvoLTqoH0y+b9oRj4j86
 z3U/LIzOmPgH2Aq1R7Ipj3518atDOE8v1vD0KMRJpo5xjqhCKYVwBgwet0lSN4EE6KLpzFe6R
 p94vzHy1CLkriJEUECNDuCSSdlBLkZVbLGmJqxXdINRuk1n0aKLkNGcHl/tQJKkqOtBkzKY6M
 NcQMT2kxzq6T/rdAmp5N+aaIToi3smX12VORQLN/V/NeQ9KbITu9aplZOyXiJEHBzcnRHq+Qw
 OmNVMkkhEbdCzhye2d1fq+1SjIwcgFoT2d4SWxp2LDZl34kHB7c/kOVhLSkfF4lajtvCIi3ho
 Cov9V1FsKptAk5FhRsO0ujhohkaxVi4jfRqAuFaQCtU00AV2ORmHcOT6TAAIpCXuWNb5C8Cs+
 f5HC/3tT+B7FzA6JOAuCUFW/TaJ0f1a5cdrICc3z8aq7wwJF9cb6hoXV4RaS3Hoxe8TvwldwX
 jYQz2HhQphwAWJGIsmvc/al9E0Bz7gH1c/zRDPjNil6GqFF6UzVcrrVZG13UDJVFfbaSfCMyQ
 OGa1C99Qr2kXLHW4cp0mWRe3blDnRlUJvWSqHEQ2N6MtO7bUZvYuJFkEh5KRqsF4UXiQHM/EN
 6k/j9MmHJiPLom/nhopBwlCRr/QJhK1wQnpy6ADdlxonYd275NOCZpVp1mJcAvMyDuBPAYJpP
 adjny2zaBuTKwsg6ps4zBHw6L3runIuC7BNZXRn4YBjJa7akICsjwhbTWY1G8MpST5XAxqvXX
 oPzfs=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The PWM config can be triggered via sysfs, so we better suppress the
error message in case of an invalid period to avoid kernel log spamming.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
=2D--
 drivers/pwm/pwm-bcm2835.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index f6fe0b9..5276306 100644
=2D-- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -72,11 +72,8 @@ static int bcm2835_pwm_config(struct pwm_chip *chip, st=
ruct pwm_device *pwm,

 	scaler =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, rate);

-	if (period_ns <=3D MIN_PERIOD) {
-		dev_err(pc->dev, "period %d not supported, minimum %d\n",
-			period_ns, MIN_PERIOD);
+	if (period_ns <=3D MIN_PERIOD)
 		return -EINVAL;
-	}

 	writel(DIV_ROUND_CLOSEST(duty_ns, scaler),
 	       pc->base + DUTY(pwm->hwpwm));
=2D-
2.7.4

