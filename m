Return-Path: <linux-pwm+bounces-5118-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB2FA56758
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Mar 2025 13:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65D2A165D20
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Mar 2025 12:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B68A218AD3;
	Fri,  7 Mar 2025 12:00:17 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FE32185BB;
	Fri,  7 Mar 2025 12:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741348816; cv=none; b=YeYxLd6fCEaRVFgx3NSjSHhwXkxPHpzDb93A8I5T35CsCpp2YTaQY4jU/caREpBHNBzKUww8ys7r6TFFHkFocm0biTBMQbIF2ysAeH/C7jJhVH6R89fUlfeeXF0psSNYyvjZiDwozpe1yuayAFVOkaY0uzoYxCo1dbcnO1SvFb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741348816; c=relaxed/simple;
	bh=Yl+gnLHKsStNxura2iA2FY94M6LLfEdskCnzr7t6lDA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mRQaI9O1f6Eg4uRf91uPIOGeBrjBeKTRvML22TMMWjQKWyc+wRfcefi57Vb9s21ZDZDoMVX+5GR5QowOM2XW12ff2RktiR02jcKJ10xuG78y/58tuFz3or4pI9XhvPCOFaRTT/ehQMxDOn4UAxztTJeN5ucj3mu0X1RLj1kzSqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [119.122.215.89])
	by smtp.qiye.163.com (Hmail) with ESMTP id d5c9f2d0;
	Fri, 7 Mar 2025 20:00:08 +0800 (GMT+08:00)
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
Subject: [PATCH 0/2] arm64: dts: rockchip: Add pwm nodes for RK3528
Date: Fri,  7 Mar 2025 20:00:02 +0800
Message-Id: <20250307120004.959980-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHh4ZVh5CGUkYGB8eQk0YHlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKTlVDQllXWRYaDxIVHRRZQVlPS0hVSktISk5MTlVKS0tVSk
	JLS1kG
X-HM-Tid: 0a95707a26a903a2kunmd5c9f2d0
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NS46Qxw4QjJJNjU*SjNICEsh
	ISEaC0NVSlVKTE9KSE9DQ0tCSkxDVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpOVUNCWVdZCAFZQUpLTUo3Bg++

Add pwm nodes for RK3528. Most rk3528 boards use pwm-regulator to
supply to CPU, add node to enable them. The PWM core on RK3528 is
the same as RK3328, but the driver doesn't support interrupts yet.

Unlike other SoCs, pinctrl-names need to be in "active" state,
I'm not sure about this, but otherwise the pwm-regulator will
not work properly.

---
vdd_arm: regulator-vdd-arm {
	compatible = "pwm-regulator";
	pwms = <&pwm1 0 5000 1>;
	pwm-supply = <&vcc5v0_sys>;
	regulator-name = "vdd_arm";
	regulator-min-microvolt = <746000>;
	regulator-max-microvolt = <1201000>;
	regulator-always-on;
	regulator-boot-on;
	regulator-settling-time-up-us = <250>;
};

&cpu0 {
	cpu-supply = <&vdd_arm>;
};

&pwm1 {
	status = "okay";
};
---

Chukun Pan (2):
  dt-bindings: pwm: rockchip: Add rockchip,rk3528-pwm
  arm64: dts: rockchip: Add pwm nodes for RK3528

 .../devicetree/bindings/pwm/pwm-rockchip.yaml |  1 +
 arch/arm64/boot/dts/rockchip/rk3528.dtsi      | 88 +++++++++++++++++++
 2 files changed, 89 insertions(+)

-- 
2.25.1


