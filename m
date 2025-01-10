Return-Path: <linux-pwm+bounces-4576-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1061A08BF9
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jan 2025 10:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95FF83AAA7B
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jan 2025 09:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD8F20FAB3;
	Fri, 10 Jan 2025 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="LoygjO/4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5566320E6E0;
	Fri, 10 Jan 2025 09:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500944; cv=none; b=XbcLZsknIw61SkFlpNbR1CD2w1x2kA0PdEzg9/j4bFPEwITVjGiItD6wP8u27iWOEFxgNI0a5NBVLMoiWQKqPSoKKOWMJom28bG7kAz9fCGjV99v/9hyTNxFjDfJIeEeIiV37NzrfCqSRZr8IrXVh2nDOS+KDhvW1uK9G8sJLhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500944; c=relaxed/simple;
	bh=fx4PfkUpPvqRRQU4K7YqmcOhuSi/rAkNRt4a3ovcj6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IttUv4uzMJCuy8iTTXxE6kO+4BFNDr2s7n3eZ4WELe1oqixyN9tMPfNeImdFAB4YnGtJQO/Y3GXQq2aIYi0tHt1hNqCflkyTyDqkLz+E/1b8r3vMs2xI5ODWW+A/6hunPM6KKuJMv1W7BQSRrKJLFgK+y/JyosbJbQb2sk/d+MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=LoygjO/4; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A7e8A5025749;
	Fri, 10 Jan 2025 10:22:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	yo5Xx8h3uCqqmk4Dv0r1R0rtmXCq2HKncRpeohdg7BQ=; b=LoygjO/45V6Walxy
	E5dE23zxyL+/awaQXUeyY3omwKiFjYPxeyQypajXO1QOydEUpqltWa/jhQzRZmv5
	Zz6Mt8FY25Hz33qXOK4dtE3IoJye2UKrVFM6QyfmydPy7OjjBfxjYHZ0WENh9F0S
	JeelT9tefwYQrSE26osjKH9OFo+R+dOO+YdfH8DPiQvVAK+W/msXk5lsjlfQ5BGf
	XmeH2BSF7rtiI/oEz4qr91msgu+MAz6ff/CZIhK+YdS8HPL1KKdIPwFkwis8OHPB
	5JSl1f406aMVZItY6l7vjT+fr/JC70/jZSfHUGCYUIlE7uf59J2lWa9pHEsScZ/P
	tD+nzg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 442mw0j93y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 10:22:13 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E6B5F4005F;
	Fri, 10 Jan 2025 10:21:05 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 349B028A866;
	Fri, 10 Jan 2025 10:20:06 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 10 Jan
 2025 10:20:06 +0100
Received: from localhost (10.252.28.64) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 10 Jan
 2025 10:20:05 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <lee@kernel.org>, <ukleinek@kernel.org>, <alexandre.torgue@foss.st.com>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <wbg@kernel.org>, <jic23@kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>, <fabrice.gasnier@foss.st.com>
Subject: [PATCH v3 8/8] arm64: dts: st: add timer nodes on stm32mp257f-ev1
Date: Fri, 10 Jan 2025 10:19:22 +0100
Message-ID: <20250110091922.980627-9-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250110091922.980627-1-fabrice.gasnier@foss.st.com>
References: <20250110091922.980627-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Configure timer nodes on stm32mp257f-ev1:
- Timer3 CH2 is available on mikroBUS connector for PWM
- timer8 CH1, timer8 CH4, timer10 CH1 and timer12 CH2 are available
  on EXPANSION connector.
Timers are kept disabled by default, so the pins can be used for any
other purpose (and the timers can be assigned to any of the processors).
Arbitrary choice is to use all these timers as PWM (or counter on
internal clock signal), except for timer10 that is configured with
CH1 as an input (for capture).

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 6f393b082789..6601ca411006 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -156,6 +156,64 @@ &spi8 {
 	status = "disabled";
 };
 
+&timers3 {
+	status = "disabled";
+	counter {
+		status = "okay";
+	};
+	pwm {
+		pinctrl-0 = <&pwm3_pins_a>;
+		pinctrl-1 = <&pwm3_sleep_pins_a>;
+		pinctrl-names = "default", "sleep";
+		status = "okay";
+	};
+	timer@2 {
+		status = "okay";
+	};
+};
+
+&timers8 {
+	status = "disabled";
+	counter {
+		status = "okay";
+	};
+	pwm {
+		pinctrl-0 = <&pwm8_pins_a>;
+		pinctrl-1 = <&pwm8_sleep_pins_a>;
+		pinctrl-names = "default", "sleep";
+		status = "okay";
+	};
+	timer@7 {
+		status = "okay";
+	};
+};
+
+&timers10 {
+	status = "disabled";
+	counter {
+		pinctrl-0 = <&tim10_counter_pins_a>;
+		pinctrl-1 = <&tim10_counter_sleep_pins_a>;
+		pinctrl-names = "default", "sleep";
+		status = "okay";
+	};
+};
+
+&timers12 {
+	status = "disabled";
+	counter {
+		status = "okay";
+	};
+	pwm {
+		pinctrl-0 = <&pwm12_pins_a>;
+		pinctrl-1 = <&pwm12_sleep_pins_a>;
+		pinctrl-names = "default", "sleep";
+		status = "okay";
+	};
+	timer@11 {
+		status = "okay";
+	};
+};
+
 &usart2 {
 	pinctrl-names = "default", "idle", "sleep";
 	pinctrl-0 = <&usart2_pins_a>;
-- 
2.25.1


