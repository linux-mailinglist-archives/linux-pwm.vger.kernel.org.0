Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416483B7A68
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Jun 2021 00:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbhF2W3Y (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 29 Jun 2021 18:29:24 -0400
Received: from mail-vi1eur05on2068.outbound.protection.outlook.com ([40.107.21.68]:41056
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233056AbhF2W3Y (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 29 Jun 2021 18:29:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6DfFnSN0e1rn1xO7NABLXFYSeiZfYax/KKtiMmdLEEwWc9meEsXlavVJ5lwu+czNIYn41xpMOzCwgsgnTquEI232IIC+kpdBHyo4bR9tRqKet6WgbqMfuFCO0tUGPxoB0Y/yuaEjAXKugsL4FL8mUeXFezS23FSHsNLkd452ja+YM1AHZxiFDu++gTumdKQ64/3zij7nJO4rN2DgE8kel8rBw/iFsxGELQQGBe9Rn5ZOhmQMwKW5rrwcCxtyJFL4sACTcUODT/Gq7xgrVf25jCej8gSDfdn89bOOWd5w8KOsR64dRooo4u6ZLSe4HAQI2sxXZ8UFn3T9SQsNf7XHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVH1SeQeEx+Wkvf0AuiJ1E0tVvHYuv0jwb5JoOgK/Sc=;
 b=d0n0JXnpfkzHcjYzv6HJqH2/o8vkTpjZheiYrSwqOk8HHj/tONbu3jXWlOQX9gOWS2mD463zYks2hoU3H/ERnHiwwy++mspKgzuaj1nN7CYQmzgPcmxTiYvqYbncOFppd1V7MRFWgsm5kgTc+p4X/YS5Xc5Qxpi3dJW2TIbz1JU5kiq3/s/kuFAhyUDTmpa3PlfpVwYucM3lz/aD01QEB9gIN3zb/s1anhWVwxRWZJWW3d4IROKLbCEthuwt0CRJJ8XKH7+20VxsrahI6n7L0Xj5Mg4RhtzIdUJX2yMG6LCGVPJD7o4FpqKU+FJgDaEzHsCMT4oqp73gs+iFe16WCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVH1SeQeEx+Wkvf0AuiJ1E0tVvHYuv0jwb5JoOgK/Sc=;
 b=CjmhEnjVaFlm97SUyT1lKWl+sFrzkR30Quo/934r3/q8y7lS/WS6kHIH86Xm/QkMFlfMOQvwYKHNRKgp8LNLtAUgWrMZpBdkUuPe45VwF/4MuSFT5kH1eCu9mh8G4/dD+fGHDU7hkdrG374cAeeh9R1YXdDuoetBDAad00m5aRE=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB6PR0302MB2629.eurprd03.prod.outlook.com (2603:10a6:4:aa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Tue, 29 Jun
 2021 22:26:52 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 22:26:52 +0000
Subject: Re: [PATCH v4 3/3] pwm: Add support for Xilinx AXI Timer
From:   Sean Anderson <sean.anderson@seco.com>
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
 <dab8407a-7cff-392c-46b7-effc8ee7ecff@seco.com>
Message-ID: <99b6d095-c60d-2bb4-4f87-d3fcb7e1b135@seco.com>
Date:   Tue, 29 Jun 2021 18:26:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <dab8407a-7cff-392c-46b7-effc8ee7ecff@seco.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: BL1PR13CA0209.namprd13.prod.outlook.com
 (2603:10b6:208:2be::34) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL1PR13CA0209.namprd13.prod.outlook.com (2603:10b6:208:2be::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8 via Frontend Transport; Tue, 29 Jun 2021 22:26:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e84f7a17-1f79-4200-6010-08d93b4cfec2
X-MS-TrafficTypeDiagnostic: DB6PR0302MB2629:
X-Microsoft-Antispam-PRVS: <DB6PR0302MB2629D936DB494B40A668BBA396029@DB6PR0302MB2629.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uSC/g11p9dT353QzcGspLwQziXKOs7Ni+QKsxy0W2s4i3LLP9LwIhg5BEafd0555n7EYjlk5ttyeL23lop/icp3NZgP2bVBOTazossq82jGdCGNpzjtAZg3C8r9YEjdAHKeTb46S0P77YwKjqYh7g/FtFbsQsD6FlVAtneJ4c8bbXhKJAtzL2URWXAFXBUrMn6/TM2J1KU/9FV8+b6n1rDAn1+SOEBXlu78QyVowbc0J12GRdW4gQiDyyx6Z9OMTWurK4RKM0tJWxjSaTFS3jcmgLjtqyo3O/Eza51l17+SLyWe//HMfFhrnSP554JyGH0rh0aU9+crtN0hXP+h4MJRItjxvNr5rfzLOOcmZwILRffCEM9wSuWY5lnyzB5TrgpWX0bd5jKA6tiwxYPLxE3otd9F12zLnVfQUHFCldUAm4qtSp8Tf1Pi2TB571Br4ILy4DX0EKuLYSzSjeDpbxJeYVtg+BrCrFIF2b7xVAtkWbdac5hCNp5TEZ0sSBZ5goptu1dhGdAxMeVhW3RjTNIaPS+F5bSmXruvdKzC3IdrUyhgM1bNLpIK3kJFKCJQMMnxi/A+JIu3Nw9oWcAyfzwclBJQ0JNU1rV7Zu5tz6yytfY8r14N/jeKKNssCYGhWw71+ilm11e2nUwgse4j9liGTgM3XyaZ7bmDZbSKYqqCekPS2YV3C02OvjBaOcdLlWgYFjFEOIzdrl/0Zh550Ey5X8nxtQ3VpofmQnf2EEP5hwqLhtfMHiGTeOk3YGR6WTSMy1sanwdQFp6BusWTMaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39830400003)(376002)(136003)(366004)(396003)(2906002)(31686004)(4326008)(16576012)(54906003)(6486002)(36756003)(38100700002)(31696002)(2616005)(956004)(38350700002)(86362001)(44832011)(5660300002)(8936002)(26005)(52116002)(6916009)(6666004)(66574015)(478600001)(83380400001)(316002)(7416002)(66946007)(186003)(66556008)(16526019)(8676002)(66476007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?LhuGp8OGqxUnrCxQzzN0Ar4kqYmjAeHGA6/QTyQNM02oxiei2nx0W7OO?=
 =?Windows-1252?Q?PC1n3W6YtHFfd6QLNVkY1KUYmwldkKQg3aIUIKetdvBTt0ujj7T88IXi?=
 =?Windows-1252?Q?R4CyN+a0NHNI3IR7llXF05QIH6m4ZCWEZbUBXeIR1vTb1ONYrRtldW4l?=
 =?Windows-1252?Q?aej4RQcjSqBaaae7NShq0KSSJg59YWqsZSXO0TjBdlkZ2JQOZO0ebwg6?=
 =?Windows-1252?Q?LrB7yyFtWlQJFwUNOQqNobQxCBByTQg6cLMiT+Du18zKdJi6Tr5o3949?=
 =?Windows-1252?Q?/XTPALu6f9irAmbmIswAslCkHw+0peKSZ00bbPhnXRyYu1XJ/EuTtvjf?=
 =?Windows-1252?Q?s5VyGDCeW092SRG6rWfPSrVZINuu+xTO9o/PiSu0g7jf6qAFmE4g3a74?=
 =?Windows-1252?Q?qobrSjkxG5m0Lb3p9gXhexGO1hC5w6ZQleht9ioMn5G7u4SJH8rHXMwD?=
 =?Windows-1252?Q?0hIU03DpMJc2mvgdW/R5GsaF3pEbNwP4v4q70SxIf8N4AqxChKv4R3ek?=
 =?Windows-1252?Q?fcy7477r7LHi32FxZ8cU+KEKAspbvSjCMReEQmX0KPLFzJ5FMoqO6e23?=
 =?Windows-1252?Q?cfKsQ+vz0lZBX9WOZIkW2D4SZd+d3YDAK0wC29CXrckg3v1ts8UeDc+u?=
 =?Windows-1252?Q?cq8GdX/RZ+sK3r/M9rX7D8+gj31osbiLGNScU/R3WKp01RIOIyemrA8P?=
 =?Windows-1252?Q?6WFPBTTlm5jRw3LZ0AdyVJz4VcxZPbpmyLjnLHxHDEemEk6UhrcMWKER?=
 =?Windows-1252?Q?wkQgJtCcgUj/DYEHgWoF5yoPJBYTTzmwdsJh4H2+HIGo4uPutUZN5qbz?=
 =?Windows-1252?Q?qm/RHTRw1TH9mAUlmx5nQRZY+dnKj3CpsaeWuTEAa3fg3d6CiOEL2fhY?=
 =?Windows-1252?Q?oKc3te0M7tsPDGViPFycKrttEDN7mwaRmuznev5xhJtLb/KnuQ2FA3+E?=
 =?Windows-1252?Q?LqQo3lS6dNZx8LN24DglUc6x88RHzxpR183UBnq7qbBGPJ1LmYjXixv7?=
 =?Windows-1252?Q?n10IOgLIqC3l0z1EEzae2+DsN6kI75EJRfWqks20GU0O6z6daF5P8gqq?=
 =?Windows-1252?Q?/3RL8BcEjH0V2mZWN2ij2PYVbMTZBjuQIF0EYkKs88BRWwTsY3VOcTSn?=
 =?Windows-1252?Q?L9rcV6qWGas/obzvPlqlgtMWkQZVgRPY4Xflcs3CsXAcpYYCh1jQBNZf?=
 =?Windows-1252?Q?1CBs1nnXa9fdtanSaJMIJtqSpg/fTKybhry+ObkkGkG6u9lyKhF4nAqp?=
 =?Windows-1252?Q?zBn0C1/a/pGX443ZckmhsJHVWNox12q6eA0+ZeiakJ+D1b+pNOiSAGCk?=
 =?Windows-1252?Q?uaEh3s60wNFKOuMrcZz/yP2yeqVjCAr2YMBHI/Pz3cF7obrobRWZH3Vk?=
 =?Windows-1252?Q?sU4gjQ+4rU8UvcmCJQFTsj1BvePqJfig6ElJblC4+g+Og2oUWtZqKyer?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e84f7a17-1f79-4200-6010-08d93b4cfec2
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 22:26:52.8669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWl5W5RWyiUVVCDmYiPC+1WzHBywZ/LnPkoWfXihyaef6g4Yv2hR6YXIILpA8GsED+D/MJiyISvJJIxXTammKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0302MB2629
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 6/29/21 6:21 PM, Sean Anderson wrote:
> 
> 
> On 6/29/21 4:51 PM, Uwe Kleine-König wrote:
>> Hello Sean,
>>
>> On Tue, Jun 29, 2021 at 02:01:31PM -0400, Sean Anderson wrote:
>>> On 6/29/21 4:31 AM, Uwe Kleine-König wrote:
>>> > Hello Sean,
>>> >
>>> > On Mon, Jun 28, 2021 at 01:41:43PM -0400, Sean Anderson wrote:
>>> >> On 6/28/21 1:20 PM, Uwe Kleine-König wrote:
>>> >> > On Mon, Jun 28, 2021 at 12:35:19PM -0400, Sean Anderson wrote:
>>> >> >> On 6/28/21 12:24 PM, Uwe Kleine-König wrote:
>>> >> >> > On Mon, Jun 28, 2021 at 11:50:33AM -0400, Sean Anderson wrote:
>>> >> >> > > On 6/27/21 2:19 PM, Uwe Kleine-König wrote:
>>> >> >> > > > On Fri, Jun 25, 2021 at 01:46:26PM -0400, Sean Anderson wrote:
>>> >> >> > > IMO, this is the best way to prevent surprising results in the API.
>>> >> >> >
>>> >> >> > I think it's not possible in practise to refuse "near" misses and every
>>> >> >> > definition of "near" is in some case ridiculous. Also if you consider
>>> >> >> > the pwm_round_state() case you don't want to refuse any request to tell
>>> >> >> > as much as possible about your controller's capabilities. And then it's
>>> >> >> > straight forward to let apply behave in the same way to keep complexity
>>> >> >> > low.
>>> >> >> >
>>> >> >> > > The real issue here is that it is impossible to determine the correct
>>> >> >> > > way to round the PWM a priori, and in particular, without considering
>>> >> >> > > both duty_cycle and period. If a consumer requests very small
>>> >> >> > > period/duty cycle which we cannot produce, how should it be rounded?
>>> >> >> >
>>> >> >> > Yeah, because there is no obviously right one, I picked one that is as
>>> >> >> > wrong as the other possibilities but is easy to work with.
>>> >> >> >
>>> >> >> > > Should we just set TLR0=1 and TLR1=0 to give them 66% duty cycle with
>>> >> >> > > the least period? Or should we try and increase the period to better
>>> >> >> > > approximate the % duty cycle? And both of these decisions must be made
>>> >> >> > > knowing both parameters. We cannot (for example) just always round up,
>>> >> >> > > since we may produce a configuration with TLR0 == TLR1, which would
>>> >> >> > > produce 0% duty cycle instead of whatever was requested. Rounding rate
>>> >> >> > > will introduce significant complexity into the driver. Most of the time
>>> >> >> > > if a consumer requests an invalid rate, it is due to misconfiguration
>>> >> >> > > which is best solved by fixing the configuration.
>>> >> >> >
>>> >> >> > In the first step pick the biggest period not bigger than the requested
>>> >> >> > and then pick the biggest duty cycle that is not bigger than the
>>> >> >> > requested and that can be set with the just picked period. That is the
>>> >> >> > behaviour that all new drivers should do. This is somewhat arbitrary but
>>> >> >> > after quite some thought the most sensible in my eyes.
>>> >> >>
>>> >> >> And if there are no periods smaller than the requested period?
>>> >> >
>>> >> > Then return -ERANGE.
>>> >>
>>> >> Ok, so instead of
>>> >>
>>> >>     if (cycles < 2 || cycles > priv->max + 2)
>>> >>         return -ERANGE;
>>> >>
>>> >> you would prefer
>>> >>
>>> >>     if (cycles < 2)
>>> >>         return -ERANGE;
>>> >>     else if (cycles > priv->max + 2)
>>> >>         cycles = priv->max;
>>> >
>>> > The actual calculation is a bit harder to handle TCSR_UDT = 0 but in
>>> > principle, yes, but see below.
>>> >
>>> >> But if we do the above clamping for TLR0, then we have to recalculate
>>> >> the duty cycle for TLR1. Which I guess means doing something like
>>> >>
>>> >>     ret = xilinx_timer_tlr_period(priv, &tlr0, tcsr0, state->period);
>>> >>     if (ret)
>>> >>         return ret;
>>> >>
>>> >>     state->duty_cycle = mult_frac(state->duty_cycle,
>>> >>                       xilinx_timer_get_period(priv, tlr0, tcsr0),
>>> >>                       state->period);
>>> >>
>>> >>     ret = xilinx_timer_tlr_period(priv, &tlr1, tcsr1, state->duty_cycle);
>>> >>     if (ret)
>>> >>         return ret;
>>> >
>>> > No, you need something like:
>>> >
>>> >     /*
>>> >      * The multiplication cannot overflow as both priv_max and
>>> >      * NSEC_PER_SEC fit into an u32.
>>> >      */
>>> >     max_period = div64_ul((u64)priv->max * NSEC_PER_SEC, clkrate);
>>> >
>>> >     /* cap period to the maximal possible value */
>>> >     if (state->period > max_period)
>>> >         period = max_period;
>>> >     else
>>> >         period = state->period;
>>> >
>>> >     /* cap duty_cycle to the maximal possible value */
>>> >     if (state->duty_cycle > max_period)
>>> >         duty_cycle = max_period;
>>> >     else
>>> >         duty_cycle = state->duty_cycle;
>>>
>>> These caps may increase the % duty cycle.
>>
>> Correct.
>>
>> For some usecases keeping the relative duty cycle might be better, for
>> others it might not. I'm still convinced that in general my solution
>> makes sense, is computationally cheaper and easier to work with.
> 
> Can you please describe one of those use cases? Every PWM user I looked
> (grepping for pwm_apply_state and pwm_config) set the duty cycle as a
> percentage of the period, and not as an absolute time. Keeping the high
> time the same while changing the duty cycle runs contrary to the
> assumptions of all of those users.
> 
>>>
>>> >     period_cycles = period * clkrate / NSEC_PER_SEC;
>>> >
>>> >     if (period_cycles < 2)
>>> >         return -ERANGE;
>>> >
>>> >     duty_cycles = duty_cycle * clkrate / NSEC_PER_SEC;
>>> >
>>> >     /*
>>> >      * The hardware cannot emit a 100% relative duty cycle, if
>>> >      * duty_cycle >= period_cycles is programmed the hardware emits
>>> >      * a 0% relative duty cycle.
>>> >      */
>>> >     if (duty_cycle == period_cycles)
>>> >         duty_cycles = period_cycles - 1;
>>> >
>>> >     /*
>>> >      * The hardware cannot emit a duty_cycle of one clk step, so
>>> >      * emit 0 instead.
>>> >      */
>>> >     if (duty_cycles < 2)
>>> >         duty_cycles = period_cycles;
>>>
>>> Of course, the above may result in 100% duty cycle being rounded down to
>>> 0%. I feel like that is too big of a jump to ignore. Perhaps if we
>>> cannot return -ERANGE we should at least dev_warn.
>>
>> You did it again. You picked one single case that you consider bad but
>> didn't provide a constructive way to make it better.
> 
> Sure I did. I suggested that we warn. Something like
> 
> if (duty_cycles == period_cycles)
>      if (--duty_cycles < 2)
>          dev_warn(chip->dev, "Rounding 100%% duty cycle down to 0%%; pick a longer period\n");
> 
> or
> 
> if (period_cycles < 2)
>      return -ERANGE;
> else if (period_cycles < 10)
>      dev_notice(chip->dev,
>             "very short period of %u cycles; duty cycle may be rounded to 0%%\n",
>             period_cycles);
> 
> Because 90% of the time, if a user requests such a short period it is
> due to a typo or something similar. And if they really are doing it
> intentionally, then they should just set duty_cycle=0.
> 
>> Assume there was already a pwm_round_state function (that returns the
>> state that pwm_apply_state would implement for a given request) Consider
>> a consumer that wants say a 50% relative duty together with a small
>> period. So it first might call:
>>
>>     ret = pwm_round_rate(pwm, { .period = 20, .duty_cycle = 20, ... }, &rounded_state)
>>
>> to find out if .period = 20 can be implemented with the given PWM. If
>> this returns rounded state as:
>>
>>     .period = 20
>>     .duty_cycle = 0
>>
>> this says quite a lot about the pwm if the driver implements my policy.
>> (i.e.: The driver can do 20ns, but the biggest duty_cycle is only 0).
>> If however it returns -ERANGE this means (assuming the driver implements
>> the policy I try to convice you to be the right one) it means: The
>> hardware cannot implement 20 ns (or something smaller) and so the next
>> call probably tries 40 ns.
>>
>> With your suggested semantic -ERANGE might mean:
>>
>>   - The driver doesn't support .period = 20 ns
>>     (Follow up questions: What period should be tried next? 10 ns? 40
>>     ns? What if this returns -ERANGE again?)
>>   - The driver supports .period = 20 ns, but the biggest possible
>>     duty_cycle is "too different from 20 ns to ignore".
>>
>> Then how should the search continue?
> 
> round_rate does not have to use the same logic as apply_state. That is,
> 
>      ret = pwm_round_rate(pwm, { .period = 20, .duty_cycle = 20, ... }, &rounded_state)
> 
> could be rounded to
> 
>      { .period = 20, .duty_cycle = 0 }
> 
> but calling
> 
>      ret = pwm_apply_state(pwm, { .period = 20, .duty_cycle = 20, ... })
> 
> could return -ERANGE. However, calling
> 
>      ret = pwm_apply_state(pwm, { .period = 20, .duty_cycle = 0, ... })
> 
> should work just fine, as the caller clearly knows what they are getting
> into. IMO this is the best way to allow hypothetical round_rate users to
> find out the edges of the PWM while still protecting existing users.
> 
> It's perfectly fine to round
> 
>      { .period = 150, .duty_cycle = 75 }
> 
> to
> 
>      { .period = 100, .duty_cycle = 75 }
> 
> in round_rate. But doing the same thing for apply_state would be very
> surprising to every existing PWM user.
> 
> IMO the following invariant should hold
> 
>      apply_state(round_rate(x))
>      assert(x == get_state())

this should be

       apply_state(round_rate(x))
       assert(round_rate(x) == get_state())

> 
> but the following should not necessarily hold
> 
>      apply_state(x)
>      assert(round_rate(x) == get_state())
> 
> Of course, where it is reasonable to round down, we should do so. But
> where the result may be surprising, then the caller should specify the
> rounded state specifically. It is better to fail loudly and noisily than
> to silently accept garbage.
> 
> --Sean
> 
>>
>> So: As soon as there is a pwm_round_rate function this can be catched
>> and then it's important that the drivers adhere to the expected policy.
>> Implementing this is a big thing and believe me I already spend quite
>> some brain cycles into it. Once the core is extended accordingly I will
>> be happy about each driver already doing the right thing.
>>
>> Best regards
>> Uwe
>>
