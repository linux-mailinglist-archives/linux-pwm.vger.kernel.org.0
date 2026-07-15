Return-Path: <linux-pwm+bounces-9738-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id frfzHaxQV2qNJAEAu9opvQ
	(envelope-from <linux-pwm+bounces-9738-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 11:19:40 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1861575C626
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 11:19:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jannau.net header.s=fm1 header.b=gKEGHd9k;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="A oFdJSe";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9738-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9738-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D28831FCC9B
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 09:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A133FADEE;
	Wed, 15 Jul 2026 09:12:22 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00123F4853;
	Wed, 15 Jul 2026 09:12:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106741; cv=none; b=XkcFYmlQjc7NJrE+nEzXIMQilZ8XPbRq7mql4vCiHMX+N+C09DMndK0FRaq8YsjRnMxVHGPO9U0WkJ/wgjAI41TfK9m7v8dj7joS8oB4XuK4RsEj9DtlorT6lO9+U6TBJ+4eWu28kJ8gna3qcVGnfwHrwe8RAp0Aypvz3Y1tE4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106741; c=relaxed/simple;
	bh=+Z+vDT5+Q+hqSjcKRrJYe+eTksVcbkAkmGk4lrETmLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WsQju+vCiBJJtTKzt5ifIwlujp4+fBRnl7QZe7aiTGJLsTGPY14pGEEm1loM/pKpA5VVSP6d186YAsICXLwd6AwL5bkHNetFzLzSpjBcYPi2gd1/2QMmZLRP2fewhpudfwQYYftX/oJWYuaM86PfJx2wVwgxxFVEZT4yO0Zc2OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=gKEGHd9k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AoFdJSet; arc=none smtp.client-ip=103.168.172.151
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id EA432EC01EC;
	Wed, 15 Jul 2026 05:12:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 15 Jul 2026 05:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784106732;
	 x=1784193132; bh=5BTmpGAAJIGxFJa3QZUQ84cSW7EHGx2SH3vpZ10Sshg=; b=
	gKEGHd9kRH83Cpz2+lX32RqM8hRCityf/8yrLF7Xa1rrQ++qby6ApG4eHLkF+0LL
	Sue4vt4V12pY56CESlAgfu2p0CKTFhaf3sOUBSp0MLSqu8T6SSI+XZyoutkOFnkU
	byWaR/Fr7h+nvkoIOdVsFwzG/VdHjaPe0Y4pglVYgnh8/rartNIrDcdKMsBSSfXd
	zuGuVAEbti39/ZVepNEl5DEeDcdli5WSyn1J/QFsRPYVwW39gjUhK+eF/iK/zgQD
	h4i6JJYqKWCijVe+PttS7wKnZ4OSoJ3pE38JG+VLptMXHssdYyM47jP52A5CbWxZ
	Y5E+qeQooMmazT6yLkxgiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784106732; x=
	1784193132; bh=5BTmpGAAJIGxFJa3QZUQ84cSW7EHGx2SH3vpZ10Sshg=; b=A
	oFdJSetKA/d0yA2OP9CIEeqMZ97p7OkdgBncwuDWGEPWeBmbaRFRXZRD54hyNiHk
	lu/xpKpbJ3QmzBTKKrNgnNGGGxoaz8u/pOKdx6IgIGQjwoxzkQfKk+0P3M57E6lN
	eHh894gkG/LIlqIFWkZw74zOGtJCD3KLc4oBLsNVPUP4pXQvdzWwoEIBvQ5aPm+z
	2PgzFLUXM3bXNgKiDe1sv5jxe0vnf6wl2oB6U1WPhGr3tnvhg4uSxSsZTWfAKll+
	e5Yi6e/UmZ0qSIGLeIwI9xDGumTHa6rvjP629/KZLBkBul/Z8T0pqSPKX6DdnvCH
	qlMTKImTL4DjrR2qnEwRQ==
X-ME-Sender: <xms:7E5Xap9lhHdMs6Fb7CS1IX4OccVcnuhq8boa1IB8cD_tG6LBddM2mg>
    <xme:7E5XauHSTjGxofECkjws8Pv4LS20XEceqFHvM74gHS47co5ZrwOAur8uyTbRwqljW
    qg0rdFKxYbw-kGHLDa4VWctO9_Z7YdDQtFRTYQLh9bYfrumfvMjvoM>
X-ME-Received: <xmr:7E5XaoL9K9RDXZ78A9jL3x-0ABumJp8nbabmD_ENBDSZhA6GDQrgXHcw_IasMN87YjlTCGKnMXEqsTaF6czm1QGR8MmuTENYa2ORBA>
X-ME-Proxy-Cause: dmFkZTGbEfTGVuHxOJuyKCFvk6zsdjnpTYAj03akCpyfO8+qFj/r9fUNl/dlR0wUY4Tkjz
    N8whbTOR/VZbolzdOo7RwWDDl+GFFDRX6xEYLButw8EkfRcs+qKzpAB3eI9bWeGQ+KZjDf
    vUjxxEC419LJG0p4lk+H/82r2oPAXONqCfgFlRnkrVqzMF3n4ZpgAOgs+drcWhplhSKo2V
    cExiHLUTnIX3eCBvpYgjx7OAUYt6zgl+tNWD/OKuHEYmIxB1ztf6XbODt0covZvJzlkiHE
    Y7hBjEUjZIPYOrZGRddUvW/Z6GPlxjye25BjJzBJOTpI0FPf5NjIM46nLCzefle7QRZCDb
    ZNVylJNjHCMYzMSzdYrbAQqyCjt1rHoy7JILcd2QYZSB81vTbgEa7qCV4SE66u+P9AE24F
    cbjwqCyV9pk2JDQrpUR9luietPVOcxUizCV/zHCX5Ycdzd68zF6fUkpW+T1zRt2W8w9FMe
    2DAgAU0anlO9KAZodZ2vaUG5M7ayMK+yRVmxRZu1qVVUkNe3HP6Eecz34PRg0kdrluqvVE
    KGF6giEbxec50ulr54BiRfO5BYs36TysYTd94vAWYJhhf4jdZd83Eqb98KyFOMcwD/HkXS
    ecqk8LkUbIfKBCRkhpx52bUDUb0R8FBmgOrADJswvhl/X1zpidffjLXXAc4g
X-ME-Proxy: <xmx:7E5XapdtJ-rMRg4fx3eATSj0LAprDOtUVyNaQkyXJT7rHnp9GCmfLg>
    <xmx:7E5XatVXorOhwbyEi30FbTzt66u8McDTMqMBCajp3O1L1AaLGqrQsg>
    <xmx:7E5XaoFrILCcJYK1EcvnqdIMOF7WNjG7_H2A1pedv5JJiX-86RnXTQ>
    <xmx:7E5XamVJdV2Tp3qdkbIuXB6aEkMVVamVqTARA-m-97fqkoIEgM-PAg>
    <xmx:7E5XagNB0V5UF3UKs73uOkXbimThhaNN_t4fhvAttaqpvQr5y2CARqSG>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 05:12:12 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Wed, 15 Jul 2026 11:11:54 +0200
Subject: [PATCH v2 07/10] dt-bindings: i2c: apple,i2c: Add t6030 and t6031
 compatibles
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-apple-t603x-initial-devices-v2-7-df65b2485710@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=959; i=j@jannau.net;
 h=from:subject:message-id; bh=+Z+vDT5+Q+hqSjcKRrJYe+eTksVcbkAkmGk4lrETmLo=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqxwv5vdzbYJfD/KcuumzfXZXmDOzxRw86FjY3Xthc/d5
 3/qLbrXMZGFQYyLwVJMkSVJ+2UHw+oaxZjaB2Ewc1iZQIZIizQwAAELA19uYl6pkY6Rnqm2oZ6h
 kY6xjhEDF6cATHXNOkaGJz091Vz2x9IvfjLgnhwZnDQnd/3Cn/7HRQMurBQyc+0OZWRo/lD89/U
 D8XRWJSnnGzUTl7z4WmxRmH32zaWJzc27GaIZAQ==
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
	TAGGED_FROM(0.00)[bounces-9738-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,jannau.net:from_mime,jannau.net:mid,jannau.net:email,jannau.net:dkim,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1861575C626

The i2c block on Apple silicon M3 Pro, Max and Ultra SoCs are compatible
with the t8103 (M1) one. Add "apple,t6030-i2c" for M3 Pro and
"apple,t6031-i2c" for M3 Max and Ultra as per-SoC compatibles.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
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


