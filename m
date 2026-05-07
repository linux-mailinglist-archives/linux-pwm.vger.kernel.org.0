Return-Path: <linux-pwm+bounces-8827-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNioB0xA/GnfNQAAu9opvQ
	(envelope-from <linux-pwm+bounces-8827-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 09:33:32 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A22DA4E412D
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 09:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E25103004F11
	for <lists+linux-pwm@lfdr.de>; Thu,  7 May 2026 07:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E7235B631;
	Thu,  7 May 2026 07:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="mQYNSi8F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YfjXnRhT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB02933F8C5;
	Thu,  7 May 2026 07:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778139208; cv=none; b=AyMmIyd2024RP271Z++Y4jdsjhW9/axD5KC0AOI0XaQbOXZSwPsG639VMMXlvUEbhqtvb1YVhTdh8a3ixiNveOZkuQbDvbYr+B1v4Khsl4J+C88zyWKk7tNBUUPWgiinmumXZbZMzLip3sxom4YzzK/nBTdsQ5pUwyqt5mNGVzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778139208; c=relaxed/simple;
	bh=tqRDD38M1lfDTOrUhWfFbq/m1TiGBjjHF1HjCcLG/DA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AL78mfahLxJCa72FVrR28DTk0J3ui2Ee1bLKWOGo63K94s2i+tNMXM/zazdL9Ok5SIwqjAjuW8RmnkRbOELGjoJoZQkox1cLonv6iCc1PkoHST8JVUDTzDVV3xZ19UIpySCOscLLzBEuZKcjh1HSXr/EWkgsn4oYiO/4vMB0DQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=mQYNSi8F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YfjXnRhT; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 435B9EC00CE;
	Thu,  7 May 2026 03:33:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 07 May 2026 03:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1778139206;
	 x=1778225606; bh=DhzpA8NsTz/+V0K0dsPsaOESAJ4FZBxYUWkuaahgCkI=; b=
	mQYNSi8FbVElXwCtBag/AxoCT5bz9DO00U0OfJ5CZsvI64kYjDMs75DD5PsEb8zS
	7CKzwpvsFM3nWTHHVsh+QzcoVo9IVEw7O6osZJVpK5s3mp+edWa6Q9cbweylJGs/
	RFQ5VVf8fVDjtbWyN58vC4l880AZXyq/J7t4+ZyMq3ImaxH1gXGrKQLXA64rZLgo
	zOenhd8UqfTA553IDUqHmQLQCD3FtpcI5bd0ZGck60HIc7Gcw/pbfA3u8NFDGX9w
	GQOF483E2mJV0PhlZXdC1//G7YqMvsVxX1WfxAGaCM51RRbvGAqTbHFQOTtBc1vr
	/mC8XZEB1veV0wQF8pAvWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778139206; x=
	1778225606; bh=DhzpA8NsTz/+V0K0dsPsaOESAJ4FZBxYUWkuaahgCkI=; b=Y
	fjXnRhTXsWGJtFtou/Q7mIxrIzgjPu/MK6mZGX5gP5Uw8Y8Ln1F6y0f75q1YuMJ4
	clybjoG4lvvgTul/P28wxDfAoLmE07oO5CioFGL4Yatcy/tEIL3DrBb7Ii9vo34D
	OdgA9ggcLLGNzfTd+l6U2W6VjlCRQ7eEKy+Lqp5/c0dadAi0G9bx7n0o/hkZwJ2X
	0eIfpLLj7Hf48l/KX7zZsdq88tSLMFJf1mg9KsFTx/gHgBl+7rWGzhL+/5XnncFR
	X7oK/lQACXteKpUPvT5DzChfGEWjHoY1F3m5uQRDIOSN1wb1jAEBb8K1IQEOYcLG
	+fjnLYlmLn+OJYkPvT/Xw==
X-ME-Sender: <xms:RUD8aVN1hVM2vFgKP5I6-GNSokrmaZED2pTRNft8h_IFEoqD_FKJNA>
    <xme:RUD8ac1dkRZt9nTekcSyOgMhAdXuXFajFAvH_2cCuyaVUfLMwMipWebPZ88p45Ba7
    MDDaXRm9Xd0Zgtc5Pf6XIvTbCPlsbGqghQFWkrq5ZFgTno1J5D8ZORH>
X-ME-Received: <xmr:RUD8ac1mc6hUu88LsP3NnQVKnq9k2_8v1iz6QzMtuzz9KfqO6L7FO2CdzeFNAB1Dt8IQ4Xdjkxoa7eHltERGTGCtOQi-V0FpdrU0ew>
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
X-ME-Proxy: <xmx:RUD8aS9Cfs6o150MLaPjLgtpgHJLpIKjdf8pQGMkShi0WMNLF4ahCg>
    <xmx:RUD8aQZPoCkzurQbeR5G2Mue2NfWFkKl_vc_2nqAA_DTqqJsXTNRyg>
    <xmx:RUD8aZzzOyFdMCPVKckx6rx3knJ8flClSoIm7b0po-Gkynl6QAmr2A>
    <xmx:RUD8aW-aoFokf9gloLNDr7BmKDwVf6fT0Lbo-pk94ZoIWSfat3hviA>
    <xmx:RkD8aZ9-qzFasEid6Fs2X3V87C1Z7Uaa04ZCSJ3wmMn0Nw_S5jqopvCm>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 03:33:25 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 07 May 2026 09:33:08 +0200
Subject: [PATCH v3 2/5] dt-bindings: watchdog: apple,wdt: Add t8122
 compatible
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-apple-m3-initial-devicetrees-v3-2-ca07c81b5dc7@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1090; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=tqRDD38M1lfDTOrUhWfFbq/m1TiGBjjHF1HjCcLG/DA=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhsw/DnZvPv7+uCZm4bUNF5PPFwstErzlxLaW9emmwD+XN
 wZ/0Am71lHKwiDGxSArpsiSpP2yg2F1jWJM7YMwmDmsTCBDGLg4BWAiG38xMlxkOl/Yw9zRWla6
 2apgWY/Vh9Nqx9ZK/vq7ytF7+87jQssYGXZu2OcZEz9B6NmCCT5vNtw5udjN9d/UxEOCRzXKmMK
 02HgA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Rspamd-Queue-Id: A22DA4E412D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8827-lists,linux-pwm=lfdr.de];
	DMARC_NA(0.00)[jannau.net];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

The watchdog on the Apple silicon t8122 (M3) SoC is compatible with the
existing driver. Add "apple,t8122-wdt" as SoC specific compatible under
"apple,t8103-wdt" used by the driver.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/watchdog/apple,wdt.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
index 05602678c070..845b5e8b5abc 100644
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
2.54.0


