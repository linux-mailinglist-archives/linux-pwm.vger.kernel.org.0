Return-Path: <linux-pwm+bounces-4651-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A48DBA15030
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 14:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D677A3A9293
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 13:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEE3202C23;
	Fri, 17 Jan 2025 13:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uefdiRTh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBC1201259;
	Fri, 17 Jan 2025 13:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737119255; cv=none; b=jB4FFeXu1HDb/o9RvLmCi/qULd4zqF9ux4ytFp2QJqOXl9ns0uLhRVlsuVRgWmK18x876ylFGt13Lv6YQYPg9rVh/5hVn7pEGL/QTY139vgtHnac+Hm3t8VWCbut5vVdWFWaDf6cRwoZpe8jN2H5XI9wuAyMrG8bZu4j1BdPQzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737119255; c=relaxed/simple;
	bh=SnBMHnKnj1tC8LtVnrBULcmj8zdhdD7cwOkX2E2VlUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dRE38mmVBhINLYUXo72V3e5F/+tdm4AqWC3Kv75FtT/RATNRreNajUFMf2UaGW/bi6v4vl6fqr4Ey+s0OKZqjhl8uLhoNrIjeQf8/ywJYESpzXvzOkavVLUAu8MYHN2veQwM2a5uAlW0u5oikf3MsWVu/Rj7ixUnjj49hIIbwS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uefdiRTh; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50HAhRSm023560;
	Fri, 17 Jan 2025 08:07:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=lsOSt
	Yi8CQtrKS9/jJ05D1NG/T/fHO7SkRThjhBKbA4=; b=uefdiRThF007ECX0PakfD
	w4cpYNhZW0GCzlYm5NJSdBMrtDAey0PXud7B0vFdyaF7rWddgH8Hn5kKtLtHk8/6
	NX9IpamCqrk8KgMLxADWqOozIWiIaRaHhmkS4AF+GnOspik+COMoOlphUNkmzhad
	wISZcj1Vkyi6pCdrLPrB30YEIEFyBOAZm168ivhb4rpxfobvKQ0QP6fM5NKoPL3A
	TMqSgTcla60td5LPyJLlPeTSjnIu5THUkBhpYgyMuQya+mE92xvS4xpocho6rpym
	hc7cdYmpW/2Ym5E3+4NKSV75r7jKA9LJr08hZ9etJvGIa9bOU3vZYFEqmQHT/RXE
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 447nq10gf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 08:07:30 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 50HD7TVA027848
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 17 Jan 2025 08:07:29 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 17 Jan 2025 08:07:29 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 17 Jan 2025 08:07:28 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 17 Jan 2025 08:07:28 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.159])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50HD764p013564;
	Fri, 17 Jan 2025 08:07:20 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v10 7/8] dt-bindings: iio: adc: add ad4851
Date: Fri, 17 Jan 2025 15:07:01 +0200
Message-ID: <20250117130702.22588-8-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250117130702.22588-1-antoniu.miclaus@analog.com>
References: <20250117130702.22588-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: LqX410LaeMUoz8b8qv1qnonqMgf0qfkh
X-Proofpoint-GUID: LqX410LaeMUoz8b8qv1qnonqMgf0qfkh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_05,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501170106

Add devicetree bindings for ad485x family.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v10:
 - improve channel properties description.
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


