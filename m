Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D97060DEB6
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Oct 2022 12:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiJZKNf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Oct 2022 06:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbiJZKNe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Oct 2022 06:13:34 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29DD95E44;
        Wed, 26 Oct 2022 03:13:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXfrPpBQII4zbh6prCjrHfH8wTvOBGaPpgCUzCvl9RLnL7tLJMSK0v34IIO5XE1Sera+8btwgNk+WrXobOBOWIB5YHPCn2U2yzZBX8cvGu9l0bZz530+ei8ujwJO+ePUzv7TBG3JRdzoqjyf7Aea1wqa5/KrCo41kDJBXnkKH1PfTLQAaTiuJ7GdkswT+JkYkYaGVic/4Gr3KpzPQGLJy6gGgDTL8yTqzOXCNC+EvD3jDjwZZUzhI7GCDnvOEITkGWGpQmCRW22Q3ArlPpTpwvIt2c+5apF+Y8bNVMAG2cNppH18yux5qqzZjp2ghpgjjgRNLBY3dTxo+lZpV0y9OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zho1N5Ybe25hDM2yJysuIqe3dbizTlMV5GBZkuzeHNM=;
 b=Cf9upWMRJArw8h20vuZofdWapVj6ZRuUcTg8r6JYFyWiqLrD22CZtDSUTEZJe2017Cidu7eCHdPY7pK+BYJreFYcjhCuewI9qnyZdRNedfM2XjOxIsRvSvB78E7bWsHsleGAKkUEt+MyIiCgTojR1uVAB7nuDNvtiolWsuT+UDqW+TIznLjG9VhQl1URgDgM0auBKeO1aVctQFiN8iRZjUvqSmBKQ+ojICQdp0YMlOvbKtcBiQNNFjs156F9k/qtzqa2+RPqA1eZYuTqpjjKYsaJjxEJ4RNEWF2Aqjodxf2xzsy5DgpSrWYuQxwIqgkhnvQye7yNC2xv9oFWlb4HCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zho1N5Ybe25hDM2yJysuIqe3dbizTlMV5GBZkuzeHNM=;
 b=pinoDzYgwlm3kwXA7fn2Hy+/PjKceMNFPBtCFb//UXz/c41ZjEWoDivxeDC/NY4bvgsKWS2PETxFrt/RHReRBY1e04vv5g7iVLyOClbrKmc+hdAeSovJqbhRE2MLZZCl/r2EZwd4ZPl6It+AZzzL0TXlwpTC0v8TH0Fdy06II8JqIxm501l7ExGodsqfXJhiJbsStqjSxJRfy5djvTxGMvBJruHdxlewl9Qm+Clkw3D4mIDruFEIGBnec57nGtteqql9dugXnJWnZBaf3b3Z8W+HKK2xbhwjgPNvuQbvMdXODh8LUe6g0o0dxGLgzKiObWRfL8Ai+AL0IIk3+Po0+A==
Received: from BN0PR03CA0051.namprd03.prod.outlook.com (2603:10b6:408:e7::26)
 by CY8PR12MB7563.namprd12.prod.outlook.com (2603:10b6:930:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 10:13:31 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::6c) by BN0PR03CA0051.outlook.office365.com
 (2603:10b6:408:e7::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Wed, 26 Oct 2022 10:13:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Wed, 26 Oct 2022 10:13:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 26 Oct
 2022 03:13:19 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 26 Oct
 2022 03:13:18 -0700
Received: from moonraker.home (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.29 via Frontend Transport; Wed, 26 Oct
 2022 03:13:17 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     <linux-pwm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 2/2] pwm: tegra: Fix required rate when clock is lower than needed
Date:   Wed, 26 Oct 2022 11:13:05 +0100
Message-ID: <20221026101305.30670-2-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026101305.30670-1-jonathanh@nvidia.com>
References: <20221026101305.30670-1-jonathanh@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT039:EE_|CY8PR12MB7563:EE_
X-MS-Office365-Filtering-Correlation-Id: 69cbafc8-53d5-4168-be6e-08dab73abbc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mqKfVQ/ZPc2/9z/Y3HyXNj5SpU1I3NngJ9WBIkb8h3XEjsEY5stFxzQWUC8O/KlRw2zMxLmGkuxepJWlcQAx1NHSURYfUw/gxtlWElQdpSF/j6D8VRRJMMijkDfEx/IjDrRl6J/d1n6pwFuB5AYFYyIdCKZsdduoQqmuIs8mp9JAdxKVmXp8DmhC+wgdIJef6iSP8OtYy3/ZKDPCdIPzryKLVjLOerQtulTdmi63wlv/gokPIXmm/8lsIs3RzIVN7cpZtaiBllNZHgr99j/8xWsZBuDVrA2oQ1UFXk7xKx52mgsSml65FF9sIReoqqnEUvKzei7ejrDtrXzoPE09TTdCX7SNa6ICfhuRJebD9+h+0DdUCcFMVCPoy8IxOz0rbbAZzshQsJgKLn5CmObqk0wbzVsn4jocbEMZlv7MW28Z9fPEPcOmKdO8S9C080YWxbf811G8owSqeq4vkAHJdVrPmxcTW1HZmQtuXTnGkV5IqnyE8JUa25PpjlWgNvAnsflzpka2CkmIanx2dzE/jjDYhT6XB33VbndpZsUHvXOP8cWregcD3n/X4QWZKGzSTwzP5mA32NYQXsnuRYDJK+nkInibvF0U6g+uB6ZN9wiACPrlQZ7WtYtvyf/ew9nhkJgbvQgqDdIo36dH+MOKJi19rih/E7a7zfghAS+0Fda1m4CowADOSOKuIX5E2bEYIs0LuJO3u0r9ZAnr67o01+wGdEVWxoOIoFdZq/YdhvJKGZOXSh8W6qBvdV0aRUwpfp92JS1hr6em8WBWptPSf9JQBabtSPOECS1/nq5y/T4=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(47076005)(426003)(83380400001)(86362001)(70206006)(36860700001)(356005)(82740400003)(5660300002)(8936002)(70586007)(4326008)(6666004)(82310400005)(8676002)(40480700001)(107886003)(26005)(2616005)(40460700003)(54906003)(41300700001)(110136005)(2906002)(336012)(186003)(316002)(7636003)(36756003)(478600001)(1076003)(20673002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 10:13:31.0756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69cbafc8-53d5-4168-be6e-08dab73abbc5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7563
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

If the 'required_clk_rate' is greater than the clock rate that can be
provided, then when mul_u64_u64_div_u64() is called to determine the
'rate' for the PWM divider, 0 will be returned. If 'rate' is 0, then we
will return -EINVAL and fail to configure the PWM. Fix this by adding 1
to the PWM_DUTY_WIDTH when calculating the 'required_clk_rate' to ensure
that 'rate' is greater or equal to 1. This fixes an issue on Tegra234
where configuring the PWM fan fails.

Fixes: 8c193f4714df ("pwm: tegra: Optimize period calculation")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 8a33c500f93b..973e2c1533ab 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -148,6 +148,19 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		required_clk_rate = DIV_ROUND_UP_ULL((NSEC_PER_SEC << PWM_DUTY_WIDTH),
 						     period_ns);
 
+		/*
+		 * If the 'required_clk_rate' is greater than the clock rate
+		 * that can be provided, then when mul_u64_u64_div_u64() is
+		 * called to determine the 'rate' for the PWM divider, 0 will
+		 * be returned. If 'rate' is 0, then we will return -EINVAL and
+		 * fail to configure the PWM. If this case, add 1 to the
+		 * PWM_DUTY_WIDTH when calculating the 'required_clk_rate' to
+		 * ensure that 'rate' is greater or equal to 1.
+		 */
+		if (required_clk_rate > clk_round_rate(pc->clk, required_clk_rate))
+			required_clk_rate = DIV_ROUND_UP_ULL((NSEC_PER_SEC << (PWM_DUTY_WIDTH + 1)),
+							     period_ns);
+
 		err = dev_pm_opp_set_rate(pc->dev, required_clk_rate);
 		if (err < 0)
 			return -EINVAL;
-- 
2.25.1

