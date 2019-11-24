Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98F4210845A
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Nov 2019 18:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfKXRaV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 24 Nov 2019 12:30:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50728 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfKXRaV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 24 Nov 2019 12:30:21 -0500
Received: by mail-wm1-f65.google.com with SMTP id l17so12733366wmh.0;
        Sun, 24 Nov 2019 09:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sjixo6ht7XiGZb8/LNb/8Q06mHVbU6wMmziG5mNnwig=;
        b=OYiNMLLI89jLaAYadwdPkm8CYT0XjYMPJ5j0/PepSiMjSKL7Ho/STOqUc4r2yA8SgD
         2fSXE/uyQsx58Q93mYXDEGPk1joPHtLRGHOdJ4FeMWPiJ/Mz5s+nNY9k8w34jfVOHDB2
         dKBcOKD5ar5yZfmeIF5ega5MCRvWQ5a7ma73aWzbjbCo7U5UqtEbi7cah2IIH2JIpsp0
         wW8s/eHJzP1xxh3uz3xN/wK1V4wtL1z47YoZmCPDHOu7UI+eVUpKzClJ/LHqjFYekFJ4
         93YidniTK30G3JkwscNuRpPRJKI3jFrQ8s8Z0PY3UkDKY2+izKO9Bf2LekGq7zrBjrRG
         C00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sjixo6ht7XiGZb8/LNb/8Q06mHVbU6wMmziG5mNnwig=;
        b=J3oPM4iA8yKpUq15Th879PXtUT8qtvQ9TqNN2uAxtyDFEuNMsl3EuFY40Wo4RSEdMR
         D9B3XHkx01dxaA8lYLGG1FmBoiJDPk9TaEwkOZwskAYvvHJeuCaAilGw1FjbAecfg0rZ
         kEMt64El9EwnTwBY5ODU87kId5cugVYtYOPOILI9Sw4aBbAOhx2noLLVg81jbiOdGtDU
         ULw0gVbPH12hB7xaAmcSkHAWEyGNvzlSD6fgDVjAvZHI1motp8a0zu9fuJtzSY4OxC06
         YyL8qFsHF//Wx4oq5/+CcXhKCryb8xhGU7WmCZvBhZ/sABiIdJQiOdFdf98h8/xzIEZA
         N5ZA==
X-Gm-Message-State: APjAAAX9HTiwstfweprSV3QlRb2tyMpWVrJKXPKaEui8qJpjlBjLYMUX
        U3+wHMNZWBZhPvLw/ELjrMprGmKzB9RPyQ==
X-Google-Smtp-Source: APXvYqzdwq6I0QuiWDS1GB2PvZLPk9+ENLHHn5zVHJOxjm5uJwP+lPkagFhiQeWjWwyFSGT7X09ZbQ==
X-Received: by 2002:a7b:c1d3:: with SMTP id a19mr6652300wmj.127.1574616618566;
        Sun, 24 Nov 2019 09:30:18 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id n13sm5537275wmi.25.2019.11.24.09.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 09:30:18 -0800 (PST)
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
Subject: [PATCH v9 6/6] pwm: sun4i: Add support for H6 PWM
Date:   Sun, 24 Nov 2019 18:29:08 +0100
Message-Id: <20191124172908.10804-7-peron.clem@gmail.com>
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

From: Jernej Skrabec <jernej.skrabec@siol.net>

Now that sun4i PWM driver supports deasserting reset line and enabling
bus clock, support for H6 PWM can be added.

Note that while H6 PWM has two channels, only first one is wired to
output pin. Second channel is used as a clock source to companion AC200
chip which is bundled into same package.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/pwm/pwm-sun4i.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 07bf7be6074b..c394878c7e5d 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -360,6 +360,12 @@ static const struct sun4i_pwm_data sun4i_pwm_single_bypass = {
 	.npwm = 1,
 };
 
+static const struct sun4i_pwm_data sun50i_h6_pwm_data = {
+	.has_prescaler_bypass = true,
+	.has_direct_mod_clk_output = true,
+	.npwm = 2,
+};
+
 static const struct of_device_id sun4i_pwm_dt_ids[] = {
 	{
 		.compatible = "allwinner,sun4i-a10-pwm",
@@ -376,6 +382,9 @@ static const struct of_device_id sun4i_pwm_dt_ids[] = {
 	}, {
 		.compatible = "allwinner,sun8i-h3-pwm",
 		.data = &sun4i_pwm_single_bypass,
+	}, {
+		.compatible = "allwinner,sun50i-h6-pwm",
+		.data = &sun50i_h6_pwm_data,
 	}, {
 		/* sentinel */
 	},
-- 
2.20.1

