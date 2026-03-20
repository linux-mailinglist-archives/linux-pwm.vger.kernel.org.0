Return-Path: <linux-pwm+bounces-8302-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNdiOVs8vWkH8AIAu9opvQ
	(envelope-from <linux-pwm+bounces-8302-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 13:23:55 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C92DE2DA1CB
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 13:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59CBB301DEE2
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 12:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFBA3ACF1D;
	Fri, 20 Mar 2026 12:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="P/jF6g1i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e0J+xu6w"
X-Original-To: linux-pwm@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBA73A963B;
	Fri, 20 Mar 2026 12:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774009428; cv=none; b=fxFBlq0DHJvPYRzAo4zkJ7NMWHueUipkk/b18RoSf4iPxQyFhe1SBTzfDs0MwKhETbR1+cPD05TMNl+UICDwn9Zn0fiLSyJSllhRebwsG7WpDPRVvc6bnv5JrqPYkM2+oJgxd/GxUvJu2KWFpaH1ADE2c/EeBJitIzHxjWBQsTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774009428; c=relaxed/simple;
	bh=buUyVcCFVjI1/V3twfbMcvHTmryX5ia7raHBMXtClws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g79SOPwQC9hRJXKO/3BM3jU3GPNm3eFCxfCUwrjfF2u3D5O4bBtsjEMNi3WEucQj731ApKAKt7NNofdoVTzRzWKVMLWG/pP+FZwtaobmZWhX3ioW+3R96T7Po3gY6GuQgO+j2bBOmpBobyM8W4mX7+dNE8DtX3y55/r7v3nCt1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=P/jF6g1i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e0J+xu6w; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id 53BF513800E5;
	Fri, 20 Mar 2026 08:23:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 20 Mar 2026 08:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774009426;
	 x=1774016626; bh=3g7hbu3raybG7hQlze0jpgiIENf9F+/i6CskYtxMfjk=; b=
	P/jF6g1i6F6mP9ydrnZkQVxxAY/rjA70izMWCCpC3YWfvj9mfjPSkKlCwiWawpIa
	Alv1iOwhpu8qgKYjJTz3ZNNGzMsA3wstJxt2NEbq2y5twOF5IcxSKIGqypYzVZ/0
	20NkurniG6ee+fadbCpKdnw43SIXJdoftySYlwAWc3qmK463SxgAgAGxTEi4WKzc
	Wo0spH63BFqcbJcVFHiDHPsO/d3LuqoT0VnME88n8A2YyW4c7ZYZof8ZZd/Z7adq
	cPIXZN+ktPPXjNzXCQaRTcPano1fQzphxRjDCB6ycMnEViZ6vd3vYaSWfOHbOT/u
	fnNks6exEFvChxmf+vEw2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774009426; x=
	1774016626; bh=3g7hbu3raybG7hQlze0jpgiIENf9F+/i6CskYtxMfjk=; b=e
	0J+xu6wPm2q5c/x42y/DKQBscVE/4gXlq+/8ABznS+yPhidiFrskvN1OzAKKWYAc
	hvbOpUD0vGfDT+R9rDN/qOHfdYnkQKJqbeiKGChRUZb6mZdevNR0byDRvSncwuN0
	SjVxOFTdFdngZjyADldO/lvpxP1Q/6VaVkXvg9gMiU6kQT+XTxJ4etPTQRbQ+tc6
	4Gm6hyivsrwriGxq3Dn2oQ0TrP2vrPM30yxGrRJfTCE/WU3r9UBdCVGvqJOW5dml
	7ZFfRfrv8OGT0M/3VQ6L4z6JPxdo7Uh1Cbvc6OK+3vS9sFnovIxPBRGxP/3iS8Zx
	0Yi8oL/R8FbXB4iQ7qbtQ==
X-ME-Sender: <xms:Ujy9aV_GkPjaZZJ6kGaAgwXc0-jEPNCD1oSJmwFzIScInvC2Fyfv3w>
    <xme:Ujy9aenDwivqaqUMZUlDj4DBSu8nDLCG9fDYsgDplQv-BxA3hPpFRMtLwHkGiwsll
    M54HZFLnrqMP6tm2mea3MSoMO98Ejjs12ooIJUN66b_Zf7fdJIm48I>
X-ME-Received: <xmr:Ujy9aQnR6J4Ayrp8d307keuthEs18s37vaTFlS010alFpmszyJwyaRAQmU8USja-nDaQ6xQSBladbyGq2QAqO6-jS5TtTR8hwpRQEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgv
    ucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    ehheeileduffehteeihfdvtdelffdutdeludduiedutedvfeffheekhefgtedtnecuvehl
    uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrg
    hurdhnvghtpdhnsggprhgtphhtthhopedvvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhinhhushifsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvggrlhesgh
    homhhprgdruggvvhdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgr
    uggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqghhpihhosehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepkhgvthhtvghnihhssehophgvnhgsshgurdhorhhg
    pdhrtghpthhtoheplhhinhhugidqihdvtgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopeifihhmsehlihhnuhigqdifrghttghhughoghdrohhrgh
X-ME-Proxy: <xmx:Ujy9abjm3WPPxN_TppajoODw0_H51IFFiN7tZEw47aDNryNO8w15UA>
    <xmx:Ujy9aZXlrMAayhkAtGdpzxfnKCFcutJGnaU_Aty4fuYwwfEw27-6NA>
    <xmx:Ujy9adjlZwlA3J30QoCcEGtTvOVgsf4IPdkp4D-PNlB_FOrODR4Ojw>
    <xmx:Ujy9ad4smtU6uX_XjOUpPiwhnk45zPKG-2OoNChhQ6jh3aSHhf7Zwg>
    <xmx:Ujy9acYn_DJWf30AAwOE0wJJlVTafcfOeCPZN5rC8JpYYsYyZkJqyaFd>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 08:23:45 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 20 Mar 2026 13:23:22 +0100
Subject: [PATCH 4/9] dt-bindings: watchdog: apple,wdt: Add t8122 compatible
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-apple-m3-initial-devicetrees-v1-4-5842e1e393a8@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1006; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=buUyVcCFVjI1/V3twfbMcvHTmryX5ia7raHBMXtClws=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhsy9Nu6nIp7/W3c9MGHaW/aYLZ1Hm2YusEl2TOzOnHGEy
 3Ipr+H8jlIWBjEuBlkxRZYk7ZcdDKtrFGNqH4TBzGFlAhnCwMUpABP54Mzw3/djBb+dCbupb5Te
 qq0LrvTYisaxNUacYvcNmffvpalpPiPDLtarofpTLv88K6v3v/Jx4q4Hddc853Y92mijZ/Zjdf8
 sLgA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8302-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gompa.dev,linux-watchdog.org,roeck-us.net,openbsd.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[jannau.net];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jannau.net:dkim,jannau.net:email,jannau.net:mid,messagingengine.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C92DE2DA1CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The watchdog on the Apple silicon t8122 (M3) SoC is compatible with the
existing driver. Add "apple,t8122-wdt" as SoC specific compatible under
"apple,t8103-wdt" used by the driver.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/watchdog/apple,wdt.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
index 05602678c070d764331795f6df91abbc55eb0f2a..845b5e8b5abc33fdf73f71b203c527025d54f693 100644
--- a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
@@ -16,7 +16,9 @@ properties:
   compatible:
     oneOf:
       - items:
-          - const: apple,t6020-wdt
+          - enum:
+              - apple,t6020-wdt
+              - apple,t8122-wdt
           - const: apple,t8103-wdt
       - items:
           - enum:

-- 
2.53.0


