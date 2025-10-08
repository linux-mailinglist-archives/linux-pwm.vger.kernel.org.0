Return-Path: <linux-pwm+bounces-7400-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C7FBC5440
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Oct 2025 15:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E01093BA08A
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Oct 2025 13:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48C3287246;
	Wed,  8 Oct 2025 13:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FumtB8YB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432AF82866;
	Wed,  8 Oct 2025 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931397; cv=none; b=LfpqZ/7hHmEvc/vdDBMvNERxsPyEAA+f23zoA3XANsOrMWFsIRvVpmGMV2xYA2wptPFxXETLG9GyB8R0tegtFAn1dJKQcj3XZhMyjm/VlLub7+MGw1xW7cvnE8V65wbRfFw4UltzDPI+PGka4nCAC5FAUFzm3rhDFYVk9zBOAKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931397; c=relaxed/simple;
	bh=7rSRe61Wa0T9YOEvz3vnpEQTBXKJjVpcBFVpx4GhmGw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IpP1TThc0Z0Z6Yi+Vh2PaAwz0xsSZY2BikRucZg3tgcqNcEbWeTTHintZy17xOVxzunr9+v456K0Ksn4y1P5iKjGUYmmf3/1sGag9cfyt+iByZwgcaV3qKpVavZETDm6c99fashNobGnLZ1nzpF2R8JfoZhhUkTOgZBc1V8CmAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FumtB8YB; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598Brr9V001000;
	Wed, 8 Oct 2025 09:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=fBzwTjMljqQMEzjKGuFbR3I5Bkw
	pXZgmBh2JeayMB/c=; b=FumtB8YBJG2T3lxlXgUJzDTPeYbwJw8ogVLsQshBgQr
	a1JhVZWb0cysLwMDuw6US03npgyoM6jLeA8Pd77KwMyRAM7+h8Bf8VzsgLPHm1S4
	wQIXrquwexnM8Z9ielz6jqsFADN/F4feQfKSBAzRkkb+2vB6X27mQo7PNlsu0baN
	t9OTne5xi5FnXoga5TVsdSSCrl5ScApMPw4xRKyWAOBBxUScANc16BiT+RWh6h2F
	v8cfghDxjqoHG6J8msHikh0xOfhTgIWcXYCNnwTGuCLQXHEH1n+onlB54GpdS0mp
	dvEE4aINBSCQK2DKsy4rRbc9IhNRRmISVOUEeCbE69Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 49nkc6sr56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 09:49:45 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 598DniHh034428
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 8 Oct 2025 09:49:44 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 8 Oct 2025 09:49:44 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 8 Oct 2025 09:49:44 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 8 Oct 2025 09:49:44 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 598DnOlh023094;
	Wed, 8 Oct 2025 09:49:26 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <ukleinek@kernel.org>, <michael.hennerich@analog.com>,
        <nuno.sa@analog.com>, <eblanc@baylibre.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 0/8] Add SPI offload support to AD4030
Date: Wed, 8 Oct 2025 10:49:23 -0300
Message-ID: <cover.1759929814.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: MEiCC6AdgHinUQyrmFBmuO4VryC1m-LO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDA0NyBTYWx0ZWRfXxWifh1cBkCkL
 ZfORDTIxSryw9LGlXC5ov88SS4LN9dZGoyS6FYVJoZd0WCtNthZ1PR2Sn6suVLLOnwDyJOyPOXA
 4gBeaZcOvD0FMAE1mHZ54TqLRJK6T5xov719IP5iOCOpBFMsM5vcpAID9lCNfyB6NYAemR9OOLb
 TGPjqTErRBwUmqZuS4HY7hSitjrdIJkuk1WECuKbWyhVz7rCOJv5+OzNw4YjDvnxBJajpQFlYHH
 qnPS/zo4BLahGqY2FOY327LRhsZzZh2uvHhxQu0uRSDNCW/oWCcP+04GSt+o/dUq4dTs/m8X7kT
 SVkfyZfZl/jIIEnOqZiqmG7tXmRxMQaQ6WGUQVBgdSQCmI+mAOpHuOrsKWI+hW8qXutgQsqUp0A
 d+tOeqaVFOl+miFKaE28HHHrwWcB1Q==
X-Proofpoint-ORIG-GUID: MEiCC6AdgHinUQyrmFBmuO4VryC1m-LO
X-Authority-Analysis: v=2.4 cv=CMInnBrD c=1 sm=1 tr=0 ts=68e66bf9 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8
 a=1NR5gd90Ntnl4w2qU1EA:9 a=cPQSjfK2_nFv0Q5t_7PE:22 a=HhbK4dLum7pmb74im6QT:22
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510080047

Hi,

Thanks for all reviews and suggestions to v3.

Main change in v4 is that ADAQ devices (those with PGA pins) are now only
supported with PGA pins connected to GPIOs. The pin strapped support code was
removed. Pin strapped/hardwired connections to PGA pins may benefit from a
"fixed-gpios" driver which may (or may not?) use the shared GPIO abstraction
layer [1]. I may propose support for pin-strapped/hardwired connections when I
get a working fixed-gpios implementation.

[1]: https://lore.kernel.org/linux-gpio/CAMRc=Mdb_cUG+hKq8GyfUP1SYBh0p19J+4dFG7G3JSuZTr4n8Q@mail.gmail.com/T/#t

Change log v3 -> v4
[PWM]
- Fixed build failure due to the lack of pwm_round_waveform_might_sleep().
[DT]
- Now only documenting GPIO setup to control ADAQ PGA pins.
[IIO]
- Dropped "Reduce register access transfer speed" patch.
- Applied code adjustments suggested to SPI offload patch.
- Only select SPI_OFFLOAD_TRIGGER_PWM if (SPI_OFFLOAD && PWM).
- ADAQ support patch updated to handle the GPIO setup case only.

Note there is also a patch to the SPI subsystem [2] that contains a feature
required by AD4030 offload support.

[2]: https://lore.kernel.org/linux-spi/cd315e95c0bd8523f00e91c400abcd6a418e5924.1759760519.git.marcelo.schmitt@analog.com/

Thanks,
Marcelo


Marcelo Schmitt (8):
  pwm: Declare waveform stubs for when PWM is not reachable
  dt-bindings: iio: adc: adi,ad4030: Reference spi-peripheral-props
  Docs: iio: ad4030: Add double PWM SPI offload doc
  dt-bindings: iio: adc: adi,ad4030: Add PWM
  iio: adc: ad4030: Use BIT macro to improve code readability
  iio: adc: ad4030: Add SPI offload support
  dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216 and ADAQ4224
  iio: adc: ad4030: Add support for ADAQ4216 and ADAQ4224

 .../bindings/iio/adc/adi,ad4030.yaml          |  77 +-
 Documentation/iio/ad4030.rst                  |  39 +
 drivers/iio/adc/Kconfig                       |   3 +
 drivers/iio/adc/ad4030.c                      | 717 ++++++++++++++++--
 include/linux/pwm.h                           |  19 +
 5 files changed, 804 insertions(+), 51 deletions(-)


base-commit: a9682f53c2d1678b93a123cdaa260e955430bc5c
-- 
2.39.2


