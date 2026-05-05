Return-Path: <linux-pwm+bounces-8776-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cK6oBvzR+WkDEgMAu9opvQ
	(envelope-from <linux-pwm+bounces-8776-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 05 May 2026 13:18:20 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 785934CC66E
	for <lists+linux-pwm@lfdr.de>; Tue, 05 May 2026 13:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C807315748A
	for <lists+linux-pwm@lfdr.de>; Tue,  5 May 2026 11:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AD443E9FE;
	Tue,  5 May 2026 11:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="U4h+Z9Ma";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gwogU4VR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7391244105E;
	Tue,  5 May 2026 11:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777978997; cv=none; b=aKtveqPdd/zJuhXW6MQTRn/BssU0gQJw6bXzf/2qcj5Myl/vjm44n0f2bPZa/RCdmWNoFA6K7vUvnLgUH6g//WXB2cmbDZ2zcDwzEsDGu0gYi6mLnE4uO7JkSkhcDGWgVTTMLPp7zDoGHPSg2vMviwuuQZ4Yp8Ript19/jdmHNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777978997; c=relaxed/simple;
	bh=1IVQx6AIB/vfknI1NzcqynJhB4K52mpqTMLBWl1yw0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xp3iyErJUb8eFiCbvJo4+5jiV1dHXlKtPnadELGEITX1jv+1jkFn7k4KYyNr4pSIYfwUd+IlyzVKqe+zAYfDq0l1dCzsme6XP61YyCsSQSUNE/HOxQaNj2Hb2eDBBFOECquQw0bdkFmPyN2VjMxyTT6xFKymzZMc4vIH6lh7Afs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=U4h+Z9Ma; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gwogU4VR; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 612EC7A0142;
	Tue,  5 May 2026 07:03:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 05 May 2026 07:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777978994;
	 x=1778065394; bh=3u0oJwcvekIHFlIhYowyYD57pRQNHflAh6NHQg3cFkk=; b=
	U4h+Z9Madj6D1TqXCZfFFbf+aPXBbYflIS2PE5sD9F/qHkqDATmo6KZcLF2jDtOS
	kiCESgNh1s10tFJBoNquUDEghvY6jsDWr2kPeSPXYHzAE3pYD2dUVZP4804aJdr/
	m0mND65iWlZyIfGvelxOUs9/SzS5exbGMg0jHus1A4CXwpPJ6ckiUhwrahDDhWBk
	DR3nRcRi1UjMHnjM0Fgx8eq580yfZitvp3LOAZH1Mi2b8PIx+ryfxY83g9CwwvbP
	Y+BlI9x2AnhJ089mC2MiyAB4x1KzZgkmheSmEn4SQg5YYuGaWJjxfSDJUYgCLxY+
	S+M+FKhJckphnceKX5qsPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777978994; x=
	1778065394; bh=3u0oJwcvekIHFlIhYowyYD57pRQNHflAh6NHQg3cFkk=; b=g
	wogU4VRvttSkVHu9teqJJRJdjxEOmE0RPqj5L4IrlifaeQOeoIidP8MJR762lTAq
	JE9jYur8b82xneyK0RSp1T7qLiv0R/+meGIdHfbUsmnZpcomOuVyTtVKIn3o7AHc
	C9iLnJEvg0kYQ79076VdLT+yeIBR9UgOLZVX3UiOjFrEaMMSf2Nxo4NifxryffJz
	zJsGn9jzWyIQ+phUsOpAKArOsk7BDZq7MvKD16rG6HwqDUberFWTaWvrQqoto/V5
	XSZIOA0IjKpU+YaBiw3i/mCH89Nyr8vZTHpE310akNOOwM6b+o7VcfJzDtJB8Q8v
	aOA9im56baQi+WzBvXxfg==
X-ME-Sender: <xms:cc75aV_486Br-aoMtLEsCSpbq7-cNdSU1VB9rO8cDUYJujv7bMoZWw>
    <xme:cc75aenxa49ukZrX5Ps_Y6acJsj2ffv5pNoVKXPbHBqwnV5EnPWRe-w-0h91WV7on
    PfkV4__7aH6JQdJ0sMx0i3UeSciiKFY9ElDivbZwXdpoGxlFhJ3P6c>
X-ME-Received: <xmr:cc75abmeZVApvKTMzPHnZtBnlOUlZ-IsFpMiY-tMu-K_ZGNnAUwIRHaFMG-WzL-h_I79De39qGomYsTm4yxXgBlVtLVqIyjmt2wJFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdduheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgv
    ucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    ehheeileduffehteeihfdvtdelffdutdeludduiedutedvfeffheekhefgtedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrg
    hurdhnvghtpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprghsrghhiheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopeif
    ihhmsehlihhnuhigqdifrghttghhughoghdrohhrghdprhgtphhtthhopehukhhlvghinh
    gvkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfigrthgthhguohhg
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhpvghishgrtghhsehusg
    hunhhtuhdrtghomhdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugiesrhhovggtkhdquhhsrdhnvghtpdhrtghpthhtohepkh
    hriihkodgutheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:cc75aasZbiRHVm0R9gaCf7o67hbV23LnnvBckMKo9_9Bh9336IlOmA>
    <xmx:cc75adJ2qGpG1ZqnMVS3df8_j1TMGHb-1jYo-P99iK7AQi35_N9J3A>
    <xmx:cc75aXgthr1ONB4TJSIuXtLZqecIXk357sDzDzL8fxFxkhA8jHh2Kw>
    <xmx:cc75aRvlBrW04DfkcVfPjOBXAdN7CZlaVcgynEGJ4Y8DsA2cD0rkPg>
    <xmx:cs75afsPcnrptvLwZHNVd9qePyMO-r4EKxycekgdzichcXEHBtcHr8iK>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 May 2026 07:03:13 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Tue, 05 May 2026 13:02:43 +0200
Subject: [PATCH v2 5/6] dt-bindings: arm: apple: Add M3 based devices
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-apple-m3-initial-devicetrees-v2-5-b0c2f3519e0e@jannau.net>
References: <20260505-apple-m3-initial-devicetrees-v2-0-b0c2f3519e0e@jannau.net>
In-Reply-To: <20260505-apple-m3-initial-devicetrees-v2-0-b0c2f3519e0e@jannau.net>
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
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhsyf5+LjiiLzV//gqKz8dLE1RkHt8RKZWx8XbKnJTl7+g
 el1XnhARykLgxgXg6yYIkuS9ssOhtU1ijG1D8Jg5rAygQxh4OIUgIkkGjD8U76hVXr89Fa+yE+b
 bz2N3HDBceNEtpyvZed3hCm8WjFB/AjDH47HYt8Y4s2V56m4Gr16PqWbY+exL/GMmX4rF807+rf
 SiQ0A
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Rspamd-Queue-Id: 785934CC66E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8776-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[jannau.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gompa.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,jannau.net:email,jannau.net:dkim,jannau.net:mid,messagingengine.com:dkim,ubuntu.com:email]

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


