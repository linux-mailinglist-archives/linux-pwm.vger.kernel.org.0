Return-Path: <linux-pwm+bounces-7830-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 245A5CE5836
	for <lists+linux-pwm@lfdr.de>; Sun, 28 Dec 2025 23:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6CA483001BC2
	for <lists+linux-pwm@lfdr.de>; Sun, 28 Dec 2025 22:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF1B299AB4;
	Sun, 28 Dec 2025 22:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="bJhgtpgC";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="bJhgtpgC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1B03A1E6F;
	Sun, 28 Dec 2025 22:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766962153; cv=none; b=CQmHR7xrOtfc7U4XWD4CxPVXTtKHjPMGDtQgbeFvuP8Z5fxxqLPRD/WeWd10kszY6gzjKb9qs8GTPWTnM3nrmpmzfJ+LoV5EoHD2PHi3ALgcllhXL28pEwh70dlr46EE7KOWF3me9VL2txubXQdtclsn8xrmailhDFSg1kpsF3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766962153; c=relaxed/simple;
	bh=AcoMQxufLzHPhOigRW/yZ7QR7x45qDKHskRtiKDydsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uY04cX4IkpTAhyROb/wve1FnltoZ+hWz4eg6GNipB99oRTOvqRQenRbRsN/DKzthHI4YU47ulEBVt8xk1Z9tSQbIZgvjnAtJK1b/uOpwziRkTqjT//o36JHP0eybgRUV0gc8H7WPupK8ir0BxLo9mtK6IjwkH1I42qvXYQvW+vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=bJhgtpgC; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=bJhgtpgC; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1766962149; bh=AcoMQxufLzHPhOigRW/yZ7QR7x45qDKHskRtiKDydsY=;
	h=From:To:Cc:Subject:Date:From;
	b=bJhgtpgCmZcC9e7B7Jf7yIAf8t0hQ3MpJF9ltviaa6mIyr5qRAhc6OuTCidMN18bi
	 s1gc0/huaHzqWeUsxRr0itF6MPsfeYXlPma0rfsf2HHGYU++OEWDnzG5T43c1oTbkh
	 Dz22M4h2/SZKkoNBPmGbmwriPzaTQyntWS9lNaBzxrLH0vzeJ+rGt/U9B72oKubLQH
	 5HKKEX7KPlmOETdmbjDK2bVq8GsNnWML6iJL2u63MngA/OGfaD60nRA+GJG3nJ3j1/
	 lU0BuUraxeERLbY9CqkWgxbuf6Jx6XqQGu6X6lV2Ag8cXSIn/2Ix9eyO2R5309A+1D
	 N2DnZ0dEFiPIg==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 9D1AD3E90D7;
	Sun, 28 Dec 2025 22:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1766962149; bh=AcoMQxufLzHPhOigRW/yZ7QR7x45qDKHskRtiKDydsY=;
	h=From:To:Cc:Subject:Date:From;
	b=bJhgtpgCmZcC9e7B7Jf7yIAf8t0hQ3MpJF9ltviaa6mIyr5qRAhc6OuTCidMN18bi
	 s1gc0/huaHzqWeUsxRr0itF6MPsfeYXlPma0rfsf2HHGYU++OEWDnzG5T43c1oTbkh
	 Dz22M4h2/SZKkoNBPmGbmwriPzaTQyntWS9lNaBzxrLH0vzeJ+rGt/U9B72oKubLQH
	 5HKKEX7KPlmOETdmbjDK2bVq8GsNnWML6iJL2u63MngA/OGfaD60nRA+GJG3nJ3j1/
	 lU0BuUraxeERLbY9CqkWgxbuf6Jx6XqQGu6X6lV2Ag8cXSIn/2Ix9eyO2R5309A+1D
	 N2DnZ0dEFiPIg==
Received: from mail.mleia.com (91-159-24-186.elisa-laajakaista.fi [91.159.24.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id EA4213DAF7E;
	Sun, 28 Dec 2025 22:49:08 +0000 (UTC)
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
Subject: [PATCH 0/2] arm: dts: lpc32xx: Set motor control PWM clock as required one
Date: Mon, 29 Dec 2025 00:49:05 +0200
Message-ID: <20251228224907.1729627-1-vz@mleia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20251228_224909_663653_D4A1B68B 
X-CRM114-Status: UNSURE (   6.07  )
X-CRM114-Notice: Please train this message. 

Motor Control PWM depends on its own supply clock, the clock gate control
is present in TIMCLK_CTRL1 register.

Vladimir Zapolskiy (2):
  dt-bindings: pwm: nxp,lpc32xx-pwm: Specify clocks property as mandatory
  arm: dts: lpc32xx: add clocks property to Motor Control PWM device tree node

 Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml | 4 ++++
 arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi                     | 1 +
 2 files changed, 5 insertions(+)

-- 
2.43.0


