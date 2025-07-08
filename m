Return-Path: <linux-pwm+bounces-6769-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED39AFCDC1
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 16:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279B217B4D4
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 14:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F1E1FCFF1;
	Tue,  8 Jul 2025 14:34:16 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F039F21B184;
	Tue,  8 Jul 2025 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985256; cv=none; b=bQk+8V1cAjppOm5I/HvHAa1Iq8TCZqtLpJnZaaFjuZzFamCKO9kVVxKsJo+jmEsuBFgCxSW1qO8vxbovugri/yJuccWOCaG1o5qau278tKl67LA0sn7wmB4s46FgCTHJoBXTsVhJ16UUv77GtOMYFxTgEuom4fffJtUGS+opAHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985256; c=relaxed/simple;
	bh=OP8Xe7kdCGxwZTk0/Uhbn9t7nQoxeuX/Abg2txz/bH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1qKvGFaeZI5cD3e9GtStlUzmu3usMO8shU+jyU++4VqA13OqAIAHbFc12jj4RJGU5kbgYlt+weBATevjBm90/OtPfUhbvli8w218nHc7myOsXYFgjsUUAbibFDnKVLMSJqJ+T0R93uODI/7Vt4Y4qH0SdblHYSxphW1Gpd/r0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from ofsar (unknown [116.232.48.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 3A6FC340FFC;
	Tue, 08 Jul 2025 14:34:03 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	drew@pdp7.com,
	inochiama@gmail.com,
	geert+renesas@glider.be,
	heylenay@4d2.org,
	tglx@linutronix.de,
	hal.feng@starfivetech.com,
	unicorn_wang@outlook.com,
	duje.mihanovic@skole.hr,
	heikki.krogerus@linux.intel.com,
	Guodong Xu <guodong@riscstar.com>
Cc: Yixun Lan <dlan@gentoo.org>,
	elder@riscstar.com,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Subject: Re: (subset) [PATCH v3 0/6] pwm: Update PWM_PXA driver for SpacemiT K1
Date: Tue,  8 Jul 2025 22:33:55 +0800
Message-ID: <175198458423.86859.5882458274157023095.b4-ty@gentoo.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250429085048.1310409-1-guodong@riscstar.com>
References: <20250429085048.1310409-1-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 29 Apr 2025 16:50:42 +0800, Guodong Xu wrote:
> This patchset adds support for the SpacemiT K1 SoC in the PWM_PXA driver
> and updates related device tree bindings. The changes enable PWM
> functionality on the K1 platform through driver enhancements,
> configuration updates, and device tree additions.
> 
> Functionality has been verified on the Banana Pi BPI-F3 board using PWM14,
> configured as a pwm-backlight. Per community feedback, the actual
> pwm-backlight node is not included in this patchset but can be found in
> patch 7 of the v1 series, with modification of pwms property to 4-cell
> format to match updated binding (#pwm-cells = <3>) since v3.
> 
> [...]

Applied, thanks!

[3/6] riscv: dts: spacemit: add PWM support for K1 SoC
      https://github.com/spacemit-com/linux/commit/9aebdfc21f755e0d2766683aa251435fb656ea47
[4/6] riscv: dts: spacemit: add pwm14_1 pinctrl setting
      https://github.com/spacemit-com/linux/commit/8709d51024068d4c81dc785d63169d283d147cf3

Best regards,
-- 
Yixun Lan


