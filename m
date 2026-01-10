Return-Path: <linux-pwm+bounces-7889-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B43B5D0CC18
	for <lists+linux-pwm@lfdr.de>; Sat, 10 Jan 2026 02:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D4FE3039AEE
	for <lists+linux-pwm@lfdr.de>; Sat, 10 Jan 2026 01:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E27F242D7B;
	Sat, 10 Jan 2026 01:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="KG+5i8Dv";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="KG+5i8Dv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7744B72631;
	Sat, 10 Jan 2026 01:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768009547; cv=none; b=n5dGm8RGXjwFvMlEMMUsWZ8TRbL/PwD2ztOVJfUVOaPBuE1MuGeBIKfWv9iQtGl65z0TQri8Zjjb6kGzVR5eogb0Yi1+pqETRq5fUFW8pascUQUMsx9os5zuJqSJXXPOoNjQ/IePcV+5xBGe+zwiS0yMefHnTQjsNkFENcHrWos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768009547; c=relaxed/simple;
	bh=XZ43TJVHj52vY2ZJ+jW/6bC5/GHKfvJv0Ek6S8x41Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZCSnOyph0miYYhVBr03PZjzUCvG8p2fqnC0O7TwQEsApDrzVacuaoUT/d+0WvRgw3ElnzcFbZ8FpYYq8xIH4rm/EEMEzu3X/8WVnUREMGwt3f1zZzKfG2GybyNpTLAkA0PwZdLGiPXx+cQbYMNZORyaf8KF1DKVACQFoc8L+/BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=KG+5i8Dv; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=KG+5i8Dv; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1768009542; bh=XZ43TJVHj52vY2ZJ+jW/6bC5/GHKfvJv0Ek6S8x41Hs=;
	h=From:To:Cc:Subject:Date:From;
	b=KG+5i8DvOQFUBYK2ZSu5mxhzn8EBbRrXFrL8RbxIDvzu6QJP+AM4SJSW8msGw2Fi8
	 vGJ9kAbdW73Po+QImqrLmtK4HNFDXfGkv98co7ejLollLz+okjDXecEy32UVcWZ6bW
	 DGwYXG130pkUSa1Y0sQMz1V5x4lkEfoyG66DUNcI2OJKkY34uWpTb2mnfFM339DyRI
	 tHEX1Ga9gmmAHBPaXg/kwb1Of8ra9bJSyUXWXGXxh/t7xOEmESOap7X8s9b4S7F2rf
	 4GFB2e7amFmRsRQ1ZHRLWMu8cJD9dvBn/Bmy/afspe14GA71Kol+mluaeEcNoNf/l7
	 XzC5OhHJX8azA==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 93BCF3EB7E6;
	Sat, 10 Jan 2026 01:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1768009542; bh=XZ43TJVHj52vY2ZJ+jW/6bC5/GHKfvJv0Ek6S8x41Hs=;
	h=From:To:Cc:Subject:Date:From;
	b=KG+5i8DvOQFUBYK2ZSu5mxhzn8EBbRrXFrL8RbxIDvzu6QJP+AM4SJSW8msGw2Fi8
	 vGJ9kAbdW73Po+QImqrLmtK4HNFDXfGkv98co7ejLollLz+okjDXecEy32UVcWZ6bW
	 DGwYXG130pkUSa1Y0sQMz1V5x4lkEfoyG66DUNcI2OJKkY34uWpTb2mnfFM339DyRI
	 tHEX1Ga9gmmAHBPaXg/kwb1Of8ra9bJSyUXWXGXxh/t7xOEmESOap7X8s9b4S7F2rf
	 4GFB2e7amFmRsRQ1ZHRLWMu8cJD9dvBn/Bmy/afspe14GA71Kol+mluaeEcNoNf/l7
	 XzC5OhHJX8azA==
Received: from mail.mleia.com (91-159-24-186.elisa-laajakaista.fi [91.159.24.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id E53A23EB2D5;
	Sat, 10 Jan 2026 01:45:41 +0000 (UTC)
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
Subject: [PATCH 0/2] arm: dts: lpc32xx: Add Motor Control PWM interrupt
Date: Sat, 10 Jan 2026 03:45:22 +0200
Message-ID: <20260110014524.3379187-1-vz@mleia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20260110_014542_630072_86AC6243 
X-CRM114-Status: UNSURE (   6.36  )
X-CRM114-Notice: Please train this message. 

NXP LPC32xx Motor Control PWM has an interrupt line, which may be used to
report events from programmable counters e.g. timer counter limit (period),
match counter (pulse-width), or from counters on input lines of PWM channels.

The platform dtsi change is based on top of the next one:
* https://lore.kernel.org/linux-pwm/20251228224907.1729627-1-vz@mleia.com/

Vladimir Zapolskiy (2):
  dt-bindings: pwm: nxp,lpc32xx-pwm: Add optional Motor Control PWM interrupt
  arm: dts: lpc32xx: add interrupts property to Motor Control PWM

 .../devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml       | 10 ++++++++++
 arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi                 |  1 +
 2 files changed, 11 insertions(+)

-- 
2.43.0

