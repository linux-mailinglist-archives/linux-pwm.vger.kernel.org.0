Return-Path: <linux-pwm+bounces-9655-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tQ59HopPT2qneAIAu9opvQ
	(envelope-from <linux-pwm+bounces-9655-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 09:36:42 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B1A72DCDD
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 09:36:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jannau.net header.s=fm3 header.b=Hjj0fm4Q;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="g 1dYVUs";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9655-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9655-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D37C530331BB
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2026 07:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708C33E5EE4;
	Thu,  9 Jul 2026 07:31:22 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1583E51E2;
	Thu,  9 Jul 2026 07:31:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582282; cv=none; b=ly6u2SGE9VHdk2y9L5VPKB8Wqmg2cfse+/7j8TdWdlfth3M9QMYkqtRjbVubcjx2RSIEW7DDUV4KoTdO4dbYwWY0LN96gzt2ArEVctmy7ojpiGip3Yq57Ov5DxVm8DsfdPRxubw0PYVYXmDAsTkD6ySdv7YtAFijbe9ZtfIU5Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582282; c=relaxed/simple;
	bh=yxRKZLxoxk7Y1QKVW7z6u95eMhug7tWF1IITEe6Dojg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tCRebmmtjfUa5dzgEjbc9WgSkQ5H6O3/0f8CyS+iXWdMRqYC6cU9fNAMLwPbNqCVOWHR/aqstjV5AFsNjC1ulFp4sUsJDPWQ/N+ESUDtZ5EKy4wHGbyzX8MMNYKzynrCIXMVfGrfeL5iRi+RmdHm/F1w7KXtbQ7Vu3ZVPxf3H54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=Hjj0fm4Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g1dYVUsO; arc=none smtp.client-ip=103.168.172.141
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id A0A1013800A3;
	Thu,  9 Jul 2026 03:31:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 09 Jul 2026 03:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1783582279;
	 x=1783589479; bh=6AeTQzIzHBeFMVZbMOHIYTBm0lF6jvBV/+e/FiVKNV8=; b=
	Hjj0fm4QY0sZpzWnVcpZPeISxW2xep7myJhp1XvNvABpE9dZZWMIS/rzEDqY7UII
	YM2xliZOqzAoVP25Hs3eFOK8q3QpE/YIZyjzXCZ1DjPe3CkgPEK2s+fPGmXZamm9
	q0ZqAottj3Ko4y556MJV/GJ9iLolUD9iMCgK2879XHjp7FVHR24gRE5xgtBE8Zm0
	e2VwjtEkK57Tf+BB/K9qiiiPBAlyNDt5bQiT9GM9eWfZp3seJjqE9LSTMghGNe5B
	IesBBQMrNPSq04vjVZdZgmDIYMiFrGRdDxrqyGN78xPVnJs/8hY/pX/16mUOmA/w
	or+20GpO45kE2A/m4UyGQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783582279; x=
	1783589479; bh=6AeTQzIzHBeFMVZbMOHIYTBm0lF6jvBV/+e/FiVKNV8=; b=g
	1dYVUsOiiSmSeEIlCtS3fPdvsdZDpHTY3mowA+41IrsmbKjhVSYC8++lJO/FDraQ
	eTL4uOfhDmvmND5j9LQGr1bEb/ZGuG3am63R9+NMyAnAYvfUnoDqUSIYAPOQO1Uo
	AyBSWrRJg5i3VTonN2/KyE5Rb9PdKsAIhob7PNHvqV7jf5+Lwa/mPtynVZf/N5S5
	y9FY6E74t+Zbt49n4BOxyScjWsVrsglxkMMsCabYdZ/Wx5NqHBm4pHCjK6nuHrUR
	anoJf/exuLV8tRRgTAkfzlr9z8edHf7hs7srJtiu91eN1hzX5cVDdUt3ZKZy7SDc
	6r0p7AgAW5H+GqBwDxZ5A==
X-ME-Sender: <xms:R05Pao7qQ7vrdZDYHl3n1nVpcIx09AjhCch-Y0OJOmlNpk4bpIJQjA>
    <xme:R05Pauxl3yHKP7r4hDw3K42xq436kAXF2XbBjFbLWdg1WbrW8dxkskipDuk1AerXk
    uVQTbFpysJ7mF0czEEMX_sgEbHsE8jiFDFeFC15Uz6y3kW3suvbJ0M>
X-ME-Received: <xmr:R05PalB-bBfrFOcdg7jVHNTYvc_giBOvpLSfC3nr3CymrDYd1fsQPHZWd1I5le-YeC2rUTxosLXmPXo5kVAP6jfe-abYAK1MKgQ>
X-ME-Proxy-Cause: dmFkZTGYKeAHgJKVIjqCymJpihoZrEqDQaRIPCKXxcc6uiPXzJNTDc4H4LzsUaMF9MJqYB
    2rpTe0oGhrtQRwfHcGfbJPzdaNrx81amtkEDFVv/fGamGt7vZBPR3jcucmA5JRiTwERHZr
    8zGRG/w0d07G5jQ4PlCj5gdYeuagoIAoYXQ4A9l2tOaakbVPoRmPGeCRSKDT6z7tQH03AB
    WTVwikV9P4YqczS+ivH9R0MDJM1iJWbkLmAFvo0DWmHZGz3C5uxbmrt35Eg98JoTPuzJKd
    X/sNvlqMxvVsFiGXNnL3d3+h2N4QVm3ifsTcrDacstkEioZW9DpvzWMrk8s16EPWaQL8MG
    ZAbowBZnyXLv9tsluktebIjGBtGna6618xVyGFC2mYgWtKZYeM+pQvke/silwCVX5Ge3VR
    Kg7Kj8Nh8cDYUIV9qspbjnjh4lj6p+MECTV8TEVE6tvqhAFuyYQEyw8IdZEb5ZIBjPa1gZ
    WXlBWiUNpUdEIxwSPN32jX/cjd/R9h/ZAJZdNRAfAMI2jSVo3IbyrUxuDz9j5CqSAQyRyD
    dXUatib5QbK2Sn/nRYOS4ZDYNaj/5mYDPKFmi9qp85y+KyqNBDvUJbBcmacBEiptS/a9Ng
    tA46s3a95YKozWlCKfGx9iaeADmTq467dhS8VPZ4CvI9FUXMjcNM+Ca4q/Dg
X-ME-Proxy: <xmx:R05PavN3EFFZrZP8Px0MZ7CYRrnBHDC2msytRe7JBSHL3psr-Z7kqQ>
    <xmx:R05ParS9EzpyT0U1QUFw4CQCdwLAwS9Uytt9uISdc7cN59Ps5dr8Pw>
    <xmx:R05PagvF8T6U1XCYXO8T5Bovf05W1sDdqFD68WNM3GtVY5Phy7LxqA>
    <xmx:R05PapUH2nyuuTysUxSSLPmMv9nI1t5WqKTjhUj3xRe2vx7DAlq6xg>
    <xmx:R05ParLi3iDwZdyHU-4VrqX60O9PXzhQEEQ5vBsQQE_DaznU0tPnLn3N>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 03:31:18 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 09 Jul 2026 09:30:48 +0200
Subject: [PATCH 02/11] dt-bindings: interrupt-controller: apple,aic2:
 Invert #interrupt-cells condition
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-apple-t603x-initial-devices-v1-2-55b305833123@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1499; i=j@jannau.net;
 h=from:subject:message-id; bh=yxRKZLxoxk7Y1QKVW7z6u95eMhug7tWF1IITEe6Dojg=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhix/P5sv6jJlRW8OS114FsP4Oqdq+9xyk8CEU6a/JBb19
 tz4MamzYyILgxgXg6WYIkuS9ssOhtU1ijG1D8Jg5rAygQyRFmlgAAIWBr7cxLxSIx0jPVNtQz1D
 Ix1jHSMGLk4BmOr8ZQz/M63czQqvcbPlaRyW/xFw/+W+xdKPkvhi2Gv7Hu55EHNiMSPD6XOCv3e
 8im49eXe7xcO7+++KTLDSvXqrNON170PbxDZBBgA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9655-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sven@kernel.org,m:neal@gompa.dev,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:tglx@kernel.org,m:wim@linux-watchdog.org,m:linux@roeck-us.net,m:linusw@kernel.org,m:kettenis@openbsd.org,m:andi.shyti@kernel.org,m:ukleinek@kernel.org,m:k@chaosmail.tech,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-watchdog@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:j@jannau.net,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	DMARC_NA(0.00)[jannau.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,messagingengine.com:dkim,jannau.net:from_mime,jannau.net:email,jannau.net:mid,jannau.net:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 26B1A72DCDD

The condition for 3 or 4 #interrupt-cells list compatibles for the 3
cells variant (not used in SoCs consisting out of multiple dies). This
includes the AICv3 base compatible "apple,t8122-aic3". This will match
    compatible = "apple,t6031-aic3", "apple,t8122-aic3";
shared for M3 Max and Ultra based devices which require the additional
interrupt cell for the die number.
Instead list the compatibles used for multi-die SoCs explicitly and use
4 #interrupt-cells for them.

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


