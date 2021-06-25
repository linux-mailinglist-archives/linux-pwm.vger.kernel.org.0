Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27A33B485A
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jun 2021 19:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhFYRsp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 25 Jun 2021 13:48:45 -0400
Received: from mail-am6eur05on2080.outbound.protection.outlook.com ([40.107.22.80]:3521
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229531AbhFYRso (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 25 Jun 2021 13:48:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hemLj7uyTIB7x7ayJcUwVKUL/9+m+HRuinShLOrikzXnDMXNJro4sKgEP6OFMO6JLC+oL3G/f4TO2fswQpR9a2nGskrS91rmg0L/ceIuKawyS9p7yTVUhDVuEcOZ+mcvNM1ssiLHo7h8/nwJygzzetpch1e4/UkA9iasnqzXI2qJiK03T3la4G/vg1TQNAd3AfJiuwUja0l8LceZMU6oeNEzB1rnDJykbY1/UByOajD4NtZqvYWaySYrXrKE3B35UskiLeUY580Bgg8Ddq5n5JoJk3j9v45A95l3Xb1WGTsSc1PZq0e4gMmxFFMWHoHy6Nu3qXwxrbaBQxQ0UFzUFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cyv43FQXwhIDKfG/3webZI2+FvuJKq76+99loYXHvag=;
 b=ZYO0GlRSr5DC2tsOoDgIecvflgoPCv5KxknqQOazBaaeTu6sqPWqZ+RUFXgvEILUKL5iKpXSbZvCdcJ3ckhPYVeUuuK2xQUf8hxXHfyCxNn12BQBoytp18w+wHk8+Tg4VNI+iUNZBMzw5+BDlIWlW/jv6VIXR5U75isdqNYOQcYKsmdgXF1YDQwQp0vCkh61gCdTQxwS5VKfriPeWi2n/WW0mzTEm83S4RgQlzimdL5ZMN94wZSZ1NKeFVv3oHrF74nAWMT4PHNw5qHmVAk82VEwQCBvsKHBA2MU2X+oLlRdo+qYt/NWQwEB/NB56E1vEm9+GPlYQJiuf7I02391vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cyv43FQXwhIDKfG/3webZI2+FvuJKq76+99loYXHvag=;
 b=q8eohcwHsi1FJ0TZeEOcEKyBhZZOCyKyvPF0TShI6pOrEZchp4h5Wu73A/ItUt86i/mQ9Ru9FVP44a3fjWNrzqbJHBx4NfMol7b8UxtMgvBk97soRRGH/Uc7n4J3wzkXgSf9ony7r5F7m5jkFL44b4InyKtyNx20VNBHP6EUWOM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBAPR03MB6533.eurprd03.prod.outlook.com (2603:10a6:10:19d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Fri, 25 Jun
 2021 17:46:20 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4264.020; Fri, 25 Jun 2021
 17:46:19 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v4 3/3] pwm: Add support for Xilinx AXI Timer
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        Emil Lenngren <emil.lenngren@gmail.com>
References: <20210528214522.617435-1-sean.anderson@seco.com>
 <20210528214522.617435-3-sean.anderson@seco.com>
 <20210625061958.yeaxjltuq7q2t7i7@pengutronix.de>
 <a748143d-f157-562e-795d-dcd9a0cf9d85@seco.com>
 <20210625165642.5iuorl5guuq5c7gc@pengutronix.de>
Message-ID: <d6fb244f-bbc9-05c0-713c-fbd08661723b@seco.com>
Date:   Fri, 25 Jun 2021 13:46:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210625165642.5iuorl5guuq5c7gc@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: MN2PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:208:d4::41) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by MN2PR04CA0028.namprd04.prod.outlook.com (2603:10b6:208:d4::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend Transport; Fri, 25 Jun 2021 17:46:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52036762-5e1b-49ed-5e58-08d9380123d0
X-MS-TrafficTypeDiagnostic: DBAPR03MB6533:
X-Microsoft-Antispam-PRVS: <DBAPR03MB6533EB818EC3BCC2C07AC51B96069@DBAPR03MB6533.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bz80msImXuqWTVJugUd75EIpuql0PimU2c4Fu81uOSW254gTJSM2wC0zmR8EasL+++mnplgaUnJrjR3hB0yMbQm+YPwrMPNPhDRVQGHO46nJu0Aa86mg5zlhE6KtoZ2dA5fNgDNbbUiITPLhtu0t3Lbw+3Qj29o7uMEJDaeF9ivsWIQISYPEYIMpwAmFwr7v9Ate24IfzjSbb8gO2ZqNxiIxZLE94m4C2o0/gfvxnJjTPqDyNYTylmwwD/SdYsfxSZ7PsWiF34u82H5Fy0IcTl73/pr9+nVkgRZD77+2WB2zQg7pB4QNOawrLMeMyB6ZvGd+y5OJJ330eJFgR2ETgKXIqwTNQZsSuneE1xeyGN6wvJ+b3fBL4skndqoEcc6NBZIdrM+ARkIx/bw2Cs7bAZaojK9LqK3sltj69rlFwe2UJNdyd0XHEx5+AWCJSBly0aMcLedXreQ5Urxi5CIsbDOy91FpQ74BqEzi4CehDcc/Vpurf0Uj1J3JlOq8vzvXf5xJNt0sAnU7ZFzNEiEY3OLyc1Lm2GOhDeLc3AyxxApDoyAgoUjtmhLHiiM/r5TZ79eXvvL14QZqZzvG7UbMVXT+Yv5NIdD4dD/etqFhYkG3uCqM/IXZfcbcJ2gWzyFL+iKS/eLXB3wr9D45p8ss9VfxDgh/zDAxf0hLru4uL/KlXbO3sETiysku1G+J1bQ7gA7yquLFfQH6FfHNfHSGLA9Z6WKc75Yhx59laHTFirjYmWfL9mhQILI3U83rHtxXhjUayzSUGTL5GCM7cMNWE/Ic8FlaAZSqfXn1XNq6QDOzIEmqFEf4/m6xQLEvebcgfOyoyTBvH1gNlIdbnZuTrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39840400004)(376002)(366004)(396003)(346002)(66574015)(54906003)(316002)(16576012)(44832011)(83380400001)(2906002)(6916009)(86362001)(31696002)(966005)(8676002)(186003)(26005)(66556008)(7416002)(38100700002)(16526019)(4326008)(6666004)(6486002)(5660300002)(36756003)(478600001)(2616005)(8936002)(66476007)(31686004)(53546011)(52116002)(38350700002)(66946007)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?yfblFKAdQFrwELhly0YTnyIB5m8OZSAKgqYoj5BmVa6oZIkFXLkHUf5+?=
 =?Windows-1252?Q?NWK2l458zaIRdfWj21eq52qxsZJI0Kg2gDBXidDBvdHjqyMr8MvcP1LE?=
 =?Windows-1252?Q?0NsDibjoX079aZfoqCfUOq75qTcUpQWtLKifZkBoUpx7kAOsSCkPwEMx?=
 =?Windows-1252?Q?A0rPyZxEec5DeSTxAtqONEkVsKvRWY7bzIY9njm5Lqp47wFVJVMdA/vD?=
 =?Windows-1252?Q?/Zv/U21fQxAYJ9CdSpIFB1eB1xcKnYrRDH7c5mNCQOC0dJ0GaAI8XdDe?=
 =?Windows-1252?Q?RKSkZEdcclnjFb/73TtudzmelBaT4bBdoH25YFVy4QpJDfN8QoKNL/s8?=
 =?Windows-1252?Q?QG+YE4lnRcpitR4xjlxKXo8rL1e72RvUmKl2Ltkrki/Cf1+L/aLuvx9E?=
 =?Windows-1252?Q?tgwLEdNYvyp995rem04uxQL5ImTRt6At5Cm77eHAp9ekjKD2NVM2LNOQ?=
 =?Windows-1252?Q?LMY4/RGDQx8Zv4iJ7YYC2p09pn8GMKnjXj493CDx/P3Bvg/kZCKxwxyv?=
 =?Windows-1252?Q?83QViS0PrCzWFc8HWoqWYBN/2vV/cpleEVaefLUyt5ljICz1Z5vk4Geo?=
 =?Windows-1252?Q?2rxPj/+tv3XlsWs1OU6NytwhMEjocBYDtzggPYLt7o/ZaBPTMwulIpc/?=
 =?Windows-1252?Q?fMtvlV8KFZhmSFfAj4h1+FKdU6ifq3ehjWLAP+RocGMNYC7xYRaoAEpO?=
 =?Windows-1252?Q?Px1VpiqJL4o1z0MWxbD0CebLIqiw82+EdzInAA56xLh5jRKhqKqKuSKD?=
 =?Windows-1252?Q?uWoENbyCRv2qwO+chF2v0uoYlAKP9FOB4BVgnkUnOvhS8xk19rJ6Vagl?=
 =?Windows-1252?Q?fk8UO63qVpbTfYDX5HIQx3gtT+DI8u9qiFRFE2jZTzBKtnoNwlkopG6B?=
 =?Windows-1252?Q?1Z6MqaTaPv1BXRiAYj2M5cT9y+H9OPzSWPgn/z3ZDRdHKzMz2jC/8mJ7?=
 =?Windows-1252?Q?lYJ/aqagu0KDX/O+UnjrFCXkIR/fEdbr7DmMQRe0QZGVrtgABZpxV6/y?=
 =?Windows-1252?Q?E+Lwac/4XFSgH4MxyAD3cwdQ3t2PPxxA8j8f/a3+Aio9G4je4E9+147k?=
 =?Windows-1252?Q?k+zp5dKImew7VxOB5qhfx3FUhNMlZ8wIlG76SaK6DwCrqQUPjUKQZKEw?=
 =?Windows-1252?Q?5uirdWTwA2XJ5ToACCunH6/K7Oma6HXDE52J1Auc1rtrEYb7WlDmOXCV?=
 =?Windows-1252?Q?f9cbIy8xfDizZ6RzbTawG0Obiw/S7l/0J41PEkrRC+mMh+ioizP6HPyl?=
 =?Windows-1252?Q?sglcDV8W36YmLP2Lxat/pqSy/uk0E420YoQW/mhSja5XI18Ip9XMu7Iz?=
 =?Windows-1252?Q?0vLn1Oa0+SJ3eVdZ8Sv8gn+lCNlglF4kXzAsBN7FKU03cnlcWimHjufN?=
 =?Windows-1252?Q?Vn/VGO4xHiFktuibdLEp5kvUNMHIQ7wgMi6Xw+9EsI8R4cWTieYyCdxb?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52036762-5e1b-49ed-5e58-08d9380123d0
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 17:46:19.7916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2N+nd6wgbJlFlQoYjkJm2ldKgDx3mpjCaiA4F71ys2SWnQcF4elSTVI/ZjsFIRBtnt7dozl+q2Tz+bG3oE4MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6533
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 6/25/21 12:56 PM, Uwe Kleine-König wrote:
> Hello Sean,
>
> On Fri, Jun 25, 2021 at 11:13:33AM -0400, Sean Anderson wrote:
>> On 6/25/21 2:19 AM, Uwe Kleine-König wrote:
>> > On Fri, May 28, 2021 at 05:45:22PM -0400, Sean Anderson wrote:
>> >> + * Hardware limitations:
>
> Please make this "* Limitations:" to match what the other drivers do and
> so ease grepping for this info.
>
>> >> + * - When changing both duty cycle and period, we may end up with one cycle
>> >> + *   with the old duty cycle and the new period.
>> >
>> > That means it doesn't reset the counter when a new period is set, right?
>>
>> Correct. The only way to write to the counter is to stop the timer and
>> restart it.
>
> ok.
>
>> >> + * - Cannot produce 100% duty cycle.
>> >
>> > Can it produce a 0% duty cycle? Below you're calling
>> > xilinx_timer_tlr_period(..., ..., ..., 0) then which returns -ERANGE.
>>
>> Yes. This is what you get when you try to specify 100% duty cycle (e.g.
>> TLR0 == TLR1).
>
> OK, so the hardware can do it, but your driver doesn't make use of it,
> right?

So to clarify, I have observed the following behavior

* When TCSR == 0, the output is constant low.
* When TLR1 (duty_cycle) >= TLR0 (period), the output is constant low.

It might be possible to achieve constant high output by stopping the
counters during the high time, but leaving the PWM bit set. However, I
do not have a use case for this. I think it might be a nice follow-up
for someone who wants that feature.

That being said, is there a standard way to specify 100% or 0% duty
cycle? It seems like one would have to detect these situations and use a
different code path.

>
>> >> + * - Only produces "normal" output.
>> >
>> > Does the output emit a low level when it's disabled?
>>
>> I believe so.
>
> Is there a possibility to be sure? I'd like to know that to complete my
> picture about the behaviour of the supported PWMs.

See above.

>
>> >> + */
>> >> +
>> >> [...]
>> >> +static int xilinx_pwm_apply(struct pwm_chip *chip, struct pwm_device *unused,
>> >> +			    const struct pwm_state *state)
>> >> +{
>> >> +	int ret;
>> >> +	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
>> >> +	u32 tlr0, tlr1;
>> >> +	u32 tcsr0 = xilinx_timer_read(priv, TCSR0);
>> >> +	u32 tcsr1 = xilinx_timer_read(priv, TCSR1);
>> >> +	bool enabled = xilinx_timer_pwm_enabled(tcsr0, tcsr1);
>> >> +
>> >> +	if (state->polarity != PWM_POLARITY_NORMAL)
>> >> +		return -EINVAL;
>> >> +
>> >> +	ret = xilinx_timer_tlr_period(priv, &tlr0, tcsr0, state->period);
>> >> +	if (ret)
>> >> +		return ret;
>> >
>> > The implementation of xilinx_timer_tlr_period (in patch 2/3) returns
>> > -ERANGE for big periods. The good behaviour to implement is to cap to
>> > the biggest period possible in this case.
>>
>> Ok. Is this documented anywhere?
>
> I tried but Thierry didn't like the result and I didn't retry. The
> problem is also that many drivers we already have in the tree don't
> behave like this (because for a long time nobody cared). That new
> drivers should behave this way is my effort to get some consistent
> behaviour.

Do you have a link to the thread? IMO if you would like to specify
behavior like this, is is very helpful to write it down so new authors
don't have to get to v4 before finding out about it ;)

>> And wouldn't this result in the wrong duty cycle? E.g. say the max
>> value is 100 and I try to apply a period of 150 and a duty_cycle of 75
>> (for a 50% duty cycle). If we cap at 100, then I will instead have a
>> 75% duty cycle, and there will be no error.
>
> Yes that is right. That there is no feedback is a problem that we have
> for a long time. I have a prototype patch that implements a
> pwm_round_state() function that lets a consumer know the result of
> applying a certain pwm_state in advance. But we're not there yet.

So for the moment, why not give an error? This will be legal code both
now and after round_state is implemented.

>
>> So I will silently get the wrong duty cycle, even when that duty cycle
>> is probably more important than the period.
>
> It depends on the use case and every policy is wrong for some cases. So
> I picked the policy I already explained because it is a) easy to
> implement for lowlevel drivers and b) it's easy to work with for
> consumers once we have pwm_round_state().

What about sysfs? Right now if you try to specify an inexpressible
period you get an error message. I saw [1], but unfortunately there do
not appear to be any patches associated with it. Do you have plans to
implement such an interface?

[1] https://lore.kernel.org/linux-pwm/CAO1O6seyi+1amAY5YLz0K1dkNd7ewAvot4K1eZMpAAQquz0-9g@mail.gmail.com/

>
>> > Also note that state->period is an u64 but it is casted to unsigned int
>> > as this is the type of the forth parameter of xilinx_timer_tlr_period.
>>
>> Hm, it looks like I immediately cast period to a u64. I will change the
>> signature for this function next revision.
>
> Then note that period * clk_get_rate(priv->clk) might overflow.

Ok, so is mult_frac the correct macro to use here?

>> >> +	ret = xilinx_timer_tlr_period(priv, &tlr1, tcsr1, state->duty_cycle);
>> >> +	if (ret)
>> >> +		return ret;

Perhaps I should add

	if (tlr0 <= tlr1)
		return -EINVAL;

here to prevent accidentally getting 0% duty cycle.

>> >> +
>> >> +	xilinx_timer_write(priv, tlr0, TLR0);
>> >> +	xilinx_timer_write(priv, tlr1, TLR1);
>> >> +
>> >> +	if (state->enabled) {
>> >> +		/* Only touch the TCSRs if we aren't already running */
>> >> +		if (!enabled) {
>> >> +			/* Load TLR into TCR */
>> >> +			xilinx_timer_write(priv, tcsr0 | TCSR_LOAD, TCSR0);
>> >> +			xilinx_timer_write(priv, tcsr1 | TCSR_LOAD, TCSR1);
>> >> +			/* Enable timers all at once with ENALL */
>> >> +			tcsr0 = (TCSR_PWM_SET & ~TCSR_ENT) | (tcsr0 & TCSR_UDT);
>> >> +			tcsr1 = TCSR_PWM_SET | TCSR_ENALL | (tcsr1 & TCSR_UDT);
>> >> +			xilinx_timer_write(priv, tcsr0, TCSR0);
>> >> +			xilinx_timer_write(priv, tcsr1, TCSR1);
>> >> +		}
>> >> +	} else {
>> >> +		xilinx_timer_write(priv, 0, TCSR0);
>> >> +		xilinx_timer_write(priv, 0, TCSR1);
>> >> +	}
>> >> +
>> >> +	return 0;
>> >> +}
>> >> +
>> >> +static void xilinx_pwm_get_state(struct pwm_chip *chip,
>> >> +				 struct pwm_device *unused,
>> >> +				 struct pwm_state *state)
>> >> +{
>> >> +	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
>> >> +	u32 tlr0 = xilinx_timer_read(priv, TLR0);
>> >> +	u32 tlr1 = xilinx_timer_read(priv, TLR1);
>> >> +	u32 tcsr0 = xilinx_timer_read(priv, TCSR0);
>> >> +	u32 tcsr1 = xilinx_timer_read(priv, TCSR1);
>> >> +
>> >> +	state->period = xilinx_timer_get_period(priv, tlr0, tcsr0);
>> >> +	state->duty_cycle = xilinx_timer_get_period(priv, tlr1, tcsr1);
>> >> +	state->enabled = xilinx_timer_pwm_enabled(tcsr0, tcsr1);
>> >> +	state->polarity = PWM_POLARITY_NORMAL;
>> >
>> > Are the values returned here sensible if the hardware isn't in PWM mode?
>>
>> Yes. If the hardware isn't in PWM mode, then state->enabled will be
>> false.
>
> Ah right. Good enough.
>
>> >> +	else if (pwm_cells)
>> >> +		return dev_err_probe(dev, -EINVAL, "#pwm-cells must be 0\n");
>> >
>> > What is the rationale here to not support #pwm-cells = <2>?
>>
>> Only one PWM is supported. But otherwise there is no particular
>> reason.
>
> The usual binding is to have 3 additional parameters.
>   1) chip-local pwm number (which can only be 0 for a pwmchip having
>      .npwm = 1)
>   2) the "typical" period
>   3) some flags (like PWM_POLARITY_*)
>
> I don't care much if you implement it with or without 1), but 2) and 3)
> should IMHO be here. If you don't want 1),
> http://patchwork.ozlabs.org/project/linux-pwm/patch/20210622030948.966748-1-bjorn.andersson@linaro.org/
> might be interesting for you. (But note, Thierry didn't give feedback to
> this yet, it might be possible he wants 1)-3) for new drivers.)

Ok, so since I let of_pwmchip_add set xlate, I don't need to change
anything in this driver? Then I will remove this check for v5.

--Sean
