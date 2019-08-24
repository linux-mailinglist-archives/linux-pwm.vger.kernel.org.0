Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A95A39BC4E
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 09:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfHXHIA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Aug 2019 03:08:00 -0400
Received: from mout.gmx.net ([212.227.15.15]:48089 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfHXHH7 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 24 Aug 2019 03:07:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566630463;
        bh=7zmLzSl5QEPcdtQwy7pC80ljPOepFXeVShtWEIEYFf8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FXvtBikCxHyYJ5pd66Qj5Khv2Gx8b7Xxf/tHar4op/NeA4BccB8phnLo28f6E6QZV
         LpMW3dPxX/GN33RhyZNKSj+unItC4TWXduUYibrEfDE/Xlun3yEGw4vd+ja5+xHVmZ
         fAEuacnxVnYffrz6Plf48T2/vAAWCOof5V78H6AA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.106]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mw9Q6-1iJv0F2u84-00s5RQ; Sat, 24 Aug 2019 09:07:43 +0200
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 1/3] pwm: bcm2835: suppress error message for invalid period_ns
Date:   Sat, 24 Aug 2019 09:07:23 +0200
Message-Id: <1566630445-4599-2-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566630445-4599-1-git-send-email-wahrenst@gmx.net>
References: <1566630445-4599-1-git-send-email-wahrenst@gmx.net>
X-Provags-ID: V03:K1:R0rW09NZDppqcsM8P+s82dRAM2pzVvmlFRvXrFJwJkMbvk72HFO
 dlryHWDKQVAjfoYFqvodWM5E4VY6N0yp4iKQeKqkzXWr68yY71hvuDcF5jbNbNUreGQpHQt
 s1PilcgL+J7jB2F0GmzE7uOG40aQd3JmQ/boXh4QdYpT7opq7gnO3JJZKBQxWBoeJ5+KHN1
 8V7kBWLJVRFk3tqVXt2QA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:o+iHcj1vHTk=:Io+XoR6JaAcaQXGdTyr5qk
 Tni7PnouSwq8noVSlsO0kpzTWKOO4N2Jm7ebh35jn4d+FDUVAuOAK2P2V/4Y8cnC0aCdX/CKv
 cntumpopx4yuOo5pwpjPBjJDsWv7X1i7c8LXRZOpLVvnyvPreyZiYWfnLSHATOhbc45dHWAgn
 yGu+v4F4n2POeGmJe7pJCqcBEdiGcKcKx+Ec0ReEtz/SgzlwmLOwERAdY4k50kGAx8H8cRcKs
 xArVavDCC4sVkReNAfrk8ZH/VhxCybiAjScTy+t0p1h5kAlsKj2YeYuidoXKjKFv5QSqtOvqN
 x3YZYb04xUMWenOOezkTUHOBQE00+4igm1RsRxDY10QOrIuXJ0Y2yC7+CSuaY0FwKJJryMKO/
 7HX9fGxUXrFdr6tyuCohyZqHadDVGhOIL/p/QM1xFLWvPQhXAW24NSLUpptzCXhFUpA+C3pGe
 Ue6bjf/uzidtH24tjAo0yVli4WFUx417S4+XT019zM/cTP/EtwevnELYnKnlvRLq2RX7S1GtE
 /02kbUkOvhiG0mzHsS3xItP/wAYZdchjGXH2Zk/SIdPSnNfflAoAo2Ye8BhTBsdkftaAUw1V2
 vq22/Y8JGW401qC4BcDqKt5slDPqWln/hZlk1hcConWuDIBcQzHVa3MTmJ7Ca8G+B9oHUvPTs
 47u91ShCp8mNbj/RuuE1QDta6LnhzV5jcVPBhsMtudpI0UwVsWfxrMlPsOundANibANQu6CMq
 jwrJrNuRYjTbA8+zu250FnHdeJFR42oamMMSnmdHPUcvUGXjT34zjjWaro4bnHG53SyCw/3f5
 Z9srReOTLJ9Ws+UulS7yJDmprDvjXLg7fUN4QJiI0kcrSnSCJPRoBnnmOn61HSSiIhqL5WSjK
 l1UIh66mXtnXefBWWwS8E5gqf9Ee6hdN341XG58ExRJB8hCcvMXxeUb9zfmL//wm65g22FrcA
 AIyIm/00A+KjK1VB6j8BuD2jRNGonKNcGK8ixeZx0bZbwD/OLxRRHh1E6HlUC3Qsq5y5VWNJT
 ymmhfQIL8L2CewWMZrH/GngZRTQlZoTDA2FIQ/80DQ9PsTVJH0+ZOEfh7eQH6rwSlqaP6vAVd
 yLZSBrOQd85RLE8zh2dpmxNW5NO1Mbu0Z22jHlzRa3EvnfRFxX/+Nhrkw==
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The PWM config can be triggered via sysfs, so we better suppress the
error message in case of an invalid period to avoid kernel log spamming.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
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

