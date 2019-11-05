Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD66EFE23
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Nov 2019 14:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389125AbfKENPN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Nov 2019 08:15:13 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35071 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389071AbfKENPH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Nov 2019 08:15:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id l10so21313494wrb.2;
        Tue, 05 Nov 2019 05:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n0fXA0HzdVYuMz+Yhj3TQjNmtcRgY2Ng0Cfj0PwkXk0=;
        b=nE6YVB8/dRlU2b3fHPmJ2QWHV0BQW340fAH+uA5LHsNv3jb6e/FKJTcJXzPlO7+ioU
         RNNPdn41M5dPxZMGxbnfPewuo/6zUyxgLQReHbeqBA6z2fIwxoVFagoab0i6Irbi4XDH
         Yc1LF0UfhEFlmoSKZNTZez+2H1Z7hE+bxkYwzTb6Rnzdev0pwqyN+nZYO2BjH+ZT8+iE
         g9WxNeAW4ZzQFVleSiSoL4eerfT36Zg6FA4T5dw6xQ+GKJ/pU/O4Uwd6AG99Mn1/zjGH
         6uAhBmknvt0h5wga6lJaNgb3ea1y3gfv8a/tvkRGDj6V/8j+K9BV1sr4HwD/eAd9uUiY
         mfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n0fXA0HzdVYuMz+Yhj3TQjNmtcRgY2Ng0Cfj0PwkXk0=;
        b=HPwhbohCKefDo/5o9zz8SHQbCgJ8jYTMxSqcQYvIrTeBSFCN3IDVjwuLGUP9SkbR2t
         3iDtc/SVjWdDtdrHmprMQwJoHe0XCQGMqbsUZjN0RCqhmWHsSPMFeuigWuAp/IRHuKZW
         CHSYVwzbnYc7eS7bBdWshw3vHntn3WSjDjx8l5JNvt26Ux0QusmwsamgI6b1jCFmNtAl
         0cXl0qVT8jBrgd7NA1E6E2z1GYqHbuLfq5LEfI5grY/iBe0RrXOQ6TR++BfqW5tIH4Tw
         DQLUKeW8/NKgq5kDWMj2BMg46IMm0ZOIVN7ReqBSw/ef5qU+IB0W4rhRX14gOjUclo1g
         2ILg==
X-Gm-Message-State: APjAAAVx0+G3E9Fr6Gm7NjF+yLYLcWYstsl41RKJUGxCMxcfmvRcsQ7Z
        NRlTNgz0jL5n0wOAvj/WNws=
X-Google-Smtp-Source: APXvYqwDhiEdJsPCcbhoaUwHdt2VPbYYzr78z9ZpGF4u1c+27BE7Axc5XPOsR2n+RkKWXf8PUlPbIA==
X-Received: by 2002:a5d:404d:: with SMTP id w13mr29418841wrp.185.1572959705408;
        Tue, 05 Nov 2019 05:15:05 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id a6sm13549920wmj.1.2019.11.05.05.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 05:15:04 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?=27Uwe=20Kleine-K=C3=B6nig=27?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 6/7] arm64: dts: allwinner: h6: Add PWM node
Date:   Tue,  5 Nov 2019 14:14:55 +0100
Message-Id: <20191105131456.32400-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191105131456.32400-1-peron.clem@gmail.com>
References: <20191105131456.32400-1-peron.clem@gmail.com>
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

