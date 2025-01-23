Return-Path: <linux-pwm+bounces-4726-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 580ADA1AAF8
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 21:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F8A3AEFAA
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 20:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E201CD219;
	Thu, 23 Jan 2025 20:11:41 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86031CD1FD;
	Thu, 23 Jan 2025 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663101; cv=none; b=I+QrPEaKb5TJ2xdNFdQSv8D6nl5RVRQQevcH5BcWMHqPQlnJtfx7+CWDO73e1dplIKnPuOgpHkDirP7tSq9Fv8Vs+uaOu6hLqWXr2jT+8iY51XNvY+st149PJlD8mbf1XI75RCPlgpzAYACIhPTf119ck5YHgUjOaKaGOPpEtIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663101; c=relaxed/simple;
	bh=XEwKrIdM476QsRZ9Xc/3begZm2U0inEUFVVUjNEN5Wo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I9uE1ebMo/oRg5+VRrd2K+YeVMlWOwDCKecGZtJx5qjAkrxDrHW0I5wTpqJejNiu6BgXBC7n0rfzUW3TBT3YA8dwgK2jm1Cr/KnWVkdm7zVUDg4MB0Auh5igSL3XpxJn+MrOjSEEM180NURtoWpCCHnVXUy3QMGAp/9WY7tJC/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 50NJa4S2005040;
	Fri, 24 Jan 2025 03:36:04 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 50NJZduh004780
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 03:35:39 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Fri, 24 Jan 2025
 03:35:39 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To: <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <ukleinek@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, Ben Zong-You Xie <ben717@andestech.com>
Subject: [v3 1/2] dt-bindings: pwm: add atcpit100
Date: Fri, 24 Jan 2025 03:35:33 +0800
Message-ID: <20250123193534.874256-2-ben717@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250123193534.874256-1-ben717@andestech.com>
References: <20250123193534.874256-1-ben717@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 50NJa4S2005040

Document devicetree bindings for Andes PWM controller.

Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
---
 .../bindings/pwm/andestech,atcpit100-pwm.yaml | 51 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/andestech,atcpit100-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/andestech,atcpit100-pwm.yaml b/Documentation/devicetree/bindings/pwm/andestech,atcpit100-pwm.yaml
new file mode 100644
index 000000000000..20d099c1503f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/andestech,atcpit100-pwm.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/andestech,atcpit100-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Andes PWM controller
+
+maintainers:
+  - Ben Zong-You Xie <ben717@andestech.com>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: andestech,atcpit100
+
+  reg:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: ext
+      - const: apb
+
+
+required:
+  - compatible
+  - reg
+  - "#pwm-cells"
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pwm@f0400000 {
+      compatible = "andestech,atcpit100";
+      reg = <0xf0400000 0x1000>;
+      #pwm-cells = <3>;
+      clocks = <&smu 1>, <&smu 7>;
+      clock-names = "ext", "apb";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b1..bc54216d1835 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3588,6 +3588,11 @@ F:	drivers/power/reset/atc260x-poweroff.c
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


