Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAD9455717
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Nov 2021 09:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244668AbhKRIjG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 18 Nov 2021 03:39:06 -0500
Received: from mail-dm6nam10on2048.outbound.protection.outlook.com ([40.107.93.48]:2945
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244770AbhKRIi7 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 18 Nov 2021 03:38:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5X3wmFWba/4nNfe/akLzgMlaaIQDq5kchjVbOhJx0Z014zlVy0QVwSKgp0d4XUhB4R0FZaLpe43aG+CHAHBMvRZFV+KL4GqDXj7/z6/w0hUcrFbZAS3TnTuZ6lGAORcL+OOThfSXq3K7TMWQjsIN5zFXoKMQO0qkuDP2/jbqxmi2UfVX6XFEyiHAH8myvT712ojQkjq+Mm50MD47mtO/nSj0T6LidTT6hctCOHPBOpEfu6EWjkOMQIhyQT2gO7PIyZORYR357FWj/LahIXl3pRMsk0bHmI7MWadpo+o+eD1Tr/DCmd348GfQ1sTGobg/v54w0gp4nn9m83LNWlmlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nbtsDLR8Nv2f+GrN9cgwnz9+QM2CAc52yaHiS+kXhY=;
 b=Jk81VpmCQop252ul0lM/lDsI5xcG5tKcn4JmgGcEBwhjtVuofhv8PcyycLw0SMDq6c1coMEQVyeVCicEaaZzid8NsITOf7rlck1S6qCAlsHov1qUeWQ0pmL7BCbzjehl+oF3iXnOQi9OzYTAehhFn1rAVMvdZbpVIr0lf+RV+eQnNNWj48Yvy+F65gvbijM0L6ttzmehWuC13yWGnO2F//F2q2LL5hX9Qb7B+QQFxlDIOZe/4u7KbHOBxeeP/lePbIX+lsuI/mXdU39djHoteTrnjHLyR3Sssqn9FdKbEo77TLMvSPg3PtZyqZQiPJ8IQRq5P1FmsoWJHmZUG8DdIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nbtsDLR8Nv2f+GrN9cgwnz9+QM2CAc52yaHiS+kXhY=;
 b=ssFzM207bAWg/wR5uQJJlvNxd3yyyMZDkttnkM6T0I8cr3eIyy7X3xUWaGmyX85g2ErZQLmPxHMTi2Bxf0iqxMDqz+bKZhf6UPC7rtZfLx6oQAfn1wsB5yIvagVPj0Se5X5HGtvQCoXN0dqXUZ0SM523xmTN++0vL/23i4/qlSA=
Received: from SN7PR04CA0082.namprd04.prod.outlook.com (2603:10b6:806:121::27)
 by BN6PR02MB2337.namprd02.prod.outlook.com (2603:10b6:404:2a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 18 Nov
 2021 08:35:51 +0000
Received: from SN1NAM02FT0057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:121:cafe::3) by SN7PR04CA0082.outlook.office365.com
 (2603:10b6:806:121::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Thu, 18 Nov 2021 08:35:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0057.mail.protection.outlook.com (10.97.4.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 08:35:51 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 18 Nov 2021 00:35:50 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 18 Nov 2021 00:35:50 -0800
Envelope-to: thierry.reding@gmail.com,
 sean.anderson@seco.com,
 linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org,
 u.kleine-koenig@pengutronix.de,
 lee.jones@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 alvaro.gamez@hazent.com,
 linux-kernel@vger.kernel.org
Received: from [10.254.241.49] (port=55340)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mnctZ-000AsJ-WD; Thu, 18 Nov 2021 00:35:50 -0800
Message-ID: <51cdffc6-7620-3bfe-2209-6f4abde0c654@xilinx.com>
Date:   Thu, 18 Nov 2021 09:35:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v10 3/3] pwm: Add support for Xilinx AXI Timer
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        <linux-kernel@vger.kernel.org>
References: <20211112185504.1921780-1-sean.anderson@seco.com>
 <20211112185504.1921780-3-sean.anderson@seco.com>
 <YZUshZs2FCfNk5IJ@orome.fritz.box>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <YZUshZs2FCfNk5IJ@orome.fritz.box>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0aae6a12-3eae-4a06-dc98-08d9aa6e6db7
X-MS-TrafficTypeDiagnostic: BN6PR02MB2337:
X-Microsoft-Antispam-PRVS: <BN6PR02MB23371314AFC3B944E14E20E3C69B9@BN6PR02MB2337.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vhY0Mn5XttHK3GUP9fjEtNKbOTRD5I3NYQeudeYktTb7+hwtbIfe/+/tcs/mTxYA0SnG1CVwb98CnWlQTUQTl860NluqUGxme9Oewb0amcGJHx+0e6GTm6jk3DfIo/aqCqBjjqxntKDThuy77/yVcbN6sKbzgX5UmThBYALLYZ41PSI9I6JjZk7HSjTLbtFye1BO7/GPxBgrMWIoAtbm34ebtitz+B+V9u7dHxRWAcrm5RN+HuJ8KPJIZnuq2H36qGskbmz3WJg9tPbxwgncDa479iV2uyV9wIbEyoE9ogNCZMVwlhGE/F+tQGUz4p893jyVdA+8p421xANeODjLUTJK1+3J9LFL4sx/OfJnyYdGu9XgsEVAiHYodFClsfO7EqIj7Jrvr4G1JtjnASfupZ498VgT3FNjspFp4ykjQTo0owbBIT8pMOEw1QiHiV5A8RyF4tCLLgb89AVuSKGTKBotZEWh1vXte2A/uYaeoWmD4IrS/tBwSiXcGlrwLJ6nAOgYrSxACTYt3mLXjtukva1MlIySr6sPBIUsVwg0GXqccpTaloKoa9qQIrJ+vpcOS9tZ7lPqGi4SvEg0ohTkPC6+0msOxjWSSmWygsPZ4miiETiuO3BxCvgCMcu2S3AJA+IkVsEVXhPc2h+zRA7taJygKXiAbq0+ljK3IufuXgYmz20dBvIvwz/7GhF7RaXmLFnKhgxJGLZm14cBAAkpxzzvAJvyUDHi+xzNVQEkBfOXG8KVmUwUz2TlQg3wZKbIWX/bK2j+cWu0Dk4lwfbiSHJ3zZtLcJOw7ikAz8F089NOmNlzNzAmaOa3e2k2ntBGdGZtJ4trjdatgNI9NAv29EQ3Q7WTBKaByddlMsmLNtE=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(70586007)(26005)(966005)(83380400001)(4326008)(5660300002)(36860700001)(6666004)(2906002)(53546011)(336012)(356005)(186003)(8676002)(70206006)(110136005)(31696002)(8936002)(7636003)(508600001)(82310400003)(44832011)(2616005)(36756003)(426003)(31686004)(36906005)(316002)(47076005)(9786002)(54906003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 08:35:51.2726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aae6a12-3eae-4a06-dc98-08d9aa6e6db7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0057.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2337
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 11/17/21 17:23, Thierry Reding wrote:
> On Fri, Nov 12, 2021 at 01:55:04PM -0500, Sean Anderson wrote:
>> This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
>> found on Xilinx FPGAs. At the moment clock control is very basic: we
>> just enable the clock during probe and pin the frequency. In the future,
>> someone could add support for disabling the clock when not in use.
>>
>> Some common code has been specially demarcated. While currently only
>> used by the PWM driver, it is anticipated that it may be split off in
>> the future to be used by the timer driver as well.
>>
>> This driver was written with reference to Xilinx DS764 for v1.03.a [1].
>>
>> [1] https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
>>
>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> ---
>>
>> Changes in v10:
>> - Fix compilation error in timer driver
>>
>> Changes in v9:
>> - Refactor "if { return } else if { }" to "if { return } if { }"
>> - Remove drivers/clocksource/timer-xilinx-common.c from MAINTAINERS
>> - Remove xilinx_timer_common_init and integrate it into xilinx_timer_probe
>>
>> Changes in v8:
>> - Drop new timer driver; it has been deferred for future series
>>
>> Changes in v7:
>> - Add dependency on OF_ADDRESS
>> - Fix period_cycles calculation
>> - Fix typo in limitations
>>
>> Changes in v6:
>> - Capitalize error messages
>> - Don't disable regmap locking to allow inspection of registers via
>>    debugfs
>> - Prevent overflow when calculating period_cycles
>> - Remove enabled variable from xilinx_pwm_apply
>> - Swap order of period_cycle range comparisons
>>
>> Changes in v5:
>> - Allow non-zero #pwm-cells
>> - Correctly set duty_cycle in get_state when TLR0=TLR1
>> - Elaborate on limitation section
>> - Perform some additional checks/rounding in apply_state
>> - Remove xlnx,axi-timer-2.0 compatible string
>> - Rework duty-cycle and period calculations with feedback from Uwe
>> - Switch to regmap to abstract endianness issues
>> - Use more verbose error messages
>>
>> Changes in v4:
>> - Don't use volatile in read/write replacements. Some arches have it and
>>    some don't.
>> - Put common timer properties into their own struct to better reuse
>>    code.
>> - Remove references to properties which are not good enough for Linux.
>>
>> Changes in v3:
>> - Add clockevent and clocksource support
>> - Remove old microblaze driver
>> - Rewrite probe to only use a device_node, since timers may need to be
>>    initialized before we have proper devices. This does bloat the code a bit
>>    since we can no longer rely on helpers such as dev_err_probe. We also
>>    cannot rely on device resources being free'd on failure, so we must free
>>    them manually.
>> - We now access registers through xilinx_timer_(read|write). This allows us
>>    to deal with endianness issues, as originally seen in the microblaze
>>    driver. CAVEAT EMPTOR: I have not tested this on big-endian!
>>
>> Changes in v2:
>> - Add comment describing device
>> - Add comment explaining why we depend on !MICROBLAZE
>> - Add dependencies on COMMON_CLK and HAS_IOMEM
>> - Cast dividends to u64 to avoid overflow
>> - Check for over- and underflow when calculating TLR
>> - Check range of xlnx,count-width
>> - Don't compile this module by default for arm64
>> - Don't set pwmchip.base to -1
>> - Ensure the clock is always running when the pwm is registered
>> - Remove debugfs file :l
>> - Rename TCSR_(SET|CLEAR) to TCSR_RUN_(SET|CLEAR)
>> - Report errors with dev_error_probe
>> - Set xilinx_pwm_ops.owner
>> - Use NSEC_TO_SEC instead of defining our own
>> - Use TCSR_RUN_MASK to check if the PWM is enabled, as suggested by Uwe
>>
>>   MAINTAINERS                        |   6 +
>>   arch/microblaze/kernel/timer.c     |   3 +
> 
> Michal,
> 
> do you mind giving an Acked-by for this part. It looks harmless enough,
> but just making sure you're aware of this.

That's fine for me.

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal

