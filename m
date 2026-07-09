Return-Path: <linux-pwm+bounces-9660-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3LOVGhpPT2qBeAIAu9opvQ
	(envelope-from <linux-pwm+bounces-9660-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 09:34:50 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4974272DC6A
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 09:34:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jannau.net header.s=fm3 header.b="A/R4Uv+K";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="j 9ae5eb";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9660-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9660-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE89F304F1E1
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2026 07:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D983EE1C1;
	Thu,  9 Jul 2026 07:31:32 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD8C3ED5A4;
	Thu,  9 Jul 2026 07:31:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582292; cv=none; b=oESlHvbiITNcFtLJPATk9h8VNlhUrYEJ41xbmMuW1gdnSKuuhh933szJvjigIaa4qmNAwsxq6DacgrWrv/9RNN60lpo1UWoNVASHwRbRvJWkJNytMGFGzNDKYW6FlcRoNYIiWKTQWl3RFVaZI5ptsnTdO7oTmHsicJ04gVVeIvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582292; c=relaxed/simple;
	bh=5HbBo+rfts5jo1g51QS60vh/NG8SZueQVhNVd+PKRqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SufItTYNn5AE3lWnAFizpujApzcTkZzGWkQYjnvu/ul+uYpAYWVXjgnO/tVV9QgT3ipDKJW5Ez8SvWrmqybqfaJQNlfEyTaTMT1Pazu1ANdns+3evUmjkQQM3+STCbZa3WDXvuV3tHddOTaZWnYePZ/ApR4zUDxkZU86gxEs5rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=A/R4Uv+K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j9ae5eb7; arc=none smtp.client-ip=103.168.172.141
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 86E1B1380145;
	Thu,  9 Jul 2026 03:31:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 09 Jul 2026 03:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1783582289;
	 x=1783589489; bh=AA0qddm+MaWJtjYda/gIc5MYiZRprfSMbgOiV0KxcgA=; b=
	A/R4Uv+K2xFZiWOd4ku15YVG7nMiA+OyG4MFDkBwKC51a828xIu5/9/MlSN81aOv
	fQsWLhphrx0Hgk8zYENaGD1R5ZLPXIMZqkb63sTqYd/LdRrG6hO9aN63WmkH0WjP
	L+wVnKXoexxsHYwA4IaGSDz8Ulklrii3mmhpLd1FJCThnDwZmc5Lnuq9rcQO/8bz
	VlhKW7B6YxkxlpC0rGisrR6Vj7NXMj9E2aj92ZL5xjLtIga/4W3so0CKSg77QjLH
	Qlsmf4bN6Y7Nyq7xkA810dznmTO3Sw+bRvaucbCR5qPCXm9yfyMEQNsRbcbGsiN+
	2meaN/V53R4f+KzjsM7APg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783582289; x=
	1783589489; bh=AA0qddm+MaWJtjYda/gIc5MYiZRprfSMbgOiV0KxcgA=; b=j
	9ae5eb75NmLwJjFnX7CHc9wtH//xiVbJEtZZ/9YZjKrCkrh9DjFg4dL3wUkoh+6S
	MDNUbGkYv8Q92PtTIUBQm3TDqLUDiiMjUSwC13SM4yU03T8gLiu72nwMOTxojaBb
	aVVfezwxYCP6KaUOAj8KJRtMd90K9GLZb42VTAiY/q/hTW7l5rSRszMkBAjTeZvI
	+6Yeo9D+819vhnxnfNpPLZMfKZmkDOGf+6xpH5FgQh7uufQLbbg4dbyxjRTbMY3+
	BqPeQSNAVuO2I34Z8xFrOzWW6RYPsWlR5wrs8q4ruso6o4Cinti6Gc9l6x7HiWhU
	dDbnyh7+gUibBRqEZNrnw==
X-ME-Sender: <xms:UU5PahKXpfyKRg9WBTJj5XEdwgBvB80pvkH0QVkSlxJcrEVIMfD84w>
    <xme:UU5PaiByJDtTLBVwElqQq3rLwV3uNYKmqDWy_fZRuIywUAqn2_wSMFlDv7yrdi5aj
    nSlbLpR4c38RgOvIDVMmqv3zw3mxw_bHfGJ9dXwNjhTQspsHhqmE0w>
X-ME-Received: <xmr:UU5PanRouTpoh-ISO42eo2_NDnPYzVQVHz6wjuTLGmmLQklyvRgziwnUaqZ9Ma6yfgbN2Q3rkg9Cjgxss54UdXBb0zqpyL2CIh0>
X-ME-Proxy-Cause: dmFkZTGYKeAHgJKVIjqCymJpihoZrEqDQaRIPCKXxcc6uiPXzJNTDc4H4LzsUaMF9MJqYB
    2rpTe0oGhrtQRwfHcGfbJPzdaNrx81amtkEDFVv/fGamGt7vZBPR3jcucmA5JRiTwERHZr
    8zGRG/w0d07G5jQ4PlCj5gdYeuagoIAoYXQ4A9l2tOaakbVPoRmPGeCRSKDT6z7tQH03AB
    WTVwikV9P4YqczS+ivH9R0MDJM1iJWbkLmAFvo0DWmHZGz3C5uxbmrt35Eg98JoTPuzJKd
    X/sNvlqMxvVsFiGXNnL3d3+h2N4QVm3ifsTcrDacstkEioZW9DpvzWMrk8s16EPWaQL8b4
    DAaBpqNmb/K+Ifmwnj6cKEMQKCUZv4Dh9LWWSCDorp5xjWc48kYarUE3lNtIxGpkR/+4yj
    s41jsrBVvL3X9T2jxKgNDD5iHaEVCNiOxnKuEE77OJjqA4SO//WQQkWuvY42BnENc5Pce2
    x3dRl+RJnz/7eol5SwGeyOp5NGwKNYkU8RA4T01IlMwFhRYD4m0huR7IErDBbvf6ql7tCK
    1FYZyq+ENOkVGpmtkGfISxvETVzFUYYlSxFFtiMozqwBR1zSVD6disJFC0eDq/8+lZJPZ2
    LYeKu3zv3ybJ9vBy4oX1aKbEth5EyjZnCPITXjvy96KE3dtzz1dfTleDSQjA
X-ME-Proxy: <xmx:UU5PakeBXISGWB1km5OXTFUBDfCtN1ThwoOucovxgQdNMgc-7grecw>
    <xmx:UU5PanguRdNZHunruD_FW8WJCZa_1JPkM75KTc-_U1ObT1hcyClbbQ>
    <xmx:UU5Pan_g_tAHWFNZ3YfHHDonvSs2l0yAKcNEErVHqg6HXU6PPRwP2A>
    <xmx:UU5PavnvCFoxPKYxqstB2a2qzzQBlcx-gjAX0BkjYs9OORiXdTVIeg>
    <xmx:UU5PamZpsTZlFPiTPv1-fDm7B4KJ71dH5uFp2GT_mxUtWatZqqTySpKU>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 03:31:28 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 09 Jul 2026 09:30:53 +0200
Subject: [PATCH 07/11] dt-bindings: pinctrl: apple,pinctrl: Add t6030 and
 t6031 compatibles
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-apple-t603x-initial-devices-v1-7-55b305833123@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=978; i=j@jannau.net;
 h=from:subject:message-id; bh=5HbBo+rfts5jo1g51QS60vh/NG8SZueQVhNVd+PKRqk=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhix/PzvRxv2lTQvW36vqve+zfvH0pUsmxtz+7D2R+VWDt
 TXvMquTHRNZGMS4GCzFFFmStF92MKyuUYypfRAGM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 GukY6xgxcHEKwFTXrmP4Z6LC8q/+U/Xe1JhjRjlbyk75f2D3OMZzovtQd/FLpT119xj+O8395fB
 MNlx5vrQP3ywWl9hGk1czrrA92bLz2YO6W9MMWAA=
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
	TAGGED_FROM(0.00)[bounces-9660-lists,linux-pwm=lfdr.de];
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
X-Rspamd-Queue-Id: 4974272DC6A

The pin controller on Apple silicon M3 Pro, Max and Ultra SoCs is
compatible with the t8103 (M1) one. Add "apple,t6030-pinctrl" for M3 Pro
and "apple,t6031-pinctrl" for M3 Max and Ultra as per-SoC compatibles.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
index 41073176bc69..f08d2c4f5784 100644
--- a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
@@ -20,6 +20,8 @@ properties:
       - items:
           - enum:
               - apple,t6020-pinctrl
+              - apple,t6030-pinctrl
+              - apple,t6031-pinctrl
               - apple,t8122-pinctrl
           - const: apple,t8103-pinctrl
       - items:

-- 
2.54.0


