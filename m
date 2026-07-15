Return-Path: <linux-pwm+bounces-9735-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JxmpCJRQV2qBJAEAu9opvQ
	(envelope-from <linux-pwm+bounces-9735-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 11:19:16 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB1875C603
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 11:19:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jannau.net header.s=fm1 header.b=KgSZLgQ4;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="Z UlFh2+";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9735-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9735-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AD4531EEB23
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 09:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA1B3F7A9A;
	Wed, 15 Jul 2026 09:12:18 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2600B3ED5AE;
	Wed, 15 Jul 2026 09:12:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106737; cv=none; b=bMlVBDc+9B19mFp/mS9ll4hUjGmmvdHl3Oi4KRbenXaDrHiCsqA9hehi4FOZX1CkiqUCfiXzvLsRrdYhG5Im8cVDJSvN8NWWAkiv8qE6KMT9Tc16BX7hKrEOrfAOm9cdQ5SsnfmDrw0641o8+g8TZbHRq0ot2BeR13wW/WLPSZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106737; c=relaxed/simple;
	bh=POzZ04ii3oXGYWWZpjbkyxhYQFzbHUY/uXqN7MGTeek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OjA5HOc3J9N1/RMEDvNF7Ro4SsQrrJu1KYVGcwlEDfqAM7l7sTve4gkQDyGpgr+7KjPMnuJvWQ9EdodDHDDYERD34wz8D6jg5bR8YoPXaJVlFYzXpoD/LBopI0hV9MbAUUafqYKS5u3SVbj8nrVhDJbOpk4sgFbMqPwidynokdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=KgSZLgQ4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZUlFh2+T; arc=none smtp.client-ip=103.168.172.151
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id EF2BBEC01E9;
	Wed, 15 Jul 2026 05:12:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 15 Jul 2026 05:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784106730;
	 x=1784193130; bh=XZ5pRocpsgstKptuIu98uX/SfHwckyMF0rK2V0V4Ggs=; b=
	KgSZLgQ4ryPyyKvJS/DpwTAt8FfY3z3qpDeNlQ86/fbN5LWO0LdDNc5zHwfc/Bql
	m9WDZOEn4GI87fBAk4K07FJsjC8Z2oLYbeH/Q46tfOQECEfagioudtTnVW/UDORb
	Mji5WzFGX/tyb6sRC4NeIkIF9XdEnaN4H6XE/r1r8g/bB15COSVKXSFUX9mJU2MT
	UBdvlEJri6de67rc7QIVK19rWCx8RLQY/cTeJC1iDHlKSNwkaO7gudSYXKXO4Iyj
	tfYALFhUuXknhRIoBistt8JzUqmulCemoEy1lTlWwAPTy6hiUp5LjhWELO46EkZa
	QYbyyxJ1lSRzf9Eqe4ICVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784106730; x=
	1784193130; bh=XZ5pRocpsgstKptuIu98uX/SfHwckyMF0rK2V0V4Ggs=; b=Z
	UlFh2+TVLfTyMJLXfOfIPYqWhL9EiN6a8mNNiLS5BgEepas7efXqTB/uQZ4MojHv
	GEzeCBjO17dA/kp7HGKhhWthe5Ay+cujOmY2iSpJanfnib7QhX9eHuHCABzjep82
	VhAOdO2QEPI5ZPKj8FSONrshqEPgWNOD6q5t5Rb3gfpGsaGK0dv6tM+uNqjNKcV4
	aOsjS3uM9Ab69m1xEFuhKmhvFSuaBFxr/UarLun+rucMqnif1uLqnsNiCM4eCaas
	jgE+AGaQfQ2Vm6TAEU0Hc+phMzqXLbH7WF33dbDKWYfMQ+PNGNEY8rxq3Yz5n4WE
	Wep0FWoLX+LmL26SO/JOQ==
X-ME-Sender: <xms:6k5XalZ93oOOT5qaQTvvK7uWW4sREKAMCnbRy1DVh-eeUaqCYgGHzg>
    <xme:6k5XasxVrfPsszOUZjaS0rFcDgzxF-T9bETc768ZWycmEY_RZukO98YPV2GhgWykA
    4MD5CaXJLRwE8-cKrQ9_no8dW4USoF4tBuDxBeE0LKfmzSK8-BI4ZA>
X-ME-Received: <xmr:6k5XapHdrPpdxZ2-9f-l0SmOKu7mKHqF_W6XXUT0t95qG9c8sti_3cAyoNiQO320KjXsaLDiMLk2Dq9VmS4iNeYQK3b7a6YWnGWN7w>
X-ME-Proxy-Cause: dmFkZTE2gDmfm1f6JjZkdn8uZ/rUQZlkWDZUpUKyAVOd2MB7mZhO+ei+CjakzAhEidYyF9
    sKbn8PGdq7v3gVNOAFzU7/WDZWt7tlbE876eNZ32SeWzbxFEIvL2gJxeQJl9pKwboBz3Ke
    Qugf2EMcZZlhegCxqaqjkexOH2Gt3Ie89hnBCSZa/9Tjwqlsy4JfLoQK6N93BBlsgvYG08
    7yIq2nMuPqZMpdMJtN6GbqcV/Mv4qMXYSX6pQ1bnUYrqDaDpjI1rNTNMAeVqkiUbfWJa0T
    mGfpuNdz9wsESMTL1AY4qJYTG3ikjrFEuoPXuyfgYFxG+Yszs3snNBLQ8fyiLcakyJ7KTP
    Ko9J3O713exSORAhA6SYGXYUZYq/80ukvaMG+vWo2zykQ2hpjKXUoUoJOj5IpACDUeH9Xl
    K/jPXoN6ftiZmu/FMXxC5LmP2bpraio41HBg5GQLoz4msdtqzu9LlrKxx50ur0FdwTqrFu
    bXd5FCy5f7TLr0atSaQl/EDX1XcG2vH+Y3aM1Hz2kMVIzs7cdqK3eUwa6JEEtVbTgG7rJM
    za84z8qnZ00Fv+IL6gLZwcusWS5RFPX+tUT6R0pQTa7bQYQbvFGq3d1rUJTKsMQCf5ZXLL
    P/tS48Q8cSD4+XEDOcWtYF6o4QKFHAAvM1AzT40XqO8Qm3TxuceD5FYS3akQ
X-ME-Proxy: <xmx:6k5XavpNKKj7UUiX-wB26dREVJ6PQFGn2p6I5pJZnCEzyojolax3Rw>
    <xmx:6k5XavzT3hiXWKhkXyKjZKac7zhiOariV2Ir44k8Pyk1w3w2hBrmDw>
    <xmx:6k5XahxSYGjXA7zp4rplDQaKwpVdCSc43ljJTJ5FJquOSc7MSqFWJw>
    <xmx:6k5XamS7vTqm1tyYv7chSfatdvR_4xZF9BAvssjboXD1PpQY_hVelw>
    <xmx:6k5XauqSX2zFVr4Ai8dWU5dFde_pJpNqkGedjv1Jpqmo2G2SLR_-Qu2M>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 05:12:10 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Wed, 15 Jul 2026 11:11:53 +0200
Subject: [PATCH v2 06/10] dt-bindings: watchdog: apple,wdt: Add t6030 and
 t6031 compatibles
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-apple-t603x-initial-devices-v2-6-df65b2485710@jannau.net>
References: <20260715-apple-t603x-initial-devices-v2-0-df65b2485710@jannau.net>
In-Reply-To: <20260715-apple-t603x-initial-devices-v2-0-df65b2485710@jannau.net>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Andi Shyti <andi.shyti@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Sasha Finkelstein <k@chaosmail.tech>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-pwm@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=982; i=j@jannau.net;
 h=from:subject:message-id; bh=POzZ04ii3oXGYWWZpjbkyxhYQFzbHUY/uXqN7MGTeek=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqxwvxu3WH79Tp46yb31h0NEjo7R31jeh7aH62+vtBU8d
 dbYv86pYyILgxgXg6WYIkuS9ssOhtU1ijG1D8Jg5rAygQyRFmlgAAIWBr7cxLxSIx0jPVNtQz1D
 Ix1jHSMGLk4BmOpIe0aGa1uy9bsSX0zzN3XXmHNBYuf+845C+721l7ayTLq2pLfgGMN/r5m7te+
 z+B+o3nro94pa+RLBvd+eXKkoWvWXS8duKfNSXgA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm1,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9735-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sven@kernel.org,m:j@jannau.net,m:neal@gompa.dev,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:tglx@kernel.org,m:wim@linux-watchdog.org,m:linux@roeck-us.net,m:andi.shyti@kernel.org,m:ukleinek@kernel.org,m:k@chaosmail.tech,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-watchdog@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:conor.dooley@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	DMARC_NA(0.00)[jannau.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[jannau.net:from_mime,jannau.net:mid,jannau.net:email,jannau.net:dkim,vger.kernel.org:from_smtp,microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5FB1875C603

The watchdog on Apple silicon M3 Pro, Max and Ultra SoCs is compatible
with the t8103 (M1) one. Add "apple,t6030-wdt" for M3 Pro and
"apple,t6031-wdt" for M3 Max and Ultra as per-SoC compatibles.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/watchdog/apple,wdt.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
index 845b5e8b5abc..bef8255022fa 100644
--- a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
@@ -18,6 +18,8 @@ properties:
       - items:
           - enum:
               - apple,t6020-wdt
+              - apple,t6030-wdt
+              - apple,t6031-wdt
               - apple,t8122-wdt
           - const: apple,t8103-wdt
       - items:

-- 
2.54.0


