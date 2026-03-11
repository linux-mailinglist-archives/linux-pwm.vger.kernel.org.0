Return-Path: <linux-pwm+bounces-8224-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8J61BlS2sGlvmQIAu9opvQ
	(envelope-from <linux-pwm+bounces-8224-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 01:24:52 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A5D259C0E
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 01:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9E1031B73D2
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 00:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFB433F8CA;
	Wed, 11 Mar 2026 00:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uc7KgwtZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AA3331222;
	Wed, 11 Mar 2026 00:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773188641; cv=none; b=MeHYHKSO/wGuR/sqf4rjSx73dgBxFlP8jYnV2zULuAq83oZQoogYvaiF+3k2IZ3RURIoNLWbEoYei6U97w42V3Hu3urmE9qsYDdbEooJgkDQmdgZ8b9gv3UgeLNnAWmaQxI0KAcIZ1O/T8ogCZ1Ef2Bg6sIuSffex2skbuDN9Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773188641; c=relaxed/simple;
	bh=K5N6UToS0qN7OLEd+jV2lnwrtEc6xRqZFBwhuzVad/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BG69cqCTWYdINNTyqpnMf+TPktyf827nA7zmFiiw9DrYyc+Qtj5/iGzUAFy367wa0cZPJP5HYKEsHx7gFrj7tHk0A6LUvRB0UJHbnAympLvaPiRFhsJX6CLnvgvTeOSg+0cmJ97UCUYv4aEi+xKok2xIgSaZ5ilR2RDOM4cLfi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uc7KgwtZ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ANdwPJ1139694;
	Tue, 10 Mar 2026 20:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mOPQT
	Xa9gtTgRRcuO09INVrzaf/vme2sKRMOsVVdNz0=; b=uc7KgwtZaVFU0YCI83XCJ
	wUYr2j0wrUYkid1Y9SvNTf+Coc23YInknMoSMKy54rkVSdBFD4/CdCVTsjXkP9iS
	rzdCNTwpH5ZfYInkow2gwyFolfDyHb+Ds2msukb5R4eVCzXGKPtoq9DI9MZ1B5NL
	X4kMoGBseBNS+7A5zeBW6LTtWLMLf5gyGH5SiOPA5PTrq6hadrJ6Qk7OTSQWyq+x
	5zkEl8ssSmzQtXwolmoMRon9j4oq/OL4+QaWCv4EVTiLQW/YDsU2iBlBpueQmVQs
	fG1Z6RGDEWSEnvRXAG2ziyoCFW1azpmps4dluG/Infkn1nhfJZz2j/qQ6bAktSkG
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ctw6284ce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 20:23:38 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62B0Nbd1036268
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Mar 2026 20:23:37 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 10 Mar
 2026 20:23:37 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 10 Mar 2026 20:23:37 -0400
Received: from ATORRENO-L02.ad.analog.com (ATORRENO-L02.ad.analog.com [10.118.4.140])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62B0NJkO015383;
	Tue, 10 Mar 2026 20:23:31 -0400
From: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Date: Wed, 11 Mar 2026 08:23:17 +0800
Subject: [PATCH v2 1/3] dt-bindings: iio: dac: Add binding for AD5706R
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260311-dev_ad5706r-v2-1-f367063dbd1b@analog.com>
References: <20260311-dev_ad5706r-v2-0-f367063dbd1b@analog.com>
In-Reply-To: <20260311-dev_ad5706r-v2-0-f367063dbd1b@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773188600; l=1852;
 i=alexisczezar.torreno@analog.com; s=20250213; h=from:subject:message-id;
 bh=K5N6UToS0qN7OLEd+jV2lnwrtEc6xRqZFBwhuzVad/I=;
 b=1TxjAx04GqsQMZad6JUfcEuLcWo6pl73l2gpqdWMxR7QVYnI2HGxn63k3g2LtlFOSpSo9SUAT
 Nv9FL3yWLjNBUYKXj6GS5+ldkkPB6Om4bmtjFFORLp3y1DNZ5YBd8z2
X-Developer-Key: i=alexisczezar.torreno@analog.com; a=ed25519;
 pk=XpXmJnRjnsKdDil6YpOlj9+44S+XYXVFnxvkbmaZ+10=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: QjkWGiFWtZPvdgaqfpUQb31TNP0m3s3g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAwMSBTYWx0ZWRfX40qHbDWfcstq
 qiTM0CJs5ylG+bu0/ALt1VBwiRsbkJKv20PJA6Nanc9G/PEmRVFokyV0VyrpI1um4Qdx7agWiEt
 jHsafWDwAMD2K8HvGn26///AGefgOKhUS8a9UMvKTOR2hq24NwMBEkisEtxUwtMfK3xDaf8xFuv
 5P/Vk8j+rrodzHdybn5MY37xKkk1AR/+DJ2P3odxHa8N+ZJsI55PqonnwiDLEYoFGlvzxvI2Ixz
 9AG6Zhq2ob3Mu3eNbnOTZjdDA7Bqit+71O3GDUlK1+t67hIOFjgEputxJps/p2mfGNhAXv/9kc+
 YoU92zX0L2EL8CipRCW1Fwq6LC+Aa1hidYOkqGDIL4OOxuWvhYRiQNHbYNGp7j+WoJVm+coQb4R
 cHQvJhni5SVrJeq/BVzdzbKkBLePNXA5zkSHkNbOcaOQeZMqwEGz/9nzMQxlpzQv2m0F9mRtlqT
 KXknD+SVSxf2XmfUezA==
X-Authority-Analysis: v=2.4 cv=P/g3RyAu c=1 sm=1 tr=0 ts=69b0b60a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=-QsktL4jgtg3-4nH4LUA:9 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: QjkWGiFWtZPvdgaqfpUQb31TNP0m3s3g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110001
X-Rspamd-Queue-Id: 73A5D259C0E
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
	TAGGED_FROM(0.00)[bounces-8224-lists,linux-pwm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,analog.com:dkim,analog.com:email,analog.com:url,analog.com:mid,devicetree.org:url];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Add device tree binding documentation for the Analog Devices
AD5706R 4-channel 16-bit current output digital-to-analog converter.

Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>

---
Changes since v1:
  - Removed clocks, clock-names, pwms, pwm-names, gpio properties
  - Simplified example to use plain SPI bus
---
---
 .../devicetree/bindings/iio/dac/adi,ad5706r.yaml   | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..cd5d7741562f79eefc9aba5629b8ad14490fa181
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml
@@ -0,0 +1,48 @@
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
+    maximum: 50000000
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "adi,ad5706r";
+            reg = <0>;
+            spi-max-frequency = <50000000>;
+        };
+    };
+...

-- 
2.34.1


