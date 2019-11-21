Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E95C4105ABF
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Nov 2019 20:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfKUT7W (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 21 Nov 2019 14:59:22 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38040 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfKUT7U (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Nov 2019 14:59:20 -0500
Received: by mail-wr1-f66.google.com with SMTP id i12so5962299wro.5;
        Thu, 21 Nov 2019 11:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x9TMHTvTHEI0MdeM6BG2NG5AiLP9dRdOdMlVTz+AH7c=;
        b=a+r84Eid4Y8fL00esj+hgbmpMIBj/5EY4jrhtjcwvQdR8QeidWW9uNe1vVGdX15W/m
         GbtMfniZGzLlGUDVV4x1+Yuz6YTNW/63dcCbA+2c5C7qTRfQVQUd48Ku3i/uJaPqpt0K
         1GKWzZkImpSpk/rVRIcwSDBR+AvOkAEyyCX76G3KLFhcbMKvmN+L5Xj3M7IXRl4L2i+c
         9cGCEmtbVPNcSn7zQvh2dZHeKr+QqeS+RlhVIRBuJhfuJNKOQBBsBpWzfjqT0jgg4OPM
         OKeq+d0QoXxUR8GaOQTaolYjku1EAq/5nCLw00pl/r5f5eHmHdHPNZMFAuD++kYjm6YN
         Olkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x9TMHTvTHEI0MdeM6BG2NG5AiLP9dRdOdMlVTz+AH7c=;
        b=k73sJPZF9TQgEC6Qc3Vk2dtLVqWEnWcKofbgasAG3hXRqtLz9Uf3JbReyr9DbZNf1B
         EDtjj4HR/zx/vQhL4g0VJQTZbmwxOCp2/j/za+IEtxVM+UZbeji8DJMG7vddbAFSd6zb
         wXgYxC7hAhXDjvsbay2K0iGtnxdZkE2gg70jJGLdrZ7DpbiwkEXmhNrv5Y6dBFLSRWOA
         L0/8tWVpgUtV+rDMlooa+8x5uSGf+6oxTYM9Ik/DfjhU4PEtsQAkZ61Fv9bc8fG8myVq
         UpJYUZXRhtHjAlMdEOqIxBesdPzrLiQsiH38TkrrPnfqtJOKYVtix3kBqLmmSwE8fTf5
         bbcw==
X-Gm-Message-State: APjAAAWprQeuRGZp2my50MSeWXY/t4JROUlt1QfqX835UTqELLbhMREb
        2FO8av9BBd87FVo+Xzg7JSk=
X-Google-Smtp-Source: APXvYqzdPYzPhB0QzXk/JHcPGUew6P1PoHo7/8DRZ0lLyE+wjlgKStea3Ce/GXZ3+54bfRop4kIX1w==
X-Received: by 2002:adf:f445:: with SMTP id f5mr13570931wrp.193.1574366356766;
        Thu, 21 Nov 2019 11:59:16 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id l4sm747124wme.4.2019.11.21.11.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 11:59:15 -0800 (PST)
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
Subject: [PATCH v8 6/6] pwm: sun4i: Add support for H6 PWM
Date:   Thu, 21 Nov 2019 20:59:02 +0100
Message-Id: <20191121195902.6906-7-peron.clem@gmail.com>
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
index 0fe9c680d6d0..84f3ccab47f9 100644
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

