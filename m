Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63CF3758CB
	for <lists+linux-pwm@lfdr.de>; Thu,  6 May 2021 18:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbhEFQ4C (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 May 2021 12:56:02 -0400
Received: from mail-bn1nam07on2058.outbound.protection.outlook.com ([40.107.212.58]:24197
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236075AbhEFQ4B (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 6 May 2021 12:56:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJd3ACrL+0RS0MGV1rs+GDApDlIHinwujOzsCTCG+VX4Mn3H45pPUpP1FJSmwAiFxeRhMmTu9jmnt/Tb867DA6y/vvOdEg33SnhJpn5LlPCvV7yO+qW0qPrE18zUQ7SCifJlu6oLuyQWACdAgHMmgcmhjx0ZO5CJfVEHl1WqBVW38HTx7u3LTofFwPqOVYlQ0fDaU1EXXhIT+jeqa0RhihgHcOlIiSN8GDWeNMxme1E9uxvIVdtOAV+QOPhJ+BDbjRWCkonnUHsvr/WMk0HFgqN1V63ttlwqDdMakAcfYbVI5r8rt55Q9ICXiWXe0iUZPV+dnVhV/vrO7BA0RPGN/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=am6P0oxgMk2raBe2Oyu8fWeBRFHJlJvyd02nP1c7lho=;
 b=CrhJZeeZsEkKi4+MDIlyjWFlbO6NZ+GvxwMXtPhjEVnEradxGMbYQPahbaCdU8+x7x/ALWZSCRhy4Z+qiYrKuOrGw91S1EoxYtcWsVe6EJFHuqsz4K39Ad/17CxCYScfDDCSa7epMRVmAuJ0EVsp2FMx6/r04aIdD+slIBA0/uU0YemYKc7JZ7GVKNxVrWIgT2aLIMzG0o1FxUhkN5OM4bFl221Ly5GGBUDV4ztoemTS16flqTNWmISwIvxIV+myv4I2dnbPl/XlR/TvSfyCFqrFckcQn9q9Dhh5ZWVHjclQdhwBpXx6pV/8EWPXUVNb2/0HmO3bBu0qkhlshS8IsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=am6P0oxgMk2raBe2Oyu8fWeBRFHJlJvyd02nP1c7lho=;
 b=dbjPF/mbaM7hwF4uoyW6lERFuoXQuVuTcXo7ErW0PrNzcmPMzOtAbN0st3EmtV5oXg27jZbdtUUYJV4duizUI8+ZQ6J2iHk4MbdHQepk0LQ8JTEsXQ3hThJUgEM55HK2qrxnIPmffopijqXEsKOKN1gVd9SCnuV5WcICriJM2As=
Received: from SN4PR0501CA0135.namprd05.prod.outlook.com
 (2603:10b6:803:2c::13) by BYAPR02MB4741.namprd02.prod.outlook.com
 (2603:10b6:a03:52::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Thu, 6 May
 2021 16:55:00 +0000
Received: from SN1NAM02FT0053.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2c:cafe::39) by SN4PR0501CA0135.outlook.office365.com
 (2603:10b6:803:2c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.11 via Frontend
 Transport; Thu, 6 May 2021 16:55:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0053.mail.protection.outlook.com (10.97.4.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Thu, 6 May 2021 16:54:59 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 6 May 2021 09:54:58 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 6 May 2021 09:54:58 -0700
Envelope-to: u.kleine-koenig@pengutronix.de,
 thierry.reding@gmail.com,
 lee.jones@linaro.org,
 alvaro.gamez@hazent.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org,
 sean.anderson@seco.com
Received: from [172.30.17.109] (port=37840)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lehH8-00027y-3H; Thu, 06 May 2021 09:54:58 -0700
To:     Sean Anderson <sean.anderson@seco.com>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20210504184925.3399934-1-sean.anderson@seco.com>
 <20210504184925.3399934-2-sean.anderson@seco.com>
 <e3782bc5-bcd9-5eb8-e89b-e4e52ed2e3cb@xilinx.com>
 <1bfde199-617a-343c-10ed-4c436bfd908f@seco.com>
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v2 2/2] pwm: Add support for Xilinx AXI Timer
Message-ID: <ff8eb398-fd49-fdb8-447e-2f6270cb006d@xilinx.com>
Date:   Thu, 6 May 2021 18:54:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1bfde199-617a-343c-10ed-4c436bfd908f@seco.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e75f63a-adb4-4d07-bdb1-08d910afaf57
X-MS-TrafficTypeDiagnostic: BYAPR02MB4741:
X-Microsoft-Antispam-PRVS: <BYAPR02MB4741C4C037229F9BA538E425C6589@BYAPR02MB4741.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 91Inww1iiPbP6P2KsmfsuyVjBjr0Ql1eSMwifPUf3mqyycGTQBFXbHN/6wFiKBYo1pYby8OFC5/PiYmUlIm15aJV95MQwclX8Ww3CdDtzqifDzwwtONS2NXap4XTdtYBEwc0sl+D68YsIRxlvh0BH8bakYjj5RyUULo/OmBKpVun7PxIsxprWV4T/MRKF0sbSfMw94raB9MjCkExd01mTffA73jevDNOQvG66Tc7OZlUL7iE3A2QzkdEda4d3ESIIqIPndlzNeNyi8Yfc1x3UE3ot1CCom9GC+dzm/3rLrTI4GVKPw6/1OqhLQz712phEw9V/ikM5EYq17rphapohDgN6K0rHtj1egQwbpcnntUn479wP0vAvX+UfG2fKTzvIk+LxQbmEq7iXYszxpfJY+U5w00cL/lc70SjaSpA7tk2ZJCGHBSi7oddbzI8XXXRT0M8LCz0nlyTgw0DTdU7AoKxq49hDnIyD+mhOM4OWZkELWHW9Jda+S2N4p9J2kk/TXJVhtxmTqQI19HcwPL9eI2HYfBObOhESEh6iCa40MZkR6is+no3uZ6lxk64JXeb8w784EpEmLyWSuH/NLMHXAwFfoqae8orsJRa+20hixXhkfuQmDO1IEayY1cY6J699KqZz3y7f7dsJ9vXY7LifvIbb0lI4H3gRBzNXtEeMXreCSWzl6tk7wvghfabmygEzH4SbWXoTfR+UbQmEtW6XXSE6xS3eAlzAsyt+yUKlVzXmgyWF7ff4ZrgHwJMv81z900bfldp5lzqHS/jrRRUFpV1x0lA9LJxOvs3uKytNaQ=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(39850400004)(36840700001)(46966006)(8676002)(966005)(6666004)(70206006)(44832011)(47076005)(82310400003)(426003)(336012)(31696002)(110136005)(316002)(36860700001)(54906003)(53546011)(478600001)(186003)(31686004)(4326008)(2616005)(356005)(82740400003)(36906005)(26005)(36756003)(8936002)(83380400001)(7636003)(5660300002)(70586007)(9786002)(2906002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 16:54:59.5920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e75f63a-adb4-4d07-bdb1-08d910afaf57
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0053.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4741
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 5/6/21 4:28 PM, Sean Anderson wrote:
> 
> 
> On 5/5/21 2:37 AM, Michal Simek wrote:
>>
>>
>> On 5/4/21 8:49 PM, Sean Anderson wrote:
>>> This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
>>> found on Xilinx FPGAs. There is another driver for this device located
>>> at arch/microblaze/kernel/timer.c, but it is only used for timekeeping.
>>> This driver was written with reference to Xilinx DS764 for v1.03.a [1].
>>>
>>> [1]
> https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
> 
>>>
>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>>> ---
>>> I tried adding a XILINX_PWM_ prefix to all the defines, but IMO it
>>> really hurt readability. That prefix almost doubles the size the
>>> defines, and is particularly excessive in something like
>>> XILINX_PWM_TCSR_RUN_MASK.
>>>
>>> Changes in v2:
>>> - Don't compile this module by default for arm64
>>> - Add dependencies on COMMON_CLK and HAS_IOMEM
>>> - Add comment explaining why we depend on !MICROBLAZE
>>> - Add comment describing device
>>> - Rename TCSR_(SET|CLEAR) to TCSR_RUN_(SET|CLEAR)
>>> - Use NSEC_TO_SEC instead of defining our own
>>> - Use TCSR_RUN_MASK to check if the PWM is enabled, as suggested by Uwe
>>> - Cast dividends to u64 to avoid overflow
>>> - Check for over- and underflow when calculating TLR
>>> - Set xilinx_pwm_ops.owner
>>> - Don't set pwmchip.base to -1
>>> - Check range of xlnx,count-width
>>> - Ensure the clock is always running when the pwm is registered
>>> - Remove debugfs file :l
>>> - Report errors with dev_error_probe
>>>
>>>   drivers/pwm/Kconfig      |  13 ++
>>>   drivers/pwm/Makefile     |   1 +
>>>   drivers/pwm/pwm-xilinx.c | 301 +++++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 315 insertions(+)
>>>   create mode 100644 drivers/pwm/pwm-xilinx.c
>>
>> Without looking below another driver which target the same IP is just
>> wrong that's why NACK from me.
> 
> Can you elaborate on this position a bit more? I don't think a rework of
> the microblaze driver should hold back this one. They cannot be enabled
> at the same time. I think it is OK to leave the work of making them
> coexist for a future series (written by someone with microblaze hardware
> to test on).

I am here to test it on Microblaze. In a lot of cases you don't have
access to all HW you should test things on but that's why others can
help with this.
As I said in previous thread driver duplication is not good way to go
and never was.

This patch targets axi timer IP which is already in the tree just for
Microblaze. You want to use it on other HW which is good but it needs to
be done properly which is not create another copy.
The right way is to get axi timer out of arch/microblaze to
drivers/clocksource (or any other driver folder) and add PMW
functionality on the top of it.
I would expect that PWM guys will say how to add PWM support to timer
driver which is not unique configuration.

Thanks,
Michal
