Return-Path: <linux-pwm+bounces-7407-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA8EBC550C
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Oct 2025 15:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A3A3A6294
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Oct 2025 13:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B87A287512;
	Wed,  8 Oct 2025 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="EDMlE1uc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A977F286420;
	Wed,  8 Oct 2025 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931535; cv=none; b=jZN++GBc15BiX4Y/XGO8ST1Yde9w6kUdhAoxlbhw4rOR95eshZBM4eYyl+S+VqN4aMsP/BoGuT1ZeKc+D7H1PQtoy05vsMYHzaf0qO85Yzzg02yMO6SvEZBRAnTCOEmIeeNyTl+Rap2MIOglakmQVN53+dRBTZo/nVP1zxOqN8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931535; c=relaxed/simple;
	bh=ugGL3yiaxZpg+452nHetHLkQw2QDEFYdeGY+4CIzkQo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RzSkXM/aN18mqvwV0fNdq4qxLgC+Es9oje9LyA6MNywfTXY6Sn8QEkwHs8/LL64ANPf2OiAGC5GMBxPF6188P52V3z1SDnOrq+WKMX8IY8SPI/hQGzBRLDbs9dGPCwRXbz+d54l2CdR1vKicPVmOFWyCjDcYHoqoFs3zH8lcoGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=EDMlE1uc; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598BXgvi001077;
	Wed, 8 Oct 2025 09:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=t90ZX
	zDw7q407kvn9IxTpa85fORT6/7Jie1q8Cpl8+E=; b=EDMlE1ucY7WIVDQK1C2zw
	Wrx3rOA5hQlx8kDCYaM5VxeViSTQEl6Tjj8EhQDNQusz48ecyij/qnEWAzWDTGa8
	xBHyU30lRFW72kKz1KsgwCJwMwGvtEbsj8zrskbroDVvSqe8rgGHiWbQ6VrRJpTI
	f5T6Lu4VgZQOQvbOOX7iPCd9fk0fT2JN2JNNLC5EzvMuvH8fWmYWE83Epj73JNAN
	Ep1ZF3tdpv9A2VqW2QCzPXv6rvayQuRdlwvYaBtO+xd+5j11uRpHwtg22LizIqGc
	osP9S8MnLeczl1pdJhlK6yqpZqCV953ZQHyKqmWs5HPkDitctHDNvSotJcBlyQ4e
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 49nkc6srfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 09:52:07 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 598Dq6KT034871
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 8 Oct 2025 09:52:06 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 8 Oct 2025 09:52:06 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 8 Oct 2025 09:51:52 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 8 Oct 2025 09:51:52 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 598DpbQs023318;
	Wed, 8 Oct 2025 09:51:40 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <ukleinek@kernel.org>, <michael.hennerich@analog.com>,
        <nuno.sa@analog.com>, <eblanc@baylibre.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 7/8] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216 and ADAQ4224
Date: Wed, 8 Oct 2025 10:51:37 -0300
Message-ID: <7e51e036ba930284c74cf42afd53b17d49093654.1759929814.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1759929814.git.marcelo.schmitt@analog.com>
References: <cover.1759929814.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: jtFawrqp0Vb72DWeS4R7EFZ6tb-V2Q1r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDA0NyBTYWx0ZWRfXzHEooKbjmzQR
 fVuvG/QE5j78QFhqZzSFBOTPpxvtUj2x8h0NUa1VcOxrb9MLSj5bs+0eLGpchNLJTetY4DBlG3T
 FAcnn8kLKzi1nSp+nby+i7AHpJGvtB62GlhdpATo/EyP//BW8aL/3jWuOcyHkVLxKnq1n7RmBIN
 eT72cvl1aG7M61CepAFkDFX1NxFzMyGQBIhmHitqGnRSO9qe2QD1eBXFpekf50BpEINQKCiA9Dh
 1xbKarU3p3vngs2FjnEqlt21vpDBXihKPSlwPceSY1bM8kVRs1u5q8nMOBWeh0fdjsmX9ANmtKe
 bVek6Ml4aSeCHTSxG9Bp+z6dN7JKqC2gKzcHiPq3YyyXmqOmIvbPncZCvnn719Giwk7/248szop
 Qc4zajELSs5mKe5e4nwq1cqbcxlS9w==
X-Proofpoint-ORIG-GUID: jtFawrqp0Vb72DWeS4R7EFZ6tb-V2Q1r
X-Authority-Analysis: v=2.4 cv=CMInnBrD c=1 sm=1 tr=0 ts=68e66c88 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8
 a=0XOC81FH8jXXWHuWOY0A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510080047

ADAQ4216 and ADAQ4224 are similar to AD4030 except that ADAQ devices have a
PGA (programmable gain amplifier) that scales the input signal prior to it
reaching the ADC inputs. The PGA is controlled through a couple of pins (A0
and A1) that set one of four possible signal gain configurations.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v3 -> v4
- Now only documenting GPIO setup to control ADAQ PGA pins.

Pin strapped/hardwired connections to PGA pins may benefit from a "fixed-gpios"
driver which may (or may not?) use the shared GPIO abstraction layer [1]. I may
propose support for pin-strapped/hardwired connections when I get a working
fixed-gpios implementation.

[1]: https://lore.kernel.org/linux-gpio/CAMRc=Mdb_cUG+hKq8GyfUP1SYBh0p19J+4dFG7G3JSuZTr4n8Q@mail.gmail.com/T/#t

 .../bindings/iio/adc/adi,ad4030.yaml          | 71 +++++++++++++++++--
 1 file changed, 66 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
index 564b6f67a96e..d0e8452598d4 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
@@ -19,6 +19,8 @@ description: |
   * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4030-24-4032-24.pdf
   * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-24_ad4632-24.pdf
   * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-16-4632-16.pdf
+  * https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4216.pdf
+  * https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4224.pdf
 
 $ref: /schemas/spi/spi-peripheral-props.yaml#
 
@@ -31,6 +33,8 @@ properties:
       - adi,ad4630-24
       - adi,ad4632-16
       - adi,ad4632-24
+      - adi,adaq4216
+      - adi,adaq4224
 
   reg:
     maxItems: 1
@@ -54,6 +58,14 @@ properties:
     description:
       Internal buffered Reference. Used when ref-supply is not connected.
 
+  vddh-supply:
+    description:
+      PGIA Positive Power Supply.
+
+  vdd-fda-supply:
+    description:
+      FDA Positive Power Supply.
+
   cnv-gpios:
     description:
       The Convert Input (CNV). It initiates the sampling conversions.
@@ -64,6 +76,13 @@ properties:
       The Reset Input (/RST). Used for asynchronous device reset.
     maxItems: 1
 
+  pga-gpios:
+    description:
+      A0 and A1 pins for gain selection. For devices that have PGA configuration
+      input pins, pga-gpios should be defined.
+    minItems: 2
+    maxItems: 2
+
   pwms:
     description: PWM signal connected to the CNV pin.
     maxItems: 1
@@ -86,11 +105,30 @@ required:
   - vio-supply
   - cnv-gpios
 
-oneOf:
-  - required:
-      - ref-supply
-  - required:
-      - refin-supply
+allOf:
+  - oneOf:
+      - required:
+          - ref-supply
+      - required:
+          - refin-supply
+  # ADAQ devices require a gain property to indicate how hardware PGA is set
+  - if:
+      properties:
+        compatible:
+          contains:
+            pattern: ^adi,adaq
+    then:
+      required:
+        - vddh-supply
+        - vdd-fda-supply
+        - pga-gpios
+      properties:
+        ref-supply: false
+    else:
+      properties:
+        adi,pga-value: false
+        pga-gpios: false
+
 
 unevaluatedProperties: false
 
@@ -114,3 +152,26 @@ examples:
             reset-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
         };
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,adaq4216";
+            reg = <0>;
+            spi-max-frequency = <80000000>;
+            vdd-5v-supply = <&supply_5V>;
+            vdd-1v8-supply = <&supply_1_8V>;
+            vio-supply = <&supply_1_8V>;
+            refin-supply = <&refin_sup>;
+            vddh-supply = <&vddh>;
+            vdd-fda-supply = <&vdd_fda>;
+            cnv-gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
+            pga-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>,
+                        <&gpio0 3 GPIO_ACTIVE_HIGH>;
+        };
+    };
+...
-- 
2.39.2


