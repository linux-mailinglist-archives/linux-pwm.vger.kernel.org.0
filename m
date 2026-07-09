Return-Path: <linux-pwm+bounces-9661-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x3vjCfZPT2raeAIAu9opvQ
	(envelope-from <linux-pwm+bounces-9661-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 09:38:30 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDFC72DD44
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 09:38:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jannau.net header.s=fm3 header.b=iR+N49Jv;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="G gFYs+a";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9661-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9661-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA1FC3053FD5
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2026 07:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59883E4C66;
	Thu,  9 Jul 2026 07:31:34 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64B33EF0AC;
	Thu,  9 Jul 2026 07:31:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582294; cv=none; b=XotrU3HaDIRiEKxgUbWINlQQD0St+kQRlTbafI+MXBy0KtpTXI8sZH8LFJ7BsZLSQK6ijQf0p1kveK4YD2emHF9WjdXUvQ3SeVRov2WnmqiUPdgloe8iKauy4Or8ByaPlCOEGiu80488O6HzXItt+AprKv4pNEy/GBGXhtocWEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582294; c=relaxed/simple;
	bh=PtgnRkr6xtk+2dy2B7hvPKi050UuNx64bEiYNjonQns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CoDjLNoiyGvLeNgf87D7eURgH613QFposYmUEZj7vuJZFz1WPljK5Cq3t4Lh2lKGFG19uQRIzjx6o4PpThRP/g9yl4hpoH0JB9mzmzN237QPwKwvrxuBVPVq/IwMnezsvm8Nb5Wmz0nZ7f0WSThwszCmL3/hwVar/tEeWVovHXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=iR+N49Jv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GgFYs+a9; arc=none smtp.client-ip=103.168.172.141
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id 0190E138006C;
	Thu,  9 Jul 2026 03:31:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 09 Jul 2026 03:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1783582291;
	 x=1783589491; bh=DKuTge21jhZ4Rn+/iG8drh+mZwRnsHZfJ2NrBam6YvQ=; b=
	iR+N49JvRIDxpvOnUkuM+E+Gtg+pryaPRZIr2VlT4twbfCeYqtgwP2+QghOmhn0x
	/5nU5I9ygOuyIacm1oePTDytdrQXCYd0Zr2Mf2u1LpGvPZE3iFjgHohJLAzarDLB
	vvbnVhm3QrA/7E6V4fV5XjUnCAwwVtd+uPHNosencZcYntZ/9F3yTxZjpMr9VMXC
	FsXzauAf2cpXsOX1w7N/N+YuxXN0AWpdasjytD2Y4P1eHWHrG8syHBRYC/S6xKnN
	9GQn7Q+gbtsTbGmBEb67113Z58c5gf/Pes0zByXsgag0qiC1jlFqcM7UvV9KSPmp
	JCntC4QiaSQUyKpjrWCjWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783582291; x=
	1783589491; bh=DKuTge21jhZ4Rn+/iG8drh+mZwRnsHZfJ2NrBam6YvQ=; b=G
	gFYs+a90RHCIvRvfcZq30XjLg0yr37LCHDe3CLfc5f9t+Iwo8XanxALR7mT4o0IS
	2BfhI+qJl4c7HLUKxjbJ2x4BtmM1nojmyLPg592pIMK49mov797+gtZDrOVv/Iq+
	G/gJXgdNYcAbs2mH62hiHKRc3BNwHwJqJpVi/DZbTQaMBOY+a2W+2Pb/Wui6fIVN
	s+gQmD2f8Bdz4JmmXN4Knur3wKGIlZcn+kqXptSOcVOk6Bb6EBZxJBGl3qrd40e+
	+7NC5yMfiM7Z2l/bQqadeb7FgN2DgnIvf4gFu4nycONiPDTazJp2OuVHfmAlHea1
	7wMfnyhjn9y9WS1Be0X4g==
X-ME-Sender: <xms:U05PavKTRUMXV22jWy6Rl44qEJyPMV4OVMkvJ8w5CE3A27lj8utOvA>
    <xme:U05PaoBd9GgmhdUDvnJ2cb_qAKPqV5222moIKVrG3KWHt26gcLeWDxQtUmV7dpq5I
    zkt_PmdwWSNJ75939REAgDE1fvVra70iivf8VUNl1Hi_iS_53XMCOg>
X-ME-Received: <xmr:U05PalTgOMZDaUOnNebWCSNwuN5viEO3RL53J-k9QVhxPn9ESR4gtMy8qW_IAMiQZ88YvaEbSNEiKd90Ni8T_PtiLQfLlFhh_b8>
X-ME-Proxy-Cause: dmFkZTGYKeAHgJKVIjqCymJpihoZrEqDQaRIPCKXxcc6uiPXzJNTDc4H4LzsUaMF9MJqYB
    2rpTe0oGhrtQRwfHcGfbJPzdaNrx81amtkEDFVv/fGamGt7vZBPR3jcucmA5JRiTwERHZr
    8zGRG/w0d07G5jQ4PlCj5gdYeuagoIAoYXQ4A9l2tOaakbVPoRmPGeCRSKDT6z7tQH03AB
    WTVwikV9P4YqczS+ivH9R0MDJM1iJWbkLmAFvo0DWmHZGz3C5uxbmrt35Eg98JoTPuzJKd
    X/sNvlqMxvVsFiGXNnL3d3+h2N4QVm3ifsTcrDacstkEioZW9DpvzWMrk8s16EPWaQL8dA
    zwXv56MGiaZIrgqQpHk+v39gxkAj9wJUda6knRLGm59LpaC3aCQYiW01gvbbjy7RJGq3hO
    I776Vyg3oTt7rx1rQnSRLEvUetwSkReJj20Gu/mT8S+t6yTT/8FAsxw1iJH7My44kEP79X
    RTc7MKv2EO2oDcXjk7mJ544blBX1x9nTx1SN/v0qH9sX/7FT4IS+26V8kMIkruUB6WCR6T
    wG2IWWAQv0PRjGGR+0PZmoj3bE501gkpwvRUUpYVH+WsjObbKl9VX7ZYIdoN1b+ZaUbo/8
    /o+vqPRgcmJ1vBZnMCysWI5hY9NGo+P2RsE6M5Bz4qTZlMj0AbaHL2Xtkjrg
X-ME-Proxy: <xmx:U05PaqfL1TEYivqhMP1ziY3KIV6fBW_J3H6J727FRvbo6OvhSchRIg>
    <xmx:U05PalgZPHl65mlH10WNvr5n4Izrs_MWXdze12oa_1XNJSrXCDcZkw>
    <xmx:U05Pat8hphgebVWlL6PWRulmiR57-B0J-lkH6u2jAOMXd6rK0IyNOw>
    <xmx:U05PatkFfKW1kKiEUST3QXN6E6WOyrFb_RXNEJkaIneGAIG_AHvcmg>
    <xmx:U05PasYgXIuMaT2c8CqueBTSeMCv-u1l9nNDVjnxOOt_YHJUfOGD2Oyz>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 03:31:30 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 09 Jul 2026 09:30:54 +0200
Subject: [PATCH 08/11] dt-bindings: i2c: apple,i2c: Add t6030 and t6031
 compatibles
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-apple-t603x-initial-devices-v1-8-55b305833123@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=906; i=j@jannau.net;
 h=from:subject:message-id; bh=PtgnRkr6xtk+2dy2B7hvPKi050UuNx64bEiYNjonQns=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhix/PztXrTSdEKZzk5sbPPa5/rtYoPxt1Z+bRew8+xbsr
 ikKCNzTMZGFQYyLwVJMkSVJ+2UHw+oaxZjaB2Ewc1iZQIZIizQwAAELA19uYl6pkY6Rnqm2oZ6h
 kY6xjhEDF6cATPVxN0aG70scFuxezuZZ+SR586ns8982bOPO0DM1fsMeluV6akmtNCPDMakO3+M
 LYjpuGezwVE6axnN6y5RVC6ffXJZWfId3Wth7fgA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9661-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sven@kernel.org,m:neal@gompa.dev,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:tglx@kernel.org,m:wim@linux-watchdog.org,m:linux@roeck-us.net,m:linusw@kernel.org,m:kettenis@openbsd.org,m:andi.shyti@kernel.org,m:ukleinek@kernel.org,m:k@chaosmail.tech,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-watchdog@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:j@jannau.net,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	DMARC_NA(0.00)[jannau.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[jannau.net:from_mime,jannau.net:email,jannau.net:mid,jannau.net:dkim,messagingengine.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8DDFC72DD44

The i2c block on Apple silicon M3 Pro, Max and Ultra SoCs are compatible
with the t8103 (M1) one. Add "apple,t6030-i2c" for M3 Pro and
"apple,t6031-i2c" for M3 Max and Ultra as per-S0C compatibles.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/i2c/apple,i2c.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/apple,i2c.yaml b/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
index 9e59200ad37b..d39f5e3f1df4 100644
--- a/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
@@ -24,6 +24,8 @@ properties:
       - items:
           - enum:
               - apple,t6020-i2c
+              - apple,t6030-i2c
+              - apple,t6031-i2c
               - apple,t8122-i2c
           - const: apple,t8103-i2c
       - items:

-- 
2.54.0


