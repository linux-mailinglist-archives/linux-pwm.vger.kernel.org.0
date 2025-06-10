Return-Path: <linux-pwm+bounces-6273-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D8EAD2EF1
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 09:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25D31893709
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 07:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C0128312B;
	Tue, 10 Jun 2025 07:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CrB2e0zc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7300C28134F;
	Tue, 10 Jun 2025 07:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749540934; cv=none; b=Nbyz/pVgD765Y9z5JWEps/1HHk1R3JbBZeWdM4YsTv+Gxsfy//Y/sGwDB053hPO6UB3eDtxOiAjkT0fJaJI+o0u9iliXj+9bRqtp2xNKFTtSfbGv6Un7YlaosXv3i9r9mvimluw13EbqdONauEiLlbT2Gro7WrGhPUlymLonqEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749540934; c=relaxed/simple;
	bh=YGNBbAmxGFyyZoPX38c/y8+uQSUZrM5W1KEjtKOY3G8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=gFXjDEdg8v4TvvJsudC9iN6WalwYyBHVQemXhTJ/83lLsfJsGv28cbRHDzn1KwyXJ+u+wsTnViTJ3bjw9EaWm8G6tlCU2ammFiYl3RiZ306Epk75ZbCMC/IFc4vlHGcR4d7/6BDTuLMScS58wH+WivxbrLf2QWEPdP9PXijk0wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CrB2e0zc; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A62TUG027961;
	Tue, 10 Jun 2025 03:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=JxEhi
	YuNWK027Yt40xFcHXX2Aoc+OVtIhuqCOWB0K+w=; b=CrB2e0zcjVlCkpc3yC7Ek
	MpxNcZrNuXCnOXNPyOj3rV6x9y5Foh314EahIVDpXqJC4RQJayurQPfCkbBOgQAA
	/hqz5icqkoGiz8pF4nOES7Y2smVH/q5QEF8gaHQ2irtgNjm7CsVFZRIUgeta2qr9
	v2Am9mTSH0lCznsTCph59mVEotooGytL7ZwCJfOVLSKmnjFDGk4Xr+HX7otaTONo
	SFWba/CgS7N0XYAhgtp9JWCPW1HX88/ONgvvueDMrzg/SS+dg9cv+EO3zLWy9kd0
	EDRfQ5MWW05MVJSDsjalX54qfJxRlb8ijk/eUu6pO+SzM/LIl6QCjdx9n0PZ14W2
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 475u346d0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 03:35:06 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 55A7Z5Zw056142
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Jun 2025 03:35:05 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Jun 2025 03:35:05 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Jun 2025 03:35:05 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Jun 2025 03:35:05 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.51])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55A7YkMg002608;
	Tue, 10 Jun 2025 03:34:57 -0400
From: Jorge Marques <jorge.marques@analog.com>
Date: Tue, 10 Jun 2025 09:34:35 +0200
Subject: [PATCH v3 2/8] dt-bindings: iio: adc: Add adi,ad4052
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250610-iio-driver-ad4052-v3-2-cf1e44c516d4@analog.com>
References: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
In-Reply-To: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
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
        "Andy
 Shevchenko" <andy@kernel.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, Jorge Marques <jorge.marques@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749540886; l=7557;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=YGNBbAmxGFyyZoPX38c/y8+uQSUZrM5W1KEjtKOY3G8=;
 b=aKrdiDdqVVHWfeJUVEf5ZCLAedHsNREQHvSQJOKbVvwPFa58LS0THfAymaunjxDY83jsmUkJy
 xWuIvmeoy61BltViWT0vgQ2Y377BJwysziIglIfrMmh/FAh5FX/gza9
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=R74DGcRX c=1 sm=1 tr=0 ts=6847e02b cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=EgBP3gVEkGq-cZKvRrIA:9 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: JH1l5m-eslA2QLcWD3VGlzRUctT3KMg0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA1NiBTYWx0ZWRfXxt/YAPiVab6O
 vH1rUFw0AzuWuXMk9iYAjvYgIdr+ilmRmqYCnl3MRuT1CKzHL1kbyfzKpnFTcgTTNMSWRVumr+x
 ezyhxe2u0ybmXB9mqxs2xsVVfL7dHGlHtuSK/1UbdB0qAj4Mexxt3j/0oxxwTANqM/Zlaq606ps
 RsSWCeh8vD+/ZZ3ypqiv+nFU+sN+CL0T62ZoJ/gxzjNs0s5A5EFkmiGbvsXEHV5/c6v64bCcJBU
 cJzi/g8C4SHdYQGsg9BHOfcjhWpICFCsuokDlXp4xPofbC3tAnyb/HhgDcAGVYGKEfD1QNaySBs
 2SzwA+dYOGerow0xL5DaCf427KmVXUlwsgYBm83xUyqFhH87UBzQSRXSat4G5pqQrG5XctBTAW0
 YgAVW7PC1LOkfMypzuq9pfukbr7dGDMs7Wtu12KUszg5L7wTkbUWv2ZnJyntkYi0XC9l+6il
X-Proofpoint-GUID: JH1l5m-eslA2QLcWD3VGlzRUctT3KMg0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_02,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100056

Add dt-bindings for AD4052 family, devices AD4050/AD4052/AD4056/AD4058,
low-power with monitor capabilities SAR ADCs. Each variant of the family
differs in speed and resolution, resulting in different scan types and
spi word sizes, that are matched by the compatible with the chip_info.
The device contains one input (cnv) and two outputs (gp0, gp1).
The outputs can be configured for range of options, such as threshold
and data ready.
The spi-max-frequency refers to the configuration mode maximum access
speed. The ADC mode speed depends on the vio input voltage.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad4052.yaml    | 167 +++++++++++++++++++++
 MAINTAINERS                                        |   6 +
 include/dt-bindings/iio/adc/adi,ad4052.h           |  17 +++
 3 files changed, 190 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..2cf197e2d872d9a3d4f7210121a1e38f784f92dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml
@@ -0,0 +1,167 @@
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
+      - description: Signal coming from the GP0 pin.
+      - description: Signal coming from the GP1 pin.
+
+  interrupt-names:
+    items:
+      - const: gp0
+      - const: gp1
+
+  cnv-gpios:
+    description: The Convert Input (CNV). If omitted, CNV is tied to SPI CS.
+    maxItems: 1
+
+  pwms:
+    maxItems: 1
+    description: PWM connected to the CNV pin.
+
+  trigger-sources:
+    minItems: 1
+    maxItems: 2
+    description:
+      Describes the output pin and event associated.
+
+  "#trigger-source-cells":
+    const: 2
+    description: |
+      Output pins used as trigger source.
+
+      Cell 0 defines the event:
+      * 0 = Data ready
+      * 1 = Min threshold
+      * 2 = Max threshold
+      * 3 = Either threshold
+      * 4 = CHOP control
+      * 5 = Device enable
+      * 6 = Device ready (only GP1)
+
+      Cell 1 defines which pin:
+      * 0 = GP0
+      * 1 = GP1
+
+      For convenience, macros for these values are available in
+      dt-bindings/iio/adc/adi,ad4052.h.
+
+  spi-max-frequency:
+    maximum: 83333333
+
+  vdd-supply:
+    description: Analog power supply.
+
+  vio-supply:
+    description: Digital interface logic power supply.
+
+  ref-supply:
+    description: |
+      Reference voltage to set the ADC full-scale range. If not present,
+      vdd-supply is used as the reference voltage.
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
+    #include <dt-bindings/iio/adc/adi,ad4052.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad4052";
+            reg = <0>;
+            vdd-supply = <&vdd>;
+            vio-supply = <&vio>;
+            ref-supply = <&ref>;
+            spi-max-frequency = <83333333>;
+
+            #trigger-source-cells = <2>;
+            trigger-sources = <&adc AD4052_TRIGGER_EVENT_EITHER_THRESH
+                                    AD4052_TRIGGER_PIN_GP0
+                               &adc AD4052_TRIGGER_EVENT_DATA_READY
+                                    AD4052_TRIGGER_PIN_GP1>;
+            interrupt-parent = <&gpio>;
+            interrupts = <0 0 IRQ_TYPE_EDGE_RISING>,
+                         <0 1 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-names = "gp0", "gp1";
+            cnv-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
+        };
+    };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/iio/adc/adi,ad4052.h>
+
+    rx_dma {
+            #dma-cells = <1>;
+    };
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dmas = <&rx_dma 0>;
+        dma-names = "offload0-rx";
+        trigger-sources = <&adc AD4052_TRIGGER_EVENT_DATA_READY
+                                AD4052_TRIGGER_PIN_GP1>;
+
+        adc@0 {
+            compatible = "adi,ad4052";
+            reg = <0>;
+            vdd-supply = <&vdd>;
+            vio-supply = <&vio>;
+            spi-max-frequency = <83333333>;
+            pwms = <&adc_trigger 0 10000 0>;
+
+            #trigger-source-cells = <2>;
+            trigger-sources = <&adc AD4052_TRIGGER_EVENT_EITHER_THRESH
+                                    AD4052_TRIGGER_PIN_GP0
+                               &adc AD4052_TRIGGER_EVENT_DATA_READY
+                                    AD4052_TRIGGER_PIN_GP1>;
+            interrupt-parent = <&gpio>;
+            interrupts = <0 0 IRQ_TYPE_EDGE_RISING>,
+                         <0 1 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-names = "gp0", "gp1";
+            cnv-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index c02d83560058f7ea75e24509b4d87ef293df6773..d000c7de7ff9eba390f87593bc2b1847f966f48b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1337,6 +1337,12 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
 F:	Documentation/iio/ad4030.rst
 F:	drivers/iio/adc/ad4030.c
 
+ANALOG DEVICES INC AD4052 DRIVER
+M:	Jorge Marques <jorge.marques@analog.com>
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml
+
 ANALOG DEVICES INC AD4080 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
 L:	linux-iio@vger.kernel.org
diff --git a/include/dt-bindings/iio/adc/adi,ad4052.h b/include/dt-bindings/iio/adc/adi,ad4052.h
new file mode 100644
index 0000000000000000000000000000000000000000..37db5d9d10e788d5e7fb715c4ba9077e555131d5
--- /dev/null
+++ b/include/dt-bindings/iio/adc/adi,ad4052.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_ADI_AD4052_H
+#define _DT_BINDINGS_ADI_AD4052_H
+
+#define AD4052_TRIGGER_EVENT_DATA_READY		0
+#define AD4052_TRIGGER_EVENT_MIN_THRESH		1
+#define AD4052_TRIGGER_EVENT_MAX_THRESH		2
+#define AD4052_TRIGGER_EVENT_EITHER_THRESH	3
+#define AD4052_TRIGGER_EVENT_CHOP		4
+#define AD4052_TRIGGER_EVENT_DEV_ENABLED	5
+#define AD4052_TRIGGER_EVENT_DEV_READY		6
+
+#define AD4052_TRIGGER_PIN_GP0		0
+#define AD4052_TRIGGER_PIN_GP1		1
+
+#endif /* _DT_BINDINGS_ADI_AD4052_H */

-- 
2.49.0


