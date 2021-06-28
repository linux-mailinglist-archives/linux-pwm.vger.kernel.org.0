Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED713B66D8
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Jun 2021 18:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhF1QiF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Jun 2021 12:38:05 -0400
Received: from mail-am6eur05on2086.outbound.protection.outlook.com ([40.107.22.86]:3297
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231749AbhF1Qhv (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 28 Jun 2021 12:37:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOzyCG2TH+DnOgXmz13q8VCCti2VPm5eglNPA9hiFoUGjb+AX4xQRUn8hsMJehUcrwKAFLUX5VaXI6dM2OPleYQj7pOKTENuTUYQtaVSy3naq8Zp8Q0HGC7SYUAHBDzEHkuKmlAVwZsgR/UsIzAXVR9kkuTi5968GkhkBZam3PRorElTa7GNbXPfTFvE75UAdx5Wfm/w4XYMm82kySC8ef7YZejUfabJ9UvfqV7kAgpAAq69AMrgxY8VeUnpFESXZvzeuhvekkptur6TxZfMzfgcZgffyQ3hnGw4uzIRBvABE9z9x8TBfYZPlmh2erpSJPvz/Y977ojrLlF5Upc5sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sODpsJNzflrmT0ng0aom9Nfe5rFXRXG7jAvbkGdwP0=;
 b=Hfgb6ULGplzdU92WrG0U4kLCA4GovijmLIjwlSerRi2gL5X5qpjP7UUtKBp9ac0+PJNfagebZP/DZFEvbdfqznx2b7KGXLesPeDi/ApVsA2s8Gis4uMoPCqnxcnLZ1UQgvIDcnepqj1tY8rOORXIZ2ZVNDc2REGU+D3nPgtgu0wfU5c8BCa3KOCA0xHUWAx0dRlfpx/y7BNh0ISztfC5ja7a1Mnxs6Rbhp2q4q2ePI+DdGgJBczgn+cdKzm8055ymHuSME34UgQYPJGXwEPDdcHdyoWlbSKIl3v4trlCLWSQ8buwaGJyTbJWvss3Xjb3avZGA5zMDgnQ7tQ3JyEehQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sODpsJNzflrmT0ng0aom9Nfe5rFXRXG7jAvbkGdwP0=;
 b=ZCJmT4XcPH3UPbn6QE+55n08swJvgZhOUFlbOi2U8rke6LORW2DknAz+Rjmj8pv8h9uA4+/6YJ177dTQBACUFjWao24cCwkklu/VLXOA7YehMnB/+OQ5GzgZsp4HV5vswjH0ai5sogMBW7R/UC7hC/I5iQClQI+182YZTHr9TPM=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB3658.eurprd03.prod.outlook.com (2603:10a6:5:2::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18; Mon, 28 Jun 2021 16:35:23 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 16:35:22 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v4 3/3] pwm: Add support for Xilinx AXI Timer
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Emil Lenngren <emil.lenngren@gmail.com>,
        michal.simek@xilinx.com, Alvaro Gamez <alvaro.gamez@hazent.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
References: <20210528214522.617435-1-sean.anderson@seco.com>
 <20210528214522.617435-3-sean.anderson@seco.com>
 <20210625061958.yeaxjltuq7q2t7i7@pengutronix.de>
 <a748143d-f157-562e-795d-dcd9a0cf9d85@seco.com>
 <20210625165642.5iuorl5guuq5c7gc@pengutronix.de>
 <f1772da9-8bd8-57cf-6eba-3c16c58a903f@seco.com>
 <20210627181919.iunagls4j67ignhh@pengutronix.de>
 <59e93f67-0552-04bb-116e-73ddf878761e@seco.com>
 <20210628162407.dxxt6hqfzeokdtxa@pengutronix.de>
Message-ID: <27fca5ef-8c82-f122-4bd0-f595cad4d588@seco.com>
Date:   Mon, 28 Jun 2021 12:35:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210628162407.dxxt6hqfzeokdtxa@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: BL1PR13CA0198.namprd13.prod.outlook.com
 (2603:10b6:208:2be::23) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL1PR13CA0198.namprd13.prod.outlook.com (2603:10b6:208:2be::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.12 via Frontend Transport; Mon, 28 Jun 2021 16:35:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f559ffdc-839a-4649-af34-08d93a52b9c1
X-MS-TrafficTypeDiagnostic: DB7PR03MB3658:
X-Microsoft-Antispam-PRVS: <DB7PR03MB365889FEE908F32D38CAA5CC96039@DB7PR03MB3658.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: su/xS0wBsLmRGMFZWQgWc6gGLT8v/ZNKdTniLyekHhGBBh2RxrH8bXkhQqJF/NdwevD+3gkuB9WFsGkazmCWG16acKsWyy2nqFjSsWI+w8zrjBzTolLSeBS6P3eT4zIOsubz5zV45BpMHc/8zwcc5Z7mDOhTQvQu56q5MXf/l/04glyxslmOhayZRdLYuHavre77T2kTI4YPNUL+J93MZTjdnxudQ1/ehUFE3bTUlt1+yMOGP2JgHNwA0y8a4knFFoaeDg9wGCQJMPBKmmBPz2zM2FNYSyWTA//TmgrQYp9eywQWpDbisY2UzdOgtwB2ZFE5o7eywDNxyxckGCnEvOVR0/t7TDEKlwHiQRHf+r1FRzMqOOMtQZD59Oa3qEMUFP/KNNdXpycFp8tClv+V0s8mAiYir0F+IbXa80N+jPg9soFAWAzbSoBCE2kmDxYd9InnuyYcc29TtycuRwhpDpygyNyYuvtt6hFy2FeFqoFxiZp5frWiHWu68f8Uow8wH8EYyl/H6zKOE7rov9P77Jy7aBZezFydNKxmd2oqDdgdJ6L6jWkMBxwfi0zg80OPmsiwzdRuIqwXbKq5TDCRmd1Ff6sr5XQe4vjRvZhDlE+ETi/dxjY6QwHNZGtV3WdmrI84fUTdHqGeN5SmEVYyY0yQXw6tjbsxKqp0N719NUJXOvhQ9kZLoAFBgGYBDVGoWjGNRmw+Ru4q3cnCeHhroGulBwP6nzVUe3uH51WzRnBx2rGUHYEt8+p5POGkcHr/sWgtZslwFO3K/IqsmorOdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(396003)(366004)(136003)(346002)(376002)(44832011)(36756003)(38350700002)(2616005)(956004)(31686004)(16576012)(38100700002)(31696002)(86362001)(316002)(52116002)(4326008)(6486002)(6916009)(26005)(5660300002)(83380400001)(66574015)(53546011)(16526019)(186003)(7416002)(66556008)(66476007)(54906003)(8936002)(2906002)(66946007)(478600001)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?jxbn2mxZhGKnhPQrhDSRi+IBw0RuHnPidM9RiuA71x6+0d4VWRLHMTad?=
 =?Windows-1252?Q?0ngMsMjdrLa/h5iKrJm8chLkOQOvZDAR+jKatoocX0Hoop+c0Fbr4J1h?=
 =?Windows-1252?Q?aKfe1fpGKeVM0Q2eUlNNEdJYjBr9k3FuyQXR4GlOOs3PoVbBo688xnaQ?=
 =?Windows-1252?Q?2489uz8c3w8cYrsMUYWyIXfq+wP8Lusf9kNEFORIeM9t6Le+0YDEGDdr?=
 =?Windows-1252?Q?tEM4pGOy1urbo0H9whybgusJnd48Z6LyCTd8+K6BqtE6oIpdTE8f0Vl0?=
 =?Windows-1252?Q?pJfp52iqZmFab0V7cX1ANfFiC+3mGJTuE9cXQDUDv5BOUHD86D9js1rh?=
 =?Windows-1252?Q?y1KMEfZpKNlPHNd5y0A19PbmCjSW8sbF8N1g7zuwqx7jkc9cq209TPxg?=
 =?Windows-1252?Q?NpFgZblQ9m2TKCDLZDUvTtqG8TUi1KtD2LLlFhPRfc2AK1PaqRk8mPqo?=
 =?Windows-1252?Q?9wPOPw5DV/fLtHNlQHSwiru6zlIrpOzKyvmoegLVAxtQx8r8C/6Y1AvM?=
 =?Windows-1252?Q?VcATsiVEdHvu3cEWl3ZCb9LNAuccIZ0heTWWf6eY9ocnufV8TMxVxTNw?=
 =?Windows-1252?Q?zGWjdKQCalrJXo+jdqdllAqGrfv2EYNvuFlY8SHW03DzFFFzPjkv4rGj?=
 =?Windows-1252?Q?5cvVAXkgVErFnSH/qPiWDbDbI8t2Ue1Ygz5IqhRcfSR583f3PvElu/IE?=
 =?Windows-1252?Q?oIsIQ4qpkGjDt5Joju4YzuFG3KD7QaXSDg+psWXbJZokdk9MkEYoGWwm?=
 =?Windows-1252?Q?jgX3b1OtPnkSilhiCXtSNmLs7RUDQMRHV+VtdxA+cuZN+sdvjcaRxkE3?=
 =?Windows-1252?Q?VIYEUStBND2VAZsPRNAe/7G9DxOa0wOrbLBGPvT4yX1yNRRTeMWUgMm+?=
 =?Windows-1252?Q?+t3GFdjpX9/cghNSyeAvedOj/+685QJWBAbB65BE26Uq8RwDxFpf1DJi?=
 =?Windows-1252?Q?otAz6EhOljEQ9FNTCtQgAvQdxISquRmEfDBOgxBxDwsiMXGJ8jM75fYB?=
 =?Windows-1252?Q?MXdY+cH5mKUjWhQ85jnk2uJywGj9dm0rOu3k6UBPVLobUn+kqVgUHtkO?=
 =?Windows-1252?Q?MyWN0nNM1z+QjfHkzRfoR4ZYDT5FT+7bjim7PBxyPQ0mBDbJyiwdYLpp?=
 =?Windows-1252?Q?vF09KA0ip5by3RCqLb+9Ri79vFgpQei2Vg5OTk0gXVieKM0NZvqDMzbs?=
 =?Windows-1252?Q?AVyzkDa4bAur/xw21Lm6rGjQB8csuC8AddeTEm58yVarQwkhAwskAekJ?=
 =?Windows-1252?Q?N2wVL77a+AMIKc9xQGkpvOQWmZKcVr38thqphjMM37qtKoLTy3efzykk?=
 =?Windows-1252?Q?W2psn+8tM8QJCbmi5PwX/2e9n5IexibcSXtohD6taSWLRU2BwqGHt7Zq?=
 =?Windows-1252?Q?IfRybyMpEcAztTZVTCm/BmNTmqgPJ/IwdDIe74zmfrdgtNHWmyxcjCjx?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f559ffdc-839a-4649-af34-08d93a52b9c1
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 16:35:22.8582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3fUetW64b9/0R7RUxnba+z4hOiLjW9qwnefqmT6JwrpR2vThJqH2brOHBBzjHMNo+0p2BXhbFYA+Ea5EQLTNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB3658
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 6/28/21 12:24 PM, Uwe Kleine-König wrote:
> Hello Sean,
>
> On Mon, Jun 28, 2021 at 11:50:33AM -0400, Sean Anderson wrote:
>> On 6/27/21 2:19 PM, Uwe Kleine-König wrote:
>> > On Fri, Jun 25, 2021 at 01:46:26PM -0400, Sean Anderson wrote:
>> > > So for the moment, why not give an error? This will be legal code both
>> > > now and after round_state is implemented.
>> >
>> > The problem is where to draw the line. To stay with your example: If a
>> > request for period = 150 ns comes in, and let X be the biggest period <=
>> > 150 ns that the hardware can configure. For which values of X should an
>> > error be returned and for which values the setting should be
>> > implemented.
>> >
>> > In my eyes the only sensible thing to implement here is to tell the
>> > consumer about X and let it decide if it's good enough. If you have a
>> > better idea let me hear about it.
>>
>> Sure. And I think it's ok to tell the consumer that X is the best we can
>> do. But if they go along and request an unconfigurable state anyway, we
>> should tell them as much.
>
> I have the impression you didn't understand where I see the problem. If
> you request 150 ns and the controller can only do 149 ns (or 149.6667 ns)
> should we refuse? If yes: This is very unusable, e.g. the led-pwm driver
> expects that it can configure the duty_cycle in 1/256 steps of the
> period, and then maybe only steps 27 and 213 of the 256 possible steps
> work. (This example doesn't really match because the led-pwm driver
> varies duty_cycle and not period, but the principle becomes clear I
> assume.) If no: Should we accept 151 ns? Isn't that ridiculous?

I am fine with this sort of rounding. The part I take issue with is when
the consumer requests (e.g.) a 10ns period, but the best we can do is
20ns. Or at the other end if they request a 4s period but the best we
can do is 2s. Here, there is no obvious way to round it, so I think we
should just say "come back with a reasonable period" and let whoever
wrote the device tree pick a better period.

>> IMO, this is the best way to prevent surprising results in the API.
>
> I think it's not possible in practise to refuse "near" misses and every
> definition of "near" is in some case ridiculous. Also if you consider
> the pwm_round_state() case you don't want to refuse any request to tell
> as much as possible about your controller's capabilities. And then it's
> straight forward to let apply behave in the same way to keep complexity
> low.
>
>> The real issue here is that it is impossible to determine the correct
>> way to round the PWM a priori, and in particular, without considering
>> both duty_cycle and period. If a consumer requests very small
>> period/duty cycle which we cannot produce, how should it be rounded?
>
> Yeah, because there is no obviously right one, I picked one that is as
> wrong as the other possibilities but is easy to work with.
>
>> Should we just set TLR0=1 and TLR1=0 to give them 66% duty cycle with
>> the least period? Or should we try and increase the period to better
>> approximate the % duty cycle? And both of these decisions must be made
>> knowing both parameters. We cannot (for example) just always round up,
>> since we may produce a configuration with TLR0 == TLR1, which would
>> produce 0% duty cycle instead of whatever was requested. Rounding rate
>> will introduce significant complexity into the driver. Most of the time
>> if a consumer requests an invalid rate, it is due to misconfiguration
>> which is best solved by fixing the configuration.
>
> In the first step pick the biggest period not bigger than the requested
> and then pick the biggest duty cycle that is not bigger than the
> requested and that can be set with the just picked period. That is the
> behaviour that all new drivers should do. This is somewhat arbitrary but
> after quite some thought the most sensible in my eyes.

And if there are no periods smaller than the requested period?

Any way you slice it, there will be situations where there is nothing
reasonable to do other than return an error.

>> > > Perhaps I should add
>> > >
>> > > 	if (tlr0 <= tlr1)
>> > > 		return -EINVAL;
>> > >
>> > > here to prevent accidentally getting 0% duty cycle.
>> >
>> > You can assume that duty_cycle <= period when .apply is called.
>>
>> Ok, I will only check for == then.
>
> You just have to pay attention to the case that you had to decrement
> .period to the next possible value. Then .duty_cycle might be bigger
> than the corrected period.

This is specifically to prevent 100% duty cycle from turning into 0%. My
current draft is

	/*
	 * If TLR0 == TLR1, then we will produce 0% duty cycle instead of 100%
	 * duty cycle. Try and reduce the high time to compensate. If we can't
	 * do that because the high time is already 0 cycles, then just error
	 * out.
	 */
	if (tlr0 == tlr1 && !tlr1--)
		return -EINVAL;

--Sean
