Return-Path: <linux-pwm+bounces-3334-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 433E697E9C3
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 12:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 030102811F1
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 10:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DA4198830;
	Mon, 23 Sep 2024 10:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="PFsnnNM2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484D5196C9C;
	Mon, 23 Sep 2024 10:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727086648; cv=none; b=IT6RnqEUoFj/ofNDh/wPC2XLcwt6vxtn29Fz6B0iSCE/Md2TklV5S3QWKXaFwNQaIlKsFBKB6ZTGK4GNlxSEjIvNMctZmDIylZeWs7nBaslUfvSXVPNdTq2NRpj8t5Jgkch4ZDvendoFTbp6X1lo8NnGWOj+XiWnjXklLXTj/u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727086648; c=relaxed/simple;
	bh=XXzW5FP1GnB4lb4is2UhQEPYyGy1RYRSkbgy5vmnI6g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EVRZBPhZH2EUvCIbaGucoIFnuxPRkzVC3M8X/q1ZVgko9ZiVfeA7BYxSyqGX6JVfBfNYM1w0gejAx2inz8gnsEheSLtyOVpMrrXNmfHo+tlx6NlSqFKC6Et9LPSNDA/RfvzF3s93oWVuCEDmTYULDSM4zDy2NPGVyUh1F3vdilc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=PFsnnNM2; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48N6tH8s025871;
	Mon, 23 Sep 2024 06:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=lpW+r
	DFRJQkTrFHMKQ2+YHg0jp560GJAD1WIw8EGgaA=; b=PFsnnNM29uJNilKWq6dFo
	Kk5F0VRLMcrm0fTd4eJ3z1ECyBiSR6pWJTsOPZbkw2KYWSEIDpgqSwNI4pRw7CsC
	NAEAvwuYyGKNSMrWYUSXl9oErLLwym2a6NDYE71k9SNTqJ33wPktD0xMPYCwp9No
	DtCcoHbRfBmksFvqkxNVy6u3JagzUCPTUPUi36ovo/l8MEj3c9ByETA77AmewRjI
	VztsnJSAlg51KboW5OJfdm2LsNINbhV2ZM7eNQffrGA4bbUV2Je1rv7wcKSLSzOL
	WqXtJyOoVW1ziAkrz+NnkKO0ZTFKuGyGvmYPy/ck8fPjjD1mJQZ6BDfRfIOHIFlZ
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 41u3frrqs1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 06:16:59 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 48NAGw7K026075
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Sep 2024 06:16:58 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 23 Sep 2024 06:16:58 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 23 Sep 2024 06:16:58 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 23 Sep 2024 06:16:58 -0400
Received: from amiclaus-VirtualBox.ad.analog.com ([10.65.36.213])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 48NAFIQV001918;
	Mon, 23 Sep 2024 06:16:50 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        "Mike
 Looijmans" <mike.looijmans@topic.nl>,
        Marius Cristea
	<marius.cristea@microchip.com>,
        Dumitru Ceclan <mitrutzceclan@gmail.com>,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Alisa-Dariana Roman <alisadariana@gmail.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
Subject: [PATCH 5/7] dt-bindings: iio: adc: add ad458x
Date: Mon, 23 Sep 2024 13:10:22 +0300
Message-ID: <20240923101206.3753-6-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240923101206.3753-1-antoniu.miclaus@analog.com>
References: <20240923101206.3753-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: D0iDsSh7ino0sif9mLR0GUUTf2GeF19Q
X-Proofpoint-GUID: D0iDsSh7ino0sif9mLR0GUUTf2GeF19Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409230075

Add devicetree bindings for ad458x DAS family.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 .../bindings/iio/adc/adi,ad485x.yaml          | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad485x.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad485x.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad485x.yaml
new file mode 100644
index 000000000000..5f5bdfa9522b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad485x.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2022 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad485x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD485X DAS family device driver
+
+maintainers:
+  - Sergiu Cuciurean <sergiu.cuciurean@analog.com>
+  - Dragos Bogdan <dragos.bogdan@analog.com>
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
+
+description: |
+  Analog Devices AD485X DAS family
+
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4858.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad4858
+      - adi,ad4857
+      - adi,ad4856
+      - adi,ad4855
+      - adi,ad4854
+      - adi,ad4853
+      - adi,ad4852
+      - adi,ad4851
+      - adi,ad4858i
+
+  reg:
+    maxItems: 1
+
+  vcc-supply: true
+
+  vdd-supply: true
+
+  vddh-supply: true
+
+  vio-supply: true
+
+  pwms:
+    maxItems: 1
+
+  io-backends:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 100000000
+
+required:
+  - compatible
+  - reg
+  - vcc-supply
+  - vdd-supply
+  - vddh-supply
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
+            compatible = "adi,ad4858";
+            reg = <0>;
+            spi-max-frequency = <10000000>;
+            vcc-supply = <&vcc>;
+            vdd-supply = <&vdd>;
+            vddh-supply = <&vddh>;
+            vio-supply = <&vio>;
+            pwms = <&pwm_gen 0 0>;
+            io-backends = <&iio_backend>;
+        };
+    };
+...
-- 
2.46.0


