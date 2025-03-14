Return-Path: <linux-pwm+bounces-5191-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E83E4A6152B
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Mar 2025 16:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333361768F7
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Mar 2025 15:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0BD1EF0B4;
	Fri, 14 Mar 2025 15:40:22 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDE0202973;
	Fri, 14 Mar 2025 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741966822; cv=none; b=hiSMkZuKizqllak9j/zQRrnwKu21PBc2K/jWxocMyLynbKIzqMFicbLUCDsDUw/tebuuGK2XDy+uWMpaBprbeoYbUqD02ZNv86L2mYpmv9abeMKqFXn0q1UkDuh+8PKHldujip6tZROA73vstqK6AcCk8RbsvcqGliRfL7Tgm3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741966822; c=relaxed/simple;
	bh=BfD28oiCDQzTZE7U5FI8BJ9IuhnfTvjWAGaG732Cg5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EFPeVqTy+BxGyhiSnHYhBVvghqVm1TygotedgvjLN/xWsVACNhhE5sSqKQuTRbLLqTskU5lAQe9BZpe+tiKheo3ZfcSehEiUspP9S581EKVatfDXjDmNDykP08DrSqCc9Ftabvtey+LCUrVLnfzXi7q+V9K546PCCBdR6OfRn48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.215.89])
	by smtp.qiye.163.com (Hmail) with ESMTP id e524c720;
	Fri, 14 Mar 2025 23:40:07 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: jonas@kwiboo.se
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	ziyao@disroot.org,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 0/2] arm64: dts: rockchip: Add pwm nodes for RK3528
Date: Fri, 14 Mar 2025 23:40:02 +0800
Message-Id: <20250314154002.1844394-1-amadeus@jmu.edu.cn>
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
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQk5IVh5OHksZSkJOHx0YHVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKTlVDQllXWRYaDxIVHRRZQVlPS0hVSktISk5MTlVKS0tVSk
	JLS1kG
X-HM-Tid: 0a959550128103a2kunme524c720
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PxA6Pgw6CDJRDAo9NwgIUQw1
	Nw0KFE5VSlVKTE9KQk1NQ0tDT0hIVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpOVUNCWVdZCAFZQUpPQ0M3Bg++

Hi,

> Interesting, good that it works with the updated U-Boot. Main change
> compared to v1 is that it now use clock/reset id and DT closer to what
> has been merged in mainline Linux. It also has DT params to help
> initialize the two pwm regulators used by these boards.
>
> I will try with the old v1 U-Boot series and see if I can replicated
> your issue.

Hi, I found the reason. I did some experiments today:

pwm-regulator  pwm1 | pwm2 | pwm3
-----------------------------------
ArmSoM Sige1 |      | work | work |
Radxa E20C   | work | hang |      |
other 3528   | work | hang |      |

This looks weird, so I tested it further:

In the new series of u-boot:
```
--- a/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
+++ b/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
@@ -8,9 +8,9 @@
 };
 
 &vdd_arm {
-	regulator-init-microvolt = <953000>;
+	status = "disabled"; # Cancel changes, pwm works
 };
 
 &vdd_logic {
-	regulator-init-microvolt = <900000>;
+	status = "disabled"; # Cancel changes, kernel hang
 };
```

I looked at schematic and found an interesting thing:
1. ArmSoM Sige1 schematic: VDD_LOGIC Default 0.901V
2. Radxa E20C schematic: VDD_LOGIC No default voltage

Therefore, the default voltage of VDD_LOGIC (supply to
GPU and LOGIC) needs to be set to 0.9V when initializing.

This can be done by hardware or software (such as u-boot)
Should we support this in the kernel driver of regulator?

Thanks,
Chukun

--
2.25.1


