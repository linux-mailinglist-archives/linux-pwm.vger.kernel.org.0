Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD41260DEB2
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Oct 2022 12:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiJZKN3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Oct 2022 06:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiJZKN2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Oct 2022 06:13:28 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43D9CE2D;
        Wed, 26 Oct 2022 03:13:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iku/frUeTrlKdIP2ZEsFnhPqdR/5qviqbHL0fS0ftci2esJlYcrVGaz0girEnaJuHuglko3GaFS0P+P68c86plcak7vmVEvdBY3jUhAKBGVH4mqkoFmXzJwqspmHkmKZRu0Or1SoQpYw/l1Itmuh5EkLAtPiSFjO82Z6G9OrOw6ARDToaRD0RfD5P4pNweNxuYLvoNSiCh3Gr1/kStOqqoUIea/ZdZGSyBNKPABhI/GHCRNgj0dmg2y9mz+EQ1lpT3Sx+5eCzRE/bP4ozvHgzsiNG3ciCBVM8cgr4HUyOrgL2gL59ctAax1n2AtPAc0x3hs9/0qyxYowVq9xIwBUdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fjf8HerWatKfxdEDcdH4yB+7hO9HdkeTb8mnp2Y/LeI=;
 b=oeUeOXjCd7gmwTVq+OtNZtZhMla++Pv7gpPngX8iBzc84gijatC2MuCtBSfNKtSDxlnYxGeErTvQrcr0YJhBzrRdvzoWFq24dPBnyYfcv16dJNHOEBDLnPePJSWVJLabSJwR16WCupjyyQYwtPeI3EdcC3QH0H6/8JafI62fBuJ4uMT9gK5UoN7HzzBIn+4JpvYoHPtGsNf5WivdNU2p+EAAb0M4E7NTnoT8YcwAUTkA2IPy1TBrOsmN7lOaRS7avWstEmWbFV6rYG4CHYH9wHEasAeDrAc8xaQaR8y5XYFahLP1wFf1SmK/OOl61BpY9S9wjgTD8mKcVypPza6L0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fjf8HerWatKfxdEDcdH4yB+7hO9HdkeTb8mnp2Y/LeI=;
 b=o2dclP6T8R5VvOvZP672SIcTlmNJqKbqLUEAY7A8PAVZWJivc+xOcfXj6OfWYdg0eFSgaH01dcZYuSY8ekcrtWPuHINoIx2SJbJ5Qxx1s/Jj0BmBQz5gSl+CZNfHU7ZqT3o+ghgadY7sJXq5PSz1uiVcAuwADvPoxbRd/gw0Ujw7qyTiu3chJeGHu4e3AblJqErt1jx9QL4x1mnSsklcu6J07MXlvUOhJCYX8OsjTUyAzKTAYaL7LNohZvVZRc+GkgsnBiwY6wE1cxz99O5uRk7xbwBR1tU2AI9il/umGD2glmHQzkPaNH0qH+e+soFOntGUkdM0V5JIOcE4h5rkTQ==
Received: from MW4PR04CA0044.namprd04.prod.outlook.com (2603:10b6:303:6a::19)
 by PH8PR12MB6915.namprd12.prod.outlook.com (2603:10b6:510:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 10:13:26 +0000
Received: from CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::6c) by MW4PR04CA0044.outlook.office365.com
 (2603:10b6:303:6a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Wed, 26 Oct 2022 10:13:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT088.mail.protection.outlook.com (10.13.175.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Wed, 26 Oct 2022 10:13:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 26 Oct
 2022 03:13:17 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 26 Oct
 2022 03:13:17 -0700
Received: from moonraker.home (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.29 via Frontend Transport; Wed, 26 Oct
 2022 03:13:15 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     <linux-pwm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 1/2] pwm: tegra: Improve required rate calculation
Date:   Wed, 26 Oct 2022 11:13:04 +0100
Message-ID: <20221026101305.30670-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|PH8PR12MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: 11dd3eab-52d6-456b-cc3c-08dab73ab8b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x1HTSpjWv2t8RrbcEJmDJzOj8iXeQg+ropP9D7f1zifjsRXaGVS6xYXQeWsNEDnshhq9dNBB3EIeOsysTXZprGASjuFsuKKYlLVyNPDlcaFmkVGJyGX0KBjRs9ND4nKhb7oL97MXpBvhsKABXTGm+OyuKyYb+m84wTXPb11aARGPKGtxGvnq3/ZF2mvem04q05FwFlFqLx6/RDDKydMgoGK086lua+tYNl6n/jdbNw+o/lSvaFWl0yqfphLA+KF2QhkX7QtfdRxJED3FmuP7RmXlwJTrtntNHi7TQmUHLyNkP/6/sFe7gAzcdIVdjd/lugfuJ+Bd+0np4uBeWcyha9pAvF/dz07byXSYlDGmAZOfjVwoisREsmifOAbZMqh7KhRlUyMEDCOpIflrHFKj3I1a86nGVHZfNDX4ScAK2wKJXpWLIbtWfgIvGvSAqx9/tTmRHdxV/TfO4Iqv5675GS5W1pFpfEb6NUZ2vnsw+rlAP5o5wqWKM5n3AZMbne5OyuOR/BVeZ/Ahr9vVSRo6cGtNbzCU0KdJzuIxl3Ayea/faL1aHwV4pIDwd18iXLZkPxiesxOhiiVHmOUKtzm/Jj34A5FQX9a5HuTYSwYCzvrJGl+yLvjCJ3UDprmBxZ62vU4HPiCoPERs5RvR7HuNdz+Igz+GRwa23Pao51losMDrOqIRXAELalFC7A2Avx/V+e0brz41MbYZT6TQvdjqsWZaqN9vVEwr4MC9N9+QK2Pp1zGciYfSAmzbHE7xD4/LOloMhsLqIXgAR9oGXwmWwA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199015)(46966006)(36840700001)(40470700004)(40460700003)(41300700001)(2906002)(186003)(1076003)(26005)(83380400001)(356005)(336012)(2616005)(36756003)(7636003)(82740400003)(47076005)(426003)(8936002)(82310400005)(5660300002)(478600001)(40480700001)(107886003)(6666004)(86362001)(36860700001)(8676002)(4326008)(70206006)(70586007)(316002)(54906003)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 10:13:25.9364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11dd3eab-52d6-456b-cc3c-08dab73ab8b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6915
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
---
 drivers/pwm/pwm-tegra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index dad9978c9186..8a33c500f93b 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -145,8 +145,8 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		 * source clock rate as required_clk_rate, PWM controller will
 		 * be able to configure the requested period.
 		 */
-		required_clk_rate =
-			(NSEC_PER_SEC / period_ns) << PWM_DUTY_WIDTH;
+		required_clk_rate = DIV_ROUND_UP_ULL((NSEC_PER_SEC << PWM_DUTY_WIDTH),
+						     period_ns);
 
 		err = dev_pm_opp_set_rate(pc->dev, required_clk_rate);
 		if (err < 0)
-- 
2.25.1

