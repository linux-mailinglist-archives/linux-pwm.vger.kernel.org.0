Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C154322ED
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Oct 2021 17:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbhJRPe4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Oct 2021 11:34:56 -0400
Received: from mail-eopbgr60065.outbound.protection.outlook.com ([40.107.6.65]:21731
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231946AbhJRPe4 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 18 Oct 2021 11:34:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/EO/1EHYHpqMN6Z8+BSnEKwm4TYgM6fGGUufhFxGA+GbsCelnJi5wBnZsSlxsPF6MfzEOkC0MYdVyvnc/VpPZGkvDM7RcumT9p/ckwfPYgKb2Id9RNvodYDaJb+przZ3zjk4q5MFSA2OJXaiUMGO5916xJq9kg1LVZoy48sVbxk1C4h/lZz7Km7UTmNytt1628orhNaANCCwFS9TJdo2e4JWJIQua5kBuxFZoNoBOXJJksLJhMqJV8vfYPlv9Dr0uj3Lc/J3FJw5+bo+b+Gt56iGyalIsFiDp/GkwceUKq7vayDHtHlcEqELIzgkuuw2Fx6gkWjcrAnhST0i1q09A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrLqZ/yQ1j5NHmDMwiI8AZRFhkMJDsCGm3+dhi5yXzc=;
 b=U/FWVzAz2RJq/V4Pfv71LpTmywpDvKDtdb7Un9LHaCKVCp3yLnUQQjcOp/O9JRpUGZUf8+iIBo3/RuX1sNSr9Mtzes+30ym6Y3TWX3Lut0ocFbA5fEV9W4C+1N+rV9FChei+6plJu+aBOFDRE2CY0URJhhG6gDRbjU60+hk4++bauoJb4yy/7VxmFEihd9Q+vEmqVolPMYGpW304SYiRkaOTyd6szhbNg1892X/yy8qrRU31l/KhRVA6A4igA9AmkeEr9iui7RHLEhSnfaCME0IQMo92WusEAzQA842MCyoJCP/f0mxg5if/FcD8oQ7ZA2orS0tif8AemBtNfAl/rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrLqZ/yQ1j5NHmDMwiI8AZRFhkMJDsCGm3+dhi5yXzc=;
 b=dZIYORpYtwMIMn0FlJEp1tWveEvNQ8xzk85hNJW3X93k9PHFP32GKwgnomxuLDp94fnkr3EYRDFrWjMVr/n5M6veD2absqkKZyi1aYV0QtUgrl4Kll2Lvv9DvKVWTxEc2a8x/Rct0mf0y1zIZq5mPZrX4BVVVerBZds+9ZuGrUM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB9PR03MB7434.eurprd03.prod.outlook.com (2603:10a6:10:22c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Mon, 18 Oct
 2021 15:32:42 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 15:32:42 +0000
Subject: Re: [PATCH v8 3/3] pwm: Add support for Xilinx AXI Timer
To:     Michal Simek <michal.simek@xilinx.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-kernel@vger.kernel.org
References: <20211015190025.409426-1-sean.anderson@seco.com>
 <20211015190025.409426-3-sean.anderson@seco.com>
 <3303baa4-e3ea-2009-2122-0abff30e25c5@xilinx.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <653f7615-4fc3-8d0d-125c-c09260d30d12@seco.com>
Date:   Mon, 18 Oct 2021 11:32:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <3303baa4-e3ea-2009-2122-0abff30e25c5@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:208:23a::7) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
Received: from [172.27.1.65] (50.195.82.171) by MN2PR03CA0002.namprd03.prod.outlook.com (2603:10b6:208:23a::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 15:32:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af8a3419-0c14-475a-359c-08d9924c8672
X-MS-TrafficTypeDiagnostic: DB9PR03MB7434:
X-Microsoft-Antispam-PRVS: <DB9PR03MB74349A48D0076EBD070BC9FA96BC9@DB9PR03MB7434.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Napefq0dvdaef0oIkoMIUxJPDp+fqm5kGUXslWKF3hvKi/VpmDeQRuBEeQBnbHmCx3Hzq5qqg0FIsSY0YiJ+lakctVe1xfGAiWIjxuZYxUYuPUi4mTbaQ+kuwLz8ZlrOwv0w2uIIytTIsit4NhHQDM2yv5mEKZiYfIzKqFpqZEw0T7pYneVwrlmjLuJ+StknPUX0omd4oQFWiXcmxc7sxyqKeMEeuvo6dK/lzTGPjxNhUxoU0UATjxEoSn7kF8H0vQ1GH10gBkyrfz5bUZMHgrEcIIBTr/0opDSpQwNklNkcbB5eXNQ0T9QjjPVnjfRVlOF6RuFjZOpgLhXG5FDH3xs5uA/pfn1oj6rC9Cgy3/yXD1sjtTMY6J2M4oLSCuzNBFi73r0eIazntuOyCO8m84SpRZQEzF04i77yhMbwAyt348OQ5vt9GweSu87HHNYeR+sUteFcKkP01R6JlOY9/qt2QPUXuSKo6HdnF5wR/WcapSZEPrq0d6MKvJ6c9THNUu/TDeV3mV2JCAJJCr3EQKCJZd3BUi5Vs0iQ4KicsCe3QIWiFzvTYQfCPre2dSaorVw9RJ22RsHb1h/Us3bYC1QDkNS/68sSO5JsfJ1dQ3EF5bFHfCUVekyUQ2TAF8KHNDlQ9mM1XybyzFk05vuWKTPm37OIiP1JsKK1Rx+WkkzEbf6LAeGUHj2UdYy9+gOXr2UIpyytvGI9h/9xraHXU+NvEyEV++HU2g1HRynWxNI1icpMZ59LeICmB+/hhInvqAHiE1p+bUHeka0wBN3WsAnmv/UMfJDdIxIaSJa5QPnTD21YWyIEECD1ko6gx48Zy19MMhe18b0219nmc1sIQNiFGKRuW31EzHZlgftl0gs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(4326008)(8936002)(38100700002)(38350700002)(966005)(8676002)(52116002)(16576012)(5660300002)(186003)(86362001)(36756003)(66556008)(6486002)(316002)(6666004)(31696002)(66946007)(26005)(53546011)(66476007)(2616005)(956004)(110136005)(54906003)(30864003)(508600001)(31686004)(44832011)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFRhNysvR3JUbFZsclRZdFB3SWc4Qy96b2c2akJwd3YwOUJIQlc2enJMTXdm?=
 =?utf-8?B?bEdnUzNFMmk2QzhUbWJDYjg0aFl6eHJPZk5CRmZtVlhlN0psaW5uZDVKaGZD?=
 =?utf-8?B?OVJzR2ZiRzkzVnZxQUhZNHF3YUhZc0x2c0JoU2Nxb2VCQUNhbVlRa3ExOHpn?=
 =?utf-8?B?RlhiZEpjYW5HSlVnZE93OTlpOGt6SmRlSThob2lVdDZGUHhJNTVqYzRmY3ZJ?=
 =?utf-8?B?U1FlWGhtbmY5RUVVUVZHVUZYSGs2aklWQTkzSFlKY3duamZ6em5WWG9kd0I5?=
 =?utf-8?B?VHdZbzZVS1RTYUg5NHUxbkI4YmdxekltTE9rYjFoSFR2SjFub1p2NVhtZDNy?=
 =?utf-8?B?RzJCVCt1NCtlZXZtcjBLOFhCTnAvamNmOG1yZDBjbkZCY1lubGVyR3c0N0lV?=
 =?utf-8?B?WnlHa0ZYQysxdDlRMlVjblVhS05pb2x0T0dsVElYMU1IbG13aFlDQm1CQUJ1?=
 =?utf-8?B?M2Q2T2VPdGJDK0JqcVFpMGZMVFBwY2ZLVU9sV0dXdUhFVG1TclJCeFN0T1dS?=
 =?utf-8?B?a0llSFFXRVY5bkVTVE9iMG1VNkptaHM4MHVGQmR4WGVsUVlqY09yOWp2enZC?=
 =?utf-8?B?MGlsQTltZlB1WGZXOGdoNkxyeTQ3MWFFdnBkKzdUbndqSnkxVVFTODJjU1kw?=
 =?utf-8?B?R1FSQWNiTHd6Q0Q5K0k2eHN3ZzBOVlNtajFsU0p3UnB1MFJXWTlYTTZ3cVdt?=
 =?utf-8?B?blZnaHZ0Y0xuM2xWalNKKzNkTVZCdzVHcWg2M3Z5NC9VZXJNeGoxZ2l1QTA5?=
 =?utf-8?B?cVZzTTNteUVNditNVWNFelgrcm0wdndJREh1VURITnZRYXQzU3JUL0drYlpr?=
 =?utf-8?B?b2p2QVQxdFhsaFp6b2t6UDFjNktmNEJqbWt4V3lqaExOMWJWOHJoSy9XTkIv?=
 =?utf-8?B?bEhxM3o2bGxJMG9NMm9ZWmtQSWN6R2V3Tlozei90eWE4WTdwWlZ2Rk5Uc2oy?=
 =?utf-8?B?RitUSkFyelZPSE1VdWNpcFU1Rm9wbzR1Q3BVR3BkZUtBS1lBTnduZmQvamww?=
 =?utf-8?B?MDVGVUM5bjRyUkJvSjR4bm9GM2pweWI4Ui8vUjBnSllIdFFQdFVCbUJuTTFv?=
 =?utf-8?B?Z0paeTFLMG9aQ01FTS90bUtQSjVMdGZnUW1Tdng4eHNnOEF5cUxDN1VCV2c1?=
 =?utf-8?B?d2VoOXpEKzVKSTJOS1RqS0lxQkFzaWxjRFZ2NHJKOTIvdHltVlhRMlJhWFZB?=
 =?utf-8?B?YXJMeWZkSXBnRDJRWnhmTllSbTJFL09xTW5EVC9pckc5Zmp1Q0YyYmY1UDI0?=
 =?utf-8?B?UmRhSTVUQTFrRk9YdkdMNjNjOGdJeXZYVVNOaGxJTXBkcUlCMFBBbWpFM3JF?=
 =?utf-8?B?Z0ZYcjY5bkFHSzZ3S2ZONklDTkVWZ2R1L0xnQjlVRFNJM2NHc0pVb0lPRVlX?=
 =?utf-8?B?RUhEQjdvQ1ZaV0xpbTNYTEdlamtaM3NDM3NYUmd3Mnp2eE1nU0IyTU04WTVX?=
 =?utf-8?B?MFdFcEY3OGVoalZXVjFUb3FxUHpvYjE0N2RtaitRcExsWUE2MnB5eWYrbFVZ?=
 =?utf-8?B?ZUVwNGtid1NBTmlicTFIZVRlUDlLUDhRL3VHaUgvYUhmdHNOb2VReDJxeFNV?=
 =?utf-8?B?Q2U0OTAxY2prQllKMFZwNE03cmM3bFNPeUltMyt6Q3QwYi9KanB3emJ4TUFw?=
 =?utf-8?B?VFBlclNDTGo2ZlNnU3ZrUW15NHlhc01wUEN0bk02aHVsRHlmTWNIZnMxcTlK?=
 =?utf-8?B?TFpMZ2N2SE52anR0eVNJaXpublg0cDJ3cWttUmpMS1NxL3IvZGMzZWZ1Mjd2?=
 =?utf-8?Q?R8lgfaePGJuNfQBv2WNPJz+40HzJ5pQm1RSttX0?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af8a3419-0c14-475a-359c-08d9924c8672
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 15:32:42.3035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjoxRP9xpkwuGPPkAlzWxmOubyRzd2Pcbr/fy14D9em43td/HFj0jWzpm497KvlI8rOUrNA0Z0NYCUYs3JC5Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7434
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 10/18/21 8:23 AM, Michal Simek wrote:
> 
> 
> On 10/15/21 21:00, Sean Anderson wrote:
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
>>    debugfs
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
>>    some don't.
>> - Put common timer properties into their own struct to better reuse
>>    code.
>> - Remove references to properties which are not good enough for Linux.
>>
>> Changes in v3:
>> - Add clockevent and clocksource support
>> - Remove old microblaze driver
>> - Rewrite probe to only use a device_node, since timers may need to be
>>    initialized before we have proper devices. This does bloat the code a bit
>>    since we can no longer rely on helpers such as dev_err_probe. We also
>>    cannot rely on device resources being free'd on failure, so we must free
>>    them manually.
>> - We now access registers through xilinx_timer_(read|write). This allows us
>>    to deal with endianness issues, as originally seen in the microblaze
>>    driver. CAVEAT EMPTOR: I have not tested this on big-endian!
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
>>   MAINTAINERS                        |   7 +
>>   arch/microblaze/kernel/timer.c     |   3 +
>>   drivers/pwm/Kconfig                |  14 ++
>>   drivers/pwm/Makefile               |   1 +
>>   drivers/pwm/pwm-xilinx.c           | 329 +++++++++++++++++++++++++++++
>>   include/clocksource/timer-xilinx.h |  91 ++++++++
>>   6 files changed, 445 insertions(+)
>>   create mode 100644 drivers/pwm/pwm-xilinx.c
>>   create mode 100644 include/clocksource/timer-xilinx.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6b6f98483deb..bed034ef46ad 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -20601,6 +20601,13 @@ F:    drivers/misc/Makefile
>>   F:    drivers/misc/xilinx_sdfec.c
>>   F:    include/uapi/misc/xilinx_sdfec.h
>> +XILINX PWM DRIVER
>> +M:    Sean Anderson <sean.anderson@seco.com>
>> +S:    Maintained
>> +F:    drivers/clocksource/timer-xilinx-common.c
>> +F:    drivers/pwm/pwm-xilinx.c
>> +F:    include/clocksource/timer-xilinx.h
>> +
>>   XILINX UARTLITE SERIAL DRIVER
>>   M:    Peter Korsgaard <jacmet@sunsite.dk>
>>   L:    linux-serial@vger.kernel.org
>> diff --git a/arch/microblaze/kernel/timer.c b/arch/microblaze/kernel/timer.c
>> index f8832cf49384..20e2669b533d 100644
>> --- a/arch/microblaze/kernel/timer.c
>> +++ b/arch/microblaze/kernel/timer.c
>> @@ -251,6 +251,9 @@ static int __init xilinx_timer_init(struct device_node *timer)
>>       u32 timer_num = 1;
>>       int ret;
>> +    if (of_property_read_bool(np, "#pwm-cells"))
>> +        return 0;
>> +
>>       if (initialized)
>>           return -EINVAL;
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index aa29841bbb79..47f25237754f 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -638,4 +638,18 @@ config PWM_VT8500
>>         To compile this driver as a module, choose M here: the module
>>         will be called pwm-vt8500.
>> +config PWM_XILINX
>> +    tristate "Xilinx AXI Timer PWM support"
>> +    depends on OF_ADDRESS
>> +    depends on COMMON_CLK
>> +    select REGMAP_MMIO
>> +    help
>> +      PWM driver for Xilinx LogiCORE IP AXI timers. This timer is
>> +      typically a soft core which may be present in Xilinx FPGAs.
>> +      This device may also be present in Microblaze soft processors.
>> +      If you don't have this IP in your design, choose N.
>> +
>> +      To compile this driver as a module, choose M here: the module
>> +      will be called pwm-xilinx.
>> +
>>   endif
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index 708840b7fba8..ea785480359b 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -60,3 +60,4 @@ obj-$(CONFIG_PWM_TWL)        += pwm-twl.o
>>   obj-$(CONFIG_PWM_TWL_LED)    += pwm-twl-led.o
>>   obj-$(CONFIG_PWM_VISCONTI)    += pwm-visconti.o
>>   obj-$(CONFIG_PWM_VT8500)    += pwm-vt8500.o
>> +obj-$(CONFIG_PWM_XILINX)    += pwm-xilinx.o
>> diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
>> new file mode 100644
>> index 000000000000..c532be6c7912
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-xilinx.c
>> @@ -0,0 +1,329 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
>> + *
>> + * Limitations:
>> + * - When changing both duty cycle and period, we may end up with one cycle
>> + *   with the old duty cycle and the new period. This is because the counters
>> + *   may only be reloaded by first stopping them, or by letting them be
>> + *   automatically reloaded at the end of a cycle. If this automatic reload
>> + *   happens after we set TLR0 but before we set TLR1 then we will have a
>> + *   bad cycle. This could probably be fixed by reading TCR0 just before
>> + *   reprogramming, but I think it would add complexity for little gain.
>> + * - Cannot produce 100% duty cycle by configuring the TLRs. This might be
>> + *   possible by stopping the counters at an appropriate point in the cycle,
>> + *   but this is not (yet) implemented.
>> + * - Only produces "normal" output.
>> + * - Always produces low output if disabled.
>> + */
>> +
>> +#include <clocksource/timer-xilinx.h>
>> +#include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/device.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pwm.h>
>> +#include <linux/regmap.h>
>> +
>> +/*
>> + * The following functions are "common" to drivers for this device, and may be
>> + * exported at a future date.
>> + */
>> +u32 xilinx_timer_tlr_cycles(struct xilinx_timer_priv *priv, u32 tcsr,
>> +                u64 cycles)
>> +{
>> +    WARN_ON(cycles < 2 || cycles - 2 > priv->max);
>> +
>> +    if (tcsr & TCSR_UDT)
>> +        return cycles - 2;
>> +    else
> 
> 
> you don't need else here.

OK

>> +        return priv->max - cycles + 2;
>> +}
>> +
>> +unsigned int xilinx_timer_get_period(struct xilinx_timer_priv *priv,
>> +                     u32 tlr, u32 tcsr)
>> +{
>> +    u64 cycles;
>> +
>> +    if (tcsr & TCSR_UDT)
>> +        cycles = tlr + 2;
>> +    else
>> +        cycles = (u64)priv->max - tlr + 2;
>> +
>> +    /* cycles has a max of 2^32 + 2 */
>> +    return DIV64_U64_ROUND_CLOSEST(cycles * NSEC_PER_SEC,
>> +                       clk_get_rate(priv->clk));
>> +}
>> +
>> +int xilinx_timer_common_init(struct device_node *np,
>> +                 struct xilinx_timer_priv *priv,
>> +                 u32 *one_timer)
>> +{
>> +    int ret;
>> +    u32 width;
>> +
>> +    ret = of_property_read_u32(np, "xlnx,one-timer-only", one_timer);
>> +    if (ret) {
>> +        pr_err("%pOF: err %d: xlnx,one-timer-only\n", np, ret);
>> +        return ret;
>> +    } else if (*one_timer && *one_timer != 1) {
> 
> you can also remove this else.
> 
> 
>> +        pr_err("%pOF: xlnx,one-timer-only must be 0 or 1\n", np);
> 
> Isn't it better to check direct value you need?
> If you have 1 here you will fail in probe anyway that's why there is no reason to continue in property reading.

This was one of the "common" functions designed for reuse by both the pwm an timer drivers.
If you like, I can remove this functionality.

>> +        return -EINVAL;
>> +    }
>> +
>> +    ret = of_property_read_u32(np, "xlnx,count-width", &width);
>> +    if (ret == -EINVAL) {
>> +        width = 32;
>> +    } else if (ret) {
>> +        pr_err("%pOF: err %d: xlnx,count-width\n", np, ret);
>> +        return ret;
>> +    } else if (width < 8 || width > 32) {
>> +        pr_err("%pOF: invalid counter width\n", np);
>> +        return -EINVAL;
>> +    }
>> +    priv->max = BIT_ULL(width) - 1;
>> +
>> +    return 0;
>> +}
>> +
>> +/*
>> + * The idea here is to capture whether the PWM is actually running (e.g.
>> + * because we or the bootloader set it up) and we need to be careful to ensure
>> + * we don't cause a glitch. According to the data sheet, to enable the PWM we
>> + * need to
>> + *
>> + * - Set both timers to generate mode (MDT=1)
>> + * - Set both timers to PWM mode (PWMA=1)
>> + * - Enable the generate out signals (GENT=1)
>> + *
>> + * In addition,
>> + *
>> + * - The timer must be running (ENT=1)
>> + * - The timer must auto-reload TLR into TCR (ARHT=1)
>> + * - We must not be in the process of loading TLR into TCR (LOAD=0)
>> + * - Cascade mode must be disabled (CASC=0)
>> + *
>> + * If any of these differ from usual, then the PWM is either disabled, or is
>> + * running in a mode that this driver does not support.
>> + */
>> +#define TCSR_PWM_SET (TCSR_GENT | TCSR_ARHT | TCSR_ENT | TCSR_PWMA)
>> +#define TCSR_PWM_CLEAR (TCSR_MDT | TCSR_LOAD)
>> +#define TCSR_PWM_MASK (TCSR_PWM_SET | TCSR_PWM_CLEAR)
>> +
>> +struct xilinx_pwm_device {
>> +    struct pwm_chip chip;
>> +    struct xilinx_timer_priv priv;
>> +};
>> +
>> +static inline struct xilinx_timer_priv
>> +*xilinx_pwm_chip_to_priv(struct pwm_chip *chip)
>> +{
>> +    return &container_of(chip, struct xilinx_pwm_device, chip)->priv;
>> +}
>> +
>> +static bool xilinx_timer_pwm_enabled(u32 tcsr0, u32 tcsr1)
>> +{
>> +    return ((TCSR_PWM_MASK | TCSR_CASC) & tcsr0) == TCSR_PWM_SET &&
>> +        (TCSR_PWM_MASK & tcsr1) == TCSR_PWM_SET;
>> +}
>> +
>> +static int xilinx_pwm_apply(struct pwm_chip *chip, struct pwm_device *unused,
>> +                const struct pwm_state *state)
>> +{
>> +    struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
>> +    u32 tlr0, tlr1, tcsr0, tcsr1;
>> +    u64 period_cycles, duty_cycles;
>> +    unsigned long rate;
>> +
>> +    if (state->polarity != PWM_POLARITY_NORMAL)
>> +        return -EINVAL;
>> +
>> +    /*
>> +     * To be representable by TLR, cycles must be between 2 and
>> +     * priv->max + 2. To enforce this we can reduce the duty
>> +     * cycle, but we may not increase it.
>> +     */
>> +    rate = clk_get_rate(priv->clk);
>> +    /* Prevent overflow by clamping to the worst case of rate */
>> +    period_cycles = min_t(u64, state->period, ULONG_MAX * NSEC_PER_SEC);
>> +    period_cycles = mul_u64_u32_div(period_cycles, rate, NSEC_PER_SEC);
>> +    if (period_cycles < 2 || period_cycles - 2 > priv->max)
>> +        return -ERANGE;
>> +    duty_cycles = mul_u64_u32_div(state->duty_cycle, rate, NSEC_PER_SEC);
>> +
>> +    /*
>> +     * If we specify 100% duty cycle, we will get 0% instead, so decrease
>> +     * the duty cycle count by one.
>> +     */
>> +    if (period_cycles == duty_cycles)
>> +        duty_cycles--;
>> +
>> +    /* Round down to 0% duty cycle for unrepresentable duty cycles */
>> +    if (duty_cycles < 2)
>> +        duty_cycles = period_cycles;
>> +
>> +    regmap_read(priv->map, TCSR0, &tcsr0);
>> +    regmap_read(priv->map, TCSR1, &tcsr1);
>> +    tlr0 = xilinx_timer_tlr_cycles(priv, tcsr0, period_cycles);
>> +    tlr1 = xilinx_timer_tlr_cycles(priv, tcsr1, duty_cycles);
>> +    regmap_write(priv->map, TLR0, tlr0);
>> +    regmap_write(priv->map, TLR1, tlr1);
>> +
>> +    if (state->enabled) {
>> +        /*
>> +         * If the PWM is already running, then the counters will be
>> +         * reloaded at the end of the current cycle.
>> +         */
>> +        if (!xilinx_timer_pwm_enabled(tcsr0, tcsr1)) {
>> +            /* Load TLR into TCR */
>> +            regmap_write(priv->map, TCSR0, tcsr0 | TCSR_LOAD);
>> +            regmap_write(priv->map, TCSR1, tcsr1 | TCSR_LOAD);
>> +            /* Enable timers all at once with ENALL */
>> +            tcsr0 = (TCSR_PWM_SET & ~TCSR_ENT) | (tcsr0 & TCSR_UDT);
>> +            tcsr1 = TCSR_PWM_SET | TCSR_ENALL | (tcsr1 & TCSR_UDT);
>> +            regmap_write(priv->map, TCSR0, tcsr0);
>> +            regmap_write(priv->map, TCSR1, tcsr1);
>> +        }
>> +    } else {
>> +        regmap_write(priv->map, TCSR0, 0);
>> +        regmap_write(priv->map, TCSR1, 0);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static void xilinx_pwm_get_state(struct pwm_chip *chip,
>> +                 struct pwm_device *unused,
>> +                 struct pwm_state *state)
>> +{
>> +    struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
>> +    u32 tlr0, tlr1, tcsr0, tcsr1;
>> +
>> +    regmap_read(priv->map, TLR0, &tlr0);
>> +    regmap_read(priv->map, TLR1, &tlr1);
>> +    regmap_read(priv->map, TCSR0, &tcsr0);
>> +    regmap_read(priv->map, TCSR1, &tcsr1);
>> +    state->period = xilinx_timer_get_period(priv, tlr0, tcsr0);
>> +    state->duty_cycle = xilinx_timer_get_period(priv, tlr1, tcsr1);
>> +    state->enabled = xilinx_timer_pwm_enabled(tcsr0, tcsr1);
>> +    state->polarity = PWM_POLARITY_NORMAL;
>> +
>> +    /* 100% duty cycle results in constant low output */
>> +    if (state->period == state->duty_cycle)
>> +        state->duty_cycle = 0;
>> +}
>> +
>> +static const struct pwm_ops xilinx_pwm_ops = {
>> +    .apply = xilinx_pwm_apply,
>> +    .get_state = xilinx_pwm_get_state,
>> +    .owner = THIS_MODULE,
>> +};
>> +
>> +static const struct regmap_config xilinx_pwm_regmap_config = {
>> +    .reg_bits = 32,
>> +    .reg_stride = 4,
>> +    .val_bits = 32,
>> +    .val_format_endian = REGMAP_ENDIAN_LITTLE,
>> +    .max_register = TCR1,
>> +};
>> +
>> +static int xilinx_timer_probe(struct platform_device *pdev)
>> +{
>> +    int ret;
>> +    struct device *dev = &pdev->dev;
>> +    struct device_node *np = dev->of_node;
>> +    struct xilinx_timer_priv *priv;
>> +    struct xilinx_pwm_device *pwm;
>> +    u32 pwm_cells, one_timer;
>> +    void __iomem *regs;
>> +
>> +    ret = of_property_read_u32(np, "#pwm-cells", &pwm_cells);
>> +    if (ret == -EINVAL)
>> +        return -ENODEV;
>> +    else if (ret)
> 
> I would remove this else. It is at least for me easier to read.

OK

>> +        return dev_err_probe(dev, ret, "could not read #pwm-cells\n");
>> +
>> +    pwm = devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
>> +    if (!pwm)
>> +        return -ENOMEM;
> 
> newline

Here I would like to keep these grouped to highlight that they are related/dependent.

>> +    platform_set_drvdata(pdev, pwm);
>> +    priv = &pwm->priv;
>> +
>> +    regs = devm_platform_ioremap_resource(pdev, 0);
>> +    if (IS_ERR(regs))
>> +        return PTR_ERR(regs);
>> +
>> +    priv->map = devm_regmap_init_mmio(dev, regs,
>> +                      &xilinx_pwm_regmap_config);
>> +    if (IS_ERR(priv->map))
>> +        return dev_err_probe(dev, PTR_ERR(priv->map),
>> +                     "Could not create regmap\n");
>> +
>> +    ret = xilinx_timer_common_init(np, priv, &one_timer);
>> +    if (ret)
>> +        return ret;
>> +
>> +    if (one_timer)
>> +        return dev_err_probe(dev, -EINVAL,
>> +                     "Two timers required for PWM mode\n");
> 
> I would fail from above that this code is not needed.

(see above)

>> +
>> +    /*
>> +     * The polarity of the generate outputs must be active high for PWM
>> +     * mode to work. We could determine this from the device tree, but
>> +     * alas, such properties are not allowed to be used.
>> +     */
>> +
>> +    priv->clk = devm_clk_get(dev, "s_axi_aclk");
>> +    if (IS_ERR(priv->clk))
>> +        return dev_err_probe(dev, PTR_ERR(priv->clk),
>> +                     "Could not get clock\n");
>> +
>> +    ret = clk_prepare_enable(priv->clk);
>> +    if (ret)
>> +        return dev_err_probe(dev, ret, "Clock enable failed\n");
>> +    clk_rate_exclusive_get(priv->clk);
>> +
>> +    pwm->chip.dev = dev;
>> +    pwm->chip.ops = &xilinx_pwm_ops;
>> +    pwm->chip.npwm = 1;
>> +    ret = pwmchip_add(&pwm->chip);
>> +    if (ret) {
>> +        clk_rate_exclusive_put(priv->clk);
>> +        clk_disable_unprepare(priv->clk);
>> +        return dev_err_probe(dev, ret, "Could not register PWM chip\n");
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int xilinx_timer_remove(struct platform_device *pdev)
>> +{
>> +    struct xilinx_pwm_device *pwm = platform_get_drvdata(pdev);
>> +
>> +    pwmchip_remove(&pwm->chip);
>> +    clk_rate_exclusive_put(pwm->priv.clk);
>> +    clk_disable_unprepare(pwm->priv.clk);
>> +    return 0;
>> +}
>> +
>> +static const struct of_device_id xilinx_timer_of_match[] = {
>> +    { .compatible = "xlnx,xps-timer-1.00.a", },
>> +    {},
>> +};
>> +MODULE_DEVICE_TABLE(of, xilinx_timer_of_match);
>> +
>> +static struct platform_driver xilinx_timer_driver = {
>> +    .probe = xilinx_timer_probe,
>> +    .remove = xilinx_timer_remove,
>> +    .driver = {
>> +        .name = "xilinx-timer",
>> +        .of_match_table = of_match_ptr(xilinx_timer_of_match),
>> +    },
>> +};
>> +module_platform_driver(xilinx_timer_driver);
>> +
>> +MODULE_ALIAS("platform:xilinx-timer");
>> +MODULE_DESCRIPTION("Xilinx LogiCORE IP AXI Timer driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/clocksource/timer-xilinx.h b/include/clocksource/timer-xilinx.h
>> new file mode 100644
>> index 000000000000..1f7757b84a5e
>> --- /dev/null
>> +++ b/include/clocksource/timer-xilinx.h
>> @@ -0,0 +1,91 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
>> + */
>> +
>> +#ifndef XILINX_TIMER_H
>> +#define XILINX_TIMER_H
>> +
>> +#include <linux/compiler.h>
>> +
>> +#define TCSR0    0x00
>> +#define TLR0    0x04
>> +#define TCR0    0x08
>> +#define TCSR1    0x10
>> +#define TLR1    0x14
>> +#define TCR1    0x18
>> +
>> +#define TCSR_MDT    BIT(0)
>> +#define TCSR_UDT    BIT(1)
>> +#define TCSR_GENT    BIT(2)
>> +#define TCSR_CAPT    BIT(3)
>> +#define TCSR_ARHT    BIT(4)
>> +#define TCSR_LOAD    BIT(5)
>> +#define TCSR_ENIT    BIT(6)
>> +#define TCSR_ENT    BIT(7)
>> +#define TCSR_TINT    BIT(8)
>> +#define TCSR_PWMA    BIT(9)
>> +#define TCSR_ENALL    BIT(10)
>> +#define TCSR_CASC    BIT(11)
>> +
>> +struct clk;
>> +struct device_node;
>> +struct regmap;
>> +
>> +/**
>> + * struct xilinx_timer_priv - Private data for Xilinx AXI timer drivers
>> + * @map: Regmap of the device, possibly with an offset
>> + * @clk: Parent clock
>> + * @max: Maximum value of the counters
>> + */
>> +struct xilinx_timer_priv {
>> +    struct regmap *map;
>> +    struct clk *clk;
>> +    u32 max;
>> +};
>> +
>> +/**
>> + * xilinx_timer_tlr_cycles() - Calculate the TLR for a period specified
>> + *                             in clock cycles
>> + * @priv: The timer's private data
>> + * @tcsr: The value of the TCSR register for this counter
>> + * @cycles: The number of cycles in this period
>> + *
>> + * Callers of this function MUST ensure that @cycles is representable as
>> + * a TLR.
>> + *
>> + * Return: The calculated value for TLR
>> + */
>> +u32 xilinx_timer_tlr_cycles(struct xilinx_timer_priv *priv, u32 tcsr,
>> +                u64 cycles);
>> +
>> +/**
>> + * xilinx_timer_get_period() - Get the current period of a counter
>> + * @priv: The timer's private data
>> + * @tlr: The value of TLR for this counter
>> + * @tcsr: The value of TCSR for this counter
>> + *
>> + * Return: The period, in ns
>> + */
>> +unsigned int xilinx_timer_get_period(struct xilinx_timer_priv *priv,
>> +                     u32 tlr, u32 tcsr);
>> +
>> +/**
>> + * xilinx_timer_common_init() - Perform common initialization for Xilinx
>> + *                              AXI timer drivers.
>> + * @priv: The timer's private data
>> + * @np: The devicetree node for the timer
>> + * @one_timer: Set to %1 if there is only one timer
>> + *
>> + * This performs common initialization, such as detecting endianness,
>> + * and parsing devicetree properties. @priv->regs must be initialized
>> + * before calling this function. This function initializes @priv->read,
>> + * @priv->write, and @priv->width.
>> + *
>> + * Return: 0, or negative errno
>> + */
>> +int xilinx_timer_common_init(struct device_node *np,
>> +                 struct xilinx_timer_priv *priv,
>> +                 u32 *one_timer);
>> +
>> +#endif /* XILINX_TIMER_H */
>>

Thanks for the review.

--Sean
