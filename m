Return-Path: <linux-pwm+bounces-9560-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qnHFOoVZSmp/BgEAu9opvQ
	(envelope-from <linux-pwm+bounces-9560-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 15:17:57 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 338C870A0A2
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 15:17:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cyberchaos.dev header.s=mail header.b=PZEQH3Ca;
	dmarc=pass (policy=reject) header.from=cyberchaos.dev;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9560-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9560-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A79C63004058
	for <lists+linux-pwm@lfdr.de>; Sun,  5 Jul 2026 13:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD3D380FF9;
	Sun,  5 Jul 2026 13:17:36 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD9C2E1722;
	Sun,  5 Jul 2026 13:17:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783257456; cv=none; b=o+bE892FMXIM3BI0FC4OBsqL1+XdTZ2GGc9cDd+prUruTw93mDXbmqreeqdjiLJeyVOAiVAECuPpREdPhDqiqAg7pTNyk2qEjC9Q3PvGqxrs5i7Qja1Sz5hSX3brMnGhrix0WtUTaD+5dcs9ocKnf1FQjW7zzmakXFKUxVvh6rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783257456; c=relaxed/simple;
	bh=AtN45WrQIxOZVuI/t0cBjAnhziQKLGkfM4y61MbTz2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZcNhDowOfOXpeyN5cbm6F3Zk4GkCanc2vXx3zURELl0KGDnj6RuTn00KxLNBP9o90DOalxu9yG/8MDS8nBaPDxPtBhFRFd6kekX9jYduJ+v2rNfdaUixX3JB2OhYBpeEns738SemIn1qPXjg9C+szsqDfdJjDxH2KP3w6gsssys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=PZEQH3Ca; arc=none smtp.client-ip=195.39.247.168
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1783257452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=afujMTjkfrhrqR4IW5B2/0jxn/KKnGOyRGVGs6O2+64=;
	b=PZEQH3Cal76bdn7R/jQ0IWk4GC+zjq/qDVpzX2XlsXZES3c8PcgQOi2U0g2sTzF3OuAuxA
	tB+VWJWcO90+2NEpdstTQWch0f/H4ZQsdrX4bUjSg1r6K+iHuGzYuW0Yas8B+kKI0t5ga2
	nJuvjfJ1iw6ig7RlT3LUQPLqXWvQx94=
Date: Sun, 05 Jul 2026 15:17:20 +0200
Subject: [PATCH 01/10] dt-bindings: arm: cpus: Add Apple M4 CPU core
 compatibles
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-apple-m4-initial-devicetrees-v1-1-e5655ee56523@cyberchaos.dev>
References: <20260705-apple-m4-initial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev>
In-Reply-To: <20260705-apple-m4-initial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Hector Martin <marcan@marcan.st>, 
 Linus Walleij <linusw@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Sasha Finkelstein <k@chaosmail.tech>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Yureka Lilian <yureka@cyberchaos.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cyberchaos.dev,reject];
	R_DKIM_ALLOW(-0.20)[cyberchaos.dev:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9560-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:lpieralisi@kernel.org,m:sven@kernel.org,m:j@jannau.net,m:neal@gompa.dev,m:tglx@kernel.org,m:wim@linux-watchdog.org,m:linux@roeck-us.net,m:marcan@marcan.st,m:linusw@kernel.org,m:kettenis@openbsd.org,m:andi.shyti@kernel.org,m:ukleinek@kernel.org,m:k@chaosmail.tech,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-watchdog@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:yureka@cyberchaos.dev,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yureka@cyberchaos.dev,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yureka@cyberchaos.dev,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[cyberchaos.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cyberchaos.dev:from_mime,cyberchaos.dev:email,cyberchaos.dev:mid,cyberchaos.dev:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 338C870A0A2

The core types of the M4 SoC no longer carry individual codenames.
Apple's device trees re-use the 'everest' and 'sawtooth' codenames from
the M3 generation for all later cores.

Instead, we use a combination of the SoC's codename ('Donan') and the
type of core ('e' and 'p' for the efficiency and performance cores
respectively) as compatible for these cores.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 5be89c584026..c328e9fb9843 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -86,6 +86,8 @@ properties:
           - apple,avalanche
           - apple,blizzard
           - apple,cyclone
+          - apple,donan-e
+          - apple,donan-p
           - apple,everest
           - apple,firestorm
           - apple,hurricane-zephyr

-- 
2.54.0


