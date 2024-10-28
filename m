Return-Path: <linux-pwm+bounces-3938-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F4F9B2D22
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Oct 2024 11:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3701C21912
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Oct 2024 10:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEE51D63CD;
	Mon, 28 Oct 2024 10:43:41 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8E61D365B;
	Mon, 28 Oct 2024 10:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112220; cv=none; b=XhH1/GyEM5dsccJ8YsVAZ92XDSTkqpZ/p/EPzLNZvJA3zL1AKmNcJSh+If9hiZSCGu3EndWa8ghBYQVyYFQ4juv0P6c1vdDoR+DU8Q5saovg5CvuDHTQvgjZ4AWU2y6bTtjPjoJmgqrydqmdN5MupWFxVzClwH4VmCKMXTygiSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112220; c=relaxed/simple;
	bh=CC5PvJZjNeb1cng0akBPUh397f3q0wLByF4Ls2G/2xI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ye6Qjm6aDCTmemLfc9pyndkjqiWkG6zyH31a69mVePgHhlZMUnXV/C82Dezah2v2ZG2zSx2ibIgGTN8Fj4A9+rXso8mVbcWm+j53jyF/UEQNRN590J4Qy8RePpSPutcjQREA4N0WGjT0rplqAAEWcJpDehaN6QtgHn8leBkfVoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 49SARpiM076964;
	Mon, 28 Oct 2024 18:27:51 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 49SARS3K076698
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 18:27:28 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Mon, 28 Oct 2024
 18:27:29 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To: <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <ukleinek@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, Ben Zong-You Xie <ben717@andestech.com>
Subject: [PATCH 1/2] dt-bindings: pwm: add atcpit100-pwm
Date: Mon, 28 Oct 2024 18:27:20 +0800
Message-ID: <20241028102721.1961289-2-ben717@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028102721.1961289-1-ben717@andestech.com>
References: <20241028102721.1961289-1-ben717@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 49SARpiM076964

Document devicetree bindings for Andes atcpit100-pwm.

Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
---
 .../bindings/pwm/andestech,atcpit100-pwm.yaml | 52 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/andestech,atcpit100-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/andestech,atcpit100-pwm.yaml b/Documentation/devicetree/bindings/pwm/andestech,atcpit100-pwm.yaml
new file mode 100644
index 000000000000..6952663f134b
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/andestech,atcpit100-pwm.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/andestech,atcpit100-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PWM driver for Andes atcpit100
+
+maintainers:
+  - Ben Zong-You Xie <ben717@andestech.com>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: andestech,atcpit100-pwm
+
+  reg:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
+
+  andestech,clock-source:
+    description:
+      Clock Source for each PIT channel.
+      0 - external clock
+      1 - APB clock.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 4
+    maxItems: 4
+    items:
+      minimum: 0
+      maximum: 1
+
+required:
+  - compatible
+  - reg
+  - "#pwm-cells"
+  - andestech,clock-source
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pwm@f0400000 {
+        compatible = "andestech,atcpit100-pwm";
+        reg = <0xf0400000 0x1000>;
+        #pwm-cells = <2>;
+        andestech,clock-source = <0 1 0 0>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index a506fa4f6825..ebbc7edcf077 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3551,6 +3551,11 @@ F:	drivers/power/reset/atc260x-poweroff.c
 F:	drivers/regulator/atc260x-regulator.c
 F:	include/linux/mfd/atc260x/*
 
+ATCPIT100 PWM DRIVER
+M:	Ben Zong-You Xie <ben717@andestech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/pwm/andestech,atcpit100-pwm.yaml
+
 ATHEROS 71XX/9XXX GPIO DRIVER
 M:	Alban Bedel <albeu@free.fr>
 S:	Maintained
-- 
2.34.1


