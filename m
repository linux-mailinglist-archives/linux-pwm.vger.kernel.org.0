Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955C238F30E
	for <lists+linux-pwm@lfdr.de>; Mon, 24 May 2021 20:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbhEXSfw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 May 2021 14:35:52 -0400
Received: from mail-eopbgr80084.outbound.protection.outlook.com ([40.107.8.84]:63592
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232547AbhEXSfv (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 24 May 2021 14:35:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFRIzdDE+en+3h5SplAQ6sztMHZwub2SRto67DlKaWiG2UCel2uGxp77D6nQBejXyagYpIZRXe1p4+2rTmyFA/ml3hvCvARZpsItkuuOP0Wiep1BCLTjtrRNq/hcwzXH6p4s2Bzm+CCQR6X8g03Hhy9HDO6j+Q4pAAEoftPk0dvJs5wttKR0lSWEmJIjNBoTzmL4J0n4RBlCeI9/KbgLd5nEbZnBUB5Xv0bb1jQ6sTfc4spkKjDi+ph88L/KSKcT+91Tre0ssjiNO2P3HEMJq62yiggumiC7tpxqxJb+m7vQWvBdomPj+nZN7cLqGR9zS/tC3Q2tEK+tnbEWpR23yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFy/z+1f/N2Ay3c2RpPeBTlCUgHia47H/UGggHb951U=;
 b=JA73bUoEhJIyD5i06s0zqC17WOOVD+FgUjYpKEiODZE9dIM7ARPffWbGLcP0cTa0XgWxL6YLRTpXyMbD1rz7DtFXgpebnjUVgI3/ZoMnQMBN4iVUPV/tAvlSDqW1u/cniB+5Uxj4H07vDdw1cwmIG2LCJyXhhMpIvtTuY8w/o+ZDdlvU0LDWpe25WyPLF/k8QDI12WRTExT/RCFKFch1I26MM8d0YRogfm2U2PRl6X2kvUuEbScgwlIO0MpeI731AEkidoJAxBxeYepIUHgnbVa8twoimxe05H1WD8GMMfxeaoWQ9ZrdwWxvfksXhXL+81Jf9ubB36zsv1+Rdq2Yxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFy/z+1f/N2Ay3c2RpPeBTlCUgHia47H/UGggHb951U=;
 b=ucPV58VID8wilaBZ6WF4rIlBm24ZIjSi4Wd4k5W5JDQ8q1Tl8q3KCbFpqvYfNq4skT5qfmk2/QWEygDN0X3sItPv28ktvOp1TkHH9fzqPpVMMabHd9Ri6R0Iac0r7dVm6AfKkI0k9gdim7InjlImmgIo9uSmFpKj93zjQjokeMA=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB8PR03MB5675.eurprd03.prod.outlook.com (2603:10a6:10:10d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Mon, 24 May
 2021 18:34:19 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 18:34:18 +0000
Subject: Re: [PATCH v3 2/2] clocksource: Add support for Xilinx AXI Timer
To:     Michal Simek <michal.simek@xilinx.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20210511191239.774570-1-sean.anderson@seco.com>
 <20210511191239.774570-2-sean.anderson@seco.com>
 <d4bb7b5d-9f38-cf60-fb0b-18f8e0ca2b1e@xilinx.com>
 <5f960034-174d-0ed8-9f52-3d5fde90e16a@seco.com>
 <9f227f96-a310-0fbd-fd34-91eb386306b9@xilinx.com>
 <7a06cf46-0f85-1edb-ca08-abd7b2543ad9@seco.com>
 <41542760-3967-4f9a-0f0c-1206e03ff494@xilinx.com>
 <d206a399-454e-d9c5-e2d3-337d098ed7aa@seco.com>
 <2296d4e5-717a-0470-d487-e0924cf6c076@xilinx.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <ea2968fb-d77b-de66-155f-a76694d4d705@seco.com>
Date:   Mon, 24 May 2021 14:34:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <2296d4e5-717a-0470-d487-e0924cf6c076@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: BL0PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:207:3c::23) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL0PR02CA0010.namprd02.prod.outlook.com (2603:10b6:207:3c::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26 via Frontend Transport; Mon, 24 May 2021 18:34:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7871e930-bb9c-4b75-b996-08d91ee28a91
X-MS-TrafficTypeDiagnostic: DB8PR03MB5675:
X-Microsoft-Antispam-PRVS: <DB8PR03MB56757FC287A1BCA57DC8AA2296269@DB8PR03MB5675.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6IvB5MgTM7Cwf4e44QUIWU7x3TpWPUyMtF83+ab6tCgbSwYHVu4xvFRELP4nAQciAzFZs/sEuMq40VURvQ0d8yUwHAzrGnkwGfGJ0gfkY6N/BkesLQwo7JkrljkLOMcepUpXaVlKw08TbPj3jVgiaylesXlAwUzg9B6X5vbsePlvagP1urXOVSZfRn6qcIjP4HaE39JKIBiWZEYLj4EhFPYF8H+8/Efk1FT9YcTJ+utGe6BgaM8qphI9Je/DF5NfUmNyJdRA0bTNe77HgIsVBnHzey8KIijuR5YXH1SnVZtDJa6SSP2rxbzT+EZ5zKfYeQH8F1E0y5Uim3JiFiz5G3rx02PKZwRytsznOCJF1XKuce71fGryT1Pm6oYE3mRD7A2BwEp6dp7O+wXU5OPtc9WXHjqo6aj5TZbzJpdfFg9kvlQ88VNKdL8nhgCI7Z36w5AoDDzPs9/EZdX9uzaaINwL7Ptjimecoo9o5Ii0orA86+6dZ50qZMDQg3LSuH5+Du+VPRQ3eS8F5iNUqf4aCTcMKUP9ep+K30ry1sseoKC5oA0CNnNwoeU9V9+7F7TxhBZNt2AS7CZe05CPMGgz8X6hn7fAt/F5vs9p2/lMqZq2u36hPs/Z3faZIpbniVGFUiuUM6KBEkb4oPGgSc1nhOZXmvzqJZ4Q4GPAit9GgEiRlsBPX7JcsTHVcaXnYj/TudzVV+wH9a6OvBfpo2afizvb3JkQ9EW0mB9dGAXB87U1gTAPV6n7JwsAw4loMXGOpQKV3RRjttA2nNQqkWZYGXfnqTS8amEp77nR0QBnH4Vbpiof+q5i1taF5/EO9VuF/AmYUilbag9DpLelZckBWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(396003)(346002)(39840400004)(478600001)(26005)(31686004)(966005)(16526019)(4326008)(53546011)(2906002)(6486002)(6666004)(52116002)(44832011)(54906003)(956004)(316002)(8676002)(86362001)(8936002)(83380400001)(186003)(31696002)(66556008)(38100700002)(66946007)(5660300002)(7416002)(66476007)(2616005)(36756003)(110136005)(16576012)(38350700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UjUwbDVQMjllUzIwY2t4d0hxSGZCRFh5QnFHb2pBTUlNZWx1RjR5TEUyV283?=
 =?utf-8?B?RmovYXo2eERVdEgvelpNQ3NnZk1VZUxwY3lCSmwvK3dHVmtWUDFPTERDMnZ6?=
 =?utf-8?B?eWtlNTQ3THloZGg4c0hudmUyZkxHdG5DWEU1Z3RRK1daRExnb1VFa1R5OGNP?=
 =?utf-8?B?MUlWd2FwQ0luU1J3cFptQnJOVENSN2xrTGovRkdjZ3M4TmovdzJVOHEzR09G?=
 =?utf-8?B?bkhKTC96bmZxZ3ZYSnptWW1Ic3locUtidTNRNThFOUFDUCs4SDZpWWlieFpp?=
 =?utf-8?B?NzNabVhvZGd3cGxKcjdoZ1Z6UHBZMURiNjZoUU1ka3RNT0diT0UwSWZDa0pZ?=
 =?utf-8?B?aTNFQ05vaWQrU0xpOWgyVUlHQzdGeXdUakNMYTlROHl5VmxDWkY4SFFYQUtZ?=
 =?utf-8?B?RUQ3MWdtK1FBUHczNVc0VW9qcXhiL2c5RGYrdklRck9kcFY2MnNYcFdtRExL?=
 =?utf-8?B?cUNRbGI4eWZ0Y25ZZmpCRm0rc3IramRFOGlZckR0bDF1d3RxUHFOd0p3Vjc0?=
 =?utf-8?B?SlJISlVNR1M3ME52NzFoaEVWZXpYSGJVUkF5VmtYdGtyU1VkRzlVM3ErS215?=
 =?utf-8?B?bTdQS0w3UkZ3WXhtTEZEMzJHSjFSc1lDTkEyaGZZVHl1OXJCTEU2ZkVTNyt4?=
 =?utf-8?B?YWErYWo2R3Vab2lBOXk4dHViemhKYkl3am1id05SbzVNeGp0aFVrVzVqeTJv?=
 =?utf-8?B?OHFiSzdYTldualcvZ0JwY3l2K1hXWXpmKzh0RDRXVW44ZnpJK1pDa0FLNWhP?=
 =?utf-8?B?anEyajhIK3ZPK2xOQVNIa1c1TkVJTHo3ZWxPbVo5b3ZKdm4rakpINHVINTl3?=
 =?utf-8?B?UHoxMWRFTVdUNmt0TUhGTVJoazJhUm1uZmhFQ2NYZUZ0UGJlVFdFMWpwanZ1?=
 =?utf-8?B?RVRxYk1PcC92aUFzaDNKUU9IRlJOM0FSZmR4d04wQXNXUGZvS1duUE5TTmo0?=
 =?utf-8?B?TjVlUCt3a2k1QTg3bkUzTzZSeXErYWQrS2VXeFYrVzVxV0NmWHgyZk4rK3VQ?=
 =?utf-8?B?R2FCcVJiQWlFanVNcnFPN2FjK2NBRjdYMnVBR3ZXMy8yUEZ3aFhZNHBoR29M?=
 =?utf-8?B?a1ovTm1PUHhVSXV0UU15bmVzRXIycDJxdFRiTjhTRXlFOUo0V2F2S0t5Mkpv?=
 =?utf-8?B?OGllQ0ZMQmQ5SHJod1drUGIybWRyd25MR2pnektTd3lWSDhDZWE3ZU1OcVBo?=
 =?utf-8?B?SUpBRkhmQVBWOE9HTFdmOTRzQXFCYVlmZHdtMkR6eTM5YUVPbDlHdWhrWXBz?=
 =?utf-8?B?NU5MUmRPZ1oxanU3YzRhN2RNUSs1bGFMQjg1Q2NsSnQvUlJDUGdpbmRLdDlE?=
 =?utf-8?B?Q2pkUk94VmQvRlZnMWZybFJFYTVMUW9wSkhKQkpCbUFZdUVMRTN5NFNkWkhT?=
 =?utf-8?B?TWk2VGhJL01nTmgzckVjNjcvRERMUFRMcG53T25TZDZuQ0J0WFZIUVp6NnUr?=
 =?utf-8?B?SjEwRE1vcmtNSkdjN2JDN0tYYitLWUxRUzNWOFhuUXhPVVVSSmo4ZmlUcWRE?=
 =?utf-8?B?WjJwMzEyaWZFYWgwc1NsN25LU25iZ09rREFSdDFVRnJxck1TODRJa3VuY3Bq?=
 =?utf-8?B?ZGtpZUwwM1NFM3JsZWFMNXZVZ1kzRzRzMnI2aFVMeXh1eUwxeDhvVlZoQ1lK?=
 =?utf-8?B?blViQzl5b1VtRzRISjVlUWRtb3VFZkVNMDIxaTBzUXhtU29NeWVRbG1ZTjIz?=
 =?utf-8?B?Rjk1OTBFUzFma0x3RUFpeXpuaVZyMkpBNmhWem56dTRtK1U5UE1PTnFzblhl?=
 =?utf-8?Q?M9yH5RQ9XAu0Xke3I83RFagb71yOQSy13EPgdBe?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7871e930-bb9c-4b75-b996-08d91ee28a91
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2021 18:34:18.6963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6wDbey0GtW0CPud3EOSoxvDax5zw+nFAqDEdyEHinAyEy7kkPZ47lUgaLC3M8zlVp0jebtFIpG+o6Ec4S2ZBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB5675
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/24/21 3:00 AM, Michal Simek wrote:
 >
 >
 > On 5/20/21 10:13 PM, Sean Anderson wrote:
 >>
 >>
 >> On 5/19/21 3:24 AM, Michal Simek wrote:
 >>>
 >>>
 >>> On 5/18/21 12:15 AM, Sean Anderson wrote:
 >>>>
 >>>>
 >>>> On 5/17/21 3:54 AM, Michal Simek wrote:
 >>>>>
 >>>>>
 >>>>> On 5/14/21 4:40 PM, Sean Anderson wrote:
 >>>>>>
 >>>>>>
 >>>>>> On 5/14/21 4:59 AM, Michal Simek wrote:
 >>>>>>>
 >>>>>>>
 >>>>>>> On 5/11/21 9:12 PM, Sean Anderson wrote:
 >>>>>>>> This adds generic clocksource and clockevent support for Xilinx
 >>>>>> LogiCORE IP
 >>>>>>>> AXI soft timers commonly found on Xilinx FPGAs. This timer is
 >> also the
 >>>>>>>> primary timer for Microblaze processors. This commit also adds
 >>>>>> support for
 >>>>>>>> configuring this timer as a PWM (though this could be split off if
 >>>>>>>> necessary). This whole driver lives in clocksource because it is
 >>>>>> primarily
 >>>>>>>> clocksource stuff now (even though it started out as a PWM
 >> driver). I
 >>>>>> think
 >>>>>>>> teasing apart the driver would not be worth it since they share so
 >>>> many
 >>>>>>>> functions.
 >>>>>>>>
 >>>>>>>> This driver configures timer 0 (which is always present) as a
 >>>>>> clocksource,
 >>>>>>>> and timer 1 (which might be missing) as a clockevent. I don't
 >> know if
 >>>>>> this
 >>>>>>>> is the correct priority for these timers, or whether we should be
 >>>>>> using a
 >>>>>>>> more dynamic allocation scheme.
 >>>>>>>>
 >>>>>>>> At the moment clock control is very basic: we just enable the clock
 >>>>>> during
 >>>>>>>> probe and pin the frequency. In the future, someone could add
 >> support
 >>>>>> for
 >>>>>>>> disabling the clock when not in use. Cascade mode is also
 >> unsupported.
 >>>>>>>>
 >>>>>>>> This driver was written with reference to Xilinx DS764 for v1.03.a
 >>>> [1].
 >>>>>>>>
 >>>>>>>> [1]
 >>>>>>
 >>>>
 >> https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
 >>
 >>>>
 >>>>>>
 >>>>>>>>
 >>>>>>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
 >>>>>>>> ---
 >>>>>>>> Please let me know if I should organize this differently or if it
 >>>> should
 >>>>>>>> be broken up.
 >>>>>>>>
 >>>>>>>> Changes in v3:
 >>>>>>>> - Add clockevent and clocksource support
 >>>>>>>> - Rewrite probe to only use a device_node, since timers may need
 >> to be
 >>>>>>>>          initialized before we have proper devices. This does bloat
 >> the
 >>>>>> code a bit
 >>>>>>>>          since we can no longer rely on helpers such as dev_err_probe.
 >>>> We also
 >>>>>>>>          cannot rely on device resources being free'd on failure,
 >> so we
 >>>>>> must free
 >>>>>>>>          them manually.
 >>>>>>>> - We now access registers through xilinx_timer_(read|write). This
 >>>>>> allows us
 >>>>>>>>          to deal with endianness issues, as originally seen in the
 >>>> microblaze
 >>>>>>>>          driver. CAVEAT EMPTOR: I have not tested this on big-endian!
 >>>>>>>> - Remove old microblaze driver
 >>>>>>>>
 >>>>>>>> Changes in v2:
 >>>>>>>> - Don't compile this module by default for arm64
 >>>>>>>> - Add dependencies on COMMON_CLK and HAS_IOMEM
 >>>>>>>> - Add comment explaining why we depend on !MICROBLAZE
 >>>>>>>> - Add comment describing device
 >>>>>>>> - Rename TCSR_(SET|CLEAR) to TCSR_RUN_(SET|CLEAR)
 >>>>>>>> - Use NSEC_TO_SEC instead of defining our own
 >>>>>>>> - Use TCSR_RUN_MASK to check if the PWM is enabled, as suggested by
 >>>> Uwe
 >>>>>>>> - Cast dividends to u64 to avoid overflow
 >>>>>>>> - Check for over- and underflow when calculating TLR
 >>>>>>>> - Set xilinx_pwm_ops.owner
 >>>>>>>> - Don't set pwmchip.base to -1
 >>>>>>>> - Check range of xlnx,count-width
 >>>>>>>> - Ensure the clock is always running when the pwm is registered
 >>>>>>>> - Remove debugfs file :l
 >>>>>>>> - Report errors with dev_error_probe
 >>>>>>>>
 >>>>>>>>         arch/microblaze/kernel/Makefile    |   2 +-
 >>>>>>>>         arch/microblaze/kernel/timer.c     | 326 ---------------
 >>>>>>>>         drivers/clocksource/Kconfig        |  15 +
 >>>>>>>>         drivers/clocksource/Makefile       |   1 +
 >>>>>>>>         drivers/clocksource/timer-xilinx.c | 650
 >>>> +++++++++++++++++++++++++++++
 >>>>>>>>         5 files changed, 667 insertions(+), 327 deletions(-)
 >>>>>>>>         delete mode 100644 arch/microblaze/kernel/timer.c
 >>>>>>>>         create mode 100644 drivers/clocksource/timer-xilinx.c
 >>>>>>>
 >>>>>>> I don't think this is the right way to go.
 >>>>>>> The first patch should be move current timer driver from
 >> microblaze to
 >>>>>>> generic location and then apply patches on the top based on what you
 >>>> are
 >>>>>>> adding/fixing to be able to review every change separately.
 >>>>>>> When any issue happens it can be bisected and exact patch is
 >>>> identified.
 >>>>>>> With this way we will end up in this patch and it will take a lot of
 >>>>>>> time to find where that problem is.
 >>>>>>
 >>>>>> What parts would you like to see split? Fundamentally, this current
 >>>>>> patch is a reimplementation of the driver. I think the only reasonable
 >>>>>> split would be to add PWM support in a separate patch.
 >>>>>>
 >>>>>> I do not think that genericizing the microblaze timer driver is an
 >>>>>> integral part of adding PWM support. This is especially since you seem
 >>>>>> opposed to using existing devicetree properties to inform the
 >> driver. I
 >>>>>> am inclined to just add a patch adding a check for '#-pwm-cells' to
 >> the
 >>>>>> existing driver and otherwise leave it untouched.
 >>>>>
 >>>>> As I said I think the patches should be like this.
 >>>>> 1. Cover existing DT binding based on current code.
 >>>>> 2. Move time out of arch/microblaze to drivers/clocksource/ and even
 >>>>> enable it via Kconfig just for Microblaze.
 >>>>> 3. Remove dependency on Microblaze and enable build for others. I have
 >>>>> seen at least one cpuinfo.cpu_clock_freq assignment. This code can be
 >>>>> likely completely removed or deprecate.
 >>>>
 >>>> This could be deprecated, but cannot be removed since existing device
 >>>> trees (e.g. qemu) have neither clocks nor clock-frequency properties.
 >>>
 >>> Rob: Do we have any obligation to keep properties for other projects?
 >>>
 >>>
 >>>>> 4. Make driver as module
 >>>>> 5. Do whatever changes you want before adding pwm support
 >>>>> 6. Extend DT binding doc for PWM support
 >>>>> 7. Add PWM support
 >>>>
 >>>> Frankly, I am inclined to just leave the microblaze timer as-is. The PWM
 >>>> driver is completely independent. I have already put too much effort
 >> into
 >>>> this driver, and I don't have the energy to continue working on the
 >>>> microblaze timer.
 >>>
 >>> I understand. I am actually using axi timer as pwm driver in one of my
 >>> project but never had time to upstream it because of couple of steps
 >> above.
 >>> We need to do it right based on steps listed above. If this is too much
 >>> work it will have to wait. I will NACK all attempts to add separate
 >>> driver for IP which we already support in the tree.
 >>
 >> 1. Many timers have separate clocksource and PWM drivers. E.g. samsung,
 >>     renesas TPU, etc. It is completely reasonable to keep separate
 >>     drivers for these purposes. There is no Linux requirement that each
 >>     device have only one driver, especially if it has multiple functions
 >>     or ways to be configured.
 >
 > It doesn't mean that it was done properly and correctly. Code
 > duplication is bad all the time.

IMO after doing all this there is not too much which can be reused. We
can reuse the read/write functions, the TLR calculations and the
processing of xlnx,counter-width and xlnx,one-timer. The timer probe is
likely much more cleanly implemented with timer_of_init. And not having
a platform device greatly complicates the PWM probe.

 >
 >> 2. If you want to do work on a driver, I'm all for it. However, if you
 >>     have not yet submitted that work to the list, you should not gate
 >>     other work behind it. Saying that X feature must be gated behind Y
 >>     *even if X works completely independently of Y* is just stifling
 >>     development.
 >
 > I gave you guidance how I think this should be done. I am not gating you
 > from this work. Your patch is not working on Microblaze arch which is
 > what I maintain.

I tested this on Microblaze qemu. What problems do you see?

--Sean

 > And I don't want to go the route that we will have two
 > drivers for the same IP without integration. We were there in past and
 > it is just pain.
 > I am expecting that PWM guys will guide how this should be done
 > properly. I haven't heard any guidance on this yet.
 > Thierry/Uwe: Any comment?
 >
 >
 >> 3. There is a clear desire for a PWM driver for this device. You, I, and
 >>     Alvaro have all written separate drivers for this device because we
 >>     want to use it as a PWM. By preventing merging this driver, you are
 >>     encouraging duplicate effort by the next person who wants to use this
 >>     device as a PWM, and sees that there is no driver in the tree.
 >
 > We should do it cleanly that it will be easy to maintain which is not by
 > creating two separate drivers or by switching to completely new driver.
 >
 > Thanks,
 > Michal
 >
