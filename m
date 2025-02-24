Return-Path: <linux-pwm+bounces-4969-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327B5A42AE4
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Feb 2025 19:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB36177223
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Feb 2025 18:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55852661BA;
	Mon, 24 Feb 2025 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="hZxP1mkO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21245265CDD;
	Mon, 24 Feb 2025 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420842; cv=none; b=l92Y+TlPVw+iGrnaq5Jyt6bFaLY47Idmj/Xz3nmFcazxXKsFDRruyuCkvtmvESo0bPAx8Pjiqzs3UL25e9G5CJrfazlYDJjPu9wcQM3CFAYQbu/OU9vh5zkiwsPH8JmMYejvD7nVKar/NS3l1RjMg4a9zyoMi7/kKZE05iupptY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420842; c=relaxed/simple;
	bh=ArKolMzeETjUwmKW4te7NXG/s9X7oIkM4cETyiPZUQk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LabYs3x90+pkwT7XiKzb6K4wrMrAKe2tuwx3OSgu09ZXvWm4kGOTTi2sVcNKQAS1sL2EZyyZ5f5s1mKSev6h08srYpZFSPfTHWATmffSQeAfypue8zDxJA1wxG2r9H4fJmm4fKA7JJOS49TBCxhRjsGHTHhFM5hHteEXFLjFgko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=hZxP1mkO; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OEnHnD025112;
	Mon, 24 Feb 2025 19:13:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=caTOVoBOyF0MRwCSZLjQta
	/N2cLC0otSKq3vfvnJa1k=; b=hZxP1mkOfRngm5RL60oLFe+P5QXMX3xTexdEVl
	r2x+eIpTbr7WghKVqnotLaXzBtP6Rwc0rK2iaYAzfTPvP/1N2WjcCvTxOKxYiY7G
	XkHVYMbIj5x8BRGk4Vx3RFTNHG0geClTz3Nwtbt8CWV5BuMxEQN9/Nv8Ae07hbEQ
	bgVCLpfVaZC/MAQT8ofiOJ4hdIY8UdeT9pT8F/uOoYja0yCiSU4rrSZCLleGdNLj
	2RMUTlYrTbogHnZlDnzp6RNWXKFkxIyh8Qf08PY7THwYRdpW7pHUWfMTCCsDMqDu
	ofjozVhCqDtpQYr6YLbNy1l5kzi1u5kq687RXGSbjaH6HSIg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44y6bh0hwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 19:13:50 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8D8B440046;
	Mon, 24 Feb 2025 19:12:25 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C9221544742;
	Mon, 24 Feb 2025 19:02:29 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 19:02:29 +0100
Received: from localhost (10.252.23.75) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 19:02:29 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <lee@kernel.org>, <ukleinek@kernel.org>, <alexandre.torgue@foss.st.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <wbg@kernel.org>, <jic23@kernel.org>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>, <fabrice.gasnier@foss.st.com>
Subject: [PATCH 0/8] Add STM32MP25 LPTIM support: MFD, PWM, IIO, counter, clocksource
Date: Mon, 24 Feb 2025 19:01:42 +0100
Message-ID: <20250224180150.3689638-1-fabrice.gasnier@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_09,2025-02-24_02,2024-11-22_01

This series adds support for STM32MP25 to MFD PWM, IIO, counter and
clocksource low-power timer (LPTIM) drivers.
This new variant is managed by using a new DT compatible string.
It comes with a slightly updated register set, some new features and new
interconnect signals inside the SoC.
Same feature list as on STM32MP1x is supported currently.
The device tree files add all instances in stm32mp251 dtsi file.

Fabrice Gasnier (6):
  dt-bindings: mfd: stm32-lptimer: add support for stm32mp25
  mfd: stm32-lptimer: add support for stm32mp25
  pwm: stm32-lp: add support for stm32mp25
  counter: stm32-lptimer-cnt: add support for stm32mp25
  arm64: defconfig: enable STM32 LP timers drivers
  arm64: dts: st: add low-power timer nodes on stm32mp251

Olivier Moysan (1):
  iio: trigger: stm32-lptimer: add support for stm32mp25

Patrick Delaunay (1):
  clocksource: stm32-lptimer: add stm32mp25 support

 .../bindings/mfd/st,stm32-lptimer.yaml        |  23 +-
 arch/arm64/boot/dts/st/stm32mp251.dtsi        | 177 ++++++++++++++
 arch/arm64/configs/defconfig                  |   5 +
 drivers/clocksource/timer-stm32-lp.c          |   1 +
 drivers/counter/stm32-lptimer-cnt.c           |   1 +
 drivers/iio/trigger/stm32-lptimer-trigger.c   | 109 +++++++--
 drivers/mfd/stm32-lptimer.c                   |  30 ++-
 drivers/pwm/pwm-stm32-lp.c                    | 220 +++++++++++++++---
 include/linux/iio/timer/stm32-lptim-trigger.h |   9 +
 include/linux/mfd/stm32-lptimer.h             |  32 ++-
 10 files changed, 554 insertions(+), 53 deletions(-)

-- 
2.25.1


