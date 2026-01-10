Return-Path: <linux-pwm+bounces-7888-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C34D0CC12
	for <lists+linux-pwm@lfdr.de>; Sat, 10 Jan 2026 02:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B031D303398B
	for <lists+linux-pwm@lfdr.de>; Sat, 10 Jan 2026 01:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A551D23EA8D;
	Sat, 10 Jan 2026 01:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="CIrNkb3E";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="cEhXN1QI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561A919067C;
	Sat, 10 Jan 2026 01:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768009546; cv=none; b=EdapzjP+oJyzB4Vd8V+gKXu94VM+vGU1uSiQXWDUT17z+d1GiLPz+lfDm9ucaHVo/cEZyjPx+czsHox6xvmveGwnZkyErRB+zhdLiqsyDgi6cgnhH3yOBVTXmBtxt3K0iPjedFmbBW2U1VRaVU5YBNfBs8pK9yYnIwExlYCma3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768009546; c=relaxed/simple;
	bh=9JX/rXLHGcrTabMUzfusMQsBUjz6LX2b1LPrfc/bGPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIIh1JzGSACUlLcn6qfAbXwfWZW6HnbtQdDbtpalOCv03m+25jbmSDILHOW4Fb7e6GYl6yhGV9htd18dP4xFiK2QK7y7CFtE3RdVpfDzIqBp5InPB5Pvnf7Ci4h098hMRNrqPvZAMecyRufkBfcHZR89oLYaEc30O9jdOAXDzHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=CIrNkb3E; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=cEhXN1QI; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1768009544; bh=9JX/rXLHGcrTabMUzfusMQsBUjz6LX2b1LPrfc/bGPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CIrNkb3EHQdgUqjfOTaQQznA9mIA5U/V9U7ab98icQJRLuVRZs5KhlSJ+bGnWmpXP
	 QiKgSMMS4BYzhx/ipuhyRPiIyB8pkgnXS42JMg6WInsN9u+YktbUg0iutMVQ4XeBmn
	 0vaZf03zPz84BoP9rzmLUmd8bxS9C1HmBGYnk2sAJCqXQna0nHYpU+RCK7ka+v5OE2
	 b48Uag5ESCAhwIzbHxZUx2HyGof0dUHQtGl3kSuv3BbzHnpH9t1TWhStW0y2Bmok93
	 ZVZBfTd8t9+MHx4yKWa/5HgRsGkRluAuoQmnPWMCvrcjmRBA3J29L1P8rHB04p60J0
	 xnBttruyHPPGw==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 0D40C3EB80E;
	Sat, 10 Jan 2026 01:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1768009543; bh=9JX/rXLHGcrTabMUzfusMQsBUjz6LX2b1LPrfc/bGPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cEhXN1QIZgsmjPONfJwPPcPwCctX5FxXGpz2NRr+hYCccjhYlegywl6dxSmMeP1ew
	 khhGImm2huMxuQ89q8YbbW8MOygV2WRjMup+NPh+gXxt74R5zpZ7VJBTA4WSGBzQvD
	 Lby2RBAUJNtIMieqrgVdEWG8AwcfOOC6b0DG1VQpXPeLWzMUEsKIHk87XDkz34bnee
	 Bg59pLusbLj7MB1GqZDTrKGeJ3VIM/k4dwls302nkGw+bn3Vg5WIzr/ST5nNinTkFV
	 b7JaChrdgbtMUkOU2E7OHtgoofRU0G1R3aZvCjI2lYBwFLDHORxKwsqYt7RdIM5OVQ
	 ZDyrNm92BzANA==
Received: from mail.mleia.com (91-159-24-186.elisa-laajakaista.fi [91.159.24.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id 5F3473EB810;
	Sat, 10 Jan 2026 01:45:43 +0000 (UTC)
From: Vladimir Zapolskiy <vz@mleia.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] arm: dts: lpc32xx: add interrupts property to Motor Control PWM
Date: Sat, 10 Jan 2026 03:45:24 +0200
Message-ID: <20260110014524.3379187-3-vz@mleia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260110014524.3379187-1-vz@mleia.com>
References: <20260110014524.3379187-1-vz@mleia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20260110_014544_070900_8715560B 
X-CRM114-Status: UNSURE (   9.46  )
X-CRM114-Notice: Please train this message. 

Motor Control PWM shares an interrupt line with TIMER4 on MIC interrupt
controller, the interrupt serves as period (timer limit), pulse-width (match)
and capture event interrupt.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi b/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
index 7fa91d1ac9ea..e94df78def18 100644
--- a/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
@@ -322,6 +322,7 @@ i2c2: i2c@400a8000 {
 			mpwm: pwm@400e8000 {
 				compatible = "nxp,lpc3220-motor-pwm";
 				reg = <0x400e8000 0x78>;
+				interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
 				clocks = <&clk LPC32XX_CLK_MCPWM>;
 				#pwm-cells = <3>;
 				status = "disabled";
-- 
2.43.0


