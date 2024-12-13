Return-Path: <linux-pwm+bounces-4338-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9FA9F128E
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Dec 2024 17:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F91828417D
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Dec 2024 16:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74291EF085;
	Fri, 13 Dec 2024 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cL5T4cbI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119011EC4F4;
	Fri, 13 Dec 2024 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108316; cv=none; b=tRXXE745AxNdZRtFM0stL0MTN79oJV++uoQs53sTcCeQVQja/aI1CIW+B5AnDH+AvWudZ1k/+oYz1RUtEdo4kXitLHSEqtI358DPosHbRj2sfqGsX3v8wIh1UjSRzT9om0fYlMqQjJvbAlDh2EwEku7agStRkqooTyH883rdc/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108316; c=relaxed/simple;
	bh=Yr6smzUP+pGNtfwEZvaNFnG7f0tKzfrcvadL1/eeVlw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pg1WEFGtC/e+TYohDAYikAgqwnq0aYMvYGtbkK4HB1sw1An0BivjJtRBgdRarIkdRVuZEOFb2sqRbEqHAOUEv5Ij1ycnMYJOeBZJjKopBBtkVi5AjG8cENhVsm/44du2dBLU2SXzYzl4KehnxFEFLbsPrESxM403M9ZnBOMuX4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cL5T4cbI; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDEpigM023598;
	Fri, 13 Dec 2024 11:45:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tbhUw
	1dKJJIJMFaB5nZIdLIXMmSaYHCgHGe5YT/dzS4=; b=cL5T4cbIFxjpEipg+IEQP
	24LUCo82B9Au4k2qQDVmvgJ4IYGcTj/75W7uvlQ7FNl8qnHfovanY514i6pvLrSB
	Rm0Tk99sfjCZF/NzLoL/bTPBMuhDBvCd8xUQ7G3gGhKcG3rrW4bzRw1mATzI/LGL
	QDDNtuPlE9+V/Ai7jZxE7ZYnYUc884+wX68zbO911r9n6UJNEzjpkt5/sAOMGfIi
	KKpNGv3H+YKPM+4sSU0aWrCN9JOTDscJTwgjqkWaEml/kVmSX9Wgl8MHuZ6ZvQFU
	5Jki7ML62I9iJINV7EPWuUpNXUN9zIFKAiwmKGzF8L8J+5JI3/t73MMTYVdhdZXD
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 43gju79jqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 11:45:11 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4BDGjAOh030814
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Dec 2024 11:45:10 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 13 Dec
 2024 11:45:10 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 13 Dec 2024 11:45:10 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.187])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4BDGipcH025509;
	Fri, 13 Dec 2024 11:45:04 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v8 7/8] dt-bindings: iio: adc: add ad4851
Date: Fri, 13 Dec 2024 18:44:44 +0200
Message-ID: <20241213164445.23195-7-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213164445.23195-1-antoniu.miclaus@analog.com>
References: <20241213164445.23195-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: HmJZhrHEwa5wCdTvYSJ1F-YcroDfSbSh
X-Proofpoint-ORIG-GUID: HmJZhrHEwa5wCdTvYSJ1F-YcroDfSbSh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130117

Add devicetree bindings for ad485x family.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v8:
 - use "bipolar" property in adc channel definition.
 .../bindings/iio/adc/adi,ad4851.yaml          | 139 ++++++++++++++++++
 1 file changed, 139 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
new file mode 100644
index 000000000000..f7acc89f75f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
@@ -0,0 +1,139 @@
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
+        description: The channel number in single-ended mode.
+        minimum: 0
+        maximum: 7
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
2.47.1


