Return-Path: <linux-pwm+bounces-4423-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6269D9F8F9D
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 11:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD0116A968
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 10:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD271BEF97;
	Fri, 20 Dec 2024 10:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="yjOoLFPy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1F229A1;
	Fri, 20 Dec 2024 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734688956; cv=none; b=RdsDgkU4mFcno+zpLlj5FScLhzlX950fPunbNILXTyu10icKNGJeCaD0qO8PN51WemOE1jAD+6OboFIadE3/wNcl24laTBStsg70XQSZnrF4on8MPACslv+NCDJeXVz4E9n2EpfpCHl3x/q+NaLpwH3HGDMA2ZqwbHbEXj2w8ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734688956; c=relaxed/simple;
	bh=oZ/DcDAFhRbo1xnLfgBy5L3HAY5qlB5QQlLsjp5Q6hU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jW6CaVC/Q4+RLRN9Jtkfd0ZHllYw3BXH/m218QQdO+omNtnbWCNS32xUVrBrnFsWVKhzUfkzwHDFpnCdT3R5baniFvYcqtOUvBoI2y0fOnfwgt4klWZB5fsaftz4myGAVNo3+myy48F0oqGXuixNAQZfjIP+peuupl5YFOLKPcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=yjOoLFPy; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK89Ckx013359;
	Fri, 20 Dec 2024 11:02:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	RAT2h6WzrOZMzEhukTS7X5Mg1zcABGayhHzVGz0aqKM=; b=yjOoLFPyG4vrIF3a
	uABz+3W01cWmGeLbRzdoX6FrjjPiNy0G/0TQ/SJJdgmcTHQNHV8L5Etc97KuFlUo
	Yd+U7fjoBLngy971I07ysATlghw+O1Sd8d3tcKuWGOJ8mVCBLFzGkmfKyEvFBjf3
	wKkJwjDg9UUROpJwaumB5Emv4364ytSC9OBhygtKhyhBywLANc3Lekjkcg+uD+Ny
	FKvfXIQu6DPxrZeTMbjRUvYaRsHuVtRKe1LeB3uiawXQkFTT7InhR+k+ZfElbKoS
	B/nCijRXkFr+8ksAhdHEv92Nlzbp1Nad5mec7IlvxG3V6AG+QB8vjHD2QJRSMMKy
	84VYzA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43n34bryww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 11:02:04 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 491754005E;
	Fri, 20 Dec 2024 11:01:09 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D9CD725F1F4;
	Fri, 20 Dec 2024 11:00:07 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 20 Dec
 2024 11:00:07 +0100
Received: from localhost (10.48.86.222) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 20 Dec
 2024 11:00:07 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <alexandre.torgue@foss.st.com>,
        <wbg@kernel.org>, <jic23@kernel.org>, <ukleinek@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>
Subject: [PATCH v2 1/9] dt-bindings: mfd: stm32-timers: add support for stm32mp25
Date: Fri, 20 Dec 2024 10:59:19 +0100
Message-ID: <20241220095927.1122782-2-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241220095927.1122782-1-fabrice.gasnier@foss.st.com>
References: <20241220095927.1122782-1-fabrice.gasnier@foss.st.com>
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

Add a new stm32mp25 compatible to stm32-timer dt-bindings in order to
support the STM32MP25 SoC. Some features has been added or updated in
the stm32-timer timer such as:
- hardware configuration and identification registers to read the timer
  version and capabilities (counter width, number of channels...)
- dithering mode (can be used to extend PWM resolution)
- input triggers list
- new counter modes
- various bit-field updates
- power-domains property
Timer trigger identifier can be up to 19 (from timer 20)

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 .../bindings/mfd/st,stm32-timers.yaml          | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml b/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
index b0e438ff4950..66aa1550a4e5 100644
--- a/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
+++ b/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
@@ -21,7 +21,9 @@ maintainers:
 
 properties:
   compatible:
-    const: st,stm32-timers
+    enum:
+      - st,stm32-timers
+      - st,stm32mp25-timers
 
   reg:
     maxItems: 1
@@ -36,6 +38,9 @@ properties:
   resets:
     maxItems: 1
 
+  power-domains:
+    maxItems: 1
+
   dmas:
     minItems: 1
     maxItems: 7
@@ -77,7 +82,9 @@ properties:
 
     properties:
       compatible:
-        const: st,stm32-pwm
+        enum:
+          - st,stm32-pwm
+          - st,stm32mp25-pwm
 
       "#pwm-cells":
         const: 3
@@ -113,7 +120,9 @@ properties:
 
     properties:
       compatible:
-        const: st,stm32-timer-counter
+        enum:
+          - st,stm32-timer-counter
+          - st,stm32mp25-timer-counter
 
     required:
       - compatible
@@ -128,12 +137,13 @@ patternProperties:
         enum:
           - st,stm32-timer-trigger
           - st,stm32h7-timer-trigger
+          - st,stm32mp25-timer-trigger
 
       reg:
         description: Identify trigger hardware block.
         items:
           minimum: 0
-          maximum: 16
+          maximum: 19
 
     required:
       - compatible
-- 
2.25.1


