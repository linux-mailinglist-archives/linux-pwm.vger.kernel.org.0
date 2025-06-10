Return-Path: <linux-pwm+bounces-6270-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0266AD2EE3
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 09:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AECB1893A47
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 07:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74753280319;
	Tue, 10 Jun 2025 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Vknqc7Fy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22A227F164;
	Tue, 10 Jun 2025 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749540931; cv=none; b=dbqzuupUoUjw5JC3LZ5l3xTKNxE1LrosftMv2sXMQrQzLjn6GuGCWl8SQxq/8Gb/O79Z0gqEa7K6y1tgQw8X7/GdtNrjTxauHytjOpnAJtWpfD/td9HHe9wsmxG/R3E9nsefFmeFNK1T98CcTSlowZUJm5KmU1gcOG8GHR0PwlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749540931; c=relaxed/simple;
	bh=wRpByI1coJpFEIh+zJNKNHgrlO5l0ATlV/vp7byccE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kP54xMx7ZjqeVxoo/BQFiKgxJ06v8pDbBdVXe18E/S1K7v1yM5wwYDIjVLCDKNMNTdJePAMwyToXqEERpGXEFAw5AXgN8/F9+f1gJXWNXirk4cKi8T3pNqhtbeXi0ZCXPVm9jyqcS6N8i0W4g1nD3t1OzMCSElq/WsHNZClIwhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Vknqc7Fy; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A6uqt9002452;
	Tue, 10 Jun 2025 03:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=b8URu
	x3k/Kp76Jxq7h6A+CDTnwaDlwXerEzBO9LTHvw=; b=Vknqc7FytR5sBDtm3j283
	9QpjvaFRtyLfeqJTEhDHWRHUye8caqEevT/Yzr9wn9Ss0YWbREy/cxV62SLWZ2nQ
	JfTmY4Fqd4OX2v1Wzen45t7n5y0yrH26nOc+aoN9BWzumT8xHmJZ608sW54Eg6Ap
	JXG317haEAW4fA2enQl+olRUYLqnM00aTYRD403MiDV41BkuelCzjDf8ivgTKJ2r
	3E5+lYJ3GTzg/0GEidr9ZbZ18dMNCU3uMNW82uslXIBmNI5dzf41KkuOAl/S7TGW
	rzNUk1yxwSw3CqRktpX+tUtiRfQiMYE7xnt0hLNPomN6usLUT0p7qHSgykjqty0d
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 476fvkr7q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 03:35:16 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 55A7ZF1x056174
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Jun 2025 03:35:15 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 10 Jun
 2025 03:35:15 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Jun 2025 03:35:15 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.51])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55A7YkMl002608;
	Tue, 10 Jun 2025 03:35:06 -0400
From: Jorge Marques <jorge.marques@analog.com>
Date: Tue, 10 Jun 2025 09:34:40 +0200
Subject: [PATCH v3 7/8] docs: iio: ad4052: Add event documentation
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250610-iio-driver-ad4052-v3-7-cf1e44c516d4@analog.com>
References: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
In-Reply-To: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, Jorge Marques <jorge.marques@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749540886; l=2133;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=wRpByI1coJpFEIh+zJNKNHgrlO5l0ATlV/vp7byccE0=;
 b=ji7mAuuU994h1QB4oGT2M8cOkLGrPQA+pJPttJrdTg7uqIFql+lSN97ktdF9TMmyX35e5TF1W
 wCxz1XXouYqDN23EeV3MGIJmubwfiZVYoFyuNx9a08cfMiOl49vdAvR
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA1NiBTYWx0ZWRfX8UhCCaKxg/J6
 xkr0upiZcQhcm1MNWm0QnQ0Nq7zsIGTFqnCljeC5mUrSu7RFKRe9w2rmikl2P2A9Zu2vQqjYkyM
 GJ03wjHPi/2F9Tm62fMJ7YDPsOchwIPo/Pv+Pf0+yd7JZSC+ygt9iCl52yFP8M5uv8nP2jpaj3s
 dc+mCsu3fMfx98F8rzvxbMkhoVUABV7Ik2IN5j1p6NsG0rdpjMd7gQf0W5xcnZcRmfcNJ1v0/k8
 14JXcto58frfYSN7ovXtuZJ77t65vSTuetR5iiQbGJkYg++F+OFkW4G1N4x1OagOdWbQazRaDv0
 95rsP65ySxLAsVrGf0d2+YCHJMoAirRXhVnzlZpc9pBoXRyKIqVLgLlmd49/ENhDKwd+sK/+LAY
 0ujDnGP8UV7aXRGRiK4jX3m1dfWmOy3Mm0Xdu3z+Fv7jLp5lmBaoIiMX27MLAaEm4EWD9WUS
X-Proofpoint-GUID: prhMjQO8IIsya-Yfpp1B43BKxKRaG-jg
X-Authority-Analysis: v=2.4 cv=Coy/cm4D c=1 sm=1 tr=0 ts=6847e034 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=55yT-0NB-ohaRzUcirIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: prhMjQO8IIsya-Yfpp1B43BKxKRaG-jg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_02,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506100056

Explain the AD4052 monitoring support by exposing as an IIO event.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 Documentation/iio/ad4052.rst | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/iio/ad4052.rst b/Documentation/iio/ad4052.rst
index 2ad1c7712766118b03c48929d1f2b7670d5f8d41..da9c0481dfcd3b4eecd91280b7f259aa9118467c 100644
--- a/Documentation/iio/ad4052.rst
+++ b/Documentation/iio/ad4052.rst
@@ -93,3 +93,41 @@ When SPI offload is being used, additional attributes are present:
      - Description
    * - ``in_voltage_sampling_frequency``
      - Set the sampling frequency.
+
+Threshold events
+================
+
+The ADC supports a monitoring mode to raise threshold events. The driver
+supports a single interrupt for both rising and falling readings.
+
+The feature is enabled/disabled by setting ``thresh_either_en``. During monitor
+mode, the device continuously operates in autonomous mode until put back in
+configuration mode, due to this, the device returns busy until the feature is
+disabled.
+
+The following event attributes are available:
+
+.. list-table:: Event attributes
+   :header-rows: 1
+
+   * - Attribute
+     - Description
+   * - ``sampling_frequency``
+     - Frequency used in the monitoring mode, sets the device internal sample
+       rate when the mode is activated.
+   * - ``sampling_frequency_available``
+     - List of available sample rates.
+   * - ``thresh_either_en``
+     - Enable monitoring mode.
+   * - ``thresh_falling_hysteresis``
+     - Set the hysteresis value for the minimum threshold.
+   * - ``thresh_falling_value``
+     - Set the minimum threshold value.
+   * - ``thresh_rising_hysteresis``
+     - Set the hysteresis value for the maximum threshold.
+   * - ``thresh_rising_value``
+     - Set the maximum threshold value.
+
+If the interrupt ``gp0`` is not provided, the IIO events attributes are still
+present, but no IIO Event will ever be triggered. This allows to use ``gp0``
+output to trigger other resource.

-- 
2.49.0


