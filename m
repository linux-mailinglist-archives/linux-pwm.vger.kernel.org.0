Return-Path: <linux-pwm+bounces-8306-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GB59BvU9vWmJ8AIAu9opvQ
	(envelope-from <linux-pwm+bounces-8306-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 13:30:45 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD23B2DA462
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 13:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E18FB30530D5
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 12:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDED3B19AD;
	Fri, 20 Mar 2026 12:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="L7YQO+vK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y5CjvI31"
X-Original-To: linux-pwm@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FB03AF677;
	Fri, 20 Mar 2026 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774009433; cv=none; b=OQIZ9fRTlPmvse6FuTqWMUidEiWjSCzgqu2s9uQmqBGjJijfihoUZ/QSDP1xaygaE6s498ujppurcWlYCl2yti3DefL/x9l7QlF80SY6PAtfIn7freSMMtiOkum5gqEcvpSaUBOTHo2vXyP+dHdrtxe7JuRHKt9RBS4E0GnLoE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774009433; c=relaxed/simple;
	bh=zB20SDXo7O420ChiSg6dYfmEMAcZxJETARGKd8sXk3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gRXyW/xgIzTWp3JVQEPOgATr/ctaVOMJ/kx8rkywa7RX3DZRvGIlXGxIUSFTbzBfVG/wx6z5oCCJAlVjzImSHIsB9SUkhpeGrr/2qEzdz/KtemyfiHFKHPQhwVYxj9fVd+j+73EdNPXNPT7MpVtIc43av/7IV+foaV24VezUumE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=L7YQO+vK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y5CjvI31; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id B7BA213800D7;
	Fri, 20 Mar 2026 08:23:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 20 Mar 2026 08:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774009431;
	 x=1774016631; bh=0+XTcZCzwF0TtKfCncbcOIU+nvHlBtT+9st5uGOxtvw=; b=
	L7YQO+vKUVSvmQG3dUs0DDJIkL4dR9yarwmwGnEEnU/uW1miGOKFCC2bUME169c5
	ZnZ34e1XMQx+fZxLA+lG/JJRZOzde4u55hjNmPgO6gdv3wPiUAnJ/ANLhJPLohdS
	kN1HbZYXFCF5y5Gxu8idXD1Dpaz2xCf/3vxXWauprM72EVwZXBrIDVjMvd8MsCqG
	0sE0TD0d5uUGyero7QIsMgBlMMkkPg9Fdsb3WCSzZHS8kAT8H2qSiLjdkG2euLdq
	zvBJQvWt42m+X693c0vfql4/uad2bmza5PI9HZemMf4HBDa8J+TnQRS8mMz5qyYZ
	qI87Czkxr1El5MV6musvzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774009431; x=
	1774016631; bh=0+XTcZCzwF0TtKfCncbcOIU+nvHlBtT+9st5uGOxtvw=; b=Y
	5CjvI31qsEIfJ+H8Ex/BtDDX5DjyD+D1SfgiY+co5tn2Op65U+Lh4GsHrfsMkalb
	CBJe7HcODZ/HcF3Z1sc/gbTY+t6UWixWkLIfAGfioOL16+hCsZmCDpIGwNVxy74g
	/kHWX6VQg5P8JlBigVarLkr/f5VPQg48ZNYNWlMzePu2Oa3rX/nLojJWJc4oje7Y
	W5bw0MBBlnFTFzI6j1AOUKuAnigX9aikbBAqbkvXxb+dTKTh+plNNQndusqf9ozc
	OxGjXDs6KroZJ7fwlWQRLAqt8Dc07MCPNSCbgtxIalMWIQnePvM7Yqdj61dHAGyw
	9k5fpO4pwjjdYPs0zBMhw==
X-ME-Sender: <xms:Vzy9aQ99ndZDSei_aQFxZEuVaH3atn4PDvNwIhtRGQ07kuE-YRpmyg>
    <xme:Vzy9admsji2_OJMfAfR-FVX8IHTwN_f6vSRPK4Ge-i0VvuWb14iB1ZzEWoDNytzG5
    zGxpz3yLHGCky5HrHTw75aMwxVNf5gxN2O9Yi8U6MDbgeEhyztBwXw>
X-ME-Received: <xmr:Vzy9aTmfQnOOscMZ602NkixgeYJaGFytol9Mar_KWlLe1wjFqO3BJl0S0VoWyTrh3NIkuy0CEucLf46UZWmPWDwP6PlgkFQ_vnb7wQ>
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
X-ME-Proxy: <xmx:Vzy9aSjRmTF9LasMcby1b2dnBzLLCSdZ7LZWcv_DIUzx9jxUvsgZAQ>
    <xmx:Vzy9aUVXkG3MqIQUC1l6NowU6qZQyycI5k0rFpcdZ2uEu5e_NVPmOQ>
    <xmx:Vzy9achto2yHTUygd_iaNxF0p7FTFnvxTkNaUHEh4piCNrhivssDEQ>
    <xmx:Vzy9aQ6uVANjYwzYlmC2UGDJQD8mjrJToIuxFlud_35euAMmgSv97w>
    <xmx:Vzy9aWLO_yCy8RP3TSF_BzpA8zTlJ5hHyywJJZn_By3gcPMsTdGL-qqR>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 08:23:51 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 20 Mar 2026 13:23:25 +0100
Subject: [PATCH 7/9] dt-bindings: pwm: apple,s5l-fpwm: Add t8122 compatible
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-apple-m3-initial-devicetrees-v1-7-5842e1e393a8@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=951; i=j@jannau.net; s=yk2025;
 h=from:subject:message-id; bh=zB20SDXo7O420ChiSg6dYfmEMAcZxJETARGKd8sXk3c=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhsy9Nh4+i283vj+544vVnJsdhZmmczrMM68k7xD4HvQ8d
 5Lrw53CHaUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACbimM/wz2737IqgP8ubtk9o
 WS9/yYq3sH/Bc60nx36vZbW/zKR4cTkjw+ZnLpe7eN/PktyYe/PCUhGFMAeOn84ndFLtn95fP9W
 flQUA
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
	TAGGED_FROM(0.00)[bounces-8306-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[jannau.net];
	FREEMAIL_TO(0.00)[kernel.org,gompa.dev,linux-watchdog.org,roeck-us.net,openbsd.org,gmail.com];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AD23B2DA462
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The PWM controller on the Apple silicon t8122 (M3) SoC is compatible
with the existing driver. Add "apple,t8122-fpwm" as SoC specific
compatible under "apple,s5l-fpwm" used by the driver.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
index 04519b0c581d0e9fb1ae6aa219a4e850027de6a2..24a71f21c7af0fde4ee6a11e49179b004ba1b9c1 100644
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
2.53.0


