Return-Path: <linux-pwm+bounces-6269-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DE2AD2ED9
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 09:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A183AEA37
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 07:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39173280030;
	Tue, 10 Jun 2025 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="UOSW/CX4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF7827F73A;
	Tue, 10 Jun 2025 07:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749540931; cv=none; b=dCC0Vj4EYXrjxZ7UHqlP0zriFq3/MIucW+U2x0d7e2nDU55nKFFafw70PDMJfwEieH0PpzkBYLBvji1MQf9yOXwNT8fThmSh3DDJW4nx71YxgUCwmyitPQwdNMevamcv+gcTa6OXI3DWaXzp5tssLxZD7h49JPtSXspfJ+/m2aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749540931; c=relaxed/simple;
	bh=BStMCOgPLwAcv0102KzdZT2L0QgfKEUgCbYK4hAWzrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fT2LUasoVCqtKdMJH9jwnW7RPJoJT0WUATYZ1vW/+F2RyKARYYbdiLNAbOP3eQ8Ofk5uwJv6jiq/7aeXPOJcs3/U3oeaSe6HGhRkkYfflSiQwp35R8desZinHYny/TjLXY8lkXMNf6xrdxSXKvafRX2Gg0gZ6qC5GGFhu2LyNrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=UOSW/CX4; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A62TUC027961;
	Tue, 10 Jun 2025 03:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=nYS8h
	VWxHnvEOeh9OJgvFtJ0jhBoLhu+GpQOdvI/82o=; b=UOSW/CX4QCL+2irmCI5ig
	ZlIUbOn96WxY91LYTaizweN5Y+5jhNUhUpzHWn/m+rUI9XQoCRllkW32k5M2Shzx
	+tXW+nacLSweYW/HxPW1mjvasD4bFNlg6ZljxVbcHzENqS7ds6m6ntwBD5DDg6+h
	bh9lo56iZBZoILsVA+IM8/sTX6a+xWeEwO7iEA5XAnInBtkLc4Q4a+tuiJ1oLFqa
	PuLwXcKxXIE/WPMSza/5R4mewBNYfBYU8QD77L8LfSGSbN991/1YvN5LZlJdg9Rv
	fBTtC692vt6khDlKfGwqPH50fIrGH0jQAO2A3t9IZyc1TF9OufkceWkYkJsOvN27
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 475u346cyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 03:35:02 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 55A7Z1UF056124
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Jun 2025 03:35:01 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 10 Jun
 2025 03:35:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Jun 2025 03:35:01 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.51])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55A7YkMf002608;
	Tue, 10 Jun 2025 03:34:55 -0400
From: Jorge Marques <jorge.marques@analog.com>
Date: Tue, 10 Jun 2025 09:34:34 +0200
Subject: [PATCH v3 1/8] Documentation: ABI: add oversampling frequency in
 sysfs-bus-iio
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250610-iio-driver-ad4052-v3-1-cf1e44c516d4@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749540886; l=2299;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=BStMCOgPLwAcv0102KzdZT2L0QgfKEUgCbYK4hAWzrM=;
 b=SFBpg39X0yjLGyt/eCwcA2RBmfaREh3W1gW6zKTyksHjCCaH7RZr45LuEVmsirZo0JdpODEVX
 hl/Vxw2rDGlAh7EE212sGr3wi0O/iVCqWmJJXC9tc5ebCNPh3pT0f1P
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=R74DGcRX c=1 sm=1 tr=0 ts=6847e026 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=RBIExvWx9eVdLZ2BeXAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: NMKyQ_A2qgZtDghLkVgYwl1npDCu7nke
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA1NiBTYWx0ZWRfX5Ky6/OkSuB4f
 birNCA5GKcokoo8V6BvTkpo0dkV25mnr+zM3j/vREzlAZejizFP+KMVR/JOQjD2Yl/EuVlE5w7w
 qulg5lEIYWX62lbO3ttYjqc4eAEyB/aUDigSEt6ViHB/f4VHNaSUHW6ZP2w10d4Sm3t1e1QMCvM
 Oc8F3OPPra+6yK72vR2MHtl2b1KaGSXkYgRFrjk3icrF1lEeumaS/y0NJ2lZAkPcDXHR7TLuysF
 nebQRCHWjw00LkEroDeV0cg9sArOVbrQYfUn+6Bgwak7xihIW+OsEGPUJPCfWqTdHRjoq9nLJtc
 9A7nM8Ji4voJlfQ7S/srMQuir6CXFvqLv02nTVOnOOuBYKtUuOjRhD0nIVDWkelBI98tZWu3s+C
 5UfhO3DHzYijoN8l8kz1vS1Y0DW61wpYdqLxCukIDRt7JWGBdaljhaM+5LrRrLs9oYaRR0CE
X-Proofpoint-GUID: NMKyQ_A2qgZtDghLkVgYwl1npDCu7nke
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_02,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100056

Some devices have an internal clock used to space out the conversion
trigger for the oversampling filter, Consider an ADC with conversion and
data ready pins topology:

  Sampling trigger |       |       |       |       |
  ADC conversion   ++++    ++++    ++++    ++++    ++++
  ADC data ready      *       *       *       *       *

With the oversampling frequency, conversions are spaced:

  Sampling trigger |       |       |       |       |
  ADC conversion   + + + + + + + + + + + + + + + + + + + +
  ADC data ready         *       *       *       *       *

In some devices and ranges, this internal clock can be used to evenly
space the conversions between the sampling edge. In other devices the
oversampling frequency is fixed or is computed based on the sampling
frequency parameter, and the parameter is read only.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index ef52c427a015cf47bb9847782e13afbee01e9f31..e60367255be89a9acc827ec1a749b729735f60e6 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -139,6 +139,23 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Hardware dependent values supported by the oversampling filter.
 
+What:		/sys/bus/iio/devices/iio:deviceX/oversampling_frequency
+KernelVersion:	6.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Some devices have internal clocks for oversampling.
+		Sets the resulting frequency in Hz to trigger a conversion used by
+		the oversampling filter.
+		If the device has a fixed internal clock or is computed based on
+		the sampling frequency parameter, the parameter is read only.
+
+What:		/sys/bus/iio/devices/iio:deviceX/oversampling_frequency_available
+KernelVersion:	6.17
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


