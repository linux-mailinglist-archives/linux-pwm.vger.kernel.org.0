Return-Path: <linux-pwm+bounces-9659-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n27cC7BQT2oYeQIAu9opvQ
	(envelope-from <linux-pwm+bounces-9659-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 09:41:36 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3030972DDC2
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 09:41:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jannau.net header.s=fm3 header.b=sa7Z4+uB;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="P +9IFoS";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9659-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9659-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F539306FEAD
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2026 07:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49003ED10F;
	Thu,  9 Jul 2026 07:31:29 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF9D3EB7FD;
	Thu,  9 Jul 2026 07:31:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582289; cv=none; b=ms4hNO+dYgeG0T0s+ycY1ebynmJSTYBgtfiVfllVt2XBTrzjQ75/BsoL+PNwvc+6JH7UUApZFA3hYWV31mzSSUb65+BXu3wXfT1CIHd5j58AhzhejxLD2YbZBJIEeXQtf5ekDYtT36vM4CxlubeHp19WfPnqSuCuKHGcP1tTtiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582289; c=relaxed/simple;
	bh=6qF9+LQf/ahNi17synXQrvJc75Sa7pH4BXwkTf4Bvf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lvx4ks69SnK1GADnINPowg+cEglNo+kjcKUghltWOUSZEy/3DDm340j7+hKlBsq7BSH62R0cq5YEIY5qJrRrb5mztXlGidpMeoXoXp2eaeIEC/krXVzNU160brdxiIEoAj+gxcP/joYHSub/kCFY9fmnFnjk1Q5N/F9nU9IDiok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=sa7Z4+uB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P+9IFoSl; arc=none smtp.client-ip=103.168.172.141
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 7EAEC1380140;
	Thu,  9 Jul 2026 03:31:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 09 Jul 2026 03:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1783582287;
	 x=1783589487; bh=u7PlXoIiOCrPIQKlfbRweJ5ktznIESIxsbV+6crBLVM=; b=
	sa7Z4+uB2yhPy8EDyrVi2APYP7691CdSYOMjEiqfYbdhqe0pAlKsBoV+xaqTxI9A
	w9yjRvmPe3fKeX74g/vPIL4hyrPG2JOb5BIl4QHsRnOwJ1RcKL+ex3+/ChlvUIXk
	ZnimqzrAZidqkWMWelVN1+o2zmTjOqZdALUb9ulMqmZqO0e6u7XDzOYUxOjDExzW
	QPEN9HZnOStV5/3Tcsdgh0CoffzQZhTGZZMCTZOx0G1+gF+vxKULDW9cEaLAQamt
	fT87qp8Ox6AyZwJkXj4k4lC/2fgNdTdajsojFK7tJtgjhIA0RFxWQ61uTS1mpWXk
	dgzZK3TBPXtzsyq0y32yxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783582287; x=
	1783589487; bh=u7PlXoIiOCrPIQKlfbRweJ5ktznIESIxsbV+6crBLVM=; b=P
	+9IFoSlOUQ54GDb+4js5y5Owj10xbad54ohXY7hYgxuRhdPk4GxPiZiW/let3M69
	+nULKQXZZhMQKSszyuaRKiVbpFRflnCvFJUsk/4CW+PMdd+avNYiCefI450kvA5C
	mZ3CyYhZ1QofLkSyFOuW+dPZt+UtBqF4PTPdx28+bK3EkGFxfPfwacN9hrqEBMw9
	9P43tYEquel+2yP3oDpddOGf+KaLYSJPc/+VXOEEzKbEdyAycRIsKuvd9lNIX6Mo
	1GMmt6Coy67czyj5ygwTrReCwYvp2xhESePqqvyLWzGv73w0cfycgIMyqtPJwNdm
	tgG2usq8UjG+r/KLOV1Zg==
X-ME-Sender: <xms:T05PagMu0KtmKKAThENdwEN38TVH3utSO9t_CPrFcSIOm6NKd9L9aQ>
    <xme:T05Par08DzhN4w7BJKx0HrS9iGyWwH2B9qpVi_P17ba1W8Z1IdyhY4vkhHSJe9sR8
    SJE3NC8f7v4FkpBODkjol3d28QJoX_44IEQd0L8g0qtADFjdURZTT1K>
X-ME-Received: <xmr:T05Pak27dsuk6qqA0qZSJk2C-1uVIcG42RvRR6oKkFpG9jCIkKjNI6BGLXNKPz7MC01uRRqhU4trkUI66nSt2ZGkfpJobIh5YLE>
X-ME-Proxy-Cause: dmFkZTFDgvji+KZOYa7+nDRYV5XjpiHYyZNb+S62U1l3I0KgY+OxJTHOccc7LleD76+n6b
    Vf0fTkznQWCQtUJWgIlosDWTwuMIFaBxPt3fTu/P9Cx41Cuvrk6EyPr+NNfcbSVCPT3+Dc
    C6efMtdHDRJF5NN4unR+Llnrm9yKKGkxbNssZuc0MV99+GgEHaiE4b6Jv7DPfedmhEtrjl
    UIJxXa0C0eF7kFlLWMf7rGql7KQXWx+/7Zo6i0e6y7H1udqz2uSFZ55rFZXpgMXMistz7D
    Zk29AuVpkBQ7eIeXTsIe1jlElcCjhKZ98d11EqdTlN+SxLlaQ0qYrg2hFiC7rk7Z0xHuex
    96SP6TUDNib5CWq8FO9WrL/spXSXAjPCh/lp2j0A+P7U1a7Hp4bIw1eCUCiuJjmxLxkdOj
    WLrsJ51jTsZr+Yq/yWTV07wXtJzPxaYON5PUNNTYucuLmSUTpzGnI46WyO+mEe5lokxeYy
    r3pNxnfOd0XEOgBicDrnzjA5rsgIRVz9Bp6sperVy5pbFEyR24bk92f3iwxbmKwbh4krGc
    RBJEv1R0Tu6DZuA3Hi2ODnVlUKTSJxDVaJX08Yz8NnarJ+820WGEVZEmtLFj+IrG9uasDS
    uDE2jBIccG/LkGST3ztEZGNHDBRtsZ/H9F0nzR9yY7fSYSI1DHs/pZpROYIg
X-ME-Proxy: <xmx:T05Paqy9c8v_-83UTRO0b1xxltdz9VtKqfpWFrAIhKMMu_qXjpatiw>
    <xmx:T05PanmjiDur7PQSfmf9vpWVbkRkI0y0DdYAqL9KT1N8qwAqA9_lfw>
    <xmx:T05PauyXwotjL1aZCXa0Al2ieGUOXyoGSd_qee5IfruvOjO59yNFwQ>
    <xmx:T05PamL3pVRFVOnDTaLSXfRq5C6JNQUtpUUtG8gr5mDJBmbsWNiBag>
    <xmx:T05PaqMU25wPu2t0l4cSlfHyOji2Pm5FLaoGHy8EcgQ6DHRyXXswYcET>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 03:31:26 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 09 Jul 2026 09:30:52 +0200
Subject: [PATCH 06/11] dt-bindings: watchdog: apple,wdt: Add t6030 and
 t6031 compatibles
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-apple-t603x-initial-devices-v1-6-55b305833123@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=929; i=j@jannau.net;
 h=from:subject:message-id; bh=6qF9+LQf/ahNi17synXQrvJc75Sa7pH4BXwkTf4Bvf8=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhix/PzvFvf4XlPbuml1waZ/n29NfLCeJJ32fscjQUuY5n
 4HoPjanjoksDGJcDJZiiixJ2i87GFbXKMbUPgiDmcPKBDJEWqSBAQhYGPhyE/NKjXSM9Ey1DfUM
 jXSMdYwYuDgFYKpZ7Bj+qfhfCMtJfy7iULYkTHPitNUuCW0WhQwK73VPcU6dnrVbipHhkMPCqbK
 WQW+NC2u+Pdoq01+Z8uVK+Ntz5pd/fGXuqW/iBwA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9659-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sven@kernel.org,m:neal@gompa.dev,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:tglx@kernel.org,m:wim@linux-watchdog.org,m:linux@roeck-us.net,m:linusw@kernel.org,m:kettenis@openbsd.org,m:andi.shyti@kernel.org,m:ukleinek@kernel.org,m:k@chaosmail.tech,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-watchdog@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:j@jannau.net,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	DMARC_NA(0.00)[jannau.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,jannau.net:from_mime,jannau.net:email,jannau.net:mid,jannau.net:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3030972DDC2

The watchdog on Apple silicon M3 Pro, Max and Ultra SoCs is compatible
with the t8103 (M1) one. Add "apple,t6030-wdt" for M3 Pro and
"apple,t6031-wdt" for M3 Max and Ultra as per-SoC compatibles.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/watchdog/apple,wdt.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
index 845b5e8b5abc..bef8255022fa 100644
--- a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
@@ -18,6 +18,8 @@ properties:
       - items:
           - enum:
               - apple,t6020-wdt
+              - apple,t6030-wdt
+              - apple,t6031-wdt
               - apple,t8122-wdt
           - const: apple,t8103-wdt
       - items:

-- 
2.54.0


