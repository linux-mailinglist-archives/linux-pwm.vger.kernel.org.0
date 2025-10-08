Return-Path: <linux-pwm+bounces-7414-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E738BC5B86
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Oct 2025 17:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2D334FB173
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Oct 2025 15:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8856B2FB625;
	Wed,  8 Oct 2025 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOvkIdvK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5458E2F998A;
	Wed,  8 Oct 2025 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759937627; cv=none; b=tmV7Q6ZbQ78NwM+RhHREPgJ9GolIwaJcUTXG6sznqopFogA8d9/Vu0In+cx6aLf8010+7vcoy2ZC0UJDgcdoJXJ/+RCKqJgMRfDw7deUMG3C6HJO+H+bewkM7laBvKse1vuHV6iAO3oeDD7rD1KN0Ldqy+dmXjBS+GqGOb4vtR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759937627; c=relaxed/simple;
	bh=eVOsFH8osOeZ8GHSlQlqi0o9HHh6RBAnnXxTD6MchR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XhmN5IfDYuZh1kJJTsv42kUDqXcmHE6QESphXDJ5ogSzgHRY6W/fATWhxB6b8nEeUACREsdpkM7W2QO0QC8vHRS4uw+4joe0GaObY/2CFqhige+KJzpBTAw+Si6N6KET8X6o6yCqRHkPPLqzUL0eiQeUgHcKtJGxi25lJHybJQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOvkIdvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C4EEC116D0;
	Wed,  8 Oct 2025 15:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759937627;
	bh=eVOsFH8osOeZ8GHSlQlqi0o9HHh6RBAnnXxTD6MchR0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JOvkIdvKAasO3xCoq/L5vJozz+ODbzwBc0z5L17uzeoK2L+bffNxUdtXm8sBNiFxs
	 4Ta5uLvWKrFBIzDWyDaJHHy3ENMR0l7Ebavm8rk2IP//Sn4LKIdG/L9a1H1Erelq5m
	 XrZDzAMYXsB3ZrCRhTLN1eF0d251rWveB1gdA0+iXaJEtGtvIKDcQmLz0zKoFmIlZE
	 OLdjrpMPQhU0GXpxl61+qcCs3poHTTha50DDMU9eT0gJqMrMxhA+7DZKWHaQKVfFda
	 XHu8OUmigZPw/KrrLFJhmzKV3DiWTAkao0YWs4caur94kOlBOve/eH5tNB3OJVRR0a
	 k1eJPQp6d939A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117B4CCA470;
	Wed,  8 Oct 2025 15:33:47 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 08 Oct 2025 19:33:01 +0400
Subject: [PATCH v17 9/9] arm64: dts: qcom: ipq9574: add pwm node
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-ipq-pwm-v17-9-9bd43edfc7f7@outlook.com>
References: <20251008-ipq-pwm-v17-0-9bd43edfc7f7@outlook.com>
In-Reply-To: <20251008-ipq-pwm-v17-0-9bd43edfc7f7@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759937623; l=1234;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=qc4VIzmfGZ/Xd+TOMpfJif2wj3plsSY0LnXsUU/Cm6A=;
 b=kdV2vbA1Dga3vyES71ONOlSMDOa1obqQ9fBP2whZgu3oe3HCJspmEAOggz5qK9ydJxnCXqMgD
 3z1S8ogGsRuCv9c2BeNpVoRQ2k13z4v7IvAoO6q5cIhZ0fyXRIZZfWz
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

Describe the PWM block on IPQ9574.

Although PWM is in the TCSR area, make pwm its own node as simple-mfd
has been removed from the bindings and as such hardware components
should have its own node.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 86c9cb9fffc98fdd1b0b08e81428ce5e7bb87e17..8dba80d76d609a317a66f514c64ab8f5612e6938 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -449,6 +449,16 @@ tcsr: syscon@1937000 {
 			reg = <0x01937000 0x21000>;
 		};
 
+		pwm: pwm@1941010 {
+			compatible = "qcom,ipq9574-pwm", "qcom,ipq6018-pwm";
+			reg = <0x01941010 0x20>;
+			clocks = <&gcc GCC_ADSS_PWM_CLK>;
+			assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
+			assigned-clock-rates = <100000000>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
 		sdhc_1: mmc@7804000 {
 			compatible = "qcom,ipq9574-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x07804000 0x1000>,

-- 
2.51.0



