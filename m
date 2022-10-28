Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27245611185
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Oct 2022 14:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiJ1MeR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Oct 2022 08:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJ1MeP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Oct 2022 08:34:15 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DC71D462B;
        Fri, 28 Oct 2022 05:34:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPc96Uw05LUTPi1FRww1nBsSm3jKNniqsdSJlQS1Tsk+ThNv4gQx61ZDWBLrDHqjhgnkkLKmzCEERn+Kruk+8RK94iT7vUVoYS9gh8aCXg3rYG0g1gdO5mvqLKg6tR72NeOAq4y1cpz9LZ5UDAO8YHGSjgflSFTtXYakwGTdL/9BPTSxD1kifPQZz9zoKOdQQVss+c2/UMGG/RKwqrsuuYiAaq/g3D+b1IKoGiw97kgdkp1FGU2eRJiAJ41PQxuVk4KC3vWSTvGt/4OvjLKUqSx30IPJp2TyyJvnhEk2CDgUCpvlimVco4ODlK9npfayqGocL1G09XO6HUtgJjF+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vyEm+GGJ8av55BjVf4f7a1pzJhihJGaxTcjBb2sHOM=;
 b=AD1ULHBoSHNq2/xtQyKhHjhapEe8IgB8F7K38mJufLkfSTt2v3d1Hx720FS4yHpQYkksN+t6u8zRNSbnAFcN6bVTZhxxPUHnmax6MUo+qvmsO/uZ+b0bN9wEO4irtX7geryxlo7Mm0QdWocW7WuK+TJz2tDYmn360R9NshZBt9N4MNwOG4gUbE/0D31XNT/nIh/RfsyzZ6Te5aWlpaJIjI/mq/g52qNU2l6v8edmyo46DDopiyde9wvAv+rq7GFvGTwyKCLyh9jiy/3ac4UK2pf3+YAZyjuCe8iGc5KCVVv9+sokdbpd0FSQqYmBRS4PhcMz0A6I5dQuxLDmxVoN3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vyEm+GGJ8av55BjVf4f7a1pzJhihJGaxTcjBb2sHOM=;
 b=GboNw6zZnJy10QsJYRHfmrEW8nEPuvt1MfTiM/hJCiiOrWA+0nUoivTwA4ifrWHRYKSF7PsqrKuuJH/xCEH53oGIu28IRUZT2AzUg7VzzuevhfWiw38m1wxIHc1ffhOTypjwGUJhJ690iFL58FwIlSrO1eOQihVGpLMS1X9E6ZEecdXTcUlS4t7yxWvS5vMRP5sgTxs6uyi7IfblzpuXJ4r7de1+nbwqS4+7Kghc4rE+HfMRoU0XXSf/pEBuGWBkdZ9A7TH1Cx/DvXRbyt4d280DkomTOOjP0Ze8U6oVZgLkCVEh8TQ+Ze3bpmgd1zb0xPyksvXEohlQEkNshAqJrA==
Received: from MW4PR03CA0230.namprd03.prod.outlook.com (2603:10b6:303:b9::25)
 by BL1PR12MB5850.namprd12.prod.outlook.com (2603:10b6:208:395::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 12:34:12 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::6c) by MW4PR03CA0230.outlook.office365.com
 (2603:10b6:303:b9::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Fri, 28 Oct 2022 12:34:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14 via Frontend Transport; Fri, 28 Oct 2022 12:34:11 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 28 Oct
 2022 05:34:03 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 28 Oct 2022 05:34:02 -0700
Received: from moonraker.home (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 28 Oct 2022 05:34:01 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     <linux-pwm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2 1/2] pwm: tegra: Improve required rate calculation
Date:   Fri, 28 Oct 2022 13:33:55 +0100
Message-ID: <20221028123356.133796-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT035:EE_|BL1PR12MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: a24f72e0-ee67-4ab4-e629-08dab8e0b7b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iedDWrYx5VC/7LbPKgm7tDLTmvcfipN7s7+9KCQ6cS/Rb+uIN28loWpi7EZGA9sRZaoXE0qdP84xTZ/6++FfLz2Rf15NSmwwiAUajGLtjGqQj8vpU709VW27wvvzXtheDxCQMuw6IBZfSWJFeVR5Gku6GHYFptAnAzrkqaG+qMD9D9Dqyp/0ClE7D0w3nytk5OZkZLbbX0Rbu8RtKQpejayDU02nkocX7Yi0CM6m5Piv2w8AIRW2ZJ5PW9AaQKp+vtVa2K//cASLePUWmqXzeH+1//Q3sJk2yO4/mBQh671DVKQAqI3VDOLPYR4OPIuyVI9n1SG5t1jGexQaklML2e8r/iC/s9kuqC8vV20bMyrt907FthfwfRUTQO9tEnVPOEC6Tie5ch8AU3ZXheEPqeRDYfVUmioIBWW/fS7XivDnWP3Qoj+CHwt1b2xPpCtsXXjWURpToNmF+LfD/+/mSRjqMpxT7bsBk9dd0xtG46bb/YmIhdW5S+VVW5dUc30luLfMpdl81fQkD7Rf6lYnUJTHSUfFbBf1mdaDUCW/9Fkv7S2I3hrfiCpMlix5SmKKZGQQNYGwBUfHz5mo78FJ8nJIDSrKYqdS6fw6eoF+PX8HrWWvDL/JeLKGZeFBYoEkJlMO4OxGVYadmIteEBI1FyDCQQtblkTAdTzi+td/ifKtw5VMm5cWxy6a23T26sdQNSD3QR7O9tTZQrERMWTxFpoN6wGt0iBBvDNtISCNjUHl6fwG2w5ThdmGiv5GNdl63H2AL+eqk4X+zkKVlMRQSA==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(36840700001)(46966006)(40470700004)(36756003)(82740400003)(86362001)(8936002)(7636003)(356005)(40460700003)(40480700001)(110136005)(316002)(54906003)(478600001)(4326008)(70206006)(70586007)(8676002)(2906002)(41300700001)(82310400005)(5660300002)(47076005)(186003)(336012)(36860700001)(426003)(26005)(1076003)(6666004)(83380400001)(107886003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 12:34:11.9942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a24f72e0-ee67-4ab4-e629-08dab8e0b7b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5850
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

For the case where dev_pm_opp_set_rate() is called to set the PWM clock
rate, the requested rate is calculated as ...

 required_clk_rate = (NSEC_PER_SEC / period_ns) << PWM_DUTY_WIDTH;

The above calculation may lead to rounding errors because the
NSEC_PER_SEC is divided by 'period_ns' before applying the
PWM_DUTY_WIDTH multiplication factor. For example, if the period is
45334ns, the above calculation yields a rate of 5646848Hz instead of
5646976Hz. Fix this by applying the multiplication factor before
dividing and using the DIV_ROUND_UP macro which yields the expected
result of 5646976Hz.

Fixes: 1d7796bdb63a ("pwm: tegra: Support dynamic clock frequency configuration")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Changes since V1:
- Dropped extra parenthesis

 drivers/pwm/pwm-tegra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index dad9978c9186..b05ea2e8accc 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -145,8 +145,8 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		 * source clock rate as required_clk_rate, PWM controller will
 		 * be able to configure the requested period.
 		 */
-		required_clk_rate =
-			(NSEC_PER_SEC / period_ns) << PWM_DUTY_WIDTH;
+		required_clk_rate = DIV_ROUND_UP_ULL(NSEC_PER_SEC << PWM_DUTY_WIDTH,
+						     period_ns);
 
 		err = dev_pm_opp_set_rate(pc->dev, required_clk_rate);
 		if (err < 0)
-- 
2.25.1

