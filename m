Return-Path: <linux-pwm+bounces-5651-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 580F8A967AC
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 13:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C8C189EB19
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 11:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214D727CCEE;
	Tue, 22 Apr 2025 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="WI6sbVc2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355F527CB06;
	Tue, 22 Apr 2025 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745321738; cv=none; b=XS+XQ8KAHARUFixsccnZoKryQen9ZbLnshZDd2hC+M1zD622n7NDBW92fLev7tg6/lFynL9wi08sSK7GQEabToSPU/4vCLQLMkhC+/Aa7dvt2BsHeP/W2UjMqJkHp8j8o7YWAl7+YdSxWm1f++qi3Hw2K6Y4LkR1a8GGUG76Wq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745321738; c=relaxed/simple;
	bh=TlMA7ZQBOxvUdaio2NjH92P0I3iyaKZuK2JKBu/xeiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=A7dl1OqslkskiFSLLoxRpMKb2DT3MaGtzNkcOtNo9wbav/4AxHqj0fAmsLIIaniKHEnakZTPbMWbVi35IrYtLnikU3AgJ7IbwxfU2Arfr3mG73ZCVImSIU1JzDIE7GYabEZ70n5VbtdjhJllkQShDuw9fKX0AN0u9sOmh/lItBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=WI6sbVc2; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MAEb7D029954;
	Tue, 22 Apr 2025 07:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mvA9/
	LerFIFIqbFyGdykheft533sEC6KvAJoBSyow3g=; b=WI6sbVc2ahfnvScUhrWEv
	bmiUvgyhinbbn2xO5mJSVOrkjrGAPqOS+UpThgFykmAXsdgPp0Fe5+3k5WS/dUVt
	OBZWCLaAKntF3GV0Pgl6Wx67Gl7+rBDSwyh9o7P/1GQeva0GNfMJaEXekHwXGqYa
	lvjdvZ33mrc/xC7qXhLT1ZswkL7eW0wkkHtgd4+QTJNjr9xTtb3FdzLcOaW5PaOl
	7XpSuejoZorDVlABGtx9wTW38wB5w5NKQliBJRItr5ob/6t52Hxk6Md8zeJAZAmf
	DtmjyKUVlu9zxgzXryD6tSPRoo/o6bDaw6UnSCNc+ZqpowClhD77Xfq/AQNVBYU7
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 464t5gm6nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 07:35:21 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 53MBZJvH057901
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 22 Apr 2025 07:35:19 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 22 Apr 2025 07:35:19 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 22 Apr 2025 07:35:19 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 22 Apr 2025 07:35:19 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.55])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53MBZ4Qo024350;
	Tue, 22 Apr 2025 07:35:12 -0400
From: Jorge Marques <jorge.marques@analog.com>
Date: Tue, 22 Apr 2025 13:34:46 +0200
Subject: [PATCH v2 1/5] Documentation: ABI: add oversampling frequency in
 sysfs-bus-iio
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250422-iio-driver-ad4052-v2-1-638af47e9eb3@analog.com>
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
In-Reply-To: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
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
        "Andy
 Shevchenko" <andy@kernel.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, Jorge Marques <jorge.marques@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745321704; l=2624;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=TlMA7ZQBOxvUdaio2NjH92P0I3iyaKZuK2JKBu/xeiA=;
 b=0pCZNbtOxqcI8P1XCmBQu5TndIG1zwR9YnNlRa3plSj10lJyZXs0HaiUhiDq19xMQBT3jw7z5
 1kBNvAnWNTyDtWuuqn3GvE+fY2tQX5wZOUNewpALF5Kqu6xQoyb09Id
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=RaiQC0tv c=1 sm=1 tr=0 ts=68077ef9 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=RBIExvWx9eVdLZ2BeXAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: agFd13OU1QOm8CGJvNC_Ia7fIFqPl-3o
X-Proofpoint-ORIG-GUID: agFd13OU1QOm8CGJvNC_Ia7fIFqPl-3o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_05,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1011
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220087

Some devices have an internal clock used to space out the conversion
trigger for the oversampling filter,
Consider an ADC with conversion and data ready pins topology:

  Sampling trigger |       |       |       |       |
  ADC conversion   ++++    ++++    ++++    ++++    ++++
  ADC data ready      *       *       *       *       *

With the oversampling frequency, conversions are spaced:

  Sampling trigger |       |       |       |       |
  ADC conversion   + + + + + + + + + + + + + + + + + + + +
  ADC data ready         *       *       *       *       *

In some devices and ranges, this internal clock can be used to evenly
space the conversions between the sampling edge.
In other devices the oversampling frequency is fixed or is computed
based on the sampling frequency parameter, and the parameter is
read only.

Devices with this feature are max1363, ad7606, ad799x, and ad4052.
The max1363 driver included the events/sampling_frequency in
commit 168c9d95a940 ("iio:adc:max1363 move from staging.")
and ad799x in
commit ba1d79613df3 ("staging:iio:ad799x: Use event spec for threshold
hysteresis")
but went undocumented so far.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 33c09c4ac60a4feec82308461643134f5ba84b66..129061befb21b82a51142a01a94d96fcf1b60072 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -139,6 +139,23 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Hardware dependent values supported by the oversampling filter.
 
+What:		/sys/bus/iio/devices/iio:deviceX/oversampling_frequency
+KernelVersion:	6.15
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Some devices have internal clocks for oversampling.
+		Sets the resulting frequency in Hz to trigger a conversion used by
+		the oversampling filter.
+		If the device has a fixed internal clock or is computed based on
+		the sampling frequency parameter, the parameter is read only.
+
+What:		/sys/bus/iio/devices/iio:deviceX/oversampling_frequency_available
+KernelVersion:	6.15
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Hardware dependent values supported by the oversampling
+		frequency.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_raw

-- 
2.49.0


