Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA8F10032B
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Nov 2019 12:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfKRLAp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Nov 2019 06:00:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36355 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfKRLAo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Nov 2019 06:00:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so18902619wrx.3;
        Mon, 18 Nov 2019 03:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+uPwPfx0oQerpYTv3rMNbZ1we4qpdrwsuG2bGFowiTE=;
        b=QFDuz+IW+HnUgegZRGK3iKMMqIgXz0PnyggLLboNAo23LCWY2Gj5hyXBR8JHU8sDEW
         2nFd8+IW1Nzpj3BTX/Ttt6LotZtoOk7OE4hTSRRql/uwPopINBAR0Tprett8ddJKHgBh
         3vHJuPOfA60KLKupuWrAF4vdz5IxsfObywmNmB/3ySzo/X0LP3uLOzkowkzFN32lsHlR
         REVQ60uYcjw5vMMLLNNKA0ylvY5KVclB/BVwP7Cy1QT+kzWy6ZVtQ5JRHn0Ejlq0DYkw
         ASV1ziUmM3K+C7WVSn+VR1BbebvHWGO6sPbiG+O1OHWtjqLpRtt6spd1TTCBAALQ3Ai9
         qufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+uPwPfx0oQerpYTv3rMNbZ1we4qpdrwsuG2bGFowiTE=;
        b=DSdCtbvaDQdpi3UXaK89QKkjoKU5jEgE+l5CiudaEeAbGka+6fEp1GNWtY9sM+JPm0
         5TWJOCsQ/uCEjaPGAsWryucSZuDRXFprWx7e4DQuAYMkksPL/MFKmJSpsfY0EcYkTSsq
         9kDVB6JNyh4pV8OFwWAtinNsiSa9UXHwaMxVgqkpoOgNzguzWZRudZWWFovnk8Y5nO+s
         lq58VRX96blDbKRHMS1M3uWcaKmUiBNdEVnPYeahNg0zEs7Mgrv1sa6+JEH8CByUOcWX
         9dR8ALSf97qKteUyfgUVt/0JJ/5MaWZPbJAa1tHBDl+ufhXDrIdPOX6XF+8/RizKW2Ur
         CdMw==
X-Gm-Message-State: APjAAAXRsn6Y8w21lJSHZZ36oXfmUVW/Zc+Rx5lvepN7tMzdUwZQcn50
        sZCJOrNjR3JVePp62nIx2n4=
X-Google-Smtp-Source: APXvYqyaEaWN5edD71vuH2Nr7q1utFJujX5hmEgB41Q5ofpd4MyhhKPr56RU/npbmympYwagPqL5hA==
X-Received: by 2002:adf:f20d:: with SMTP id p13mr27767215wro.325.1574074841802;
        Mon, 18 Nov 2019 03:00:41 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id f67sm19873313wme.16.2019.11.18.03.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:00:41 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v6 3/8] pwm: sun4i: Prefer "mod" clock to unnamed
Date:   Mon, 18 Nov 2019 12:00:29 +0100
Message-Id: <20191118110034.19444-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191118110034.19444-1-peron.clem@gmail.com>
References: <20191118110034.19444-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

New device tree bindings called the source clock of the module
"mod" when several clocks are defined.

Try to get a clock called "mod" if nothing is found try to get
an unnamed clock.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/pwm/pwm-sun4i.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index c17935805690..6d97fef4ed43 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -362,9 +362,34 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pwm->base))
 		return PTR_ERR(pwm->base);
 
-	pwm->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(pwm->clk))
+	/*
+	 * All hardware variants need a source clock that is divided and
+	 * then feeds the counter that defines the output wave form. In the
+	 * device tree this clock is either unnamed or called "mod".
+	 * Some variants (e.g. H6) need another clock to access the
+	 * hardware registers; this is called "bus".
+	 * So we request "mod" first (and ignore the corner case that a
+	 * parent provides a "mod" clock while the right one would be the
+	 * unnamed one of the PWM device) and if this is not found we fall
+	 * back to the first clock of the PWM.
+	 */
+	pwm->clk = devm_clk_get_optional(&pdev->dev, "mod");
+	if (IS_ERR(pwm->clk)) {
+		if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "get mod clock failed %pe\n",
+				pwm->clk);
 		return PTR_ERR(pwm->clk);
+	}
+
+	if (!pwm->clk) {
+		pwm->clk = devm_clk_get(&pdev->dev, NULL);
+		if (IS_ERR(pwm->clk)) {
+			if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
+				dev_err(&pdev->dev, "get unnamed clock failed %pe\n",
+					pwm->clk);
+			return PTR_ERR(pwm->clk);
+		}
+	}
 
 	pwm->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
 	if (IS_ERR(pwm->rst)) {
-- 
2.20.1

