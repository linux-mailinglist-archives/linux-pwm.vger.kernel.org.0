Return-Path: <linux-pwm+bounces-5711-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3781A9C953
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Apr 2025 14:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2754F1BC7F1A
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Apr 2025 12:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6251252909;
	Fri, 25 Apr 2025 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="aHniuGyW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF98B24C084;
	Fri, 25 Apr 2025 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745585429; cv=none; b=dJF9UqaxNb7NvhUKuAURFQTey4wU5ktBwvFCPvTPeSpLvbJnOyNN/jiVAtQ7xloqCwNGpFFgdRkubAtuDmVPkFtXHTR+6xPoqIW9CFZYraCStrPYq+wr79b9udwgZuOwestdW687+Uiu5BMksSQvyP4G4xAcWOnXk+776fgeDzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745585429; c=relaxed/simple;
	bh=0UnlsJ/QMPp3en93prvQfDrfGSRGtCvMeCyLsWlTT+o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sBdHVPqWiE4zYQCC1Xg8py1Yj++SHuaYzCiDZ4apg8i0GDlcai5aX5h44nYFDSpFM56SCvMka5OOb1yU8/8zBxwaHrQyS5IzJbv6sJMP4GJqMF6761AGChChlZyL5VVBDJlLBl/j8KI0ttVkdMx+Y10+6IBtV5fmRQyYbt5wR2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=aHniuGyW; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P7lAxF018475;
	Fri, 25 Apr 2025 14:50:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	2wY6Dic8hzBm+S2wld/DgwBFhKKy9RZVyTbW8u8LUKQ=; b=aHniuGyW5wXEexaJ
	wN/0mgKOrkjRB9ul0/pq6wZNhy9S9Laek+IDMd4ulNrCDtQ5Yt9PzwSWrHmJp/tx
	+5NnyjLHoF/dR9JUfUjPZZ4uFbduhANN6AqFwcQRPdYIldYlffsyMtmqaU/B3t+Q
	rsnVGb5qAO4n5NQdDVHxFrUvogylimuMBxfyaNmAY55CgsOkYjmFWW0UJHeML7YU
	y/XKAmv5tgIEzjjH2sgzeMcVyV4DhSQZscotkfUpL+kPgrMueQtK4Be0Lv11hyx0
	O8bOEEAKZYm8ompknWtgXKI8QAhmxSjE6J+CD086HjjT655OzbQv/AHAX3YXzIK9
	QHNW5Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 466jjvc67q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 14:50:16 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0F51540060;
	Fri, 25 Apr 2025 14:49:19 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 002A49E8E07;
	Fri, 25 Apr 2025 14:48:10 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 14:48:10 +0200
Received: from localhost (10.252.15.6) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 14:48:10 +0200
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
Subject: [PATCH v5 7/7] arm64: dts: st: use lptimer3 as tick broadcast source on stm32mp257f-ev1
Date: Fri, 25 Apr 2025 14:47:55 +0200
Message-ID: <20250425124755.166193-8-fabrice.gasnier@foss.st.com>
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

During the low power modes the generic ARM timer is deactivated, so the
the tick broadcast is used, based on LPTIMER3 which is clocked by LSE on
STMicroelectronics boards.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 1b88485a62a1..242115863ab4 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -190,6 +190,14 @@ &i2c8 {
 	status = "disabled";
 };
 
+/* use LPTIMER with tick broadcast for suspend mode */
+&lptimer3 {
+	status = "okay";
+	timer {
+		status = "okay";
+	};
+};
+
 &rtc {
 	status = "okay";
 };
-- 
2.25.1


