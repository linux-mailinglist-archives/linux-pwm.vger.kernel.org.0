Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8C042333A
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Oct 2021 00:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbhJEWKX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Oct 2021 18:10:23 -0400
Received: from mail-eopbgr60045.outbound.protection.outlook.com ([40.107.6.45]:39171
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231569AbhJEWKW (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 5 Oct 2021 18:10:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEOWRbhAU4n3c0f/+prGEwb+b3K1bp+xItwY8gD7bmvGSqcvJ6n19QJtD9KigO9ApNkr3SZRAG7CzVB9s+kFFyKgyt3O1a0i7P49/hjx1akSqK9lsek3c3QZ+qLfaYMJHuYAzc1DmyD1wUeIN8mLR4a6iJwzwX5dzg5z2elNYATVFmm+b41AdAvX8Gl+ix03JA/aKIap8yf3bQ4rejtURDDbDAwsKYmWJQ3qnrh2q2Ap0+EldGyjOivpT5pl4DeN6UAvBnK0s5Vi85aPlmpPhEGNSiZIXFrjd3A8eJZF0z0hL8f/Dgbjlm4P66j8qSXkEv0zi/wGXMVwK5gCIvMDOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nClUYm8lWo3uQ8k6jtkikfjjTH4jVseuy/tcCR6WBVE=;
 b=YvW0TnpFTvGPQxhv16py/tJTJ3cNk2pdjZjY2WB0yYPQd37/paxi1IeSOGGXjECvRkKG/7BwqEvdj2cF3pVIzXampTgN14a6f6BoRJT9VcO9nY1NiYtp/E1cI9yZbOZcWXt2HUMPPQoL8wrVSHFVS1MsDh2gdb65qCremdKTUIIZzIjVGMYXFqks83SfNlB1HONMlZN1zO8Qi91TNvmbiGF8XLMFbJrPmwbGko46f/AdFikpyNsoZSCrkggc9HAgXCUx819/Uw/18Ou3Yn4+ObQnKrN2jpLWG01E95Ebx2gRVEdQLZ1SjcNdmLwUW2lecnS1Pm5fqIRzHINHSf9D1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nClUYm8lWo3uQ8k6jtkikfjjTH4jVseuy/tcCR6WBVE=;
 b=LvMTZxK4H6P7NZScuAxJHiIZLnXMZC6EPihBB7zXwyPcITvesn/H7wptYwEABwLsC/sbCQN/FLSXYci+OxmaZt9jQu98a1tGGpPbA39f3cG0a9V9PAF4IfMZ+C5hvHjODmsP/V64m26ZPZqsra5hcRndgyBIaiwLr02izsm6z3k=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB6PR03MB3045.eurprd03.prod.outlook.com (2603:10a6:6:35::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 22:08:29 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf%6]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 22:08:29 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v7 2/3] clocksource: Rewrite Xilinx AXI timer driver
To:     Michal Simek <michal.simek@xilinx.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20210916180544.2873770-1-sean.anderson@seco.com>
 <20210916180544.2873770-2-sean.anderson@seco.com>
 <696e2f8b-1737-0686-40cb-575a8fa2fa61@xilinx.com>
Message-ID: <667279a0-1a11-06ad-c764-d9150a5db593@seco.com>
Date:   Tue, 5 Oct 2021 18:08:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <696e2f8b-1737-0686-40cb-575a8fa2fa61@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0042.namprd19.prod.outlook.com
 (2603:10b6:208:19b::19) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
Received: from [172.27.1.65] (50.195.82.171) by MN2PR19CA0042.namprd19.prod.outlook.com (2603:10b6:208:19b::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Tue, 5 Oct 2021 22:08:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcce67c5-5d44-4917-afde-08d9884ca974
X-MS-TrafficTypeDiagnostic: DB6PR03MB3045:
X-Microsoft-Antispam-PRVS: <DB6PR03MB30456A7CD8621931A642537C96AF9@DB6PR03MB3045.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LLa4hjfYc/tE8WYeQr1TOC0Porh0kanR9RN/79W66GcrkcptFO4Ju6JcMcSaQEfJA0Nux1Ry80Nrs27FmXyS16TVvWPXiymao8BMo/RWjQ5TnIsS0wvwap7kU1g7kPtE7M4sEK6cktErFIXagAJ/x0Ep6Uj7DTmsRr3nmZyeZDVa9ZifI8kormpJkfrCL0nQmlaOCSfTU8K0sa8SiZPhIV8U6Wh2K/ud1OvQAEBe2ssGqk2oOvTh5sr+Eii6OlLY87hhcHJRe0LRdUM+wgFMggmh3AxSOOOIR8DE+AQWKDZwVYtpAcUWAnzqd4TbxmaK8+Pls8kwbuoAaIj7ANwPcdvnCIzvT4k+BrWmLskywQkkoulK5ArZh7roBdKE5xNv8BVmweiWe0TzS5d1izfEpOPxUwjlPlimis41I/3FZ+Hzn+F9wqQfD0zUjII5eOHXVLwGPTKJUTOXDcgGtdFb0UYrzQQGbfUX992M7ugzRiqq33LcOlxYMSv4BzATR5yU86QkxbZCX6peDc3OyNJq7Sy0VV+ylw+BEKrgJ0ClQQNIjtPJ2+6MfBXR4vs9zwHxyEe1UYhPxDjos3N40kj/vsBxgdQwVfVFveIbTlY+cL0qmg7tRH1Ov2ACulho8nw5hGyVw54AQAZ2wuJh/S5R1uycFailzAjfrFpQiB2ZcogripxpRw0qhUEo68jATQo/98Lj3ZKCKgT/3/NKsmW/5xBRm+A9Iqru9ExDUgjFvG3OTjNNpNFIn829nIEmj6zMGeEuEBdqzj59AnMterclpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(956004)(2906002)(66946007)(31696002)(186003)(66476007)(53546011)(26005)(66556008)(6666004)(44832011)(7416002)(31686004)(83380400001)(38100700002)(16576012)(6486002)(8936002)(5660300002)(4326008)(38350700002)(52116002)(36756003)(54906003)(316002)(508600001)(8676002)(110136005)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3ZxWCt2M2FKZ0JNcXFlYTBPRzREWU5BTTlRRjFkdEo3d0orOFpOWTlQcExT?=
 =?utf-8?B?VGwzRFBTcnZ4SXlOTWwyUzZGcVRoM2Vyb3BxQjhId1RMd2xmYThwSDBqWWg0?=
 =?utf-8?B?NzJjKzRrc2RLdUtNMzNLd096Umo5Q0JqbSt1d2lTbi9VWi84aGNvVmw1K0t6?=
 =?utf-8?B?UkpNNDRKSUpPbmdPSWJBeEZyYXpRRHZYU1R4d092dm1DZWg2NUZvQnBsY2VC?=
 =?utf-8?B?YXRYWDRnMHVJWjZwbUJ3RnVRZ01hakZRWXAwZHZnd3ZKZzdLMnR6aGE1SVNl?=
 =?utf-8?B?QUZlcnVtOThkZEZWMlNzaEZzRUEwMHgySzhESnNmNnB3a001ZlVpcG90TkMw?=
 =?utf-8?B?bkUvY1c2RVhNbkdYekdmbW02SmQwcmhhcXVlay9mSHh6RzhUcjhGWkJiQnAv?=
 =?utf-8?B?TjE3STg4cFdyVm5NZXpBVGVGc1U2U2VHYXNmUUk0TGFiU0h2ZXNrWks5eGkx?=
 =?utf-8?B?UWpabFNFL1orUE9hMG1nV292eUJPbHhUMTRYUmxMTGJzaWtwaG5vaUdXQjZG?=
 =?utf-8?B?WXJLSFdmY2FodndBMmdKYXo0TmJoNjRiOHF2VVp5OG5tRFBXSWNnVUNJWmYr?=
 =?utf-8?B?eE1xOW9LUWRxbFZ5TGY1Uk9OdHg2cUxSVXZBQzVRVmdKdy9KdHZoOWdmdks3?=
 =?utf-8?B?UDNXc01BMlZPbk1xTGJKTDlqVXl4YkZjNWRQSDlSMmNrQ2RYZ0RYYmF4bVVN?=
 =?utf-8?B?SEh0d01WWFdxWUk4d09jZDVCUi9SZ251aUJSSXkxbStCNU1xWnZKaUpFbHpQ?=
 =?utf-8?B?ZzArc0lNSTRyU3RYcWxOWlV6Ti91V3dCVlRwS2docXlRNkY1YzlSekpkdFI0?=
 =?utf-8?B?N0NVQ0tLcEtybmMxV3NNaEJIUFljZnBuNFBWWDVKbHRjMVlROE5MZUlXVEpo?=
 =?utf-8?B?SnVjY1M0M21NdXpvN0NxaDdHTlFCVzBKaEhCRjB0RVhSaWFrSmpoeW5mNkhY?=
 =?utf-8?B?Uk1nUVpxU2JObVpuMEdncFVjdVRlYmN6eXBNU012MnM3U1hXREFKVE92Qzkw?=
 =?utf-8?B?WFRkMVF1R0RQcVB0RmpjTXZmRExzcVpQeUJ3ZyttdFFLRkxORURWOGVtTGRu?=
 =?utf-8?B?Rng4OUxHdGcrakpQT1VEeThnNTRLUjhpZnh5Y1BsR2E5STQ1cHlneGZ2Zkpm?=
 =?utf-8?B?L1U2RWlyV0E1ZFBSNXBXV1JZTWpMNW04bkxlcUxRcDc4bm9jTjNlV3piK0Rr?=
 =?utf-8?B?aVN1QUt2MmltTGM3TnM4T3VoMTI3OW1tRUFXSVN1WHdmVllPK0pTYlBSdmQr?=
 =?utf-8?B?M0I1M254UWY0elhWRzlXNXdWdzlxb1BsbU96YkNuUnNXTWJXTmNlUzJ2dXp5?=
 =?utf-8?B?d1ZBSEEzRGlSQU1KWis5NkRIZ1JWZjlkSng3ZXBxYnI5V204dmpOY1prY1dj?=
 =?utf-8?B?bldDQVl3emNMSmRQU095M2YwU0xJNkFNOGlXRlJ2U0hmdkZYZDI2VkgzY2h0?=
 =?utf-8?B?RjQ0ZzgvT0xJTUYwZThZZWd1NjJjaElVVUdjUnlValRTd3IzUXQ1K2tEOWZO?=
 =?utf-8?B?SzZvajA5SGZCYnExZ21KSE03cVVKV3ZHeVI1aGUrdVE4UVBaQVNOR1Z3bnpV?=
 =?utf-8?B?enpZR3BLUG55NkxnQ3JGUHErVFgvUTlaWWxOcEViTU1vN3Z0Qms2bHFPTzVj?=
 =?utf-8?B?SGtuMENCYnhSWjhWZTEvTWFhcUs5VXBYTUpybkR0RVM2M0dia0FWK2F3cVRP?=
 =?utf-8?B?NTJnZ2xueXhiUHp4SnhPUGlDNlY2RWIyQjJwRTJFMU04Mk9INy9DbnhKUGpk?=
 =?utf-8?Q?ca/ddRdfQTUSXaYHFhz66z9ie5EBlFrQvZP1q2F?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcce67c5-5d44-4917-afde-08d9884ca974
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 22:08:29.2343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZqr/1E5OtuCn++EtARBXuwt/HYs5QmD/Y1GvhJaBwqiuhRRr3v1a7agE8Ku4/ldouh5x0NTCxKFCO/k6CjdyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR03MB3045
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 9/24/21 2:52 AM, Michal Simek wrote:
> Dear Sean,
>
> On 9/16/21 8:05 PM, Sean Anderson wrote:
>> This rewrites the Xilinx AXI timer driver to be more platform agnostic.
>> Some common code has been split off so it can be reused. These routines
>> currently live in drivers/mfd. The largest changes are summarized below:
>>
>> - We now support any number of timer devices, possibly with only one
>>   counter each. The first counter will be used as a clocksource. Every
>>   other counter will be used as a clockevent. This allocation scheme was
>>   chosen arbitrarily.
>> - We do not use timer_of_init because we need to perform some tasks in
>>   between different stages. For example, we must ensure that ->read and
>>   ->write are initialized before registering the irq. This can only happen
>>   after we have gotten the register base (to detect endianness). We also
>>   have a rather unusual clock initialization sequence in order to remain
>>   backwards compatible. Due to this, it's ok for the initial clock request
>>   to fail, and we do not want other initialization to be undone. Lastly, it
>>   is more convenient to do one allocation for xilinx_clockevent_device than
>>   to do one for timer_of and one for xilinx_timer_priv.
>> - We now pay attention to xlnx,count-width and handle smaller width timers.
>>   The default remains 32.
>> - We access registers using regmap. This automatically deals with
>>   endianness issues, so we no longer have to use our own wrappers. It
>>   also provides locking for clockevents which have to worry about being
>>   interrupted in the middle of a read/modify/write.
>>
>> Note that while the existing timer driver always sets the cpumask to cpu
>> 0, this version sets it to all possible CPUs. I believe this is correct
>> for multiprocessor systems where the timer is not physically wired to a
>> particular CPU's interrupt line. For uniprocessor systems (like most
>> microblaze systems) this makes no difference.
>>
>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> ---
>> This has been tested on microblaze qemu.
>>
>> Changes in v7:
>> - Add dependency on OF_ADDRESS
>>
>> Changes in v6:
>> - Add __init* attributes
>> - Export common symbols
>> - Fix goto'ing incorrect label for cleanup
>> - Remove duplicate regmap_config
>> - Round to closest period in xilinx_timer_get_period to ensure proper
>>   semantics for xilinx_pwm_get_state
>>
>> Changes in v5:
>> - Fix some overflows when setting the max value for clockevent and
>>   sched_clock
>> - Just use clk_register_fixed_rate instead of the "private" version
>> - Remove duplicate register definitions
>> - Remove xilinx_timer_tlr_period
>> - Remove xlnx,axi-timer-2.0 compatible string
>> - Require that callers check arguments to xilinx_timer_tlr_cycles
>> - Use regmap to deal with endianness issues as suggested by Lee
>>
>> Changes in v4:
>> - Break out clock* drivers into their own file
>>
>>  MAINTAINERS                               |   6 +
>>  arch/microblaze/kernel/Makefile           |   3 +-
>>  arch/microblaze/kernel/timer.c            | 326 ----------------------
>>  drivers/clocksource/Kconfig               |  13 +
>>  drivers/clocksource/Makefile              |   1 +
>>  drivers/clocksource/timer-xilinx-common.c |  71 +++++
>>  drivers/clocksource/timer-xilinx.c        | 323 +++++++++++++++++++++
>>  include/clocksource/timer-xilinx.h        |  91 ++++++
>>  8 files changed, 506 insertions(+), 328 deletions(-)
>>  delete mode 100644 arch/microblaze/kernel/timer.c
>>  create mode 100644 drivers/clocksource/timer-xilinx-common.c
>>  create mode 100644 drivers/clocksource/timer-xilinx.c
>>  create mode 100644 include/clocksource/timer-xilinx.h
>
>
> I have said it couple of times. I won't accept this in this form.
> I have no problem to move this driver out of microblaze. But I want to
> see transition from current state to new state and check it with baby
> steps which are bisectable if any problem happens.
> Because in this style we end in this patch and it will take some time to
> find out what it is failing.

Unfortunately, I do not have the time do do this at the moment. Because
these drivers are independent in nature, I propose to drop these changes
to the timer driver, but leave the common functions split out. In the
future, I (or you) may come back and make the changes in this patch in
an incremental fashion. The only change necessary for this driver would
be to check for #pwm-cells.

--Sean
