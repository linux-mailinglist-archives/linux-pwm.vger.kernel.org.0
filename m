Return-Path: <linux-pwm+bounces-4577-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C187FA08BFE
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jan 2025 10:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D032D3AB202
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jan 2025 09:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7D6210194;
	Fri, 10 Jan 2025 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="f5AnzzOe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E1E20C471;
	Fri, 10 Jan 2025 09:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500945; cv=none; b=TSOFkcsK9fFqMUZ0tdhfepWocJtW+pXHcDMwclsAI4WrmaE+mv52SD+oP5yT1KEz1iYGHPpHHh+fBcFvO0WI0xfMpKBLbE/yTWeMJH2goAlrlVUEdWa8Qb1FFxUl5t6MAvLYWw4JaVzqwjLWgiBNi0mVHsweBthIfCaraquWo5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500945; c=relaxed/simple;
	bh=i5781SrdTzv0z1hkaCd04HLCgm/icH0mX8fAl8lXIjg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MW2/Ydnhl25ycOa/4oJbRWN63so28sFa2Lbe0ECs8YTMy3jM2O8yCw0XAF+d7b0ju7W2LlQf0ld/H1S3aLAHQ01MRCyCIz1nxr61auBTh+AJpMvTHbxNt67JPizvZ0BlVwXwAdfbY61OBymMtrJS1+860YHCOJorAaTpZBsGLZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=f5AnzzOe; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A8PVML032636;
	Fri, 10 Jan 2025 10:22:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	+82biZaVNxLrPwnRt+Mf4mhE6BomVWsuu3IFQ+UAqLo=; b=f5AnzzOe4IyNtzHx
	J69udNuMaNtfiMfjXlfSi++xVGAoKcpka7r1A9xwmkkbvPELlmEM0k63y8MtAQ0/
	/IdhEziv6Hz2Ma1/u6+eEPz65vGqQCJKUYPXGIYx3JTHHF3oJyqwd1udv6YB6yjC
	3mazc+VQG/Qdk3G/QYQal/ULHc3mzFhD6yV3sMnrDnbpk4VULXucS67yLJ42QT5v
	FhQqEr/s0Wpc7N+SewSNp1GWbbgACY9fdVYs6HpGy1EcWJ/naFvFWl6Bayaa9CJN
	DXw8RB5Ht2h2KmdNAYYiwl1gfdxXfyCQN6qfWmMiORRq8lcZ+kLn+HnB2oocO4d9
	sS2IOQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 442q2dhywa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 10:22:14 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 249774005B;
	Fri, 10 Jan 2025 10:21:06 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6277628A862;
	Fri, 10 Jan 2025 10:20:05 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 10 Jan
 2025 10:20:05 +0100
Received: from localhost (10.252.28.64) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 10 Jan
 2025 10:20:04 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <lee@kernel.org>, <ukleinek@kernel.org>, <alexandre.torgue@foss.st.com>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <wbg@kernel.org>, <jic23@kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>, <fabrice.gasnier@foss.st.com>
Subject: [PATCH v3 7/8] arm64: dts: st: add timer pins for stm32mp257f-ev1
Date: Fri, 10 Jan 2025 10:19:21 +0100
Message-ID: <20250110091922.980627-8-fabrice.gasnier@foss.st.com>
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

Add timer pins available on stm32mp257f-ev1, configured for PWM:
- timer3 CH2 is available on mikroBUS connector
- timer8 CH1, timer8 CH4, timer10 CH1 and timer12 CH2 are available
  on EXPANSION connector
Arbitrary define all these pins to be used as PWM (output) channels,
except for timer10 CH1, to be used as counter input.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi b/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
index 8fdd5f020425..bb9dc82d3dd5 100644
--- a/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
@@ -82,6 +82,53 @@ pins {
 		};
 	};
 
+	pwm3_pins_a: pwm3-0 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 15, AF7)>; /* TIM3_CH2 */
+			bias-pull-down;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	pwm3_sleep_pins_a: pwm3-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 15, ANALOG)>; /* TIM3_CH2 */
+		};
+	};
+
+	pwm8_pins_a: pwm8-0 {
+		pins {
+			pinmux = <STM32_PINMUX('J', 5, AF8)>, /* TIM8_CH1 */
+				 <STM32_PINMUX('J', 4, AF8)>; /* TIM8_CH4 */
+			bias-pull-down;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	pwm8_sleep_pins_a: pwm8-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('J', 5, ANALOG)>, /* TIM8_CH1 */
+				 <STM32_PINMUX('J', 4, ANALOG)>; /* TIM8_CH4 */
+		};
+	};
+
+	pwm12_pins_a: pwm12-0 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 11, AF9)>; /* TIM12_CH2 */
+			bias-pull-down;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	pwm12_sleep_pins_a: pwm12-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 11, ANALOG)>; /* TIM12_CH2 */
+		};
+	};
+
 	sdmmc1_b4_pins_a: sdmmc1-b4-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('E', 4, AF10)>, /* SDMMC1_D0 */
@@ -158,6 +205,20 @@ pins1 {
 		};
 	};
 
+	tim10_counter_pins_a: tim10-counter-0 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 9, AF9)>; /* TIM10_CH1 */
+			bias-disable;
+		};
+	};
+
+	tim10_counter_sleep_pins_a: tim10-counter-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 9, ANALOG)>; /* TIM10_CH1 */
+			bias-disable;
+		};
+	};
+
 	usart2_pins_a: usart2-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('A', 4, AF6)>; /* USART2_TX */
-- 
2.25.1


