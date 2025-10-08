Return-Path: <linux-pwm+bounces-7403-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 718C6BC54A0
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Oct 2025 15:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38BF73B6E35
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Oct 2025 13:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8FB287268;
	Wed,  8 Oct 2025 13:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SWXlKF3M"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF6D16F288;
	Wed,  8 Oct 2025 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931449; cv=none; b=dIruh6YUQPoBwA1BatgGKUBxOcf5mTYuBwuPKe/VT6yUbhYRrqpHNjGYUgMWWxU9KtCx2YIThEaMWt4Ca408sxeGNYTeebSQTzv8fyK6vwZukT2OHqFQnmFVq1frXA9zk7D9TORkDiy+x4tXuF+yKLYUqJk2nDcxA+J0ZSbiGSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931449; c=relaxed/simple;
	bh=vreuyB1oJMX28dl3w587JJSbrdpOaZ848torossb2pI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDSp5i6qMNczC++1lKXRNxwruOr54K7YG9FIRE9+mrIrinWw/pwz2+ZRUkRnLO3TJTcUL4LDPLp2+JH9rsBm9jYsIMN1HNkMqh4ej6El2cznCfiNJAMUsO7bYqCdmrccBWewUlv6NEoY09t7sy+Dai7PUu9OhOkOAKwqvGjHzoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SWXlKF3M; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598D6wjl010585;
	Wed, 8 Oct 2025 09:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/m5lg
	W9LZdYxB6YJs1TYPvAh9FlaVDaMUHUk0YNse/U=; b=SWXlKF3MmYYs1uxXPkVUE
	yOk+bLoXQ55c6qp6PHd9Odii23Ds6omvsKX4jz0t3gg4E1ma0QOEP1TndRdJx2w8
	m9y34lrmKs0EcSj3tzh+F9tRwOrNpDYB0yRDkwltZrT/COeFBIRs02Ol9FKGgTm1
	dMFH6/oxieg4iy8UA9YqJVcX33Ds3pooGngc3jJuhlBMW31ncKaUzw43TudjFcii
	4ezYEb83hRfHp1oLDaniMDIP7FIjOnf46kQ2r3gP0mQUDWZQySYURcsWDFG3TW9U
	BKH7Bg7tmlZ36PdMXk0pIao/o5z3ZNOU2Ms3lUr5tBzPstQDiQDnscpQkLMnt7fP
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49jwe27442-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 09:50:39 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 598DocS1034658
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 8 Oct 2025 09:50:38 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 8 Oct
 2025 09:50:38 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 8 Oct 2025 09:50:38 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 598DoMCX023152;
	Wed, 8 Oct 2025 09:50:24 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <ukleinek@kernel.org>, <michael.hennerich@analog.com>,
        <nuno.sa@analog.com>, <eblanc@baylibre.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 3/8] Docs: iio: ad4030: Add double PWM SPI offload doc
Date: Wed, 8 Oct 2025 10:50:21 -0300
Message-ID: <30501211fb199f3322e2ec5d3fd2b0adac74f15e.1759929814.git.marcelo.schmitt@analog.com>
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
X-Authority-Analysis: v=2.4 cv=Y7n1cxeN c=1 sm=1 tr=0 ts=68e66c2f cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=x6icFKpwvdMA:10 a=wI1k2SEZAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=Z7BqY8bEq__jAXHbdh4A:9 a=6HWbV-4b7c7AdzY24d_u:22 a=IawgGOuG5U0WyFbmm1f5:22
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=poXaRoVlC6wW9_mwW8W4:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-GUID: KtL50UfRmR_BybjJxFgSFaJDjQnWZT0G
X-Proofpoint-ORIG-GUID: KtL50UfRmR_BybjJxFgSFaJDjQnWZT0G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDA0MyBTYWx0ZWRfXwgvJXXYfDDJ0
 iGuT2ECtw4ZKG81w5QkpGFVfWm9WFbcEml5JM8HPpnW2xAU2H0oHhoKUNEiveQ1bV850pMr1W4v
 XUviZE1lb6BnwmnSpxzXMn3t4tt8ya3ffFxPuxWlTxQS4Is+fiyRajrurbIeaBYNo0EbcIFDJ/Z
 prlW6rNt/XpurDX41/RAtn6Qpy59SX0bKstK+9FrUyH0T0RZuZQqvxIBg+zYcxzRouRkCThXCeC
 DnBCM1RqMx9RzUDEvl/IZIE4KYY2zM2tZsbkuxy11QEanY+2tk78w1+KOWby/NxpvQwilhijdTn
 Ka5W81wK7a+5FR33CM9HqZVAygQOIf4SjW5XPHd5R5ty68pPEkCncUDhVYd5Hyzg/111RxIc+VY
 trmtUko0EF2oJkJ17dVatqk1n9C7TA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040043

Document double PWM setup SPI offload wiring schema.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/iio/ad4030.rst | 39 ++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/iio/ad4030.rst b/Documentation/iio/ad4030.rst
index b57424b650a8..9caafa4148b0 100644
--- a/Documentation/iio/ad4030.rst
+++ b/Documentation/iio/ad4030.rst
@@ -92,6 +92,45 @@ Interleaved mode
 In this mode, both channels conversion results are bit interleaved one SDO line.
 As such the wiring is the same as `One lane mode`_.
 
+SPI offload wiring
+^^^^^^^^^^^^^^^^^^
+
+.. code-block::
+
+    +-------------+         +-------------+
+    |         CNV |<-----+--| GPIO        |
+    |             |      +--| PWM0        |
+    |             |         |             |
+    |             |      +--| PWM1        |
+    |             |      |  +-------------+
+    |             |      +->| TRIGGER     |
+    |          CS |<--------| CS          |
+    |             |         |             |
+    |     ADC     |         |     SPI     |
+    |             |         |             |
+    |         SDI |<--------| SDO         |
+    |         SDO |-------->| SDI         |
+    |        SCLK |<--------| SCLK        |
+    +-------------+         +-------------+
+
+In this mode, both the ``cnv-gpios`` and a ``pwms`` properties are required.
+The ``pwms`` property specifies the PWM that is connected to the ADC CNV pin.
+The SPI offload will have a ``trigger-sources`` property to indicate the SPI
+offload (PWM) trigger source. For AD4030 and similar ADCs, there are two
+possible data transfer zones for sample N. One of them (zone 1) starts after the
+data conversion for sample N is complete while the other one (zone 2) starts 9.8
+nanoseconds after the rising edge of CNV for sample N + 1.
+
+The configuration depicted in the above diagram is intended to perform data
+transfer in zone 2. To achieve high sample rates while meeting ADC timing
+requirements, an offset is added between the rising edges of PWM0 and PWM1 to
+delay the SPI transfer until 9.8 nanoseconds after CNV rising edge. This
+requires a specialized PWM controller that can provide such an offset.
+The `AD4630-FMC HDL project`_, for example, can be configured to sample AD4030
+data during zone 2 data read window.
+
+.. _AD4630-FMC HDL project: https://analogdevicesinc.github.io/hdl/projects/ad4630_fmc/index.html
+
 SPI Clock mode
 --------------
 
-- 
2.39.2


