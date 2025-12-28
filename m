Return-Path: <linux-pwm+bounces-7832-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B31ECE5851
	for <lists+linux-pwm@lfdr.de>; Sun, 28 Dec 2025 23:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE7E5300F9DB
	for <lists+linux-pwm@lfdr.de>; Sun, 28 Dec 2025 22:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B45729AB11;
	Sun, 28 Dec 2025 22:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="U0PxZWi5";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="MwQ2YRkG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F1323875D;
	Sun, 28 Dec 2025 22:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766962154; cv=none; b=pfKFbFw/KJ0VaFJRELudFdon/1a18ndoScwNUTKUsvQbVyO7xLIk3ou7SYJGv9jT50jfxZohISJiLhIZmW16UOanSNHFXBdt+ga2eotyC2aoK+tlRLD8V5yVBPXPexKKc+hai2yY4K85d3ojK79Bx0rfyU46gDYP4QKJ5kPjQsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766962154; c=relaxed/simple;
	bh=KaCBaMWeVC2ZFchPLeP88CdpHpnT+QxAouK/zyWlpMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzqijaJi1Lj63VrGq3C1Fadkve75xdXwd6TIg8YBjnOh6N4XPcZeGHYj5wmL/pJIWVoEGEVbMqLbR3PMjMitC+EKb8xJ9jG84mb6wC1gJhTtgaGi4MQRWsLAqJYEwT1cVdHpRB38ENL4RJPVjBIBHX0p5K5vPUusgWuBSGdDiA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=U0PxZWi5; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=MwQ2YRkG; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1766962151; bh=KaCBaMWeVC2ZFchPLeP88CdpHpnT+QxAouK/zyWlpMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U0PxZWi5zMD/97c0q/3zpYwkvjxznCn74S0x6+Pdx3vGION33tMjSZDzI5PNGFEpc
	 5Fo/4Fb9o8REG068pCSg1lXqNM8n35iS+A0i5abpIUENWOqQiwPw8jh1Z/9QJk5uWv
	 U09mbtYbW0pfcQxwRimRzCLEUbgEqwb49fdgNb+TI7q7BdLkz+sz5udlWPVXIpXXv6
	 AHgRzoy26KyXJCM2IC/P+jiSXLJz2MRsZ/jQgDjT0mot7Fe3uU+z7TdquWeWSN9kPL
	 KuMnBPf7nSxXYqQWZfgZDoo9NYHA7XKrC06qjU0vqgR5KqaxUpEQ/rxJNOaj0nbB2p
	 yOMhnXcu873OA==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 017EE3E915B;
	Sun, 28 Dec 2025 22:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1766962150; bh=KaCBaMWeVC2ZFchPLeP88CdpHpnT+QxAouK/zyWlpMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MwQ2YRkGBS0egyQ1QHHeFEyKEzZD6BD6A2utaroB20eL+Hn+vnH7Gx1JDQyVXlLt1
	 yTB4DEli3zNn9Z4qhsaw+XNsY5DiXtJ9DpUlaHozMuoS+r0DPJ0POYtCZgsltwiV3n
	 jep5pNrUx0UjAM4C3hpMrAJva9b/UNbLHf/r6ehtLN0be4Bnaak05Ho4WJEoPAmGKb
	 NH1uvFkzkurcRkQnIiZJpyc/XfNk3dhJguSA/dbjRHp5T4e5MJTdV2UtV3sbpopKEc
	 5rPUVPZ43rJ0AvxMSGno+MRABNJq2e4ybhHzrun+h5tmkWh/lY3Aod/4pOwQO4K1va
	 U3pHaDMGS0Ekg==
Received: from mail.mleia.com (91-159-24-186.elisa-laajakaista.fi [91.159.24.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id 52A2D3E915D;
	Sun, 28 Dec 2025 22:49:10 +0000 (UTC)
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
Subject: [PATCH 2/2] arm: dts: lpc32xx: add clocks property to Motor Control PWM device tree node
Date: Mon, 29 Dec 2025 00:49:07 +0200
Message-ID: <20251228224907.1729627-3-vz@mleia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251228224907.1729627-1-vz@mleia.com>
References: <20251228224907.1729627-1-vz@mleia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20251228_224911_029039_DCC7A718 
X-CRM114-Status: GOOD (  10.19  )

Motor Control PWM depends on its own supply clock, the clock gate control
is present in TIMCLK_CTRL1 register.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi b/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
index 39af48470ed5..abd401fda94e 100644
--- a/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
@@ -304,6 +304,7 @@ i2c2: i2c@400a8000 {
 			mpwm: pwm@400e8000 {
 				compatible = "nxp,lpc3220-motor-pwm";
 				reg = <0x400e8000 0x78>;
+				clocks = <&clk LPC32XX_CLK_MCPWM>;
 				#pwm-cells = <3>;
 				status = "disabled";
 			};
-- 
2.43.0


