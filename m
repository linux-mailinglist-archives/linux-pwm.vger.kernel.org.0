Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCF33C17A2
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Jul 2021 18:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhGHRCL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 8 Jul 2021 13:02:11 -0400
Received: from mail-vi1eur05on2050.outbound.protection.outlook.com ([40.107.21.50]:29153
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229469AbhGHRCJ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 8 Jul 2021 13:02:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIoSAz9FwtK9UMnbCSNh8RJRDgP3eI4S2SuAQbaAEu/x/5hWAO7lfeoGKf6/Pn9kvCrexVHNijawYDs+8Gq3d3+VmSLA/7LrsJxlDbr1PR1f6gaWQi3MiCWirTMwWebpgSVtpDLYNE4NSjRvPmrmWdBAGUl5GSXi6rGWYiNIMKGpsIERhw+tq/fZnjj4eHZG66okECOmpCi7ljc2LAx81MbskaTFgpY2N6Xkjxj3AoKkPhLVyIpH+ik9H66RI10vXZFXSQqW5gVvhoi8i5DrRIqGQaP/GD8y/6k35KIbxcgJ5qGwoWN7cJJFenc9VTg99iFQKc6vJU1sJj0Qw4DFoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TjW4Dl0yvYQXz0ooDlWZYwea0FLYhgjWleajBRHeoE=;
 b=mnPNzWUrhNOm39RHr8x8sI2OCYozRP3iCTOQSV1pdrwlBjWCcDoibU7jVani8IJxpuP9fazc7A/Jm3aqPgNg/juPNp7YIYtx15r9irrzHKUx4YGYFWb86vEGwyOZCPlR0IzU8Zq9W8wLqSf2bLLVHjpG20UoS7QpgEAYVzeG92vrwVI8PyABT7iOAXKYDwSdzDX9lsCNLyUBJGo620uPT1V9LCEbltwtlt4auLze7LBKFHJN1boNmXZPGtIlXjCPMHnuShkLRscCzRkMRIOszhrKNM5ERxDb/AISgKC04y1ASvC0wlzM6BQwr2f3tJBD5FT4BQdHoOuFOma+pxDD/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TjW4Dl0yvYQXz0ooDlWZYwea0FLYhgjWleajBRHeoE=;
 b=GHMV/gbMUzLkT4jtqMBFNH1E7BP0826Ra6LWTMSBUolAAUbzmCh5SDtYxACSaJtXY0elztBbrNnQ3N5LRDSyzSzTOwqMzcuss/ByMt9rqcWHz3MM7P+hegCpXEyYodUM5JAH+0qxWAqb6AOKvpSBFSNfefscMWYlNe67q61yM/M=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB5367.eurprd03.prod.outlook.com (2603:10a6:10:dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Thu, 8 Jul
 2021 16:59:23 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4264.035; Thu, 8 Jul 2021
 16:59:23 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v4 3/3] pwm: Add support for Xilinx AXI Timer
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Emil Lenngren <emil.lenngren@gmail.com>,
        michal.simek@xilinx.com, Alvaro Gamez <alvaro.gamez@hazent.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
References: <20210627181919.iunagls4j67ignhh@pengutronix.de>
 <59e93f67-0552-04bb-116e-73ddf878761e@seco.com>
 <20210628162407.dxxt6hqfzeokdtxa@pengutronix.de>
 <27fca5ef-8c82-f122-4bd0-f595cad4d588@seco.com>
 <20210628172021.q5enzmr7u6cornm6@pengutronix.de>
 <661e52c3-cd79-c2aa-e031-64eef5617be0@seco.com>
 <20210629083144.53onthkcchbk73lo@pengutronix.de>
 <a4943aa5-956c-1820-3489-994f0812c3a7@seco.com>
 <20210629205102.wtnhdlqdbkihi4mz@pengutronix.de>
 <dab8407a-7cff-392c-46b7-effc8ee7ecff@seco.com>
 <20210630083513.gi3yql5u3tzuub3e@pengutronix.de>
Message-ID: <ddd2ad0c-1dff-c437-17a6-4c7be72c2fce@seco.com>
Date:   Thu, 8 Jul 2021 12:59:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210630083513.gi3yql5u3tzuub3e@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.10 via Frontend Transport; Thu, 8 Jul 2021 16:59:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67d19458-6c27-44ba-f1e9-08d94231bc89
X-MS-TrafficTypeDiagnostic: DBBPR03MB5367:
X-Microsoft-Antispam-PRVS: <DBBPR03MB536744C0D555A5134E0A7E0A96199@DBBPR03MB5367.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a7zvHBB5wB8PzJpi1lWIgdXYTyvrfcGUOhA/5WSECSByzxXBT4/6/kysDxMCuxvjYI6UhlXNG7Rd4VOHSpp2/LeHf+Ri/Qu5r/m2efBRI0KR5xXh3V2MgZDgrVpnsSMX/lAZjxFfNL+gbTa8LN1vloOgK8avF1uzJmLRhurESKoo5x7dtOvjed/kfi7CGEUfUAkAe5jXj7NNtoS1TdrU3XGzBITcjtCe8r5l0U9i0GcevVjwSch6kkPyAeUczzzaGPgQP7SnYUt1+leo0z3Mgj1A9fo4N3Awk121oJgLTo6LGIsrk+APOvlu/VsaHZ/SkOwi5gcgv7xko00Y9Jjni1xPC7xjUIlFmv7/vkPD218lgqUy9rUzgOTZpAI2AUnd8xzlQMwTtl/mB3fX9sPP1Kg3Vrjr1Fp9TnOv9gA24/ciQFmp54o6iR1nhKkn/LX88m535t2BjyzsvhRReTw7stosi5MbSQfcfH3/KRIjVSvnpLozSx8A0J++DYLRZSMIwLYRxzEw1sEYet+g+X/yFvoJ24kyyQRP5TtFXoAdyoAtgxhL5PdGdxZyc+lSvWagTCOiRUFp/XnySc/E0qS2Jc50RnYP1G8UEztcRG2WxDtc6zKhRW4BVcqiVHQCB3wdvH7Gm+7mthYLtjtMDk2gH3hOb6v54EGRCnat9YIHztQ8xLL3VcTMLM8bBzDhKJueR9u3rCLYR09Hboy38lgeHBXEgjo2EiNAET205KGApgu6cv71YQXP5zhjmQhNCNr24PVY1S/l2mP4v9kojOiw8LQPY2pO8+gj8QRWzvXAf7zgE42SlaU0zkdhBTyizabnO1qijJBdrPMJQxB00qAGjNDV4IT0ewhPTEwMVIc65fg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(346002)(136003)(366004)(376002)(396003)(30864003)(54906003)(31686004)(6916009)(86362001)(66574015)(16576012)(316002)(2906002)(7416002)(53546011)(966005)(478600001)(31696002)(5660300002)(6486002)(36756003)(38100700002)(38350700002)(66476007)(66556008)(6666004)(4326008)(83380400001)(8936002)(8676002)(956004)(52116002)(186003)(2616005)(44832011)(26005)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?XMPLhq99xup2Eifn7C8ZZFkntmQyMsAsdjVlidN3wgvXHB3OvNiNevvk?=
 =?Windows-1252?Q?u1qvox6U/VQi2xKiMMmfdwZAzV9rQiy/HRFaqk3/VKPDtd1VPsWxeUAn?=
 =?Windows-1252?Q?DB9lwmG1P0TpqNIuHSgXSW4NpHZ+nwLoc1q37/THKUgUZVHa3HoIfXiw?=
 =?Windows-1252?Q?uYJmGaZP576H7N8Sa0QumzT4xqODM0mwMTmihVb/+WZx2moy96Ep6wSB?=
 =?Windows-1252?Q?GkcuW2M5kumQxEqoCabcVHqfbrHktOfeiQYp8Wg8XFjjP6T9w1o1w4Yt?=
 =?Windows-1252?Q?KRr6phV2g08ao0osQYJUDbQyXGR0AsaB0JTr9Jj9NSuk3EOoNQN3OVqt?=
 =?Windows-1252?Q?tSBu5DZZaB7yHR7dBM9/Jd3JMMzlfBEjWqcA71C4g2psIpRoMgamoGUb?=
 =?Windows-1252?Q?aH0O0f9yOIafCwAp85HqYiTxugnI3i5X4wIydJbYLrc9zt1oFSrnpHfv?=
 =?Windows-1252?Q?Ou6i+47j5z5nS0ZUTypgbfxxbgLdxQqfPAbPIo2s75qmkb4U0lkEXgiI?=
 =?Windows-1252?Q?XoKD+63Yu1opzili+PDnfMLEYIYPHsxrggB4Uj40IgbUPLZpk0VjY81t?=
 =?Windows-1252?Q?hAJjlUrWd4seWeJcC2djgdeq9K1AZBsfIrS3z6PFC09X3nUp8ioifdKX?=
 =?Windows-1252?Q?l7T9PqShN2eUw+/M52wUboQC4hLX8jusNkAuik8gN7xm6ge56DKZfoWg?=
 =?Windows-1252?Q?yS0YtkY/DFH2TsgMG5o0Ui2E9YvRn/hvQpUd528/he69BCnhpOiM7YFw?=
 =?Windows-1252?Q?bbWxR6+rlG8OSK4zgpMDCIb+ytFdEM3gGY0L+Lf21/qE1+EEE7Hc/h86?=
 =?Windows-1252?Q?8m9Uh0ecsrALUjlJH/o36rMTev7ngIVbMxETXdUHsRu2hXNXdQG7l4LL?=
 =?Windows-1252?Q?8LsCSxgLmhXGz9l+Dj+e+xHBuXN4r9iq8zsHrgHpXhfQCcJvwe0t0OnZ?=
 =?Windows-1252?Q?UJSpgcIGmHPvV4oXjEJu4KcDYR9xwKDM368oFLNkIyE94rygejIadL2X?=
 =?Windows-1252?Q?V38riSBjhRr4aojqGvZc/lVVzuPfNzm96YfborTitdOO5grHr/zOYPfP?=
 =?Windows-1252?Q?6CPkx364HrBrw/M/NOMMQzBNgM39eRqCDJyj8cDmiv7WS/78HRWdMHWs?=
 =?Windows-1252?Q?ffAyq24V+cm2PTuTBX1obK4nXp7JxgcvMZ9aa8DqAgGkFXkkXvZ7Y9Z5?=
 =?Windows-1252?Q?yGSoZn4F7ANlb/Y6/unE4Xj8gVCDQtfrejU23TnP00n0BuXvhb8DUKy0?=
 =?Windows-1252?Q?uIVdV9QYMP36lFCIob7e4zSwZsM7JTZ3k9UVlvT3RDtW/Qfh3c3byWfL?=
 =?Windows-1252?Q?w/dJURVtZdigfQqW6KCywrgIK6AkCdoNg2pPEhSn0i6dtgm502TIC15s?=
 =?Windows-1252?Q?aCYu7xy86eX7w2L5hKWfjchFLfx5kyLZDy8wNygkSnzxWQ15j+FMVsF9?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d19458-6c27-44ba-f1e9-08d94231bc89
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2021 16:59:23.5192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43Q+idMp9IZdccqLV+VIZ1EhM3nWVLV9YNcq4rCJ9/pki0eIHvpzQhniLiGpwba3AGaGXCiiXyGndNNNBy8XQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB5367
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 6/30/21 4:35 AM, Uwe Kleine-König wrote:
> Hello Sean,
>
> I often mistype the name of the rounding function as "pwm_round_rate",
> the better name is "pwm_round_state" of course. That's just me thinking
> about clk_round_rate where ".._rate" is the right term. I'll try harder
> to get this right from now on.
>
> On Tue, Jun 29, 2021 at 06:21:15PM -0400, Sean Anderson wrote:
>> On 6/29/21 4:51 PM, Uwe Kleine-König wrote:
>> > On Tue, Jun 29, 2021 at 02:01:31PM -0400, Sean Anderson wrote:
>> > > On 6/29/21 4:31 AM, Uwe Kleine-König wrote:
>> > > > On Mon, Jun 28, 2021 at 01:41:43PM -0400, Sean Anderson wrote:
>> > > >> On 6/28/21 1:20 PM, Uwe Kleine-König wrote:
>> > > >> > On Mon, Jun 28, 2021 at 12:35:19PM -0400, Sean Anderson wrote:
>> > > >> >> On 6/28/21 12:24 PM, Uwe Kleine-König wrote:
>> > > >> >> > On Mon, Jun 28, 2021 at 11:50:33AM -0400, Sean Anderson wrote:
>> > > >> >> > > On 6/27/21 2:19 PM, Uwe Kleine-König wrote:
>> > > >> >> > > > On Fri, Jun 25, 2021 at 01:46:26PM -0400, Sean Anderson wrote:
>> > > >> >> > > IMO, this is the best way to prevent surprising results in the API.
>> > > >> >> >
>> > > >> >> > I think it's not possible in practise to refuse "near" misses and every
>> > > >> >> > definition of "near" is in some case ridiculous. Also if you consider
>> > > >> >> > the pwm_round_state() case you don't want to refuse any request to tell
>> > > >> >> > as much as possible about your controller's capabilities. And then it's
>> > > >> >> > straight forward to let apply behave in the same way to keep complexity
>> > > >> >> > low.
>> > > >> >> >
>> > > >> >> > > The real issue here is that it is impossible to determine the correct
>> > > >> >> > > way to round the PWM a priori, and in particular, without considering
>> > > >> >> > > both duty_cycle and period. If a consumer requests very small
>> > > >> >> > > period/duty cycle which we cannot produce, how should it be rounded?
>> > > >> >> >
>> > > >> >> > Yeah, because there is no obviously right one, I picked one that is as
>> > > >> >> > wrong as the other possibilities but is easy to work with.
>> > > >> >> >
>> > > >> >> > > Should we just set TLR0=1 and TLR1=0 to give them 66% duty cycle with
>> > > >> >> > > the least period? Or should we try and increase the period to better
>> > > >> >> > > approximate the % duty cycle? And both of these decisions must be made
>> > > >> >> > > knowing both parameters. We cannot (for example) just always round up,
>> > > >> >> > > since we may produce a configuration with TLR0 == TLR1, which would
>> > > >> >> > > produce 0% duty cycle instead of whatever was requested. Rounding rate
>> > > >> >> > > will introduce significant complexity into the driver. Most of the time
>> > > >> >> > > if a consumer requests an invalid rate, it is due to misconfiguration
>> > > >> >> > > which is best solved by fixing the configuration.
>> > > >> >> >
>> > > >> >> > In the first step pick the biggest period not bigger than the requested
>> > > >> >> > and then pick the biggest duty cycle that is not bigger than the
>> > > >> >> > requested and that can be set with the just picked period. That is the
>> > > >> >> > behaviour that all new drivers should do. This is somewhat arbitrary but
>> > > >> >> > after quite some thought the most sensible in my eyes.
>> > > >> >>
>> > > >> >> And if there are no periods smaller than the requested period?
>> > > >> >
>> > > >> > Then return -ERANGE.
>> > > >>
>> > > >> Ok, so instead of
>> > > >>
>> > > >> 	if (cycles < 2 || cycles > priv->max + 2)
>> > > >> 		return -ERANGE;
>> > > >>
>> > > >> you would prefer
>> > > >>
>> > > >> 	if (cycles < 2)
>> > > >> 		return -ERANGE;
>> > > >> 	else if (cycles > priv->max + 2)
>> > > >> 		cycles = priv->max;
>> > > >
>> > > > The actual calculation is a bit harder to handle TCSR_UDT = 0 but in
>> > > > principle, yes, but see below.
>> > > >
>> > > >> But if we do the above clamping for TLR0, then we have to recalculate
>> > > >> the duty cycle for TLR1. Which I guess means doing something like
>> > > >>
>> > > >> 	ret = xilinx_timer_tlr_period(priv, &tlr0, tcsr0, state->period);
>> > > >> 	if (ret)
>> > > >> 		return ret;
>> > > >>
>> > > >> 	state->duty_cycle = mult_frac(state->duty_cycle,
>> > > >> 				      xilinx_timer_get_period(priv, tlr0, tcsr0),
>> > > >> 				      state->period);
>> > > >>
>> > > >> 	ret = xilinx_timer_tlr_period(priv, &tlr1, tcsr1, state->duty_cycle);
>> > > >> 	if (ret)
>> > > >> 		return ret;
>> > > >
>> > > > No, you need something like:
>> > > >
>> > > > 	/*
>> > > > 	 * The multiplication cannot overflow as both priv_max and
>> > > > 	 * NSEC_PER_SEC fit into an u32.
>> > > > 	 */
>> > > > 	max_period = div64_ul((u64)priv->max * NSEC_PER_SEC, clkrate);
>> > > >
>> > > > 	/* cap period to the maximal possible value */
>> > > > 	if (state->period > max_period)
>> > > > 		period = max_period;
>> > > > 	else
>> > > > 		period = state->period;
>> > > >
>> > > > 	/* cap duty_cycle to the maximal possible value */
>> > > > 	if (state->duty_cycle > max_period)
>> > > > 		duty_cycle = max_period;
>> > > > 	else
>> > > > 		duty_cycle = state->duty_cycle;
>> > >
>> > > These caps may increase the % duty cycle.
>> >
>> > Correct.
>> >
>> > For some usecases keeping the relative duty cycle might be better, for
>> > others it might not. I'm still convinced that in general my solution
>> > makes sense, is computationally cheaper and easier to work with.
>>
>> Can you please describe one of those use cases? Every PWM user I looked
>> (grepping for pwm_apply_state and pwm_config) set the duty cycle as a
>> percentage of the period, and not as an absolute time. Keeping the high
>> time the same while changing the duty cycle runs contrary to the
>> assumptions of all of those users.
>
> Indeed there is no mainline driver that relies on this. There are some
> smart LED controllers (e.g. WS2812B) where the duty_cycle is more
> important than the period. (I admit a PWM is not really the right driver
> for that one as it could only completely enable and complete disable
> white color.) Also there are some servo motor chips where the absolute
> duty is relevant but the period isn't (in some range). (See
> https://www.mikrocontroller.net/articles/Modellbauservo_Ansteuerung#Signalaufbau
> for a article about that (in German though).)

> In case you want to argue that out-of-mainline users don't count:

They don't :)

This is a kernel-internal API.

But my point is that the vast majority of PWM users, and 100% of the
in-kernel users care about the % duty cycle and not about the absolute
high time. We should design around the common use case first and
foremost.

> I think in the design of an API they do count to place the bar to
> enter the mainline low. Frameworks should be generic enough to cover
> as much use cases as possible.

They can cover many use-cases as possible, but they should be ergonomic
firstly for the most common use case.

> And note that if you want a nearest to (say) 50% relative duty cycle and
> don't care much about the period it doesn't really matter if you scale
> duty_cycle in pwm_round_state() to the period change or not because in
> general you need several calls to pwm_round_state() anyhow to find a
> setting with 51% if the next lower possibility is 47%. So in the end you
> save (I think) one call in generic PWM code.
>
> In contrast the math gets quite a bit more complicated because there is
> rounding involved in scaling the duty cycle. Consider a PWM that can
> configure period and duty in 16.4 ns steps and you ask for
>
> 	.period = 100 ns
> 	.duty_cycle = 50 ns
>
> Then the best period you can provide is 98.4 ns, so you return .period =
> 99 from pwm_round_state(). (Yes, you don't return 98, because
> round-nearest is much harder to handle than round down.)
> To determine the adapted duty_cycle you have to do
>
> 	50 * realperiod / 100
>
> which independently of choosing 98, 98.4 or 99 for realperiod is 49. Then
> to approximate 49 without rounding up you end up with 32.8 while 49.2
> would have be perfectly fine.

And what if the consumer comes and requests 49 for their period in the
first place? You have the same problem. The rescaling made it worse in
this instance, but this is just an unfortunate case study.

> You might find a way around that (maybe you have to round up in the
> adaption of duty_cycle, I didn't convince myself this is good enough
> though).
>
> So your suggestion to adapt the duty_cycle to keep the relative
> duty_cycle constant (as good as possible within the bounds the hardware
> dictates) implies additional complication at the driver level.
>
>  From a framework maintainer's point of view (and also from a low-level
> driver maintainer's point of view) I prefer one complication in a
> generic function over a complication that I have to care for in each and
> every low-level driver by a big margin.

FWIW what you're suggesting is also complex for the low-level driver.

>
> So unless you volunteer to complete the math above and promise to review
> low-level drivers for that aspect in the future (or alternatively
> convince me that math is easy and I missed something) I would like to
> end this discussion here and stay with the policy I explained.

see below

>> > > > 	period_cycles = period * clkrate / NSEC_PER_SEC;
>> > > >
>> > > > 	if (period_cycles < 2)
>> > > > 		return -ERANGE;
>> > > >
>> > > > 	duty_cycles = duty_cycle * clkrate / NSEC_PER_SEC;
>> > > >
>> > > > 	/*
>> > > > 	 * The hardware cannot emit a 100% relative duty cycle, if
>> > > > 	 * duty_cycle >= period_cycles is programmed the hardware emits
>> > > > 	 * a 0% relative duty cycle.
>> > > > 	 */
>> > > > 	if (duty_cycle == period_cycles)
>> > > > 		duty_cycles = period_cycles - 1;
>> > > >
>> > > > 	/*
>> > > > 	 * The hardware cannot emit a duty_cycle of one clk step, so
>> > > > 	 * emit 0 instead.
>> > > > 	 */
>> > > > 	if (duty_cycles < 2)
>> > > > 		duty_cycles = period_cycles;
>> > >
>> > > Of course, the above may result in 100% duty cycle being rounded down to
>> > > 0%. I feel like that is too big of a jump to ignore. Perhaps if we
>> > > cannot return -ERANGE we should at least dev_warn.
>> >
>> > You did it again. You picked one single case that you consider bad but
>> > didn't provide a constructive way to make it better.
>>
>> Sure I did. I suggested that we warn. Something like
>>
>> if (duty_cycles == period_cycles)
>> 	if (--duty_cycles < 2)
>> 		dev_warn(chip->dev, "Rounding 100%% duty cycle down to 0%%; pick a longer period\n");
>>
>> or
>>
>> if (period_cycles < 2)
>> 	return -ERANGE;
>> else if (period_cycles < 10)
>> 	dev_notice(chip->dev,
>> 		   "very short period of %u cycles; duty cycle may be rounded to 0%%\n",
>> 		   period_cycles);
>
> Ah ok, so only a 100% jump warrants that warning.
> I think adding that
> has no practical relevance, so I don't oppose to that. Add it if you
> want. (But note that if it triggers indeed it might flood the kernel log
> if your consumer wants to start a motor but notices it doesn't run fast
> enough and so configures 100% in a tight loop. So I would recommend some
> rate limiting.)
>
>> Because 90% of the time, if a user requests such a short period it is
>> due to a typo or something similar. And if they really are doing it
>> intentionally, then they should just set duty_cycle=0.
>
> Uh, don't you think that a warning that is wrong in 10% of the cases is
> bad?

Yes. Which is why I would prefer to use the first warning.

>> > Assume there was already a pwm_round_state function (that returns the
>> > state that pwm_apply_state would implement for a given request) Consider
>> > a consumer that wants say a 50% relative duty together with a small
>> > period. So it first might call:
>> >
>> > 	ret = pwm_round_rate(pwm, { .period = 20, .duty_cycle = 20, ... }, &rounded_state)
>> >
>> > to find out if .period = 20 can be implemented with the given PWM. If
>> > this returns rounded state as:
>> >
>> > 	.period = 20
>> > 	.duty_cycle = 0
>> >
>> > this says quite a lot about the pwm if the driver implements my policy.
>> > (i.e.: The driver can do 20ns, but the biggest duty_cycle is only 0).
>> > If however it returns -ERANGE this means (assuming the driver implements
>> > the policy I try to convice you to be the right one) it means: The
>> > hardware cannot implement 20 ns (or something smaller) and so the next
>> > call probably tries 40 ns.
>> >
>> > With your suggested semantic -ERANGE might mean:
>> >
>> >   - The driver doesn't support .period = 20 ns
>> >     (Follow up questions: What period should be tried next? 10 ns? 40
>> >     ns? What if this returns -ERANGE again?)
>> >   - The driver supports .period = 20 ns, but the biggest possible
>> >     duty_cycle is "too different from 20 ns to ignore".
>> >
>> > Then how should the search continue?
>>
>> round_rate does not have to use the same logic as apply_state.
>
> I want to have .round_state() and .apply() (i.e. the driver callbacks)
> to behave identically. If we indeed come to the conclusion that
> pwm_apply_state needs to have some precautions, I'd like to have them
> implemented in pwm_apply_state() only and not in every driver.
>
>> However, calling
>>
>> 	ret = pwm_apply_state(pwm, { .period = 20, .duty_cycle = 0, ... })
>>
>> should work just fine, as the caller clearly knows what they are getting
>> into. IMO this is the best way to allow hypothetical round_rate users to
>> find out the edges of the PWM while still protecting existing users.
>>
>> It's perfectly fine to round
>>
>> 	{ .period = 150, .duty_cycle = 75 }
>>
>> to
>>
>> 	{ .period = 100, .duty_cycle = 75 }
>>
>> in round_rate. But doing the same thing for apply_state would be very
>> surprising to every existing PWM user.
>>
>> IMO the following invariant should hold
>>
>> 	apply_state(round_rate(x))
>> 	assert(round_rate(x) == get_state())
>
> (merged your correction of the follow up mail into the quote above)
>
> (Fun fact: Only needing this one would allow a generic implementation of
> round_state, it just had to return a pwm_state that doesn't depend on x
> :o)

Maybe. The only constraint is that the state returned by round_rate is
possible to implement on the hardware without modification. See below
for further discussion.

>> but the following should not necessarily hold
>>
>> 	apply_state(x)
>> 	assert(round_rate(x) == get_state())
>>
>> Of course, where it is reasonable to round down, we should do so.
>>
>> But where the result may be surprising, then the caller should specify
>> the rounded state specifically. It is better to fail loudly and
>> noisily than
>> to silently accept garbage.
>
> Can you please come up with an algorithm to judge if a given deviation
> is reasonable or surprising? I agree there are surprises and some of
> them are obviously bad. For most cases however the judgement depends on
> the use case so I fail to see how someone should program such a check
> that should cover all consumers and use cases. I prefer no precautions +
> an easy relation between pwm_round_state and pwm_apply_state (i.e.
> behave identically) over a most of the time(?) useless precaution and
> some policy defined differences between pwm_round_state and
> pwm_apply_state

After thinking it over, I believe I agree with you on most things, but I
think your proposed API has room for additional checks without any loss
of generality.

The PWM subsystem has several major players:

* Existing users of the PWM API. Most of these do not especially care
   about the PWM period, usually just leaving at the default. The
   exception is of course the pwm-clk driver. Many of these users care
   about % duty cycle, and they all calculate the high time based on the
   configured period of the PWM. I suspect that while many of these users
   have substantial leeway in what accuracy they expect from the % duty
   cycle, significant errors (in the 25-50% range) are probably unusual
   and indicative of a misconfigured period. Unfortunately, we cannot
   make a general judgement about what sort of accuracy is OK in most
   cases.

* Hypothetical future users of some kind of round_state function. These
   users have some kind of algorithm which determines whether a PWM state
   is acceptable for the driver. Most of the time this will be some kind
   of accuracy check. What the round_state function returns is not
   particularly important, because users have the opportunity to revise
   their request based on what the state is rounded to. However, it is
   important that each round rate function is consistent in manner that
   it rounds so that these users

* Existing drivers for the PWM subsystem. These drivers must implement
   an apply_state function which is correct for both existing and future
   users. In addition, they may implement some kind of round_state
   function in the future. it is important to reduce the complexity of
   the calculations these drivers perform so that it is easier to
   implement and review them.

I believe the following requirements satisfy the above constraints:

* The round_state function shall round the period to the largest period
   representable by the PWM less than the requested period. It shall also
   round the duty cycle to the largest duty cycle representable by the
   PWM less than the requested duty cycle. No attempt shall be made to
   preserve the % duty cycle.
* The apply_state function shall only round the requested period down, and
   may do so by no more than one unit cycle. If the requested period is
   unrepresentable by the PWM, the apply_state function shall return
   -ERANGE.
* The apply_state function shall only round the requested duty cycle
   down. The apply_state function shall not return an error unless there
   is no duty cycle less than the requested duty cycle which is
   representable by the PWM.
* After applying a state returned by round_state with apply_state,
   get_state must return that state.

The reason that we must return an error when the period is
unrepresentable is that generally the duty cycle is calculated based on
the period. This change has no affect on future users of round_state,
since that function will only return valid periods. Those users will
have the opportunity to detect that the period has changed and determine
if the duty cycle is still acceptable. However, for existing users, we
should also provide the same opportunity. This requirement simplifies
the behavior of apply_state, since there is no longer any chance that
the % duty cycle is rounded up. This requirement is easy to implement in
drivers as well. Instead of writing something like

	period = clamp(period, min_period, max_period);

they will instead write

	if (period < min_period || period > max_period)
		return -ERANGE;

Instead of viewing round_state as "what get_state would return if I
passed this state to apply_state", it is better to view it as "what is
the closest exactly representable state with parameters less than this
state." I believe that this latter representation is effectively
identical for users of round_state, but it allows for implementations of
apply_state which provide saner defaults for existing users.

--Sean
