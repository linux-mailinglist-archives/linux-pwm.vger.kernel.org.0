Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353A8373500
	for <lists+linux-pwm@lfdr.de>; Wed,  5 May 2021 08:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhEEGjC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 5 May 2021 02:39:02 -0400
Received: from mail-dm6nam10on2073.outbound.protection.outlook.com ([40.107.93.73]:23776
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229592AbhEEGjC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 5 May 2021 02:39:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7fqhzU+x9XpKqnNQbWxQT7vokkJamE6GefEHmoDt9a90sFf952QNH5kej221IzJV6iENrJ3RINakJIFnr+jeYYGcslspu67pSNOqCmz3DiYlQp7rwK1F5WBnP0jb0w3QaTj5528/p1XPR8hHpxwN+VSF6Qo5Lsw4xMrCw96NZw+FNqvskIP21Gu74L7ebDrZ5DfyWjmygfrCunTotdvIn/HotZylHcppbTpaMc8swzksYSSMrifwnNxDdBa3Wna/ES++X/HErh4xHnkp6sNPHTblxx5YU6Aj55Nf/GR8wLbRTXooaVoMwPnEeeTkn9qrQxKEdrQNVuIBAr+f/KNzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rN1Hm2MFChn4L2SfV2K9THIK50s0/V0/l4v/iE59Vs8=;
 b=bDuunPtWro6ABgmnwZiFpIvaqKDTIjakkqMFyCMZt4NWhPx0C0MRBAbbA6Qp8r1jmPSdHIxBAiQ1zKyQB2XjuTZaI8tPnULg18/RssbWT8ocAiFzKRpwKn7ngU7G7hvkv8hsZe1+N46AjNnqHIScIkAiPjVbr4OkBtrPkU6+o0C4KLQm2++/YPchJjwA69oi5fILUknfofLZEGkog9t9dqe0VfsFROXM4kAP2/ggW4ij5UmkwTEJH9b2NwSOJ3G1ydK91n83KnTEN2B+B1NMuK/nMIGZK8bVeXes6UXb7OD+fCvuADkybp4+QGSzMjuabKvXKnxd2kCiYlleDVWOFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rN1Hm2MFChn4L2SfV2K9THIK50s0/V0/l4v/iE59Vs8=;
 b=KnFjBeXrsSGvrI76jA30MhcJjqVbFUf0t3WRY896kMOqsyouU4ncV3w/YydFLxKFbPva/8LZV5THAFq9zFHKJlQrYTZZdNK57ALWMNPQp3Sye8IOXxYag4END6M8fzQKnnWnPN2n1yV7MPy1AUZE7hQCt4I6Sj194gzDcUNlZzU=
Received: from SN4PR0501CA0149.namprd05.prod.outlook.com
 (2603:10b6:803:2c::27) by MWHPR02MB3166.namprd02.prod.outlook.com
 (2603:10b6:301:67::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.35; Wed, 5 May
 2021 06:38:04 +0000
Received: from SN1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2c:cafe::f) by SN4PR0501CA0149.outlook.office365.com
 (2603:10b6:803:2c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend
 Transport; Wed, 5 May 2021 06:38:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT020.mail.protection.outlook.com (10.152.72.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 5 May 2021 06:38:03 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 4 May 2021 23:38:01 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 4 May 2021 23:38:01 -0700
Envelope-to: u.kleine-koenig@pengutronix.de,
 thierry.reding@gmail.com,
 lee.jones@linaro.org,
 alvaro.gamez@hazent.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org,
 sean.anderson@seco.com
Received: from [172.30.17.109] (port=46602)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1leBAX-00089z-Ma; Tue, 04 May 2021 23:38:01 -0700
Subject: Re: [PATCH v2 2/2] pwm: Add support for Xilinx AXI Timer
To:     Sean Anderson <sean.anderson@seco.com>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20210504184925.3399934-1-sean.anderson@seco.com>
 <20210504184925.3399934-2-sean.anderson@seco.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <e3782bc5-bcd9-5eb8-e89b-e4e52ed2e3cb@xilinx.com>
Date:   Wed, 5 May 2021 08:37:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210504184925.3399934-2-sean.anderson@seco.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25194029-22f4-46ce-f903-08d90f9055de
X-MS-TrafficTypeDiagnostic: MWHPR02MB3166:
X-Microsoft-Antispam-PRVS: <MWHPR02MB3166B66DD8689A6D7B1A9495C6599@MWHPR02MB3166.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V/2HlHIePlZA5QLc+9TgvXSN0nQsMiuGC2KX6DeJj99+msLAdIj/cvfvglkTN15V57Oa5vke0j2YEIGJZoLdaYWuYMbSASR8CfYwpLOrtGS4/wRHf+DdOEhmiJQ1iHkYtYKTDFMigj57IGrVmr9fx7IECTJYJ9IgoFBGh+FoptjpXkpI+5ldoZVqYhj7xoXRMcnUvITW+hxdlJE3DHoGcPqZePIHKOGZl9UDW2dZcjYvCX3OKlAuoq5Erwmj6SPBrnfJ3c6hkkhOcFIrFC25TK1ToZ93rqUHS4wJu/fpkR8Sv5pZo24sbnJNgbszdAzMw6KM8j5XHOwUKPYbLJ4/lHPo6qphhaVs6ATLTSJorWRAwYb7nsXG+nb38QShmmvYZOfUWbtrt8F+wqcWKngTEbT+p3K7WSnJZO2ih4fnNGYb2dE2uDFzY+Fi4hvHsPKiKJrOpRDvHT6nfrwaDgQWoAB0jyyN3BGdiMPnVhZkRwpTKQ7s2LoM0G+5m8YO32+nLkTW0QM+5THYwcCzDh4DqNSBtzyb+P4A6QnN0JZ1whu8OiOqJVfS6guH50eMwer0qiCjw2cKIUhCwSJ3IHYYkO+vVSk6iF2CrnzZXZWpub44lS9Z1rQ2ixTS2IHL9uh1p+cpqCYmBFoA4/ht77M0moxdfHFG+mA8BDCuorz2MjL2EFXWO/n5dDfbqsjNydfTU+o9PUnLBSNbK/ksYlGvHdWSee4NFspVZvSm6IRv8OU0PD/CVOrV4tz5Yq42P66mh0Gk0DSuK46HccJkvcWab9SffvpCrWu5gdHfGmsVfQ0=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(136003)(376002)(346002)(396003)(46966006)(36840700001)(2616005)(54906003)(478600001)(8936002)(53546011)(70586007)(5660300002)(7636003)(70206006)(82740400003)(82310400003)(186003)(110136005)(36756003)(26005)(9786002)(44832011)(356005)(31696002)(47076005)(31686004)(36860700001)(2906002)(966005)(8676002)(336012)(36906005)(316002)(4326008)(83380400001)(426003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 06:38:03.9219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25194029-22f4-46ce-f903-08d90f9055de
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT020.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3166
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/4/21 8:49 PM, Sean Anderson wrote:
> This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
> found on Xilinx FPGAs. There is another driver for this device located
> at arch/microblaze/kernel/timer.c, but it is only used for timekeeping.
> This driver was written with reference to Xilinx DS764 for v1.03.a [1].
> 
> [1] https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> I tried adding a XILINX_PWM_ prefix to all the defines, but IMO it
> really hurt readability. That prefix almost doubles the size the
> defines, and is particularly excessive in something like
> XILINX_PWM_TCSR_RUN_MASK.
> 
> Changes in v2:
> - Don't compile this module by default for arm64
> - Add dependencies on COMMON_CLK and HAS_IOMEM
> - Add comment explaining why we depend on !MICROBLAZE
> - Add comment describing device
> - Rename TCSR_(SET|CLEAR) to TCSR_RUN_(SET|CLEAR)
> - Use NSEC_TO_SEC instead of defining our own
> - Use TCSR_RUN_MASK to check if the PWM is enabled, as suggested by Uwe
> - Cast dividends to u64 to avoid overflow
> - Check for over- and underflow when calculating TLR
> - Set xilinx_pwm_ops.owner
> - Don't set pwmchip.base to -1
> - Check range of xlnx,count-width
> - Ensure the clock is always running when the pwm is registered
> - Remove debugfs file :l
> - Report errors with dev_error_probe
> 
>  drivers/pwm/Kconfig      |  13 ++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-xilinx.c | 301 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 315 insertions(+)
>  create mode 100644 drivers/pwm/pwm-xilinx.c

Without looking below another driver which target the same IP is just
wrong that's why NACK from me.

Thanks,
Michal

