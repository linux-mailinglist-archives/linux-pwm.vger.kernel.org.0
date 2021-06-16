Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A9F3A99FE
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Jun 2021 14:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhFPMOo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Jun 2021 08:14:44 -0400
Received: from mail-dm6nam10on2042.outbound.protection.outlook.com ([40.107.93.42]:40993
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229456AbhFPMOn (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 16 Jun 2021 08:14:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkVf79htUxavQI/ByUqgaYhHSvtX4pdYkxO4gpUlB7ukeW1/+Iw/nYb0N7xiIpTXFGiKTmtSwwglOr7lVXq28jckiEPuhNeVoVKCeKyH21pca041ufROhInLd8XIIgc25PUh+IXlV8gvvg6F6Sbblzz4OVn3bkYQxCsrm+5DMiO+0rH0k5Zsei+l1TqDTdfGh8x7K47p0/T61oTudP/GsMJOmvnEbul0P9l1e/D/bHn7rzF8vaENZXlIRuf9UoVeMJUgPtNIvQur2Syj3IHI85I7W+/VWw47iYkUj38KuKeaULomu71oL+eRF0wqCtDGnbyS+gAmR9hm33xcp8w6oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UeZ5EsCgXob8Oz7rniFRPZ11FMeshrxgKg/0b1mhd0=;
 b=RghJBLhqeaBy/RIdnScuICnBTwtfZ2JRHM8wqBoVrq8iPLvrgEmwVkEtwACH88ZH+4ZKjLLiOWf79hMh7dg4aW7M4kIYWLR8xVg8H17MPsydMxD4NlI3H/gbcmHlID3Q7EL1NrxfkC9o2HOCES5YXB6wunmTroPJBXgcIYnr9jnIzCT43CoP24RrQ2jxMqM7DzaaDiHskuVYDQ+nRizr5ucEnYlkND+RxTKXVO5iNtFwfpNJW0O5XGexewzPSFkaUQ76XaJ/09H0Feg+i+KQPlahpduPUsf1I07bxm70qtUOYKuxlU2EMfNL8KMsL3DZuYRHzibNPnh6WeXobOR43A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UeZ5EsCgXob8Oz7rniFRPZ11FMeshrxgKg/0b1mhd0=;
 b=P7tVjq2hJ2djz3r/spRB9QJSHN6UJl6ibESSxMGcELbYQw4oUOE75ZaIWAKgh0zgllSLZcLSQbv4Ui59UPpXU7tWXscmLU6FOYbiBkqVkH+az6LtM6fKrXIVVEjSIjm5carJ4tmaAbtBW0sP9vAmw8Rc3Q2Y4F6ujVvBGYo8jtQ=
Received: from DM5PR15CA0040.namprd15.prod.outlook.com (2603:10b6:4:4b::26) by
 CH0PR02MB8167.namprd02.prod.outlook.com (2603:10b6:610:10c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Wed, 16 Jun
 2021 12:12:36 +0000
Received: from DM3NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::c) by DM5PR15CA0040.outlook.office365.com
 (2603:10b6:4:4b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Wed, 16 Jun 2021 12:12:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT026.mail.protection.outlook.com (10.13.5.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 12:12:36 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 05:12:35 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 16 Jun 2021 05:12:35 -0700
Envelope-to: kernel@pengutronix.de,
 tglx@linutronix.de,
 lee.jones@linaro.org,
 daniel.lezcano@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 alvaro.gamez@hazent.com,
 thierry.reding@gmail.com,
 robh+dt@kernel.org,
 devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org,
 sean.anderson@seco.com,
 u.kleine-koenig@pengutronix.de
Received: from [172.30.17.109] (port=42314)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ltUPL-0006sV-Da; Wed, 16 Jun 2021 05:12:35 -0700
Subject: Re: [PATCH v3 2/2] clocksource: Add support for Xilinx AXI Timer
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Sean Anderson <sean.anderson@seco.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, <kernel@pengutronix.de>
References: <20210511191239.774570-1-sean.anderson@seco.com>
 <20210511191239.774570-2-sean.anderson@seco.com>
 <d4bb7b5d-9f38-cf60-fb0b-18f8e0ca2b1e@xilinx.com>
 <5f960034-174d-0ed8-9f52-3d5fde90e16a@seco.com>
 <9f227f96-a310-0fbd-fd34-91eb386306b9@xilinx.com>
 <7a06cf46-0f85-1edb-ca08-abd7b2543ad9@seco.com>
 <41542760-3967-4f9a-0f0c-1206e03ff494@xilinx.com>
 <d206a399-454e-d9c5-e2d3-337d098ed7aa@seco.com>
 <2296d4e5-717a-0470-d487-e0924cf6c076@xilinx.com>
 <20210525061131.omrbcdewf4z75ib7@pengutronix.de>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <64318c16-780c-336a-8580-e70c91b71cbf@xilinx.com>
Date:   Wed, 16 Jun 2021 14:12:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210525061131.omrbcdewf4z75ib7@pengutronix.de>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 150ff267-e59d-4a3f-7f5a-08d930c0074e
X-MS-TrafficTypeDiagnostic: CH0PR02MB8167:
X-Microsoft-Antispam-PRVS: <CH0PR02MB81673D47F48A01CE48142661C60F9@CH0PR02MB8167.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Ya1XNor839OVyFhkYJy2/uq9X3UKFghJ7xkHsYPIw6aTxCgdyv5zaNwTQBjU6I284+erBVm6H8vjvwyqL92tRXMDQihiEF5djWPeq04+7SxxGBc+Jhp0oI2Yfj5UapLuOnV+YOVCjYFwealUEh1eQLJ2TAsS57QwTgdpXlKTDR/01ZWH6M2vsLrz2lAY2/VdvGWijRIHH2m+0osPxrJt5ntt2YwNGAm5W6GhyY5ZoXPXMMVNAvJcv+do6Z7LvC8EwhNI5alaMP4GXNWa2ZpNY6WQutqzicEFzSJq0f3TANAICNgkIb5JR58dvUBh4Us8hKW1+KetOZ2/87FzPKpjtEOyAcDgjfL6+kWSMzE1vS7jZ2a1sv9Okeqczzp82iDj+ncDGHRB2OXEUSo/A1WSa7/gA+k09Ep16Fsf3R7bBEQLAvMxuI0uEbZtszrgcJ59iK/SuUUAKxZnG3x3QGOpq+DxKCO6vBKJHCHUqOqo2ecnHNKASn/mBWPeyiUv5DVPZt0ly7Xt6TNn8NHwSQ7CIGbpToVsRkLn+oc6w4J1KTlk0xQyci3+QJGC34/HAY3hL6GthvSoBXumVtwgZCDF554PowI/gCpIaYkuu1Jsf12t1mhkUPICyZwxTgVm74hcTWMJPhO443FbJk+RtrE6F/WwGVFFSHtW1kE4n1nC6f5bYgQU4oSfFXE5BsSDitBd8QbygONxajD03TtSc20EA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(36840700001)(46966006)(336012)(426003)(82740400003)(53546011)(7636003)(5660300002)(356005)(36860700001)(26005)(186003)(44832011)(9786002)(2616005)(4326008)(8936002)(54906003)(31686004)(8676002)(70206006)(70586007)(31696002)(47076005)(36906005)(2906002)(110136005)(316002)(66574015)(6666004)(478600001)(82310400003)(83380400001)(7416002)(36756003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 12:12:36.3165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 150ff267-e59d-4a3f-7f5a-08d930c0074e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT026.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8167
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On 5/25/21 8:11 AM, Uwe Kleine-König wrote:
> Hello Sean, hello Michal,
> 
> On Mon, May 24, 2021 at 09:00:51AM +0200, Michal Simek wrote:
>> On 5/20/21 10:13 PM, Sean Anderson wrote:
>>> On 5/19/21 3:24 AM, Michal Simek wrote:
>>>> On 5/18/21 12:15 AM, Sean Anderson wrote:
>>>>> This could be deprecated, but cannot be removed since existing device
>>>>> trees (e.g. qemu) have neither clocks nor clock-frequency properties.
>>>>
>>>> Rob: Do we have any obligation to keep properties for other projects?
> 
> If a binding is in the wild and used to be documented, it has to stay.
> 
>>>>>> 4. Make driver as module
>>>>>> 5. Do whatever changes you want before adding pwm support
>>>>>> 6. Extend DT binding doc for PWM support
>>>>>> 7. Add PWM support
>>>>>
>>>>> Frankly, I am inclined to just leave the microblaze timer as-is. The PWM
>>>>> driver is completely independent. I have already put too much effort into
>>>>> this driver, and I don't have the energy to continue working on the
>>>>> microblaze timer.
>>>>
>>>> I understand. I am actually using axi timer as pwm driver in one of my
>>>> project but never had time to upstream it because of couple of steps above.
>>>> We need to do it right based on steps listed above. If this is too much
>>>> work it will have to wait. I will NACK all attempts to add separate
>>>> driver for IP which we already support in the tree.
>>>
>>> 1. Many timers have separate clocksource and PWM drivers. E.g. samsung,
>>>    renesas TPU, etc. It is completely reasonable to keep separate
>>>    drivers for these purposes. There is no Linux requirement that each
>>>    device have only one driver, especially if it has multiple functions
>>>    or ways to be configured.
>>
>> It doesn't mean that it was done properly and correctly. Code
>> duplication is bad all the time.
> 
> IMHO it's not so much about code duplication. Yes, code duplication is
> bad and should be prevented if possible. But it's more important to not
> introduce surprises. So I think it should be obvious from reading the
> device tree source which timer is used to provide the PWM. I don't care
> much if this is from an extra property (like xilinx,provide-pwm),
> overriding the compatible or some other explicit mechanism. IIUC in this
> suggested patch the selection is implicit and so this isn't so nice.
> 
>>> 2. If you want to do work on a driver, I'm all for it. However, if you
>>>    have not yet submitted that work to the list, you should not gate
>>>    other work behind it. Saying that X feature must be gated behind Y
>>>    *even if X works completely independently of Y* is just stifling
>>>    development.
>>
>> I gave you guidance how I think this should be done. I am not gating you
>> from this work. Your patch is not working on Microblaze arch which is
>> what I maintain. And I don't want to go the route that we will have two
>> drivers for the same IP without integration. We were there in past and
>> it is just pain.
>> I am expecting that PWM guys will guide how this should be done
>> properly. I haven't heard any guidance on this yet.
>> Thierry/Uwe: Any comment?
> 
> Not sure I can and want to provide guidance here. This is not Perl, but
> still TIMTOWTDI. If it was me who cared here, I'd look into the
> auxiliary bus (Documentation/driver-api/auxiliary_bus.rst) to check if
> it can help to solve this problem.

I recently got patches for cadence TTC driver
(drivers/clocksource/timer-cadence-ttc.c) for PWM support too. It is the
second and very similar case. This driver is used on Zynq as clock
source and can be also use as PWM. I can't believe that there are no
other examples how to deal with these timers which are used for PWM
generation.

Thanks,
Michal

