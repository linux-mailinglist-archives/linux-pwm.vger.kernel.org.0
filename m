Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0E26102B1C
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Nov 2019 18:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfKSRxg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 19 Nov 2019 12:53:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46164 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbfKSRxc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 19 Nov 2019 12:53:32 -0500
Received: by mail-wr1-f68.google.com with SMTP id b3so24943417wrs.13;
        Tue, 19 Nov 2019 09:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iGqUalssFt90BW+qC26cPJ2ocimtOg3RIH0RE3W1sS4=;
        b=Fc13efBMJJjOXeqjH+ZH/G7w0cMsQNvHOnfUpMSgYCkHs+tF+L3ULQ25t7ZQBQutNE
         T+VProISjfu37CsMUc0z10Y3ljPZiXievptG17p1rtrrFzKesy+AvID1JSBuZ2TrUV/r
         EndFAJzzb1E1x4+NirNRghaeVYsxqn0t605JjeWRIt164/KHhNVTZP7w3zBfxksXUt63
         +UhoILSnlqiFCFsiF8OCJlyr7S+dDFExinST2zBeqUJZJC0/ck3zs25sGr/fPjVZF7Qk
         1xs+9jnhqfg+Mrx/fIX2faWX5k0tDgUj7dZ05hQ2763TpIWLsQCuGsM3L+xoJKcnIoQX
         Dgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iGqUalssFt90BW+qC26cPJ2ocimtOg3RIH0RE3W1sS4=;
        b=cLn1N17Ztn+jFABlYj+N/1q2Kt9veze3scJKnG/12LG8IiZ4s90GlIAC/FmpPC57Tw
         jUZccoprThXiiLBlsKp4ZiNJhO0c3/RJmHLIH/dQ2DnFis3blB43Vd9kZJp7IXEYASoQ
         Fyj1wI0eqOnltc+OczAQUFkogyGas+G72nD65lxbEIY590fSePJ5AU0O1yGB0K3AnrDO
         gxvyYiYympaGc5ZOb0QuEWUj1zKpmMOUL+VT7lqhDj9DPgkKJFX7uXsMSIHF8ptMx3Wo
         Q9uZ36qpQCzN6pUBGvjUV2FOrMA7Pz5ACaTfYhxoysVriuIjHmnrO4kvrHhFQSfVBiqj
         SN5A==
X-Gm-Message-State: APjAAAUPXeEI7Ms0AWZTZO0FGpgmnvCBVosFQF4OjKe5v/OWgEq64dCQ
        x8mUju+pSGSrR5R25qScdGtP9GGHl6O/1w==
X-Google-Smtp-Source: APXvYqyrBcqNH9t86bk+axnFrVx1ZfsuKnxRbES8aE/F8d/qm8q7ETQ/uOkWuTpa8cWqpKUFPKW04A==
X-Received: by 2002:adf:e78c:: with SMTP id n12mr36004693wrm.94.1574186010055;
        Tue, 19 Nov 2019 09:53:30 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id l13sm3772618wmh.12.2019.11.19.09.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 09:53:29 -0800 (PST)
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
Subject: [PATCH v7 8/8] [DO NOT MERGE] arm64: allwinner: h6: enable Beelink GS1 PWM
Date:   Tue, 19 Nov 2019 18:53:19 +0100
Message-Id: <20191119175319.16561-9-peron.clem@gmail.com>
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

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index f335f7482a73..cf684bc7374d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -136,6 +136,10 @@
 	vcc-pg-supply = <&reg_aldo1>;
 };
 
+&pwm {
+	status = "okay";
+};
+
 &r_i2c {
 	status = "okay";
 
-- 
2.20.1

