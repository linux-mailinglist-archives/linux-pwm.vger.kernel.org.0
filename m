Return-Path: <linux-pwm+bounces-5654-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B0CA967BF
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 13:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EFBC169326
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 11:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EA527F4CC;
	Tue, 22 Apr 2025 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="d7KVxezB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195AA27EC69;
	Tue, 22 Apr 2025 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745321744; cv=none; b=JNfjj6et6G6CDoSikXgLT07dkwIcqFwCM1+CZuwsp6UQCBztRPejjBhOCRgi0kSaMoosJuI8Ydhf7aLkivFHsHRvIzTaYoy3+aq1sbqsGHze8NAH30JQpqeQiEDTNeygH01mP9AliUWVipbQcsq/al+Iq4gcmTMW+38ZhJl4GU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745321744; c=relaxed/simple;
	bh=QtEocJy/CJth/1vVDY0oG1mV878r2tNjKt4aQLtRDb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RsMtvEJyQfaAtMFMri91rYK9G56xkT1N6uMWZ5nsSjq6gvqzZfnYGFbYPr/BtcfC4CkJZ58sFJC9AXNLqIXJwSUEDdKes9jM+0BsiZnDVbJeOF+QYb7JtBuav6yHUgbLsj99vONdJ0zP9tSoOqhUTna0j5Wd4dqzBalLK4Uc5bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=d7KVxezB; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MAWq8W022389;
	Tue, 22 Apr 2025 07:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=VGzu1
	GLzxd8b4H7qPy2W9Zq0LtV9JQ9yF0J8aNtLXlM=; b=d7KVxezB4EkDzSlCkGDCJ
	CWD1PUE31UVF36EGGRhN3lIG5TfaJI7Sz2lsZu8+ZdIzVGl8qN04FFAELjAOrP9B
	VIijvG/klwKHaf3fZVG64fXn3vZT++snLs7ANFOWZtOVJo6OwxD4T19+89lWy4Sa
	1ClJUdhkVppl7ZKiDFKqHTIqz7+PFO4Z0ndM1y0Hmg8VwSBa1ZfFstu+lJMISPER
	AN+Em2nqYafjJ431NOWPtiyLffvFAp/BrNx+VaJicE5j6Aq/RNkxr13aB+uELTZg
	anSxLybAHgGeK0QUT1ckWdxDXB4+HkEkkPk/9tTT+N+MQERnvQ7VN4eTj+l5odmC
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4645p7q8s7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 07:35:28 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53MBZR24050191
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 22 Apr 2025 07:35:27 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 22 Apr
 2025 07:35:27 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 22 Apr 2025 07:35:27 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.55])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53MBZ4Qr024350;
	Tue, 22 Apr 2025 07:35:18 -0400
From: Jorge Marques <jorge.marques@analog.com>
Date: Tue, 22 Apr 2025 13:34:49 +0200
Subject: [PATCH v2 4/5] docs: iio: new docs for ad4052 driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250422-iio-driver-ad4052-v2-4-638af47e9eb3@analog.com>
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
        Andy
 Shevchenko <andy@kernel.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, Jorge Marques <jorge.marques@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745321704; l=4091;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=QtEocJy/CJth/1vVDY0oG1mV878r2tNjKt4aQLtRDb4=;
 b=edCYEFEQRHzRG8szj7sKRBqMYYjAWY6eZHgvizquSjlrdVZFBbgBtLzEYWM1HUCEtL7Sjyb8e
 MeD8GkZvy3rA0dhYoh0hGomA25MthK5Dg26t3fvh19qGV+gj0gooBIb
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=D4VHKuRj c=1 sm=1 tr=0 ts=68077f00 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=wI1k2SEZAAAA:8 a=qLcM2r4-lCJhFG8HUqIA:9 a=QEXdDO2ut3YA:10
 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-GUID: sTDtT0KOgEK6r3YGHrK0QDGQU6FcCT_m
X-Proofpoint-ORIG-GUID: sTDtT0KOgEK6r3YGHrK0QDGQU6FcCT_m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_05,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220087

This adds a new page to document how to use the ad4052 ADC driver.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 Documentation/iio/ad4052.rst | 95 ++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                  |  1 +
 2 files changed, 96 insertions(+)

diff --git a/Documentation/iio/ad4052.rst b/Documentation/iio/ad4052.rst
new file mode 100644
index 0000000000000000000000000000000000000000..410aaa437ed5fea6a2924d374fa5f816f5754e22
--- /dev/null
+++ b/Documentation/iio/ad4052.rst
@@ -0,0 +1,95 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+=============
+AD4052 driver
+=============
+
+ADC driver for Analog Devices Inc. AD4052 and similar devices.
+The module name is ``ad4052``.
+
+Supported devices
+=================
+
+The following chips are supported by this driver:
+
+* `AD4050 <https://www.analog.com/AD4050>`_
+* `AD4052 <https://www.analog.com/AD4052>`_
+* `AD4056 <https://www.analog.com/AD4056>`_
+* `AD4058 <https://www.analog.com/AD4058>`_
+
+Wiring modes
+============
+
+The ADC uses SPI 4-wire mode, and contain two programmable GPIOs and
+a CNV pin.
+
+The CNV pin is exposed as the ``cnv-gpios`` and triggers a ADC conversion.
+GP1 is ADC conversion ready signal and GP0 Threshold event interrupt, both
+exposed as interrupts.
+
+Omit ``cnv-gpios`` and tie CNV and CS together to use the rising edge
+of the CS as the CNV signal.
+
+Device attributes
+=================
+
+The ADC contain only one channels, and the following attributes:
+
+.. list-table:: Driver attributes
+   :header-rows: 1
+
+   * - Attribute
+     - Description
+   * - ``in_voltage0_raw``
+     - Raw ADC voltage value
+   * - ``in_voltage0_oversampling_ratio``
+     - Enable the device's burst averaging mode to over sample using
+       the internal sample rate.
+   * - ``in_voltage0_oversampling_ratio_available``
+     - List of available oversampling values. Value 0 disable the burst
+       averaging mode.
+   * - ``conversion_frequency``
+     - Device internal sample rate used in the burst averaging mode.
+   * - ``conversion_frequency_available``
+     - List of available sample rates.
+
+Threshold events
+================
+
+The ADC supports a monitoring mode to raise threshold events.
+The driver supports a single interrupt for both rising and falling
+readings.
+
+The feature is enabled/disabled by setting ``thresh_either_en``.
+During monitor mode, the device continuously operates in autonomous mode until
+put back in configuration mode, due to this, the device returns busy until the
+feature is disabled.
+
+Low-power mode
+==============
+
+The device enters low-power mode on idle to save power.
+Enabling an event puts the device out of the low-power since the ADC
+autonomously samples to assert the event condition.
+
+SPI offload support
+===================
+
+To be able to achieve the maximum sample rate, the driver can be used with the
+`AXI SPI Engine`_ to provide SPI offload support.
+
+.. _AXI SPI Engine: http://analogdevicesinc.github.io/hdl/projects/ad4052_ardz/index.html
+
+When SPI offload is being used, additional attributes are present:
+
+.. list-table:: Additional attributes
+   :header-rows: 1
+
+   * - Attribute
+     - Description
+   * - ``in_voltage0_sampling_frequency``
+     - Set the sampling frequency.
+   * - ``in_voltage0_sampling_frequency_available``
+     - Get the sampling frequency range.
+
+The scan type is different when the buffer with offload support is enabled.
diff --git a/MAINTAINERS b/MAINTAINERS
index 81fbe7176475c48eae03ab04115d4ef5b6299fac..04aa8db44bee418382a2e74cb6b1d03a810bd781 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1334,6 +1334,7 @@ M:	Jorge Marques <jorge.marques@analog.com>
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml
+F:	Documentation/iio/ad4052.rst
 
 ANALOG DEVICES INC AD4130 DRIVER
 M:	Cosmin Tanislav <cosmin.tanislav@analog.com>

-- 
2.49.0


