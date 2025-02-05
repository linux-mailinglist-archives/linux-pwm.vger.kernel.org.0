Return-Path: <linux-pwm+bounces-4771-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 902C7A28721
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 10:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9C5166186
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 09:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CDD22A817;
	Wed,  5 Feb 2025 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AzNPYTPV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31D622A7F7;
	Wed,  5 Feb 2025 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738749354; cv=none; b=uu83HJyuuqcKjUYCoQ7ybDBKmQwRwlPfbVsZELFI/Vu+Ndz6KqEXEZdHFUjjr+ovg4Xy8xHdiyyRI2EecvoMX3nn2ddsq7Sv28rIZl9ztVxDtq69eI0I0mGezBvFeqk9BV2Uc1PcBRaYox6HBmqFRMD2ffLcRdDsmXFVRWfeEgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738749354; c=relaxed/simple;
	bh=lf2J/Jvva6CeFbVTIi/pV8rBqbhOFBSkkoEq6HHZWD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATNOQnSX2wWA/qVCFyYgD2BSVOYUhlQDXtSml4hqNEcgWgcGKiSWA24xe+K7z2X6oLiRS6MZE9+O0VIJC9/CFFVYEu6JQolE3Kjyc6pebjWVV/Km/+Zy8kCZNN0lU0ZKEZqmQH5Qn48v9RcuHzrZvE9PR2hCCSVaxqgrxn9Aj6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AzNPYTPV; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id DAC3B43404;
	Wed,  5 Feb 2025 09:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738749350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eOBdVJSBqhcVuEH+zRzYmH2H4Qw9RQMcHASYrX6Us4o=;
	b=AzNPYTPV2wQZEFo1sN9qEWj525uZz7pFpbtKEw6mG7WfQ+OME7EmZeyYqdArFT/wyGOR2H
	zAUQVCC6KppsD0X1iYHpaKtK7RAyyTftYSndzAmd5yHfBmdnbOfQV8Ecx3Vv13KdtRh8nF
	Pb0zvyDbhyi9h0dBzTz0as3LSIYZuLi2ftc2DjT8npVebYSXiTCVacOnkMY1+g4Hhwc+yk
	pcFbpoievDoA+pspCajOBF94ltTPlRYlYFnLi1duF9ePyM10/zZ02ky692udblJAsMeb2Z
	n9fET93nxnhQT052xu/n/WiYD5lb7WKp3tOfPPoWzdhlXJk+wtly/NC6CISjug==
From: Herve Codina <herve.codina@bootlin.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 1/2] dt-bindings: pwm: Add support for PWM nexus node
Date: Wed,  5 Feb 2025 10:55:42 +0100
Message-ID: <20250205095547.536083-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250205095547.536083-1-herve.codina@bootlin.com>
References: <20250205095547.536083-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefffffgfffgveekfefhhffgjeelueetieeffedttdegvdegjefghfevffegjeejveenucffohhmrghinhepghhithhhuhgsrdgtohhmpdguvghvihgtvghtrhgvvgdrohhrghenucfkphepvdgrtddumegvtdgrmedvgeeimeejjeeltdemvdeitgegmegvvddvmeeitdefugemheekrgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemvdegieemjeejledtmedviegtgeemvgdvvdemiedtfegumeehkegrpdhhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpmhgrihhlfhhrohhmpehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepuhhklhgvihhnvghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgut
 heskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhigqdhpfihmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: herve.codina@bootlin.com

Platforms can have a standardized connector/expansion slot that exposes
PWMs signals to expansion boards.

A nexus node [1] allows to remap a phandle list in a consumer node
through a connector node in a generic way. With this remapping, the
consumer node needs to know only about the nexus node. Resources behind
the nexus node are decoupled by the nexus node itself.

This is particularly useful when this consumer is described in a
device-tree overlay. Indeed, to have the exact same overlay reused with
several base systems the overlay needs to known only about the connector
is going to be applied to without any knowledge of the SoC (or the
component providing the resource) available in the system.

As an example, suppose 3 PWMs connected to a connector. The connector
PWM 0 and 2 comes from the PWM 1 and 3 of the pwm-controller1. The
connector PWM 1 comes from the PWM 4 of the pwm-controller2. An
expansion device is connected to the connector and uses the connector
PMW 1.

Nexus node support in PWM allows the following description:
        soc {
                soc_pwm1: pwm-controller1 {
                        #pwm-cells = <3>;
                };

                soc_pwm2: pwm-controller2 {
                        #pwm-cells = <3>;
                };
        };

        connector: connector {
                #pwm-cells = <3>;
                pwm-map = <0 0 0 &soc_pwm1 1 0 0>,
                          <1 0 0 &soc_pwm2 4 0 0>,
                          <2 0 0 &soc_pwm1 3 0 0>;
                pwm-map-mask = <0xffffffff 0x0 0x0>;
                pwm-map-pass-thru = <0x0 0xffffffff 0xffffffff>;
        };

        expansion_device {
                pwms = <&connector 1 57000 0>;
        };

From the expansion device point of view, the PWM requested is the PWM 1
available at the connector regardless of the exact PWM wired to this
connector PWM 1. Thanks to nexus node remapping described at connector
node, this PWM is the PWM 4 of the pwm-controller2.

[1] https://github.com/devicetree-org/devicetree-specification/blob/v0.4/source/chapter2-devicetree-basics.rst#nexus-nodes-and-specifier-mapping

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../bindings/pwm/pwm-nexus-node.yaml          | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-nexus-node.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-nexus-node.yaml b/Documentation/devicetree/bindings/pwm/pwm-nexus-node.yaml
new file mode 100644
index 000000000000..55412fe50d01
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-nexus-node.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/pwm-nexus-node.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PWM Nexus node properties
+
+description:
+  Platforms can have a standardized connector/expansion slot that exposes PWMs
+  signals to expansion boards.
+
+  A nexus node allows to remap a phandle list in a consumer node through a
+  connector node in a generic way. With this remapping, the consumer node needs
+  to know only about the nexus node. Resources behind the nexus node are
+  decoupled by the nexus node itself.
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+select: true
+
+properties:
+  '#pwm-cells': true
+
+  pwm-map:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+
+  pwm-map-mask:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  pwm-map-pass-thru:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+dependentRequired:
+  pwm-map: ['#pwm-cells']
+  pwm-map-mask: [ pwm-map ]
+  pwm-map-pass-thru: [ pwm-map ]
+
+additionalProperties: true
+
+examples:
+  - |
+        pwm1: pwm@100 {
+            reg = <0x100 0x10>;
+            #pwm-cells = <3>;
+        };
+
+        pwm2: pwm@200 {
+            reg = <0x200 0x10>;
+            #pwm-cells = <3>;
+        };
+
+        connector: connector {
+            #pwm-cells = <3>;
+            pwm-map = <0 0 0 &pwm1 1 0 0>,
+                      <1 0 0 &pwm2 4 0 0>,
+                      <2 0 0 &pwm1 3 0 0>;
+            pwm-map-mask = <0xffffffff 0x0 0x0>;
+            pwm-map-pass-thru = <0x0 0xffffffff 0xffffffff>;
+        };
+
+        device {
+            pwms = <&connector 1 57000 0>;
+        };
-- 
2.47.1


