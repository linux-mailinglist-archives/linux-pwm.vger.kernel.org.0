Return-Path: <linux-pwm+bounces-5150-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA54A5F516
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 14:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8B03BF59A
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 13:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E52E2676C0;
	Thu, 13 Mar 2025 13:01:38 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB212661BE;
	Thu, 13 Mar 2025 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741870898; cv=none; b=IXT0WBkw2WiKBevdTrmS8gpOEc7+9mbMtIzcwdxs6KZKh1hMWWyG16I1b1RsaFwOlBpoUqyrcv/U5e5+lF/NkW1uEGqVXPebSyXFA/qWf3eWWUfPZojtpwFUQU5HkWFO6EVgor0nGW41OMhuhAPCvxCuGesjP90yxZL/TlHoWD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741870898; c=relaxed/simple;
	bh=SX7pBKY0ZRRjvwuaSY3uDv5mmBx+HWJ12bqJ47Nbliw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L0ZwpG0L8+g7nig1YdRT3MNUAbih1G6p12X17xreryxE6xcqRgN9jPNPp2roi+RjpgvI9ICvvFOPImrQcXmdPZWWFUhHFrL0u2cX86IF3su9QldaSPr4KkBDpv6FysMquLtDdO/enh7r8RPoDgobr34kJZ5otQxOBJ2SIv+QiQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.215.89])
	by smtp.qiye.163.com (Hmail) with ESMTP id e2d5d956;
	Thu, 13 Mar 2025 21:01:22 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: jonas@kwiboo.se
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 0/2] arm64: dts: rockchip: Add pwm nodes for RK3528
Date: Thu, 13 Mar 2025 21:01:18 +0800
Message-Id: <20250313130118.2772992-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <22d849c3-8a0d-4704-b69c-8019c7f70ca7@kwiboo.se>
References: <22d849c3-8a0d-4704-b69c-8019c7f70ca7@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSU9PVk8ZTUtCSE5KGh5DTVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKTlVDQllXWRYaDxIVHRRZQVlPS0hVSktISk5MTlVKS0tVSk
	JLS1kG
X-HM-Tid: 0a958f985e7603a2kunme2d5d956
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PT46Mzo6MzJWCBc*SBFKCz4W
	HyFPCjdVSlVKTE9KQ0xLQ0NISkxKVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpOVUNCWVdZCAFZQUlIS0M3Bg++

Hi,

> Interesting, good that it works with the updated U-Boot. Main change
> compared to v1 is that it now use clock/reset id and DT closer to what
> has been merged in mainline Linux. It also has DT params to help
> initialize the two pwm regulators used by these boards.
>
> I will try with the old v1 U-Boot series and see if I can replicated
> your issue.

It is easy to reproduce this issue.
Make the following changes in the new series of u-boot:

```
--- a/configs/radxa-e20c-rk3528_defconfig
+++ b/configs/radxa-e20c-rk3528_defconfig
@@ -47,9 +47,7 @@ CONFIG_DM_MDIO=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
-CONFIG_REGULATOR_PWM=y
 CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_PWM_ROCKCHIP=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
```

Or change dts:
```
--- a/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
+++ b/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
@@ -8,9 +8,9 @@
 };
 
 &vdd_arm {
-	regulator-init-microvolt = <953000>;
+	status = "disabled";
 };
 
 &vdd_logic {
-	regulator-init-microvolt = <900000>;
+	status = "disabled";
 };
```

Then the kernel will hang when loading the gpio driver:

[    0.162618] gpio gpiochip2: Static allocation of GPIO bae is deprecated, use dynamic allocation.
[    0.163558] rockchip-gpio ffb00000.gpio: probed /soc/pinctrl/gpio@ffb00000
[    0.164322] gpio gpiochip3: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    0.165231] rockchip-gpio ffb10000.gpio: probed /soc/pinctrl/gpio@ffb10000
[    0.165977] gpio gpiochip4: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    0.166886] rockhip-gpio ffb20000.gpio: probed /soc/pinctrl/gpio@ffb20000
[    0.170342] Internal error: Oos - Undefined instruction: 0000000002000000 [#1] SMP

Changing the debug level:
[    0.175260] rockchip-pinctrl soc:pinctrl: setting mux of GPIO4-14 to 0
[    0.175356] rockchip-pinctrl soc:pinctrl: setting mux of GPIO4-20 to 1
[    0.175968] rockchip-pinctrl soc:pinctrl: setting mux of GPIO4-14 to 0
[    0.176849] rockchip-pinctrl soc:pinctrl: setting mux of GPIO4-21 to 1
[    0.178453] rockchip-pinctrl soc:pinctrl: setting mux of GPIO4-13 to 0
(hang)

Thanks,
Chukun

--
2.25.1


