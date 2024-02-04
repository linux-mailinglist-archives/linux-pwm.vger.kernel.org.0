Return-Path: <linux-pwm+bounces-1193-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5327A848D3A
	for <lists+linux-pwm@lfdr.de>; Sun,  4 Feb 2024 12:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98E52B20E67
	for <lists+linux-pwm@lfdr.de>; Sun,  4 Feb 2024 11:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408AE22085;
	Sun,  4 Feb 2024 11:49:55 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F19219FF;
	Sun,  4 Feb 2024 11:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707047395; cv=none; b=S4M7rmFWwV1UJB7ErnnNBoCRrKyyLxuzCoxV1kTJxkoMzW2RQ/arKznXS+Pf9flSg9I8mebjm3qgB6o+HzS0LPAPVICuaqOraB58u76STsthNcpzu3zA9AfPmDv0iTgfz2eQo+HSIZabyG+Wo2u9JOD70CMPYTPS8VyjWEq4mvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707047395; c=relaxed/simple;
	bh=vEE7Ab99Zk7NDxu4UXzR/KXDRTMnKym+OK+9C9h/mZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=So5RkGDXJ3W84PFRhIWlCrSvJyM761fIME2VNd7Jxtdzghj0OWavPVr1NHBxW//cyCRfi87Bh11cJEVQDW11mTd3Yo78KcuuORr5OtGfpJkT5mUO0XZHg7l7LoQbeSg5Z7B87dfj5o1+pXm2t7oT2oCl/MKT8wcS7PAI9J2DDlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [185.175.219.2] (helo=phil.fosdem.net)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rWaUq-00051V-So; Sun, 04 Feb 2024 12:17:12 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh+dt@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pwm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: rockchip: Drop interrupts property from pwm-rockchip nodes
Date: Sun,  4 Feb 2024 12:17:09 +0100
Message-Id: <170704542195.2517832.659994399742833718.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240129113205.2453029-2-u.kleine-koenig@pengutronix.de>
References: <20240129113205.2453029-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 29 Jan 2024 12:32:02 +0100, Uwe Kleine-König wrote:
> The binding doesn't define interrupts and adding such a definition was
> refused because it's unclear how they should ever be used and the
> relevant registers are outside the PWM range. So drop them fixing
> several dtbs_check warnings like:
> 
> 	arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dtb: pwm@10280030: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/pwm/pwm-rockchip.yaml#
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: rockchip: Drop interrupts property from pwm-rockchip nodes
      commit: f98643d8daf3443e3b414a82d0cb3d745f8c8bbc

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

