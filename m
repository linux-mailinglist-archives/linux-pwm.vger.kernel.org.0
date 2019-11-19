Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACF5102B19
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Nov 2019 18:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfKSRxc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 19 Nov 2019 12:53:32 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33234 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbfKSRxc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 19 Nov 2019 12:53:32 -0500
Received: by mail-wr1-f67.google.com with SMTP id w9so24968370wrr.0;
        Tue, 19 Nov 2019 09:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q0mPzKXAC37oXp0wVkV8/ys9/u7aTcSnLuWMUuY5ccw=;
        b=kX2xzYkOJcey0IukBXgQckcOBqFfeKMPv7YciY4a3L0doXl5qmk0A2usdXyKAJIgZ0
         7eNa0NiVdsNwe5PsQcg/JLjb7hMqUj+611GewB5jwT9ULmoA8Bdl/5D+O3BXxlXGnOFj
         WO3IHhcSyZMcNGYYF1kcr1czchvuFfF8Xh6GsBkkCTrtyyBQMqCkTdcQuXtF7DACJkvq
         4/Q5Tn0uOlIETPi6UJ1atg6uty8SQhHJxAH1+9Howsr7fRttG/ri4mdKX8xrSWq249S8
         Da8kOFKoOLLvRgnOnTJkmvhgDWXuvqNP0o/UoHtROWRKubHpL79tewAs2qJhmr12mSQz
         GORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q0mPzKXAC37oXp0wVkV8/ys9/u7aTcSnLuWMUuY5ccw=;
        b=n/92RMOrtW/hJ/BSgIUBk85smNZUCKgfbAIwwqDcM9kUevIL96f6qJMxjdUGyLls68
         +ucV3oIYih+UOr5stnnMzqurvAETwGP+cxlqPGo2F5ZsQieoc3PX7xxIVhrVkKKxfR8e
         VFuX2cVmXvuf6kjCPz+K5CNICqoeXxKXGPD2+WSRv3r+CCBzcrmV8TOQy7y2p5smqioZ
         G6AMHiCnv4MwlMznCLTQhZr/zTg0Ihu1HRPafMcaVsMEcpjVjlK2XOuJlHpWYglrBh1c
         0g2YAeCqzHHLwvZ01bc5uccJm3aBm+U88o0ciHE/oqv34RQKxOF6PMAEDpjsuFXPkEqK
         8djg==
X-Gm-Message-State: APjAAAXi3tUQO9rlquOEE+PKuY1encV4X8KWGrqQL00s7YjDK9Z2chq4
        shOgEa8wCt1ketMYEuLEXLs=
X-Google-Smtp-Source: APXvYqzFlw39pjo+DqL/WXfkMNWpQBCjd95PTn5lbA4E2SEiaWGk7919C/2iTa87tf1G8RE9zuXazg==
X-Received: by 2002:a5d:5227:: with SMTP id i7mr38288820wra.277.1574186009397;
        Tue, 19 Nov 2019 09:53:29 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id l13sm3772618wmh.12.2019.11.19.09.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 09:53:28 -0800 (PST)
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
Subject: [PATCH v7 7/8] arm64: dts: allwinner: h6: Add PWM node
Date:   Tue, 19 Nov 2019 18:53:18 +0100
Message-Id: <20191119175319.16561-8-peron.clem@gmail.com>
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

