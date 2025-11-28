Return-Path: <linux-pwm+bounces-7725-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF18FC91A46
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 11:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 581083535D1
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 10:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBE730DEB5;
	Fri, 28 Nov 2025 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aj4TY4wk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7219730C631;
	Fri, 28 Nov 2025 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764325763; cv=none; b=TrZJk5blK0C9/K19E/p42NhguPggM0CwCZ95+ngNtXJEf18fT0uRI2B5kayDVxConnn3sgbju7f5jawEaB9WO/nOtZIItvzUOCAN9iiHUIVYwf86IZihBnjtzNLwJUTel3iHp6edPCcW/RSmSCFzB8mE5ssG+hK1qSnW9m+oL58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764325763; c=relaxed/simple;
	bh=XQ4+jrCNUegmedw+kAaz44GruUsx1JtVMFlXfj8TCGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=thTUXcFo/CBsmn4TnLBNcqmV6Q+nwi/JYD9BtaQe1NndvnOl+xHzG3gmjFhwvZB9W9CWJAhkJ7uRSJW0JNxNHTZ53kLsZhYy6Cmc//pQQq7PPHBvRk0fJTczdG1ADTsEOzXom2FBXhwV9UT+0vf22lEMSIs9G2VgvTUFmrkSKVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aj4TY4wk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1FA9C19421;
	Fri, 28 Nov 2025 10:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764325763;
	bh=XQ4+jrCNUegmedw+kAaz44GruUsx1JtVMFlXfj8TCGg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Aj4TY4wkGQYANB46OYfuBuNYlNA388L8b2ubHdtZDQY0lbqMVwga8v0AUlp26rX4A
	 fhRrzIYwMg0p2vl4Qd2VupMxg6Z9sXNDknU3Ol2NM33ziPz4dPhSDfBfGpmsqz+CGi
	 izNgZjjf2jnr8jznO/ierqEvpW3rlm7wKtE8GN/M5Bn498rhDz8IK/0rixbxl23Abf
	 E4iJWT65uvGadfvG8yxvGJ3EkDRS5L+JKAJEZ49Q5NRlWCaoxqEa3r4UU08+WsuTc6
	 bbJ0O+FzvU4iqzPIOfZ9McGyGNvx/x0hvEDIWhAvhai57VfLG8M8U6pNe6to/isImY
	 9qtg/ycAGyQQw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4207CFD376;
	Fri, 28 Nov 2025 10:29:22 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Fri, 28 Nov 2025 14:29:17 +0400
Subject: [PATCH v19 5/6] arm64: dts: qcom: ipq5332: add pwm node
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-ipq-pwm-v19-5-13bc704cc6a5@outlook.com>
References: <20251128-ipq-pwm-v19-0-13bc704cc6a5@outlook.com>
In-Reply-To: <20251128-ipq-pwm-v19-0-13bc704cc6a5@outlook.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764325760; l=1253;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=ZzpZ9Oc2KX6I6uglSgS8/bCLV/sm5oDSygkEKKOZMT4=;
 b=3vGNro9Ja1P7N6wnvg4pg0K4XT4vfGr/1vBxM/TYRBpoF/OuWL4Ll4EwKyS4UMa+Vt8i6yf4P
 HcDzH7E0poyDIuA1aKoQX7xV54rNMoxuc4A9bakTy4KceSF9tR9R8sL
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

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index 45fc512a3bab221c0d99f819294abf63369987da..e58051f6c1c4fd8ef85cbcc9b98433f599377c7a 100644
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
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		sdhc: mmc@7804000 {
 			compatible = "qcom,ipq5332-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x07804000 0x1000>, <0x07805000 0x1000>;

-- 
2.52.0



