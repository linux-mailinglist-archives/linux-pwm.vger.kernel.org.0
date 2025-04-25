Return-Path: <linux-pwm+bounces-5709-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A7EA9C94D
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Apr 2025 14:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ECA13B52E5
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Apr 2025 12:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1906124E4A9;
	Fri, 25 Apr 2025 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="WX0jyR2K"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3699324BC1D;
	Fri, 25 Apr 2025 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745585428; cv=none; b=buQDTyS2hjS+RNck8NnrTO26W+76gtjeBCcvnvA2vjEPkHNWmbNs3mv0mIcRo+pB/Vd6Ee3zaaPP/uk/ri8DOytA2BIBFiyes72HZNysx2eKfOspRcXtfpVoB7xi26n3jURuVgTBQDw4LYr305c9kKfJYtBjBaRp9O6RT0S/y/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745585428; c=relaxed/simple;
	bh=Jo1F+SpndTahZzn2NeV6YMgPnUybfbIKse3Y/YgP+5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QPHSq5RRyKPuJfAB7cHF/ci0w1km2LTq3vlnHYSaxvJI+djNO1ESw7w/Qhy+hg49W6bGkvZ2T7k8Ub2wvtbj9ey86BXyWXRoUxv5zyr3UwS95bzncnPY2XSnnjVMeCquc42Wy8lCqj+6T1/7fw1/zK/moFLU5krMNgiVUNN5Q6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=WX0jyR2K; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P7NVon019309;
	Fri, 25 Apr 2025 14:50:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	NeK5d7dLB9+0vrbA7blChOQTxW3J9mnj7OUQ3K6i/f4=; b=WX0jyR2KUaY7pB3z
	3IeQxJcN3N1A8FtwdTfpgq4rfg8aRwSvRbFcg0lJGstwZ2IYadzeWAeESYTpMBR1
	/BufXm1oikD+MzBduAUiQSlxCHyr3n91WaN9i2k5ZA8uj3P2yXGwwu663KES5mcg
	t0HameL848ww0a06i3w9Ho67+CuaV0QXvFWYzCUVsueRjFovvJsohUGXOBrcfxEq
	WBjFGAAZX+x2qdsr4H0trcaRvN7Wd4SFtnvh40Ww9/TOlxoCVFCT0QerC8BCX5JJ
	jlmGPw1EJYWMQ18tl6D4NxzyFZRgvQSEUdTWw8rjGMr6e47YbEpwDVYb0r/NJPab
	a/C6MA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 466jjvm6tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 14:50:16 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1097040048;
	Fri, 25 Apr 2025 14:49:12 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C4605A09553;
	Fri, 25 Apr 2025 14:48:05 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 14:48:05 +0200
Received: from localhost (10.252.15.6) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 14:48:05 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC: <ukleinek@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <jic23@kernel.org>, <robh@kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <devicetree@vger.kernel.org>, <wbg@kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>, <fabrice.gasnier@foss.st.com>
Subject: [PATCH v5 1/7] dt-bindings: mfd: stm32-lptimer: add support for stm32mp25
Date: Fri, 25 Apr 2025 14:47:49 +0200
Message-ID: <20250425124755.166193-2-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250425124755.166193-1-fabrice.gasnier@foss.st.com>
References: <20250425124755.166193-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01

Add a new stm32mp25 compatible to stm32-lptimer dt-bindings, to support
STM32MP25 SoC. Some features has been updated or added to the low-power
timer:
- new capture compare channels
- up to two PWM channels
- PWM input capture
- peripheral interconnect in stm32mp25 has been updated (new triggers).
- registers/bits has been added or revisited (IER access).
So introduce a new compatible to handle this diversity.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in V4:
- Add Rob's Reviewed-by tag
Changes in V3:
- Fix yaml indentation issue found by Rob's bot
Changes in V2:
- Use fallback compatibles, along with stm32mp25 specific compatible
- trigger identifier can be up to 4 (e.g. from LPTIM1..5)
---
 .../bindings/mfd/st,stm32-lptimer.yaml        | 40 ++++++++++++++++---
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml b/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
index d41308856408..4eabafb8079d 100644
--- a/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
+++ b/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
@@ -21,7 +21,12 @@ maintainers:
 
 properties:
   compatible:
-    const: st,stm32-lptimer
+    oneOf:
+      - items:
+          - const: st,stm32mp25-lptimer
+          - const: st,stm32-lptimer
+      - items:
+          - const: st,stm32-lptimer
 
   reg:
     maxItems: 1
@@ -48,13 +53,21 @@ properties:
     minItems: 1
     maxItems: 2
 
+  power-domains:
+    maxItems: 1
+
   pwm:
     type: object
     additionalProperties: false
 
     properties:
       compatible:
-        const: st,stm32-pwm-lp
+        oneOf:
+          - items:
+              - const: st,stm32mp25-pwm-lp
+              - const: st,stm32-pwm-lp
+          - items:
+              - const: st,stm32-pwm-lp
 
       "#pwm-cells":
         const: 3
@@ -69,7 +82,12 @@ properties:
 
     properties:
       compatible:
-        const: st,stm32-lptimer-counter
+        oneOf:
+          - items:
+              - const: st,stm32mp25-lptimer-counter
+              - const: st,stm32-lptimer-counter
+          - items:
+              - const: st,stm32-lptimer-counter
 
     required:
       - compatible
@@ -80,7 +98,12 @@ properties:
 
     properties:
       compatible:
-        const: st,stm32-lptimer-timer
+        oneOf:
+          - items:
+              - const: st,stm32mp25-lptimer-timer
+              - const: st,stm32-lptimer-timer
+          - items:
+              - const: st,stm32-lptimer-timer
 
     required:
       - compatible
@@ -92,13 +115,18 @@ patternProperties:
 
     properties:
       compatible:
-        const: st,stm32-lptimer-trigger
+        oneOf:
+          - items:
+              - const: st,stm32mp25-lptimer-trigger
+              - const: st,stm32-lptimer-trigger
+          - items:
+              - const: st,stm32-lptimer-trigger
 
       reg:
         description: Identify trigger hardware block.
         items:
           minimum: 0
-          maximum: 2
+          maximum: 4
 
     required:
       - compatible
-- 
2.25.1


