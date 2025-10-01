Return-Path: <linux-pwm+bounces-7375-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AB7BB0A0C
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Oct 2025 16:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932F73C10D1
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Oct 2025 14:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AB7303A3F;
	Wed,  1 Oct 2025 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPnF481b"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49F630277F;
	Wed,  1 Oct 2025 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327463; cv=none; b=iIO51GZ3Y9IcGB5DP0WJar7iSES7P6e37+k+lpy3AgJelpbK97INWnn7gKpoH7duj2Hjazx5truD3drwDxK80ztkwUZVwjxFCDTWNsFdPnOAbBtUPh6FLVn1JG46bPomw/oUtEY8c95RBYyQe1+Nl/na913wxX3Vy+3x5nF/uug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327463; c=relaxed/simple;
	bh=Pi8UCkwgJIEOdVhZWtrj0Uu7QhaUGHxfSoe/0iViBsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VGv4Nqd69740Vc6yZNkxc5pioaSZFJdhsYvnRsPbFzhdGbH7qTY9KZHIuaBDrIiYgY0PzvB9YSt5LukblcYPQi+X7bij3JRR61vCtTgrsbt5/oNB6cwnUE5xCTykFgCxN7nmsC8DAE9KWt5BR/VZ2Oh/rH7b7R+J2OSAyQz8Hlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPnF481b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71632C19422;
	Wed,  1 Oct 2025 14:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759327463;
	bh=Pi8UCkwgJIEOdVhZWtrj0Uu7QhaUGHxfSoe/0iViBsQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SPnF481bRUsR+gspp1H7c7FoBsi2sp1mhFut3RZ+O9XpW8nU8e5495pzHmTi773vQ
	 EtfGr0sKZkekLd3NBU2AT2GTOhHQ6KZRPlWXM2GlGY12ScmJ/mMG2lFNGA+XAnJla7
	 IHgdnn1eOMWPpUGLkCb+51ZSBowDSejAvKZXL9hLTNrWxTn4xK8znDYVah6Ww2dyFH
	 sjvYXrXmqkK8SwcOG7Caq7hd45dyVNz7tV0vGpYYq5kA3rteyC/LAut0Ku646lB2an
	 uiKSxgcnsuHx/gMxgko7/xMd7cCFMDhkYN9H/0e+iba+/WKzxM/2YxkrQxh0RWvMjh
	 NjzJaJqltNniw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F55CAC5BB;
	Wed,  1 Oct 2025 14:04:23 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 01 Oct 2025 18:04:24 +0400
Subject: [PATCH v16 8/9] arm64: dts: qcom: ipq5332: add pwm node
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-ipq-pwm-v16-8-300f237e0e68@outlook.com>
References: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
In-Reply-To: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759327459; l=1186;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=KvYbb087e0IlFv5OJiQl0AaX3Z3Wvu4mRV8HcggrQbU=;
 b=Ah/Gp1IRi9I3RMtMSorPmK/+gcsW3TwS7R/hNSgj/sNzrA7Tu6dkcYzMMxwReGloAXjEVZhP8
 mSOlAuQdzujCMwH1mc5aqE8mwyfl1f3od1bKV1NL9p6SYyR3BwOwbI/
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

Describe the PWM block on IPQ5332.

Although PWM is in the TCSR area, make pwm its own node as simple-mfd
has been removed from the bindings and as such hardware components
should have its own node.

Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index 45fc512a3bab221c0d99f819294abf63369987da..4ff6e38521ed94fac0f4caac5c5b0d9be3704d7e 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -334,6 +334,16 @@ tcsr: syscon@1937000 {
 			reg = <0x01937000 0x21000>;
 		};
 
+		pwm: pwm@1941010 {
+			compatible = "qcom,ipq5332-pwm", "qcom,ipq6018-pwm";
+			reg = <0x01941010 0x20>;
+			clocks = <&gcc GCC_ADSS_PWM_CLK>;
+			assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
+			assigned-clock-rates = <100000000>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
 		sdhc: mmc@7804000 {
 			compatible = "qcom,ipq5332-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x07804000 0x1000>, <0x07805000 0x1000>;

-- 
2.51.0



