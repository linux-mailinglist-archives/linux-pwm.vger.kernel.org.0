Return-Path: <linux-pwm+bounces-6266-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5FBAD2ECF
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 09:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0729A3AECFA
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 07:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF0B27FD64;
	Tue, 10 Jun 2025 07:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Y3s0gkXc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF1027F72E;
	Tue, 10 Jun 2025 07:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749540930; cv=none; b=ZTCgyzyRQDyvLMixAcXlU+3KY5Jt1TcjxlXG3zgt6ytxK/nRboWHzyE7m+f19VRjA9YlEiVSqdc0u2BQxT8YJ3siiIa0oJMAd+VScpNuOlI/MHPCaLEmnt17N5xwNduKpNyt5w1I8BSoiV/SbrYUYv2ZUsdzZ7S/xAE59qEgN9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749540930; c=relaxed/simple;
	bh=sdFAjldeGCQJJ20ICafL2xOY+VAsXnig4eCBQzH8MzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MAQyS6aSLVmvr+7ICybvzpNDtYzsdfUwgegpL1vFOXT8tScyoQCg602wFapeCqJiF5XAcaImJ1Q9QHdmcwIqfdmaloGMaG+QBp1Rz/ZePaFpS11ebZgzDGnVVlDgmF8sDHTAVCLLU3PKLimoS2a7gUp5AAHN4NSiVpDFBPtHxAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Y3s0gkXc; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A6g8Bp023177;
	Tue, 10 Jun 2025 03:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=d5ryt
	0pI/G+b2LsAq1xg2LHy7S0hE2LV6WmwFRL/qQU=; b=Y3s0gkXcOZsYIfIHascyf
	TZ4RQ09U8fFOvvTtxJ+2SjBiwYOgTe8Ek4r7XiH9dAns0qn+JlOscAQzNDEkSyAg
	1cVA0R75MVRA3bhaPnDFj9bJCOZc8RP/7uEd6a+p/+2ZsZVXg0yMNKom2e7cIzFo
	KEkxshqwiNoLo6CUAPnbhQXuQImtJ0R4hgINzKVD36+37yAlc0ooFrzfzYEXF3hJ
	Ce+BNAjHDkciqWgngOm5aLXrReHpw/BnyixzJdxrq+ZJsuiolalt6PqdsgdR8gxd
	YtNw7jdqVqjww8khFIDErqPAi8HLC8nNJO/WaVYb7+8CofDs0fKKSgVmX+6Kh7gE
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 476fc30bk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 03:35:07 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 55A7Z5sN013927
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Jun 2025 03:35:05 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 10 Jun
 2025 03:35:05 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Jun 2025 03:35:05 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.51])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55A7YkMh002608;
	Tue, 10 Jun 2025 03:34:59 -0400
From: Jorge Marques <jorge.marques@analog.com>
Date: Tue, 10 Jun 2025 09:34:36 +0200
Subject: [PATCH v3 3/8] docs: iio: New docs for ad4052 driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250610-iio-driver-ad4052-v3-3-cf1e44c516d4@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749540886; l=3632;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=sdFAjldeGCQJJ20ICafL2xOY+VAsXnig4eCBQzH8MzQ=;
 b=TwD251L7wL7SF8OIpJ2r64y34FTdwapbKPHi2dCGNrDcghYCYRc/fG0RwaeIkkiT8bgyDWryr
 0N85bXruQTMA8TWp77mZ1z5Z8lu8LFP9SMWNxLs1uxPWTSzFF8l0WTJ
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: j07RvrN39XEziBFan2LZDy1lGuy3Ms2U
X-Proofpoint-ORIG-GUID: j07RvrN39XEziBFan2LZDy1lGuy3Ms2U
X-Authority-Analysis: v=2.4 cv=LtaSymdc c=1 sm=1 tr=0 ts=6847e02b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=qLcM2r4-lCJhFG8HUqIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA1NiBTYWx0ZWRfXzpVQ4queZZZy
 xUGdoSjjhvzWMbfMg34/3+5PNi3TDLkMA3b0cznv/pITyQAuKRPW5iEuD7IsHLMJafUEQ7MVZ5T
 SKUDqNLXc+Ina0xDs0aHW5y+Xce6K4+9gmdQWN55lk3G7sUcfINjPZk90PnXETSU5eL978nNLmE
 JxDBSrXJxndNv6vN3m7OiZ5nX4l6EM2ga+mDb6omfDK1RpLrEYgLku1BYQKTiJp3mzpjc6JZVun
 EKZtDsKImNJZxSTi/FN6Jl/ZAjDZsuCj8O1efZpn9CLLIukBBBc1/oubnJM3HdE8oOIZ7kZkXnw
 xwSsW0iTmjPKwLXbKpPS3rU5aMl+MfZrZew9iR5LVij+C09RRzrcg62PAY78IsF7uf22Q34yR5R
 m2wr/AN3euASO0c3AKfHUIg2XceTJow/YBtC5e0E0o5C5AnSsxou4lnUi+65PU8Bsry020Ou
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_02,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506100056

This adds a new page to document how to use the ad4052 ADC driver.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 Documentation/iio/ad4052.rst | 71 ++++++++++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |  1 +
 MAINTAINERS                  |  1 +
 3 files changed, 73 insertions(+)

diff --git a/Documentation/iio/ad4052.rst b/Documentation/iio/ad4052.rst
new file mode 100644
index 0000000000000000000000000000000000000000..25e55eb72e167bd2b2195ba789b45ce402869b0f
--- /dev/null
+++ b/Documentation/iio/ad4052.rst
@@ -0,0 +1,71 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+=============
+AD4052 driver
+=============
+
+ADC driver for Analog Devices Inc. AD4052 and similar devices. The module name
+is ``ad4052``.
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
+The ADC uses SPI 4-wire mode, and contain two programmable GPIOs and a CNV pin.
+
+The CNV pin is exposed as the ``cnv-gpios`` and triggers an ADC conversion. GP1
+is ADC conversion ready signal and GP0 Threshold event interrupt, both exposed
+as interrupts.
+
+Omit ``cnv-gpios`` and tie CNV and CS together to use the rising edge of the CS
+as the CNV signal.
+
+Device attributes
+=================
+
+The ADC contains only one channel with following attributes:
+
+.. list-table:: Channel attributes
+   :header-rows: 1
+
+   * - Attribute
+     - Description
+   * - ``in_voltage_calibscale``
+     - Scale factor to multiply the raw value.
+   * - ``in_voltage_raw``
+     - Raw ADC voltage value
+   * - ``in_voltage_oversampling_ratio``
+     - Enable the device's burst averaging mode to over sample using the
+       internal sample rate.
+   * - ``in_voltage_oversampling_ratio_available``
+     - List of available oversampling values. Value 1 disable the burst
+       averaging mode.
+
+Also contain the following device attributes:
+
+.. list-table:: Device attributes
+   :header-rows: 1
+
+   * - Attribute
+     - Description
+   * - ``oversamling_frequency``
+     - Frequency used in the burst averaging mode, sets the device internal
+       sample rate when the mode is activated.
+   * - ``oversampling_frequency_available``
+     - List of available sample rates.
+
+Low-power mode
+==============
+
+The device enters low-power mode on idle to save power. Enabling an event puts
+the device out of the low-power since the ADC autonomously samples to assert
+the event condition.
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index 2d6afc5a8ed54a90cd8d5723f0dc5212b8593d16..ef03022b8a6374c14d7b1b2e51e5c487e1d37df9 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -22,6 +22,7 @@ Industrial I/O Kernel Drivers
    ad3552r
    ad4000
    ad4030
+   ad4052
    ad4695
    ad7191
    ad7380
diff --git a/MAINTAINERS b/MAINTAINERS
index d000c7de7ff9eba390f87593bc2b1847f966f48b..32afd568b68e45616c291d689a35ab905d421cd1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1342,6 +1342,7 @@ M:	Jorge Marques <jorge.marques@analog.com>
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml
+F:	Documentation/iio/ad4052.rst
 
 ANALOG DEVICES INC AD4080 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>

-- 
2.49.0


