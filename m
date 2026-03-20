Return-Path: <linux-pwm+bounces-8307-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENlSHno9vWmJ8AIAu9opvQ
	(envelope-from <linux-pwm+bounces-8307-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 13:28:42 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3292DA3A5
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 13:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C73430900A7
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 12:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EC93B27C6;
	Fri, 20 Mar 2026 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="dsDomXet";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k0Y7z0Uy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265FC3AD510;
	Fri, 20 Mar 2026 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774009435; cv=none; b=XGA61eUxhaBoB3Lh1FEc2haJNF7IEjnjZDrl1d9X/fvvFnh9GBaiH++Ov4KV1PqtQRojAtRHr5ujfxgOi4cKM1ytSSTGK49db9yx3BHf5NNuR40TG/ubazP+awF5zA+6k2tTTuu2ypgrUx700qh6WuZWTu9B9CutxoD/atB0Wto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774009435; c=relaxed/simple;
	bh=SJxxfLf8m4pPdoRRfrkK/fh1aBM2pnBwzbyh0xmav4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iySa9V6Gmj7FOOyQ6xnZgYPDauuFQ7aqW1YA1hTzQhPHq0BDL3RXZhS+B7WO/rY7lj3hL9TrwM/qklZJUUi7Py4TgY0r0hxyVERh2yPP1vM+xJRtChhm6SUI08RRkEfxDwyP/cxKdX0t8y8TPuABJyloPXkZhDMNZADFtzUJgM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=dsDomXet; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k0Y7z0Uy; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id 8B3BC13800B0;
	Fri, 20 Mar 2026 08:23:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 20 Mar 2026 08:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774009433;
	 x=1774016633; bh=nCl0V+SQBcpw8bxOLxB5y2YcMK1hGGMyaZ23lgQY9Sg=; b=
	dsDomXeti/l96cSgE5IB3L4xFY9rH3uNeCc0QDJh/wHLl2xHjj5ofTxOMe4gaZ5N
	0a2apfx9W4z/yVDlW0fKh1pKARckt7rr5zj5VrSpmqmTen+e8sAEqZRdNbJRH35O
	2e6tGra3jAwH2Nd5bKyryxw+x77pHG90tJuy71ul0XuUbEa/vyK1C2WIHPnbvZqS
	6gLMKRAjtwm8JxD7p20Z+sxsrdP3xb1qGQN5gNnRfMi8pHLoX1WDVo+1LyQI4OrQ
	9fmUBauhP3kOO/+agY/Nyr8Airb2vKZo+uD0FGP9UxshGEX4tFpGxJ62BlKdX/j8
	3SCqIGe4FSasO7C3P8NDZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774009433; x=
	1774016633; bh=nCl0V+SQBcpw8bxOLxB5y2YcMK1hGGMyaZ23lgQY9Sg=; b=k
	0Y7z0UyD+x0VM/KcjjUvpNRgZgadwmRmD9nSKxtFpMXtlRaXwNqQJUMaE/Rx/pmH
	AxdK/VupPsApK5K5u31lA41KqVmFVdFw0yVSosg24dzqvVBtmG1VVVrmq+ff45Bt
	YNRWMpwGGbzdFiuj3lMy1p6yGplpAV4swhy4h9AgupeVOl1kO4iKewH84TO8diBk
	ECN0JkL11w6PB7hRqs8UklU1ebt9xr4xJkpHYnhyIjryVhLIE/UGabNehdRo4SH8
	vnvBS27GygtCyN3ufLixGQKWUQ39sKDtQTlmgAZMJsIOR7Cea38dX4Z7Nk5xGxFJ
	fXdpuW1lQ1PdV6dUfHInQ==
X-ME-Sender: <xms:WTy9aeJSUcZGrKpn_cuvoouEW9hSaj3ewFcgiYALxCYmMtA_Xh3aQw>
    <xme:WTy9abBJwOdHAl_xH1tW-3Pz9oo82RgE24lZViN8ngScSdLyXlAJCAOffJhGGnLjC
    8x47ueu932YBxYroPnLlm1de1Fqg1tAEkHR5j01LvRm-u4GZFsepSU>
X-ME-Received: <xmr:WTy9acSQf1W-8xehAin4vi7k7q5MN1efS_6ZFZdkK6DtsciwljBqwIZqhfiEUrzs2idH8EkzU7mL1xQMY6e9H0zQj8k2v9lZSUvHkQ>
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
X-ME-Proxy: <xmx:WTy9aVeLs3zf3MWp-10xJ-XIsJuPj9moS2S3vUb_ep71M5En8dOXdA>
    <xmx:WTy9aUjXHuopH84Ojt4jeIrGExFQyUbH8V11S4suSRs2T1eFvvDx3A>
    <xmx:WTy9aQ-hFhljjtyCWMfi34LnACh_I3Vxqhb-Kb3VTOIlxB2JWDSeYg>
    <xmx:WTy9aUlN58d0yXb8laa7mtyoooQZIiiRxUcOeN_Dg5MoekDiXMOmOg>
    <xmx:WTy9aaW7u0nfdHqbKMISN7dg0pP4zMvkc8XlT7MTL_1ACecG1lN1JeSc>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 08:23:52 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 20 Mar 2026 13:23:26 +0100
Subject: [PATCH 8/9] dt-bindings: arm: apple: Add M3 based devices
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-apple-m3-initial-devicetrees-v1-8-5842e1e393a8@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1854; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=SJxxfLf8m4pPdoRRfrkK/fh1aBM2pnBwzbyh0xmav4E=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhsy9Nh5sWw70v5u3ef/J0GUrOe4Jr+poNK4x8tkicO6a7
 U3JrSFSHaUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACby8gUjw5z95jqznuk7T1m6
 yMhHbHteVdlDy9I95xgXNjFy94cf+sLw33Nu565Hx/1kZzhJvlTdkPE6iucpt6SK+OaDFqlq90x
 ZGQE=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8307-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gompa.dev,linux-watchdog.org,roeck-us.net,openbsd.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[jannau.net];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,jannau.net:dkim,jannau.net:email,jannau.net:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 2D3292DA3A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Apple devices with the t8122 SoC (M3) are very similar to their M1
and M2 predecessors.
Only the 13-inch Macbook Pro is replaced by a 14-inch version based on
the design of the 14-inch Macbook Pro with (M1/M2 Pro/Max). The Mac mini
was not offered with M3.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/arm/apple.yaml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index 5c2629ec3d4cbcee49d3ff6a4db1cc8298e2a2e1..e49403c73f9d2efe7066f7c1dca18fc7987dc885 100644
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
2.53.0


