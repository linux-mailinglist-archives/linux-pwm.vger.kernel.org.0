Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006DF1B8EB6
	for <lists+linux-pwm@lfdr.de>; Sun, 26 Apr 2020 12:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgDZKLv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 26 Apr 2020 06:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726116AbgDZKLu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 26 Apr 2020 06:11:50 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF9BC061A0C;
        Sun, 26 Apr 2020 03:11:49 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x25so16218376wmc.0;
        Sun, 26 Apr 2020 03:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=38Zt7pEGuLVXiT/st0D2AyWKW3xWiPY2bYtiMLWQK3Y=;
        b=PVTghr0FgcuBmCZ0PUMXezA+nNTKcI1Fygf3ezJu65NPeZgIBxfCaFa6awH9Zd0ue6
         Xwb3tBMIgTokisslyMLXG/zu4eydefaM4LGTSbM5jOv6AVNtZLxcvrGycj9v3ZFi3uNf
         Of8+v2yEYU1N0ybqdkXEVcMHw7rXJYQpg/3tr7pB6EdLjDaQft4aR79GwBR63MlZ0COW
         Wf3rWAGvJ4afQpjtOfM35KfcgdrdeYS9luG5nN4jNIpW9LankXkbti7qClolWiKZs8Rj
         6YWLNp62hGJ65qpnooLLU8vEe81YIPJJG4xfc/RtyjsCqK79yRyQ8bxI3dnsTzZ7pB3J
         n1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=38Zt7pEGuLVXiT/st0D2AyWKW3xWiPY2bYtiMLWQK3Y=;
        b=rfp4o2qXaIRLmvvS7eVZFsYEFo46jWTengnWMvMtIV1E8kKYbhOTB6eLGGn59lHpkI
         M/AM2b8+KGsWmzf6MhlQFuhhsgSO+/L7WJldUydH+5YNRJQtVytxJ1zqXuJq6HKDYoan
         jLCs11qdNqC3VSnQtGhCYTRRbBU/BqfKa8wrLfcJPf6tkinTqkm82FX/+zTG+Nv3swk2
         7OJ6Z/eIwFT5unFWo+v8qcrCyPLlp88bl8VKFNvGRzpXC5WT4Idc3PHQ1inSyoH4+Ijc
         BE+9bwiWgsqp6roPL2nNH3vGfSWSR2dkE8yTIACO7Lr2czzWeIdRTjpXLhC+pSTcXkUs
         /f3Q==
X-Gm-Message-State: AGi0PuYp2SfP6hVLL1noBpDHoSjjCzLqeJgYTd35zhdn7Sgr/yTOT57t
        MRi+fAnpw8UslV27Sc+oufE=
X-Google-Smtp-Source: APiQypKXFtdOYFrN+l5LO7+WgBAma4dWRhOE2oE7+TzVEBs1qJ7Dar8zrTy8d1BBmyaXKX6/yknvJg==
X-Received: by 2002:a1c:c2d4:: with SMTP id s203mr21788195wmf.128.1587895907126;
        Sun, 26 Apr 2020 03:11:47 -0700 (PDT)
Received: from localhost (89-104-3-59.customer.bnet.at. [89.104.3.59])
        by smtp.gmail.com with ESMTPSA id 1sm11366982wmi.0.2020.04.26.03.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 03:11:46 -0700 (PDT)
From:   Peter Vasil <peter.vasil@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Peter Vasil <peter.vasil@gmail.com>
Subject: [PATCH] pwm: sun4i: direct clock output support for Allwinner A64
Date:   Sun, 26 Apr 2020 12:11:22 +0200
Message-Id: <20200426101122.98318-1-peter.vasil@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Allwinner A64 is capable of a direct clock output on PWM (see A64
User Manual chapter 3.10). Add support for this in the sun4i PWM
driver and adjust compatibility in sun50i-a64 base device tree.

Signed-off-by: Peter Vasil <peter.vasil@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 6 ++----
 drivers/pwm/pwm-sun4i.c                       | 9 +++++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 31143fe64d91..c334fd106854 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -1069,8 +1069,7 @@ gic: interrupt-controller@1c81000 {
 		};
 
 		pwm: pwm@1c21400 {
-			compatible = "allwinner,sun50i-a64-pwm",
-				     "allwinner,sun5i-a13-pwm";
+			compatible = "allwinner,sun50i-a64-pwm";
 			reg = <0x01c21400 0x400>;
 			clocks = <&osc24M>;
 			pinctrl-names = "default";
@@ -1252,8 +1251,7 @@ r_ir: ir@1f02000 {
 		};
 
 		r_pwm: pwm@1f03800 {
-			compatible = "allwinner,sun50i-a64-pwm",
-				     "allwinner,sun5i-a13-pwm";
+			compatible = "allwinner,sun50i-a64-pwm";
 			reg = <0x01f03800 0x400>;
 			clocks = <&osc24M>;
 			pinctrl-names = "default";
diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 5c677c563349..18fbbe3277d0 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -352,6 +352,12 @@ static const struct sun4i_pwm_data sun4i_pwm_single_bypass = {
 	.npwm = 1,
 };
 
+static const struct sun4i_pwm_data sun50i_a64_pwm_data = {
+	.has_prescaler_bypass = true,
+	.has_direct_mod_clk_output = true,
+	.npwm = 1,
+};
+
 static const struct sun4i_pwm_data sun50i_h6_pwm_data = {
 	.has_prescaler_bypass = true,
 	.has_direct_mod_clk_output = true,
@@ -374,6 +380,9 @@ static const struct of_device_id sun4i_pwm_dt_ids[] = {
 	}, {
 		.compatible = "allwinner,sun8i-h3-pwm",
 		.data = &sun4i_pwm_single_bypass,
+	}, {
+		.compatible = "allwinner,sun50i-a64-pwm",
+		.data = &sun50i_a64_pwm_data,
 	}, {
 		.compatible = "allwinner,sun50i-h6-pwm",
 		.data = &sun50i_h6_pwm_data,
-- 
2.25.1

