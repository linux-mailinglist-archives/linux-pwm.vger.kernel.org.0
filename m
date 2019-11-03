Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB352ED4AC
	for <lists+linux-pwm@lfdr.de>; Sun,  3 Nov 2019 21:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfKCUdy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 3 Nov 2019 15:33:54 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37666 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbfKCUdx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 3 Nov 2019 15:33:53 -0500
Received: by mail-wr1-f67.google.com with SMTP id t1so8862977wrv.4;
        Sun, 03 Nov 2019 12:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n0fXA0HzdVYuMz+Yhj3TQjNmtcRgY2Ng0Cfj0PwkXk0=;
        b=i/sky6bsfSoF+v66SZuJapjuBGutQRDLdacALuPS5Wpd4itve6qDo356E0DWwjjenP
         XNxa4Ro0IGjjt/oLMELFfbsRrkIezE2nvUKkzc4eWUGT4vT4nFTFjjSnuPMihnkyMSST
         PmDy0XvN87/xfufSylj0f0yY6cfgPOP0Bze4I2s8Hj689EizoFVDxnirvSFGlJBjTuIu
         PR1A36HffOGv2pCZShvSGatli0jdBTlSAFkXgqDnRo+WuhUx0BazPwBRBhsvJrE2Jbey
         Og6OjYGsW6to5SDCttzC91MeD324z3tW42tiiQ6IPQiylpDDy0SnOl+OQM7Mvkdcqh4A
         HY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n0fXA0HzdVYuMz+Yhj3TQjNmtcRgY2Ng0Cfj0PwkXk0=;
        b=hg5uLNTG2tPwMuyp//+rjZBEoKLXkfF3anG86IrlpvLGj89mXR+anST46D6SS4D3bC
         ewkEZc5kxp3qK1Ww65UskSA4vNtgRQ/JaJO8ei3pvF+ANnlMoYHH/999FlbgN3tANoVH
         +s/Z3k4YHxYv+b0bJ8Gsyo5Ut8GtZ3ZmO+yCkjCpJRTEDd00Nq0DuhdA492eKVCG2o2e
         uEIvtTHg9WIKeM9LG1SpT9OR+U9XRE1/KcU0rwqjAz/LkWMw+SrCeLrdtkSpkvPnfgRe
         +qZzpGo7YBHjtz+mPySVNYNPp+DV0Hz5n5kFHLicnPtMBjnAtsk+oqIfPPmBuiYe216W
         DerA==
X-Gm-Message-State: APjAAAW9JOEq97bBCCUvSQYnLtc0RbAlgWdQV0f+Rc17W+BaXSpUqk3B
        OTLd646GVwmJywGN5+HPqzQ=
X-Google-Smtp-Source: APXvYqzVgddkWTmA7e/xSuVULVWuMR+fGR0jEkIJUyfWJe0RutYNHUuUB24XHZrQsrHhHYeIj6B/fQ==
X-Received: by 2002:a5d:404d:: with SMTP id w13mr21117897wrp.185.1572813230950;
        Sun, 03 Nov 2019 12:33:50 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id x16sm13644026wrp.91.2019.11.03.12.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 12:33:50 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?=27Uwe=20Kleine-K=C3=B6nig=27?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 6/7] arm64: dts: allwinner: h6: Add PWM node
Date:   Sun,  3 Nov 2019 21:33:33 +0100
Message-Id: <20191103203334.10539-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191103203334.10539-1-peron.clem@gmail.com>
References: <20191103203334.10539-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

Allwinner H6 PWM is similar to that in A20 except that it has additional
bus clock and reset line.

Note that first PWM channel is connected to output pin and second
channel is used internally, as a clock source to AC200 co-packaged chip.
This means that any combination of these two channels can be used and
thus it doesn't make sense to add pinctrl nodes at this point.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 0d5ea19336a1..b0d9ee1ead13 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -222,6 +222,16 @@
 			status = "disabled";
 		};
 
+		pwm: pwm@300a000 {
+			compatible = "allwinner,sun50i-h6-pwm";
+			reg = <0x0300a000 0x400>;
+			clocks = <&osc24M>, <&ccu CLK_BUS_PWM>;
+			clock-names = "mod", "bus";
+			resets = <&ccu RST_BUS_PWM>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		pio: pinctrl@300b000 {
 			compatible = "allwinner,sun50i-h6-pinctrl";
 			reg = <0x0300b000 0x400>;
-- 
2.20.1

