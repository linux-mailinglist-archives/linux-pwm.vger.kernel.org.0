Return-Path: <linux-pwm+bounces-8372-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KhGNDTVxGnk4AQAu9opvQ
	(envelope-from <linux-pwm+bounces-8372-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Mar 2026 07:41:56 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D8332FFAC
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Mar 2026 07:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 004733074E03
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Mar 2026 06:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC04345CB0;
	Thu, 26 Mar 2026 06:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgx5PVz7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CB233C18E;
	Thu, 26 Mar 2026 06:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774506947; cv=none; b=MwEa208fj62aCCEVjtJYieF3pBrrlZ22pwx73cCoAcfL221x88FUdAQnH8lG8y5rrvQ8CvML6lE5WGzNOGap10Xe3OCyypRD6XQo9yApOplCgqSj4OzMHNFSlWuo30kGgpGPoV+rEPQJHnEhMQLr0EW89AYsm6PXZ/z9DHTegxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774506947; c=relaxed/simple;
	bh=XgK+c61EJ3POwwUA4dYICWS5n7txtDGgDK9lPOzEOoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DKld1Re+1DB7n98jxS3HR6krDH92cpwsOQUadIGmlJSWVNWKUWVSDY5jHehSxn0Lyxuqf3Hv659k/gmNqzoM3LgTlc1ZAWA+/FEyI0IbbW7t3mgMFGh+wgQKHLoaOn3sctIbAUvVlDvGQhLKnJYyMjJWnmuFyUk5H6inYv5hXS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgx5PVz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 310E4C2BC87;
	Thu, 26 Mar 2026 06:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774506947;
	bh=XgK+c61EJ3POwwUA4dYICWS5n7txtDGgDK9lPOzEOoY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kgx5PVz7pfvEDHR6tWXx8Q8qJSFZ091irntbeytd6xr4kTLw1BztVuKrCcy9GbJ1D
	 ySO9EIdAklDv/hh1VBjjtXXRnn0fjuQ7Mq6xFUPXUq7IMLqkFTOrNmdIg8iigJ+NA5
	 ZGsQ/cpPCd0bfmW8oyPDA7P4IRwsDFxrBGdXhaSwUZ4162Ib00tNP3Htx7svdWUoTc
	 I6AkbXTsHiSitiYO8YfvPXIm3phld3SSnJbL7t3XGRz8uT/8h5yZMAe2x+irLN7nPj
	 UMrofdLRaQiAnkytd/P0thnbYlbFA8VQsZuHUzBvd1s45HeiaR8LwxurmD3z9q40/w
	 S0aWCsM9MVoCQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D385109E558;
	Thu, 26 Mar 2026 06:35:47 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 26 Mar 2026 06:35:38 +0000
Subject: [PATCH 1/2] dt-bindings: pwm: amlogic: Add new bindings for S6 S7
 S7D
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-s6-s7-pwm-v1-1-67e2f72b98bc@amlogic.com>
References: <20260326-s6-s7-pwm-v1-0-67e2f72b98bc@amlogic.com>
In-Reply-To: <20260326-s6-s7-pwm-v1-0-67e2f72b98bc@amlogic.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Junyi Zhao <junyi.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774506945; l=1979;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=7pPP6FCX/JHlWDMsAPkXc7yrHLEf0gHhe1iZNl6X4a4=;
 b=0ilGapcjKBpO/yK6NfK5WTocVVTM8wUZtDKxrEbLtgMa9SrXPk5KYA3+Iw0XSPAux28L6n1uy
 B5TH4iJqCF4AqIjE3i1yrWcPRAknu8w7aMs+3i+x1uC9MaCgI3MTaOy
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8372-lists,linux-pwm=lfdr.de,xianwei.zhao.amlogic.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linaro.org,baylibre.com,googlemail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[xianwei.zhao@amlogic.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_PROHIBIT(0.00)[0.0.3.232:email];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amlogic.com:email,amlogic.com:replyto,amlogic.com:mid]
X-Rspamd-Queue-Id: 33D8332FFAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Junyi Zhao <junyi.zhao@amlogic.com>

Amlogic S7/S7D/S6 different from the previous SoCs, a controller
includes one pwm, at the same time, the controller has only one
input clock source.

Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../devicetree/bindings/pwm/pwm-amlogic.yaml       | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
index c337d85da40f..f0c40dc359ad 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
@@ -37,6 +37,7 @@ properties:
       - enum:
           - amlogic,meson8-pwm-v2
           - amlogic,meson-s4-pwm
+          - amlogic,s7-pwm
       - items:
           - enum:
               - amlogic,a4-pwm
@@ -45,6 +46,11 @@ properties:
               - amlogic,t7-pwm
               - amlogic,meson-a1-pwm
           - const: amlogic,meson-s4-pwm
+      - items:
+          - enum:
+              - amlogic,s6-pwm
+              - amlogic,s7d-pwm
+          - const: amlogic,s7-pwm
       - items:
           - enum:
               - amlogic,meson8b-pwm-v2
@@ -146,6 +152,20 @@ allOf:
         clock-names: false
       required:
         - clocks
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,s7-pwm
+    then:
+      properties:
+        clocks:
+          items:
+            - description: input clock of PWM
+        clock-names: false
+      required:
+        - clocks
 
   - if:
       properties:
@@ -182,3 +202,10 @@ examples:
       clocks = <&pwm_src_a>, <&pwm_src_b>;
       #pwm-cells = <3>;
     };
+  - |
+    pwm@1000 {
+      compatible = "amlogic,s7-pwm";
+      reg = <0x1000 0x10>;
+      clocks = <&pwm_src>;
+      #pwm-cells = <3>;
+    };

-- 
2.52.0



