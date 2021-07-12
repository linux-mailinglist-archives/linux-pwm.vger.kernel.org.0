Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19103C607B
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Jul 2021 18:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbhGLQ3p (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Jul 2021 12:29:45 -0400
Received: from mail-eopbgr150043.outbound.protection.outlook.com ([40.107.15.43]:57927
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233911AbhGLQ3o (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 12 Jul 2021 12:29:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBQkXAxyUr6FWX//RZbJdsGYWaDUEtFExRRydLphjQAz1bor7CBjfvsGc5VIJGQ02IpELEIoHBMTxVIVUJgKOkdtHI+1hB03leotxuG/oAECpvl+g6DhdTACfEa5FF3HKhkIkDWd/yPpYVy50bhDwgNZ9sm85ccNtleNxxuqKJ6wWbb0yDChWJy+btapPgPa+XN4i3g/FrgxWsW6Xg6coBa7N7GOcXZEw2B41Vaf2ui9GSZJMnuGiZ/WNOp6ePp4hic0ElyUDMSeJx6gOClLTeH7466uKdleJQkgxjPEFl8g8DzxGoHZUtGn8dEpvB2hOp5oe7CiJdJIjir8xeGBtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHi1I7BBIO8Tzxn1zdiHwRwWDGk774fQgnQ4waLWlnM=;
 b=XPWNXClxd6QAQtXjyryRK6uX7Y40VVmABhwtay8z7nZWJC9IQiwlSmkQcjO7FjBdWPt4rmBVW5+rDbiNyIUrcCFD2hdEgLceUe80I1NhAa03kF6ssqMDen9RRkVKmhN02GT17sWHwCZJhSNjRtKyY/PO8+9Nqq8QvnCD25pLqNwNV6myKlFzWb3FVmrj5QvizmxrU8UYsn8nWmGJzp9JAWDmp6ZCTTOKPnmaDN3Cn6R68pjrsUtGCZkL1pm5pNM7VTm98B8lggnDFiBYaBfeqO60spHaUBM4+afO39JduAGW5+CUSAzgRsjqDJWaqt0wtmhozTlZag0JPlWDtvBgVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHi1I7BBIO8Tzxn1zdiHwRwWDGk774fQgnQ4waLWlnM=;
 b=pSLrx1LRoNLUB8AkiGuQ3tdpGn1Rh0yUN2I68Wajz2wBftJemKN6zzSFy8L/KMzwRSlIa49WUjDTN1EtmCmkmUW/fVi8mEKvcyo8+tjwS4yeOKL5ayldVSzO6ltlMehylYO5l1bJ3e6fOTFY2J2ygOu/08pGhegjAIcfVIVY/b4=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB9PR03MB7513.eurprd03.prod.outlook.com (2603:10a6:10:22a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Mon, 12 Jul
 2021 16:26:54 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 16:26:54 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v4 3/3] pwm: Add support for Xilinx AXI Timer
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Emil Lenngren <emil.lenngren@gmail.com>,
        michal.simek@xilinx.com, Alvaro Gamez <alvaro.gamez@hazent.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
References: <20210628162407.dxxt6hqfzeokdtxa@pengutronix.de>
 <27fca5ef-8c82-f122-4bd0-f595cad4d588@seco.com>
 <20210628172021.q5enzmr7u6cornm6@pengutronix.de>
 <661e52c3-cd79-c2aa-e031-64eef5617be0@seco.com>
 <20210629083144.53onthkcchbk73lo@pengutronix.de>
 <a4943aa5-956c-1820-3489-994f0812c3a7@seco.com>
 <20210629205102.wtnhdlqdbkihi4mz@pengutronix.de>
 <dab8407a-7cff-392c-46b7-effc8ee7ecff@seco.com>
 <20210630083513.gi3yql5u3tzuub3e@pengutronix.de>
 <ddd2ad0c-1dff-c437-17a6-4c7be72c2fce@seco.com>
 <20210708194312.d4gjf6plvk2535yt@pengutronix.de>
Message-ID: <ad61c979-62e0-d2e4-7d20-72304e515ded@seco.com>
Date:   Mon, 12 Jul 2021 12:26:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210708194312.d4gjf6plvk2535yt@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:208:120::15) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.129] (50.195.82.171) by MN2PR10CA0002.namprd10.prod.outlook.com (2603:10b6:208:120::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Mon, 12 Jul 2021 16:26:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c7ce5df-7c00-48dc-42e8-08d94551dc1d
X-MS-TrafficTypeDiagnostic: DB9PR03MB7513:
X-Microsoft-Antispam-PRVS: <DB9PR03MB7513877977C4DE7A7135150296159@DB9PR03MB7513.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q4+MlH7nJekYcmdCDNxhKIMO+r44krEdqsVNZd/pfrzoks/oT7Ab059Y41y9Jw7OcnTLs0n3+a0LfkA3O/WUMDsFcxBPfl8ayTvR5uWa6dBa9W9p48gHaTzWYI6a/AP10oA6cXv2+09+apMbf0fsstDXIS0qCT2ig9ULqurAuhbe5cVNgU4tDvEYDa1LMF6jY6/U8gC8ehp94XgfxhLnNrlaaRTpygCvIYLQKYdpd+dMSJMSH5l13bMD42bAbmjbXMSjry65cY9mgdcjl6WIH66QWKy5dipjV68lngEme9U70x5nTUezGNybXJIoXhGhoE1sjKUUe0TNWScfb7piQsP7UGx5zpJOKinL9Y33QU3cOMi8jUJ/tfpSU2YtqzPDjWtSirtjMNQ55yekFyIM6Caj0jpObfpW9GZr27hKytPqwQSLLxpDUO4vii3zJLUJmDe+HL4dJlCK4u2Wh1KZLt4OHQOJuz1vA4YrSl/lQBBHWIqzPRZwu00R4Ao1iu7e6MDEJq7CDiuqRxNnCtLJ475BZiuM6bRvXml0ukyKhJH8C7oZ9FR4mBPgYUbDWjDuVc56mzg5+OfrnnJSVRRFKQuAHIPy0gczBraN2h3f6kpOCnaTUJ+uT2h+1raZN75hBGOozaBsiWN3RZetnLLK0GQ2fwDNZEKEzIwmUMcQR5a9YDWBsY1kEYV3FdDuLQG7ABTfLyzFxzkZOkXhkYsMFvGzXif6sSqauH0FqeHO6ZuuYSROnonlZcwo7KSkpKnZl2hYdsaa9S8Upu4hlYJrzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(366004)(39840400004)(346002)(7416002)(31686004)(6486002)(186003)(6666004)(2906002)(8676002)(478600001)(5660300002)(83380400001)(86362001)(52116002)(4326008)(44832011)(8936002)(31696002)(38100700002)(2616005)(66556008)(38350700002)(53546011)(6916009)(956004)(66574015)(36756003)(66946007)(66476007)(16576012)(26005)(54906003)(316002)(30864003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?Vo91w93FjZ34A7nhxVDJlN3l78/A/HeqyUWdaTLSTSgKk6v0Eew8hsZG?=
 =?Windows-1252?Q?hEFN/gsGKaovR+HzeSr7tVXvh9AePIyWsem6IKZe407BLnnpVTxQHOUv?=
 =?Windows-1252?Q?17cD1uo6tH7fNcpfC40i54Up4lnOKHZ8FfPys53kjwEwIU1n8qsmnGdo?=
 =?Windows-1252?Q?PMIYtzFuMTOpCShHBn2eyVBC1wzrH65XfwvyOEzaZ2jd9Ai+AwYYobJZ?=
 =?Windows-1252?Q?SNn9BSWGkx9dptACSjijHA/OxALMVSxZyh9WCg0e6HOCz5/nmASl7qnl?=
 =?Windows-1252?Q?b4yWeNZ9hqxT9atS3+uS6qHmo0Dg3SGOEAOZBCV9uoT0ne7h3f/dFs+L?=
 =?Windows-1252?Q?4DUIaIsVKVqn//E0vO1//iH3HShZhuo6Xp7tlLrg/y8bD6ad2mu0U16X?=
 =?Windows-1252?Q?AePAPLkkqEOt1fBT67KyHrG97KXw1De/Iur6ax6arpeS/+DfqTxJg1ps?=
 =?Windows-1252?Q?FgAoHdFW+po7I5JG+hE3t1c5bYp04jUqFYm/izk2w+MnrEn39N/sXvyG?=
 =?Windows-1252?Q?D16iFPtJFMr/hvyB4bba7EX6G5uaptaiUP+XpIDoFTYcOr8JyaktndYX?=
 =?Windows-1252?Q?vne3PQoUNtNnIRQEuE/kMT7QsPA0thczFdrGBMMlPSpoYcvjIEO6r63k?=
 =?Windows-1252?Q?SliyG0l85Pgjd55qivn6QrdUui5bQ0qAxOW0eP3y4FQW9vmy3UDa+zGv?=
 =?Windows-1252?Q?pccQsarPYsrFP/42aMMZ+Rza3/KVZFSe5+4zb0Ie0YPXYyTaQv2rsI+m?=
 =?Windows-1252?Q?WJU8NW8TlrCSCpCXl/O3HxrI6TeiHclT6hojni4afMQo+n/lZKA54brp?=
 =?Windows-1252?Q?wbaEnc1cYXTvUXcobxqBiUY4FW9iZkvjm+U697ltFnwb4uZ2CRRtK3rG?=
 =?Windows-1252?Q?25bHW2ySmBRK+sH7MpY/+Eh0dKc/6QrKDGBtpA2vu5JAZW9dRk1f7IL/?=
 =?Windows-1252?Q?GDaQp8H8LCRO10AlNXDZ0Nx6/mXCEINC1qumHOijiEvnEcdPMttG8heX?=
 =?Windows-1252?Q?ySbBc0910mNT3m9ypcnh7TMTRAYOrB4/FC7S6HRiKYJXCLp+D9nBoBDh?=
 =?Windows-1252?Q?MFAhSYCQtKdRogWLVYu0tSVkNWTMxTMP7yaYzNq2pY5CbNWWxcp6Fj4T?=
 =?Windows-1252?Q?ADIZLQ0JMN1MAW+7muR9tGTr+YO4RPp2mBv3tDH+kolPNdWjLWVDuLYZ?=
 =?Windows-1252?Q?qqM2SHF8rUqcxing+UgG3L8oevNqFk6FegIMtIUJ2HSYGMFCGP4REPYq?=
 =?Windows-1252?Q?pJwRFImwKy8XZYsnyCAeLqAScjFOeAuXhPLqIdhHt2ibAxOe6YUVSGRb?=
 =?Windows-1252?Q?Wu0Q20TKAtP5EHeFRRZfZIQRq1+UL3NArRS9ga1HHYCPgx4WDZDxIE27?=
 =?Windows-1252?Q?PEMQarIZe3D4wKnv/rPU/r5X2H2ghDk+846+pCfXWgFyyzrbt221lC/8?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7ce5df-7c00-48dc-42e8-08d94551dc1d
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 16:26:53.9007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4lBrC6iFgQqxXVlFt0RVX8RMzEEFYQMXpmT9+893B1z7q0O21VfbCs7sBDoLSey9w0MLJBQcWYT27l7gMQw5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7513
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 7/8/21 3:43 PM, Uwe Kleine-König wrote:
> Hello Sean,
>
> On Thu, Jul 08, 2021 at 12:59:18PM -0400, Sean Anderson wrote:
>> And what if the consumer comes and requests 49 for their period in the
>> first place? You have the same problem. The rescaling made it worse in
>> this instance, but this is just an unfortunate case study.
>
> I cannot follow. There are cases that are easy and others are hard.
> Obviously I presented a hard case, and just because there are simpler
> cases, too, doesn't mean that implementing the algorithm that must cover
> all cases becomes simple, too. Maybe I just didn't understand what you
> want to say?!

My point is that you cannot just pick a bad case and call the whole
process poor. I can do the same thing for your proposed process.
In any case, I don't wish to propose that drivers do rescaling in this
manner; I hoped that my below discussion had made that clear.

Though I really would like if we could pick a different name for "the
duration of the initial part of the PWM's cycle". I know "high time" is
not strictly correct for inverted polarity, but duty cycle refers to
percentage everywhere but the Linux kernel...

>> > You might find a way around that (maybe you have to round up in the
>> > adaption of duty_cycle, I didn't convince myself this is good enough
>> > though).
>> >
>> > So your suggestion to adapt the duty_cycle to keep the relative
>> > duty_cycle constant (as good as possible within the bounds the hardware
>> > dictates) implies additional complication at the driver level.
>> >
>> >  From a framework maintainer's point of view (and also from a low-level
>> > driver maintainer's point of view) I prefer one complication in a
>> > generic function over a complication that I have to care for in each and
>> > every low-level driver by a big margin.
>>
>> FWIW what you're suggesting is also complex for the low-level driver.
>
> Well, it is as complex as necessary and simpler than adapting the
> duty_cycle as you suggested.
>> [...]
>> > Can you please come up with an algorithm to judge if a given deviation
>> > is reasonable or surprising? I agree there are surprises and some of
>> > them are obviously bad. For most cases however the judgement depends on
>> > the use case so I fail to see how someone should program such a check
>> > that should cover all consumers and use cases. I prefer no precautions +
>> > an easy relation between pwm_round_state and pwm_apply_state (i.e.
>> > behave identically) over a most of the time(?) useless precaution and
>> > some policy defined differences between pwm_round_state and
>> > pwm_apply_state
>>
>> After thinking it over, I believe I agree with you on most things, but I
>> think your proposed API has room for additional checks without any loss
>> of generality.
>
> \o/
>
>> The PWM subsystem has several major players:
>>
>> * Existing users of the PWM API. Most of these do not especially care
>>   about the PWM period, usually just leaving at the default. The
>>   exception is of course the pwm-clk driver. Many of these users care
>>   about % duty cycle, and they all calculate the high time based on the
>>   configured period of the PWM. I suspect that while many of these users
>>   have substantial leeway in what accuracy they expect from the % duty
>>   cycle, significant errors (in the 25-50% range) are probably unusual
>>   and indicative of a misconfigured period. Unfortunately, we cannot
>>   make a general judgement about what sort of accuracy is OK in most
>>   cases.
>
> ack.
>
>> * Hypothetical future users of some kind of round_state function. These
>>   users have some kind of algorithm which determines whether a PWM state
>>   is acceptable for the driver. Most of the time this will be some kind
>>   of accuracy check. What the round_state function returns is not
>>   particularly important, because users have the opportunity to revise
>>   their request based on what the state is rounded to. However, it is
>>   important that each round rate function is consistent in manner that
>>   it rounds so that these users
>
> This sentence isn't complete, is it?

this should be finished like

	... can manipulate it programmatically.

> One thing I consider important is
> that there is a policy which of the implementable states is returned for
> a given request to make it efficient to search for a best state
> (depending on what the consumer driver considers best). Otherwise this
> yields to too much distinctions of cases.
>
>> * Existing drivers for the PWM subsystem. These drivers must implement
>>   an apply_state function which is correct for both existing and future
>>   users. In addition, they may implement some kind of round_state
>>   function in the future. it is important to reduce the complexity of
>>   the calculations these drivers perform so that it is easier to
>>   implement and review them.
>
> It's hard to know what "correct" means. But ack for "They should not be
> more complex than necessary".
>
>> I believe the following requirements satisfy the above constraints:
>>
>> * The round_state function shall round the period to the largest period
>>   representable by the PWM less than the requested period. It shall also
>>   round the duty cycle to the largest duty cycle representable by the
>>   PWM less than the requested duty cycle. No attempt shall be made to
>>   preserve the % duty cycle.
>
> ack if you replace "less" by "less or equal" twice.

Yes.

>> * The apply_state function shall only round the requested period down, and
>>   may do so by no more than one unit cycle. If the requested period is
>>   unrepresentable by the PWM, the apply_state function shall return
>>   -ERANGE.
>
> I don't understand what you mean by "more than one unit cycle", but
> that doesn't really matter for what I think is wrong with that
> approach: I think this is a bad idea if with "apply_state" you mean
> the callback each driver has to implement: Once you made all drivers
> conformant to this, someone will argue that one unit cycle is too
> strict.

The intent here is to provide guidance against drivers which round
excessively. That is, a driver which always rounded down to its minimum
period would not be very interesting. And neither would a driver which
did not make a very good effort (such as always rounding to multiples of
10 when it could round to multiples of 3 or whatever). So perhaps
s/shall/should/.

> Or that it's ok to increase the period iff the duty_cycle is 0.

IMO it doesn't matter what the period is for a duty cycle of 0 or 100.
Whatever policy we decide on, the behavior in that case will

> Then you have to adapt all 50 or so drivers to adapt the policy.

Of course, as I understand it, this must be done for your policy as
well.

> Better let .apply_state() do the same as .round_state() and then you can
> have in the core (i.e. in a single place):
>
> 	def pwm_apply_state(pwm, state):
> 	    rounded_state = pwm_round_state(pwm, state)
> 	    if some_condition(rounded_state, state):
> 	    	return -ERANGE
> 	    else:
> 	    	pwm->apply(pwm, state)
>
> Having said that I think some_condition should always return False, but
> independant of the discussion how some_condition should actually behave
> this is definitively better than to hardcode some_condition in each
> driver.

And IMO the condition should just be "is the period different"?

I think a nice interface for many existing users would be something like

	# this ignores polarity and intermediate errors, but that should
	# not be terribly difficult to add
	def pwm_apply_relative_duty_cycle(pwm, duty_cycle, scale):
	    state = pwm_get_state(pwm)
	    state.enabled = True
	    state = pwm_set_relative_duty_cycle(state, duty_cycle, scale)
	    rounded_state = pwm_round_state(pwm, state)
	    if rounded_state.period != state.period:
	        state = pwm_set_relative_duty_cycle(rounded_state, duty_cycle, scale)
		rounded_state = pwm_round_state(pwm, state)
             if duty_cycle and not rounded_state.duty_cycle:
	        return -ERANGE
	    return pwm_apply_state(pwm, rounded_state)

which of course could be implemented both with your proposed semantics
or with mine.

>> * The apply_state function shall only round the requested duty cycle
>>   down. The apply_state function shall not return an error unless there
>>   is no duty cycle less than the requested duty cycle which is
>>   representable by the PWM.
>
> ack. (Side note: Most drivers can implement duty_cycle = 0, so for them
> duty_cycle isn't a critical thing.)

Yes, and unfortunately the decision is not as clear-cut as for period.

>> * After applying a state returned by round_state with apply_state,
>>   get_state must return that state.
>
> ack.
>
>> The reason that we must return an error when the period is
>> unrepresentable is that generally the duty cycle is calculated based on
>> the period. This change has no affect on future users of round_state,
>> since that function will only return valid periods. Those users will
>> have the opportunity to detect that the period has changed and determine
>> if the duty cycle is still acceptable.
>
> ack up to here.
>
>> However, for existing users, we
>> should also provide the same opportunity.
>
> Here you say: If the period has changed they should get a return value
> of -ERANGE, right? Now what should they do with that. Either they give
> up (which is bad)

No, this is exactly what we want. Consider how period is set. Either
it is whatever the default is (e.g. set by PoR or the bootloader), in
which case it is a driver bug if we think it is unrepresentable, or it
is set from the device tree (or platform info), in which case it is a
bug in the configuration. This is not something like duty cycle where
you could make a case depending on the user, but an actual case of
misconfiguration.

> or they need to resort to pwm_round_state to
> find a possible way forward. So they have to belong in the group of
> round_state users and so they can do this from the start and then don't
> need to care about some_condition at all.
>
>> This requirement simplifies
>> the behavior of apply_state, since there is no longer any chance that
>> the % duty cycle is rounded up.
>
> This is either wrong, or I didn't understand you. For my hypothetical
> hardware that can implement periods and duty_cycles that are multiples
> of 16.4 ns the following request:
>
> 	period = 1650
> 	duty_cycle = 164
>
> (with relative duty_cycle = 9.9393939393939 %)
> will be round to:
>
> 	period = 1640
> 	duty_cycle = 164
>
> which has a higher relative duty_cycle (i.e. 10%).

This is effectively bound by the clause above to be no more than the
underlying precision of the PWM.  Existing users expect to be able to
pass unrounded periods/duty cycles, so we need to round in some manner.
Any way we round is OK, as long as it is not terribly excessive (hence
the clause above). We could have chosen to round up (and in fact this is
exactly what happens for inverted polarity PWMs). But I think that for
ease of implementation is is better to mostly round in the same manner
as round_state.

>> This requirement is easy to implement in
>> drivers as well. Instead of writing something like
>>
>> 	period = clamp(period, min_period, max_period);
>>
>> they will instead write
>>
>> 	if (period < min_period || period > max_period)
>> 		return -ERANGE;
>
> Are you aware what this means for drivers that only support a single
> fixed period?

This is working as designed. Either the period comes from configuration
(e.g. pwm_init_state), which is specialized to the board in question, in
which case it is OK to return an error because the writer of the dts
either should leave it as the default or specify it correctly, or it
comes from pwm_get_state in which case it is a driver error for
returning a a period which that driver cannot support.

There are two exceptions to the above. First, a fixed period PWM driver
could have its period changed by the parent clock frequency changing.
But I think such driver should just clk_rate_exclusive_get because
otherwise all bets are off. You just have to hope your consumer doesn't
care about the period.

The other exception is pwm_clk. In this case, I think it is reasonable
to pass an error on if the user tries to change the frequency of what is
effectively a fixed-rate clock.

> I still think it should be:
>
> 	if (period < min_period)
> 		return -ERANGE;
> 	
> 	if (period > max_period)
> 		period = max_period;
>
> There are two reasons for this compared to your suggestion:
>
>   a) Consider again the 16.4 ns driver and that it is capable to
>      implement periods up to 16400 ns. With your approach a request of
>      16404 ns will yield -ERANGE.
>      Now compare that with a different 16.4 ns driver with max_period =
>      164000 ns. The request of 16404 ns will yield 16400 ns, just because
>      this driver could also do 16416.4 ns. This is strange, because the
>      possibility to do 16416.4 ns is totally irrelevant here, isn't it?

Ah, it looks like I mis-specified this a little bit. My intent was

	The apply_state function shall only round the requested period
	down, and should do so by no more than one unit cycle. If the
	period *rounded as such* is unrepresentable by the PWM, the
	apply_state function shall return -ERANGE.

>   b) If a consumer asked for a certain state and gets back -ENORANGE they
>      don't know if they should increase or decrease the period to guess a
>      state that might be implementable instead.

Because I believe this is effectively a configuration issue, it should
be obvious to the user which direction they need to go. Programmatic
users which want to automatically pick a better period would need to use
round_state instead.

> (Hmm, or are you only talking about .apply_state and only .round_state
> should do if (period < min_period) return -ERANGE; if (period >
> max_period) period = max_period;?

Yes.

> If so, I'd like to have this in the framework, not in each driver.
> Then .round_state and .apply_state can be identical which is good for
> reducing complexity.)

So you would like each PWM driver to have a "max_period" and
"min_period" parameter? And what if the clock rate changes? Otherwise,
how do you propose that the framework detect when a requested period is
out of range?

>> Instead of viewing round_state as "what get_state would return if I
>> passed this state to apply_state", it is better to view it as "what is
>> the closest exactly representable state with parameters less than this
>> state."
>> I believe that this latter representation is effectively identical for
>> users of round_state, but it allows for implementations of apply_state
>> which provide saner defaults for existing users.
>
> I look forward to how you modify your claim here after reading my
> reasoning above.

I believe it stands as-is.

--Sean
