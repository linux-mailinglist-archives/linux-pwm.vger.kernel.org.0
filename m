Return-Path: <linux-pwm+bounces-8304-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IMnOSk9vWkH8AIAu9opvQ
	(envelope-from <linux-pwm+bounces-8304-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 13:27:21 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EF12DA304
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 13:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E098130795CF
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 12:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABAF3ACF01;
	Fri, 20 Mar 2026 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="kxqkGfoN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WfqNrALM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7113AEF34;
	Fri, 20 Mar 2026 12:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774009431; cv=none; b=ACQLlYBhc0s+3DzQNlZRM9G1LrWRx6KP3orGU7OwhYlJD5wM1uaH7eKYwItn0ypqThTqV5G44G9dnjSOdRfeEoyEfu69sUF0WZdhsfepwdf3OlNgbnF+TnZETIXDZZM4N1KPylbT+Ln/A29EScenQn61P3cAx4hwz+s1wHIFleA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774009431; c=relaxed/simple;
	bh=eBMmaDJ/djXSONMeeCKnBnkO4wJ1J76ZtSepqcRlrt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lUDSNiMFX5zLevwcjxx7LxAMFOCfOrRXH/mWwwsfMI6/n3dMQ6MDmU7V6OooL8WzUJHShcT9us6jpLgIHMeyZt8yH+Frlmfje6KN7UdwSQi22I2lwejQPO3mKcAStjkJ9bcA0keU33nD+jnJG+gsCz9LoEnvmPpayOkDinGzJFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=kxqkGfoN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WfqNrALM; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id EFD0513800EB;
	Fri, 20 Mar 2026 08:23:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 20 Mar 2026 08:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774009429;
	 x=1774016629; bh=DvlSLsOg9rAATuQvp/4b0bNk+5Q0SCiitC0H9DNdVRg=; b=
	kxqkGfoNzJ1Nfkysg1t2YWFBtdrkKtAXajLr19o5yTV4uNR7b3WUaGHCKiItMfPw
	uPFaeqE1qJEges2lPjXVKzEvEAuW6Ec9QAq15GE4uFw7GYjKCi6A/2Pb7IGC/rr5
	zh+//Uxkow/WU+Bm/zLJAS9ELyPsbOW8K1s7z3z3OAGQxyC9FvLPT5nIlxOkFltz
	UTHeLaIdB6vOs7wK0lfJ751TpaCEubXGhcIEmciwpnMN59vXQ5FsWjRfJtw6NqFA
	QywQat+7v6f5kV+lPcHgLpE5rO4DJhK8tKvqX+idg18V1cdVjS7MFC4ciSllk9M/
	7tG/jxOw5WBJVzYztzkWmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774009429; x=
	1774016629; bh=DvlSLsOg9rAATuQvp/4b0bNk+5Q0SCiitC0H9DNdVRg=; b=W
	fqNrALMH4jlRtBaBnWxxlXJpOm1j6RC6UUVfl669L/LZX690Z9vpIKibQCw2F4fR
	hIBEdx4OU89DKQr7FwIVxLUJIEyGgNMMPrBYJEZzxK2aalOYRN/RqFevg2ui3hlf
	bmgK8HEOvGeZurnEz8r+fTT4CdyIWEQnbkSy1eAfSjPGq7i82OoSwTYnd3YhVPoz
	NngU1gc4lQSxKyeQANeiAFxcO8tjISlenCqirwu5jnr20zWmRejsJKhZhSCkRyJh
	8xAMAsbqzMM6h1giX/JYcDTbrXrSxY+4p8HzPEn34hfxn/OY3jLVFYhxrAMkFydI
	GteExEfVfGC/WTM/ZsQlA==
X-ME-Sender: <xms:VTy9aebjw2LNMQJXGQMWZcArKawVrtQjgmNmumFvXDr6yZj0f_N-BQ>
    <xme:VTy9aWSggZq7pGzGzIdgGu_xDbhaDg1XflVT6fDMNE2i9HAoG07liqXCU433AmxRH
    fFo2sfko9evmDYOXP-mVFsVj15SUQbGTD83ltTrW9pIFq_aY5Rd7dk>
X-ME-Received: <xmr:VTy9aWgzpyujsqdgdC0hiJkweu8r2ZPPIXRX5GQqCblhrkt1tDFL8tNe3sDo1Nz7bBNPP4ikUGnla4GvS8e-LcOXemDNEgQlqjIbwg>
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
X-ME-Proxy: <xmx:VTy9aSsj424flPXKykjrHkK-jJe-ctDGlo25aXhVwT9_FgvzEeiMhQ>
    <xmx:VTy9aYz0OprbOQVwkF4uGj0R93G2v1rAL91zaL0TBwTmXpxMmSZv5w>
    <xmx:VTy9aQMvCkotxZ486VCWuE62iZIPPD6VULDWPEjMtEwGrOFjX2nnLQ>
    <xmx:VTy9aS32E-ZcT2nqC10JayjpWGqkoadP08uEcGqfCH9MSjootdigRg>
    <xmx:VTy9aXnSPeUSvL6mCP49a2gIPMhXctaKYkf2i4MOjuD-sRamR1ISVo8i>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 08:23:49 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 20 Mar 2026 13:23:24 +0100
Subject: [PATCH 6/9] dt-bindings: i2c: apple,i2c: Add t8122 compatible
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-apple-m3-initial-devicetrees-v1-6-5842e1e393a8@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=983; i=j@jannau.net; s=yk2025;
 h=from:subject:message-id; bh=eBMmaDJ/djXSONMeeCKnBnkO4wJ1J76ZtSepqcRlrt4=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhsy9Nh6esY6yNj+VJ69fPWP9zOkpj+tjdhvavZ7j5yBsd
 N9i7Z2FHaUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACby2ozhnwVf3s0tvhaGDu/+
 FxsdFNij0fyvqVuw75LX1tVqAuY/lRj+GZW6Hsq6sJx9T6XV9uvn41cmTjXovCwtl/7+7qal69I
 quQA=
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
	TAGGED_FROM(0.00)[bounces-8304-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim,jannau.net:dkim,jannau.net:email,jannau.net:mid]
X-Rspamd-Queue-Id: 91EF12DA304
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The i2c block on the Apple silicon t8122 (M3) SoC is compatible with the
existing driver. Add "apple,t8122-i2c" as SoC specific compatible under
"apple,t8103-i2c" used by the deriver.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/i2c/apple,i2c.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/apple,i2c.yaml b/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
index 500a965bdb7a84e4997b52e8c19dcc1a7ee0cff7..9e59200ad37b63eb6f00e1e219c53bcb3f7ee402 100644
--- a/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
@@ -22,7 +22,9 @@ properties:
   compatible:
     oneOf:
       - items:
-          - const: apple,t6020-i2c
+          - enum:
+              - apple,t6020-i2c
+              - apple,t8122-i2c
           - const: apple,t8103-i2c
       - items:
           - enum:

-- 
2.53.0


