Return-Path: <linux-pwm+bounces-5652-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A30BA967A9
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 13:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C47C67A4887
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 11:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDED227D763;
	Tue, 22 Apr 2025 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0ju5hbwM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333A127CB04;
	Tue, 22 Apr 2025 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745321739; cv=none; b=gBpBiCg7a8aLCTE+2B9w78Ynj/teguh8CM+3xZMVNT//uobRwCYQiOXLnP0wE1UmyiFvwl0P5jRV5dQiN4kFRbsr6CEcsGI0oKV4hQlYT9QGwAZDCbC21qDZ+ayAa45ZoAT+txGudi3B3Rldh9xCjGLScs82GP0Ywf9w30IJDPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745321739; c=relaxed/simple;
	bh=G8sSQ9oAgloExPnknPGbWGqIy8M8oFar3xVuD94bKRY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=RXOVYIe233JCgxAOCLQSAd9gCY68dWbU/FxOyrfOqqoO8sdW8ChR8VW2EryPZCxfPP8ABpRd6QMhIgNB3ppSOIrAmmbBs/Y2JXpR4gF1gUzD8HHP4Kh2J077CnaO1IoLdOEy20qdXVxzDyvQnYmgivviHRnF9U8GPKLY0fiABRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0ju5hbwM; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MBLYAk028756;
	Tue, 22 Apr 2025 07:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=8ngmqNaf0duiny1aZAS8S/xUKjw
	+TPotW+kUL0uNCHk=; b=0ju5hbwM88b34gmyt0qDjZf0PmZLaF4XRfae2v0pVAv
	Mv7oBlcUhD4TJMFrkixLffZrP+pDkdguDPN9xf5+UIbe4aAtYqbCexxJnA/2xjiI
	NTPaH4Scbe0BE7eYRBGcWjIhivHUcISZJ8H//uHJ5kKBjeBmKAc44JADuFdiVjfU
	zb+33AkBar5NZI/rJ/DmJnV5Dei5MlwR0MiBOgrfcIHU40pdaN6mI33gzGBUMqiZ
	7MSHRr7pK4CYc7yzVGCTzXMPiLj0rBCjPGec5a0kck6Meoy5h0bg3F4Z0cUyoxRN
	JIRAs4gYsD52VyZAzx1Ac5n9LCDRcA7JYXXDhuGsa0A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 464t5gm6nh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 07:35:20 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 53MBZJhU057904
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 22 Apr 2025 07:35:19 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 22 Apr
 2025 07:35:19 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 22 Apr 2025 07:35:19 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.55])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53MBZ4Qn024350;
	Tue, 22 Apr 2025 07:35:06 -0400
From: Jorge Marques <jorge.marques@analog.com>
Subject: [PATCH v2 0/5] Add support for AD4052 device family
Date: Tue, 22 Apr 2025 13:34:45 +0200
Message-ID: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANV+B2gC/32NTQrCMBBGr1Jm7Ugmabtw5T2ki8mP7YA2kpSgl
 Nzd2AO4fA++9+2QQ5KQ4dLtkEKRLHFtoE8duIXXOaD4xqCVHpRRI4pE9ElKSMi+V4NG7tk5Yy2
 RNdB2rxTu8j6at6nxInmL6XNcFPrZf7VCqFBb9uyNIhrdlVd+xPns4hOmWusX6k2oZLMAAAA=
X-Change-ID: 20250306-iio-driver-ad4052-a4acc3bb11b3
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745321704; l=5234;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=G8sSQ9oAgloExPnknPGbWGqIy8M8oFar3xVuD94bKRY=;
 b=JV+PT3g1gWdNFdIW5K7X5H9NLmALrVSsHo77PYv3beGsmEfagxEsVJy8ndGH/PKMc2yf1m66e
 UvTfNCjGU3MC5FFKcDmeBtBvCmVNS6kZsL3lYu4ypB+pDxEOJohKbdX
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=RaiQC0tv c=1 sm=1 tr=0 ts=68077ef8 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=wI1k2SEZAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=r35hEovfIMHMg4DKX5UA:9
 a=QEXdDO2ut3YA:10 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-GUID: elOUQXYvSUNxbIbUZV_UB3CoWwfTT4c4
X-Proofpoint-ORIG-GUID: elOUQXYvSUNxbIbUZV_UB3CoWwfTT4c4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_05,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1011
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220087

The AD4052/AD4058/AD4050/AD4056 are versatile, 16-bit/12-bit,
successive approximation register (SAR) analog-to-digital converter (ADC).

The series starts with marking iio_dev as const in iio_buffer_enabled,
to not discard the qualifier when calling from get_current_can_type.
This is required since the size of storage bytes varies if the offload
buffer is used or not.

The scan_type also depends if the oversampling feature is enabled, since
the 16-bit device increases the SPI word size from 16-bit to 24-bit.
Also due to this, the spi message optimization is balanced on the buffer ops,
instead of once per probe.
SPI messages related to exiting the ADC mode, and reading raw values are
never optimized.

The device has autonomous monitoring capabilities, that are exposed as IIO
events. Since register access requires leaving the monitoring
state and returning, device access is blocked until the IIO event is disabled.
An auxiliary method ad4052_iio_device_claim_direct manages the IIO claim
direct as well as the required wait_event boolean.
The device has an internal sampling rate for the autonomous modes,
exposed as the sample_rate attribute.

The device contains two required outputs:

* gp0: Threshold event interrupt on the rising edge.
* gp1: ADC conversion ready signal on the falling edge.
       The user should either invert the signal or set the IRQ as falling edge.

And one optional input:

* cnv: Triggers a conversion, can be replaced by shortening the CNV and
  SPI CS trace.

The devices utilizes PM to enter the low power mode.

The driver can be used with SPI controllers with and without offload support.

A FPGA design is available:
https://analogdevicesinc.github.io/hdl/projects/ad4052_ardz/

The devices datasheet:
https://www.analog.com/media/en/technical-documentation/data-sheets/ad4050-ad4056.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/ad4052-ad4058.pdf

The unique monitoring capabilities and multiple GPIOs where the decision factor
to have a standalone driver for this device family.

Non-implemented features:

* Status word: First byte of the SPI transfer aligned to the register
  address.
* Averaging mode: Similar to burst averaging mode used in the
  oversampling, but requiring a sequence of CNV triggers for each
  conversion.
* Monitor mode: Similar to trigger mode used in the monitoring mode, but
  doesn't exit to configuration mode on event, being awkward to expose
  to user space.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
Changes in v2:
dt-bindings:
- commit message: describe io, how each device differ, remove driver
  specifics.
- add interrupt names, format descriptions
- fix datasheet link
- add vdd/vio supply

documentation (new to series):
- add oversampling_frequency in sysfs-bus-iio

documentation/ad4052:
- rename sample_rate to conversion_frequency
- extend threshold event description

ad4052:
- use oversampling_frequency in burst_averaging_mode
- name the defines with register and label names, not only label
- remove defines that are used once, or may hard to understand, instead, have logic where they are used.
- due to the topology:
  - set spi_offload_trigger_config.type from PERIODIC to DATA_READY
  - handle the pwm_device on the driver.
- add oversampling_frequency and events_frequency to store distinct conversion_frequency
  and to write accordingly when entering monitor_mode or burst_averaging_mode 
- set sampling frequency as the pwm_device frequency
- update production IDs values with the ones from the released parts
- use production IDs to obtain device grade.
- set chip info static
- remove ad4052_iio_device_claim_direct, and solve unbalances
- add missing rd_table, wr_table to regmap_config
- replace PTR_ERR_OR_ZERO with if IS_ERR return PTR_ERR
- rename ad4052_set_non_defaults with a ad4052_setup (more usual naming convention)
- reorder pm_runtime autosuspend to after enabling the pm

- Link to v1: https://lore.kernel.org/r/20250306-iio-driver-ad4052-v1-0-2badad30116c@analog.com

---
Jorge Marques (5):
      Documentation: ABI: add oversampling frequency in sysfs-bus-iio
      iio: code: mark iio_dev as const in iio_buffer_enabled
      dt-bindings: iio: adc: Add adi,ad4052
      docs: iio: new docs for ad4052 driver
      iio: adc: add support for ad4052

 Documentation/ABI/testing/sysfs-bus-iio            |   17 +
 .../devicetree/bindings/iio/adc/adi,ad4052.yaml    |   98 ++
 Documentation/iio/ad4052.rst                       |   95 ++
 MAINTAINERS                                        |    8 +
 drivers/iio/adc/Kconfig                            |   14 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad4052.c                           | 1425 ++++++++++++++++++++
 drivers/iio/industrialio-core.c                    |    2 +-
 include/linux/iio/iio.h                            |    2 +-
 9 files changed, 1660 insertions(+), 2 deletions(-)
---
base-commit: 905d6b57b18fa932b3f05578e82625d22a4dd17f
change-id: 20250306-iio-driver-ad4052-a4acc3bb11b3

Best regards,
-- 
Jorge Marques <jorge.marques@analog.com>


