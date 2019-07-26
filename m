Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5BA7718B
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jul 2019 20:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388227AbfGZSs5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 26 Jul 2019 14:48:57 -0400
Received: from mailoutvs9.siol.net ([185.57.226.200]:56183 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388223AbfGZSs5 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 26 Jul 2019 14:48:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 52643523039;
        Fri, 26 Jul 2019 20:40:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zy3us02qcUnp; Fri, 26 Jul 2019 20:40:59 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 04A4E523030;
        Fri, 26 Jul 2019 20:40:59 +0200 (CEST)
Received: from localhost.localdomain (cpe-194-152-11-237.cable.triera.net [194.152.11.237])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id A9240523039;
        Fri, 26 Jul 2019 20:40:56 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     thierry.reding@gmail.com, mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 2/6] pwm: sun4i: Add a quirk for reset line
Date:   Fri, 26 Jul 2019 20:40:41 +0200
Message-Id: <20190726184045.14669-3-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726184045.14669-1-jernej.skrabec@siol.net>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

H6 PWM core needs deasserted reset line in order to work.

Add a quirk for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/pwm/pwm-sun4i.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index de78c824bbfd..1b7be8fbde86 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -16,6 +16,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/time.h>
@@ -72,12 +73,14 @@ static const u32 prescaler_table[] =3D {
=20
 struct sun4i_pwm_data {
 	bool has_prescaler_bypass;
+	bool has_reset;
 	unsigned int npwm;
 };
=20
 struct sun4i_pwm_chip {
 	struct pwm_chip chip;
 	struct clk *clk;
+	struct reset_control *rst;
 	void __iomem *base;
 	spinlock_t ctrl_lock;
 	const struct sun4i_pwm_data *data;
@@ -371,6 +374,14 @@ static int sun4i_pwm_probe(struct platform_device *p=
dev)
 	if (IS_ERR(pwm->clk))
 		return PTR_ERR(pwm->clk);
=20
+	if (pwm->data->has_reset) {
+		pwm->rst =3D devm_reset_control_get(&pdev->dev, NULL);
+		if (IS_ERR(pwm->rst))
+			return PTR_ERR(pwm->rst);
+
+		reset_control_deassert(pwm->rst);
+	}
+
 	pwm->chip.dev =3D &pdev->dev;
 	pwm->chip.ops =3D &sun4i_pwm_ops;
 	pwm->chip.base =3D -1;
@@ -383,19 +394,31 @@ static int sun4i_pwm_probe(struct platform_device *=
pdev)
 	ret =3D pwmchip_add(&pwm->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
-		return ret;
+		goto err_pwm_add;
 	}
=20
 	platform_set_drvdata(pdev, pwm);
=20
 	return 0;
+
+err_pwm_add:
+	reset_control_assert(pwm->rst);
+
+	return ret;
 }
=20
 static int sun4i_pwm_remove(struct platform_device *pdev)
 {
 	struct sun4i_pwm_chip *pwm =3D platform_get_drvdata(pdev);
+	int ret;
+
+	ret =3D pwmchip_remove(&pwm->chip);
+	if (ret)
+		return ret;
=20
-	return pwmchip_remove(&pwm->chip);
+	reset_control_assert(pwm->rst);
+
+	return 0;
 }
=20
 static struct platform_driver sun4i_pwm_driver =3D {
--=20
2.22.0

