Return-Path: <linux-pwm+bounces-8300-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMtDDmU9vWmJ8AIAu9opvQ
	(envelope-from <linux-pwm+bounces-8300-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 13:28:21 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C002DA380
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 13:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27E283111E8A
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 12:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8393ACEF0;
	Fri, 20 Mar 2026 12:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="JYn3mUVb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I4X4wW+U"
X-Original-To: linux-pwm@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A835C3AA509;
	Fri, 20 Mar 2026 12:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774009423; cv=none; b=sOUdPjjNQVROAH1HePkfqyTnx+6MxuavGGUedDeimMarEKTHCvhvtN3l/GdenLTPr+Q1iHEZIV+bO3LfZ1qhxRd9hS3/ca67tXooSeVtI0u0z8+cN7a1XHZbqGs1OmRySTuE5tzuFe/aKoe9fJdPatjMPkEHH1PyHJ2YiThhklE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774009423; c=relaxed/simple;
	bh=wnJGrb1D5sklE9ktZIBz/FIliktYpSP1dImVPMP5p/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QF/FLn95HZ9VbJ2t4ODgaltIoskmf7wfn9SdeL/WSEbiZYBX6ZYojl1DbFkC76Mq926cAxzbtWKAcfn6db/tr9hAPxfQSmtDgCIUgd/csoFAuXtOl/6CHg3gLj++j3QE1/rEQancPzOmf+3+mn+i01YqnWI1EfhVAmAhqyFuzw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=JYn3mUVb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I4X4wW+U; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id D999013800B0;
	Fri, 20 Mar 2026 08:23:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 20 Mar 2026 08:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774009420;
	 x=1774016620; bh=EqID2YyqE72b5OAwRBciwOdkk06DGeqd/D/N5LXJySI=; b=
	JYn3mUVbL1uqGpp416tfsqTgtGzVDWDbrYauKszI91LhU465VSD0p6CGLKgFN1AC
	6cuOOiSooYGXpwcAjE5oak7uzCe4f66XtK3KrLe2liCIOUgrLpVkfGTnPIJkItaG
	igP5O/IEOi5vfpGaYTXSFkqHeUyOgVdKi2jFUippWjpA7sQUvHNLEfdKuscq0sQS
	TNA+H86ZDZdC8eToVcSchQvje70BqFC6tkxLY5mwZmpTFUIR6Y9sN6YlyB25MJ74
	2Citr8TFghb5IpddT1il+S8Hf7hcg4wZtsVz0suCN2ByWFZBZn6ZnXMxPPmpUBZa
	JdsGONdtk0+/p/LAe5RpIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774009420; x=
	1774016620; bh=EqID2YyqE72b5OAwRBciwOdkk06DGeqd/D/N5LXJySI=; b=I
	4X4wW+U8x/RdyF9t8OL8GvCtUNCrdr5uZ57MbnDtr/Fs+FAP1E/YyDRG5OXunIan
	58Dn+DL0sCOBBuEnEGrGgv22wESIwj4fTcSFgL573wu5spxnAfE4btlIvaYWoiib
	CuxaZ8wKy4stmv1GmIeYl+3FJyH8NzasQrjQfJXZHSoY9KI6Fy7+oOHysshd+EUc
	YngOtrHhBsoXbfxKC9JxaBObRR/yQhJNZkRFvoff/dzzRqXxkSVpuch75D9oF/3W
	UJSeykiOGhqUI2XHFBSLaSNrmNgMK7OJflt24TcjDlNoMiyTuLg+wr8RXvF0AxNX
	N9GUZ7zCx5FV/dNTxTdqg==
X-ME-Sender: <xms:TDy9aX5sPc2_uOc2p5a2qwUhAqUPr2SD_qhVMjSovuypv7DtBLHAZQ>
    <xme:TDy9aXp29DK2qdm8ZXsI8tAK5maMj5ftDbiOpiGiFDaj_TDdndLElISS0StDij5QK
    CsB8fi8JaRUjh-R5YMoXLYPQ9MDbf8bQHimXPJa7-tFc5_RM6PuGs7O>
X-ME-Received: <xmr:TDy9adXdomVWeMEq0R7lFJg74kVu7Fiy5gno5bkweHQyfuHhCwxcpU-y1c9H9MOk_8KDNslfEXn66x7X2ruU93EfENJEbxyXxfbz-Q>
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
X-ME-Proxy: <xmx:TDy9ae4qSmwYjhucPubgpLeOrIZZi59ogBuzqkkP29xVWQKkSd8bJQ>
    <xmx:TDy9ab1iuIMnCZVj_gKnIqFcfHxT8CgLh5Z4v47JlmPehiEv90j1WQ>
    <xmx:TDy9aV8YMfP7I0-IM2kKwatCmBSmyyYNBTn25bsUBgk1jUArPaB3Vg>
    <xmx:TDy9aUvLPPMv-Bs53O7haGLTLyNKNvR1dCSIIzA3Yo4xq-z7jNx-nQ>
    <xmx:TDy9acsoAKMl5yQVKrCdaOs0I6GyVSpQHeQy7PDTCvpSOJ6-AGAVOi6d>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 08:23:40 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 20 Mar 2026 13:23:19 +0100
Subject: [PATCH 1/9] dt-bindings: arm: cpus: Add Apple M3 CPU core
 compatibles
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-apple-m3-initial-devicetrees-v1-1-5842e1e393a8@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1030; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=wnJGrb1D5sklE9ktZIBz/FIliktYpSP1dImVPMP5p/4=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhsy9Nu7nfVkahaLeu70qZu9J5p+RcfGI8FRD1pV+s6qcH
 Xeab1XpKGVhEONikBVTZEnSftnBsLpGMab2QRjMHFYmkCEMXJwCMJEv4gz/7PhTDy5880zVcvOc
 /oL7tmwOdyPmG701/3M0In69oPHf0wx/xa+YvVFgzzkVLG7xtaPEsd/30fzirYzax7Of/QnKkVv
 KBwA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8300-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gompa.dev,linux-watchdog.org,roeck-us.net,openbsd.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[jannau.net];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: D6C002DA380
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add "apple,everest" compatible for the M3 performance core and
"apple,sawtooth" for the M3 efficiency CPU core. These CPU cores are
found on Apple Silicon SoCs M3 and M3 Pro, Max and Ultra.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 736b7ab1bd0a0235527de8e63248f8e070e15431..e1fd73281657df25316449dd8c5c837aa9b4b27f 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -85,11 +85,13 @@ properties:
       - apple,avalanche
       - apple,blizzard
       - apple,cyclone
+      - apple,everest
       - apple,firestorm
       - apple,hurricane-zephyr
       - apple,icestorm
       - apple,mistral
       - apple,monsoon
+      - apple,sawtooth
       - apple,twister
       - apple,typhoon
       - arm,arm710t

-- 
2.53.0


