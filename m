Return-Path: <linux-pwm+bounces-8829-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uE8wBNtA/GlMNgAAu9opvQ
	(envelope-from <linux-pwm+bounces-8829-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 09:35:55 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A38274E4240
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 09:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9EBB30459F7
	for <lists+linux-pwm@lfdr.de>; Thu,  7 May 2026 07:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26992361DD2;
	Thu,  7 May 2026 07:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="jw+mAB3n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y4IhRj9c"
X-Original-To: linux-pwm@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B791335CBD7;
	Thu,  7 May 2026 07:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778139212; cv=none; b=pLnfHlR4UNj4p5iu92xF4jILYKQJqBLKC5YD7eBl13CizainJoCgsH5jMBq14SI8GKDPgFraVVK2cJtSb30yLu/8pds6rcy19D5aouygWq8Rn8tuNr3Mc8yFVpivlpdcooJAZfJH8RxRt5eLmAajx0OxSJpbNna4wpu5OpCXpPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778139212; c=relaxed/simple;
	bh=1IVQx6AIB/vfknI1NzcqynJhB4K52mpqTMLBWl1yw0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gtRzRImUE748kOLlRJGXqN7uhIIeQRduXJdV7w7woMBB1HMhOKvNAtcbESSfbPzyqNcbULyb2prPBesdYMh6AJbFdL64R4YJdfvU7SwsI/C5VOVcapCccEmkSq8NAhLMk87IU/0jesKv8gF1Bp/T8UieLb7hsWbJkzG5gTdOHIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=jw+mAB3n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y4IhRj9c; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 08FB514000AD;
	Thu,  7 May 2026 03:33:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 07 May 2026 03:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1778139210;
	 x=1778225610; bh=3u0oJwcvekIHFlIhYowyYD57pRQNHflAh6NHQg3cFkk=; b=
	jw+mAB3nfrVj+oCvb6PYqUKt3zlfOy2oc3tCxbAYuLb8CjwOHgcrAbpR+qyTnxuL
	HctGMd/U3rPK+Jm0oGE1yfsTlAHUXSiCMgrfMAKSKzcJOqHEBhajD48c7kjWpYxG
	dvHRc5+uQEsR51DAKlRyeZqyMHTC1e8a2GVQsc0H/OU94sSqJuUkX744XEAWMUMH
	wAdAer36SVV0KQ90R25j3Oigh79+sT6M2Ny10pePH6+PrbhyESPbckWZ5w0YAfp5
	4iaUw0JPVFmySSn+aDV5NxvAaU/MF3dPwqoaxnz7lKx7bqBDyR2NzNqFuc+Bco0N
	BtvrGgHXYH5Lxq0e0KzPnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778139210; x=
	1778225610; bh=3u0oJwcvekIHFlIhYowyYD57pRQNHflAh6NHQg3cFkk=; b=Y
	4IhRj9cS7Z8BtNyW4cqMv1fZtxK+FJbrgmCY8vM0sDFsKM0lUtrmyAzkIISRhhXm
	T3oIvEJDrm7f2idNNG0dpOMcIfW2peOuDATltOz2wlOVwRYgbQa3K+r6U+MDw4vZ
	sSIhJfuTtsd5XmZOgPWwmmKSW4QoOd0919d1KriyZTPbdH+GDdTnaCU638d3dRht
	j1uMyakfNuR63K3Q/HGGSiZZEOuSzgdjVVsS/5OROpSK2DGC3jWoKEIX68fAndUx
	2Dbd56bcdiGikhSki2LzzSoaW5f+4BJgiJND0n+SfMNieyDAQeS6pmowpNuZBzo2
	gPSyAUk0YM5DyXJC5xvoA==
X-ME-Sender: <xms:SUD8aXbNpq35lvoIx9NfZQvtj_GFNgSOig5KuupQ2Nd0_QmdwHa-vg>
    <xme:SUD8abRWNwZeOhbUqx2NCTxVASd_pe-Qwd-NnLxpwJX6KCjcu079SJKuAiUVvU_3d
    RGyjnrEYZM7qSVMkBvhfVRJCdy_HkrbdqjKDbLMdo7S16tSe_gIvxQ>
X-ME-Received: <xmr:SUD8aSjrsZaqXC4E3vNIkFB-1N5kaqfjaJ_WHqumh-GtwLNSXStRJ2hrnSbap19UjGh3BdfJqMImDPhJwhcY_yInmSis5yYEb7MX8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdeikeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgv
    ucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    ehheeileduffehteeihfdvtdelffdutdeludduiedutedvfeffheekhefgtedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrg
    hurdhnvghtpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqfigrthgthhguohhgsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhv
    vghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepnhgvrghlsehgohhmphgrrdguvghvpdhrtghpthhtohepuhhklhgv
    ihhnvghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshgrhhhisehlihhsthhsrd
    hlihhnuhigrdguvghv
X-ME-Proxy: <xmx:SUD8ae5e6lecumkZoTh_AzJB3F9qdRqPN8WuT1dQ7EBjzvPXkIjmvw>
    <xmx:SUD8aVkmkPA0uGGeG8BFgarLIJtGXK0a8VY061x-Zq_0s4-mOPuVrw>
    <xmx:SUD8afMzU8vEh_BDrWlAzvQo1qCDrs2hWJt000eKBNehF95O4-3H2w>
    <xmx:SUD8aXopiWz_PyByJtFXl1bT7toe_Tn7qj39K7sga2vwvey3-u422g>
    <xmx:SkD8adbwE2FY7ZnTiM-f-UJG3p-yPT-Wzj7MGTCDECj9GHqwU1Dp4_fb>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 03:33:29 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 07 May 2026 09:33:10 +0200
Subject: [PATCH v3 4/5] dt-bindings: arm: apple: Add M3 based devices
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-apple-m3-initial-devicetrees-v3-4-ca07c81b5dc7@jannau.net>
References: <20260507-apple-m3-initial-devicetrees-v3-0-ca07c81b5dc7@jannau.net>
In-Reply-To: <20260507-apple-m3-initial-devicetrees-v3-0-ca07c81b5dc7@jannau.net>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Sven Peter <sven@kernel.org>, 
 Neal Gompa <neal@gompa.dev>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Mark Kettenis <kettenis@openbsd.org>, 
 Sasha Finkelstein <k@chaosmail.tech>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-watchdog@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Janne Grunau <j@jannau.net>, Joshua Peisach <jpeisach@ubuntu.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1938; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=1IVQx6AIB/vfknI1NzcqynJhB4K52mpqTMLBWl1yw0s=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhsw/DvYNB+YcY7rL03R7TW1F5feZFw+cX/04rEqlZ+Z+A
 e3ULM7nHSUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACZy24nhn338VBmN3WuroqW+
 /Te0cjuaxW7gMcOb4V3byVeKRWxF2xg+MmoLO05cMneL4BORU19XnLznu0Nna+JkZ/c3yo8Wevd
 wAAA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Rspamd-Queue-Id: A38274E4240
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8829-lists,linux-pwm=lfdr.de];
	DMARC_NA(0.00)[jannau.net];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

The Apple devices with the t8122 SoC (M3) are very similar to their M1
and M2 predecessors.
Only the 13-inch Macbook Pro is replaced by a 14-inch version based on
the design of the 14-inch Macbook Pro with (M1/M2 Pro/Max). The Mac mini
was not offered with M3.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/arm/apple.yaml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index 5c2629ec3d4c..e49403c73f9d 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -96,6 +96,13 @@ description: |
   - MacBook Pro (13-inch, M2, 2022)
   - Mac mini (M2, 2023)
 
+  Devices based on the "M3" SoC:
+
+  - MacBook Air (13-inch, M3, 2024)
+  - MacBook Air (15-inch, M3, 2024)
+  - MacBook Pro (14-inch, M3, 2023)
+  - iMac (24-inch, M3, 2023)
+
   Devices based on the "M1 Pro", "M1 Max" and "M1 Ultra" SoCs:
 
   - MacBook Pro (14-inch, M1 Pro, 2021)
@@ -297,6 +304,17 @@ properties:
           - const: apple,t8112
           - const: apple,arm-platform
 
+      - description: Apple M3 SoC based platforms
+        items:
+          - enum:
+              - apple,j433 # iMac (24-inch, 2x USB-C, M3, 2023)
+              - apple,j434 # iMac (24-inch, 4x USB-C, M3, 2023)
+              - apple,j504 # MacBook Pro (14-inch, M3, 2023)
+              - apple,j613 # MacBook Air (13-inch, M3, 2024)
+              - apple,j615 # MacBook Air (15-inch, M3, 2024)
+          - const: apple,t8122
+          - const: apple,arm-platform
+
       - description: Apple M1 Pro SoC based platforms
         items:
           - enum:

-- 
2.54.0


