Return-Path: <linux-pwm+bounces-8828-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLzOHdJA/GlMNgAAu9opvQ
	(envelope-from <linux-pwm+bounces-8828-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 09:35:46 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D1B4E4228
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 09:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 478743043F83
	for <lists+linux-pwm@lfdr.de>; Thu,  7 May 2026 07:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF18835BDA4;
	Thu,  7 May 2026 07:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="U5YaNNGd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BWYPxutg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C5135B654;
	Thu,  7 May 2026 07:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778139211; cv=none; b=mtZO20aUZ4/ji9MB28O0+Nd/BbC2P+Rh7McmMPsxRcXTJvHoUls1OMSONNOwqWuvEJPqg7Sg96XMrdZEM4bnVpB8v56Cyo8E+VNrYzuUiMwhinRVfqrsStfomqyjtUi13IXFQLGo6OyVkVZKifv/6QuNtOXgFw//pr8IPsh1yPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778139211; c=relaxed/simple;
	bh=gUN8s2Ri7zG9BdlChN+PUyMx26oLN03c/SpGRdRYMTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=irzuKLCe3+ER7OfHbkhhMFvMm/qp4h7is9V1aymmRH8zvMHUqf5YsXUCwbt0TU4VUbQqAEVhR7sGs5BwtjTiAC/V5oze67dmgvxdgeYDycy6Eik1hf9sAKdJs3E7xfQWHXv9YsZBKoGSSIQYmXNCq6avvxNKOwyKR9uiDlv3t5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=U5YaNNGd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BWYPxutg; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1CDB014000BF;
	Thu,  7 May 2026 03:33:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 07 May 2026 03:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1778139208;
	 x=1778225608; bh=U0DLBQ104H4pRJmAnhQAaxKxLWgSeWObdD3M2XI1ycA=; b=
	U5YaNNGddboE6bAKZ376AARROX4Y3BxGHD1pPJ6l0mOFrcH/8Fskvv9LXWF9WMj6
	KfzJlSIkpOc411Fy070L4yw6dRA4gY4PrYKi4xL6B2fuFv74HU34197CLzWxWOqk
	xl3J+IzoiGmXZAzjKgYmdmclL+gIU4YtXWuL3EoTczm7EFoZoEJamSUIbyjrTlPn
	gD8n3dybwmofsZBqj4rXCoyVOS9qufR8c3/Qbm4RLz8nHKw+UNoikvsK0dOkGAE4
	IoySreYNncDO/+9Bv6p1JgsyzYzRPh+vgi8aNcFFc+zA5T7yhaMPi3nD2onPUAI0
	oplTuMw/VuTE36sQWJd/7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778139208; x=
	1778225608; bh=U0DLBQ104H4pRJmAnhQAaxKxLWgSeWObdD3M2XI1ycA=; b=B
	WYPxutghXFvpUGV6Udapz9Pqk5gIRztxFWgpcNQ985LuIIg/ZkbU6320vIh9J305
	5AnU1OUXR60Bjn6Qekxve0yUKDuEyUHPjspMbO0YBHA1nTOcMx2xyIo8xBcDbfGa
	hP/pPsfD3AbB9p2X1rDttdG9ietnKQURW0KcU6AHsptgM8WK4GbwI3ccYT/grBNF
	29NB3KNTFr5UOeT8Iqw9j0IhpiaqOGaQENt/NhoOyK5mp/2h4WUgdrfQM+Jvr54U
	1VD4HM4QvStlUzNBUb2cU+B3OM2gmxTOgluIIA8+94pJqrC2FUQl4Vl5U/cgOP6q
	hjrkvpGRqOwAOwqLVYirw==
X-ME-Sender: <xms:R0D8aZJcr9dek-cMkGyKpR_vxiTyA9UTpBWOYwLiVo1GzQphQVIvMw>
    <xme:R0D8aaBtP9KguDfYptjpduN3y21MkhtUD13p_EN3eLpOdCGSr3LYwVS4ALYiAa2M7
    3RvhT1yxh3d6qsS9m8EIiFpJ54gnaPL9GsyZAjWo0_Tj_gD3fKoA3dl>
X-ME-Received: <xmr:R0D8aaS1S4Sbw_sVT2uDkhlsKJx8aoJ-uR7cFPgIrekLTvdY_He2yS-klo7e0ypqryVJzLSL7VRLWjPNh1pFHvotUBBgzsEGAOho4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdeikeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeflrghnnhgv
    ucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepgf
    ekieetieeltdetieetfeevieejtdeileelieetleegjefghfejvefhgefhvdeknecuvehl
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
X-ME-Proxy: <xmx:R0D8abr9oOBYNk6bMqiPlTk7yBD3zNgv0q4DRYKTC3TWt79lPX4brA>
    <xmx:R0D8aTULDYVZ71zrz1LEP3cwYRW7VIAqtKYX6xEWwNoyOD2SBVnFQg>
    <xmx:R0D8aZ9N7vx4vdaWGPYARKVc-ItYHNLDxG1ku89K6AZYni6iI5HBjA>
    <xmx:R0D8abafM7fJ73pf3DdrQa7aAqXguADL4DZME12wB4rPmj3ejBzeJw>
    <xmx:SED8aQIs9mJTv8IKh-rZFUgKyCxb2bJexhdTd-RnHzC3ZeZD7K1BG-Im>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 03:33:27 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 07 May 2026 09:33:09 +0200
Subject: [PATCH v3 3/5] dt-bindings: pwm: apple,s5l-fpwm: Add t8122
 compatible
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260507-apple-m3-initial-devicetrees-v3-3-ca07c81b5dc7@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1086; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=gUN8s2Ri7zG9BdlChN+PUyMx26oLN03c/SpGRdRYMTI=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhsw/Dna7Hq8Wnz1FwKF59hOrbW90XTir8vazJM7iaBN78
 OrKwnmJHaUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACayvZqRoWHKrtJdfo1Jahyu
 CWl35jZ8a2jLPPgrndM9p5N9momICsNf0YqDy4r8GKyFOYNVI/6Khulf0dnBmuV3do3P3VIvzxZ
 2AA==
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Rspamd-Queue-Id: D0D1B4E4228
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
	TAGGED_FROM(0.00)[bounces-8828-lists,linux-pwm=lfdr.de];
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

The PWM controller on the Apple silicon t8122 (M3) SoC is compatible
with the existing driver. Add "apple,t8122-fpwm" as SoC specific
compatible under "apple,s5l-fpwm" used by the driver.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Uwe Kleine-König <ukleinek@kernel.org>
Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
index d8f4f9ffe884..25ef04b60ca1 100644
--- a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
@@ -18,6 +18,7 @@ properties:
       - enum:
           - apple,t8103-fpwm
           - apple,t8112-fpwm
+          - apple,t8122-fpwm
           - apple,t6000-fpwm
           - apple,t6020-fpwm
       - const: apple,s5l-fpwm

-- 
2.54.0


