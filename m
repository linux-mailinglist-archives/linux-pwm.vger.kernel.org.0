Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868813B7A5E
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Jun 2021 00:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbhF2WXw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 29 Jun 2021 18:23:52 -0400
Received: from mail-eopbgr60054.outbound.protection.outlook.com ([40.107.6.54]:52373
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234640AbhF2WXw (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 29 Jun 2021 18:23:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSAX9YV03FZu/D1O2XJb3oae8F20N+6qCNSRKxioOOXlLahFImEz9mae9jP8gmRb2CgDoipF1UrCWVPBDd9JZXbgyIvMZNH6Jnzh7lSEeBnjYNCdn2vdnxD2SxSHf5LGIh6nYtV3ggyeQrpFqZ5nrofMENXLtAf0EAi89qT5geE0myh8cdvO3+7I/jEQAAALMXuJ+KsniDzWsdWBUxIl8Dvgkqm66WUvb2dBFwG/hZ2IvUInnGaPsDaD9UxDnyuNyKFii8OD7F+iGk/sBfbdhjDHuJJ/ROJotWjyXMpozpSk4ZAnnX1cBJH4AN3/VaY72vHz/EvoSGiPyFWUzWPdjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAlwfQoqVqic4gsbpaafPlm0OgwxQaQL8U0rUUNFo/8=;
 b=TWJu6jt6MfGllgXHbZHZYbBEVRLuKeEphUKkG1Tu/zPuJdMhMTkZcLV6BnDWW2DDqzKwCizv2pG68XDBt1mNMDLJOqY4ornQ0PUzhr93gm8XgeHdxFJUUq9061uad+aaIPmCEsiLEI58zw2d54WiJfAvCQxkFJE0s0SmSemv88QlNTuq42dOGEjQGgc5IlDyG0yWJeu25xKLOhgA+l/gMg0dLTwLOJe4FLEljsufXPdO9Posfr6q5xXEQb1bxhQT0CMxEdpUpbkPP0m04KN93RGN2iH+dNKoXQ1Nq85tGCVHJbRsMKrM+P08hVrfB7/x+E9vvuL3SBcUZTu/qXxFHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAlwfQoqVqic4gsbpaafPlm0OgwxQaQL8U0rUUNFo/8=;
 b=btKaAQJ1jz+pZqX03VJ2t0OOA7mAhsunRZ46YdiviDwJ38wqVKnTTQP/Orwcfxvn0dYtlDF9omYzH16SetBDtPd0hAXkItlY0Yei6+UenohnRrytr4imEixLG6deUCbsw/7O/Upz6TlbXDcAhzPR982Dbwuz+3QT26O160hQALc=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB5368.eurprd03.prod.outlook.com (2603:10a6:10:d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Tue, 29 Jun
 2021 22:21:20 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 22:21:20 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v4 3/3] pwm: Add support for Xilinx AXI Timer
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Emil Lenngren <emil.lenngren@gmail.com>,
        michal.simek@xilinx.com, Alvaro Gamez <alvaro.gamez@hazent.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
References: <20210625165642.5iuorl5guuq5c7gc@pengutronix.de>
 <f1772da9-8bd8-57cf-6eba-3c16c58a903f@seco.com>
 <20210627181919.iunagls4j67ignhh@pengutronix.de>
 <59e93f67-0552-04bb-116e-73ddf878761e@seco.com>
 <20210628162407.dxxt6hqfzeokdtxa@pengutronix.de>
 <27fca5ef-8c82-f122-4bd0-f595cad4d588@seco.com>
 <20210628172021.q5enzmr7u6cornm6@pengutronix.de>
 <661e52c3-cd79-c2aa-e031-64eef5617be0@seco.com>
 <20210629083144.53onthkcchbk73lo@pengutronix.de>
 <a4943aa5-956c-1820-3489-994f0812c3a7@seco.com>
 <20210629205102.wtnhdlqdbkihi4mz@pengutronix.de>
Message-ID: <dab8407a-7cff-392c-46b7-effc8ee7ecff@seco.com>
Date:   Tue, 29 Jun 2021 18:21:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210629205102.wtnhdlqdbkihi4mz@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: BLAPR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:208:32b::35) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BLAPR03CA0030.namprd03.prod.outlook.com (2603:10b6:208:32b::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend Transport; Tue, 29 Jun 2021 22:21:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61fc0924-f97d-46ae-6003-08d93b4c38c8
X-MS-TrafficTypeDiagnostic: DBBPR03MB5368:
X-Microsoft-Antispam-PRVS: <DBBPR03MB53685333729A4CC80E94E32B96029@DBBPR03MB5368.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RrRGBwhQ3fL7sDCy5M6ZFSGYqSqxIkLVVFJu2cNY9LtuKv3tWjf3oqyXASnhGpKiF5VYlGu+s4oPd5Jlx1EIM0oIraqFxc2g4lPHoxYoNJLTslidMDXSEAe6gLP8htDmeNHfIl0aCsNoIKMXc6F8tZX2CSXqtmypfKJTzJiINxc9tyDvtElYQTgKWBoUYxvULU/j/LBVmAiX6+PB1fswRPo1WDC8usBIJh6BpUotWU2S46W0fuIqi351xnG6xiFHQVaMGfshahwm94VkoE3N/HceNaemzPcYNX8lh8UPSULt5lqHke59NbKlQGjzojGGFi3bN/ODkrNl7p5Z/Zee6zxDxONtu+bt517Sk/zq+ItWYTB25O0p6malKEWHDlDeikoJC/T1lh6B6gz5u/lxEQI7vf7P8rQC/ByMZbavc5ojO4dcuXjH7m2aablI52NBcC0jf84Af2HFro85xsszr9+f/aDq68ZFv06ZugXN3Mq5yVWD0B8hBHCfb+0Z5ItrwTcWqZs0B1vSAkCaeZqQ/u18Hd5OZYf5kIW7S8KkaQO74XQ5H5CpbHbvbROewPF7yn1oH/2gHZqFk7IJJ21cBRu9EdbeRHhyrLW04Ywa1J8vsuTLu2oElZNopyx5pbCdFvxm2twUP5g3f7OmpaXWyjOeOi7Hw0SiqH5oqZ5TpsVd+jM3SWwzxqXIL0FDvU39blZdmofxwLF1fhcdHbK+ye4Fq4QzMOVQyZJtdSli7r/StlYD419l/7+DzVInoZXrjrgsNJyJNRMfW42i8EjUGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(346002)(376002)(39840400004)(36756003)(54906003)(6916009)(31686004)(66574015)(956004)(44832011)(8936002)(5660300002)(2616005)(8676002)(66556008)(53546011)(66476007)(66946007)(6486002)(16576012)(316002)(26005)(4326008)(478600001)(83380400001)(86362001)(31696002)(38100700002)(38350700002)(16526019)(7416002)(52116002)(2906002)(6666004)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?iIMFb+JJtkBFDkb+dtRDYgKnTuk26BBN5hiNWCg4SD5KbrIrcCtGj30z?=
 =?Windows-1252?Q?swrpbfTcMPwZe3x9yXoR2+dVzVoGYpDpDC59rmmvJVtqS8vkbjFBaKQW?=
 =?Windows-1252?Q?vmijUdnq+0klAquRJrxKYT8NLR2zym+J/5m3pZUfmzqC4n7ozSaY0wzb?=
 =?Windows-1252?Q?FQZMUDNF22TlLhO6kbEnkUa3qYauF4rVhY/qNGm9eJKrV1i3dpwMJJ7N?=
 =?Windows-1252?Q?ECRmimrZLCjELmDe7M7SeUOGC18GcdCeLlwcNIF8HZlJMtxEXoL9vzcX?=
 =?Windows-1252?Q?hxbds4jVtEcpMYYdZy73USI7LuyOnQ32lHNZ/DQB7wrP/yi/HwdLCuqu?=
 =?Windows-1252?Q?2A1j0Ia6jWdROzYv0GB8zo00MxpCNS4gYpWu2irI8FpFwaaFdmDJsS0w?=
 =?Windows-1252?Q?+PUV/h1cEVcAl7jvP+vL42fQnYltHtF3qojedcCi322Nhj8/lSmR/Dhf?=
 =?Windows-1252?Q?tXqgNj5ftVAPyBNybntfR4+MbTRGHa7E3niba3MPZgP1JF/TsPocFgZ8?=
 =?Windows-1252?Q?+OK+YHG587QQKbkNKr7yMt+NmKJkKe1aObAdQt3Ee9LL9fDypTeQzkU/?=
 =?Windows-1252?Q?vuQc9eDvOoSFm8aFoJ/ptWgDMYet9ztY7IThI40O8Omvd9v/TDKE9vQi?=
 =?Windows-1252?Q?rd68N3v57CB+xYsQB7R+58361gcuT/+MssFl4nKkeppa/9YSqfmz2pUC?=
 =?Windows-1252?Q?ibOvDFyCUIV+hL37k6rrtYxTYjOwHQRt8ZMVdKBQxMP7eJoHg/3vnz+c?=
 =?Windows-1252?Q?UiZOH9NuEzsaGnaUOhSt2B0W0MDU1ttRztV9g13HupU5yQ20twazrGal?=
 =?Windows-1252?Q?0D/o4bi58HcfYppRar9/ToKL3y4q12GQPt3Fc/VvrdsS0z1yG/vGG9fx?=
 =?Windows-1252?Q?ffPD26IPQx8wnhiQK9tq3Eb6kGT7MAQ17Ksa6pvnijWB+LyRa6NCCEyE?=
 =?Windows-1252?Q?0Dqr5U0+fEcLCdDU0xYzqqslyFSDChTqi23lRBF3klnXfmWjlElui3bs?=
 =?Windows-1252?Q?h//c4ragzjnd3BDETpcuQipFtoqGSY5gzHyKaM9Z/hXwNO8RVUfyovGs?=
 =?Windows-1252?Q?2wvhGiMsfF1eGzLyKtZhNItmVV9TBySwLqzZi8sg7cJpBarx/cMdkVAh?=
 =?Windows-1252?Q?ewzJ2Chugwxd2+cU/YvUr1e0CTZxRK21+QCTp0ZTun6Y5j2slnFMhUF+?=
 =?Windows-1252?Q?7R8ZwbKCYXKyh0cAUVtevVQe3Aj6xPtefPa/bYy08TuZszavWyfLKVdZ?=
 =?Windows-1252?Q?aZZQvPG51yoMwk7xVUwZAvfOucuPn0+pQ0jNsh7N+fEDo/+rRSZGS9Qr?=
 =?Windows-1252?Q?sUP1EH19DYfodkzrhBFOccfEECqKknOerN12JeQIMPEW4ku9uYJd5UOG?=
 =?Windows-1252?Q?aDdGaMWBBEQEYlwBzp/CpUEymEtWSIArRA4YEizTWNhkfub86KuqYE4Q?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61fc0924-f97d-46ae-6003-08d93b4c38c8
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 22:21:20.6914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WT7FEg5AhF3gzHImVz4PFbpgl3vbUgyYk393LpXZUmRF3xEI2y89z/xdF5HOtSefc2M1AzoCTfdwLXJlhWQIxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB5368
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 6/29/21 4:51 PM, Uwe Kleine-König wrote:
> Hello Sean,
>
> On Tue, Jun 29, 2021 at 02:01:31PM -0400, Sean Anderson wrote:
>> On 6/29/21 4:31 AM, Uwe Kleine-König wrote:
>> > Hello Sean,
>> >
>> > On Mon, Jun 28, 2021 at 01:41:43PM -0400, Sean Anderson wrote:
>> >> On 6/28/21 1:20 PM, Uwe Kleine-König wrote:
>> >> > On Mon, Jun 28, 2021 at 12:35:19PM -0400, Sean Anderson wrote:
>> >> >> On 6/28/21 12:24 PM, Uwe Kleine-König wrote:
>> >> >> > On Mon, Jun 28, 2021 at 11:50:33AM -0400, Sean Anderson wrote:
>> >> >> > > On 6/27/21 2:19 PM, Uwe Kleine-König wrote:
>> >> >> > > > On Fri, Jun 25, 2021 at 01:46:26PM -0400, Sean Anderson wrote:
>> >> >> > > IMO, this is the best way to prevent surprising results in the API.
>> >> >> >
>> >> >> > I think it's not possible in practise to refuse "near" misses and every
>> >> >> > definition of "near" is in some case ridiculous. Also if you consider
>> >> >> > the pwm_round_state() case you don't want to refuse any request to tell
>> >> >> > as much as possible about your controller's capabilities. And then it's
>> >> >> > straight forward to let apply behave in the same way to keep complexity
>> >> >> > low.
>> >> >> >
>> >> >> > > The real issue here is that it is impossible to determine the correct
>> >> >> > > way to round the PWM a priori, and in particular, without considering
>> >> >> > > both duty_cycle and period. If a consumer requests very small
>> >> >> > > period/duty cycle which we cannot produce, how should it be rounded?
>> >> >> >
>> >> >> > Yeah, because there is no obviously right one, I picked one that is as
>> >> >> > wrong as the other possibilities but is easy to work with.
>> >> >> >
>> >> >> > > Should we just set TLR0=1 and TLR1=0 to give them 66% duty cycle with
>> >> >> > > the least period? Or should we try and increase the period to better
>> >> >> > > approximate the % duty cycle? And both of these decisions must be made
>> >> >> > > knowing both parameters. We cannot (for example) just always round up,
>> >> >> > > since we may produce a configuration with TLR0 == TLR1, which would
>> >> >> > > produce 0% duty cycle instead of whatever was requested. Rounding rate
>> >> >> > > will introduce significant complexity into the driver. Most of the time
>> >> >> > > if a consumer requests an invalid rate, it is due to misconfiguration
>> >> >> > > which is best solved by fixing the configuration.
>> >> >> >
>> >> >> > In the first step pick the biggest period not bigger than the requested
>> >> >> > and then pick the biggest duty cycle that is not bigger than the
>> >> >> > requested and that can be set with the just picked period. That is the
>> >> >> > behaviour that all new drivers should do. This is somewhat arbitrary but
>> >> >> > after quite some thought the most sensible in my eyes.
>> >> >>
>> >> >> And if there are no periods smaller than the requested period?
>> >> >
>> >> > Then return -ERANGE.
>> >>
>> >> Ok, so instead of
>> >>
>> >> 	if (cycles < 2 || cycles > priv->max + 2)
>> >> 		return -ERANGE;
>> >>
>> >> you would prefer
>> >>
>> >> 	if (cycles < 2)
>> >> 		return -ERANGE;
>> >> 	else if (cycles > priv->max + 2)
>> >> 		cycles = priv->max;
>> >
>> > The actual calculation is a bit harder to handle TCSR_UDT = 0 but in
>> > principle, yes, but see below.
>> >
>> >> But if we do the above clamping for TLR0, then we have to recalculate
>> >> the duty cycle for TLR1. Which I guess means doing something like
>> >>
>> >> 	ret = xilinx_timer_tlr_period(priv, &tlr0, tcsr0, state->period);
>> >> 	if (ret)
>> >> 		return ret;
>> >>
>> >> 	state->duty_cycle = mult_frac(state->duty_cycle,
>> >> 				      xilinx_timer_get_period(priv, tlr0, tcsr0),
>> >> 				      state->period);
>> >>
>> >> 	ret = xilinx_timer_tlr_period(priv, &tlr1, tcsr1, state->duty_cycle);
>> >> 	if (ret)
>> >> 		return ret;
>> >
>> > No, you need something like:
>> >
>> > 	/*
>> > 	 * The multiplication cannot overflow as both priv_max and
>> > 	 * NSEC_PER_SEC fit into an u32.
>> > 	 */
>> > 	max_period = div64_ul((u64)priv->max * NSEC_PER_SEC, clkrate);
>> >
>> > 	/* cap period to the maximal possible value */
>> > 	if (state->period > max_period)
>> > 		period = max_period;
>> > 	else
>> > 		period = state->period;
>> >
>> > 	/* cap duty_cycle to the maximal possible value */
>> > 	if (state->duty_cycle > max_period)
>> > 		duty_cycle = max_period;
>> > 	else
>> > 		duty_cycle = state->duty_cycle;
>>
>> These caps may increase the % duty cycle.
>
> Correct.
>
> For some usecases keeping the relative duty cycle might be better, for
> others it might not. I'm still convinced that in general my solution
> makes sense, is computationally cheaper and easier to work with.

Can you please describe one of those use cases? Every PWM user I looked
(grepping for pwm_apply_state and pwm_config) set the duty cycle as a
percentage of the period, and not as an absolute time. Keeping the high
time the same while changing the duty cycle runs contrary to the
assumptions of all of those users.

>>
>> > 	period_cycles = period * clkrate / NSEC_PER_SEC;
>> >
>> > 	if (period_cycles < 2)
>> > 		return -ERANGE;
>> >
>> > 	duty_cycles = duty_cycle * clkrate / NSEC_PER_SEC;
>> >
>> > 	/*
>> > 	 * The hardware cannot emit a 100% relative duty cycle, if
>> > 	 * duty_cycle >= period_cycles is programmed the hardware emits
>> > 	 * a 0% relative duty cycle.
>> > 	 */
>> > 	if (duty_cycle == period_cycles)
>> > 		duty_cycles = period_cycles - 1;
>> >
>> > 	/*
>> > 	 * The hardware cannot emit a duty_cycle of one clk step, so
>> > 	 * emit 0 instead.
>> > 	 */
>> > 	if (duty_cycles < 2)
>> > 		duty_cycles = period_cycles;
>>
>> Of course, the above may result in 100% duty cycle being rounded down to
>> 0%. I feel like that is too big of a jump to ignore. Perhaps if we
>> cannot return -ERANGE we should at least dev_warn.
>
> You did it again. You picked one single case that you consider bad but
> didn't provide a constructive way to make it better.

Sure I did. I suggested that we warn. Something like

if (duty_cycles == period_cycles)
	if (--duty_cycles < 2)
		dev_warn(chip->dev, "Rounding 100%% duty cycle down to 0%%; pick a longer period\n");

or

if (period_cycles < 2)
	return -ERANGE;
else if (period_cycles < 10)
	dev_notice(chip->dev,
		   "very short period of %u cycles; duty cycle may be rounded to 0%%\n",
		   period_cycles);

Because 90% of the time, if a user requests such a short period it is
due to a typo or something similar. And if they really are doing it
intentionally, then they should just set duty_cycle=0.

> Assume there was already a pwm_round_state function (that returns the
> state that pwm_apply_state would implement for a given request) Consider
> a consumer that wants say a 50% relative duty together with a small
> period. So it first might call:
>
> 	ret = pwm_round_rate(pwm, { .period = 20, .duty_cycle = 20, ... }, &rounded_state)
>
> to find out if .period = 20 can be implemented with the given PWM. If
> this returns rounded state as:
>
> 	.period = 20
> 	.duty_cycle = 0
>
> this says quite a lot about the pwm if the driver implements my policy.
> (i.e.: The driver can do 20ns, but the biggest duty_cycle is only 0).
> If however it returns -ERANGE this means (assuming the driver implements
> the policy I try to convice you to be the right one) it means: The
> hardware cannot implement 20 ns (or something smaller) and so the next
> call probably tries 40 ns.
>
> With your suggested semantic -ERANGE might mean:
>
>   - The driver doesn't support .period = 20 ns
>     (Follow up questions: What period should be tried next? 10 ns? 40
>     ns? What if this returns -ERANGE again?)
>   - The driver supports .period = 20 ns, but the biggest possible
>     duty_cycle is "too different from 20 ns to ignore".
>
> Then how should the search continue?

round_rate does not have to use the same logic as apply_state. That is,

	ret = pwm_round_rate(pwm, { .period = 20, .duty_cycle = 20, ... }, &rounded_state)

could be rounded to

	{ .period = 20, .duty_cycle = 0 }

but calling

	ret = pwm_apply_state(pwm, { .period = 20, .duty_cycle = 20, ... })

could return -ERANGE. However, calling

	ret = pwm_apply_state(pwm, { .period = 20, .duty_cycle = 0, ... })

should work just fine, as the caller clearly knows what they are getting
into. IMO this is the best way to allow hypothetical round_rate users to
find out the edges of the PWM while still protecting existing users.

It's perfectly fine to round

	{ .period = 150, .duty_cycle = 75 }

to

	{ .period = 100, .duty_cycle = 75 }

in round_rate. But doing the same thing for apply_state would be very
surprising to every existing PWM user.

IMO the following invariant should hold

	apply_state(round_rate(x))
	assert(x == get_state())

but the following should not necessarily hold

	apply_state(x)
	assert(round_rate(x) == get_state())

Of course, where it is reasonable to round down, we should do so. But
where the result may be surprising, then the caller should specify the
rounded state specifically. It is better to fail loudly and noisily than
to silently accept garbage.

--Sean

>
> So: As soon as there is a pwm_round_rate function this can be catched
> and then it's important that the drivers adhere to the expected policy.
> Implementing this is a big thing and believe me I already spend quite
> some brain cycles into it. Once the core is extended accordingly I will
> be happy about each driver already doing the right thing.
>
> Best regards
> Uwe
>
