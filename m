Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C016F3B33E7
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Jun 2021 18:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhFXQ2S (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Jun 2021 12:28:18 -0400
Received: from mail-dm6nam08on2041.outbound.protection.outlook.com ([40.107.102.41]:57345
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229464AbhFXQ2R (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 24 Jun 2021 12:28:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMGwvJpQGEvLc8l6pHEYo4SYYvD1G1OgoIDKI/DJEs580CXp8X4g4BfA8+oFqrfhS/CzcCwACn80nb5TlTp3phecbBiQjvTEJeBQEHm7JpxQyP4YwI63fiSxoxnuM9y7dUsCD1EAp8Bvk9sW8F41iJkveCvY76M4Mv2z3B4m19uVdvmHeanBlmbeslw/mdbHzD6zzhWsKpIohE9TANJyLWIKiSuRrb18A0vnqjtEdEmiXh27fnwNtkceKr9HJ1py0fx7tn0I5vX7lrx6R4m34CqS8pHY4SBkaDNnK1BqSWjiP1Kmcgx7t79eJcXLh10WNJU2UNos8songHHcGdOYCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPUWlvFKfxTyMFfBT7y171EJxcli2INw4LcnLeCoGxY=;
 b=DBxnYtWhO+XqJtWk/nCLksPhqoTancBzTsa9pQheBqXfGRlenbEGPIdk78iowP1tvNdLpAqkv5NqoLj796+PpVMnMyOePrSY3OQhUNrDJlRD5P9gjTIJk4MjSEZaZDmQmy5pSXQJb/AwjLCIJ2XSxgiORLqmLV86lnScH7BLlvR1AC55N5bQlbkojMj1axE2D3PmFallSqE61+ZCaOyUVHdNN+djE1/Gky6BgZ0NR4wS+NlJfwr+qF4bT667gAlfZwOjUZ8XdI4xZXHtGAtKZEWu+ubnk0xq0Pc/wT0N1gHxS78P+NXIYkhaLMqPwEl8XbK1DDpizootS5Na6OVjXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPUWlvFKfxTyMFfBT7y171EJxcli2INw4LcnLeCoGxY=;
 b=MQmfgGjDb6khH8zW12P/0k3VnVMkgLplh9U1BZpbYhjYqNRqBKF/M7tBj2U0N9CoNRqg/YxviDDWm4xlO2GSvdF1PQOR9fSmCONdIRApyoMO5GIwU+2KC2knzxXqKdfMFDpHDY1PGiZnkAseuwW28Kt8l5OXbmJVfNS9UPOMH68=
Received: from SN6PR01CA0012.prod.exchangelabs.com (2603:10b6:805:b6::25) by
 BN6PR02MB2418.namprd02.prod.outlook.com (2603:10b6:404:54::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.19; Thu, 24 Jun 2021 16:25:55 +0000
Received: from SN1NAM02FT0033.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:b6:cafe::28) by SN6PR01CA0012.outlook.office365.com
 (2603:10b6:805:b6::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Thu, 24 Jun 2021 16:25:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0033.mail.protection.outlook.com (10.97.5.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 16:25:54 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 24 Jun 2021 09:25:54 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 24 Jun 2021 09:25:54 -0700
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
 u.kleine-koenig@pengutronix.de,
 sean.anderson@seco.com
Received: from [172.30.17.109] (port=39136)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lwSAr-0005i6-Vh; Thu, 24 Jun 2021 09:25:54 -0700
Subject: Re: [PATCH v3 2/2] clocksource: Add support for Xilinx AXI Timer
To:     Sean Anderson <sean.anderson@seco.com>,
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
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
 <64318c16-780c-336a-8580-e70c91b71cbf@xilinx.com>
 <48f972d5-8690-7850-317b-59bb9680d8f9@seco.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <53de5f06-3ae4-0fdd-d930-aa04e74c0319@xilinx.com>
Date:   Thu, 24 Jun 2021 18:25:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <48f972d5-8690-7850-317b-59bb9680d8f9@seco.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55c6f7f4-2edd-47db-628d-08d9372cbdb6
X-MS-TrafficTypeDiagnostic: BN6PR02MB2418:
X-Microsoft-Antispam-PRVS: <BN6PR02MB24189E9A9EC88B326470F414C6079@BN6PR02MB2418.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RaqBPqozC3zSr9pj+xyf33RSwvoyDijdROidcYPvCR94atkDuPM3M9oL8HOdA6F9h6qtbwmAwAxNTNS+/DFcydG9paTcOAwPIVyQrIUzy5oqb42EA6wpAFsMdzSExsTqKs/TefR8hIJZjiOKorX6bDMVd0JE1CI+RzFGxnJ4D+Sv7VJ+d1KETXabGOL4q1irfGO9CKXzaRSS3qlUbgtIKRDnO8gQZnWMdRdMhsQYmMd+HlS3Dc4a6MY9CsqH3NbuCHG9sLKiENdHz2m7duI05Ac9V++v9RglFR90Uq/Hu0YFYysC0Dn6ppJA1oJkkJfjZGuImi4l3R7puuBiQQy3FcbMU3ujI+QQxOPsVhEg5o/tkTaZaOcAicLh1HNVrwylAcxuTrjqrgQ32ivJJes6D6WXqTLKXPzGz6iaWVomojy8yR26Ph/5G14ABnaO2Jb6iLzM3G7bO82eG5TUCcx6eT31uYMwU3JAtqUU5xrdsIKXTUcNSWQAYkGERlN1ZS0Oun1hvBiShVzL6STuoj/rxVCIRuoUht7hqkXy9ww+xvLXqihpLTh7f8Yzb+UWNMwXHTSgcUa9nNS4MOoTPpgJLkchnnIWgTOzGNc9GfWqaI6HlhuTARMJFqfrE+cJkXpNLfB7tDGqPinhlYkDkACf9eDTCBPG0XZbcV6ez3XAs/YK5IA8pfZBXlZ+2h29aM2OoI3c+MygRY/IitGT7+5kpw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(39850400004)(36840700001)(46966006)(26005)(186003)(53546011)(44832011)(8676002)(31696002)(4326008)(8936002)(336012)(9786002)(478600001)(31686004)(2616005)(82740400003)(356005)(7636003)(426003)(7416002)(82310400003)(36756003)(83380400001)(66574015)(6666004)(36860700001)(2906002)(47076005)(36906005)(316002)(110136005)(70206006)(5660300002)(54906003)(70586007)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 16:25:54.9771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c6f7f4-2edd-47db-628d-08d9372cbdb6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0033.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2418
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 6/18/21 11:24 PM, Sean Anderson wrote:
> 
> 
> On 6/16/21 8:12 AM, Michal Simek wrote:
>> Hi Uwe,
>>
>> On 5/25/21 8:11 AM, Uwe Kleine-König wrote:
>>> Hello Sean, hello Michal,
>>>
>>> On Mon, May 24, 2021 at 09:00:51AM +0200, Michal Simek wrote:
>>>> On 5/20/21 10:13 PM, Sean Anderson wrote:
>>>>> On 5/19/21 3:24 AM, Michal Simek wrote:
>>>>>> On 5/18/21 12:15 AM, Sean Anderson wrote:
>>>>>>> This could be deprecated, but cannot be removed since existing
> device
>>>>>>> trees (e.g. qemu) have neither clocks nor clock-frequency
> properties.
>>>>>>
>>>>>> Rob: Do we have any obligation to keep properties for other projects?
>>>
>>> If a binding is in the wild and used to be documented, it has to stay.
>>>
>>>>>>>> 4. Make driver as module
>>>>>>>> 5. Do whatever changes you want before adding pwm support
>>>>>>>> 6. Extend DT binding doc for PWM support
>>>>>>>> 7. Add PWM support
>>>>>>>
>>>>>>> Frankly, I am inclined to just leave the microblaze timer as-is.
> The PWM
>>>>>>> driver is completely independent. I have already put too much
> effort into
>>>>>>> this driver, and I don't have the energy to continue working on the
>>>>>>> microblaze timer.
>>>>>>
>>>>>> I understand. I am actually using axi timer as pwm driver in one
> of my
>>>>>> project but never had time to upstream it because of couple of
> steps above.
>>>>>> We need to do it right based on steps listed above. If this is too
> much
>>>>>> work it will have to wait. I will NACK all attempts to add separate
>>>>>> driver for IP which we already support in the tree.
>>>>>
>>>>> 1. Many timers have separate clocksource and PWM drivers. E.g.
> samsung,
>>>>>     renesas TPU, etc. It is completely reasonable to keep separate
>>>>>     drivers for these purposes. There is no Linux requirement that
> each
>>>>>     device have only one driver, especially if it has multiple
> functions
>>>>>     or ways to be configured.
>>>>
>>>> It doesn't mean that it was done properly and correctly. Code
>>>> duplication is bad all the time.
>>>
>>> IMHO it's not so much about code duplication. Yes, code duplication is
>>> bad and should be prevented if possible. But it's more important to not
>>> introduce surprises. So I think it should be obvious from reading the
>>> device tree source which timer is used to provide the PWM. I don't care
>>> much if this is from an extra property (like xilinx,provide-pwm),
>>> overriding the compatible or some other explicit mechanism. IIUC in this
>>> suggested patch the selection is implicit and so this isn't so nice.
>>>
>>>>> 2. If you want to do work on a driver, I'm all for it. However, if you
>>>>>     have not yet submitted that work to the list, you should not gate
>>>>>     other work behind it. Saying that X feature must be gated behind Y
>>>>>     *even if X works completely independently of Y* is just stifling
>>>>>     development.
>>>>
>>>> I gave you guidance how I think this should be done. I am not gating
> you
>>>> from this work. Your patch is not working on Microblaze arch which is
>>>> what I maintain. And I don't want to go the route that we will have two
>>>> drivers for the same IP without integration. We were there in past and
>>>> it is just pain.
>>>> I am expecting that PWM guys will guide how this should be done
>>>> properly. I haven't heard any guidance on this yet.
>>>> Thierry/Uwe: Any comment?
>>>
>>> Not sure I can and want to provide guidance here. This is not Perl, but
>>> still TIMTOWTDI. If it was me who cared here, I'd look into the
>>> auxiliary bus (Documentation/driver-api/auxiliary_bus.rst) to check if
>>> it can help to solve this problem.
>>
>> I recently got patches for cadence TTC driver
>> (drivers/clocksource/timer-cadence-ttc.c) for PWM support too. It is the
>> second and very similar case. This driver is used on Zynq as clock
>> source and can be also use as PWM. I can't believe that there are no
>> other examples how to deal with these timers which are used for PWM
>> generation.
>>
> 
> The approach I took in v4 is that probe functions and driver callbacks
> live in drivers/timer and drivers/pwm, and common functions live in
> drivers/mfd (although I may move them to drivers/timer since Lee Jones
> doesn't like them there).
> 
> I would greatly appreciate if you could review v4. It has been on the
> list for three weeks now with no comments from either you or Uwe.

I will take a look at it next week.

Thanks,
Michal

