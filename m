Return-Path: <linux-pwm+bounces-4063-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2CF9C3E33
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2024 13:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE9341F2100D
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2024 12:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F811A0AFE;
	Mon, 11 Nov 2024 12:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qddtBRN+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381541A08B2;
	Mon, 11 Nov 2024 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731327167; cv=none; b=nG7yQI9Yy6Q6aOUF8QHlRZ6PVv0ddIqcB5YaDcMaz6XuCZz6YNZJ+U40UstiLz+roX3esxXjWIDPOEr/OYkEFn0iWGsLBSEsDkA4ZX2HIFPzpIJ07MO5nfxZboCXN+HQC9cdmtrSBfoJmEt6TVsexBqAPy64+JdaC1caJt0COrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731327167; c=relaxed/simple;
	bh=/9hK0NLfDkTSlh5VDhO3/k2twGEEQMyBMggpYT0hcA4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4V1NbaL/snRfU1SUJZ0hNXQ/Jbo8Ah3uS4R5RDub5hdEMODuDacKqt2uLSlFL4ZVL977bhet0hgtPZ6VVPH5veE4xLYF3L/bKSQOHdmv4/1QdJ1R9a88DMc8Jo3ZBK4Qu8QKxZstPFnsqMdQw7tpJWgmwZ318NuKphh//BCq9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qddtBRN+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB9WFke027704;
	Mon, 11 Nov 2024 07:12:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jRwRO
	Y1WWE0gmr/TbvgtAAlsDJMQisU5kEokFgjgNJw=; b=qddtBRN+gfrCBdGPrHAm5
	k32SwN8McbupHSLl3aX8OF3sjSTfZUIHoJBkJHZuqEcaoLyUzFFssTPMb05QujMd
	p6XwJJfvxUJrj7Kvs50w0y4xRBKQgPZOxNQx76yQ5i+3xsm6s4HSjuNEELXvlbVa
	LYeZDIciyHzLoGlu2ht7gN9kzWFKAoQi/fpOUXY+Uks+zn/R7O3eN50qwR3kriUR
	demdBcIpe66hbDoQFvnjsSl2XE0GqzZyZuEu2ONhuT72kAvwxyYuFrS+IRF75NbQ
	xyCxtH8IfhGiIDNRhZSJfJ/2mPkMP4af/stry9x/Jg0j1z4Fh0cN5dlvYB5q9Rqc
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42t5h5xw4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 07:12:42 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4ABCCfSL031085
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 11 Nov 2024 07:12:41 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 11 Nov 2024 07:12:41 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 11 Nov 2024 07:12:41 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 11 Nov 2024 07:12:40 -0500
Received: from amiclaus-VirtualBox.ad.analog.com ([10.65.36.213])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4ABCCFEQ010000;
	Mon, 11 Nov 2024 07:12:32 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <dlechner@baylibre.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v6 7/8] dt-bindings: iio: adc: add ad4851
Date: Mon, 11 Nov 2024 14:12:02 +0200
Message-ID: <20241111121203.3699-8-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241111121203.3699-1-antoniu.miclaus@analog.com>
References: <20241111121203.3699-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: pGf1ozbOsYRrcNG3jI1iB7YP6jGPkH4G
X-Proofpoint-ORIG-GUID: pGf1ozbOsYRrcNG3jI1iB7YP6jGPkH4G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411110101

Add devicetree bindings for ad485x family.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v6.
 .../bindings/iio/adc/adi,ad4851.yaml          | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
new file mode 100644
index 000000000000..9e9439fed3ef
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
@@ -0,0 +1,103 @@
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
+        };
+    };
+...
-- 
2.47.0


