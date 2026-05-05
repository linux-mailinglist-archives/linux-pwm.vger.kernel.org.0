Return-Path: <linux-pwm+bounces-8774-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFZKK+bR+WlHEQMAu9opvQ
	(envelope-from <linux-pwm+bounces-8774-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 05 May 2026 13:17:58 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A264CC641
	for <lists+linux-pwm@lfdr.de>; Tue, 05 May 2026 13:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74940311CC3F
	for <lists+linux-pwm@lfdr.de>; Tue,  5 May 2026 11:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA5E439006;
	Tue,  5 May 2026 11:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="lW+u5u4T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i4mAUx7o"
X-Original-To: linux-pwm@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1F6438FE5;
	Tue,  5 May 2026 11:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777978991; cv=none; b=QM3p08RB9CM6OWcsfnz9FMrz8zHbb7M8vn9T1NtWrvsvVzXzEs7OnAmY7LmD1rhlyhqebn+iZ/0mZ+CFotmSN78LFOhnMJKgcOptlXOa6nmn76yMIhiKhnwlVAkGy0BFPQphIdVNTut8OyQj7EpqBs9rIWQk6NGgzHpPasWjr6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777978991; c=relaxed/simple;
	bh=tqRDD38M1lfDTOrUhWfFbq/m1TiGBjjHF1HjCcLG/DA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qYfg1Iz+DkcnKem4bn2IL/41KrjwgojYoWVAzItIvTYVls3HiiGyvc6ehvRG+tGnJeJGp1qE2f+Mkp3jZpRX3703uo3sobwsv0mYeGygTtzN0GO8gm6PtM+QFJElN+FOM48dSmo4X9iBpE+vqTh0jk4Q4QXTrcGw4XS4q7yQyE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=lW+u5u4T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i4mAUx7o; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 333B61D00022;
	Tue,  5 May 2026 07:03:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 05 May 2026 07:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777978989;
	 x=1778065389; bh=DhzpA8NsTz/+V0K0dsPsaOESAJ4FZBxYUWkuaahgCkI=; b=
	lW+u5u4TeF5ZhTQaxueWiedehr1vi1V3vRq10SebhhwinomEqswq9G1yuxGPZ6Z7
	B+Okjo9sNEDBei+2Me2WSyATiNL1rdbqJDQtwObl1fUPx+Y50tFtMbXNxbElAH4z
	3+Sih3gY363ee5SgN7ud/J8Sq5EGBwOj+3lt/lIEVslDX82BsW+Nvk/5ljn2SnmL
	WBEQJfBsW+3Z2p+wfJ1lKFg8i9FU7Tn9hM4bz+9U3uwdjcBvp8ASrQ3y+/P0aWKA
	Q4lIUpOmQmn/bTyIVG0BSgNkJc4kyeeE1q4IVT30mS436XuR2I6PyFW1/AoUtwRN
	QpXZp/PiObVNVRprAAAQZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777978989; x=
	1778065389; bh=DhzpA8NsTz/+V0K0dsPsaOESAJ4FZBxYUWkuaahgCkI=; b=i
	4mAUx7okU7dp0HDFw0KPqnesE7oWVs6JXNeIFoBjR3x/WhLnaf5+4PyJKZffyCkI
	sUQc6SvuNqj5KnlCAfjQi+hCof78USQxK4j2XSJioBAXOTcGgthp+0tOYERMcy3C
	jXNiJx2FEWODWKK3OO5jQkel1PtiaImVHZOBJ+qXIXDXZoXgBGKtooBcDSg+lKNb
	wPQfn/Yw9sBQO4mOK6I0msk3iErTtpSGCCG2WoneZ05DdeqZFc8DON0ZufMuRUbR
	6MetVqaGN+pQsa3C3mu1cr3ebDsDy3VrMdmmVXDzIq9RcgU6xVIsXB+ToDQJyKuP
	KTtQIV64yhYpFFNPQUb5w==
X-ME-Sender: <xms:bM75aeNx___wO381oahd9yN_J2-2ab1rL1rZSkVpDPeHaozC86ftzA>
    <xme:bM75aR1HK9QcPJsgQkldeY4WXR87DbwPNNA1E7CPgpvv35FJTxO39LhvX8ddxj3ky
    E6pZupiW6lfz1a6vSzJAP7r70VfSHzjyRXxAXROeLsjTypMBdywMA>
X-ME-Received: <xmr:bM75ad2dWSBKq2_4fMdqie0dNPyzSh9jgx3roUYPVj45qgJNAF_o3efv-kw3Ekv3BLlblyvtqlLEJf6vaKcQvF3Kda3Btau8fhBEpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdduheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgv
    ucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    ehheeileduffehteeihfdvtdelffdutdeludduiedutedvfeffheekhefgtedtnecuvehl
    uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrg
    hurdhnvghtpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprghsrghhiheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopeif
    ihhmsehlihhnuhigqdifrghttghhughoghdrohhrghdprhgtphhtthhopehukhhlvghinh
    gvkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfigrthgthhguohhg
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhpvghishgrtghhsehusg
    hunhhtuhdrtghomhdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugiesrhhovggtkhdquhhsrdhnvghtpdhrtghpthhtohepkh
    hriihkodgutheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:bM75af8TvFN1fbrKA31_gmji2eTDSzlToIyzEcm448Q73YGLWFo-HQ>
    <xmx:bc75aZaEMzuE9mwQ0_cd6LUjH1pxoNmPT47mbpEiH8q9tgx3MsAezg>
    <xmx:bc75aewhyR_7XlhG9FU5U3x__jvYd2X7jKiXXao0ZFf9tf7wWGgixg>
    <xmx:bc75aX8yGaYxY4QnS-YqrSYmSOslQWqL2gcjvrCicwI8KoNA_mS-Pg>
    <xmx:bc75ae_GUxUZubNy6763FllROpJ46WMls8W6lFEDMeq3GH_UzKbIZkGI>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 May 2026 07:03:08 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Tue, 05 May 2026 13:02:41 +0200
Subject: [PATCH v2 3/6] dt-bindings: watchdog: apple,wdt: Add t8122
 compatible
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-apple-m3-initial-devicetrees-v2-3-b0c2f3519e0e@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1090; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=tqRDD38M1lfDTOrUhWfFbq/m1TiGBjjHF1HjCcLG/DA=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhsyf5+KNNssk5tqdm+bXf909ZJX/P6NnHM/CH64KvPX2x
 I+JkUzuHaUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACby+wkjw+ybXLN9/At+fxZw
 sBWKnCS7Vcnt0x6XL/Y/f8zp/SVbxsHI8J5lxv1rd82d8hqad4lLHdkVq7Fpbcd/70WyVXocc2w
 t+AA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Rspamd-Queue-Id: 58A264CC641
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
	TAGGED_FROM(0.00)[bounces-8774-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ubuntu.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,jannau.net:email,jannau.net:dkim,jannau.net:mid,messagingengine.com:dkim,gompa.dev:email]

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


