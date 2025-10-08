Return-Path: <linux-pwm+bounces-7402-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D443EBC546A
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Oct 2025 15:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BAAF3A5250
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Oct 2025 13:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC590287267;
	Wed,  8 Oct 2025 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="i/R8uxyo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB11286D60;
	Wed,  8 Oct 2025 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931429; cv=none; b=HTeWl3L+S9kYwDfaAaJDyja/hbiWIIFKbGYYTcHm4vivlDhaIXP/Y6yeid+nrJRojEiXpRiCuV3zPjhn+zI9EJmTAqx5zk18BkxlZMhCOjOD65QzGHVFQsLy2v3mG1EwclCU2fMm8uD0uBNXO+IPpLUe4VvlAgebJC1CTgNW/u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931429; c=relaxed/simple;
	bh=WZ9Dsob8217rQMVY/2ETpmcz51DbclJK5tiSEfVxA3E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e5eMAU+RNqkyqTw95WVxtIsuu46pthbRfxxMMD5Txy7LjT62JJdVkezSJWYdkymX6Gyzk1BhPMvZP3Hf5U+f0yYSGkHSkdaC8I+MvjrmRitjIP41VSLz8JZh5HGIzU6IBoYZKMyUvN5QUvcOp95sQXM1r6QpDRBsHvyJkW3GoVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=i/R8uxyo; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598D9EHa010582;
	Wed, 8 Oct 2025 09:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=S14ln
	y/Kcps9xDIlvxH1tzTzOuHDv/EVueka5mwTaCY=; b=i/R8uxyoZnesRFg+GI9FS
	Qe2k90MnnIwZ0ndwL+3cIR9TvPFUSnYGJMBWT/JU8z2PuncgG29MA/+xysOgP7DU
	D+RoE+MjwQvUec2y7lHRm6r7oiCkBEDIiHBRHXgupbtznVVsrGoVlykix12mqIoG
	AEHf+JadpkLur/OlzRB20wNW7sGSjW0xS45uFXfuJ8Q2MEzeDv7IMEFrT9S38Cmo
	VYv+hfNEWFvIilijJOiAV9t7Sx8JpH7mcq/LCfpInPWiUZYG3K50Feay48m8Nf8e
	z4lfois5e7xiMM7cG6Boa6OJlLvFcOgtVoTjdfb17X/ROnFVwJuypFLrUG3Ns522
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49jwe2742g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 09:50:21 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 598DoIC0034526
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 8 Oct 2025 09:50:18 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 8 Oct 2025 09:50:18 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 8 Oct 2025 09:50:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 8 Oct 2025 09:50:17 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 598Do3qK023146;
	Wed, 8 Oct 2025 09:50:06 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <ukleinek@kernel.org>, <michael.hennerich@analog.com>,
        <nuno.sa@analog.com>, <eblanc@baylibre.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
        "Conor
 Dooley" <conor.dooley@microchip.com>
Subject: [PATCH v4 2/8] dt-bindings: iio: adc: adi,ad4030: Reference spi-peripheral-props
Date: Wed, 8 Oct 2025 10:50:03 -0300
Message-ID: <5dcddffbd766a41ad6ef66f03ca5e74d96392167.1759929814.git.marcelo.schmitt@analog.com>
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
X-Authority-Analysis: v=2.4 cv=Y7n1cxeN c=1 sm=1 tr=0 ts=68e66c1d cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=x6icFKpwvdMA:10 a=gAnH3GRIAAAA:8 a=XYAwZIGsAAAA:8 a=EfQ9L3lKGMo9VN_2EekA:9
 a=E8ToXWR_bxluHZ7gmE-Z:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: P-_QyPTmD5VLCTEcgKvdbHazj-spBKEf
X-Proofpoint-ORIG-GUID: P-_QyPTmD5VLCTEcgKvdbHazj-spBKEf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDA0MyBTYWx0ZWRfX16aNxcj35UWB
 0+Q2Mb/fd84Lnpl3WDgfVzarDwa3rIkOnoEIapMjpu6rqeQ6ETdVG9FOsn7ekOtbK0nyRC0tGbK
 wbe5DhryWPP55PPy/Yd/fRjy8xc1n8e2fvVaB5TZ7J61bpphuvczzBnOiNryt3n1+uAMJem9OQ3
 dNELaVYIbLPgFf005VH8PV/efnEdCoQ/2CnVxfXwbNyJKzqKrI65p6EApSx5SaXlOlDHCQ3EoEG
 uoFOJ6Nct8SiUWLefuAOOjga3h4QsiX2vrFIJwdSgHKZvJ4D8omwN+hh/apRh8Ds3J/vxHie/Ta
 TsAI44SK3HYpJ5LYi1N9muJRCzTCflb8sq3aVyz7xR7a4vWIdnHtE4pdV03MRZTmrOdLE9b+ojo
 J+o1yaCTML1FmN/cbq0iCGteH0P37A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040043

AD4030 and similar devices all connect to the system as SPI peripherals.
Reference spi-peripheral-props so common SPI peripheral can be used from
ad4030 dt-binding.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
index 54e7349317b7..a8fee4062d0e 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
@@ -20,6 +20,8 @@ description: |
   * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-24_ad4632-24.pdf
   * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-16-4632-16.pdf
 
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
 properties:
   compatible:
     enum:
-- 
2.39.2


