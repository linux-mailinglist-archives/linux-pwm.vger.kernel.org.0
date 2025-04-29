Return-Path: <linux-pwm+bounces-5761-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D5BAA0C4C
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Apr 2025 14:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D432C4817DB
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Apr 2025 12:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7722C3756;
	Tue, 29 Apr 2025 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="zhHv2OGm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE402C2ABF;
	Tue, 29 Apr 2025 12:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931294; cv=none; b=YlNaA6B6bGS3HKJ2S8Dd37ZuLgK2UKbZOc3RgCprgxIrNvW0WCTO94zNymUC0Kch4j4iJdPW4MPB21qn+zhE+yl3rNX0AwRIADcP0AWNuB0MpzQm+JUtpLPxgd4dmfZ6Ck6h9fcAclRddHwRQL6g0UgxPy9zcNszSFRWmAIHdHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931294; c=relaxed/simple;
	bh=9sxFsQ8w8gMj+AilVBnCr0ylt/sgAVMT9xuG3Be9C+I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MSqO3NWsvDH8Utt1E5JEh+Fpw4twmpciBPhKtv+yEKsJSn0Xu3y+wU3ihZfbQS6dOhIurD0r+MibV1SkqqWzQ3Kwz2vl2REhesPBXMptnALIFH6mvxV9PpZAQcNMSblLqRyIVxtLveRIxfRPyI2Y8PQp57wC5NoUr0JLd2QTlqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=zhHv2OGm; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TBAfsm010486;
	Tue, 29 Apr 2025 14:54:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=friZdCP02PIxujmS9U1259
	XJwM1z2G20WzU8LNOMS1A=; b=zhHv2OGm/EjXwJeBYv0jDW1FyvHNbBVstYgTMx
	5fSZ5pCIBBRl3Ye7tDX//R+VO/ZfzbhKXDl5QcZ7Zi5fJlPD8AUi36PmJwc3mIXU
	5t/jjUKJHrFCveI0/na/uoBvrBEX40DcNiNVz6GKIIDWPU8ab1fi/bYbouoO3cWb
	kQiQlkT1PlKgNBw7C62PGISpIRE+TXxu/4sVy/n5K9D+8caHl8QC215p6wSAPKSp
	iKPYlAW7+PWd2LfmPJLQyVkUF1EVpY7rtMQ+g5zV3dRxD1kCeQyXg6WbI5cSEEx+
	4uwr4VaHGVX3KYJ1SpBeCkUrZpSJt7MzWp0CrxZ77MNbAtnA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 468pcgb1tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 14:54:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1500A4005D;
	Tue, 29 Apr 2025 14:53:25 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E40B0ABE2D7;
	Tue, 29 Apr 2025 14:51:45 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Apr
 2025 14:51:45 +0200
Received: from localhost (10.252.5.160) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Apr
 2025 14:51:45 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <daniel.lezcano@linaro.org>, <lee@kernel.org>,
        <alexandre.torgue@foss.st.com>, <tglx@linutronix.de>
CC: <ukleinek@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <jic23@kernel.org>, <robh@kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <devicetree@vger.kernel.org>, <wbg@kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>, <fabrice.gasnier@foss.st.com>
Subject: [PATCH v6 0/7] Add STM32MP25 LPTIM support: MFD, PWM, IIO, counter, clocksource
Date: Tue, 29 Apr 2025 14:51:26 +0200
Message-ID: <20250429125133.1574167-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_04,2025-04-24_02,2025-02-21_01

This series adds support for STM32MP25 to MFD PWM, IIO, counter and
clocksource low-power timer (LPTIM) drivers.
This new variant is managed by using a new DT compatible string, hardware
configuration and version registers.
It comes with a slightly updated register set, some new features and new
interconnect signals inside the SoC.
Same feature list as on STM32MP1x is supported currently.
The device tree files add all instances in stm32mp251 dtsi file.

Changes in V6
---
- Fixed kernel test robot warning
  https://lore.kernel.org/oe-kbuild-all/202504261456.aCATBoYN-lkp@intel.com/

Changes in V5
---
- Add a necessary delay in clocksource driver, when enabling the timer.
- Add collected Acks
- Dropped IIO trigger patch as applied by Jonathan [1] (no dependency)
  [1] https://lore.kernel.org/all/20250331110435.26157ebe@jic23-huawei/

Changes in V4
---
- Simplify IIO trigger driver as per Jonathan's comments.
- Rework clocksource driver: encapsulate mp25 changes in separate function
  after Daniel's suggestion.
- Add some definitions to MFD header.

Changes in V3
---
- Yaml indentation issue fixed, reported by Rob's bot

Changes in V2
---
- Review comments from Krzysztof
  - Adopt compatible fallback in dt-bindings and driver
  - drivers: drop "st,stm32mp25-..." compatibles when unused (e.g. no .data)
  - counter driver: no update (patch dropped)
  - defconfig: only enable the necessary config for upstream board
  - add lptimer DT node in stm32mp257f-ev1 board
- Add missing management of IER access for stm32mp25

Fabrice Gasnier (7):
  dt-bindings: mfd: stm32-lptimer: add support for stm32mp25
  mfd: stm32-lptimer: add support for stm32mp25
  clocksource: stm32-lptimer: add support for stm32mp25
  pwm: stm32-lp: add support for stm32mp25
  arm64: defconfig: enable STM32 LP timer clockevent driver
  arm64: dts: st: add low-power timer nodes on stm32mp251
  arm64: dts: st: use lptimer3 as tick broadcast source on
    stm32mp257f-ev1

 .../bindings/mfd/st,stm32-lptimer.yaml        |  40 +++-
 arch/arm64/boot/dts/st/stm32mp251.dtsi        | 177 ++++++++++++++
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    |   8 +
 arch/arm64/configs/defconfig                  |   2 +
 drivers/clocksource/timer-stm32-lp.c          |  61 ++++-
 drivers/mfd/stm32-lptimer.c                   |  33 ++-
 drivers/pwm/pwm-stm32-lp.c                    | 219 +++++++++++++++---
 include/linux/mfd/stm32-lptimer.h             |  37 ++-
 8 files changed, 537 insertions(+), 40 deletions(-)

-- 
2.25.1


