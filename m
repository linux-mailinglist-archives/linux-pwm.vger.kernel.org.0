Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 989DE100166
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Nov 2019 10:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfKRJhw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Nov 2019 04:37:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37818 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfKRJhu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Nov 2019 04:37:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id b17so17915945wmj.2;
        Mon, 18 Nov 2019 01:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vod7tJCc8xx/G0ZpiGEd0t8UwWFPWKuiAaWz9aKP/9w=;
        b=qIiuY4DCzDm5JRTLShB/ummcyU5Sfck4itXI5JsUH2E16LYfZUt3t7Epg6slARO5OW
         0IAogTuZ1EseBp31dVq4btqRADizcM74TeE6quxd7sc03lPnzfOj4WhCvfYJMlxXWNiw
         0Iff+QIM/n0MAWaGp6/v1rXAB2/HX6zhmi+6Ijclv3sgc+1CaNWcQxsnCqTTdX+KHXOL
         VLMLyctJ20q73sC9LfGpnjed0WRTUh9HIPAQTt9USkhZ6ZR1d4S99aJS3dw8fLCPrYqb
         17BwLM2ebwsFavHQTF30r3dqNQ5+zCj2dEMZfofeZpqG1QmmjkcemM+qozplG0TdWNDp
         a3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vod7tJCc8xx/G0ZpiGEd0t8UwWFPWKuiAaWz9aKP/9w=;
        b=TSCYtbjRtDYoJz6OZH3CYk1EMj6varP82qGPFKmARNeILY2v8QycOJYPizlEM+fNNC
         4oa5fdtq5L725WOMq342Py3mr0esf9HHiUBKPbSNQtYLoYVKaXkCpJsJ4G+eSrbEYx6B
         dQ4AwLy1tHcHXiSDsMxudF2Sgh/4YFmVF6QbJa2TQ1cP5MTuhf8epfeKKPfsouS3TPWY
         4+FeSwYA9rZWEbLXjCK7JbelelQC1xD/wW40Epsp6IeOoSBNCijF9jhNWBC+ZUuiMa2J
         sQvzOe35ef6jWVW6cY9olqHO2vvuk52nGBRbhwMuDzxSK0U5jwniMD5KdI+UI/NbziFz
         f9ag==
X-Gm-Message-State: APjAAAVA+bIwhzKrXOZZdfk47X9c+yY1AV2bgS7vCURbC/c/LSOz62qL
        S6Cth651C3Zx3CSe5IvHAA8=
X-Google-Smtp-Source: APXvYqzLv1tO0gcDiCWBypni9a6vlJjYgSdq+2MJNZgwmUFWVgTnni8xpPgEmcU5Pk2qcDz+Ne4nqw==
X-Received: by 2002:a1c:c917:: with SMTP id f23mr28850531wmb.95.1574069867482;
        Mon, 18 Nov 2019 01:37:47 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id w10sm19006687wmd.26.2019.11.18.01.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 01:37:46 -0800 (PST)
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
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 6/8] pwm: sun4i: Add support for H6 PWM
Date:   Mon, 18 Nov 2019 10:37:25 +0100
Message-Id: <20191118093727.21899-7-peron.clem@gmail.com>
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
index b64250b7e2be..8d6699659db7 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -358,6 +358,12 @@ static const struct sun4i_pwm_data sun4i_pwm_single_bypass = {
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
@@ -374,6 +380,9 @@ static const struct of_device_id sun4i_pwm_dt_ids[] = {
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

