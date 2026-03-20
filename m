Return-Path: <linux-pwm+bounces-8301-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCJ/L4k9vWmJ8AIAu9opvQ
	(envelope-from <linux-pwm+bounces-8301-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 13:28:57 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4932DA3BA
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 13:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE396314B698
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 12:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01D33ACA4A;
	Fri, 20 Mar 2026 12:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="qZGsRdol";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E55nhl5R"
X-Original-To: linux-pwm@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968623ACEE8;
	Fri, 20 Mar 2026 12:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774009426; cv=none; b=PxVi6aRBaFUcC6bWqWN3GjroKRJyOezGPBoF4Go8/PUEBFfittXfT7/H6hzaHhOtnMHrWALxFexY9zhqf4qUC1o4tX3Wz50sbgZFKgCwRhGktqg0fKWfyIsqrW9t+kSAQi4ZgzfaXBj/hNnM+7Yv5GY1jaeKOOW/KqnB/cDDK/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774009426; c=relaxed/simple;
	bh=iptqK0MK2F+9Cab0yWgsD04dQkDPQW6FI8oBI0X4bB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IPo4UyUGLoJFDb+AGBdwYc20kMelKxzp2H5r67N3exAV/Rb34Aphz9/2QONa2KPPzTzhvZTm4HCj51LORi+W88GXkS901EVdHjU91Sx5CRn5y/0weE1hSIC1SQUw0f5m+5Ei738o2vkEG4XYGdI0jFUXCG0gscQu0AimgN4Duzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=qZGsRdol; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E55nhl5R; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id D6AF313800DD;
	Fri, 20 Mar 2026 08:23:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 20 Mar 2026 08:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774009422;
	 x=1774016622; bh=LiJ39O+gV/vs6WPLCTGiaT+afqvJ67nFrDEVuBuGfvI=; b=
	qZGsRdolvzShcx/PSmpYIchq3vQMQT269Tc1gxS3NJVyL9o/usDCfWtOC9DUXDNs
	27KkpNScWcYib6s1xdYvnMjaNkH85qdmc5G+Yg5GBOAKX7zGDbsUesoEJb6588nc
	pfE00v1MZH6cepifrUDUwzroGqgB5ubbTkG8f7Nm3KJQsdF6C7KCe2e7pqyasPdE
	jPFR0THfqAlGO2w7vwjc5o0lxXjcdtdO8T112Uul2NRluOYrMeFON42tEae+E41a
	gLFD0IsGPqyGi0pIvw+rYvkvg7mTKhQrX/iKx54gzmnLon0z+ULT7V96xXopCYC0
	br0KxTn/rWI2QZmChp0qeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774009422; x=
	1774016622; bh=LiJ39O+gV/vs6WPLCTGiaT+afqvJ67nFrDEVuBuGfvI=; b=E
	55nhl5Rbv+6HvuHCcvKIDi0Y4YUKvM9jjQDHz+TexuoZrlGgoUU/6zfGxSWh6jkX
	dPIYm/7npGSFy0zOkPJXKSaGFN008572A1uEbo/hF8F3sjjIl7FPSZF6KmcPp/CY
	3cN0A4qV0r/A45SX+rdtabcYRe/Oh4GbejjhtuxIOkGN7NViqt9xPiLUj8yFDCgY
	aZ5PY33s6onBaBJW3PFhID2NVuM4p5jFb9Py+3q+ZbLpmBzeN2hlTJ9Bj0OAu7fw
	1Z1QsdgWy2E561DFY36nv0mIUVzmc3DJBaIvicymjO2HD8MTeKd3U3qXbzc5N0gc
	O6dxjy8kkRyiKBBzzZgRw==
X-ME-Sender: <xms:Tjy9aUE8cMi-Y837N9JcVB4mcYNbQDk6dpWrA2CoWVFUaSoOz4-fOw>
    <xme:Tjy9aSMBKRo6y2ArHcKg5UU7ASV9Ti0ydhm5-wo-VTdz1aUGlOLPwWGnSSB5-h7nP
    Vj5VQfbVOlnF-VLtKo6UCkFcEQoZqivfz5MsyuwUshj_caGCB0VJxg>
X-ME-Received: <xmr:Tjy9abv-6rhwB0ZYeoaSzCPuLmvfAGs-hOfHZ6Lby-t8KBc3_5Onj6d1rP2NknLIBo16bOQy5pgq36RjE9axEqSIWF242Nk9SHGWTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgv
    ucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    ehheeileduffehteeihfdvtdelffdutdeludduiedutedvfeffheekhefgtedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrg
    hurdhnvghtpdhnsggprhgtphhtthhopedvvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhinhhushifsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvggrlhesgh
    homhhprgdruggvvhdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgr
    uggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqghhpihhosehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepkhgvthhtvghnihhssehophgvnhgsshgurdhorhhg
    pdhrtghpthhtoheplhhinhhugidqihdvtgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopeifihhmsehlihhnuhigqdifrghttghhughoghdrohhrgh
X-ME-Proxy: <xmx:Tjy9aYJH8ecz5XDjs_VelJ2b4ydtqVyLx32LA6Wp7ohEkX3dOCttFw>
    <xmx:Tjy9aZeXGsxx0nowuyy53TVeyMjxOvRq9-xbXX9sEZY5xlk-COFAIg>
    <xmx:Tjy9abJ84kpBNR-T3CPuRD7AycW_SmjhMDzOVGK2ZdEbrYK_XsmoKA>
    <xmx:Tjy9abBDTPddTRyFEeAYvCxDCB3LLhEpTH7wEToJxTUHNaAkkrHrhw>
    <xmx:Tjy9aRBwv7xQ4yGVgfuc5RARD7k09KQVkAzkkwwbGMDcxh2o-OWbY5wq>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 08:23:42 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 20 Mar 2026 13:23:20 +0100
Subject: [PATCH 2/9] dt-bindings: arm: apple: apple,pmgr: Add t8122
 compatible
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-apple-m3-initial-devicetrees-v1-2-5842e1e393a8@jannau.net>
References: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
In-Reply-To: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Sven Peter <sven@kernel.org>, 
 Neal Gompa <neal@gompa.dev>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Linus Walleij <linusw@kernel.org>, 
 Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1039; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=iptqK0MK2F+9Cab0yWgsD04dQkDPQW6FI8oBI0X4bB8=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhsy9Nu5Xkjm2rVnqrKZcMsNZo0z6ZtlBsWdW1zitZvyJu
 7v8/pf/HaUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACai18TwP2SnW4Czn7fuoe7w
 ud+32KXNCovYf0PP4pt5VVXF7OWqhowM5xPXGW7lPfbXQlHp1LMg92Q2Lgv9CgcVLdtvnHz7NwZ
 xAgA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8301-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gompa.dev,linux-watchdog.org,roeck-us.net,openbsd.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[jannau.net];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jannau.net:dkim,jannau.net:email,jannau.net:mid,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D4932DA3BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The PMGR blocks on Apple silicon M3 SoCs (t8122) are compatible with the
M1 and M2 predecessors. Add "apple,t8122-pmgr" as M3 specific
compatible.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
index b88f41a225a385e68a71de93027b5b62c38d6b63..c67b67ba065afaaccf4436d86dfbac233870d624 100644
--- a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
+++ b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
@@ -36,7 +36,9 @@ properties:
           - const: syscon
           - const: simple-mfd
       - items:
-          - const: apple,t6020-pmgr
+          - enum:
+              - apple,t6020-pmgr
+              - apple,t8122-pmgr
           - const: apple,t8103-pmgr
           - const: syscon
           - const: simple-mfd

-- 
2.53.0


