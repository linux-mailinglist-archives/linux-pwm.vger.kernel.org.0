Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A403C7934
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Jul 2021 23:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbhGMVwl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Jul 2021 17:52:41 -0400
Received: from mail-eopbgr50085.outbound.protection.outlook.com ([40.107.5.85]:7166
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234947AbhGMVwl (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 13 Jul 2021 17:52:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Itpeoe6wIMS8QWAk/WMNmE5IgJS5yY4+xqWKIPgVFGS1VHWel5UF4pzeg7r2SyTmPCL1GzMk6G6SCuEn9CMbJi4sN7fC2Hep4ljrmwmyRvetWZGBTmuO4YjnhQirHtwMQkeIe4wt16Q0VHB1Lw9/XKucPcx0xsVSQB/CTFDhj1RxWJDA5jYeZn02hImf8pCaOMRCTabaAV7akhdSX5HCfuN0CFU2xQbfoeFgt3c+Z3+H3cWuzFcX+eJekFbYnQikf6Y9EUxNsbV3XLi+EL68Cn5KwemrAMGYIxC56F4HraIMXF164BBXqAW4laqeZCGKdUSzmhlji+0xDTTC82AANw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHMSYVy9Zj8RQGE82yS3qDMOQpGvpY6ucN4mrw+Gg9M=;
 b=Q5djK4fkpm0KS03uoVZuNw9VbN19HBSyFtewu+bsvG6O0scU9o/xEVxiUSiyXe54a7qAjkIjma5ZMSVJj9FwWFF7Wo4i5xNnPLjH9utxuv7bClrRdzL6MLRnzt/YqNmlj0aboCnAk16Ei828etOzBUvM+Vt01lIZbClpMxZFw7XLFg5x0oC0tirpQlzEPiL9o7RUBwgOOFnDrsYmptRygn4nBuEctA/jwobn8ITZWh6S/hbTjGQQYTj6Jm8MwwV3xvkWN9ry9e9qDpUIr7PAPNZW8RQhbfG17D5A0eiNgHvMaZM9lXtwmPxFVPg3YgyRgYyz2Ch+9DhylpaWqWCPaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHMSYVy9Zj8RQGE82yS3qDMOQpGvpY6ucN4mrw+Gg9M=;
 b=pHsXhy2q2wRjWadqed6A3DjVgZJO3hZVLDS+Ab/kLo97Zw9XZxDisSyisl0H05ODkyYG+nhQk5b/ZIIcnG3dAfdCR1E0/SKaT+Rcr1F3ZHYIzg08fCtg5yITkHJrcAYJunmt5aGF3VdU5xLn080L8ugd/rkzU3OcbwvkgHpfJF4=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB3PR0302MB3354.eurprd03.prod.outlook.com (2603:10a6:8:a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.26; Tue, 13 Jul
 2021 21:49:46 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 21:49:46 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v4 3/3] pwm: Add support for Xilinx AXI Timer
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Emil Lenngren <emil.lenngren@gmail.com>,
        michal.simek@xilinx.com, Alvaro Gamez <alvaro.gamez@hazent.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
References: <20210628172021.q5enzmr7u6cornm6@pengutronix.de>
 <661e52c3-cd79-c2aa-e031-64eef5617be0@seco.com>
 <20210629083144.53onthkcchbk73lo@pengutronix.de>
 <a4943aa5-956c-1820-3489-994f0812c3a7@seco.com>
 <20210629205102.wtnhdlqdbkihi4mz@pengutronix.de>
 <dab8407a-7cff-392c-46b7-effc8ee7ecff@seco.com>
 <20210630083513.gi3yql5u3tzuub3e@pengutronix.de>
 <ddd2ad0c-1dff-c437-17a6-4c7be72c2fce@seco.com>
 <20210708194312.d4gjf6plvk2535yt@pengutronix.de>
 <ad61c979-62e0-d2e4-7d20-72304e515ded@seco.com>
 <20210712194933.t2oui3wzocfzeatk@pengutronix.de>
Message-ID: <cbe91df4-2a9b-0c75-ce8e-524334681dff@seco.com>
Date:   Tue, 13 Jul 2021 17:49:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210712194933.t2oui3wzocfzeatk@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR16CA0008.namprd16.prod.outlook.com
 (2603:10b6:208:134::21) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by MN2PR16CA0008.namprd16.prod.outlook.com (2603:10b6:208:134::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Tue, 13 Jul 2021 21:49:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e4422a1-582c-466f-09b2-08d946482159
X-MS-TrafficTypeDiagnostic: DB3PR0302MB3354:
X-Microsoft-Antispam-PRVS: <DB3PR0302MB3354956816B4E308F10FCD2996149@DB3PR0302MB3354.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aSuxQJacCVBOpeENeVjLmpOubmi2cerLsG8O5shXbz++zKUS7TSX02h+HTbf8wlWnGHXdyyKHBUbgyr+YCbQ2FZkdgas9So4SDt2QDupM7gjCXjZ3uSbOLqiRiWWzjT/DMjTtMed623s2FSIwOZj53KDvODY8dRgpF5RtL0FxjeNlfJHxouvEtXb5mxkpISCPNZo0OBSerE14nKC2RcrILvsN8znRhKHR3NSMFC6+4cV/KwTVc5WB6Qwl6NLqfX3IrZkABpmR93PISgInPswGnHCodf/X9GmVX/jmqDzz0EAaviLef7W5yG4L+Cr9bbRhD8Pa14p4MgY6O38hyUmJAGRmBdLn9quXUNsKNPQwbI8avs0g+83RZq80t8hoab7j98NEFzXzHrOdgC77S3X8Ng3P8lZcIaZrPxjy26+4L30/tqjycUfZWomq8loWerifzRdRXJLv/Vo3paMoIrWq/hPWIsPfEWpYYZgyz+qjWX3EzEcfGUaJYFePOQA/Za/A2rFHUyFrvj0xPPzKM1WTK+h/TSShQOgSZlfy4lsdkY2Gw6Ya5/OLTthIEfgc5qUSaLZVzc3WABJygETSmAakm8kPxKCQETbvjRCwlSmiwZfQQB7CjBRznnDD0U5CMBlWtIiSM8AElf2wMhWt9iTyix7OKk8wdk086w8X2mbdmEx2bTURF+eSzbLjxiNh7tIbGvmCTZB2eomntYavCpTe0bPZgnjgPvpfkrmx516QGHv4jzeEEC61VRiAy+BOiJ1fFimbK4dmVA/GUsitThxEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39830400003)(396003)(366004)(136003)(7416002)(66946007)(66556008)(66476007)(5660300002)(6916009)(86362001)(6486002)(30864003)(66574015)(83380400001)(31696002)(52116002)(6666004)(316002)(36756003)(31686004)(8676002)(16576012)(54906003)(2906002)(4326008)(186003)(44832011)(38100700002)(956004)(26005)(2616005)(53546011)(478600001)(8936002)(38350700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?ZRfzosTo7GgG7g6+FfjHIR60QCk0pbKEDDPUuOCYFiV40W350zSHq4j0?=
 =?Windows-1252?Q?+P/eJ4v6Dr/siFA+IIIAuq+osb32RA87qXGmyOGOjS6xhbH88v5LFxNq?=
 =?Windows-1252?Q?amB1yDEe8f9TbuifVjQs/wrAGBmWWqxjb7o5lgeH3kSsYc72T6bHqUTr?=
 =?Windows-1252?Q?5HgM2WkIC4ogYh8xqBUrLdY/jxWDCzMuQGCacEM6IA6jx0mq0y2pxWUN?=
 =?Windows-1252?Q?5+f2m/4uHZDF3AXcPkFb1HpxP0wFEKe4wCzm2i9T2nEyaHT0pLYD/ZdJ?=
 =?Windows-1252?Q?ISiLtTZjxy4E/lZf5BAmvQ/KpkehZ/YsTnQriRKhjia8nCCXDqIkyyp/?=
 =?Windows-1252?Q?mM76XsEx4dLTwiorrYAbOPqaZIrAbCH7NntoNfSzFDRVLmci0DQvQWiV?=
 =?Windows-1252?Q?NhLUpyyH0MkY117vnkWQ0a/Z3OZoSJ+BQg10z88dHQNyKywIupF95yYs?=
 =?Windows-1252?Q?vMBu4URkK4mtAj5BSo8QHA2MdOL8wyVH2NTGdlCVh4MKdejOq4vxIXGa?=
 =?Windows-1252?Q?JeHHydhhlre86rcLGFFsD36ZuA1AvMJKDug0UuyXbMBjixOaPMCmL98P?=
 =?Windows-1252?Q?SMM8V3BWTWbSOSqNm50MjR8e7e9OgIxg/pBYotKVTPHqb3HSizYw/q6l?=
 =?Windows-1252?Q?RkaEFSILxdz9m4JIfdQS6bLf2Wi+5hsDoiTc8qg4RibRPHgMf6FwMou8?=
 =?Windows-1252?Q?MlgzJvXo6bxET2fJK1eQdTvuYjOqzGe13ExSLqEat4/klnkPoZGtB7oE?=
 =?Windows-1252?Q?KC9X7+hApU783o118UfVLpiE9fEtCTzMrDQpt3sjw0ONfeKkPfVsYVvL?=
 =?Windows-1252?Q?KedMesZNFRoU06pHzZztu9bApmfk32ru/OyEK8cfS/cKGCancsgOg2Bd?=
 =?Windows-1252?Q?SRMfQdxznzIy8nO6ieF1JpO+5IkIzsZWFRzkgfqR5W2QlZ1MYs5ktg7y?=
 =?Windows-1252?Q?UIExQB7kovySwx3V684VXC5V2qRPEf3RBYvYo5UAvTggcF1UqDo8XyL8?=
 =?Windows-1252?Q?JoR7PLe2klg0dcJCEvJTEOagWp0zYenU7sJmcXb2DFn8Tvs/jUyopzly?=
 =?Windows-1252?Q?O1ZcXr3rwLtsBCbFDfrPvORTFoDY7HsJkY0nBzoRNiUgPtbMN6nT8o9i?=
 =?Windows-1252?Q?xizdHVLH4Xql8ZFVofVZgHiMvUAa7q5SCKhPGT6gh7R8VnpqtjarzHHQ?=
 =?Windows-1252?Q?D16XDVGV/HLnYMU0saZ9Uq1W1kx6TdME0eKrZHj4JDv0XqD7UO41O/FK?=
 =?Windows-1252?Q?22mnSYAk0VN4grgyBG06heVZTa66giPXPhTE/LiXwMx5utsaMamep5Ct?=
 =?Windows-1252?Q?0HHzypXdqOTAjHLTHZdCflGXTGYUAhC7CtDmUKl5NWhWAjDh90bgalM/?=
 =?Windows-1252?Q?jzUy3o4HejCGanjNTWUMEF/KTR4v4Q8L5NrmpL1KxGGy2Kc1OvU82di7?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4422a1-582c-466f-09b2-08d946482159
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 21:49:46.3037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8i7jP8vFQycQS+dDgekNCD+W1RlKiU+mqYloRUM1Mjg1Zar7B5xH6wHhzbjChE0hj7nkyJyH78sUrhmmfKs/dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB3354
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 7/12/21 3:49 PM, Uwe Kleine-König wrote:
> Hello Sean,
>
> On Mon, Jul 12, 2021 at 12:26:47PM -0400, Sean Anderson wrote:
>> On 7/8/21 3:43 PM, Uwe Kleine-König wrote:
>> > Hello Sean,
>> >
>> > On Thu, Jul 08, 2021 at 12:59:18PM -0400, Sean Anderson wrote:
>> > > And what if the consumer comes and requests 49 for their period in the
>> > > first place? You have the same problem. The rescaling made it worse in
>> > > this instance, but this is just an unfortunate case study.
>> >
>> > I cannot follow. There are cases that are easy and others are hard.
>> > Obviously I presented a hard case, and just because there are simpler
>> > cases, too, doesn't mean that implementing the algorithm that must cover
>> > all cases becomes simple, too. Maybe I just didn't understand what you
>> > want to say?!
>>
>> My point is that you cannot just pick a bad case and call the whole
>> process poor.
>
> Yeah, there are surprises with both approaches. My point is mostly that
> if you cannot prevent these surprises with a more complicate algorithm,
> then better live with the surprises and stick to the simple algorithm.
>
> (For the sake of completeness: If the request for my 16.4 ns PWM was
>
> 	.period = 100 ns
> 	.duty_cycle = 49 ns
>
> the hardware should be configured with
>
> 	.period = 98.4 ns
> 	.duty_cycle = 32.8 ns
>
> . The key difference to the scaling approach is: The computation is easy
> and it's clear how it should be implemented. So I don't see how my
> approach yields problems.)

It doesn't, which is why I suggested using it below.

>> I can do the same thing for your proposed process.
>> In any case, I don't wish to propose that drivers do rescaling in this
>> manner; I hoped that my below discussion had made that clear.
>
> Yes, After reading the start of your mail I was positively surprised to
> see you reasoning for nearly the same things as I do :-)
>
>> Though I really would like if we could pick a different name for "the
>> duration of the initial part of the PWM's cycle". I know "high time" is
>> not strictly correct for inverted polarity, but duty cycle refers to
>> percentage everywhere but the Linux kernel...
>
> "active time" would be a term that should be fine. But I think
> "duty-cycle" in contrast to "relative duty-cycle" is fine enough and
> IMHO we should keep the terms as they are.

It is very easy to misread one for the other, as I did above. I think
active time is a good term.

>> > > * Hypothetical future users of some kind of round_state function. These
>> > >   users have some kind of algorithm which determines whether a PWM state
>> > >   is acceptable for the driver. Most of the time this will be some kind
>> > >   of accuracy check. What the round_state function returns is not
>> > >   particularly important, because users have the opportunity to revise
>> > >   their request based on what the state is rounded to. However, it is
>> > >   important that each round rate function is consistent in manner that
>> > >   it rounds so that these users
>> >
>> > This sentence isn't complete, is it?
>>
>> this should be finished like
>>
>> 	... can manipulate it programmatically.
>
> Then ack.
>
>> > > * The apply_state function shall only round the requested period down, and
>> > >   may do so by no more than one unit cycle. If the requested period is
>> > >   unrepresentable by the PWM, the apply_state function shall return
>> > >   -ERANGE.
>> >
>> > I don't understand what you mean by "more than one unit cycle", but
>> > that doesn't really matter for what I think is wrong with that
>> > approach: I think this is a bad idea if with "apply_state" you mean
>> > the callback each driver has to implement: Once you made all drivers
>> > conformant to this, someone will argue that one unit cycle is too
>> > strict.
>>
>> The intent here is to provide guidance against drivers which round
>> excessively. That is, a driver which always rounded down to its minimum
>> period would not be very interesting. And neither would a driver which
>> did not make a very good effort (such as always rounding to multiples of
>> 10 when it could round to multiples of 3 or whatever). So perhaps
>> s/shall/should/.
>
> Ah, that's what I formalized as "return the *biggest possible* period
> not bigger than the request". fine.
>
>> > Or that it's ok to increase the period iff the duty_cycle is 0.
>>
>> IMO it doesn't matter what the period is for a duty cycle of 0 or 100.
>> Whatever policy we decide on, the behavior in that case will
>
> So it might even be you who thinks that the request
>
> 	.period = 15
> 	.duty_cycle = 0
>
> should not be refused just because the smallest implementable period is
> 16.4 ns :-)

If the general policy is to refuse periods less than the minimum
representable, then this should be refused. Otherwise, it should be
allowed. This edge case is not worth complicating drivers.

>> > Then you have to adapt all 50 or so drivers to adapt the policy.
>>
>> Of course, as I understand it, this must be done for your policy as
>> well.
>
> Well to be fair, yes. But the advantage of my policy is that it
> returns success in more situations and so the core (and so the consumer)
> can work with that in more cases.

Failure is as important for working with an API as success is.

>> > Better let .apply_state() do the same as .round_state() and then you can
>> > have in the core (i.e. in a single place):
>> >
>> > 	def pwm_apply_state(pwm, state):
>> > 	    rounded_state = pwm_round_state(pwm, state)
>> > 	    if some_condition(rounded_state, state):
>> > 	    	return -ERANGE
>> > 	    else:
>> > 	    	pwm->apply(pwm, state)
>> >
>> > Having said that I think some_condition should always return False, but
>> > independant of the discussion how some_condition should actually behave
>> > this is definitively better than to hardcode some_condition in each
>> > driver.
>>
>> And IMO the condition should just be "is the period different"?
>
> So a request of .period = X must result in a real period that's bigger
> than X - 1 and not bigger than X, correct?

Yes, if 1 is replaced by a suitable

>> I think a nice interface for many existing users would be something like
>>
>>         # this ignores polarity and intermediate errors, but that should
>>         # not be terribly difficult to add
>>         def pwm_apply_relative_duty_cycle(pwm, duty_cycle, scale):
>>             state = pwm_get_state(pwm)
>>             state.enabled = True
>>             state = pwm_set_relative_duty_cycle(state, duty_cycle, scale)
>>             rounded_state = pwm_round_state(pwm, state)
>>             if rounded_state.period != state.period:
>>                 state = pwm_set_relative_duty_cycle(rounded_state, duty_cycle, scale)
>>                 rounded_state = pwm_round_state(pwm, state)
>
> This should be rounded_state, right?! -----------------^^^^^

No, since we just recalculated the duty cycle on the line above.

>
>>             if duty_cycle and not rounded_state.duty_cycle:
>>                 return -ERANGE
>>             return pwm_apply_state(pwm, rounded_state)
>
> (Fixed tabs vs space indention)
>
> I oppose to the duty_cycle and not rounded_state.duty_cycle check. Zero
> shouldn't be handled differently to other values. If it's ok to round 32
> ns down to 16.4 ns, rounding down 2 ns to 0 should be fine, too.
>
> Also for these consumers it might make sense to allow rounding up
> period, so if a consumer requests .period = 32 ns, better yield 32.8 ns
> instead of 16.4 ns.

It might. Allowing apply_state to round closest while round_state rounds
down would be a good useability improvement IMO. The exact rounding
behavior of apply_state is not as important as round_state, so the
requirements detailed below could certainly be loosened.

>> which of course could be implemented both with your proposed semantics
>> or with mine.
>
> Yeah, and each pwm_state that doesn't yield an error is an advantage.
> (OK, you could argue now that period should be round up if a too small
> value for period is requested. That's a weighing to reduce complexity in
> the lowlevel drivers.)

Again, I don't think we should round period in apply_state, because that
throws % duty cycle (which most drivers care about) out the window. And
we both agree that rescaling duty cycle adds too much complexity for
drivers.

>> > > * The apply_state function shall only round the requested duty cycle
>> > >   down. The apply_state function shall not return an error unless there
>> > >   is no duty cycle less than the requested duty cycle which is
>> > >   representable by the PWM.
>> >
>> > ack. (Side note: Most drivers can implement duty_cycle = 0, so for them
>> > duty_cycle isn't a critical thing.)
>>
>> Yes, and unfortunately the decision is not as clear-cut as for period.
>
> Oh, note that up to now we consider different options as the right thing
> to do with period. That's not what I would call clear-cut :-)
>
>> > > * After applying a state returned by round_state with apply_state,
>> > >   get_state must return that state.
>> >
>> > ack.
>> >
>> > > The reason that we must return an error when the period is
>> > > unrepresentable is that generally the duty cycle is calculated based on
>> > > the period. This change has no affect on future users of round_state,
>> > > since that function will only return valid periods. Those users will
>> > > have the opportunity to detect that the period has changed and determine
>> > > if the duty cycle is still acceptable.
>> >
>> > ack up to here.
>> >
>> > > However, for existing users, we
>> > > should also provide the same opportunity.
>> >
>> > Here you say: If the period has changed they should get a return value
>> > of -ERANGE, right? Now what should they do with that. Either they give
>> > up (which is bad)
>>
>> No, this is exactly what we want. Consider how period is set. Either
>> it is whatever the default is (e.g. set by PoR or the bootloader), in
>> which case it is a driver bug if we think it is unrepresentable, or it
>> is set from the device tree (or platform info), in which case it is a
>> bug in the configuration. This is not something like duty cycle where
>> you could make a case depending on the user, but an actual case of
>> misconfiguration.
>
> That is very little cooperative. The result is that the pwm-led driver
> fails to blink because today the UART driver was probed before the
> pwm-led and changed a clk in a way that the pwm-led cannot achieve the
> configured period any more.

This is fine. There are two options for such a board. First, don't set
the period explicitly. You can always just leave the period at whatever
the default is. If you don't actually care about the period (since it
could change every boot), then you shouldn't be setting it explicitly.
Second, add an `assigned-clock-frequencies` property to the clocks node
and remove the race condition.

If you don't grab the clock rate, then you can easily have some
interaction like

     pwm_round_rate()
                        clk_set_rate()
     pwm_apply_state()

where suddenly the period you requested might be unattainable, or could
be rounded completely differently.

>> > or they need to resort to pwm_round_state to
>> > find a possible way forward. So they have to belong in the group of
>> > round_state users and so they can do this from the start and then don't
>> > need to care about some_condition at all.
>> >
>> > > This requirement simplifies
>> > > the behavior of apply_state, since there is no longer any chance that
>> > > the % duty cycle is rounded up.
>> >
>> > This is either wrong, or I didn't understand you. For my hypothetical
>> > hardware that can implement periods and duty_cycles that are multiples
>> > of 16.4 ns the following request:
>> >
>> > 	period = 1650
>> > 	duty_cycle = 164
>> >
>> > (with relative duty_cycle = 9.9393939393939 %)
>> > will be round to:
>> >
>> > 	period = 1640
>> > 	duty_cycle = 164
>> >
>> > which has a higher relative duty_cycle (i.e. 10%).
>>
>> This is effectively bound by the clause above to be no more than the
>> underlying precision of the PWM.  Existing users expect to be able to
>> pass unrounded periods/duty cycles, so we need to round in some manner.
>> Any way we round is OK, as long as it is not terribly excessive (hence
>> the clause above). We could have chosen to round up (and in fact this is
>> exactly what happens for inverted polarity PWMs). But I think that for
>> ease of implementation is is better to mostly round in the same manner
>> as round_state.
>>
>> > > This requirement is easy to implement in
>> > > drivers as well. Instead of writing something like
>> > >
>> > > 	period = clamp(period, min_period, max_period);
>> > >
>> > > they will instead write
>> > >
>> > > 	if (period < min_period || period > max_period)
>> > > 		return -ERANGE;
>> >
>> > Are you aware what this means for drivers that only support a single
>> > fixed period?
>>
>> This is working as designed. Either the period comes from configuration
>> (e.g. pwm_init_state), which is specialized to the board in question, in
>> which case it is OK to return an error because the writer of the dts
>> either should leave it as the default or specify it correctly, or it
>> comes from pwm_get_state in which case it is a driver error for
>> returning a a period which that driver cannot support.
>>
>> There are two exceptions to the above. First, a fixed period PWM driver
>> could have its period changed by the parent clock frequency changing.
>> But I think such driver should just clk_rate_exclusive_get because
>> otherwise all bets are off. You just have to hope your consumer doesn't
>> care about the period.
>>
>> The other exception is pwm_clk. In this case, I think it is reasonable
>> to pass an error on if the user tries to change the frequency of what is
>> effectively a fixed-rate clock.
>>
>> > I still think it should be:
>> >
>> > 	if (period < min_period)
>> > 		return -ERANGE;
>> > 	
>> > 	if (period > max_period)
>> > 		period = max_period;
>> >
>> > There are two reasons for this compared to your suggestion:
>> >
>> >   a) Consider again the 16.4 ns driver and that it is capable to
>> >      implement periods up to 16400 ns. With your approach a request of
>> >      16404 ns will yield -ERANGE.
>> >      Now compare that with a different 16.4 ns driver with max_period =
>> >      164000 ns. The request of 16404 ns will yield 16400 ns, just because
>> >      this driver could also do 16416.4 ns. This is strange, because the
>> >      possibility to do 16416.4 ns is totally irrelevant here, isn't it?
>>
>> Ah, it looks like I mis-specified this a little bit. My intent was
>>
>> 	The apply_state function shall only round the requested period
>> 	down, and should do so by no more than one unit cycle. If the
>> 	period *rounded as such* is unrepresentable by the PWM, the
>> 	apply_state function shall return -ERANGE.
>
> I don't understand "one unit cycle". What is a unit cycle for a PWM that
> can implement periods in the form 10 s / X for X in [1, ... 4096]? What
> is a unit cycle for a fixed period PWM?

One... quanta? step? detent? The idea is that the driver should give its
best approximation which doesn't just round everything down to the
maximum period. So if I were to better capture my above sentiment, I
would suggest

	The apply_state function shall round the requested period down
	to the largest representable period less than or equal to the
	requested period. However, it may not round a period larger than
	the largest representable period by more than the difference
	between the largest representable period and the next largest
	representable period. If no such period exists, or the period is
	too large to be rounded, the apply_state function shall return
	-ERANGE.

In your example, periods of 15s would be rounded down to 10s, since the
difference between the largest period (10s) and the next largest (5s) is
5s. Unfortunately, when the difference between adjacent periods is a
substantial fraction of the period itself, whatever the user requested
goes out the window if they don't calculate their duty cycle with a
period which can be represented exactly.

But the above specification would necessitate implementations like

	if (period < 15ULL * NSEC_PER_SEC)
		period = min(period, 10ULL * NSEC_PER_SEC);
	X = 10ULL * NSEC_PER_SEC / period;

which is arbitrary and requires extra instructions to enforce. So I
would prefer this clause as originally stated, since it makes for easier
implementation. And I suspect that the number of users hitting this edge
case is fairly slim.

>> >   b) If a consumer asked for a certain state and gets back -ENORANGE they
>> >      don't know if they should increase or decrease the period to guess a
>> >      state that might be implementable instead.
>>
>> Because I believe this is effectively a configuration issue, it should
>> be obvious to the user which direction they need to go. Programmatic
>> users which want to automatically pick a better period would need to use
>> round_state instead.
>
> You only consider consumers with a fixed period. Do you want to
> explicitly configure all possible periods for a a driver that uses ~ 50%
> relative duty cycle but varies period (e.g. the pwm-ir-tx driver)?

 From what I can tell this driver doesn't really change the period very
much (mostly just to change standard). I think if you are using a
fixed-period PWM as a carrier frequency, your PWM had better be very
nearly the frequency it should. I would certainly rather get an error
about how my pwm was 40KHz instead of 36KHz than have the driver merrily
continue on. This driver is a very good candidate for round_state,
because it (should) care about what the period is. Even normal PWM
rounding could cause you to completely miss your target frequency (e.g.
request 38KHz, rounded to 36KHz). Of course, this driver doesn't even
check the result of pwm_config, so all bets are off.

And yes, I admit that if you had (e.g.) a driver with a fixed-period PWM
which you were using for IR, and you applied these rules, then it would
break your setup. But I think it is fairly easy to hold off on
converting fixed-frequency PWMs used for IR until the consumer drivers
were converted to round_state.

> (OK, these drivers could use pwm_round_rate(), but then that argument
> could be applied to all consumers and the result of an unrounded request
> doesn't really matter any more.)
>
>> > (Hmm, or are you only talking about .apply_state and only .round_state
>> > should do if (period < min_period) return -ERANGE; if (period >
>> > max_period) period = max_period;?
>>
>> Yes.
>
> I really want to have .apply_state() and .round_state() to behave
> exactly the same. Everything else I don't want to ask from driver
> authors. I don't believe you can argue enough that I will drop this
> claim.

And yet, round_state does not exist yet. Why should we match apply_state
behavior with something which is not implemented? You've noted how
certain checks can be implemented with round_state, but until then it is
better to raise an error in the driver.

>> > If so, I'd like to have this in the framework, not in each driver.
>> > Then .round_state and .apply_state can be identical which is good for
>> > reducing complexity.)
>>
>> So you would like each PWM driver to have a "max_period" and
>> "min_period" parameter?
>
> No, I don't want this explicitly. What did I write to make you think
> that? With .round_state() these values can be found out though.
>> And what if the clock rate changes?

See discussion above about exclusive get.

>> Otherwise, how do you propose that
>> the framework detect when a requested period is out of range?
>
> I call round_rate() with
>
> 	.period = requested_period
> 	.duty_cycle = requested_period
>
> and if that returns -ERANGE the PWM doesn't support this rate (and
> smaller ones). And a big requested period is never out of range.

And what do you do about e.g. pwm-sifive where the min/max can change at
any time?

--Sean
