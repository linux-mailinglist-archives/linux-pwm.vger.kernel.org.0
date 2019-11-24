Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5546108456
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Nov 2019 18:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfKXRaF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 24 Nov 2019 12:30:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53281 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfKXRaF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 24 Nov 2019 12:30:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id u18so12735960wmc.3;
        Sun, 24 Nov 2019 09:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=11OJgFf0c1fRpm2QKhR90dd74bTjmn3YLFrj0+iDgME=;
        b=JxvIqrQsR3EH7tVEg3Mt/EsgCifsBPlln+APafYJtr99HPNoUtYqSCBEkFbeyc9wZt
         X97dKcORrbfwyvlS4808HTu/f031TGUSxsGrbitSrqk1xKGMHlywKBKZjQTAo53+SSAr
         4AnJtK1d3ENQerbwCjewLj2UDU+9fSHMniqXxpjJg2ME6TKq8N16wqEcqnfezw7o/p4/
         DxvPqwiqHS+fBB8vUsFpSNCTw3DtE5KrZHz+joqDk/1VFhevOT5XuKXdu4ZtQmz/T+UV
         HXDVHStVlHpDndteZ1icmtJyGiWFwS6B/BkRpBVS6XGJdijuTXb/LXqN4EW615naEmB9
         wtZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=11OJgFf0c1fRpm2QKhR90dd74bTjmn3YLFrj0+iDgME=;
        b=Q54EoOJ1oIy7KFov4TNBihWZVQICzig0wt8ZxpcBLR9WyNuIFssXKDdlaSu8OfWYIN
         yi8hE7y+k+6F65aNRvB4BpEeJSpVCHbFMyEejgdxatI/EW1+KBlUAi4YuQ8/tYiDgScr
         56+p6bP8/O8TVMnoHh4pGViZsEw4jb1HUKq3wlENSAeJhKHz1iwRWpAWdJ2eLHJtzFag
         DvHjovJ4X8kgstnBvvo1i0TZNsUUtOlgw0CRky520c08j7FAcmNxcVfjdybQVzjraYy+
         Ybf4Cnb7EHe4Iy3bDK50RVL1tq/3amiRdWBs4qoBIO5bOoSI1pzvatqa2IX0hkETJsea
         M6Qg==
X-Gm-Message-State: APjAAAVDS6kcpwuPZVHapT4aciLoRsO81GHhWZV3MjSF7N/Acv2487mN
        G07/eC571vjn0nmU7z/DTkc=
X-Google-Smtp-Source: APXvYqxCILgcleo6Lk2jlnRahagfAhZ8VPpjVIezqiUklQ+tzkHAg3+u75onarnPMn0IhMj0G1Nqkg==
X-Received: by 2002:a7b:cd86:: with SMTP id y6mr12934898wmj.30.1574616603668;
        Sun, 24 Nov 2019 09:30:03 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id n13sm5537275wmi.25.2019.11.24.09.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 09:30:03 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v9 2/6] pwm: sun4i: Prefer "mod" clock to unnamed
Date:   Sun, 24 Nov 2019 18:29:04 +0100
Message-Id: <20191124172908.10804-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191124172908.10804-1-peron.clem@gmail.com>
References: <20191124172908.10804-1-peron.clem@gmail.com>
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

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/pwm/pwm-sun4i.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 487899d4cc3f..80026167044b 100644
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

