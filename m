Return-Path: <linux-pwm+bounces-5653-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C10E8A967B3
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 13:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 459C97A4F15
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 11:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC4927E1A5;
	Tue, 22 Apr 2025 11:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="i0QhnsdU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E6727D76A;
	Tue, 22 Apr 2025 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745321741; cv=none; b=Dg16+DoWyLI4toj0zezk1F5VRErfIBY8xpiyov/v6r5O0DFVKTTdUGHJTFlni8ohV61m/3u2IrY+rao9i9O11CYHSUXBao22Eiedb1JmJRAEzmrJiUk44GnaSlMvy0a+KcPSEfVApMZJDmAl6HsxRN+ZSHqa+UlLqHhmY49jaSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745321741; c=relaxed/simple;
	bh=AXR9N1DwB389eApnJDPbeMf/BZ2AAWFC+CnUCOCV5jk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DC9IGOMG98rUoC45LiofT+CmUoS/Pjoony8ypZowq9Ek651fHLzs+t6NJSOPN4SAG75dZDIEqfQm+xJRRFdf/l3wwD/yk8BVxMazC5Bl9d48BjYO56grDZ9tq/BptS0cZ8j1pDDlInXboMSDyfskAr5kQHe1vUymFn65+Oh/u/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=i0QhnsdU; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MA4Fod029132;
	Tue, 22 Apr 2025 07:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=5qmEA
	umP8Ir40WoPF7pfQtOdDlZrPv3CfeSg7p9S74Q=; b=i0QhnsdUzGf7wznZ1PT0z
	mUnRRHpOegcKiyonMid+BULvMv5bRaX0SyM+Crsxf36CS/+kbTjUWQLNF0MbEkop
	Hu8NFEifKQKHZBq7Xkih+/8Welc+0h5pVXXiZqH2i39NFduyLlbu3BJIQBdiAEKo
	r3K7F7naKjGSsIyh0UYRoM4y7AzSAUIJkmvpFkiUcgRAOrw0dfEbzie7s4+SklKC
	wIppk5gMORH7tOBcBOhCeQBSYsg0SEcXzA91SjEqEzja8wDj6FkpiZ5lG6PWhoVS
	dE+cnjuWhXBHfcP7eQ/mUykhYUGeVmUM4Lfd1tAUSkehufCoGOn/gqC1kWYfTlOF
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 464t5gm6p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 07:35:24 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 53MBZNw4057917
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 22 Apr 2025 07:35:23 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 22 Apr
 2025 07:35:23 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 22 Apr 2025 07:35:23 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.55])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53MBZ4Qq024350;
	Tue, 22 Apr 2025 07:35:16 -0400
From: Jorge Marques <jorge.marques@analog.com>
Date: Tue, 22 Apr 2025 13:34:48 +0200
Subject: [PATCH v2 3/5] dt-bindings: iio: adc: Add adi,ad4052
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250422-iio-driver-ad4052-v2-3-638af47e9eb3@analog.com>
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
In-Reply-To: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, Jorge Marques <jorge.marques@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745321704; l=4091;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=AXR9N1DwB389eApnJDPbeMf/BZ2AAWFC+CnUCOCV5jk=;
 b=SDTsaLgNLjArAs32s0DRL2AwpM6fgZXRPfdZPUMFHws+8wcyKyV8faKwIkQt98cYO6j/G9eLl
 oF3VbFvav//BvHg06LrWDetxVr9ZyBsvIIUUUQQsWMnF6CiCHHK3FIv
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=RaiQC0tv c=1 sm=1 tr=0 ts=68077efc cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=0CypkOm7ba8rlrjfvoEA:9
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: mRpUd89L8WEq0XLBKrng9lPHuSxz0ebR
X-Proofpoint-ORIG-GUID: mRpUd89L8WEq0XLBKrng9lPHuSxz0ebR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_05,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1011
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220087

Add dt-bindings for AD4052 family, devices AD4050/AD4052/AD4056/AD4058,
low-power with monitor capabilities SAR ADCs.
Each variant of the family differs in speed and resolution, resulting
in different scan types and spi word sizes, that are matched by the
compatible with the chip_info.
The device contains one input (cnv) and two outputs (gp0, gp1).

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad4052.yaml    | 98 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 104 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..a0510d485f130ceec15b887e8f8deeb2cf6562c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2025 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad4052.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD4052 ADC family device driver
+
+maintainers:
+  - Jorge Marques <jorge.marques@analog.com>
+
+description: |
+  Analog Devices AD4052 Single Channel Precision SAR ADC family
+
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4050-ad4056.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4052-ad4058.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad4050
+      - adi,ad4052
+      - adi,ad4056
+      - adi,ad4058
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Signal coming from the GP0 pin (threshold).
+      - description: Signal coming from the GP1 pin (data ready).
+
+  interrupt-names:
+    items:
+      - const: gp0
+      - const: gp1
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+    description: |
+      The first cell is the GPn number: 0 to 1.
+      The second cell takes standard GPIO flags.
+
+  cnv-gpios:
+    description: The Convert Input (CNV). If omitted, CNV is tied to SPI CS.
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 62500000
+
+  vdd-supply:
+    description: Analog power supply.
+
+  vio-supply:
+    description: Digital interface logic power supply.
+
+  vref-supply:
+    description: Reference voltage to set the ADC full-scale range.
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vio-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad4052";
+            reg = <0>;
+            vdd-supply = <&adc_vdd>;
+            vio-supply = <&adc_vio>;
+            spi-max-frequency = <25000000>;
+
+            interrupt-parent = <&gpio>;
+            interrupts = <0 0 IRQ_TYPE_EDGE_RISING>,
+                         <0 1 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-names = "gp0", "gp1";
+            cnv-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 01079a189c93697c1db6b0ca4e54212d25589974..81fbe7176475c48eae03ab04115d4ef5b6299fac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1329,6 +1329,12 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
 F:	Documentation/iio/ad4030.rst
 F:	drivers/iio/adc/ad4030.c
 
+ANALOG DEVICES INC AD4052 DRIVER
+M:	Jorge Marques <jorge.marques@analog.com>
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml
+
 ANALOG DEVICES INC AD4130 DRIVER
 M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
 L:	linux-iio@vger.kernel.org

-- 
2.49.0


