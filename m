Return-Path: <linux-pwm+bounces-9731-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LsyjJIJQV2p+JAEAu9opvQ
	(envelope-from <linux-pwm+bounces-9731-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 11:18:58 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED10F75C5F4
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 11:18:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jannau.net header.s=fm1 header.b=K4aPOpNj;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="Y 5hZ+Rm";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9731-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9731-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 316A431E12EA
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 09:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD793F4845;
	Wed, 15 Jul 2026 09:12:10 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E633ED5A6;
	Wed, 15 Jul 2026 09:12:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106728; cv=none; b=MhqSlSldMsYcNBsSDsD2dheNxjGgB/J926rFpXwg6dM2jRg9gfDcXQ+ivBl6okQZe/HAHSQ8J70gxK5BLqK5zFJmvgXWQwzRvloRBn2QA0u31HFIw8oxgu6avoZ680Ji1IK0kz/F6xXi+4BNdbkeGKr3rxLHhamEleEpWOYi7dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106728; c=relaxed/simple;
	bh=3KqStA0vOh3gLhhM0N7a+mTVjgYTrvoTWcsvCD7tNQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PkLldXW+0QDY2nK2yv9eUEq3vLv3QlQQPdkqdopxC/tVmyMpa299o1CwZjcctwNUlsKprMe1K7SdEk3vbPWUcoVAllFJvxoELXowSaDtR9gXLvwulQFsVqdZdRxH/TflvU3bIxgOJiI3przdF+Fwd4tB/bNyC15mqtTxmpt578A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=K4aPOpNj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y5hZ+Rmz; arc=none smtp.client-ip=103.168.172.151
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 35493EC01E7;
	Wed, 15 Jul 2026 05:12:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 15 Jul 2026 05:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784106720;
	 x=1784193120; bh=SRkTLGqM3vhWnE1QrtQWOVktNnFZl7EvFbRUlHz6SFQ=; b=
	K4aPOpNjgNSd/rDZjZrtaObcmm6H1pBd4mv1DrTd0NZruld0Yg37YcY3Ivn/1IEL
	kB7d4kuWLNRt1lHCdsB0sQB3UnCDECbHdrtKFnJjckB8/b/8rJt5PguM2TqVqb76
	BRkTkRmKbC+Us5ugzGxm/KtCKQu6C2M4jYlrW+gXLME3ZkM4R24TKWQeCCKvytzC
	i0AFnbmS3ePGcPD/6TPmGn7zt0ZUvcdfwgHCIqVAQFr+6Aj7ifrUuDnr9JxWHfJh
	WbnuejMeZL48kr5CURK33f3jr7AeEBATnh25pn0gQWBs4Q35/0tajOXqAIB4ypOH
	6K56nI06VfYW3z70Bsl6uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784106720; x=
	1784193120; bh=SRkTLGqM3vhWnE1QrtQWOVktNnFZl7EvFbRUlHz6SFQ=; b=Y
	5hZ+RmzS7tOimk+YEb+gDBh9Jg3AENn1DwMjF2z+h3lWC+rCkjAWp0HfO63JPUF9
	5KjN1J3c/458SmKCmy7c41wNFwqhiwGpRdnhRqhfcdi8vQPqt+RHPA7BhOOoRncn
	bmyZaCoJkKuNdcVXHaib2Nkyk05V2+BXxJve4xCyDpVQY/ooiieE7k0QWKRALzGD
	pLnGUNwOISYx+JKo62ckBrfM7poplTIg+Ja7nP6WsEFPNIT5i/28Dwd8H+HJ7JYD
	J3zbZd+eoM4eUp0hO5RvT8TWDSi32nPCwqalqOjBd8YqWJVwtKPU7+9L3aPraZ35
	x7hf6aV57o/NSse8zlZIA==
X-ME-Sender: <xms:4E5Xam6jihcDONSyM8FgAPNwR6ZHaWSrD-DTlU-DcYz9gPLfaYkrSA>
    <xme:4E5XagQeU2z1teJE458eTEvhv2gMuSw-vT2gUdWS-_RSnMcU3Am_oDjaU_n0tbKjt
    4RYCvnQ_lA7iRRqPVzDg5-N9Cpno5EFIex3drJgjq61KCm1_s0EOfss>
X-ME-Received: <xmr:4E5XamltxW6O9bAwNS4TXJ1K7itnLxJdcapEAdQr87I_q_rAFKFqaaXagje5j-VklaE89CCwivVrFM8wUt76eAK00gtHTN89oJO-iw>
X-ME-Proxy-Cause: dmFkZTGLBKmB5PzUkMr6ko/mqj5IHxBJNxFvqMKpFknx/d+TQPsuitJFYNuH8X5aBce9R7
    tMzgE7tUB/P2h5T8uyczMRGwUga8g25gxgHkb6zt/dHHhgEyqoKijbGPm4c94Ba06so0rO
    8aHLYTj1PMCkLyKEqrs3jBel/YvsFIIfSq7rh6KA8BGuvenAo9C2vokqu5f35I3EUPuFlA
    PyKHPPc9QlP0kuuY6KWj8kdBQA6mQ/B1tqvU0sKOBy8csnboAGWF6UXr6ZhBi4Vh7WXhwt
    rJ19aJH/gP5zb7oC6huPtFVf2g2r4ZI6hxB7jjQtBCWm2TRzqafvrumgwJ7soeSa97MILn
    dHktbH0fh3MjRIIn+Zthz4Ec+jmioiTm4msNYu7mmdYfmOe23IDVNsaCDn7apZX7q4SX8O
    3xtxk6dWv6JtJ/UkPmz+UO83t7CMG0Ky4ltETrJkEvCcMZ6kLAoBvr8OkeeKBgOsSvt0Jm
    sgVoqwAgvk90mq2h+NTzAcPtxYYwDlix3fSOBl1T+JmtFJbjHeJV9OhVpMYeoS7tsHq9bj
    ZL3l+w3w+AR+Jd1r0OM9fNvYaxDCsTX9j1Cns8aByZtfZa3g1TbV9cioWFjiB9j99F0m8y
    aXo3eBnhYbiLLESnCxZm1oXwTEg38Lzs+Zjy/fBBtIlvCWQ4DXIgy8Nvp8zQ
X-ME-Proxy: <xmx:4E5XavKc-RKHj-61FbOV1bK6InDH1sFbQ_F9sISd8W8yOuoXaF0s6A>
    <xmx:4E5XapRDkH1SqCznR8iC9sDxcqufOxr1KmRGhFVrD-wMpiAoZhlQKw>
    <xmx:4E5XatRlT2J3Yz56M1GvkZfoFAxbW1Lg_vrn72XPMbA1DEw1h5vlUg>
    <xmx:4E5Xarxw4C4e2bMfz9VQqWwB-iqJuLGIZqTvYOuIrI-il6oOxjcmaw>
    <xmx:4E5XanKMzatyaPpl8uoszv6iLX75lV3bvml235ECXAB5mACWrqDMWI8U>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 05:11:59 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Wed, 15 Jul 2026 11:11:48 +0200
Subject: [PATCH v2 01/10] dt-bindings: arm: apple: Add M3 Pro/Max/Ultra
 devices (T603x)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-apple-t603x-initial-devices-v2-1-df65b2485710@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3346; i=j@jannau.net;
 h=from:subject:message-id; bh=3KqStA0vOh3gLhhM0N7a+mTVjgYTrvoTWcsvCD7tNQ8=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqxwv+vFhQLV0/kEWV+G+q5R/xdwv2fz6cL4hZO6T6jtC
 r4+26W+YyILgxgXg6WYIkuS9ssOhtU1ijG1D8Jg5rAygQyRFmlgAAIWBr7cxLxSIx0jPVNtQz1D
 Ix1jHSMGLk4BmGpTWYb/QcHTftXE8Z2pU2Q8K6IXdo2l6lKMiCizQujZy5H+mziSGf77NbkftMx
 7vP3fD5m7ayIF4vav3tDQtfsWw6n/pyx4YsW5AA==
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm1,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9731-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sven@kernel.org,m:j@jannau.net,m:neal@gompa.dev,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:tglx@kernel.org,m:wim@linux-watchdog.org,m:linux@roeck-us.net,m:andi.shyti@kernel.org,m:ukleinek@kernel.org,m:k@chaosmail.tech,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-watchdog@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:conor.dooley@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	DMARC_NA(0.00)[jannau.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[jannau.net:from_mime,jannau.net:mid,jannau.net:email,jannau.net:dkim,microchip.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED10F75C5F4

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

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/arm/apple.yaml | 37 ++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index e49403c73f9d..fb277c96f341 100644
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
+              - apple,j514s  # MacBook Pro (14-inch, M3 Pro, 2023)
+              - apple,j516s  # MacBook Pro (16-inch, M3 Pro, 2023)
+          - const: apple,t6030
+          - const: apple,arm-platform
+
+      - description: Apple M3 Max SoC based platforms
+        oneOf:
+          - items:
+              - enum:
+                  - apple,j514c  # MacBook Pro (14-inch, M3 Max, 16 cores, 2023)
+                  - apple,j516c  # MacBook Pro (16-inch, M3 Max, 16 cores, 2023)
+              - const: apple,t6031
+              - const: apple,arm-platform
+          - items:
+              - enum:
+                  - apple,j514m  # MacBook Pro (14-inch, M3 Max, 14 cores, 2023)
+                  - apple,j516m  # MacBook Pro (16-inch, M3 Max, 14 cores, 2023)
+              - const: apple,t6034
+              - const: apple,arm-platform
+
+      - description: Apple M3 Ultra SoC based platforms
+        items:
+          - const: apple,j575d  # Mac Studio (M3 Ultra, 2025)
+          - const: apple,t6032
+          - const: apple,arm-platform
+
 additionalProperties: true
 
 ...

-- 
2.54.0


