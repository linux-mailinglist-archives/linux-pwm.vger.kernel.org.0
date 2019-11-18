Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC47710017B
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Nov 2019 10:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKRJiO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Nov 2019 04:38:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34496 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfKRJhr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Nov 2019 04:37:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id e6so18584423wrw.1;
        Mon, 18 Nov 2019 01:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3oSzYYj438eAKcP5hk6lqHYItTlWnnUzKNHsPAjkdJc=;
        b=AAwSAzRJnxMXxjJhclwhlpl/mYNzB5ilqx+RifNxbzYksBz8LgaY8HM1HjolEFjUlL
         htMUYi1b7/J9koh5JDoM5lang7KZDLwjE6LCARKrKo2iUv6DaNBf4lTaUQGBHu4hWz7X
         5OHJlfP7Un+y6PgbkQ2SXfWbqW3hi7zz7xofwBFSxwRm6iYI23xFe3yjWbG3F6TLwiuR
         gdE7MYjSUXMpmX0782a7Kv8EzXZ/nArwW7O8qPZBz1ge4yY27txHV/SCApwR89XgItGo
         KdfQTO0P4EOkM8udo8IuJ90uquKhx1zz25e4/iCrXyT7XdDJoUkD8E5S10WNQHl0FOAt
         NbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3oSzYYj438eAKcP5hk6lqHYItTlWnnUzKNHsPAjkdJc=;
        b=nJ3hGiLxrsmnklzROxvIkRTpLuHKJqlfd2wX5n+RjiAwuDJnuYGg1ywRKP9ch3AYZd
         BqJnxSAxJVnK0G+bjiCXBy2mg1YyicCoJS0kXoJ6dktzzEIozrnon+dvfTFU0apczGaO
         A2p00V5Cw4weHpRI0qleQ1DvFvo4461e8nrw4GXPFJtePPrlRtDswoxEbsV/Cb0Z/LyU
         97VjZGbi3qs8EOKrTyGGZDLapG2MxpYq9wcaG0UEKosz8qA8lkNZfZNKOJj8DxkoD8QZ
         ffyIS2+RljDVdrhccvJ1K7WnSbO+ozYECSpBkfBAcqbVRwBwxaplRqUFVR2I4iq7nVZR
         +nug==
X-Gm-Message-State: APjAAAXRrLPSXFQcCkKc9VtMeoRjFAphO47Q7NF9BsGj25GYpPsZvnbn
        5wRrLQH689Y1ouewcO7x+h4=
X-Google-Smtp-Source: APXvYqzDOwuq0A8F4oYn60+HJq1SW+kqllssigTTUg8uT9nBRUvhHeMoTlhVG7xt0+yV2c7Jg6TXXw==
X-Received: by 2002:adf:fd91:: with SMTP id d17mr28262822wrr.214.1574069864966;
        Mon, 18 Nov 2019 01:37:44 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id w10sm19006687wmd.26.2019.11.18.01.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 01:37:44 -0800 (PST)
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
Subject: [PATCH v5 3/8] pwm: sun4i: Prefer "mod" clock to unnamed
Date:   Mon, 18 Nov 2019 10:37:22 +0100
Message-Id: <20191118093727.21899-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191118093727.21899-1-peron.clem@gmail.com>
References: <20191118093727.21899-1-peron.clem@gmail.com>
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
index c17935805690..bbb1ed194c0e 100644
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
+			dev_err(&pdev->dev, "get clock failed %pe\n",
+				pwm->clk);
 		return PTR_ERR(pwm->clk);
+	}
+
+	if (!pwm->clk) {
+		pwm->clk = devm_clk_get(&pdev->dev, NULL);
+		if (IS_ERR(pwm->clk)) {
+			if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
+				dev_err(&pdev->dev, "get clock failed %pe\n",
+					pwm->clk);
+			return PTR_ERR(pwm->clk);
+		}
+	}
 
 	pwm->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
 	if (IS_ERR(pwm->rst)) {
-- 
2.20.1

