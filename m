Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE982102B25
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Nov 2019 18:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKSRxz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 19 Nov 2019 12:53:55 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39012 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfKSRxa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 19 Nov 2019 12:53:30 -0500
Received: by mail-wm1-f67.google.com with SMTP id t26so4788796wmi.4;
        Tue, 19 Nov 2019 09:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+uPwPfx0oQerpYTv3rMNbZ1we4qpdrwsuG2bGFowiTE=;
        b=HrqbTpU48LtXXGhuT1jSoBXlW4dQYaVuKNPJ6cUTawNnHjXEbsNb2n+BtrFaIT0nxg
         jO0U2HrzGfy4kyXtUC/suSyd8YuQ1lB28fbgBv/rNCKapu5Q0EmVKEVIeNLjdTj+1lOB
         UfcojpSGvn4mY8QWbvlzHdDWCtJPBuPB9aRRGscQUs79XtKLnDCvPNkkJ19xsPlJBdRB
         y76yrpvQEmgaIa9po8DcKV70OOJk2lfCDp6KoT6W+wAsBJRwe9Etn5OH4Eik9P+qn+dh
         ib0klC/9sl7FbGu3gDtebUHe43V/2zVto6ZKc3hNx/Np+vi+obLmAZ4D+qav/uAGE0tb
         utQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+uPwPfx0oQerpYTv3rMNbZ1we4qpdrwsuG2bGFowiTE=;
        b=FdXWzeoFYPw7BQebqhZba3fohGGcw2LDRBkT4yIJLewRwS/EGoR7dNl1ujAaHVrvUs
         zWF8t1SXW4rvTxVrPL/ELbpih6Yfac+GolYION0FXZ4Cv3TV4Zi9Ic9YvM+GDABapLDX
         lDxMPrluYE+/jLsps+Np6x+6YXCyjVXNkZHG6WRxFu9KYUIlmRkLozzPc5NkH3nGfxiG
         k2Z2bKqVDIiMRaFrGpwWIajwnFSZv5TfAy37CuJJWXg5kluII51MURh0Xde5PjfpEgkz
         9Ez3q+fmhtNORYid/C7/LzEI1D9lInzHkScRzEn1MTkPLzb9Se4jHHBvVf8DYKSD5aij
         TNWg==
X-Gm-Message-State: APjAAAV3vdwBapWBaTGuoImhBASC3e5DPE36p4QmgmVr6AswCupCKseg
        XLdQx7Ppke2ewWFLJfWdajI=
X-Google-Smtp-Source: APXvYqxoIbx/qLj+H9mdcAmhEdkBaM+WWALtgFxviLoGVxHH9Lkd0YrjTBQkL8yEBwpAShppBEu69w==
X-Received: by 2002:a7b:c392:: with SMTP id s18mr6609135wmj.61.1574186006521;
        Tue, 19 Nov 2019 09:53:26 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id l13sm3772618wmh.12.2019.11.19.09.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 09:53:26 -0800 (PST)
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
Subject: [PATCH v7 3/8] pwm: sun4i: Prefer "mod" clock to unnamed
Date:   Tue, 19 Nov 2019 18:53:14 +0100
Message-Id: <20191119175319.16561-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191119175319.16561-1-peron.clem@gmail.com>
References: <20191119175319.16561-1-peron.clem@gmail.com>
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

