Return-Path: <linux-pwm+bounces-8128-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qL9fM2MVmGki/wIAu9opvQ
	(envelope-from <linux-pwm+bounces-8128-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Feb 2026 09:03:47 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF61165795
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Feb 2026 09:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50959302927B
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Feb 2026 08:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B08335081;
	Fri, 20 Feb 2026 08:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="czZ+vOIz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1CE2DD5E2;
	Fri, 20 Feb 2026 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771574620; cv=none; b=eg59IDb6QzMhGh0jo7uXthP6ykqM3ccZlciq3BMeavnEAxq6HyIks7o5jEHiYVtM2gryRURUUpyb2mVJ9DEckrbpEtxn2guj6AnqjtzeH3jweaPTU2PfZFoveb+u8Gqf6SUE72T1nmzwkzSuKur8aEmjGKj67lzbcsDIP4+czzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771574620; c=relaxed/simple;
	bh=9isQTDegz19hHKeSgFeP+LMRs+EKd7MeU55wsgAcKkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nwvm2rBi5Rb8ncv2eFCrFHuko7hYxquILnTUGmR9JMrveFBv3YPuozLOft9yRqrdWmsjHiBfnrE2TZAArb0ExBR/AtO+L9kvCWD1EtlW+KlRyRTV5in0ciB3OpMEw10rFKdHWr1b8TqkK8X+s/iQBK7qInT14tK/hlHr0hvi2Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=czZ+vOIz; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61K7nlLP3994332;
	Fri, 20 Feb 2026 03:03:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=uv3Eu
	8NpkluT9h90NZq4oXSBheWBWfkPkVm3i6Rsoww=; b=czZ+vOIzB/mVug8WGS1CW
	BqqLW+9NbP2oL1IIjYq+j87cT6QyxK5FIinEDXwImhlQFnnIzC4cprtI7NjBVY2n
	6OvYnMePgcttnQgmUBYolOY+h5a0xJeTgdNp6gQN/4ZWBeMrpw8rhNt4Z+0SbJSG
	72iGdAxABsprf5qb8SNPdNKU48TzFq5HghfCatoaGqfeNwYF9IdKW/u0bfzNhbok
	5FILGowfGiiUdJ1XsB/3xzFoCiQp8hNBPSolSD4DjVZwwUf51Dh1/cQyxcTZzgL1
	FiBjKfF3IZ55WzELMDAz7p6JwdwypcS54x0/ZcJcZ+ly17wZCuMNubWZNGAN+ItP
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ced6f99y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 03:03:16 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61K83Fjq028665
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Feb 2026 03:03:15 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 20 Feb
 2026 03:03:15 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 20 Feb 2026 03:03:15 -0500
Received: from ATORRENO-L02.ad.analog.com (GGONZAL4-D01.ad.analog.com [10.116.20.162] (may be forged))
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61K82vY8007405;
	Fri, 20 Feb 2026 03:03:08 -0500
From: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Date: Fri, 20 Feb 2026 16:02:56 +0800
Subject: [PATCH 1/3] dt-bindings: iio: dac: Add binding for AD5706R
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260220-dev_ad5706r-v1-1-7253bbd74889@analog.com>
References: <20260220-dev_ad5706r-v1-0-7253bbd74889@analog.com>
In-Reply-To: <20260220-dev_ad5706r-v1-0-7253bbd74889@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        Alexis Czezar
 Torreno <alexisczezar.torreno@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771574577; l=2936;
 i=alexisczezar.torreno@analog.com; s=20250213; h=from:subject:message-id;
 bh=9isQTDegz19hHKeSgFeP+LMRs+EKd7MeU55wsgAcKkU=;
 b=Q53R3yCcJSJZY0dcATAM8DQQVn9AKQuZgCeVaO4RuDiCmgabAak5MZjumgZJKPhZIuAinlfXl
 mm1kcFaNrt9At5FlVHRSphXoTaSZ309dvEx+m51E+/8lFDSnamVmWyp
X-Developer-Key: i=alexisczezar.torreno@analog.com; a=ed25519;
 pk=XpXmJnRjnsKdDil6YpOlj9+44S+XYXVFnxvkbmaZ+10=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: bLDeYPLkpW1F3qRlxawcAsCRAOM4l8qW
X-Authority-Analysis: v=2.4 cv=fPg0HJae c=1 sm=1 tr=0 ts=69981544 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=rAWaG2PsGduRtDMPHBwA:9 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: bLDeYPLkpW1F3qRlxawcAsCRAOM4l8qW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDA2OCBTYWx0ZWRfX60roQ8OCnUXA
 XKxWz8BMCIqbDNL04Hqh+x5BT4bFjTzwzMouHTJuFvumXZ+lDsdJkMjzyjBMzbFHt4nSxTeEqUR
 fRt1Bca3L3J8ZNjxD6WGHH1aev50BZ6d5DhU96sTeSNB2pd6D7Y7Fu22EIhgXfRLw4g2de2KwGv
 kn14ipYtDRHtpzmIw1y0OKp4qt0fhV15vZh4EIsoWE5VhzMNGP5ZSVOV85sMS4Vzf38RMwMdddy
 DFctkHouUhOrRpMOdDylk//RXuY4DFNmjXn3AgU1x7wMtWSHBHly4secJ1EXjurDHXOBYiKVbZQ
 uKrvc24y966pE49i00wsmzRJTjGkurK7bGiq6xWAzmgzUIcEK80LODjnnDXa4bgFNXHDhNO/wDc
 GpaGSRUlLOBPVTmD4Ro2h/vbJ7Y78qdw+Tykju17PN2ZOWgnNfVWwkunxNpOFVNELTO2nLgXAyK
 XuFQISanVrrKhTNLvxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_06,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1011
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200068
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8128-lists,linux-pwm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:mid,analog.com:dkim,analog.com:url,analog.com:email,0.0.0.0:email,devicetree.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[analog.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexisczezar.torreno@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2AF61165795
X-Rspamd-Action: no action

Add device tree binding documentation for the Analog Devices
AD5706R 4-channel 16-bit current output digital-to-analog converter.

Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad5706r.yaml   | 96 ++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..dabaf2195a07d2c66d44f69ca60e32e6bc37cf55
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5706r.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5706R 4-Channel Current Output DAC
+
+maintainers:
+  - Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
+
+description: |
+  The AD5706R is a 16-bit, 4-channel current output digital-to-analog
+  converter with SPI interface.
+
+  The driver supports dynamic SPI clock rate management via an external
+  clock generator (e.g., AXI CLKGEN) referenced by the 'clocks' property.
+  This allows separate read and write SPI speeds to be configured at
+  runtime.
+
+  Datasheet:
+    https://www.analog.com/en/products/ad5706r.html
+
+properties:
+  compatible:
+    enum:
+      - adi,ad5706r
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 100000000
+
+  clocks:
+    maxItems: 1
+    description:
+      Reference clock for SPI clock rate management.
+
+  clock-names:
+    items:
+      - const: spi_clk
+
+  pwms:
+    maxItems: 1
+
+  pwm-names:
+    items:
+      - const: ad5706r_ldacb
+
+  dac-resetb-gpios:
+    maxItems: 1
+    description: GPIO connected to the active-low reset pin.
+
+  dac-shdn-gpios:
+    maxItems: 1
+    description: GPIO connected to the active-high shutdown pin.
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+  - clocks
+  - clock-names
+  - pwms
+  - pwm-names
+  - dac-resetb-gpios
+  - dac-shdn-gpios
+
+additionalProperties: false
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
+        dac@0 {
+            compatible = "adi,ad5706r";
+            reg = <0>;
+            spi-max-frequency = <100000000>;
+
+            clocks = <&spi_clk>;
+            clock-names = "spi_clk";
+
+            dac-resetb-gpios = <&gpio0 86 GPIO_ACTIVE_LOW>;
+            dac-shdn-gpios = <&gpio0 87 GPIO_ACTIVE_HIGH>;
+
+            pwms = <&axi_pwm_gen 0 0>;
+            pwm-names = "ad5706r_ldacb";
+        };
+    };
+...

-- 
2.34.1


