Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C1E378122
	for <lists+linux-pwm@lfdr.de>; Mon, 10 May 2021 12:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhEJKV5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 May 2021 06:21:57 -0400
Received: from mail-eopbgr760087.outbound.protection.outlook.com ([40.107.76.87]:1607
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230175AbhEJKV5 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 10 May 2021 06:21:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idPh05dWvN8xu/rDYUQx+Ohbl/JtcVYxuOP7FktebsSmXM6GXclH2s42w91Yx0r9qi5SENHeiXHkrjUj7HUCc9vWDHkc+HRdTHyuSYi2Abg4D81MuWxM43/KaoLyImcOEG/sClcEnDIXtVcmeboqFmeeOHkv8x6Pw/lYitFxt8c4yiNoMAJ0KSLGATvaEytnKmP9Nf/EI6SHplbGZJ3z9mZkX0QsS7Us1KZscSDtXWsW49N6Bd0AlCNdhRctDt+ZvOuDTQHWTXQ8KCTvNpLJteUdkT7IB4WFkdWNn5WQe4uTXKmtweyegKSM9zKiManyxNoDwp6sfTAIAQ9dFY3VbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0K/eDcsy+1R5PGwGnVfz/TJmMB5kN4/MZbcFqiyhEIk=;
 b=R8DksoNhDkdRLjwqOxwVfLOzmseIaN/y013p/uy/PCBOwNXvZz7fD8hAgZWgznwxQ2NtwYlsNiPAV+4QpeEaWQn3GvwUWaJxaUyosYMCwvlSOzCPB0S4yg0LWvyMkmGVhSFK3/Q8Ss1pF94LdaO/qBtaTNtxT5h2MoZpug1i7LzSy9HiC1ohJqm0kHFzzS2ccnqPcZuBuGZH9VS3RUcCV9/cxM8dvInswT3KmJ4dvxgQelbWOYdM9WA88a99A+bisYCKmQ4n96PByAGj/ZBdluRySKg5LdhZQpXWfVFCJxhWmviiIrwm5B3NXf7npblaW2SMAsx5xBrMuEhIRNtQtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0K/eDcsy+1R5PGwGnVfz/TJmMB5kN4/MZbcFqiyhEIk=;
 b=JecbyODnFCueHR3v+fjkTOkmqRf6IV3TToCRfG88jU14egcQF/k2mwY0pw6MM5mdgPyroOUmGeV4YtW0RRJJsnIptFcF6XGv0VjnC44JsHcmFlgvk13Myj6BC0/sfmXFIuZWXXUDl1G36yzlmz+eJ2leebe6yv6XK/cEHa9+gHc=
Received: from BL0PR02CA0130.namprd02.prod.outlook.com (2603:10b6:208:35::35)
 by BY5PR02MB7042.namprd02.prod.outlook.com (2603:10b6:a03:23b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Mon, 10 May
 2021 10:20:50 +0000
Received: from BL2NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:35:cafe::8b) by BL0PR02CA0130.outlook.office365.com
 (2603:10b6:208:35::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Mon, 10 May 2021 10:20:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT032.mail.protection.outlook.com (10.152.77.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Mon, 10 May 2021 10:20:49 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 10 May 2021 03:20:44 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 10 May 2021 03:20:44 -0700
Envelope-to: u.kleine-koenig@pengutronix.de,
 thierry.reding@gmail.com,
 lee.jones@linaro.org,
 alvaro.gamez@hazent.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org,
 sean.anderson@seco.com
Received: from [172.30.17.109] (port=45012)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lg31h-0004Uf-Lx; Mon, 10 May 2021 03:20:38 -0700
Subject: Re: [PATCH v2 2/2] pwm: Add support for Xilinx AXI Timer
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
 <ff8eb398-fd49-fdb8-447e-2f6270cb006d@xilinx.com>
 <448097ba-7616-ccca-7219-6532dac04dbd@seco.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <12409453-c6f2-1731-a45a-7ef74dabe982@xilinx.com>
Date:   Mon, 10 May 2021 12:20:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <448097ba-7616-ccca-7219-6532dac04dbd@seco.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 316e901a-373d-4ba0-555a-08d9139d48b1
X-MS-TrafficTypeDiagnostic: BY5PR02MB7042:
X-Microsoft-Antispam-PRVS: <BY5PR02MB70421E573EE7A13F33212F7BC6549@BY5PR02MB7042.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uWcIcBRO3NR55EaQnWkjeH6reZJ5iUvpay14AB0BxulZ59GCapr2fiviWgpicHxPNeXSNAKiyf+meda8BAYgCuiTeSkE7TJBI2XCkD1OZgP6EqVr/tBq/o24doVUbVqhUpZJB6fd5h/Sa5YW0YJ8CnpGBuve9X2CZa972iOjaB6OwLa1o4O8I5hmpXkX2yFp1EMGSjaUyNjasqnHRpW6Eho+TYKgm5FnYHRixl1bYaCwpFsHZ7WXVksGUBhlREciS5TJYjVAZm4p9GVAPuIyDPWa4dIqbI8k1mLmMbKgPWR+FOPZW4kUKRvLyEOM3O7Cb7ulcElfIRiupTlbNcmOrpTH/hCojx5gL55YksyH223/SgmbaL6M8tnBVBXcKu5ATAISYpezS6S4+GgH5LlGlXC8v2C+7ULeqpSqrneVdfQJNRKyKvvv31IKmHM/VFS4iNkyZFufZzFSdfbTkhrZrDDGBDC36MpnoJLbOAIzrtRt9EXcvg88YqF1yoCky6nydASoFhAFwfxrlPwhKOEXzP/TNQWTPZZS4c0lfv7pie8GjcT8mlB/EMlMy8b9oul1Q9d6pvJxtFw8jVFLME7MjBBgo636KIxMtkKlEJinqIt19a6iUlHl82zrRAF5nGIEj9r8zBd/SZe0+zEUhtV1yVB6HyhnFjhPKCHz02w+bKnMvtsG40G9WT1AJ2vknaxXeJXurJlIiPrJFCfgjPAJrzaeLdGTH8tP5QT7PaQDiGfStI9j67Zd6RyK+pJzf5+WTYOEZgDKHLfi4bEWSpegSL+lzWsINPoCRrWFAwrFD9M=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(396003)(346002)(376002)(136003)(46966006)(36840700001)(336012)(4326008)(5660300002)(47076005)(966005)(426003)(316002)(6666004)(478600001)(26005)(8676002)(36906005)(31696002)(186003)(36756003)(36860700001)(2906002)(2616005)(82310400003)(31686004)(44832011)(53546011)(9786002)(356005)(7636003)(83380400001)(54906003)(82740400003)(8936002)(70586007)(70206006)(110136005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 10:20:49.8611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 316e901a-373d-4ba0-555a-08d9139d48b1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7042
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 5/7/21 12:36 AM, Sean Anderson wrote:
> 
> 
> On 5/6/21 12:54 PM, Michal Simek wrote:
>> Hi,
>>
>> On 5/6/21 4:28 PM, Sean Anderson wrote:
>>>
>>>
>>> On 5/5/21 2:37 AM, Michal Simek wrote:
>>>>
>>>>
>>>> On 5/4/21 8:49 PM, Sean Anderson wrote:
>>>>> This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
>>>>> found on Xilinx FPGAs. There is another driver for this device located
>>>>> at arch/microblaze/kernel/timer.c, but it is only used for
> timekeeping.
>>>>> This driver was written with reference to Xilinx DS764 for v1.03.a
> [1].
>>>>>
>>>>> [1]
>>>
> https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
> 
>>>
>>>>>
>>>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>>>>> ---
>>>>> I tried adding a XILINX_PWM_ prefix to all the defines, but IMO it
>>>>> really hurt readability. That prefix almost doubles the size the
>>>>> defines, and is particularly excessive in something like
>>>>> XILINX_PWM_TCSR_RUN_MASK.
>>>>>
>>>>> Changes in v2:
>>>>> - Don't compile this module by default for arm64
>>>>> - Add dependencies on COMMON_CLK and HAS_IOMEM
>>>>> - Add comment explaining why we depend on !MICROBLAZE
>>>>> - Add comment describing device
>>>>> - Rename TCSR_(SET|CLEAR) to TCSR_RUN_(SET|CLEAR)
>>>>> - Use NSEC_TO_SEC instead of defining our own
>>>>> - Use TCSR_RUN_MASK to check if the PWM is enabled, as suggested by
> Uwe
>>>>> - Cast dividends to u64 to avoid overflow
>>>>> - Check for over- and underflow when calculating TLR
>>>>> - Set xilinx_pwm_ops.owner
>>>>> - Don't set pwmchip.base to -1
>>>>> - Check range of xlnx,count-width
>>>>> - Ensure the clock is always running when the pwm is registered
>>>>> - Remove debugfs file :l
>>>>> - Report errors with dev_error_probe
>>>>>
>>>>>     drivers/pwm/Kconfig      |  13 ++
>>>>>     drivers/pwm/Makefile     |   1 +
>>>>>     drivers/pwm/pwm-xilinx.c | 301
> +++++++++++++++++++++++++++++++++++++++
>>>>>     3 files changed, 315 insertions(+)
>>>>>     create mode 100644 drivers/pwm/pwm-xilinx.c
>>>>
>>>> Without looking below another driver which target the same IP is just
>>>> wrong that's why NACK from me.
>>>
>>> Can you elaborate on this position a bit more? I don't think a rework of
>>> the microblaze driver should hold back this one. They cannot be enabled
>>> at the same time. I think it is OK to leave the work of making them
>>> coexist for a future series (written by someone with microblaze hardware
>>> to test on).
>>
>> I am here to test it on Microblaze. In a lot of cases you don't have
>> access to all HW you should test things on but that's why others can
>> help with this.
> 
> Ok, can you convert the microblaze driver then? I'm afraid I can't work
> on a driver if I don't have a system to test it on. There are too many
> small bugs which can creep in without anything to work with. If you are
> insistant that there must be no driver duplication (even temporarily),
> then you should help with the deduplication :)
> 
> I would also be willing to try and get a microblaze qemu setup working,
> but I have found no good instructions for doing so with mainline linux.
> The best I found was [1]. Do you have a working setup for this?


You can look at Guenter's files which he uses for testing here.
http://server.roeck-us.net/qemu/microblazeel/

Or you can use Xilinx petalinux distribution or Yocto layer which should
have qemu integrated.

Thanks,
Michal
