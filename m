Return-Path: <linux-pwm+bounces-9733-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XMc1Iu1RV2rmJAEAu9opvQ
	(envelope-from <linux-pwm+bounces-9733-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 11:25:01 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A9075C70C
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 11:25:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jannau.net header.s=fm1 header.b=JjPq4v2v;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="o 5idtCd";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9733-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9733-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9988E31366B2
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 09:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F90E3F58EB;
	Wed, 15 Jul 2026 09:12:17 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAC13F0A94;
	Wed, 15 Jul 2026 09:12:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106736; cv=none; b=n1Iy83oMQuQaQtjaQOc/VJUU14iTenAKfOsovf4komEvCQJQnVdWM/kX68TuGLFWrnl1xuJ+8x5VC+5d+V6swmORqzb1eEJExTSr1DgzOhVfQYhkd9EIpAwF30+J9k8GSgSjh7zJO7giiK+F+5Kw+WBPzLMM/st7CMz9LW1QZmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106736; c=relaxed/simple;
	bh=TaPp3YmDGKuL811lfs/as2BQJH0FaJPIrM4HTX3tMVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kcU8JPZCy7UXQVKI59BaDjckrTZbjUg4TStVq0BVueF80aIBSyo6pUtIbiJa6s7eOrcPo28736Yk3O+Nri3x0r+GDTGycBe/oPuJZQ49JzA1tL0OzOL9Ybvar73J8r2D50mL3Am0tdS4xYpKM7sKWzI+1ZotCUAej0xW7n3p8Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=JjPq4v2v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o5idtCdW; arc=none smtp.client-ip=103.168.172.159
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 23E64140014A;
	Wed, 15 Jul 2026 05:12:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 15 Jul 2026 05:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784106724;
	 x=1784193124; bh=Gwg1Qkumyzy7K7Uv0qmGTTBvVa/Ezn8Hh7q0O4lw1Sc=; b=
	JjPq4v2v5I+Itv2CMXjGQWCIs/C6IM5Lb3qf7W0Gz3vjhEenV2IpBnnfBE5SDIuh
	F1J5iGwpL1Qwif7fTFUYLH9jiRU+gHxSK2Sd5oY1mjk97upLYUE+BtCIPTHc3qb4
	XRnuEmzwBhHfNXs1oaF3WO8qbvHUmKvqhwHH/r+nUCnoCCveH3QQG2K0LJfCMR90
	/do6kmxWIMtTVxubHwEPtDIqVme6lGS2wb1ccTH/8BPZX2bAzIjeK+0dPAMFjuVp
	Qfn7g+7MTot2ivPmLJhZ4eyOdgHqHjQBHaLVt2W5XtPPdi8lzPQwOmT+GS1uxZOZ
	aFlkWgsT5VydWJDZVsyHCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784106724; x=
	1784193124; bh=Gwg1Qkumyzy7K7Uv0qmGTTBvVa/Ezn8Hh7q0O4lw1Sc=; b=o
	5idtCdWh0rAgVye9w44PEHkQezqqTg8wLVZJ5yDyBATsPG9EFbBSWy4bR7J+iqLL
	HiLmtDNcjQ/GQsa8MxHLw/ZC6sbk5u6e63oiW0holj76UeDUuIGUvKIJQILJh5I8
	yOe/Idig6X8+XZ5EU/NMwW4W0lQLVNJSew4+8zqENdUPJarvJDYnXf1/cNoMmFOv
	IPP+ZS0uXzSkj/CL//Or6hNh38spD+sneBhCuO8oCAQDKCyDadGhcfU1V+gv/ZH7
	mYqGTnSF5xLLVJqCU0jMICGmdbmZ+me2+UVMCv4Ktq+XaSPDyVo7CDlQsH0yafrv
	UIdKVtPab1Wwo847p4s2w==
X-ME-Sender: <xms:405XajBNWU7BBwdolUWEBnoPOuKinycHR8b3gmElFy7nQ5iua672lw>
    <xme:405Xap6xrSnGGt1U-g5fAH-pkDEFIA9q-VwaGVWhtMp7MAYUFBMCmACyWZzvN-xJW
    bSWf2Ej8mDEV3NQA9t2gOfgL66n1IXBwMcRsK6MjjO1eJ6TgBaZ2T4>
X-ME-Received: <xmr:405Xavuh6gyvXoCO0Uq528jPkVV5d_4UaP3JRxZggPORHF86fPRLBdCVPrts96JnDNpTp_aierVkuLow0plyRRQRHSll_15xFIs4uA>
X-ME-Proxy-Cause: dmFkZTGbEfTGVuHxOJuyKCFvk6zsdjnpTYAj03akCpyfO8+qFj/r9fUNl/dlR0wUY4Tkjz
    N8whbTOR/VZbolzdOo7RwWDDl+GFFDRX6xEYLButw8EkfRcs+qKzpAB3eI9bWeGQ+KZjDf
    vUjxxEC419LJG0p4lk+H/82r2oPAXONqCfgFlRnkrVqzMF3n4ZpgAOgs+drcWhplhSKo2V
    cExiHLUTnIX3eCBvpYgjx7OAUYt6zgl+tNWD/OKuHEYmIxB1ztf6XbODt0covZvJzlkiHE
    Y7hBjEUjZIPYOrZGRddUvW/Z6GPlxjye25BjJzBJOTpI0FPf5NjIM46nLCzefle7QRZCsh
    3A2THnwSNaCQziai36l8Qq4CzhkN0RlR5WGyfXTG5BYIU0csr3fDR3IxoT7t/ynnwD/CdS
    hYsaNHVr2OxaXdhXIqHiZ2PijZpxynSRqxAoxyhIqiF2SjKeCxLQy1BCnJmFLrNplJL3e/
    QcXMOSUy6tsWNjVvAOjftIKPsHi78gYOmg9XEDFFToRYjGQLQduAkva83dBRG2sXRTFOPo
    RHkyZNCccl3yN9F0M5Lgu4MW7RO+ZuFBf0m6y+5kGdNItaul5s59BbHR+QBmu6kwipfjGv
    TQBlpLPk/RC5Z4ajDmejmtXgz+IhDdcUwarI1cCKlkeDZQ4n7EKbZAqkAIbg
X-ME-Proxy: <xmx:405XahwrpOjC-hX6Pff99xu8t33gOtCXJwDFnpaIj-O1RpbABPH3IQ>
    <xmx:405XanaHoC0kbpjBj3pbxTYc62yBy_Q5F53Mrv0zy4318-6nGXDA7g>
    <xmx:405Xag5ZkYatUNEVcVqS_9x3F4iH2zSNlkj_WoPeu8hWB11ST-aczA>
    <xmx:405Xam4c82ScU50ZN4YvB-2SbxTc0hGFraxuQLF-ZxGTOfvgANNKTg>
    <xmx:5E5XauQs1g0wckBeGzGvZijbNa28P-LA3XsxtaxuNi9I79usZq_qHqMx>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 05:12:03 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Wed, 15 Jul 2026 11:11:49 +0200
Subject: [PATCH v2 02/10] dt-bindings: interrupt-controller: apple,aic2:
 Invert #interrupt-cells condition
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-apple-t603x-initial-devices-v2-2-df65b2485710@jannau.net>
References: <20260715-apple-t603x-initial-devices-v2-0-df65b2485710@jannau.net>
In-Reply-To: <20260715-apple-t603x-initial-devices-v2-0-df65b2485710@jannau.net>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Andi Shyti <andi.shyti@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Sasha Finkelstein <k@chaosmail.tech>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-pwm@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1552; i=j@jannau.net;
 h=from:subject:message-id; bh=TaPp3YmDGKuL811lfs/as2BQJH0FaJPIrM4HTX3tMVk=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqxwv+vJ9l/UyzK3hzSd1LISv5pqHL88O33n1QcO0/54H
 N6xz3Vmx0QWBjEuBksxRZYk7ZcdDKtrFGNqH4TBzGFlAhkiLdLAAAQsDHy5iXmlRjpGeqbahnqG
 RjrGOkYMXJwCMNWpKQz/LItNQk8++X1I4tDHcN4isXM3lt3aOOPdBcvEYhezpoBP5Qz/HRXiw8q
 emuVtDL7osja5hunV9hlTtc6FTLp+eY/Zpvo4VgA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm1,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9733-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sven@kernel.org,m:j@jannau.net,m:neal@gompa.dev,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:tglx@kernel.org,m:wim@linux-watchdog.org,m:linux@roeck-us.net,m:andi.shyti@kernel.org,m:ukleinek@kernel.org,m:k@chaosmail.tech,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-watchdog@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:conor.dooley@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	DMARC_NA(0.00)[jannau.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,jannau.net:from_mime,jannau.net:mid,jannau.net:email,jannau.net:dkim,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8A9075C70C

The condition for 3 or 4 #interrupt-cells list compatibles for the 3
cells variant (not used in SoCs consisting out of multiple dies). This
includes the AICv3 base compatible "apple,t8122-aic3". This will match
    compatible = "apple,t6031-aic3", "apple,t8122-aic3";
shared for M3 Max and Ultra based devices which require the additional
interrupt cell for the die number.
Instead list the compatibles used for multi-die SoCs explicitly and use
4 #interrupt-cells for them.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 .../devicetree/bindings/interrupt-controller/apple,aic2.yaml      | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
index d0d9a90e96e7..a94787939d34 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
@@ -128,16 +128,16 @@ allOf:
         compatible:
           contains:
             enum:
-              - apple,t8112-aic
-              - apple,t8122-aic3
+              - apple,t6000-aic
+              - apple,t6020-aic
     then:
       properties:
         '#interrupt-cells':
-          const: 3
+          const: 4
     else:
       properties:
         '#interrupt-cells':
-          const: 4
+          const: 3
 
 examples:
   - |

-- 
2.54.0


