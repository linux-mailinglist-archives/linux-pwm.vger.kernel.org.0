Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2AC917A42F
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Mar 2020 12:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgCEL1m (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Mar 2020 06:27:42 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8584 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgCEL1m (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Mar 2020 06:27:42 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e60e1d70000>; Thu, 05 Mar 2020 03:26:15 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 05 Mar 2020 03:27:41 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 05 Mar 2020 03:27:41 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Mar
 2020 11:27:40 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 5 Mar 2020 11:27:40 +0000
Received: from sandipan-pc.nvidia.com (Not Verified[10.24.42.163]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e60e2290000>; Thu, 05 Mar 2020 03:27:39 -0800
From:   Sandipan Patra <spatra@nvidia.com>
To:     <treding@nvidia.com>, <robh+dt@kernel.org>,
        <u.kleine-koenig@pengutronix.de>, <jonathanh@nvidia.com>
CC:     <bbasu@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sandipan Patra <spatra@nvidia.com>
Subject: [PATCH] pwm: tegra: Add support for Tegra194
Date:   Thu, 5 Mar 2020 16:57:33 +0530
Message-ID: <1583407653-30059-1-git-send-email-spatra@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1583407575; bh=H8MoH5bhmTck+CA7CcSHDmGDuDzoBuc1QHZfZf1Odv4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=bnKPxpOwuWtvm3BJp5aQ8FKREQkGasGO98+XGBx4vkkGRdHysMVjx/azO8medGykq
         CbhoBI8FqFiOAnKPZImAP0hdFQ4LKN9ydgaNgiZNDKYO782PdSTTZDdqXMvKuAqHjm
         fcELXW6QTuOz0TejsoNQ4v+ZK1kjM92qrjznoXkUKdiXmSpWlDSm6jbIJxkMndgs24
         J8nutniVE0GEh+RHjiHM7xEG00iSPDVkPqJZ4QgRkF1ed42xEO8eesKE8ntfs+wfaV
         Lwk8c+xaWYnzdZXsR48dOOejAIOhfIxveMkqdI6sYQm412EoCCdtl6aSYAfR1hwJ+0
         11cio0r072JfQ==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Tegra194 has multiple PWM controllers with each having only one output.

Also the maxmimum frequency is higher than earlier SoCs.

Add support for Tegra194 and specify the number of PWM outputs and
maximum supported frequency using device tree match data.

Signed-off-by: Sandipan Patra <spatra@nvidia.com>
---
 Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt | 1 +
 drivers/pwm/pwm-tegra.c                                      | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
index 0a69ead..74c41e3 100644
--- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
@@ -9,6 +9,7 @@ Required properties:
   - "nvidia,tegra132-pwm", "nvidia,tegra20-pwm": for Tegra132
   - "nvidia,tegra210-pwm", "nvidia,tegra20-pwm": for Tegra210
   - "nvidia,tegra186-pwm": for Tegra186
+  - "nvidia,tegra194-pwm": for Tegra194
 - reg: physical base address and length of the controller's registers
 - #pwm-cells: should be 2. See pwm.yaml in this directory for a description of
   the cells format.
diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index aa12fb3..d26ed8f 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -282,9 +282,15 @@ static const struct tegra_pwm_soc tegra186_pwm_soc = {
 	.max_frequency = 102000000UL,
 };
 
+static const struct tegra_pwm_soc tegra194_pwm_soc = {
+	.num_channels = 1,
+	.max_frequency = 408000000UL,
+};
+
 static const struct of_device_id tegra_pwm_of_match[] = {
 	{ .compatible = "nvidia,tegra20-pwm", .data = &tegra20_pwm_soc },
 	{ .compatible = "nvidia,tegra186-pwm", .data = &tegra186_pwm_soc },
+	{ .compatible = "nvidia,tegra194-pwm", .data = &tegra194_pwm_soc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tegra_pwm_of_match);
-- 
2.7.4

