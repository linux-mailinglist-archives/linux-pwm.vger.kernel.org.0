Return-Path: <linux-pwm+bounces-9736-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Xqt5DfhRV2rtJAEAu9opvQ
	(envelope-from <linux-pwm+bounces-9736-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 11:25:12 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B27475C722
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 11:25:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jannau.net header.s=fm1 header.b=AbUl8UD0;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="O LPX7VF";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9736-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9736-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 966AA31009D4
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 09:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E373F8246;
	Wed, 15 Jul 2026 09:12:19 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5CA3EF646;
	Wed, 15 Jul 2026 09:12:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106737; cv=none; b=Nti8lzajI0BT0IQxm04lbNCDzq/s5JCjjNc5UWfAVt3qt+SB3CJUTXZVRcElAtUxXIt+o3Mq4+vRZedTBcqE1B5HEoMQO+1JyY+DPyP9EAkKoFxs4a0BVG/RVO2tgtodU1oWj2VLbiU3sVkBoPKJDnd8ZUdt9Nt6RGhiTxjFBlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106737; c=relaxed/simple;
	bh=S26aWssmrcL04fggmWOi1VbjBZkaSi2GWBxk3WpTUnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PbjIyhN9ATKgl4qDoej/0753NRgROD4XAgM+Hh+ZThy1GgErLWbJ5jSC1S4/Qzh5O1iTa1gTL51Kiw+ZWR7/fHvBHupeKEuRCoDx6cRYBXHby0EE45iK4vQqXBQ5ubX+nPaMAd8+gi/UZI5juOucHfvG4+5an2Vj56cYCaOtfeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=AbUl8UD0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OLPX7VFG; arc=none smtp.client-ip=103.168.172.159
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 795FC140015E;
	Wed, 15 Jul 2026 05:12:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 15 Jul 2026 05:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784106727;
	 x=1784193127; bh=f4HRh2PONW6e6WBYwL+bRJGF3U1xDlt9qqHYqQt/mB8=; b=
	AbUl8UD0NKu0OJyWD2u4Q1XAwtNEdC9yQh7MV8VOWaZb1LYUEDfX+1rAlxOrh4Vb
	j2RNLCfkpcLpzfyxUJwSX686NLAqU7UyJq9c/3dbJwrACF49rNXFCxJl8aBMjWOS
	dxV7std0EMPdlaOCJDXfeikIwjSdg30RZIIinIj9UAEI+D3Rc21dIgAUWH2tYVE3
	tk2uRkjlUHVQ36ro2sGgTYVi/AgJh04zcHHUKpyqV9ggAhNBNL52k1C513E+YqQ8
	Fv1+lkG8NzwBvAReQaJrbgT3epZ1oy8PMBPl/GLQHkwi0Rc87GjRaegxjDQZzpYn
	14PUPNjW4lm21592UCQGAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784106727; x=
	1784193127; bh=f4HRh2PONW6e6WBYwL+bRJGF3U1xDlt9qqHYqQt/mB8=; b=O
	LPX7VFGuOC6Sabc6EiWqbwywGNxJAKeQv/iUKJBCHPMDSg9C1bhPYoUzRoNNYHmB
	m+DoecJrZCNbQICdPzNfGJiz31YKE/NuoEww6r8u+WVhmS1dCesUOG6VVQY0jrYp
	B2e/nvZViNfvR+8S+qHum82Rk2sOrDutBaDaniMaBatlSowIuB/HzAjUNwYE2UEd
	VPsr2L4Wnl9H8vKQ+G49jlsRP9DxM4cyQHKdvptOHwajaEMiEknixXDlrpQnLuRa
	QP1gbQ/CVbltj1nRPDzgUZqPZeUdk+h8zrebA6ga/XU1in4QFXMZB5GhqGWxR4AZ
	kV4RbLRrkR8qU2mkPuMfA==
X-ME-Sender: <xms:505Xapgc6L6AVuexQ9Xo2SW4D8WawvKOPMcG_Qwq5YtQONuVmYsjpw>
    <xme:505XauZws8iINoDve1jDrxpyBJKVjWERSREXj2wEn5zaYk-Ktt0BH1N7vwjgpKVN-
    bQ-1o4vQT4L8R2hwsVrsBNZ3zznVXayxjHa5mYvzzIBmPa33ZzT_WE>
X-ME-Received: <xmr:505XaqPDl7KCRYwQ7iz3AVMZdWEZXzR-iEaVk2vwnkDPdRvvuVI5VG9YijIGYVLfPZ_L2li3mgofhKuNPeGi005ihPY1hH3HfcXM0Q>
X-ME-Proxy-Cause: dmFkZTEW04HtTf+zNef7m5r/Wybx1ydSPmxeGPzAYI5SWVBIt9NF+gliEmmzRtNMmeyncy
    0yH12g4gcKN4bwgQ9/fxkVDLkA/oJQKBqhvmVPbO8YzIkt35ekG+/k0lN1XR1RUOe2vlYy
    9oh0a9s2MeN7rHW5UMydYFPb+rmR89Xmz+kCkWxhD+fm56RfXxSYKM4k+nBq3+TLUtm39d
    wb/YON6eLtDPA751fCTGB9EwOodztE2RbFbzkkek/KiqmBaiq89taQ8SgYyX4XMGIxWBrs
    FEpjBwG/7g2vXO1BGnw4zPV7vNeivmHu8Q5ocRpo3auKeu4wiZy38k1ASmncIsKxkpduQg
    Sxbztx1UCoyZBkFI5KZinpRhQoaodwh5fddm255XUArpeSXsIP7tbP9guhW4USnO88izTC
    hBtl/WqWYmCrHUY0LzIt3tGKSuHG/JCP3jSVr3tpxcd5kzJlzqy7oo4zd0A/KdkK1osBFi
    tOSKvVNQN7i1khBs9f9/8tHJGPKD7E0/b93LcyimE2XDY4clHatfp8coTbKCJAtZhMXyNN
    O8/jhYE/G0xSEcHLxN65l7l1Hvz4hY41/BTHsXN+4EovuiPLQj3frD029ldR5ESC2QG5O+
    kyTEQQZlBcsJgxZ0bZaggS5GbKz62RnR5uQZDp2FbSLokfGtKEVtJrzsBlAQ
X-ME-Proxy: <xmx:505XaqRveLZUpdwDlx_srif-A3NIqcQx9FF2kQPuZQ44WfMEFg3WnA>
    <xmx:505Xal7l86Pg5lOlvqXHPIOranzbJEwk-aXWpIqE6s0grKbR9fqvGg>
    <xmx:505XatbETpDBHAyYb2Y_J5jjn-TuqInkNb2vnRSb0cjpazV2qpr1QA>
    <xmx:505Xapawz4WJs96E2vgvFK1yPiTvNGTOkp_wf6tcA7SAMZ245ZT-Qg>
    <xmx:505XaswkYUnW3RLEkRNPen80RHtDthDk9UlHDP8zJ2P51adlGHX35VNE>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 05:12:06 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Wed, 15 Jul 2026 11:11:51 +0200
Subject: [PATCH v2 04/10] dt-bindings: arm: apple: apple,pmgr: Add t6030
 and t6031 compatibles
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-apple-t603x-initial-devices-v2-4-df65b2485710@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=999; i=j@jannau.net;
 h=from:subject:message-id; bh=S26aWssmrcL04fggmWOi1VbjBZkaSi2GWBxk3WpTUnQ=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqxwvxsKZ7apZAV+ZFrXcq25mfn+0v1nt+Wnpzq9/lLI+
 bf3fuTCjoksDGJcDJZiiixJ2i87GFbXKMbUPgiDmcPKBDJEWqSBAQhYGPhyE/NKjXSM9Ey1DfUM
 jXSMdYwYuDgFYKp33mf4p2jj8P7sH5+0eBXLM49mzPm5/aBDM8OK8wlTs/655vptCGRkaNtjd8S
 3JG+Zj+nP3LDt7Y0vXh/7sOF+RE/FxKCcmsPZDAA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm1,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9736-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sven@kernel.org,m:j@jannau.net,m:neal@gompa.dev,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:tglx@kernel.org,m:wim@linux-watchdog.org,m:linux@roeck-us.net,m:andi.shyti@kernel.org,m:ukleinek@kernel.org,m:k@chaosmail.tech,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-watchdog@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:conor.dooley@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	DMARC_NA(0.00)[jannau.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 8B27475C722

The block on Apple M3 Pro, Max and Ultra SoCs is compatible with
"apple,t8103-pmgr". Add "apple,t6030-pmgr" and "apple,t6031-pmgr" as
per-SoC compatibles for M3 Pro and M3 Max and Ultra.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
index c67b67ba065a..1d2001836eb4 100644
--- a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
+++ b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
@@ -38,6 +38,8 @@ properties:
       - items:
           - enum:
               - apple,t6020-pmgr
+              - apple,t6030-pmgr
+              - apple,t6031-pmgr
               - apple,t8122-pmgr
           - const: apple,t8103-pmgr
           - const: syscon

-- 
2.54.0


