Return-Path: <linux-pwm+bounces-9658-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ca4ICqpOT2o1eAIAu9opvQ
	(envelope-from <linux-pwm+bounces-9658-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 09:32:58 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EE78D72DBF2
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 09:32:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jannau.net header.s=fm3 header.b=pA1yMmoD;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="P hrDLi2";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9658-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9658-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC339303A20E
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2026 07:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2563EB80E;
	Thu,  9 Jul 2026 07:31:28 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDDD3E9C07;
	Thu,  9 Jul 2026 07:31:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582288; cv=none; b=TGiIiim1UNN3YQly//rndboMjBZiPMRJ0v8JCvuTo1CAgGSsGUBIC5IS26fj6Pb30yYbo+5Z3819/CdLsGAae3LgGzkHdal8RBswlDdwDgV/i0Lx5qn6uHeFyAkPfFLDJ87bMQ2TuIY6f1zQP/BLOKWZNmW+qO27fKyIiRW8tiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582288; c=relaxed/simple;
	bh=6j04J5ZsMYC1glEYGPI5SeONi9pfivKJ6lbbwpnFQEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VRT9HUSIRGrgLD4i7L7/z6qhwrCwdHGgw2mosbVko6MDXwqKtErCNtYvet+ejrvXuvNHph9PE4F7D91tmkEXs4xDqA5ZCfhNIY8xRgRCvVS86c+wy717QzE1PJH+RD6Ksc42oVTq+raI5R/pm8RPpVAJXUVZvGcPL6bQKW/Q4Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=pA1yMmoD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PhrDLi2K; arc=none smtp.client-ip=103.168.172.141
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id CAC5413800A2;
	Thu,  9 Jul 2026 03:31:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 09 Jul 2026 03:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1783582285;
	 x=1783589485; bh=6cw29mlAkLYr8FXLoHcl6TTmhyQjc2qvZWL680Rsq4g=; b=
	pA1yMmoDuuIDFRT3lNHde80m4TM+bn7gJYQEb2bCYMawWTRryPBgIklO2xMY70vM
	OdY+YKdDyLSGmf7ShmnrwviBDiCbYBKf7rshzOYENcb6JuLS816dd+cDuu9PR45P
	Muh8JhKaI6ZeYXnpmvqkTQAr2R3kLXnUf1eXWAQE5c6/Ko2nFlYzoSkjan/F7mTr
	K1jKOwY3ZCze0zWbbFXkmRNRqDnq+j+SaFI6fhUOVPYVLJrSuSaR+gRYbwgmW4r2
	W0L+mEJcXVYPvkJRe7bcB5YB8/38Ht7D3vR5TC1NQHDUso8wG8luAg1w4/qIeCl5
	O6ptPekuWEYN7E2C78RJ5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783582285; x=
	1783589485; bh=6cw29mlAkLYr8FXLoHcl6TTmhyQjc2qvZWL680Rsq4g=; b=P
	hrDLi2K2+kxA6ICuD4ssVIsqMFYMz03Y415DTfMCVokx0SiRF3P9Bv5ozP64pAU8
	tacpIlPVCJgQ1kAy7QhLUjjEXRX/1DA8mGdbDJ5pk65FCQIKFnrtjQmGkcaYDHNf
	yYeLFMwmwVJwNAOS3XSCbcmP6p+iwAQi0uHiOGT5iNKnOscONSSeDR7WfIfjUs1X
	CXPjlV5JYM9fThlgQrS+9fw0GJpj/B51+u+qpZa78HTC6k9NVuMvl8PVVjbBCmoh
	ZQlN7JxGcrGJB5Arcu31gghIIu3yT3HpMZ6waXgyVGUlySTSllewfvtQtZiC5pmr
	PVxoOvoc0eMQwx/rwEu5g==
X-ME-Sender: <xms:TU5PamJkQieoP5Oist3VmcZue47XWUE2x3Z4W_GTSwcRvEXKYNK-tw>
    <xme:TU5PajC9HeYS0i7iAj4wBoPTVDJ42YZ2PKF62GxuWzlaeLCYsKvD0Zgvl-C_tMd1X
    0kySzMW1q7ufLkHq5hWx7ZIsOwKA_EwO3l0R0OXkeR00GFssYe2qena>
X-ME-Received: <xmr:TU5PakS-DhOTscIlMCnG-cxHUT2emcZQ-kB6PUX-R4j7H2vQThLmR7STHWufo99CE-fvZAo9tus-JG32TDGNTgxQdix7XSifpOA>
X-ME-Proxy-Cause: dmFkZTFDgvji+KZOYa7+nDRYV5XjpiHYyZNb+S62U1l3I0KgY+OxJTHOccc7LleD76+n6b
    Vf0fTkznQWCQtUJWgIlosDWTwuMIFaBxPt3fTu/P9Cx41Cuvrk6EyPr+NNfcbSVCPT3+Dc
    C6efMtdHDRJF5NN4unR+Llnrm9yKKGkxbNssZuc0MV99+GgEHaiE4b6Jv7DPfedmhEtrjl
    UIJxXa0C0eF7kFlLWMf7rGql7KQXWx+/7Zo6i0e6y7H1udqz2uSFZ55rFZXpgMXMistz7D
    Zk29AuVpkBQ7eIeXTsIe1jlElcCjhKZ98d11EqdTlN+SxLlaQ0qYrg2hFiC7rk7Z0xHush
    K9qxGA9r9bA+DJsK+gvEQJDyEf/Nje3JyMT30TO/jD0s1jUq64OZA3eH2rX/baT9aV07uW
    /0N+FyM9wWpP0OQp/HyxcNnogudiUmrJVF2x+5mz0vn0or/bvBKyNGRHknV5jd6LctLRrs
    NreWOgvHxQuVgqrQhAqREE5mmN3QNL50aEvYQ9IYE185+CNuQXUwyhUVuhpB3YwemTtuVR
    W7fSDVX8syzj1Zwup62/44G1m/o5QyKXuhvTr2/+ViUz44giVbKmsoK0DcYYrLyhtZgveR
    pWsBextCNl2jhgbpBOKAcsAzCjzYtCxR/ikUDb5WDopHK7EDMtm8jgmNopqw
X-ME-Proxy: <xmx:TU5Patfqisel_f6GRr2GzkmMrd_mM3Q6uYJ1Zyy0itvvSkJxJer2pA>
    <xmx:TU5PasiAn1EusVAMJPuMW64NfAwrg0HxBnQ-1KVZy5i-CZ7swB3WuA>
    <xmx:TU5Pao_MJwVNMtJuQoUAh4kLwGksACxVfuy7P9PRVJrkhmFz-HoCWg>
    <xmx:TU5PasnSS9IQrhEl89kNqE-pAWvYUd6VkGkmmUMIdqYK9WPKX8MBOA>
    <xmx:TU5PanYmakzPKwNq4cqhSN0xrpn3o7hTRmvlzhBLatIZEAe_nc37rfPh>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 03:31:24 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 09 Jul 2026 09:30:51 +0200
Subject: [PATCH 05/11] dt-bindings: power: apple,pmgr-pwrstate: Add t6030
 and t6031 compatibles
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-apple-t603x-initial-devices-v1-5-55b305833123@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=994; i=j@jannau.net;
 h=from:subject:message-id; bh=6j04J5ZsMYC1glEYGPI5SeONi9pfivKJ6lbbwpnFQEk=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhix/P9tbgefVVBZPCFsibOmfd+rOtnb2kJPzPSw3W2Zfn
 8v8ZlNDx0QWBjEuBksxRZYk7ZcdDKtrFGNqH4TBzGFlAhkiLdLAAAQsDHy5iXmlRjpGeqbahnqG
 RjrGOkYMXJwCMNUGnIwMvf5TlF6V5sjNsHu8T/xuePXc1JwTP0O+HG7iWTi7tbOnl5Ghy17vlvD
 x1RZlC9ztBCPqpcTtLq7cGTrt0GZNzcfaE3bzAQA=
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
	TAGGED_FROM(0.00)[bounces-9658-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,jannau.net:from_mime,jannau.net:dkim,jannau.net:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE78D72DBF2

The pmgr-powerstate registers on Apple M3 Pro, Max and Ultra SoCs are
compatible with "apple,t8103-pmgr-pwrstate". Add
"apple,t6030-pmgr-pwrstate" for M3 Pro and "apple,t6030-pmgr-pwrstate"
for M3 Max and Ultra as per-SoC compatibles.
---
 Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
index c9be097cfba0..e269f433524e 100644
--- a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
+++ b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
@@ -45,6 +45,8 @@ properties:
       - items:
           - enum:
               - apple,t6020-pmgr-pwrstate
+              - apple,t6030-pmgr-pwrstate
+              - apple,t6031-pmgr-pwrstate
               - apple,t8122-pmgr-pwrstate
           - const: apple,t8103-pmgr-pwrstate
 

-- 
2.54.0


