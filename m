Return-Path: <linux-pwm+bounces-7368-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BDBBB0A1D
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Oct 2025 16:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4831189FA95
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Oct 2025 14:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE38130275A;
	Wed,  1 Oct 2025 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKc/wIOu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD603019C5;
	Wed,  1 Oct 2025 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327463; cv=none; b=IWfLBq5zJSTYI8Iv9TJeEPOZnJ3UI91NjCVVvTcTVA2H0J52SnWZvdJF0mxmG9gVYWVauNc41+9jQTvlfexC8NUvqBFIv0ZU7HsgZRXUzEb6I9XATptXf3/K5IMnXZzEFhsWJE6Yf6//CWdngc+0Y7rlQ4xgMRlIK7vxdDwYzZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327463; c=relaxed/simple;
	bh=uxRiHy8P3s8sW7vDoa08TCwgTgT1biPZKyz5CO7SMNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l4A3plsbkOVj0mCyNESuoCSWlG1LrvTWXKq2dpf8wuCzUbfClVX8RaKvo0YT7wMDt3s8lAItcLA2t0rsuUJosixn+UI8YDrymTAqZ+SihCQvVRPROY0Z7s/+6BAvsgHo3KGadwaOsead2JrU5kFdVfLH9JyJWcl2QXogv+FFSgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKc/wIOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 315E8C4CEFB;
	Wed,  1 Oct 2025 14:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759327463;
	bh=uxRiHy8P3s8sW7vDoa08TCwgTgT1biPZKyz5CO7SMNE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lKc/wIOuTPr1TiEx6kJ57y3NgDdyN08flnrB33vok1ggmg1s+U3wdEfrVBKP1K1cE
	 rQrTrqJGw2Ldwv7XYiNl+c0MrlWdryRD9Rb9EtT2t60t7gCVOaytWEGoX3e6b0puJr
	 UAlsTM0MkyMTCK8dnh8B/e1FMWAs+Sfa+gBcQlPdaGDnZyi320Srp94MyOED7OXPmv
	 ytDwxaqrdkXwr3npO45yKvAntk6kUDIGZuzM/P5hVO2okxztM4C0v1eIKEXHf9Sw3f
	 46vGgf8lib43pObBp0UGgH1dioHwr0XTgLvkYUCYRPFhBNgUmpPX+JdNTGeBVN7a4a
	 FqLBPvy2w8Hpg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E07CCD180;
	Wed,  1 Oct 2025 14:04:23 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 01 Oct 2025 18:04:20 +0400
Subject: [PATCH v16 4/9] dt-bindings: pwm: qcom,ipq6018-pwm: Add compatible
 for ipq5332
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-ipq-pwm-v16-4-300f237e0e68@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759327459; l=935;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=y8giwJKpFzWeiaRvUor0Eljp/p0jcgEG1QTHLcQUb/c=;
 b=cbOuQtetQFcdRwCz4KSHRK5SusXPEgOjS3eOsqWGIPHrIZhGq3M+OYdYqr+WgdT6Bipe37jmd
 OZ/TQIRAkdaBT0x38hr3KQK1P01kvvaWsVvuGEs3AGM4Z7O64QMTsjn
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

The IPQ5332 SoC contains a PWM block which is exactly the same as the
one found in IPQ6018. So let's add a compatible for IPQ5332 and use
IPQ6018 as the fallback.

Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
index acbdd952fcca53368e3b594544df8d3dae8a06b3..e00b9e01f4f89dd0d08610772c984a0e2725d154 100644
--- a/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
@@ -15,6 +15,7 @@ properties:
       - items:
           - enum:
               - qcom,ipq5018-pwm
+              - qcom,ipq5332-pwm
           - const: qcom,ipq6018-pwm
       - const: qcom,ipq6018-pwm
 

-- 
2.51.0



