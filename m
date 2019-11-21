Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05255105ABB
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Nov 2019 20:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfKUT7S (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 21 Nov 2019 14:59:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33446 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfKUT7Q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Nov 2019 14:59:16 -0500
Received: by mail-wm1-f65.google.com with SMTP id t26so4605893wmi.0;
        Thu, 21 Nov 2019 11:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PYYcMhCYLh99IaUN22VzlWfjt3WzTsIGH/YGey+qGyI=;
        b=i9w4EOY4O9bXhQu+sR8nZY5pzFKJZCx/BBuFxaVSZR+0PdyRLkH8st0Ng44twdhayu
         nUO7fWgGO8VqhbTGoi+oLEq3kTO4Yoj//6rgF+nYd9LBn77ceoF76LDjrlz2zDf2RLn/
         BZLMX0HRa5/2o0A58gV3UyjYec2lWJ9VDn9UHP+iXQQhQLYbidwuK0NJ+GGmfRReQcex
         vfpcshQMFpJXNpZ1F5u3OnyDzU2Ao0/d55n1dnWwb499EJNRyT6cI8HjsL0BOXwKI9de
         a3RjQk7IKI/UwDKaag+F1pHvUNgryebvGzR1yTqwRYZHbhRaEZFbJtn2gPnrq7paTbGr
         YOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PYYcMhCYLh99IaUN22VzlWfjt3WzTsIGH/YGey+qGyI=;
        b=LxaXeJyjxDvjdSi1HbPFMITaD+3pknvhjB1hodvl0NU3PM5uZq+rqwEFxjR3h2paOx
         0ixC35wbHsv7pjyYq575LvL5mvl38IDMuTHpcReGzHHhXqjTkrFgbz+COcGRIfQGVEHs
         oRPxeUxDWSdQQNwOc1eKjvUaRftBxgQ/4RU+mQEM55Ym13Z5QvPpsRx32cf7K9TiPlh1
         5WNUTQi7fTi3jgOLRu/X7KbUxE7gzX0xEe8Y9hAG8V43mL2xsnibrwCrmy080VzHFemu
         1YgshievVBOclNJNxamTC+wFsLBGFjMsHcrsIHw+kO4y51LPmaJ9GLW+LrCpRMx6nLFe
         J/wA==
X-Gm-Message-State: APjAAAXvRGCROZWDyCBcmMgq7vzsBEvSMIk28f4WSrgJTNkcsv27u9Ut
        8pvi0GHz7T25fcacnDbHXIM=
X-Google-Smtp-Source: APXvYqwbgqimjqppMsN2KbSc785eOX59193AYNJJcYkigIB+7/VTzs4LtmZNnv6gckI42ubUc8ba7w==
X-Received: by 2002:a1c:6a1a:: with SMTP id f26mr12594907wmc.19.1574366354139;
        Thu, 21 Nov 2019 11:59:14 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id l4sm747124wme.4.2019.11.21.11.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 11:59:13 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v8 3/6] pwm: sun4i: Add an optional probe for bus clock
Date:   Thu, 21 Nov 2019 20:58:59 +0100
Message-Id: <20191121195902.6906-4-peron.clem@gmail.com>
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

From: Jernej Skrabec <jernej.skrabec@siol.net>

H6 PWM core needs bus clock to be enabled in order to work.

Add an optional probe for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/pwm/pwm-sun4i.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 369990ae7d09..66befd8d6f9c 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -78,6 +78,7 @@ struct sun4i_pwm_data {
 
 struct sun4i_pwm_chip {
 	struct pwm_chip chip;
+	struct clk *bus_clk;
 	struct clk *clk;
 	struct reset_control *rst;
 	void __iomem *base;
@@ -391,6 +392,14 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 		}
 	}
 
+	pwm->bus_clk = devm_clk_get_optional(&pdev->dev, "bus");
+	if (IS_ERR(pwm->bus_clk)) {
+		if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "get bus clock failed %pe\n",
+				pwm->bus_clk);
+		return PTR_ERR(pwm->bus_clk);
+	}
+
 	pwm->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
 	if (IS_ERR(pwm->rst)) {
 		if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
@@ -407,6 +416,17 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/*
+	 * We're keeping the bus clock on for the sake of simplicity.
+	 * Actually it only needs to be on for hardware register accesses.
+	 */
+	ret = clk_prepare_enable(pwm->bus_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Cannot prepare and enable bus_clk %d\n",
+			ret);
+		goto err_bus;
+	}
+
 	pwm->chip.dev = &pdev->dev;
 	pwm->chip.ops = &sun4i_pwm_ops;
 	pwm->chip.base = -1;
@@ -427,6 +447,8 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	return 0;
 
 err_pwm_add:
+	clk_disable_unprepare(pwm->bus_clk);
+err_bus:
 	reset_control_assert(pwm->rst);
 
 	return ret;
@@ -441,6 +463,7 @@ static int sun4i_pwm_remove(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	clk_disable_unprepare(pwm->bus_clk);
 	reset_control_assert(pwm->rst);
 
 	return 0;
-- 
2.20.1

