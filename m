Return-Path: <linux-pwm+bounces-8303-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFERHPs8vWkH8AIAu9opvQ
	(envelope-from <linux-pwm+bounces-8303-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 13:26:35 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE302DA2C0
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 13:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A93DA3061288
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 12:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0493AE6E2;
	Fri, 20 Mar 2026 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="LcalUQsl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vbj/QsgL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792C83AC0F5;
	Fri, 20 Mar 2026 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774009429; cv=none; b=OMFIw/yQNT3OjewoVTLYLXWViXd0wkf0Gph4fNw5B45jJRWAVIpOMaSgHNrEgKD36wgHdbWm1rjT1g/oj9N1nvaCuGzphAhhhXL3evpiB3youE8PK7fUalXkVaWsfr1Xo843YAiTqeimKLZFDYhbJY8LwMwte5VjHdWXd7ddM0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774009429; c=relaxed/simple;
	bh=x6Qe6Kw14xao3bSRFl/Kgufiy8EMMno8B7J53ldPVP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gZ5lEU08RpxU8GzKEPjWE5zo3lz6qBhpfqMog2+FyHNtPJwn9gNrrnd82SoLVqJq+LpDjR0QJwxkfc179hZlbZ02fVNnPZFjk0uDIo/Ma0zuVSvsHHY9hYZ4uYR1woNNpXEOUMjLcF7g1ntYxBDedQtUNBo0eq/EUDORzQuK4K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=LcalUQsl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vbj/QsgL; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id A0DFA13800E3;
	Fri, 20 Mar 2026 08:23:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 20 Mar 2026 08:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774009424;
	 x=1774016624; bh=jtkLawOArao2lCnWHz+vxVSKfUKpDNghJlpU1ibhhOc=; b=
	LcalUQslf3rG6fhoDzayHx0tTcMSQ7ihtdzHGQdQlTcW6I3NEVtunzF8cplqLzKj
	5Yzh+oDGHLDbqTx2+GB7KkmC8JgC0A/JhfI7wQiQSl39niHKwA42qYZ2l6Xbspkl
	fHvu9vFhxBHFT8zYs1yI+p9kXIQUnxa7MQFPQm0MhIrdPLQMJp89ChwNjCQaQ0mv
	4gsLUfppjS1y8iLM7nWtvinWkpCpDI/PwGMh4oaRLyXxj4iA482eqmGoTcDKso2b
	1HVWqT5mvJrRC8WRy4Cxp7R6c6h+W7js7YS4stZWgSvpNjwAuUJJeRjrD7+aumgc
	0PJsw0ISMQfpdKAI7aN3mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774009424; x=
	1774016624; bh=jtkLawOArao2lCnWHz+vxVSKfUKpDNghJlpU1ibhhOc=; b=V
	bj/QsgLRH69dp3fe2nx/b8BsNLWt60iFSQCklJdTERPDOHxbjms2FaRonQQHN2y5
	yzrdx7Jlirepo3TET4DDiyazN5aeIcVGj2TgsnNVTLus4VhxH9mO2tXKUyeKkF1C
	qV1YVZGlzthW/7zmDRRxv/K1hsCWBKXGjJ7+9T3O32LQj1SAzI1ybK1z09Q53H1m
	ru9Rs4c77FWZa8XDseWr1t9ZcbXTsqAyJCzqtKlrjabsRGzEeAH4QqO3HGbRapJy
	8fyERzcBwuMMZGCWbXVlyhapiH+D7t26Gsi6A7bTc/EcCXfkJYyNGJMTINuPsjXh
	c27R5u7iTbkUuKoPwx2qw==
X-ME-Sender: <xms:UDy9aaIHm6yVcW30iyI991a7Cg5zkPOK7oIfrmum1QN9MD8Tm4bMIg>
    <xme:UDy9ac7cYaRkKtiZxyyqRAI8lcECr6mvfgH9X_jpwSPL5YZfvqhdQVy3d8bIAoO8v
    FT3uxMBL9xpjc6mQQ8hkAUaR03Cwtzfjp-Lv4AHWZv1uMS0hLQVyg>
X-ME-Received: <xmr:UDy9aZnnlihSnOCxc9GvK3FFVFAgmIM95zAoV50ueAcdVNHt3dUF4S2SNOcfCfAEYHX_Z5hJPvsHpx1NuoaVOasU6GYWEE6bLM9u0g>
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
X-ME-Proxy: <xmx:UDy9aWJrqKde_2_UdgrTcWiWchePzM7Rbr0mvpiU4A2BzWmannIzXQ>
    <xmx:UDy9aSEMsnsq6lYq5-qgeVj_AoiMfzR-wDwkxSAhLlL_Of08YSuDJg>
    <xmx:UDy9afMP3rbLGE2Pqrag8taS2uYW7DN2kjkWgZU343LbzcM9c99HHQ>
    <xmx:UDy9aU8twT63cAh__d-AmF8suJWIzz3k412zM-kM8DYWGwMLtfj4cw>
    <xmx:UDy9aT9gBJhghB5JpfKryQobZCqz2whyfjGuMZsRgeN6eslixFcqR5cu>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 08:23:43 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 20 Mar 2026 13:23:21 +0100
Subject: [PATCH 3/9] dt-bindings: power: apple,pmgr-pwrstate: Add t8122
 compatible
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-apple-m3-initial-devicetrees-v1-3-5842e1e393a8@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1176; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=x6Qe6Kw14xao3bSRFl/Kgufiy8EMMno8B7J53ldPVP8=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhsy9Nu7RXC/iF+1PTOoqex/ikP6gZsZWu/BQoSd+0pl/l
 He0qh3sKGVhEONikBVTZEnSftnBsLpGMab2QRjMHFYmkCEMXJwCMJG2Swx/OFc57/ssvYhx5YPX
 06xuppluMJfo3q8+eZKB1ywN9Uc7PzAyrLOfeHaT2yOfT4+5D/4uLxOamy/e12i6oHlmb7KJ/+X
 37AA=
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
	TAGGED_FROM(0.00)[bounces-8303-lists,linux-pwm=lfdr.de];
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
X-Rspamd-Queue-Id: DAE302DA2C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The device power state management of the PMGR blocks on Apple's t8122
SoC (M3) is compatible with the existing driver.
Add "apple,t8122-pmgr-pwrstate" as SoC specific compatible under the
existing "apple,t8103-pmgr-pwrstate" used by the driver.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
index caf15188099921d2b92a20a616945627f34fb869..c9be097cfba0e416081aa5d6677c74d2b34c9ac8 100644
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
2.53.0


