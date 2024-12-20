Return-Path: <linux-pwm+bounces-4421-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AF89F8F98
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 11:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C5E1889C06
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 10:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DF31BD9CF;
	Fri, 20 Dec 2024 10:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="rKCbiFb9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2CE1AAA1F;
	Fri, 20 Dec 2024 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734688956; cv=none; b=CSZ0vV6LvI7Fq7NU77VeFr+WnEwX4Y4hEcC5qQWzHxfVabKIWnOuwPhPJi/vTk7j4CdUubZXJ+6K2wS69uWNA427efBAggwAy+EX+x3zWEE8N3loGMk8na2nGmcVU7w5H23H3BPPOIW0gpXfvjgX+5pFBhkmf14u1N6sDEMoIq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734688956; c=relaxed/simple;
	bh=O3TPsDuYVQzy9v4SB94Pl+0hbYroxKTomg3hAw0cwrY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X6RvDSVE6EsRyL+L6UuoKqYK/3hsnr02beo5n+z45X0LW9OB9lpOwdbPeJioc3QMfCG/Ot0U6t2eN57gLinAoKpbk3NBa271WwwXmBULzbRgv4sjesg3d7GtpXPd0KrcScPJD5UqM9ogsGZ0VSHSWFyzACP1CLIp03iq33OcOaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=rKCbiFb9; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK8DsG0025632;
	Fri, 20 Dec 2024 11:02:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=dOw4YdXj9waL07VKIhuDIT
	dlMciXDPom5te6D/MGRbo=; b=rKCbiFb92P1LU4qyekPkq6kjghozmWwcaSzrX0
	0jcrWsF5wYH/UocONfYpPcfHghdAWJzhrfWIttUbvvfVzMf8NefIY8BWM0+lkQoK
	8/xrsP3kKcWqxNEpbTe4etcgxr7zitx3ZIuIEtdaNNmp6wOmivim3S7MfMOylqxE
	k/FnPGlt5HW0EwthYLr5MpPNFIgTop0sCyhYowQ5j+Wdga/vNJoMeWE8zlqNwCa4
	UViIuXKqBqngCV4va/ZCF0C5EumzaLSBadgk2/jyYiKyWMD1v+TErfW6CQHVsdTU
	PQxvykibfpb9vIXMBIE0W+lPbD+qWMjNbeUrXwt+DicbgYWw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43n4vu0jcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 11:02:04 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C130940060;
	Fri, 20 Dec 2024 11:01:10 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1E89925F1EC;
	Fri, 20 Dec 2024 11:00:07 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 20 Dec
 2024 11:00:06 +0100
Received: from localhost (10.48.86.222) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 20 Dec
 2024 11:00:06 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <alexandre.torgue@foss.st.com>,
        <wbg@kernel.org>, <jic23@kernel.org>, <ukleinek@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>
Subject: [PATCH v2 0/9] Add STM32MP25 timers support: MFD, PWM, IIO and counter drivers
Date: Fri, 20 Dec 2024 10:59:18 +0100
Message-ID: <20241220095927.1122782-1-fabrice.gasnier@foss.st.com>
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

Changes in V2
---
- PMW driver updated to address Uwe's review comments
- Collected Acked-by

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
 drivers/pwm/pwm-stm32.c                       |  42 +-
 include/linux/iio/timer/stm32-timer-trigger.h |   6 +
 include/linux/mfd/stm32-timers.h              |   9 +
 11 files changed, 766 insertions(+), 16 deletions(-)

-- 
2.25.1


