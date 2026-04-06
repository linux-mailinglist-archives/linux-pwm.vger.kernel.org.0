Return-Path: <linux-pwm+bounces-8496-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qC/XI23W02nUnAcAu9opvQ
	(envelope-from <linux-pwm+bounces-8496-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 17:51:09 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3041E3A4E36
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 17:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1CC13008996
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Apr 2026 15:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81176330648;
	Mon,  6 Apr 2026 15:51:06 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD1F2D0614;
	Mon,  6 Apr 2026 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775490666; cv=none; b=nVUSpRjPj2nitlMjNGxt/L3JV3NMWfGS+tZdoXj7vNQQW0QYeyR2S1M4WQr2XLgh/CFufA+uzbtdykAhXqPp9P/rET8YHohSev2cY2GtEsB+Phm9xObyCNzwQTNxcZdtMtdEH4+ECrlgA65cRNQcgaVKw1t6NU4YrA31YPL0nIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775490666; c=relaxed/simple;
	bh=hyoSGNKO8z6d1axQ29oBEAL7xl1kP5y9LqcBAulHLMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U/TRO5IFZ/jcP9G1pndzGryIkcqoVZMzlJd6VKVTNgjQ799n0mHj65p8Xd3vWU0sTknBX/hQnEk784C1HfA9/DWl9GXDlIbYXtZJx3Sn22rdGJ03qOQZINnwVOzmOHxNruon8UttAt54xg7S8jO6D+mW8HI+pccXQSHFpuljBIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpsz5t1775490611t88c1fc21
X-QQ-Originating-IP: O33DW5ODZGKddTF7xRQ7Ge2Lc2xYEoUlTwU0BzXScsQ=
Received: from [192.168.30.32] ( [116.234.14.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 06 Apr 2026 23:50:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13515617376988754846
EX-QQ-RecipientCnt: 10
From: Xilin Wu <sophon@radxa.com>
Date: Mon, 06 Apr 2026 23:50:01 +0800
Subject: [PATCH 1/2] dt-bindings: pwm: clk-pwm: add optional GPIO and
 pinctrl properties
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-clk-pwm-gpio-v1-1-40d2f3a20aff@radxa.com>
References: <20260406-clk-pwm-gpio-v1-0-40d2f3a20aff@radxa.com>
In-Reply-To: <20260406-clk-pwm-gpio-v1-0-40d2f3a20aff@radxa.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2512; i=sophon@radxa.com;
 h=from:subject:message-id; bh=hyoSGNKO8z6d1axQ29oBEAL7xl1kP5y9LqcBAulHLMQ=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDJmXr+lpz6zwPig603O36Y01rG92GuQbLL22/F3exIhDM
 +ZqJnM97ihlYRDjYpAVU2RRiGeYy16Ze+2pWKkezBxWJpAhDFycAjARfilGhnMfXbY9Y5qecXqP
 bpyVtt9TtUtui1+Z2vj5BE1h+3tonSojQ2Nl8f3PZayTn729HX3u4uSXczjWC8xJPS4Verb445d
 gXX4A
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Ob+yvR0lmunCxlEdJ5yqfcfe8D1O7uVqXJxhN3Hhst+k/5IQeBIBSRM3
	+3E2ec4Wc1MlrG32fFTxY3WUlFtXsOcmUyBH1eShzav/1q0vFc9LJtvujKXsJKMCXk4RkbN
	p4kgrmLqTRTTn8qYPKoRv5mzJeZI71rL7Wi/lIN73AWDhP4Vk7qFY1EX4H1cDW5kiBU8jUQ
	M2c+nmM7qNb3Q3U2KcAcdlhSStCvXYu+KWU4dc+2vVcl6KgkolxVRJHpr6JGRAa0nMGxlIy
	Jq37eEkjz3nmOZ49UfS9bs24pmUFKh23V6+hLKsaMEVY4zenBrNzDRaF97r8IBygcTwKbjA
	PON12jYLZYkBu/0jJeZm1x/tEvQBDO4GgBRVM/zGS4MOyKEYRbf6Xk9HJasdrcdqChsA9w6
	+gclveBuOMOPqq7Q+8wc8Znboi3/YTWAo3c3i4QvG3vVaz+mujYO2gDkSbtgpLz3UmUgDX8
	HwS1UeW731icaVKqclJIZ1D3cPinN0mRtNvrqF5K7d0lbZ6ebpMmzXI6MmnUnKy/ruAORQl
	TSaoJYNg0zzL323Zbp2Xhc568VXFK+UIwhA+dqu6Wq/Bv2s3xdwCVwgSOLuqQNFv2f9sc4L
	MoXQhHCuHruYVfcIAUBTq2Gk3bfwt2tWpPTssqSQvh/0WEYBENK05ylu+q3sRNVcD2CaXuU
	h2qipZP6kBzkvCkQuNoVSKIiMMXg3giiUvMmyWsXJDrAG32Mot3cUmnNvhjg5/uw0Y+sdnB
	6jAmsZ7g5x8oNXKR1FN742ULKglIjP8sBTKLA/nHYosk9FJjWRM7vP9vW+6eVsXQoInOr7g
	vwdG7Y+HCXxE52sD/A/L22PWKBw1yn2/ZzTTTm2nK8JOLaOCGMCb9mSjwOBN5bIFVt1Goek
	g671OtWHJcdBAJR7gAPSUrLTju8vFvSOX6xexrOKrBdsQJJrea1JDclGeTHD4vFjWeQHakX
	H9T8ZAikdH60rzfzly0H9wfXzBavhQduqvJiA3EweqTPMticSePv9gcxV1EaQzwkVp020ig
	VuKU+cCdgKOEG8dM4BIZKWfwCeu4vzcVctX8lIs7xw0/rvkpVIvBAZfhFvF9qErQFQ58nWp
	nKcX6iTvtlNgiCNMz5YtJE/AC2sRysPqQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[radxa.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8496-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sophon@radxa.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.813];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3041E3A4E36
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


