Return-Path: <linux-pwm+bounces-9662-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tJREFEBPT2qOeAIAu9opvQ
	(envelope-from <linux-pwm+bounces-9662-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 09:35:28 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F2F72DC90
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 09:35:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jannau.net header.s=fm3 header.b=NcjXP36j;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="E fOYLRL";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9662-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9662-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EAE7D307F742
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2026 07:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160633F0AB6;
	Thu,  9 Jul 2026 07:31:39 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE833E5568;
	Thu,  9 Jul 2026 07:31:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582298; cv=none; b=mfbo130gNCPkYdr3kBFQxqrSMnESISauIo0qp07aEIyiY66ZhfNpkJcbDSdl0PEnppWK8rrSe20QPLbG8UKVMd37EurUKxJBOb0DLo+KsqGIxSdgbD6SEp1xt5xB/8B++LMMMyMfShJfldrIo37bV7/MBsGpQTWT9nIWdv9UJWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582298; c=relaxed/simple;
	bh=Ppfdy02YJ5CZLZtqqh7kewhrMf6+EmjK3Cy3GA55q3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oo5DtGweOpfeNxmhWf+JnhtZ5pSTq1agRh3JG0rlhTpK+g8DOwh1Hh1FpvQ5bh9+nGcshIb4ELYbck4yme5v1wopj1zu83q8CdHhvEWaxpiGhew6sVi9zZepVnhwSZCneuU7GwXPgV/CcBfG882eRiCXj9XnnQ+Cn7/oufmwkXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=NcjXP36j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EfOYLRLA; arc=none smtp.client-ip=103.168.172.141
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id BE16E1380149;
	Thu,  9 Jul 2026 03:31:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 09 Jul 2026 03:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1783582293;
	 x=1783589493; bh=t2jWJuLgHrPs7M9dO8QM30Eyc5bIJ/1eecsMwS669Og=; b=
	NcjXP36jr3upWS9hN+FAjMOkg9AJoqH2V1/XdxVXx2FPQytKW5D3LEdp5rrLr0vz
	HRMvhIrdQIHfK/4E5WxY8MqJsfaIccn483PTiP6SjKEcqiiSnuhMnnP6fYo6LP/t
	wJgvblgDbNy3uKytHHw9IQpJVtHXDaG3wVb4N+8tqcGIvPRu1n9CD594Qx/3iMoL
	VsVjnqNnH8cuX/Eazj0B8ml2F0eKXa1Xox6VRx6JLeAlGlc/d0yFqOWu8ePjyrqT
	51XuIuvTNLN7K0+YCabxcDylDRr2TE6vqivL0D5yop+VclYMXa9O7GlbQ6pgBnqA
	/3nbJWQFrmOcg0sqTozPxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783582293; x=
	1783589493; bh=t2jWJuLgHrPs7M9dO8QM30Eyc5bIJ/1eecsMwS669Og=; b=E
	fOYLRLABOf1jQaS0RUJ1Tra54OMvskUxlTA9lIszIsRAprkn6dG/ZIXmkFrC1cUz
	MyzhHM4oVNbVwHFakRFz1uoREeU4zwSWYUsJvA3fjmMc1LsciP2lSG2aZWk2MkJZ
	Vzu1kbTYZHC86R6JhglcIA9BnJtg/TXheP3PEkiwl2sTOqlGtD1bOvp7v8Jbi2aY
	xh9wBc74wbvIGIGpcbTrMqNeE62MiNYtpCsLenTw45m9B6hgVq3L3/z2VO7wKtfx
	gfn5n2nCGavuxuLRkJUr6p7IMtSpD7S60NyT4cqqTHdfSJmX+10Xxx4A1ypFcMUb
	F1OPVLawmrMANTjOElnhg==
X-ME-Sender: <xms:VU5PaqiPjSioJ9Cshf_s5uppcfWRYnQt9sqpF1oRTq0f3aXUFzH50w>
    <xme:VU5Pav4NiJQ0LnOc2Fz2Z7TNbdCUQpA8OGtR-qQpQHxdHldVXUt1cI9QaO-N-zzos
    yZgMc44twHPiIci0tDNYhxQVAtH0ytSjKhriBW8q1QQzhQBA5ENyV8>
X-ME-Received: <xmr:VU5Pavo51PzPcIYOVzxHcuSsO5CdJu_ZZEjmXrLA03k6cw2axAMn4jp8IjVov1qhzLYKn-tB1XheEOzPTRWJHnajhFSSsLijWu8>
X-ME-Proxy-Cause: dmFkZTGTDz8RTLhItPbFFd+gcnt5D2cnrDrA9F0Bu4iuiJUOABQ/t6OEIghgd/I7rUj0fu
    DyRTW0vng3TTYmRifDkSqezpta5UmBqSTxduanIbo/irNS/7zSwkm3liyg6HqibupBIxF4
    qaBZR4W3LUq0RAzlY7KFquqnRzToKaRax/SSlc/VeNsQ8Ii2ifFnWadAhB/GXoVH5qtbmM
    7/xAVskeXjkTi/OSNh3fcUFwygXTI3pwsAhkGvaFtWofwSFRarcsFBxFMXD/PBZqIdLBgS
    sA8WGpz+BiJMX3wwD4hYH+vVlcJ5WzOfGtR1yboz7lR9X0/+HB2hbuocXq1tPn379K9mSh
    Uvs+ZwJTatqycpHD9Gv0grUb7P5xPTWsWCSaxCTBMdDcrUxI1N8iW5piy/eutEFJFNddXU
    u447zJvK9glK0RWRRoVpl84pUfBruFhm1k3sDVG0Vf/CaW0cdqGrIBN0jUXhYTS/VuXU4O
    qIBAruU1FEjSc8tFf1W3MW7Prq84veqXedQovzbqIdf7hjcebbFakK1hj+VuCFCqT7Hh+7
    KoQlb+3lg3it5XU/8Lx1Zs/v6zKUiM2zrfrv7VmlkkyeW+BMzLmWYzqowr0Vd9l0I5bez0
    V1qQQUAR+L8/CoKj3u93ey8OuhcA+Q5D6ap4NGocXVcL+F30S/2zDAOnLVZw
X-ME-Proxy: <xmx:VU5PalUbjp0wqBR5BVwEKBpG9dLZXA3QTbWvYjy6f0DqnCo_tq23Ow>
    <xmx:VU5Pam5atEa3IxCCMz6i_Vcg7mTDT-X_SytnPOwrJhY1g930ypEOTA>
    <xmx:VU5Paj2cm7MTacsk62FqTZPz2WG4WDd-a1gTVcW_aDizZcjZOlqcuA>
    <xmx:VU5Pat-TmX6-3VMQwNZiSyyVgpD8auGfzayfM6V9OaLFMlEcYy3uxQ>
    <xmx:VU5PagT_NqOhuhEyOEFhF_WQBfXhgj-sAN_scZwnD4BCuW8kW5BBaLlU>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 03:31:33 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 09 Jul 2026 09:30:55 +0200
Subject: [PATCH 09/11] dt-bindings: pwm: apple,s5l-fpwm: Add t6030 and
 t6031 compatibles
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-apple-t603x-initial-devices-v1-9-55b305833123@jannau.net>
References: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
In-Reply-To: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
To: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Linus Walleij <linusw@kernel.org>, 
 Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Sasha Finkelstein <k@chaosmail.tech>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=915; i=j@jannau.net;
 h=from:subject:message-id; bh=Ppfdy02YJ5CZLZtqqh7kewhrMf6+EmjK3Cy3GA55q3o=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhix/P3sT456O+JXSP42lPPimx0hkya04HcQW/7p1TZLf/
 8VNBZkdE1kYxLgYLMUUWZK0X3YwrK5RjKl9EAYzh5UJZIi0SAMDELAw8OUm5pUa6RjpmWob6hka
 6RjrGDFwcQrAVEdGM/z3Nlx2P3HB7lueyoLqU1daf/OaIWVf7qZ5Nk1qjgBb/VxzRoa/OwRfTir
 vCjnqpG38xMnyQXvu4xUXXnUuD5Vmjcw5Op0JAA==
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9662-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sven@kernel.org,m:neal@gompa.dev,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:tglx@kernel.org,m:wim@linux-watchdog.org,m:linux@roeck-us.net,m:linusw@kernel.org,m:kettenis@openbsd.org,m:andi.shyti@kernel.org,m:ukleinek@kernel.org,m:k@chaosmail.tech,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-watchdog@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:j@jannau.net,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	DMARC_NA(0.00)[jannau.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim,jannau.net:from_mime,jannau.net:email,jannau.net:mid,jannau.net:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 29F2F72DC90

The PWM controller on Apple silicon M3 Pro, Max and Ultra SoCs is
compatible with the t8103 (M1) one. Add "apple,t6030-pinctrl" for M3 Pro
and "apple,t6031-pinctrl" for M3 Max and Ultra as per-SoC compatibles.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
index 25ef04b60ca1..dd95037ea5ee 100644
--- a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
@@ -21,6 +21,8 @@ properties:
           - apple,t8122-fpwm
           - apple,t6000-fpwm
           - apple,t6020-fpwm
+          - apple,t6030-fpwm
+          - apple,t6031-fpwm
       - const: apple,s5l-fpwm
 
   reg:

-- 
2.54.0


