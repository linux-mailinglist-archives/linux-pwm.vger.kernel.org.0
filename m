Return-Path: <linux-pwm+bounces-5120-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EA4A5675E
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Mar 2025 13:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2872516784B
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Mar 2025 12:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F466217675;
	Fri,  7 Mar 2025 12:00:21 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E291A5BBB;
	Fri,  7 Mar 2025 12:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741348821; cv=none; b=GsIrSyuT4mgwBfKz/lkyUezfAsq8Y3xfAN3p/0TjOHTZlu9iB5E+3Y4SKZAZoxnqyEeCExq7wskVad3AWKczqfpbaqlhne6nL6OpXyLdEvNUZIe2N6WK09LWGP3pMtnCt5La60Z9RxQ1CJUKDnIQbyhww3nC8kXC53AVwJwrHtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741348821; c=relaxed/simple;
	bh=/x+qSuyLXYULQi4EgZ4qvLN2WXhpLCIge5kiEBcHkng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cq6T5cgUDCInTFwbnSZKR/s/WrE8hOMlamY03gtr1UrUCID9yOZoMYCC1w+lC8tG4FmimTjhf7oqj22a0P2dzGuNI2AY8EGTbdAWr06xFi21kHc8QS5kqyssfBHHeGcwL/IcsPycS+Gc09xBdgcNUaKCX7SQl6mDShb815eUpCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [119.122.215.89])
	by smtp.qiye.163.com (Hmail) with ESMTP id d5c9f2d7;
	Fri, 7 Mar 2025 20:00:12 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Yao Zi <ziyao@disroot.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 2/2] arm64: dts: rockchip: Add pwm nodes for RK3528
Date: Fri,  7 Mar 2025 20:00:04 +0800
Message-Id: <20250307120004.959980-3-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250307120004.959980-1-amadeus@jmu.edu.cn>
References: <20250307120004.959980-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTR4ZVklLH05NSUxNGENPGFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKTlVDQllXWRYaDxIVHRRZQVlPS0hVSktJSEJLQ1VKS0tVSk
	JZBg++
X-HM-Tid: 0a95707a369203a2kunmd5c9f2d7
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NAw6TAw4KzJKMjUKMzMpCEkp
	EBUKCSJVSlVKTE9KSE9DQ0pISk1IVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpOVUNCWVdZCAFZQUhIQ083Bg++

Add pwm nodes for RK3528. The PWM core on RK3528 is the same as
RK3328, but the driver does not support interrupts yet.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/rockchip/rk3528.dtsi | 88 ++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
index b1713ed4d7e2..ab1ac3273611 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
@@ -264,6 +264,94 @@ uart7: serial@ffa28000 {
 			status = "disabled";
 		};
 
+		pwm0: pwm@ffa90000 {
+			compatible = "rockchip,rk3528-pwm", "rockchip,rk3328-pwm";
+			reg = <0x0 0xffa90000 0x0 0x10>;
+			clocks = <&cru CLK_PWM0>, <&cru PCLK_PWM0>;
+			clock-names = "pwm", "pclk";
+			pinctrl-0 = <&pwm0m0_pins>;
+			pinctrl-names = "active";
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm1: pwm@ffa90010 {
+			compatible = "rockchip,rk3528-pwm", "rockchip,rk3328-pwm";
+			reg = <0x0 0xffa90010 0x0 0x10>;
+			clocks = <&cru CLK_PWM0>, <&cru PCLK_PWM0>;
+			clock-names = "pwm", "pclk";
+			pinctrl-0 = <&pwm1m0_pins>;
+			pinctrl-names = "active";
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm2: pwm@ffa90020 {
+			compatible = "rockchip,rk3528-pwm", "rockchip,rk3328-pwm";
+			reg = <0x0 0xffa90020 0x0 0x10>;
+			clocks = <&cru CLK_PWM0>, <&cru PCLK_PWM0>;
+			clock-names = "pwm", "pclk";
+			pinctrl-0 = <&pwm2m0_pins>;
+			pinctrl-names = "active";
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm3: pwm@ffa90030 {
+			compatible = "rockchip,rk3528-pwm", "rockchip,rk3328-pwm";
+			reg = <0x0 0xffa90030 0x0 0x10>;
+			clocks = <&cru CLK_PWM0>, <&cru PCLK_PWM0>;
+			clock-names = "pwm", "pclk";
+			pinctrl-0 = <&pwm3m0_pins>;
+			pinctrl-names = "active";
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm4: pwm@ffa98000 {
+			compatible = "rockchip,rk3528-pwm", "rockchip,rk3328-pwm";
+			reg = <0x0 0xffa98000 0x0 0x10>;
+			clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
+			clock-names = "pwm", "pclk";
+			pinctrl-0 = <&pwm4m0_pins>;
+			pinctrl-names = "active";
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm5: pwm@ffa98010 {
+			compatible = "rockchip,rk3528-pwm", "rockchip,rk3328-pwm";
+			reg = <0x0 0xffa98010 0x0 0x10>;
+			clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
+			clock-names = "pwm", "pclk";
+			pinctrl-0 = <&pwm5m0_pins>;
+			pinctrl-names = "active";
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm6: pwm@ffa98020 {
+			compatible = "rockchip,rk3528-pwm", "rockchip,rk3328-pwm";
+			reg = <0x0 0xffa98020 0x0 0x10>;
+			clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
+			clock-names = "pwm", "pclk";
+			pinctrl-0 = <&pwm6m0_pins>;
+			pinctrl-names = "active";
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm7: pwm@ffa98030 {
+			compatible = "rockchip,rk3528-pwm", "rockchip,rk3328-pwm";
+			reg = <0x0 0xffa98030 0x0 0x10>;
+			clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
+			clock-names = "pwm", "pclk";
+			pinctrl-0 = <&pwm7m0_pins>;
+			pinctrl-names = "active";
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		pinctrl: pinctrl {
 			compatible = "rockchip,rk3528-pinctrl";
 			rockchip,grf = <&ioc_grf>;
-- 
2.25.1


