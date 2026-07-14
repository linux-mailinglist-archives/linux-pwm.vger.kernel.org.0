Return-Path: <linux-pwm+bounces-9721-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8QpvLLCSVmoP9wAAu9opvQ
	(envelope-from <linux-pwm+bounces-9721-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 21:49:04 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B69758763
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 21:49:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hJjbRkjo;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9721-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9721-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75B163002F77
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 19:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F77A43552A;
	Tue, 14 Jul 2026 19:48:10 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159FC433047;
	Tue, 14 Jul 2026 19:48:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784058489; cv=none; b=kynygfMhhQd3WfJfzl5e8SoAbv5R55v1aby+WYd0eo4WutPOIta68rzKzDe6K70CkI8UNOdy1IGLtZAPD6lt9wCHFfcguE7soNOkg5WJqkXaULdXTJMBOcnJHycxcm9oB29wkkWxapdkCWjeteoPmC0Lr/tpPU76Nuo6Ir9LUL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784058489; c=relaxed/simple;
	bh=B/L/X9V9PjtyIkDoHFL2DD8jdxZBz4bQhuxjlzo8bYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rmHfFip1KZ0MS6/52yRV6KASDPEaPLdQNYotWUEHwncfOHAB2oZB9BwstYWbmE0jnye6mjklkNjWo7YWXfjBnhRmmeYDLZqAizX4KRNHG9f6uelnrJa/icigTLBZ0kWMIZoVYU5C5nOF3jmiwLH/9UktkRXpzsvelmGCnAJ0eMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJjbRkjo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CA91F000E9;
	Tue, 14 Jul 2026 19:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784058486;
	bh=oUqzUmCd5C8LaJR7q3XMrWlHVSAMJDyXvnpn53blVaI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hJjbRkjodStNV3aFkSroSh3RyI1uRsygLQn7A7gDs39Y2nFzt9uMuVciIxK1tCwid
	 66Zsi7OXdiuAxDKyEIZCZr3Y9I8GCiLF/6JSPmQZtGTO8IhFtkj+duE81iHc26IQn2
	 sGcHzOYVs7sqGGWXhxqTLkkpdp94MM5U3iMnjO88g90e1AK0JU0DxA1vT9yJ/oIBbD
	 K6F0yyuRNESCDE6QhmYjyn5BKZVDrwP3/e/WhQLW4pw6uiJDgBOq28fGTs/p01Oh+b
	 Hyzzf9nPwI6aCkawKUD5Q+mQgyttB7YY8h5gKwGVoQ4zWjrPBvu3GeScAb0VXeMkTr
	 MNslCVmGm6Uqg==
Message-ID: <6c3a01f7-957d-4dc4-a892-3af2826928af@kernel.org>
Date: Tue, 14 Jul 2026 21:47:59 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] arm64: dts: apple: Add minimal t8132 (M4) device
 trees
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Hector Martin <marcan@marcan.st>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Neal Gompa <neal@gompa.dev>, Janne Grunau <j@jannau.net>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Guenter Roeck
 <linux@roeck-us.net>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Linus Walleij <linusw@kernel.org>, Sasha Finkelstein <k@chaosmail.tech>,
 linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
 Thomas Gleixner <tglx@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-pwm@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>,
 Mark Kettenis <kettenis@openbsd.org>
References: <20260705-apple-m4-initial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev>
 <20260705-apple-m4-initial-devicetrees-v1-10-e5655ee56523@cyberchaos.dev>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20260705-apple-m4-initial-devicetrees-v1-10-e5655ee56523@cyberchaos.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9721-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:yureka@cyberchaos.dev,m:marcan@marcan.st,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-watchdog@vger.kernel.org,m:krzk+dt@kernel.org,m:robh@kernel.org,m:ukleinek@kernel.org,m:neal@gompa.dev,m:j@jannau.net,m:lpieralisi@kernel.org,m:linux@roeck-us.net,m:wim@linux-watchdog.org,m:linusw@kernel.org,m:k@chaosmail.tech,m:linux-gpio@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:tglx@kernel.org,m:conor+dt@kernel.org,m:linux-pwm@vger.kernel.org,m:andi.shyti@kernel.org,m:kettenis@openbsd.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sven@kernel.org,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6B69758763



On 7/5/26 15:17, Yureka Lilian wrote:
> Added device trees for the following devices:
> - apple,j604 - MacBook Pro (14-inch, M4, 2024)
> - apple,j623 - iMac (24-inch, 2x USB-C, M4, 2024)
> - apple,j624 - iMac (24-inch, 4x USB-C, M4, 2024)
> - apple,j713 - MacBook Air (13-inch, M4, 2025)
> - apple,j715 - MacBook Air (15-inch, M4, 2025)
> - apple,j773g - Mac mini (M4, 2024)
>
> The device trees have a minimal set of devices limited to CPU cores,
> interrupt controller, power states, watchdog, serial, pin controller,
> i2c and framebuffer.
> The device trees for the notebooks add a PWM controller for the keyboard
> LED illumination.
>
> Using the macOS 26.6b3 iBoot/firmware, the Mac mini reliably boots on a
> single core using the stock kernel.
> Booting with smp requires avoiding the wfi and wfit instructions
> in the idle loop and `delay()` respectively, since those instructions
> cause a loss of architectural state on the secondary cores, and even
> then boot is unreliable.
>
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>   arch/arm64/boot/dts/apple/Makefile        |    6 +
>   arch/arm64/boot/dts/apple/t8132-j604.dts  |   35 +
>   arch/arm64/boot/dts/apple/t8132-j623.dts  |   18 +
>   arch/arm64/boot/dts/apple/t8132-j624.dts  |   18 +
>   arch/arm64/boot/dts/apple/t8132-j713.dts  |   35 +
>   arch/arm64/boot/dts/apple/t8132-j715.dts  |   35 +
>   arch/arm64/boot/dts/apple/t8132-j773g.dts |   25 +
>   arch/arm64/boot/dts/apple/t8132-jxxx.dtsi |   48 ++
>   arch/arm64/boot/dts/apple/t8132-pmgr.dtsi | 1125 +++++++++++++++++++++++++++++
>   arch/arm64/boot/dts/apple/t8132.dtsi      |  440 +++++++++++
>   10 files changed, 1785 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
> index 6fc3349a5842..181bd0e28965 100644
> --- a/arch/arm64/boot/dts/apple/Makefile
> +++ b/arch/arm64/boot/dts/apple/Makefile
> @@ -1,4 +1,10 @@
>   # SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_APPLE) += t8132-j604.dtb
> +dtb-$(CONFIG_ARCH_APPLE) += t8132-j623.dtb
> +dtb-$(CONFIG_ARCH_APPLE) += t8132-j624.dtb
> +dtb-$(CONFIG_ARCH_APPLE) += t8132-j713.dtb
> +dtb-$(CONFIG_ARCH_APPLE) += t8132-j715.dtb
> +dtb-$(CONFIG_ARCH_APPLE) += t8132-j773g.dtb
Please put these at the correct position in the Makefile and not at the 
very top.

>   dtb-$(CONFIG_ARCH_APPLE) += s5l8960x-j71.dtb
>   dtb-$(CONFIG_ARCH_APPLE) += s5l8960x-j73.dtb
>   dtb-$(CONFIG_ARCH_APPLE) += s5l8960x-j85m.dtb
> diff --git a/arch/arm64/boot/dts/apple/t8132-j604.dts b/arch/arm64/boot/dts/apple/t8132-j604.dts
> new file mode 100644
> index 000000000000..c4be915cb33a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t8132-j604.dts
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Apple MacBook Pro (14-inch, M4, 2024)
> + *
> + * target-type: J604
> + *

[...]

> +
> +		pmgr: power-management@380700000 {
> +			compatible = "apple,t8132-pmgr", "apple,t8103-pmgr", "syscon", "simple-mfd";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0x3 0x80700000 0 0x14000>;
> +			/* child nodes are added in t8132-pmgr.dtsi */
> +		};
> +
> +		aic: interrupt-controller@381180000 {
> +			compatible = "apple,t8132-aic3", "apple,t8122-aic3";
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			reg = <0x00000003 0x81000000 0x00000000 0x1cc000>,

You have 381180000 in the node name but 381000000 here, I guess the node 
name is a copy paste error. W=1 flags this fwiw.


Sven


