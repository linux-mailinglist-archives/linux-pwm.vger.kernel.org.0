Return-Path: <linux-pwm+bounces-5147-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441E1A5EEC8
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 10:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84AF07A83FD
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 09:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F9A264F88;
	Thu, 13 Mar 2025 09:01:29 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173662641DE;
	Thu, 13 Mar 2025 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856489; cv=none; b=luzUGXEaXgL3TOf8Z+50F9145mAcID95zUJpPLsLs+V0O3Paz4pS0hVc3JFGVC56qGBNA9+3F+GqQS9KVAwisjk29IUFqUDOKR3G+npo0DFaKcEJuaREwX67C5tCEtsFnRipckqMIgNgZYawhu4VXacTYqeSpBo+SGfWCYL4aUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856489; c=relaxed/simple;
	bh=pzlGOpGQzeCXZtQkQGt/enf4g4Md7xr7WSnEf7vTN7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tjQqZIMZ2S9QivV5SxOqaw+v4cGqAjR5VBXQbHb2H86mxFLR7rKsiBYKlDXurZuiOXaJt2B7O88Fb0kT7B9cwKmBWrc5G3G277Q77Uaeu8vNeajLpaR+q40rcc3Wq76aMRxDucVXUPWZF7wRiTUFKsgB2w35S5hWeBB9MA3+/50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.215.89])
	by smtp.qiye.163.com (Hmail) with ESMTP id e266ff78;
	Thu, 13 Mar 2025 17:01:14 +0800 (GMT+08:00)
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
Date: Thu, 13 Mar 2025 17:01:09 +0800
Message-Id: <20250313090109.1910997-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <60065c0b-4597-4976-b74b-172556c4e156@kwiboo.se>
References: <60065c0b-4597-4976-b74b-172556c4e156@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTElIVktNTkpOTkkfQxhCGlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKTlVDQllXWRYaDxIVHRRZQVlPS0hVSktJQk1KSlVKS0tVS1
	kG
X-HM-Tid: 0a958ebc86e603a2kunme266ff78
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ky46EAw*MjJJNhBKTiwNQw4Q
	TxNPCThVSlVKTE9KQ05NT0xNSUlKVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpOVUNCWVdZCAFZQUpKTUw3Bg++

Hi,

> I have not seen any issue with PWM using the merged patch having
> pinctrl-names=default.
>
> Please see my Linux tree [1] and U-Boot tree [2], those are little ahead
> of what has been posted on ML, e.g. it has working USB2.0 host, CPU opp,
> Hantro VPU, GPU + opp, arm and logic pwm regulators for E20C, ROCK 2A/2F
> and Sige1.
>
> Please see my Linux tree [1] and U-Boot tree [2], those are little ahead
> of what has been posted on ML, e.g. it has working USB2.0 host, CPU opp,
> Hantro VPU, GPU + opp, arm and logic pwm regulators for E20C, ROCK 2A/2F
> and Sige1.
> ...
> [1] https://github.com/Kwiboo/linux-rockchip/commits/next-20250311-rk3528/
> [2] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3528

I tested your kernel device tree on E20C earlier today and still have
the same issue. But if I replace u-boot with the link [2] you provided,
it will work fine. For reference, I was using v2025.01 plus this series
of patches [3]. So it looks like u-boot does something and kernel doesn't?

[3] https://lore.kernel.org/u-boot/20250123224844.3104592-1-jonas@kwiboo.se/

Thanks,
Chukun

--
2.25.1


