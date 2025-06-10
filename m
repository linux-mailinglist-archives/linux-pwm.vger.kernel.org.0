Return-Path: <linux-pwm+bounces-6267-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9871AD2ED3
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 09:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0D13A83C8
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 07:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A9D27FD7A;
	Tue, 10 Jun 2025 07:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DTQV1baG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFE427F751;
	Tue, 10 Jun 2025 07:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749540930; cv=none; b=V2IVPk7A1Wya7SXFKBeUXGvUwICM3paMSL7pbnIL62QPvZdbGE07TSKfCwLEyL5qSNQUz2SrzBAmgPJbkuVMs4El9meUn1nUl/jZd8nrbCZhl7WOlmDewMIhqMPyNNkHrOEVPtpW6uAAFjrF5JF8XHJJwdUn21fH5vNKRPh9q1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749540930; c=relaxed/simple;
	bh=cP3hfxwtijXtGwMjqGSuX37hg+a7cG5R5E+SflTI4fw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=g2pINqF4wo309PSb/WNZ3DlGRFRQJdC+OZzM5kczA+PiEPEziSN1QWDveNZicm3yRqU40Ld9oC6qFXnNFMEFxMaTklez73hENvKeRPePlCMDcg+NG9zk/MVNB1rKTWHUeSkXIeUwPrw1XKlZvRPAx3SASUmPGeDP/2C4zXbNtUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DTQV1baG; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A6so2G027929;
	Tue, 10 Jun 2025 03:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=DfnzPxdHh71dhjxBWCxRbQZcCV1
	GfuMMpInJmYIeMrI=; b=DTQV1baGrccFZeywiRndcxPcHXcdTClHBzayY5I+Wvt
	5r/skm83waH5S1Qg6+v8mYsbDHXzjL0Do83GxdiU2zABoLYKHoBRSQyFSQ2ISlDZ
	klbApTdC4CHjDiJ6wci3qdCLT/1XV5SL8wphnjKzbBC9VnWDPOJYKipOLS4Bi3KA
	xfDkAI9XUVrIx7cNJDkC7y2+O8Eim849TXfILq7zyH2BLpS625mICbNdXJccs0yk
	BmCwsyV1X9NeH6/t1KqG1hsJrk0A5aO2UsFbecFGmvnz5ADvdNoqEIFMIyf3hG1g
	HmYXXDT6nYgdiIwlqRFRGwszjKhAnIg18T5pydKrttA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 475u346cyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 03:35:01 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 55A7Z0tw013921
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Jun 2025 03:35:00 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Jun 2025 03:34:59 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Jun 2025 03:34:59 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Jun 2025 03:34:59 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.51])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55A7YkMe002608;
	Tue, 10 Jun 2025 03:34:49 -0400
From: Jorge Marques <jorge.marques@analog.com>
Subject: [PATCH v3 0/8] Add support for AD4052 device family
Date: Tue, 10 Jun 2025 09:34:33 +0200
Message-ID: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAngR2gC/33NTQrCMBCG4auUrI0kk7b+rLyHuJgk03ZAG0kkK
 KV3N+1GBHH5fjDPTCJRZEriWE0iUubEYSxhNpVwA449SfalBSholFGtZA7SR84UJfpaNSCxRue
 MtVpbI8rdPVLHz9U8X0oPnB4hvtYXWS/rPy1rqSRY9OiN0rp1JxzxGvqtCzexcBk+RA3wi4BCt
 GaPXb2jA1nzRczz/AY/ZZIC9gAAAA==
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
        "Andy
 Shevchenko" <andy@kernel.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, Jorge Marques <jorge.marques@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749540886; l=6205;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=cP3hfxwtijXtGwMjqGSuX37hg+a7cG5R5E+SflTI4fw=;
 b=NaqfU5f1S0sfC+X6q1faqlUCA/yAnqeCi06vvyfiz7pn1R/apS3ifDQKrTwmTS2BVTJCN9ksO
 BvEmcgDtIMsBZLAPJE1nU8HcUbZj1kIiRqH4k4DejzMGEKNip5YMuaN
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=R74DGcRX c=1 sm=1 tr=0 ts=6847e025 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=wI1k2SEZAAAA:8 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=6Uq9xBZ7zCHUD0NN2q8A:9 a=QEXdDO2ut3YA:10
 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-ORIG-GUID: g7mqVC4p8nSTfTE-P2R_J9XQU9eV5gMg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA1NiBTYWx0ZWRfX5V0X4FotGwq0
 cOC2s5QUcUeeoRtsVDkcEpppYj4pzrerIHMrIBh81X37Jd+xzt3BF1FOIdVSGaB8tz2/xvY2Qua
 biGMI5MDJiWLiGIN+06z9RYGzYy7UMqES6nZjmHjuwHzqQtAIjivYcaCNNGPtYEegW/ny7okmjJ
 Q41KNJH6yE4OEed7YNm1D/lyRa57sP16HIxwUPMFOq8zKOWj2DStciLmrLzDiaVJx2Tc+0a+Y1U
 goMVw57BfXHyZJ2RWxFCJbTdKR5XxsLy39lvWOzC+JoXLZF4cWIivUDcPDUIMlbrdrXRgHkfluq
 Qw6xLrzwBeEbEgDUSQaR6z2k310Y+BbEAH9utuMpZt8FxBc9Cg/Kg68v07Bag+R3eg70rcJZ7aR
 i267BPOp1sAdj/GNzuambwy21CzdDI167AWrD1Cj58e5hNnJrmICC5Kie/ZMYW2s+8V3Qnqp
X-Proofpoint-GUID: g7mqVC4p8nSTfTE-P2R_J9XQU9eV5gMg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_02,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100056

The AD4052/AD4058/AD4050/AD4056 are versatile, 16-bit/12-bit,
successive approximation register (SAR) analog-to-digital converter (ADC).

The scan_type depends if the oversampling feature is enabled, since the
16-bit device increases the SPI word size from 16-bit to 24-bit. Also
due to this, the spi message optimization is balanced on the buffer ops,
instead of once per probe.

The device has autonomous monitoring capabilities, that are exposed as
IIO events. Since register access requires leaving the monitoring state
and returning, device access is blocked until the IIO event is disabled.

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
* Trigger mode: Similar to monitor mode used in the monitoring mode, but
  exits to configuration mode on event.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
Changes in v3:
Documentation/ABI/testing/sysfs-bus-iio:
- oversampling_frequency and oversampling_frequency_available: target
  6.17 instead of 6.15

dt-bindings/adi,ad4052.yaml:
- add trigger-sources
- add sample dts with spi engine support

dt-bidings/ad4052.h (new to series):
- add header file with event and gpio values

ad4052.c:
- rework regmap and fields. always prefix field with reg name
  - create custom regmap bus to bound spi speed in configuration mode
- rework scantype:
  - drop offload scantype
  - use realbits to compute spi xfer length
  - set storagebits as 32-bits (fixed SPI Engine offload width)
      - tools use storagebits to compute the number of samples.
- reconsider spi speeds:
  - devicetree node: sets regmap spi speed, used for configuration
    access.
  - vio voltage: sets the adc access speed (higher than configuration
    mode).
- explicitily support only signed, removes conditionals checking if
  signed.
- add calibscale to configure scaling (MON_VAL), value 1 disable
  scaling.
- add get scale
- on sleep mode exit, sleep for 4ms (time required to power-on adc side
  and not trigger NOT_RDY_ERROR)

general:
- Break driver and doc commit into three: base driver, offload support,
  and events support, to be easier to review.
- Drop commit that sets get_current_scan_type as const.

- Link to v2: https://lore.kernel.org/r/20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com

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
Jorge Marques (8):
      Documentation: ABI: add oversampling frequency in sysfs-bus-iio
      dt-bindings: iio: adc: Add adi,ad4052
      docs: iio: New docs for ad4052 driver
      iio: adc: Add support for ad4052
      docs: iio: ad4052: Add offload support documentation
      iio: adc: Add offload support for ad4052
      docs: iio: ad4052: Add event documentation
      iio: adc: Add events support to ad4052

 Documentation/ABI/testing/sysfs-bus-iio            |   17 +
 .../devicetree/bindings/iio/adc/adi,ad4052.yaml    |  167 ++
 Documentation/iio/ad4052.rst                       |  133 ++
 Documentation/iio/index.rst                        |    1 +
 MAINTAINERS                                        |    8 +
 drivers/iio/adc/Kconfig                            |   15 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad4052.c                           | 1692 ++++++++++++++++++++
 include/dt-bindings/iio/adc/adi,ad4052.h           |   17 +
 9 files changed, 2051 insertions(+)
---
base-commit: 8bd4d29e36cd44abe95e1b289994bcda47e011ee
change-id: 20250306-iio-driver-ad4052-a4acc3bb11b3

Best regards,
-- 
Jorge Marques <jorge.marques@analog.com>


