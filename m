Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B533105ABA
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Nov 2019 20:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfKUT7S (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 21 Nov 2019 14:59:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46780 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfKUT7S (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Nov 2019 14:59:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so2532458wrl.13;
        Thu, 21 Nov 2019 11:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IWDES4H6FK9m7SMVyLGPZhTPZo+2N/nXcrBq8GxN+no=;
        b=EtkFtF8CBsyuucSxiIa/b0wzIAJkqo0ayTpBwFGhoOff674C94s/a9kNTBEi8s/tiF
         UVeFzrTS1024HfPlBsdYpUIkzBFSFdcqNa9ZMpob14BfvV9iwxHCiSxJXxUaug241dSU
         3y3kLuFSqQ/Ot5VJZ2U9Ru2zHTkK7NgPVQcLmRMTSmemtIEKnS4leeLwEsIhO01/xxPf
         aJkN85hmqBRynBBiOW8ocTvMDArMMdDJ2956VVZZ82eZxgQOJkDg397ve1gaEGQ5fBhK
         IidtqFLMMxL6UmmtnJUL4tvHbLuf98xnqvFnlzMiM7USLGVRm7Av8RXFUdPFfKLvnkHF
         Kz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IWDES4H6FK9m7SMVyLGPZhTPZo+2N/nXcrBq8GxN+no=;
        b=pq4G68q2bJfCO5VWZHKhXv2a3I/I6U8zvKLugo3nnHxBU/ph82DwLcaU+YPBbJK/tD
         Y7EOe/XdB4P91zftYdqkq8eJw1THz3gLI+r36zo8Ekn05M91rbGRdNXGvDB1gnogfVPS
         JxmT20NgFHf7t+sr02nKmOhYIacSjBaZv2HfRTxqWujZcdDVyya59lyislj70u+lxwYu
         HtZm3G8jHTuSQH/vH30kIAiVuTSv7jxFBy0LlQiE/hAieZYmY+7pihcb2SjNnXDopKSJ
         j6lbjHRKgcuPy+C4eEQ3XcOYWXEDcSx3pKpAhu6OjK1AC6SWUtftT6VNAd6lQHkpT9QK
         hiNA==
X-Gm-Message-State: APjAAAVHJY1BJ7ueKU2njW4fKD6W1IdP18+IxCPwspKWPiyjqpCwpYYD
        nsTYMfehBxXMLYam9QXzAeI=
X-Google-Smtp-Source: APXvYqzxnV1R6FQNd3QC0/8HqDTTJeYDU0/5hlp7oOWfU+vuXUM7WtJED6UShlFOpfkJH1TQUAkQbQ==
X-Received: by 2002:adf:f744:: with SMTP id z4mr13248893wrp.205.1574366352692;
        Thu, 21 Nov 2019 11:59:12 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id l4sm747124wme.4.2019.11.21.11.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 11:59:11 -0800 (PST)
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
Subject: [PATCH v8 2/6] pwm: sun4i: Prefer "mod" clock to unnamed
Date:   Thu, 21 Nov 2019 20:58:58 +0100
Message-Id: <20191121195902.6906-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191121195902.6906-1-peron.clem@gmail.com>
References: <20191121195902.6906-1-peron.clem@gmail.com>
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
index e353a03ec614..369990ae7d09 100644
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

