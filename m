Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3D31ADE5C
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Apr 2020 15:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbgDQNcd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Apr 2020 09:32:33 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10108 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730351AbgDQNcd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Apr 2020 09:32:33 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e99afe40001>; Fri, 17 Apr 2020 06:32:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 17 Apr 2020 06:32:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 17 Apr 2020 06:32:33 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 Apr
 2020 13:32:32 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 17 Apr 2020 13:32:32 +0000
Received: from sandipan-pc.nvidia.com (Not Verified[10.24.42.163]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e99afed0009>; Fri, 17 Apr 2020 06:32:32 -0700
From:   Sandipan Patra <spatra@nvidia.com>
To:     <treding@nvidia.com>, <robh+dt@kernel.org>,
        <u.kleine-koenig@pengutronix.de>, <jonathanh@nvidia.com>
CC:     <bbasu@nvidia.com>, <bbiswas@nvidia.com>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sandipan Patra <spatra@nvidia.com>
Subject: [PATCH 1/2] arm64: tegra: Add pwm-fan profile settings
Date:   Fri, 17 Apr 2020 19:02:41 +0530
Message-ID: <1587130362-6149-1-git-send-email-spatra@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587130340; bh=XQiGWOGFzg3l+QIfS45QIJAE9J403LC3AAuTqpFbPj4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=W1ljNgAiglXpYwTiOt5LIiM96HxibYp4Bv/aKBTqcsq5QftmopOp6RjWo6xWx00sb
         E8rvxbjKJzs0+BvDMSxgSMGxMxNtJ5yh3N8IMQeklBkfX+CIlOyJpMVjs/6DZHaGc5
         xgrG8Dqvwiv+WxHIvQKkVi6CiU0u+xMa0PONc93b2th8DYfwKW1njjRkidyUTRmEmC
         MwywXd2lkbNDnIS/jU6wr5sEOGfmrG8mSv+UGIn6yqbABfMIG/Afwhquca4NhuV1cD
         LGfXGs7aEv+zWFPMqyLq/WEH6SuI4deN/AVN88ZmR8KPs1y9H4rAs1YPH9ROUFoBQD
         T6N++2c8PtnYw==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add support for profiles in device tree to allow
different fan settings for trip point temp/hyst/pwm.

Signed-off-by: Sandipan Patra <spatra@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
index e15d1ea..ff2b980 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
@@ -219,10 +219,19 @@
 
 	fan: fan {
 		compatible = "pwm-fan";
-		pwms = <&pwm4 0 45334>;
-
-		cooling-levels = <0 64 128 255>;
 		#cooling-cells = <2>;
+		pwms = <&pwm4 0 45334>;
+		profiles {
+			default = "quiet";
+			quiet {
+				state_cap = <4>;
+				cooling-levels = <0 77 120 160 255 255 255 255 255 255>;
+			};
+			cool {
+				state_cap = <4>;
+				cooling-levels = <0 77 120 160 255 255 255 255 255 255>;
+			};
+		};
 	};
 
 	gpio-keys {
-- 
2.7.4

