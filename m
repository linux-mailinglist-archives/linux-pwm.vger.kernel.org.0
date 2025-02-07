Return-Path: <linux-pwm+bounces-4818-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B28FA2C4EC
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Feb 2025 15:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22531883DD0
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Feb 2025 14:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC84217677;
	Fri,  7 Feb 2025 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hiLCCTuG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712011F76B4;
	Fri,  7 Feb 2025 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738937406; cv=none; b=EonKBPPN+sDLUP2Rgv04ypZY6pvfjczWrXgbS7CKwbv6dZIauvhD9w4GxCtUv2a/KGATd58oO5DI+e/QkPcARI0VFNTJc0JWG4RcVrx83PUtIauX9P5lh23pSDbY3dvepkQd2U0poBzczR6gKXTXRsDzehmU8jPEu6dqAkUn8jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738937406; c=relaxed/simple;
	bh=Yp575RH6BwU1dL9bLIYjiLBrXtGG7Px4ArBeReU9tSs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onuOzMyhZ0WrBed+Yl3A8E5jM0/bAKlGHV7Vp0r6TOBe5+HvNadHLiUDIkn3qRSYe5ijn5s8kr32SAdikFBj4j7KN3BO8hztlyvh2oAXT+b1lpBCjRGNikp+oWX6i1JyXaAryh7G2veBCoYnmJbNQxWSi3oLjq059kV3UTltN20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hiLCCTuG; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5179Kg4j022333;
	Fri, 7 Feb 2025 09:10:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=vPi2z
	4RcciElgTJNg8wwxR0SaZWaGo29+9h6Efd8yU8=; b=hiLCCTuGCGi5hFNUAsOOl
	hjz5n3DBzcGEySB0QbH5dZUUChfLndcDcd5z49vLjqNdtKD9BJ++auzEa2LDsDy8
	2u2ioe1fb3lR0hKP+4/sv2SrTX6Oa3oRMYaLk44I83zXe8Pe+QIN0WydZZdKLRzF
	xbebX1Fbm9MDAAFBjd12gwKb/A4Fl7BFHcOYrerrPxQh0Mdj8sWVih6F4hQ6IHn5
	pVE9CyDw1HnJw0SWv4OhXiJrmKST81fSga50WI9P5x4r3M0qQEDWWI2ZKB62onCR
	zLbpxI+fT18tkEfbOZNxRFaJxZZ+uMba4bK30/CWRWssuXeGT91mq7rxyXnlqUfD
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44nff99134-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 09:10:00 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 517E9x3J008521
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Feb 2025 09:09:59 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 7 Feb 2025
 09:09:58 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 7 Feb 2025 09:09:58 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.147])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 517E9a4u015095;
	Fri, 7 Feb 2025 09:09:52 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v12 8/9] dt-bindings: iio: adc: add ad4851
Date: Fri, 7 Feb 2025 16:09:17 +0200
Message-ID: <20250207140918.7814-9-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207140918.7814-1-antoniu.miclaus@analog.com>
References: <20250207140918.7814-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: SoldVp_U1E6pxW5kIqcFfap9bZnFZwzc
X-Proofpoint-ORIG-GUID: SoldVp_U1E6pxW5kIqcFfap9bZnFZwzc
X-Authority-Analysis: v=2.4 cv=Pt9pbxM3 c=1 sm=1 tr=0 ts=67a61438 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=T2h4t0Lz3GQA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=XYAwZIGsAAAA:8 a=fZsOGKJ4Br6LgI_lcG4A:9 a=sptkURWiP4Gy88Gu7hUp:22
 a=oVHKYsEdi7-vN-J5QA_j:22 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_06,2025-02-07_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502070108

Add devicetree bindings for ad485x family.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v12.
 .../bindings/iio/adc/adi,ad4851.yaml          | 153 ++++++++++++++++++
 1 file changed, 153 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
new file mode 100644
index 000000000000..c6676d91b4e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
@@ -0,0 +1,153 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2024 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad4851.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD485X family
+
+maintainers:
+  - Sergiu Cuciurean <sergiu.cuciurean@analog.com>
+  - Dragos Bogdan <dragos.bogdan@analog.com>
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
+
+description: |
+  Analog Devices AD485X fully buffered, 8-channel simultaneous sampling,
+  16/20-bit, 1 MSPS data acquisition system (DAS) with differential, wide
+  common-mode range inputs.
+
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4855.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4856.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4857.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4858.pdf
+
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - adi,ad4851
+      - adi,ad4852
+      - adi,ad4853
+      - adi,ad4854
+      - adi,ad4855
+      - adi,ad4856
+      - adi,ad4857
+      - adi,ad4858
+      - adi,ad4858i
+
+  reg:
+    maxItems: 1
+
+  vcc-supply: true
+
+  vee-supply: true
+
+  vdd-supply: true
+
+  vddh-supply: true
+
+  vddl-supply: true
+
+  vio-supply: true
+
+  vrefbuf-supply: true
+
+  vrefio-supply: true
+
+  pwms:
+    description: PWM connected to the CNV pin.
+    maxItems: 1
+
+  io-backends:
+    maxItems: 1
+
+  pd-gpios:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 25000000
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "^channel(@[0-7])?$":
+    $ref: adc.yaml
+    type: object
+    description: Represents the channels which are connected to the ADC.
+
+    properties:
+      reg:
+        description:
+          The channel number, as specified in the datasheet (from 0 to 7).
+        minimum: 0
+        maximum: 7
+
+      diff-channels:
+        description:
+          Each channel can be configured as a bipolar differential channel.
+          The ADC uses the same positive and negative inputs for this.
+          This property must be specified as 'reg' (or the channel number) for
+          both positive and negative inputs (i.e. diff-channels = <reg reg>).
+          Since the configuration is bipolar differential, the 'bipolar'
+          property is required.
+        items:
+          minimum: 0
+          maximum: 7
+
+      bipolar: true
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - vcc-supply
+  - vee-supply
+  - vdd-supply
+  - vio-supply
+  - pwms
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0{
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "adi,ad4858";
+            reg = <0>;
+            spi-max-frequency = <10000000>;
+            vcc-supply = <&vcc>;
+            vdd-supply = <&vdd>;
+            vee-supply = <&vee>;
+            vddh-supply = <&vddh>;
+            vddl-supply = <&vddl>;
+            vio-supply = <&vio>;
+            pwms = <&pwm_gen 0 0>;
+            io-backends = <&iio_backend>;
+
+            channel@0 {
+              reg = <0>;
+              diff-channels = <0 0>;
+              bipolar;
+            };
+
+            channel@1 {
+              reg = <1>;
+            };
+        };
+    };
+...
-- 
2.48.1


