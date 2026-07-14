Return-Path: <linux-pwm+bounces-9722-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +1rbJYSVVmrx+AAAu9opvQ
	(envelope-from <linux-pwm+bounces-9722-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 22:01:08 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BBB7588D6
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 22:01:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TOKbhNSm;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9722-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9722-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EAE0313AE9B
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 19:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDB6433029;
	Tue, 14 Jul 2026 19:50:53 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F573ED5C9;
	Tue, 14 Jul 2026 19:50:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784058653; cv=none; b=F/lx1X6T8WHHFRkF8T0dIycq30Wph2LpdM5W0Y3E7nTbpS2cyIh1Yr9zZk6QanIbfnxSsPDf6cn3h5eNsa4edNFVPJAMdEsRwepPndVa7zy8brQMGDCn4AuzIRnAhzN2IQt4vDrqWsTerJMNCC/DcV4ZvwqjB45PvxTF6jgPwIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784058653; c=relaxed/simple;
	bh=Xd6HvhT7dw6Wgmk94tnTYJUmFvZeh8MhbSfiMJLGYks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lt9tFHpK3L0ggUu/QPBV6K3b7B36xX1JcQji2JgYquBKgQKLa1tda8GDkL86Mm2ga+oHEWWanCXzYj7u2b6u3xXNDY/ov8ABj0H7nhwVJZqQLOGPWXgy4I3XOlFmrWyppf16rX4KxfTf8mmYgf/DusuPYKceys1vtZ32De43Bd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOKbhNSm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11941F00A3A;
	Tue, 14 Jul 2026 19:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784058651;
	bh=cMuxhfaknBq5QjhLYVGrFXr0U+Y0NiHMcVJiOgD3Vkw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TOKbhNSmby1ttQf6TaPpN5uWolvANg04bDbsf/ppCud8DtfTX/2x+jayxhmL8GHOF
	 mEOueQIWBC8dkXo9sBmFZGphDd5Hzko6mOov+uPOUh4GCML09iX2QtubjbAjeQDrzE
	 +qKPOgBGibQuLc5MKjnpDYOAshWSqTtL7NpgX9nbT7YL77TLpb9lIwaq2Er66m5ti4
	 TsqPv9j/MFs3aylUX1baQ+wQCmsuhyT+e7vpL31zuenbqSlHqwEOLmPPHXs0Yc7vId
	 770PdPa/vdKgc3ewCTbTWtpkW6jrOgnmsQbWYO1WPBmB3G2K2s/59ilmFsNiNT+7SC
	 qXwc4A2YzJDpg==
Message-ID: <cd9da9aa-6e91-4534-a86c-a4421aafbd38@kernel.org>
Date: Tue, 14 Jul 2026 21:50:45 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] dt-bindings: arm: apple: Add M4 based devices
To: Yureka Lilian <yureka@cyberchaos.dev>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
 Thomas Gleixner <tglx@kernel.org>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>,
 Hector Martin <marcan@marcan.st>, Linus Walleij <linusw@kernel.org>,
 Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Sasha Finkelstein <k@chaosmail.tech>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20260705-apple-m4-initial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev>
 <20260705-apple-m4-initial-devicetrees-v1-9-e5655ee56523@cyberchaos.dev>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20260705-apple-m4-initial-devicetrees-v1-9-e5655ee56523@cyberchaos.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9722-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yureka@cyberchaos.dev,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:lpieralisi@kernel.org,m:j@jannau.net,m:neal@gompa.dev,m:tglx@kernel.org,m:wim@linux-watchdog.org,m:linux@roeck-us.net,m:marcan@marcan.st,m:linusw@kernel.org,m:kettenis@openbsd.org,m:andi.shyti@kernel.org,m:ukleinek@kernel.org,m:k@chaosmail.tech,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-watchdog@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cyberchaos.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E5BBB7588D6



On 7/5/26 15:17, Yureka Lilian wrote:
> The Apple devices with the t8132 SoC (M4) are very similar to their M3
> predecessors.
>
> In addition to the MacBook Pro and the various MacBook Air and iMac
> variants, a Mac mini is offered again with the M4.
>
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>   Documentation/devicetree/bindings/arm/apple.yaml | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
> index e49403c73f9d..3262292252d2 100644
> --- a/Documentation/devicetree/bindings/arm/apple.yaml
> +++ b/Documentation/devicetree/bindings/arm/apple.yaml
> @@ -315,6 +315,18 @@ properties:
>             - const: apple,t8122
>             - const: apple,arm-platform

Please also add M4 to the top of the binding in the description.
>   
> +      - description: Apple M4 SoC based platforms
> +        items:
> +          - enum:
> +              - apple,j604  # MacBook Pro (14-inch, M4, 2024)
> +              - apple,j623  # iMac (24-inch, 2x USB-C, M4, 2024)
> +              - apple,j624  # iMac (24-inch, 4x USB-C, M4, 2024)
> +              - apple,j713  # MacBook Air (13-inch, M3, 2025)
> +              - apple,j715  # MacBook Air (15-inch, M3, 2025)
Copy/paste errors: these two should be M4 as well and I think the ones 
at the top should be 2025 instead of 2024, shouldn't they?


Best,

Sven

