Return-Path: <linux-pwm+bounces-9746-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nVKTMn6dV2rLXwAAu9opvQ
	(envelope-from <linux-pwm+bounces-9746-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 16:47:26 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5575375F8A3
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 16:47:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Kp04aKsB;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9746-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9746-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D12E3006788
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 14:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C678639184A;
	Wed, 15 Jul 2026 14:47:23 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F7037C907;
	Wed, 15 Jul 2026 14:47:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126843; cv=none; b=BO1ytVgdDKNhb5+nS4ns+p5WcXf/vjcsPx2uDn/kgaGf3Xd1+t6qB+I5kG2hOi51vf3RFabfEgakZu7AVfG9qH9N+TbSrup3BPN5gJJ4IPcAKBHCJMFE5PcurQwJvpkD+dpWv1DBa9dF51Mk+6qL1KETy08VKYibo3IKD2emJf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126843; c=relaxed/simple;
	bh=xHG4Cgmp0u4sP3xzDzY3WvztI9ASDmdcF3CfBU0mdu0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=H/Wf2Przjdm6gqb4PjNFao/UxwqE4XCwNMp9FAXgpiezUC0hYR7nVcdcpkHkGaZn0nmnIq7vvDriz/VlXUVPNQwVKkpkCzmD0Htd8WWD4OkKNvrtggMYRbtxh/5fXdwuWF1aOMKb44Ts7xIIwdES/+BM0yJOKbpSgKe8fOIJMWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kp04aKsB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9D31F000E9;
	Wed, 15 Jul 2026 14:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784126842;
	bh=4/AlFWwnDA/SV5JENDj0Z4O7qhKDad5syaPLp/K1Aq8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Kp04aKsBor216y3M2IQhJWClxfjKrVp0CdavYdhymjRdXGcmmZCVNHfmmmUijU61h
	 0R406OBsN0NucPYLhUQBScrmhq7/FGcHl64Z+trYg6pXWD0II9VhDj2VCThGtVLVJS
	 wAlueNQBgkYBSUCUjDvewxz81e4UMTuIZuWb255e7oDoAxlt7a1YVqavt4P/wMoMwz
	 kqnmct5VkUpV5EOBxklqwQ131oTjAiveXcuVWDRS1AIMgk7EUytNiClppxdUlL/moG
	 k9RZBfPLeKJsgx4GKgXTPZqY1bFYqW6iBvmYXZffgAegMoFVWTg8IgXZsnVXXTsIC9
	 JYiRAsHC3J1lg==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 09/10] arm64: dts: apple: Initial T603[124] (M3 Max
 and Ultra) device trees
From: Sven Peter <sven@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Andi Shyti <andi.shyti@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Sasha Finkelstein <k@chaosmail.tech>, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org
In-Reply-To: <20260715-apple-t603x-initial-devices-v2-9-df65b2485710@jannau.net>
References: <20260715-apple-t603x-initial-devices-v2-0-df65b2485710@jannau.net>
 <20260715-apple-t603x-initial-devices-v2-9-df65b2485710@jannau.net>
Date: Wed, 15 Jul 2026 16:46:42 +0200
Message-Id: <178412680283.41818.6965684846949512896.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=951; i=sven@kernel.org;
 h=from:subject:message-id; bh=xHG4Cgmp0u4sP3xzDzY3WvztI9ASDmdcF3CfBU0mdu0=;
 b=owGbwMvMwCXmIlirolUq95LxtFoSQ1b43Oj86Yu4eCfMP6ClwXZn39N2zu7eUsOExA6D+QJTr
 Ir7rpR0lLIwiHExyIopsmzfb2/65OEbwaWbLr2HmcPKBDKEgYtTACZiqsfI0MOrkmnX4NJqyyxd
 NUex4Aa3RW3W01WMKfnrbl19du3XCob/+f/ObMyzePIrKaNg14XX0Vv1UrpP9WSd89VPm1exyG4
 mAwA=
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:j@jannau.net,m:sven@kernel.org,m:neal@gompa.dev,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:tglx@kernel.org,m:wim@linux-watchdog.org,m:linux@roeck-us.net,m:andi.shyti@kernel.org,m:ukleinek@kernel.org,m:k@chaosmail.tech,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-watchdog@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[sven@kernel.org,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@kernel.org,linux-pwm@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9746-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,jannau.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5575375F8A3
X-Rspamd-Action: no action

On Wed, 15 Jul 2026 11:11:56 +0200, Janne Grunau <j@jannau.net> wrote:
> diff --git a/arch/arm64/boot/dts/apple/t6031-die0.dtsi b/arch/arm64/boot/dts/apple/t6031-die0.dtsi
> new file mode 100644
> index 000000000000..e02c29e1d9f3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t6031-die0.dtsi
> @@ -0,0 +1,197 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Devices used on die 0 on the Apple T6032 "M3 Ultra" SoC and present on
> + * Apple T6030 ("M3 Pro") and T6031 / T6034 ("M3 Max").
> + *
> + * Copyright The Asahi Linux Contributors
> + */
> +
> +	wdt: watchdog@2a02d4000 {
> +		compatible = "apple,t6031-wdt", "apple,t8103-wdt";
> +		reg = <0x2 0xa02d4000 0x0 0x4000>;
> +		clocks = <&clkref>;
> +		interrupt-parent = <&aic>;
> +		interrupts = <AIC_IRQ 0 718 IRQ_TYPE_LEVEL_HIGH>;
> +	};

wdt belongs below the adt node.

Reviewed-by: Sven Peter <sven@kernel.org>

-- 
Sven Peter <sven@kernel.org>

