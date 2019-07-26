Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 900F977194
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jul 2019 20:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387394AbfGZSs5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 26 Jul 2019 14:48:57 -0400
Received: from mailoutvs34.siol.net ([185.57.226.225]:56216 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388225AbfGZSs5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 26 Jul 2019 14:48:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id A2A8A523033;
        Fri, 26 Jul 2019 20:41:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ymv40tVszZwP; Fri, 26 Jul 2019 20:41:01 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 61A51523030;
        Fri, 26 Jul 2019 20:41:01 +0200 (CEST)
Received: from localhost.localdomain (cpe-194-152-11-237.cable.triera.net [194.152.11.237])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 13799523033;
        Fri, 26 Jul 2019 20:40:59 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     thierry.reding@gmail.com, mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 3/6] pwm: sun4i: Add a quirk for bus clock
Date:   Fri, 26 Jul 2019 20:40:42 +0200
Message-Id: <20190726184045.14669-4-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726184045.14669-1-jernej.skrabec@siol.net>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

H6 PWM core needs bus clock to be enabled in order to work.

Add a quirk for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/pwm/pwm-sun4i.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 1b7be8fbde86..7d3ac3f2dc3f 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -72,6 +72,7 @@ static const u32 prescaler_table[] =3D {
 };
=20
 struct sun4i_pwm_data {
+	bool has_bus_clock;
 	bool has_prescaler_bypass;
 	bool has_reset;
 	unsigned int npwm;
@@ -79,6 +80,7 @@ struct sun4i_pwm_data {
=20
 struct sun4i_pwm_chip {
 	struct pwm_chip chip;
+	struct clk *bus_clk;
 	struct clk *clk;
 	struct reset_control *rst;
 	void __iomem *base;
@@ -382,6 +384,16 @@ static int sun4i_pwm_probe(struct platform_device *p=
dev)
 		reset_control_deassert(pwm->rst);
 	}
=20
+	if (pwm->data->has_bus_clock) {
+		pwm->bus_clk =3D devm_clk_get(&pdev->dev, "bus");
+		if (IS_ERR(pwm->bus_clk)) {
+			ret =3D PTR_ERR(pwm->bus_clk);
+			goto err_bus;
+		}
+
+		clk_prepare_enable(pwm->bus_clk);
+	}
+
 	pwm->chip.dev =3D &pdev->dev;
 	pwm->chip.ops =3D &sun4i_pwm_ops;
 	pwm->chip.base =3D -1;
@@ -402,6 +414,8 @@ static int sun4i_pwm_probe(struct platform_device *pd=
ev)
 	return 0;
=20
 err_pwm_add:
+	clk_disable_unprepare(pwm->bus_clk);
+err_bus:
 	reset_control_assert(pwm->rst);
=20
 	return ret;
@@ -416,6 +430,7 @@ static int sun4i_pwm_remove(struct platform_device *p=
dev)
 	if (ret)
 		return ret;
=20
+	clk_disable_unprepare(pwm->bus_clk);
 	reset_control_assert(pwm->rst);
=20
 	return 0;
--=20
2.22.0

