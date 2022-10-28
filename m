Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C23611187
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Oct 2022 14:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiJ1MeS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Oct 2022 08:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJ1MeR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Oct 2022 08:34:17 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831D91CCCEB;
        Fri, 28 Oct 2022 05:34:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQr0Ke+WG6oYATC8bPo2NdeWeI8mcujl4VQeXhQ/lwEwKqs+HrQORzh9VfioU4pyA7UOuPHOe3rmH04JezhtTOljIrcEMPxQX2jvfE8CX04T3GCeD2BVCtMvaVYfdsjWVySUMRBX04vYldI2tCSARkmodIVyQ/m7Ap0pP9zFbou8/xdrSkVsiBJT8gJMsajqcxbGIksH5yITh2K87f8JCWyqiW5Nvs3G+ZW2lHtVVHZ3FJRlz2VU0YXB/IdCl+gEuKYlPrMk4ts8yfpISE83e5Zkmjk8Eah9pSh0GRqbtPOsbpW8nnuCRKdMHnGhqSookQYQHMBTXc8KYCoDFwVtdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJWfiRN9RmmfrUPC9xoaQggAcrt5cgjr/msDq5tt4eU=;
 b=ZIhfcUqQS2zLdE6jpIH6zRdrfWCCawIfqxo6r++3agtzr2PWPm3UeLZWdisCBXRQ+EsDWSh54CVAHjLkUo/3+qxMLvrnx8zgjIivuKra6tv34ILYHjZVwVUoxDJvA7bWwJ4Y4LiJWQB4U599Mj9Yl5Jyn135WCB2ISxw27GtEEDO7E+7KmPqzfiiEiYPLUYl0ssZC8n1/HDJN2A3amm+4TVJDX+hm6VGuB3McmBYwuteBwYoUpj98yIO4YA0BRUy4FcAL9wHsJupkgMHiuOK0hje66gHiIBt82yn7iRdq0gpBKJ4ctbq7vdjue9ypeNO2knf9xia6JNVZVOImVaeUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJWfiRN9RmmfrUPC9xoaQggAcrt5cgjr/msDq5tt4eU=;
 b=jcNy+338sPEvey0YgKHgS3+PJx7WY1OwRsBSWWY1ECk76FN0H20w0ZdjYbUGx4czLn0c2ddX9xzvu5I4IPRzoPT3fTxHRN8HLid2oHhMo85j2w5PRR2qvSiJlgx43n6s6XCMEc8dF0Eg63PKYAqhdtwrYtwxkUmO+OHjbonr8DZRD+LglC1VX0lggqKmx1BaIcMRB0bNwITUTphe/c28bcVoeajgd9nA47zvLug6offo7DqHBM7kfWkOEdBuJ/Hd1tMaiFZeOeevjXZBVwL6HFV75sMVwyPQ/7sVb61Ji20TLSJVHBLTLHW/QSJIhXLLkITyd6HruqyCYPJRWNf9AA==
Received: from MW4PR03CA0215.namprd03.prod.outlook.com (2603:10b6:303:b9::10)
 by SN7PR12MB7228.namprd12.prod.outlook.com (2603:10b6:806:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 12:34:14 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::cd) by MW4PR03CA0215.outlook.office365.com
 (2603:10b6:303:b9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Fri, 28 Oct 2022 12:34:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14 via Frontend Transport; Fri, 28 Oct 2022 12:34:14 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 28 Oct
 2022 05:34:04 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 28 Oct 2022 05:34:04 -0700
Received: from moonraker.home (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 28 Oct 2022 05:34:03 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     <linux-pwm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2 2/2] pwm: tegra: Ensure the clock rate is not less than needed
Date:   Fri, 28 Oct 2022 13:33:56 +0100
Message-ID: <20221028123356.133796-2-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221028123356.133796-1-jonathanh@nvidia.com>
References: <20221028123356.133796-1-jonathanh@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT035:EE_|SN7PR12MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 4572e99e-0345-4fc7-45b2-08dab8e0b923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AWceR4zUk68qXT39r1Os20fVy6BkSrDdHcq3Axri6C/aXuMwYQdLqt9wwLv2ZrBD0uvpcNNw9PLMPjR3MP3tjQjdP6m2DG2z2f6ZQV9A8Jorx2dZ9ur9B1R7pVsFrjnnuj1AFOewOObXxl111N6k0AAvKwXBHJZEZ7PU7aJ5O+6u25hDUwPKhTWCfLgNg3V1fdDX/n3tL973BVlNWJaHjKizl/JwbqPoJ82Piie5FAq9+ocUDlg0xVxo57SUjfMvyMhlDBzqGRcvv7AFBiRdjVT8SVW4Ed97WB5yIC4vpgLYJUxsSZAXLYIM/cTa+583JAw9XBgTIW5XU6HH3UqaiuhJb+3trpc/mSGtLyIsheEalLwGrEFsR7pdsVThcmMqfnl9uJpnv1udCAa9rruDsln/PIMBrBHOCYFTVkeO3riMtRXjUUsPHXETFvX2qXCU7lD7Zzz1jFr4xTIyjD7L/CEUjn8uRCVrTXK1Fst5oda4GmYb4KzZ9qt99X5IJO9FnwDMZ90Gy9O/jkdQJHBxVP2vfnmMNIuhQw8iPYwnU5Gn+mFr/zeohxAKm5P4QUzjZDZ2cdYEUbVfGYrLC41h3xQU7uKMl+sCUa+BOAuZ0K36OXi2lAJU5l5toDPxEK9lqsDylUL0pkSH7fvcsQy08nQzIydm+yJ/Ev+TMUCDg6MMnv0Z6gqO79lQy8Xs32XvVa+h1Mbqb4koQEZbeFWZ3LQxEYX78cPB5DjxqZqgFLMbtsEjEOet2ZZHgiBnRa9t5l7vYf1LZggQKArPliIa0Q==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(26005)(478600001)(36860700001)(47076005)(83380400001)(426003)(186003)(336012)(6666004)(107886003)(40460700003)(2616005)(7636003)(40480700001)(54906003)(70206006)(70586007)(82310400005)(5660300002)(4326008)(8676002)(8936002)(2906002)(110136005)(1076003)(316002)(41300700001)(36756003)(86362001)(82740400003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 12:34:14.3690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4572e99e-0345-4fc7-45b2-08dab8e0b923
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7228
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

When dynamically scaling the PWM clock, the function
dev_pm_opp_set_rate() may set the PWM clock to a rate that is lower than
what is required. The clock rate requested when calling
dev_pm_opp_set_rate() is the minimum clock rate that is needed to drive
the PWM to achieve the required period. Hence, if the actual clock
rate is less than the requested clock rate, then the required period
cannot be achieved and configuring the PWM fails. Fix this by
calling clk_round_rate() to check if the clock rate that will be provided
is sufficient and if not, double the required clock rate to ensure the
required period can be attained.

Fixes: 8c193f4714df ("pwm: tegra: Optimize period calculation")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
Changes since V1:
- Multiplied the required_clk_rate by 2 instead of adding 1 to the
  PWM_DUTY_WIDTH and recalculating the rate. Overall rate should be
  similar.
- Updated comment based upon Uwe's feedback.

 drivers/pwm/pwm-tegra.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index b05ea2e8accc..6fc4b69a3ba7 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -148,6 +148,17 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		required_clk_rate = DIV_ROUND_UP_ULL(NSEC_PER_SEC << PWM_DUTY_WIDTH,
 						     period_ns);
 
+		if (required_clk_rate > clk_round_rate(pc->clk, required_clk_rate))
+			/*
+			 * required_clk_rate is a lower bound for the input
+			 * rate; for lower rates there is no value for PWM_SCALE
+			 * that yields a period less than or equal to the
+			 * requested period. Hence, for lower rates, double the
+			 * required_clk_rate to get a clock rate that can meet
+			 * the requested period.
+			 */
+			required_clk_rate *= 2;
+
 		err = dev_pm_opp_set_rate(pc->dev, required_clk_rate);
 		if (err < 0)
 			return -EINVAL;
-- 
2.25.1

