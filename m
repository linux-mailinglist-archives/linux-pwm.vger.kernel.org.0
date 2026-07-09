Return-Path: <linux-pwm+bounces-9654-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AiAkJQJPT2pYeAIAu9opvQ
	(envelope-from <linux-pwm+bounces-9654-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 09:34:26 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F0E72DC42
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 09:34:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jannau.net header.s=fm3 header.b=EHXgBwZp;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="e akYw1h";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9654-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9654-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D7DCA302526D
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2026 07:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391BD3E559C;
	Thu,  9 Jul 2026 07:31:21 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36255346FA4;
	Thu,  9 Jul 2026 07:31:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582281; cv=none; b=FlrRSvtvZEs1Sz+HwjFUXdF1OJ98QxA0cNgdSEp/4LyOpz9kcdq6atKM3uqdLLpeL6Xr2GD7Oz5UmjP6EmBIHWlBu1rabah6+zXuNgja3HhL9CVcATFs49DMBptJgIHdDdliNUTL+GHFa2VvD6BN2J/6Qkpx/rAx2+dCWOPZsxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582281; c=relaxed/simple;
	bh=pqcKq2hay0R2/b5p3LSUXovMevcuRRsTTjo24eXTAHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uew78MGYrgXFXS/YXOsuDMOHmcAuZSDjhFRVDLX+sn7rKsfjCniLgXeb+TEhcnVnRxv6OtUtj4Ky9cZY3Pt6iiQyLZGXnkSRCzdUZnTGz5rzluBEjcBo0mF2jMdqAkDkUiQ+6Rznhed18BcLRjLJEUyReuv2UChj/1aSmOuHPrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=EHXgBwZp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eakYw1ha; arc=none smtp.client-ip=103.168.172.141
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.phl.internal (Postfix) with ESMTP id 9921F1380072;
	Thu,  9 Jul 2026 03:31:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 09 Jul 2026 03:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1783582277;
	 x=1783589477; bh=iZ/mnhx5BfIO2ZyDyqNqTQiyhKuWuY4CpjZZF+oTV20=; b=
	EHXgBwZpWw89q8hMrlb2UJuLlMJHwKpUZcJSLt+FgoGl+K+x9c42v3HKu7UQOJnH
	/BQBwb99DF/vckNmL1GCfl2geefVFW69U6zOIzNzjkSwifvE4S+prmmKfe/+o5P1
	46cCIhsO2Bsm8oBM9gLOhI6P/RQdtsjpK8STa4O6PwDJ4gOjsDQC4rRTWpnjh8yJ
	cSHxki+WYKESxVGxfkAkneh3sMtNhVZkaIJaOtkgXm5TUUU1al3G08iwADwSbVYh
	vd8i1lWnqdnq4F+LWTTZXJrKjXSqZANoYrYd9j4KbGGHzkWDMMM6uECSnxMfprK+
	CXcj4wMuQz4Jt+xhU/3A5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783582277; x=
	1783589477; bh=iZ/mnhx5BfIO2ZyDyqNqTQiyhKuWuY4CpjZZF+oTV20=; b=e
	akYw1haxtgwb3F/Yk8DtlgXur+HOXUhj+b9aAbLAofs7KymV1PlgQbwPVyWFAN8X
	pgo0LtjzGXpGj3IGV4iH0cuzf+QfFlW+ruL9Angdw8eoYYv30ulm0zVIz12upfUK
	FyDR/oSJ4cAKftvbAO4ZlGiJIwHx7YbZI+8XdsbiVDWCC5ZzSm3Om0rs09kT7gXF
	ekSZ1wmJKH407CJX8ncjftBHbW0+UtI7DsazaAFCeI1MtgaT1KW/fJBDjbA4CQw3
	jB1D8z/r5DdlMHpjd6fwzOunyEa0D5Cqcdat/Ea8hXF+Y6yE2dalIydXFfUcLGvR
	ObXBC4KBdJ7ZB6HBIejHQ==
X-ME-Sender: <xms:RU5Pavg6z4_FPq2wiX4b70iBt1BllBH-0iFCoPCqyLXRXT6Ok_lkvg>
    <xme:RU5Pag7fJ9lUCipOpxX8p1wlAe1vKAJju8YymrmGrf-dJNQrqytG0U4AIWfNT9ws6
    FughVq1mnnzJ7CXEmsUhEnBSQ1W7nGmJj82K1WngqsXiXMuVf-r-PMP>
X-ME-Received: <xmr:RU5PasqddGX1YKnhl-X-oIqhfzZgo44hI8S3ZZ42dPODPOdRCYFVSdgMrpzJFuSg6u6NYCMn4yGuL8Rsy4TGcLYtWfRStnDt_jw>
X-ME-Proxy-Cause: dmFkZTFsuIvKvdTrsul69N9MoRm4Dr98inKDAObe/T0H784nX6XMVG5hwVL1cCfadnj5NH
    AMFCYN3ChKpOd+iUGRKmw3ZZ9407sALvWnZoqEoAyCH7BDmB6tqxdNTqVCxfKwJBg8h8se
    5v5mTr8CsYgHfwEZT1pcpqQ75AP3b6kkcmEF8u5olx6PNdzqDboZp1aet4XMTrQstmVUvU
    vB5IfLgD2Ayfj1gHColpiKvQ2yVixe8QP0JA93u+VtzbGlWUR9plEC8+MLEb50o6YMIgBi
    cw9oTEJFi+AnMynJnoU5b1bYzkudAKQQbtpG+irtuIAcvLtoaBZzEjOdVaJDr5JJexkSVC
    ypjJ0Yht0A8u3sfQISonuM0iEIts9a0CH4tla154lUoCGJkxNticxTtI1N1tO7IvFDXXfV
    97e6XHFyt+fTlgJnE6exQuWYabDI8EYK7U1TMvG9sXHG3q6g+YIw1WdqYubZt5um5fJTSd
    W8X4pxI4zTm6Mh/sDfY1nUwEcrNlZSZJtzJwOTwhXIVbQkv8qPycM9aAxhKwxYqiHgfgZJ
    16mxnHdNXU3g76VQaqEIvEzVvmd3t+cqZ3k1iLUDDA6xAXjIqLH4u5iNGX/7zS3PpBAuQ/
    ubEkiuolwmmS/3xBFuP3kUmUoydhXaz6Pt4p3YpucBMT5RmiFj6H5kzB4tcg
X-ME-Proxy: <xmx:RU5PauV6RaeVJVFoZyR_79coPpvep68WVED9shx6nCL6co4f16svYw>
    <xmx:RU5Par5qYyKEDNmvRGLL6AqoP6Dq2gc-dGuFFkJB6_7zGiWCUX452A>
    <xmx:RU5Pak1uje93IawdBHdz0wsT8rrnLBaH-m8CwfAoq5VonyxgImoefA>
    <xmx:RU5Paq9kCs7fI-TEtyzA4RoqoTx-6NDw06tlv2VrvUt48mm2HUu3cw>
    <xmx:RU5PahQCDUxAkG1za9pYABmv1D9K_gZL7kw17ZJQ0rYZZWlj51BmgbzE>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 03:31:16 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 09 Jul 2026 09:30:47 +0200
Subject: [PATCH 01/11] dt-bindings: arm: apple: Add M3 Pro/Max/Ultra
 devices (T603x)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-apple-t603x-initial-devices-v1-1-55b305833123@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3254; i=j@jannau.net;
 h=from:subject:message-id; bh=pqcKq2hay0R2/b5p3LSUXovMevcuRRsTTjo24eXTAHo=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhix/PxvV0w5KzzxFEha99iw/c7poq7o1b05sXYfqUi/Rn
 XXSmr86JrIwiHExWIopsiRpv+xgWF2jGFP7IAxmDisTyBBpkQYGIGBh4MtNzCs10jHSM9U21DM0
 0jHWMWLg4hSAqY7jZfifsX1KmEDHCTVOW0H2e8GlbA1hNQ3FnTzGO3vqLnYefZrMyDA5Qpx/j8S
 56QVqyy/kv1lWPSc2LmNmoNmH109cr31TfswEAA==
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9654-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sven@kernel.org,m:neal@gompa.dev,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:tglx@kernel.org,m:wim@linux-watchdog.org,m:linux@roeck-us.net,m:linusw@kernel.org,m:kettenis@openbsd.org,m:andi.shyti@kernel.org,m:ukleinek@kernel.org,m:k@chaosmail.tech,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-watchdog@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:j@jannau.net,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	DMARC_NA(0.00)[jannau.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,jannau.net:from_mime,jannau.net:email,jannau.net:mid,jannau.net:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C6F0E72DC42

The M3 Pro, Max and Ultra Apple silicon SoC family (T6030, T6031, T6032
and T6034) differs from its M1 and M2 predecessors. Most notable is that
T6030 (M3 Pro) appears to be a separately designed SoC. MMIO address
spaces, interrupt and pin numbers do not match. It has two CPU clusters
with 6 efficiency or performance cores. T6031 (M3 Max) as one cluster
with 4 effciency cores and two clusters with 6 performance cores each.
T6032 (M3 Ultra) is like in the previous generations two T6031 dies
connected with an high speed interface and appears from operation system
perspective as a single SoC.
T6034 is a separate identifier for smaller M3 Max variant. It has fewer
performance CPU cores (10 instead of 12), fewer GPU cores (30 instead of
40) and less memory controllers (384-bit instead of 512-bit combined
width).
Apple has only released 14- and 16-inch Macbook Pros with T6030, T6031
and T6034 (M3 Pro and Max) and as only desktop device the Mac Studio
with T6032 (M3 Ultra).

Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/arm/apple.yaml | 37 ++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index e49403c73f9d..111c28d94736 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -123,6 +123,14 @@ description: |
   - Mac Studio (M2 Ultra, 2023)
   - Mac Pro (M2 Ultra, 2023)
 
+  Devices based on the "M3 Pro", "M3 Max" and "M3 Ultra" SoCs:
+
+  - MacBook Pro (14-inch, M3 Pro, 2023)
+  - MacBook Pro (14-inch, M3 Max, 2023)
+  - MacBook Pro (16-inch, M3 Pro, 2023)
+  - MacBook Pro (16-inch, M3 Max, 2023)
+  - Mac Studio (M3 Ultra, 2025)
+
   The compatible property should follow this format:
 
   compatible = "apple,<targettype>", "apple,<socid>", "apple,arm-platform";
@@ -365,6 +373,35 @@ properties:
           - const: apple,t6022
           - const: apple,arm-platform
 
+      - description: Apple M3 Pro SoC based platforms
+        items:
+          - enum:
+            - apple,j514s # MacBook Pro (14-inch, M3 Pro, 2023)
+            - apple,j516s # MacBook Pro (16-inch, M3 Pro, 2023)
+          - const: apple,t6030
+          - const: apple,arm-platform
+
+      - description: Apple M3 Max SoC based platforms
+        oneOf:
+          - items:
+            - enum:
+              - apple,j514c # MacBook Pro (14-inch, M3 Max, 16 cores, 2023)
+              - apple,j516c # MacBook Pro (16-inch, M3 Max, 16 cores, 2023)
+            - const: apple,t6031
+            - const: apple,arm-platform
+          - items:
+            - enum:
+              - apple,j514m # MacBook Pro (14-inch, M3 Max, 14 cores, 2023)
+              - apple,j516m # MacBook Pro (16-inch, M3 Max, 14 cores, 2023)
+            - const: apple,t6034
+            - const: apple,arm-platform
+
+      - description: Apple M3 Ultra SoC based platforms
+        items:
+          - const: apple,j575d # Mac Studio (M3 Ultra, 2025)
+          - const: apple,t6032
+          - const: apple,arm-platform
+
 additionalProperties: true
 
 ...

-- 
2.54.0


