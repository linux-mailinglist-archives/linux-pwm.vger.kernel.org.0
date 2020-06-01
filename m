Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B991E9DFD
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jun 2020 08:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgFAGTd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Jun 2020 02:19:33 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15498 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgFAGTc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Jun 2020 02:19:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed49d950000>; Sun, 31 May 2020 23:17:57 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 31 May 2020 23:19:32 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 31 May 2020 23:19:32 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 1 Jun
 2020 06:19:31 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 1 Jun 2020 06:19:31 +0000
Received: from sandipan-pc.nvidia.com (Not Verified[10.24.42.163]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ed49def0000>; Sun, 31 May 2020 23:19:30 -0700
From:   Sandipan Patra <spatra@nvidia.com>
To:     <treding@nvidia.com>, <jonathanh@nvidia.com>, <linux@roeck-us.net>,
        <kamil@wypas.org>, <jdelvare@suse.com>, <robh+dt@kernel.org>,
        <u.kleine-koenig@pengutronix.de>
CC:     <bbasu@nvidia.com>, <bbiswas@nvidia.com>, <kyarlagadda@nvidia.com>,
        <linux-pwm@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sandipan Patra <spatra@nvidia.com>
Subject: [PATCH V2 2/2] arm64: tegra: Add pwm-fan profile settings
Date:   Mon, 1 Jun 2020 11:49:14 +0530
Message-ID: <1590992354-12623-2-git-send-email-spatra@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590992354-12623-1-git-send-email-spatra@nvidia.com>
References: <1590992354-12623-1-git-send-email-spatra@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590992277; bh=XQiGWOGFzg3l+QIfS45QIJAE9J403LC3AAuTqpFbPj4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=E2H7DwhZ8czbHI8kpSXdx31IRjXsW6J9CtPBiwNCeT65M5QkeJeL9q6ge6Z5olR0W
         VkOvlOsgrUn7FjD5pvddKUxPvvI8xTfLS+W71crSKiJwrnE6tvz61sH+x43srNooBe
         qnq2S+yMwjUfoHpQXcOMBetK7AHWaeZdDjps3Iy4iHrh0Zvz0eLDzfyNVN/RUrO37n
         ZcgeumjtRq8mfhoc9C/lWX5314jvioGVI/2ouX1w/YVTVyJesKO2PniWNi80e0YC7v
         6ECyRsaL86cRT6UoKELdn+CUOZlIr0MNdj9oqDcKomqold55vhRo7zwmkZ6js9IUj+
         kyPgFpqoiA3Gg==
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

