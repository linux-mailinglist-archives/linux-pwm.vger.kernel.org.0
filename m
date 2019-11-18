Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA74100173
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Nov 2019 10:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKRJiB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Nov 2019 04:38:01 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43107 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfKRJhu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Nov 2019 04:37:50 -0500
Received: by mail-wr1-f65.google.com with SMTP id n1so18524582wra.10;
        Mon, 18 Nov 2019 01:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q0mPzKXAC37oXp0wVkV8/ys9/u7aTcSnLuWMUuY5ccw=;
        b=pEnL5y/JfRfOj2VPs0MQ3Dm3cpqhOVzzq3YSk4naex2AEYy/SLeY89R3sGnuctZItW
         BxhOnaPxdCNgbUsWYzgKqs5uERI7uJONWQf8gCeZisSfvEp5Fro370miD//0aoHX0xOf
         BGOvV8yRCtX8pxFbShH5ClZ2zACLzMspCc4WOq95oKRaQZY4u1uAbWlqdeQ9JzFuaUJg
         S+mn15qg9dQrTvcYtm3wnEZyu29s+b8FN+UZOD5DfVFQ9JhNSPmnpJq6hDcgo1afGQV/
         RSYi95GxiUyNXVc1hlSe6w49Q5GF6DrnL++1l2W0mqLKqV5mzJej2HNcphKzTTzWCREh
         CqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q0mPzKXAC37oXp0wVkV8/ys9/u7aTcSnLuWMUuY5ccw=;
        b=bIab1tacR1WG4uMqyEl6Hy3Ixj9JyCD+quCZDcRTdOyTW69y2KMuffYXxq6nxJpTEl
         piOLevePDof/VqUi7Bx5XGaymXs1HM7tcrxVRO3ExL3DPA/bude4mdHGwVDWI9cbFfaS
         YFVwGPNcGGLKnJdI01xqNtVmCKIeuhsSwpQo3JYS3v79mP6lCGORgz/+fIfeZbc4YcNe
         p67nTGWnDjd56Y7nCaViJxTsmDcUxPWlVJ2aNf8vE5Fk1GE8hmSQBDsphuD3VYkxO3ax
         23zsHMyYHGv8tu5etx4ZeyHhDRb3k1RM/hGpyH3e2TYx9CrLhsAwwBV8JbB2xn/4XiUI
         iQLA==
X-Gm-Message-State: APjAAAVlWA2kr9WmcisUfl5VjR6CMeBtH2H3Txb/IHYb7CRhyWnFaBuv
        w7U2zsRiGeGR1s4XaWQmrcoTruSEcSlWgA==
X-Google-Smtp-Source: APXvYqxuDV4SIDq7LKd+hcWzsyqT+zaAXEO9EyFr4PnVgO9NKkGUDD24RwUvGUU9Rstz0wduFfOpBg==
X-Received: by 2002:a5d:49c4:: with SMTP id t4mr29606700wrs.226.1574069868491;
        Mon, 18 Nov 2019 01:37:48 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id w10sm19006687wmd.26.2019.11.18.01.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 01:37:47 -0800 (PST)
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
Subject: [PATCH v5 7/8] arm64: dts: allwinner: h6: Add PWM node
Date:   Mon, 18 Nov 2019 10:37:26 +0100
Message-Id: <20191118093727.21899-8-peron.clem@gmail.com>
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
index 29824081b43b..6d4bde488f15 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -245,6 +245,16 @@
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

