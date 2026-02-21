Return-Path: <linux-pwm+bounces-8142-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOUcFEr7mWnUXgMAu9opvQ
	(envelope-from <linux-pwm+bounces-8142-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Feb 2026 19:36:58 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A081C16D87C
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Feb 2026 19:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 538C3307C8BA
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Feb 2026 18:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5460D304BDF;
	Sat, 21 Feb 2026 18:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krSmEq5W"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4C029994B
	for <linux-pwm@vger.kernel.org>; Sat, 21 Feb 2026 18:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771699004; cv=none; b=rfQQLCP1axNzF95RsdHvCuV2IC02pRR1u85gRYD72QpOvrXWGaFHsYGfTOJxLj3hweT9Iyool6ZIq/K2FeLYBvOdTWFoh63PtPTCwAYXGMBNqDKEXZBMnpKy+Erq+JKcQwVMw1fZ0MuhAEbcUd/CoYeJr9zF2d1wBe7NTiqI8Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771699004; c=relaxed/simple;
	bh=/FvXEaGUoGpzEkjnRI9XUIndReaBxEi1jDlYZjxu8lk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qP8cAzAeQETi/mKVzpV9CcigwXFS/em+rn4s+CBpjsQ9e9zUIpplIWVSU15iHyG5wI3LPMYmulDp7tU2ib+kVff0x4UMpmAIsxCOiYvQSzz3f6kwESOHN+oxCEPSvuOYwL7ukmTqPc0jQglUFsvPVu9EEeehf4wu7l5OuiaPCYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krSmEq5W; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-386714da2a2so25872051fa.1
        for <linux-pwm@vger.kernel.org>; Sat, 21 Feb 2026 10:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771699001; x=1772303801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuboJBenXywBLFqud7lu9/BOWrHh+KcmgCOX5jvamjk=;
        b=krSmEq5WyDMCCqTHbN9PG55FVgqUZOnEQmlHKBgEsbHBAkHk00GYUauJtROaEmRTh9
         J8w33zzfN6fVVDGrYqjPWGZPinfYJHksPBKS7/LSL3RAKisvPlgjSAyJKV3f3YuQhOla
         D4XrYWCYARROj9aCHXerwRH7BGzYpb5qO1Sx8//L3VR+T21PRbN6zaVKUf16OXObmk90
         mLzJL3sZlVEQSwl6Rc2KCp4roMD+3aAjbYWI2lJWw76DGMdRBYEylR400SKYt54VKN3r
         2EpFFB8LNtUnmgmkiA9JBWrTbUx2QpiFzq8e422+gtMYyrzUlbn4GYfkGRMPcfypE1Uw
         Qcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771699001; x=1772303801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tuboJBenXywBLFqud7lu9/BOWrHh+KcmgCOX5jvamjk=;
        b=NKTiGeNVD7nM6uZME7EJeR5Dk5TsUg38HCfVIo+xzO7FsX2N6xFP0g2kyr2Vrc/Uun
         kGQoqKZmzsbzp9QPiMhd5jqknkyovhlFyYd+7P26VBZVC+Sbq2d1/NsVA3iJGL7wUWLS
         1Z4bSyjDeCOtogZpWJK0T5SXk1B7x+f/Rs2p98Cxb/pdLDsVs3Mj5VSW4SQa8HkESrfs
         XTr9EINOWnUQa+7mT3U2X6qZszgb2xeyuoWPW0nZ/i1l0+MQoTkrl0w6sTQdC42GxqRG
         eyqTO0X9ENdAQJSAzeaGFOyJM4YCXl2eNewGSpNR7pszlr7lLbaV6bCdwNDEBLthWwN7
         Sayg==
X-Forwarded-Encrypted: i=1; AJvYcCWjgnBrNh90tOXBfftMiLGGlCKgmGEKvWPCkWn656WQibF1EKLNqWX1Bpf9G1SF4dFsAvibSZeCJKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxEODmx9JXpNTVepp2hQKB5HwnOVbgwvjD8Lx4r7QiQKuGpUqO
	m/bn1vc3J08usVKaSMUSdakRUfMTND2PSE0a9kQgF1Z0E5BS57b4Z24=
X-Gm-Gg: AZuq6aIZTbUaTXO9aLi4kgKMIEK7X8mG53OtXCiwfKzEMP2rEe8wxWzXUk1e91ahM3r
	fV1+cLUb60TKesG+WcREWPSMrIAzLmVRjNvubDDPFTYYjMvoDihT4h22H6bsTMwJBWy1GvXL1/7
	zPZEEHmksPG9NadCbCyv55HE2yNT2nPyb9snBIl6wdhF5TotySyqa3d3D58dK9NfGauYwsLXVtx
	ttGL1PUotQlE1DY6OTBgaIL7U8nmUahgTCVJHllmjnl0F1MbCOJAhLwqRV4SyzElQUqcWp8XcL3
	C2enEToBKNsXgWw1d8ZDQc57E2lE4tIyuTclsZ15amUOi5229AMHd/oINIErXltBOtI63WxUDx+
	+CM0dR80xmDqKu4/RQM1e8aCxX7kOoeZYeVx8me0KRkFZYWMdLmKGWqTVhbWKDuYFfX8PWZOBGA
	/u3SHUVQ9GIk8yrEzcCvNWGbBnew7cNAq3ur5Q
X-Received: by 2002:a2e:be94:0:b0:386:eadd:9ddf with SMTP id 38308e7fff4ca-389a5cdd595mr8800811fa.12.1771699000922;
        Sat, 21 Feb 2026 10:36:40 -0800 (PST)
Received: from localhost.localdomain ([178.176.177.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389a7af19d4sm5006841fa.42.2026.02.21.10.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 10:36:40 -0800 (PST)
From: Aleksandr Shubin <privatesub2@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Aleksandr Shubin <privatesub2@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lukas Schmid <lukas.schmid@netcube.li>,
	Cheo Fusi <fusibrandon13@gmail.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: [PATCH v13 1/3] dt-bindings: pwm: Add binding for Allwinner D1/T113-S3/R329 PWM controller
Date: Sat, 21 Feb 2026 21:35:51 +0300
Message-Id: <20260221183609.95403-2-privatesub2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260221183609.95403-1-privatesub2@gmail.com>
References: <20260221183609.95403-1-privatesub2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,sholland.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,netcube.li,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-8142-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[privatesub2@gmail.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A081C16D87C
X-Rspamd-Action: no action

Allwinner's D1, T113-S3 and R329 SoCs have a new pwm
controller which is different from the previous pwm-sun4i.

The D1 and T113 are identical in terms of peripherals,
they differ only in the architecture of the CPU core, and
even share the majority of their DT. Because of that,
using the same compatible makes sense.
The R329 is a different SoC though, and should have
a different compatible string added, especially as there
is a difference in the number of channels.

D1 and T113s SoCs have one PWM controller with 8 channels.
R329 SoC has two PWM controllers in both power domains, one of
them has 9 channels (CPUX one) and the other has 6 (CPUS one).

Add a device tree binding for them.

Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
---
 .../bindings/pwm/allwinner,sun20i-d1-pwm.yaml | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20i-d1-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun20i-d1-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-d1-pwm.yaml
new file mode 100644
index 000000000000..306e14a9c4d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-d1-pwm.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/allwinner,sun20i-d1-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner D1, T113-S3 and R329 PWM
+
+maintainers:
+  - Aleksandr Shubin <privatesub2@gmail.com>
+  - Brandon Cheo Fusi <fusibrandon13@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: allwinner,sun20i-d1-pwm
+      - items:
+          - const: allwinner,sun50i-r329-pwm
+          - const: allwinner,sun20i-d1-pwm
+
+  reg:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+  clocks:
+    items:
+      - description: Bus clock
+      - description: 24 MHz oscillator
+      - description: APB clock
+
+  clock-names:
+    items:
+      - const: bus
+      - const: hosc
+      - const: apb
+
+  resets:
+    maxItems: 1
+
+  allwinner,npwms:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The number of PWM channels configured for this instance
+    minimum: 1
+    maximum: 16
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#pwm-cells"
+  - clocks
+  - clock-names
+  - resets
+  - allwinner,npwms
+
+examples:
+  - |
+    #include <dt-bindings/clock/sun20i-d1-ccu.h>
+    #include <dt-bindings/reset/sun20i-d1-ccu.h>
+
+    pwm: pwm@2000c00 {
+      compatible = "allwinner,sun20i-d1-pwm";
+      reg = <0x02000c00 0x400>;
+      clocks = <&ccu CLK_BUS_PWM>, <&dcxo>, <&ccu CLK_APB0>;
+      clock-names = "bus", "hosc", "apb";
+      resets = <&ccu RST_BUS_PWM>;
+      #pwm-cells = <0x3>;
+      allwinner,npwms = <8>;
+    };
+
+...
-- 
2.25.1


