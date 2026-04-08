Return-Path: <linux-pwm+bounces-8520-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGpLOnUp1mkUBggAu9opvQ
	(envelope-from <linux-pwm+bounces-8520-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Apr 2026 12:09:57 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3728B3BA583
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Apr 2026 12:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E04FF300B87D
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Apr 2026 10:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C923BAD9A;
	Wed,  8 Apr 2026 10:08:36 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB393B9DAD;
	Wed,  8 Apr 2026 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775642915; cv=none; b=bqmx6eWOOvWYEgnAsk5AvLo2F7qHK7QOTlb3O+mN7rqnzH+f9skpmp0dsMz8tSYSmUgdZCYpiix742F+hG+Zjaj7t6K9z2ibtV8hHPqI2BaCWLBWrMGnT8KqWiTU9GL81teDzL4UF2J1bPK/71BgMaHbA/SreB2bARQBWDbDDow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775642915; c=relaxed/simple;
	bh=hyoSGNKO8z6d1axQ29oBEAL7xl1kP5y9LqcBAulHLMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GlhXrLFl7kwZpqY/42HDdmQoCaPfo8yWM3igBtca0DkqScM9pGSa1lm79cb9lrCxPzTNtPDpFmI7CkLwqTmudtDX7i95sVQA+0XgH7YOgZkUfFRXr/G/h5jGgvOBChsNKpDg9itIdMWFbL8Pku/qGw5NTp1yYhJXwV6++6QLCN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpsz5t1775642866t6935ec97
X-QQ-Originating-IP: 4qODUJGb35PW82fgR5f0LCmXadzWoz4xrJ1L5pcMYPQ=
Received: from [192.168.30.32] ( [116.234.85.158])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 08 Apr 2026 18:07:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12296274181211464006
EX-QQ-RecipientCnt: 10
From: Xilin Wu <sophon@radxa.com>
Date: Wed, 08 Apr 2026 18:07:32 +0800
Subject: [PATCH v2 1/2] dt-bindings: pwm: clk-pwm: add optional GPIO and
 pinctrl properties
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-clk-pwm-gpio-v2-1-d22f1f3498a0@radxa.com>
References: <20260408-clk-pwm-gpio-v2-0-d22f1f3498a0@radxa.com>
In-Reply-To: <20260408-clk-pwm-gpio-v2-0-d22f1f3498a0@radxa.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2512; i=sophon@radxa.com;
 h=from:subject:message-id; bh=hyoSGNKO8z6d1axQ29oBEAL7xl1kP5y9LqcBAulHLMQ=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDJnXNN7tfMb07W11zRRXxo6iZPGW6CMH153PYW5f+LO+d
 EL4SqspHaUsDGJcDLJiiiwK8Qxz2Stzrz0VK9WDmcPKBDKEgYtTACZSsJKRYf6DAzsys7caqdZY
 2kQncL+cU6uf2DJ9gejd3QuPidf9qmZk6Nk0U7Ds+H+VFKUDKZe21dq1STLF2n349/H+d1W3R28
 1eAE=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N8r2YJN/ffrjkob54fqR58thY4A5iwbaYUjMjFmkKQCx3HXYzDhzaaGa
	ZAtQq5IYnwTQb5DZRPvhrkelCsRvCXFs3zbXmbgyc+JqxeRvalRcwCZ2ejudG6y/dB9ZVYl
	ExRQvOcedBy9t/THaoNDgoF73SGGOxEWGbrAK6fQqg9madUAKdZuCzcrk4zLxsw+BW71HQy
	eIs/dk2WcI0Yy2CgG18lIilrZfPTrojkSrsxWBNKAnAB2+rngP2jvxbuUU/djTlIQJ8PD9q
	AUkBlBoBS9d7TfE2FB8tFOplzOcEHDp/zcZeWnZ1pweEOI1vLUtDBb6GxORc0N0rtR6hCgf
	Eoj9KcciX9lDXJliAngN63b40PsAHSXhMXi7vC0iLG6UgnlfSGBpdOCd+8r54pdeXgg1Xt2
	F5hA5hG+9c5iemgEFUzE9ngVOXPi6Y2A1uEeVVjMPkfVnKQdALidp/lFUj5KaP7v5PjV42y
	FhMnd9WGDVkqfP5cVrN8ovhb0yGkC/HUivo0xu5CHFHTs9lVW4LbdONtVE8DdCChesuQ5ZM
	yXoIno/dZ/FIn3TZVn0gF0W3C5zGRHBju0JWZRABxs/06hwoOQIQ6/oH9IUwKQqJXpae0tn
	LhvxDqI4QAnYSQvGfSIu8q9bnlJALV1j4OpDQrxd4oJIj/35TYZknjrZ6izLWrBX+Wp5caQ
	Ls9/Pif5i2zdRgkGnH1BaXpGgyyYZiyXKy6NYAkgUmjc1bRX7t22nupv5iLKHaz7hbJeJh3
	0GydDhw2sQfq5zE04pEMitrWbElLGMHuXDCjSgKuXV6doB2wsC5WPy7VYJyNXmh/1RYDhO7
	7Ts5RisMU/uXyU2kFoWdrdVUw4EZ/PG53ByX+mpE2/6I9PaMXTq4T7CZwITZeuKkZs25E5U
	Cs7gRY1iSDWrFPLm73edyUvaoLL8+5/hhPOMGNXSuYGmK8xtd0pmnIhLajbj9X7rB6XWMWZ
	XuRCVy9wB3QmhwYEq2qzIUoHtj5xJ64NydVxK5z5fzfnM8dSDh2RaPeEtd47hd+fRhZcbZk
	j29jsOHpCmys/+3VvbUzmdJl4iRa5r/lm9jHf97ECTC+F7tcF6
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[radxa.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8520-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sophon@radxa.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.235];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,radxa.com:email,radxa.com:mid]
X-Rspamd-Queue-Id: 3728B3BA583
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The clk-pwm driver cannot produce constant output levels (0% or 100%
duty cycle, or disabled state) through the clock hardware alone - the
actual pin level when the clock is off is undefined and
hardware-dependent.

Document optional gpios, pinctrl-names, pinctrl-0, and pinctrl-1
properties that allow the driver to switch the pin between clock
function mux (for normal PWM output) and GPIO mode (to drive a
deterministic constant level).

Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 Documentation/devicetree/bindings/pwm/clk-pwm.yaml | 36 +++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/clk-pwm.yaml b/Documentation/devicetree/bindings/pwm/clk-pwm.yaml
index ec1768291503..2a0e3e02d27b 100644
--- a/Documentation/devicetree/bindings/pwm/clk-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/clk-pwm.yaml
@@ -15,6 +15,11 @@ description: |
   It's often possible to control duty-cycle of such clocks which makes them
   suitable for generating PWM signal.
 
+  Optionally, a GPIO and pinctrl states can be provided. When a constant
+  output level is needed (0%, 100%, or disabled), the pin is switched to
+  GPIO mode to drive the level directly. For normal PWM output the pin is
+  switched back to its clock function mux.
+
 allOf:
   - $ref: pwm.yaml#
 
@@ -29,6 +34,26 @@ properties:
   "#pwm-cells":
     const: 2
 
+  gpios:
+    description:
+      Optional GPIO used to drive a constant level when the PWM output is
+      disabled or set to 0% / 100% duty cycle. When provided, pinctrl states
+      "default" (clock mux) and "gpio" must also be defined.
+    maxItems: 1
+
+  pinctrl-names: true
+
+  pinctrl-0:
+    description: Pin configuration for clock function mux (normal PWM).
+    maxItems: 1
+
+  pinctrl-1:
+    description: Pin configuration for GPIO mode (constant level output).
+    maxItems: 1
+
+dependencies:
+  gpios: [ pinctrl-0, pinctrl-1 ]
+
 unevaluatedProperties: false
 
 required:
@@ -41,6 +66,15 @@ examples:
       compatible = "clk-pwm";
       #pwm-cells = <2>;
       clocks = <&gcc 0>;
-      pinctrl-names = "default";
+    };
+
+  - |
+    pwm {
+      compatible = "clk-pwm";
+      #pwm-cells = <2>;
+      clocks = <&gcc 0>;
+      pinctrl-names = "default", "gpio";
       pinctrl-0 = <&pwm_clk_flash_default>;
+      pinctrl-1 = <&pwm_clk_flash_gpio>;
+      gpios = <&tlmm 32 0>;
     };

-- 
2.53.0


