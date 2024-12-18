Return-Path: <linux-pwm+bounces-4385-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 945999F60C4
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Dec 2024 10:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03413163079
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Dec 2024 09:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80A1195385;
	Wed, 18 Dec 2024 09:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="4FfTT2hY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086BE187862;
	Wed, 18 Dec 2024 09:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734512696; cv=none; b=eOHgbU7LiWwHPh9HU10KNawGwg8RO61sytObvCIkibXYvXr2UQmJi+ib/5RmdA4t4XyN702KU9o5/Nd9arIs8hU3Lk7waVybBtCnJkx2GSET/WwiDVVpSk8GjZKQjHfyqpO3QivxFblso/1zcCEPZcdHSd9qtM+kFU9a8BoAd4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734512696; c=relaxed/simple;
	bh=HuxtwBiliTFACkDAti+9enYfQMXJD4UrA2I7TajWmYA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iRVgcyBH5xGAbo7viFPFSACi0Dh8ZIiFO6uWumJfiasFi2gv0nzfYz3p84jSX3mKyt/IwXLe8rn5mC8+2zTHT4b9/1N6igvbQF6UeytimGQukhcUoQlCOtYILC/iQ3CLXZFoMSg0Wdk8evQOxKlwDWzISbS6zFIwACBlBhrv0XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=4FfTT2hY; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI7Eetl022006;
	Wed, 18 Dec 2024 10:04:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=1oWrWl5HM94IDeHh5v4VY9
	2O0MF3BbHI+a7HB2xR+Cs=; b=4FfTT2hYqblXiq3AnMeik5u524MAdH+EuI2lQI
	N7LHXhuR7+R6MqXLsk8qrY1yv48SuZoAeo+BKA23Yd4ogrvjNuhGisXeoGqRzjRe
	exPABAd2J3gMNf7VlXL1PheZXw6OHzQJPi+qFg0DHz6qnD1HGnqamPr4yl4WpCcv
	wPrCm9q8AQ+3BE58N+GOl8u7JKEwqcDplhBCe81nuLJdT4j/HgzbFoz4sg4xQ+L7
	uqfgJvZ4Ze89mmtCDrpJLBQ0+JQMafx0MsRskTXXmRIox5dkowDVTACdcAEoU8Kv
	4NFummP1BmXoLkYPjcg1rTpUcy5/SyTF3C0fCUV96qxRUIxA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43kfu8a4ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 10:04:44 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DF04B4004D;
	Wed, 18 Dec 2024 10:03:53 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F0B7525EED5;
	Wed, 18 Dec 2024 10:02:54 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 18 Dec
 2024 10:02:54 +0100
Received: from localhost (10.48.86.222) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 18 Dec
 2024 10:02:54 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <alexandre.torgue@foss.st.com>,
        <wbg@kernel.org>, <jic23@kernel.org>, <ukleinek@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>
Subject: [PATCH 0/9] Add STM32MP25 timers support: MFD, PWM, IIO and counter drivers
Date: Wed, 18 Dec 2024 10:01:44 +0100
Message-ID: <20241218090153.742869-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

This series adds STM32MP25 support on MFD PWM, IIO, counter timer drivers.
This new timer variant is managed by using a new DT compatible string.
It comes with a slightly updated register set, some new features and new
interconnect signals inside the SoC. There is also a new instance (TIM20).
Same feature list as on STM32MP1x is supported currently, except for PWM
capture (not enabled, by DT).
The device tree files add all instances in stm32mp251 dtsi. PWM, counter
and trigger examples are provided for stm32mp257f-ev1 board.

Fabrice Gasnier (9):
  dt-bindings: mfd: stm32-timers: add support for stm32mp25
  mfd: stm32-timers: add support for stm32mp25
  iio: trigger: stm32-timer: add support for stm32mp25
  counter: stm32-timer-cnt: add support for stm32mp25
  pwm: stm32: add support for stm32mp25
  arm64: defconfig: enable STM32 timers drivers
  arm64: dts: st: add timer nodes on stm32mp251
  arm64: dts: st: add timer pins for stm32mp257f-ev1
  arm64: dts: st: add timer nodes on stm32mp257f-ev1

 .../bindings/mfd/st,stm32-timers.yaml         |  18 +-
 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi |  61 ++
 arch/arm64/boot/dts/st/stm32mp251.dtsi        | 524 ++++++++++++++++++
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    |  58 ++
 arch/arm64/configs/defconfig                  |   4 +
 drivers/counter/stm32-timer-cnt.c             |   7 +-
 drivers/iio/trigger/stm32-timer-trigger.c     |  21 +-
 drivers/mfd/stm32-timers.c                    |  32 +-
 drivers/pwm/pwm-stm32.c                       |  39 +-
 include/linux/iio/timer/stm32-timer-trigger.h |   6 +
 include/linux/mfd/stm32-timers.h              |   9 +
 11 files changed, 766 insertions(+), 13 deletions(-)

-- 
2.25.1


