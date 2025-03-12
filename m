Return-Path: <linux-pwm+bounces-5137-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF62A5DF10
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Mar 2025 15:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5A3F189F033
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Mar 2025 14:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D5F23E345;
	Wed, 12 Mar 2025 14:35:35 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986B61CF8B;
	Wed, 12 Mar 2025 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790135; cv=none; b=ZDH123bkEBicYZ9EMnOLghODLI2C9l4Kcw24h1q5my7iIkHZ8XZS7apFa5LCMIUF3cJHKEmifUhjQ49F+QfOOQ7I6cgvzjOO1dJNoCHklaxv8GBWNZF3QTQhnUxeuYVodMb/14/gvHKk4aisawdH95e+5oy0g5qRyiESoVrWjGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790135; c=relaxed/simple;
	bh=RWbG931LWc2SlSpfOK8RCgqBk2r4EvYGccw325dvqx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mlcMFgoowvaR6IG//yDpgQDpRChD7l+GFA520lo91hWbcT6E3v0LLSCugI3wHPsXTdGBHftaOsSpZxlu/i4ykeDcxbCs+HG1Py2pXT4eLG/gDYP+P4FhRe6g31tui6FGMfjwZArQ2f+lbWXlpkorHPmtWAVIYkzE+XFxDcWR/T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.215.89])
	by smtp.qiye.163.com (Hmail) with ESMTP id e0ccc294;
	Wed, 12 Mar 2025 22:35:20 +0800 (GMT+08:00)
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
Date: Wed, 12 Mar 2025 22:35:15 +0800
Message-Id: <20250312143515.1225171-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a5ec9062-ca57-4748-8c0f-fb5b9c75fa28@kwiboo.se>
References: <a5ec9062-ca57-4748-8c0f-fb5b9c75fa28@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQ0lKVh1LTRpCTU5OSEkeTlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKTlVDQllXWRYaDxIVHRRZQVlPS0hVSktJT09PS1VKS0tVS1
	kG
X-HM-Tid: 0a958ac80af803a2kunme0ccc294
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MSI6Vio5EzIDMhwtHU0cTTcD
	HkkaCzdVSlVKTE9KTEJLSklKTk9OVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpOVUNCWVdZCAFZQUNPTjcG

Hi,

> The pinctrl-names should be changed to "default" and not "active",
> something you can fixup or do you want a patch?

Sorry I've been a bit busy this week and forgot to send the v2 patch.
In rk3528.dtsi, the uart and upcoming i2c nodes do not have pinctrl,
so I prefer to remove them.

>> Unlike other SoCs, pinctrl-names need to be in "active" state,
>> I'm not sure about this, but otherwise the pwm-regulator will
>> not work properly.

BTW, setting the pinctrl of pwm corresponding to pwm-regulator
to "default" will cause kernel boot suspended.
Sorry but do you know why?

e.g.
```
vdd_arm: regulator-vdd-arm {
	compatible = "pwm-regulator";
	pwms = <&pwm1 0 5000 1>;
	...
};

&pwm1 {
	pinctrl-0 = <&pwm1m0_pins>;
	pinctrl-names = "default";
	status = "okay";
};
```

Thanks,
Chukun

--
2.25.1


