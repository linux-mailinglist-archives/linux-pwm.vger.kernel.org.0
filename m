Return-Path: <linux-pwm+bounces-8826-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FJuZFU1A/GlMNgAAu9opvQ
	(envelope-from <linux-pwm+bounces-8826-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 09:33:33 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9A44E413D
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 09:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE584300622D
	for <lists+linux-pwm@lfdr.de>; Thu,  7 May 2026 07:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA2D3563F6;
	Thu,  7 May 2026 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="bhaSZ9WJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LOYwqIJg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097671BD9C9;
	Thu,  7 May 2026 07:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778139207; cv=none; b=Othh6+ENRuKPFAC6UZ4Ujd7eOIhAXHhNKFTXXyZZkJFOEuUhgk4tc3T1V8JfBsQIWC6nOkMfn92vFj/HG9/kuMuWAbsRzeMapyB95AzSBB/b1q886tY2iv0BLQh6bXfW2TNjH7WnT8U4es7T9N1lZ7fQYAG0KyziNFxdlCeexhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778139207; c=relaxed/simple;
	bh=+bvTFb6N9eybW1xIFA7El09z2HTI0pUgSg1eZJeYWis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TipHGze/COhuMjKqF3aEK321py74P0uGUAMUgaqn1JZzOWTSJVJWw0VEzalhzy2xFm2gTG7ppFzT5uZZ1Ldq7el1wb+6vRTyIqARFWe2ITAf17crm6PhVCReKyKNqK0lEpsajTSZ2LQjoSNK/oIoMxePMDWhCK0DmNC5OzxTIsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=bhaSZ9WJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LOYwqIJg; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 3867FEC0129;
	Thu,  7 May 2026 03:33:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 07 May 2026 03:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1778139204;
	 x=1778225604; bh=OeRP4uxgJUzsKmseBXlEN6ZhvSvowWXW42C3z5EkAwQ=; b=
	bhaSZ9WJ0pBUOXqwnTYm27jX25h5recXqymGecS9fsN2btnRWhy8aEMfweYwKThD
	3WbseHOb9HPIYqYq3w/NeC3xD6Vrv+fUwZfn80fZ0cPD3PGVcUrxGhJY44uTE1Qe
	tQXvSpTyk1bpi+eWjzAG9clRP89FkyrnO8qJTPKeIDyrFLr1na9jiqUPIZpGIRWc
	RU38WBzopkOoofCu2GWv9CPMykl3dNuj7HAK2owh+0IYvrxk6q6/T1GWIyDmy1Ri
	8FVoOIPNodGf0Sq00+hT+VEO0CNZKCnGA53H/e1bxm27rDE8dcXuPGEIbkuD+V40
	kFk0MVrLz8Lb483TpnIXfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778139204; x=
	1778225604; bh=OeRP4uxgJUzsKmseBXlEN6ZhvSvowWXW42C3z5EkAwQ=; b=L
	OYwqIJgfspTCL6lkko/YKODMRX2CX+ynprDjCz5RYoyM1b5aDIEDD2WZaXtrYDQW
	r+3Wx7Sw0SbFLfOMdoxY59T5fiPnpQk+GM+nSQzNtl1UDHqgNzVIIWdOCDe3mcRC
	px8/Gvg5u9tHbUoMDswofNo2IPQBHkTJNk9+4qNoSRZ9DPqpdfFsJvO19P6FxZd1
	5p5WC7JhzNjC9mlYXwTutBpq1k7v6r7rtFYSbogeg7r1JiyjNjWN/ucq0PirRp7H
	tXYiJWRhH+hGnJmyNBf1227E+FSj5OEYjN4jD40ec2i1/qPhnrItEMyw05gzH2nJ
	Z3dGVy12ddw5ILzkMHuJw==
X-ME-Sender: <xms:Q0D8aaoAh0AWZS1TW1y-S_TtBxzSaIrG7jfrtZBAurcUPXL4xOOICg>
    <xme:Q0D8adjbnUmWjlCeJe_QxduG9HLwCaoMvqO_fzhkb9yxzlB6spr4-VL2QwqRSdnu0
    krAaTpQKRW_pHecDmxACCPWvztgafn6_6t_ZldMAapNBxpf_sIiYtxJ>
X-ME-Received: <xmr:Q0D8aXzzJlpd4aOINR_5pS1uNQu3Xf8nzVzqwgPchJNtqv07pwnz8zBYTzt_r12zJClYYf_LMPmDiplfhfxp1ves0c65_36trH9mwQ>
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
X-ME-Proxy: <xmx:Q0D8abJiqjsoJPt48yBOFuE8b7LjRoPtxiV04HdTFaJtoJUVchUI4w>
    <xmx:Q0D8ac3YY91YebkGjKxVq5Kq-xQEo2G6vXLmYHyTR4VESgN5ooXAEQ>
    <xmx:Q0D8aVdnuu5RsnsBHFQ_wrhMr6PGEC0QnZOF8VMZ2Jwa6JGR7c7cbA>
    <xmx:Q0D8aQ7j1U8VLrO0jirKuwnnEzNmuEcxQEkWQVQEQd-WPSSvPKQaZA>
    <xmx:RED8abq0dVB8EvFTy2XPmaAwhakJkV0k6kniCPGDO09lVYE7cjZN3W2P>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 03:33:23 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 07 May 2026 09:33:07 +0200
Subject: [PATCH v3 1/5] dt-bindings: power: apple,pmgr-pwrstate: Add t8122
 compatible
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-apple-m3-initial-devicetrees-v3-1-ca07c81b5dc7@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1260; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=+bvTFb6N9eybW1xIFA7El09z2HTI0pUgSg1eZJeYWis=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhsw/Dnbe+9784P3y6VLrru6waUuYlaRqagtszaxt/KaLf
 80L8GvrKGVhEONikBVTZEnSftnBsLpGMab2QRjMHFYmkCEMXJwCMJGaJEaGky9sGCxtxV8ePHt7
 VuWSS9YO3GWNbJsVHtjx7xOSlekQZmR4scX2ZOTb8n8lXwwWxfqonFXbOunLlmUTt318mr5j0uJ
 /fAA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Rspamd-Queue-Id: 3A9A44E413D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8826-lists,linux-pwm=lfdr.de];
	DMARC_NA(0.00)[jannau.net];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

The device power state management of the PMGR blocks on Apple's t8122
SoC (M3) is compatible with the existing driver.
Add "apple,t8122-pmgr-pwrstate" as SoC specific compatible under the
existing "apple,t8103-pmgr-pwrstate" used by the driver.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
index caf151880999..c9be097cfba0 100644
--- a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
+++ b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
@@ -43,7 +43,9 @@ properties:
               - apple,t6000-pmgr-pwrstate
           - const: apple,pmgr-pwrstate
       - items:
-          - const: apple,t6020-pmgr-pwrstate
+          - enum:
+              - apple,t6020-pmgr-pwrstate
+              - apple,t8122-pmgr-pwrstate
           - const: apple,t8103-pmgr-pwrstate
 
   reg:

-- 
2.54.0


