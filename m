Return-Path: <linux-pwm+bounces-9657-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YSblGxJQT2rfeAIAu9opvQ
	(envelope-from <linux-pwm+bounces-9657-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 09:38:58 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F138972DD57
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 09:38:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jannau.net header.s=fm3 header.b=EzOVpuKp;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="B SEzcjL";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9657-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9657-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D77103089FC3
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2026 07:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6976E3E95B1;
	Thu,  9 Jul 2026 07:31:26 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94883E7BD0;
	Thu,  9 Jul 2026 07:31:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582286; cv=none; b=MbVgTt17MPrdtf1POlWHN5ro88orAbRK3X9ZirDI9Kwzr/8raCrWnAa3ydgLcn8bQ8XDTMPUEYftLriZgwXHn/g8uOzPQuDjoZqaWGqfhce5SwE9VYXsa7O+4W4IY0+5NUaX5aNFnRdQkO5l3+eIIv6FcEx1GIBqUwajP6cnBMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582286; c=relaxed/simple;
	bh=WSOM0YrpA9KfMZMnIRKSb9LSlpwz23GMfezXspvNB/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AyqF1DeKm6dPFSzQLoZ4pmRGDamHCgt3amkrxeA/8xXiyC3yKCYvH9Reoi84LUwr/bFnrchvtTSym1VkvFyTc+Df4i1UzoJO/TjnWKTPMV4wFaZmN/QC2jwn9epfIQFEkhE2WI4mQYvasYdC9iJB6d4WkOuFDK1AIoaBxqfPmnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=EzOVpuKp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BSEzcjLp; arc=none smtp.client-ip=103.168.172.141
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id C79BC138013D;
	Thu,  9 Jul 2026 03:31:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 09 Jul 2026 03:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1783582283;
	 x=1783589483; bh=wJH7Z1Dp+e9H++GfH7ci+SP8WkC627YtXrDnkmjFkdo=; b=
	EzOVpuKpg1a7PXCDcrJkdzq3ErWeuXXqbhBBSznUDbfl2L0qSGbkoKb+gCLAs+zX
	Rp3Uz6FO56S6ZIvJzVmEQaRT67CtPHVAzTxLW7V+ajY6Dh6TcDakq2U9Uhx2hA2j
	ZqMq5AKhCLwiaxhECjjXI4HH5EVizkbh5BveS5Ee7HD+P30mPHbzRPnekBjLADxz
	tI8N6YcEVYeHbMZ4BfvTSf9hIcDgCCYodUdyEgFzURwBIXIfre8yEN7fRqc8gy1y
	IMtkLEEqldKtSA2KFANss7XGkRvELLyQWT9agZPiXnfGjCvnaXKO1bzkhnKnZEOm
	MZ32rryKiQ2s7kIBn16uVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783582283; x=
	1783589483; bh=wJH7Z1Dp+e9H++GfH7ci+SP8WkC627YtXrDnkmjFkdo=; b=B
	SEzcjLpZ0Q9Dq5//Jsc1DLs+6RcTNNN3eiDVdYwrRQ0f4YuOhqPYobNAnCnnO4cl
	VkuKcU1XkpakuIBUsF/s5O5CxEqTSsczBeNMsAf1tR+gPaiGpoF5rwUVuJeHv23U
	gdFj4PK0M49SpZ09FVKHC/EamJ5OgH1Fwn8xhshTxXnTqr4YuuYVhD4AMvkDK/iX
	pZTWCbo1eEZuq1FewpUSwrlpGhOvc73pw3+OQhODhdsUCSg58uW2lsNq5J0rDoTY
	wGgs9gFxy+EMJ/88cr8kI/39VjD4K3Jyy8gVXIDYEmY4nyxwDZy1zvSyEew49ouE
	q4cM2Z467Kx/H2ZKd8Xeg==
X-ME-Sender: <xms:S05Palsqx2utDPb_sL7dLEa1Jw9j4122EHxK9Di6gbZUx6NHmvV_Jw>
    <xme:S05PajW-D8zRLCh97XdYA3tY4VAjrdKU8foBi-xdBkPpp4y0OT56I2EPXlBBBJjWe
    cUk9ZMnM8mc6xBKB3bIxpVqTgk8ptzSywjBTZb46OFvQKUMVxR9RtI>
X-ME-Received: <xmr:S05PamWrn67P61EbGFwhmRQCg1dB_wwWOjc5WZ9Qmu6zFst7jylPZOQ24U3JB0L0VSakZiFB4352HCBy2US5Zg7IXB_JQQWe0yY>
X-ME-Proxy-Cause: dmFkZTGtcogUzsgGVSIfMmART6Z9XmtSrTIIEh/iBSqj8X1qDc34PC3kbgB7tR/vwLzKVf
    kqvFRO9dmgluv19XwE/AsIwQzOX8oXecvdVPJjjrZr3jnaou2iSke/y82ZyCP3L5qDkakt
    dur3RuUXkCTbrAhoF8QEq0O718G/XzfnJoqPLA6j2kxRHBxF4K/CgEK5IxmHjModRqpExw
    e0X9mprIbHqtSIkWvRcBteaL8/34ubH5hdAhAS2Eb0osfVj0njIZqL54O04DtPszZ5sHbx
    odRhuNJJ6vR5N7Wkl0UhPFlvdKhQKNlTg2ojEls9M+9ySrFL9ygZvOC7z41GE7FKjCrSgj
    e6VSFb/2X7FL9Wj4adPGSfComzXfQke3I5IwQfvuFAkho48fhR/kTPJeJO+zwfrFY58/pl
    4VHf1ecvk0dAcmHZTmMU6+dkbYpylhWQeZTCHIo3qOUEuAn7kWRLcaJkxghoVyBX6FOnFN
    GNqD5kGOn2EtqV7Ia7NrBsZK/x1IrLhFSsIq91LfqMzgrYPWDTu2op0HaOrsyxgE8UG57y
    8PqZQaHG8Ye3O803p1iEBHgUES80vYx9i2s1OnGHJL0BMgw/6KY5/HpjMCFtg2xp60kArv
    V1jcGw1IwfIbk1yhJYoBA51g+gK0pzvyrpcr9BuV5JPTu4m1XHjAjS1hRiKg
X-ME-Proxy: <xmx:S05PauSHt3Hkl8-RheZzvQDzqXjea4Eks_2Bu97yZvwvsYY9MnGy-g>
    <xmx:S05PalENtOl5GguwhXkqbcwMeGnC6PZy39jSuy4bQRdTd8llytdGzw>
    <xmx:S05PauS4dpjMw1sj30m2Kc9jnMVbVsszaOPtUHEkchkXiyY6WQ2kqg>
    <xmx:S05PavrQlgfckmBWYnKFJBPnOXy7_amItGWE0BVX-Sh6hUcCKfM-HQ>
    <xmx:S05Pahu9F5CsRHoqf_pmFIBusi34Q7YtlfKpz1BOFYlu2LuBJVMwhtAd>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 03:31:23 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 09 Jul 2026 09:30:50 +0200
Subject: [PATCH 04/11] dt-bindings: arm: apple: apple,pmgr: Add t6030 and
 t6031 compatibles
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-apple-t603x-initial-devices-v1-4-55b305833123@jannau.net>
References: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
In-Reply-To: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
To: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Linus Walleij <linusw@kernel.org>, 
 Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Sasha Finkelstein <k@chaosmail.tech>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=900; i=j@jannau.net;
 h=from:subject:message-id; bh=WSOM0YrpA9KfMZMnIRKSb9LSlpwz23GMfezXspvNB/0=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhix/P9sG3esrH808V9aha71f/EPq1RtLYw8r9jC9uCEcW
 hixIepjx0QWBjEuBksxRZYk7ZcdDKtrFGNqH4TBzGFlAhkiLdLAAAQsDHy5iXmlRjpGeqbahnqG
 RjrGOkYMXJwCMNWKaxj+WYYv2ZHy+MfOz7+2Zh6Z9ER049989a0TtaUajdSCvkjGfmP4X9bk+Sh
 N9LDUtme/pyjOP+7FPLdpjuLUfyqqDFp/Z2RW8wEA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9657-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sven@kernel.org,m:neal@gompa.dev,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:tglx@kernel.org,m:wim@linux-watchdog.org,m:linux@roeck-us.net,m:linusw@kernel.org,m:kettenis@openbsd.org,m:andi.shyti@kernel.org,m:ukleinek@kernel.org,m:k@chaosmail.tech,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-watchdog@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:j@jannau.net,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	DMARC_NA(0.00)[jannau.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jannau.net:from_mime,jannau.net:dkim,jannau.net:mid,messagingengine.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F138972DD57

The block on Apple M3 Pro, Max and Ultra SoCs is compatible with
"apple,t8103-pmgr". Add "apple,t6030-pmgr" and "apple,t6031-pmgr" as
per-SoC compatibles for M3 Pro and M3 Max and Ultra.
---
 Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
index c67b67ba065a..1d2001836eb4 100644
--- a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
+++ b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
@@ -38,6 +38,8 @@ properties:
       - items:
           - enum:
               - apple,t6020-pmgr
+              - apple,t6030-pmgr
+              - apple,t6031-pmgr
               - apple,t8122-pmgr
           - const: apple,t8103-pmgr
           - const: syscon

-- 
2.54.0


