Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96BF3B7783
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Jun 2021 20:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbhF2SEG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 29 Jun 2021 14:04:06 -0400
Received: from mail-db8eur05on2065.outbound.protection.outlook.com ([40.107.20.65]:18529
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231856AbhF2SEF (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 29 Jun 2021 14:04:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHXTw27m/U+rdtcaCvuhtLMnSyESYbjmitOMZ18MH55IrYkaBPO1t9e82HuQ1wcQy0Yp2mUyvJKbx2jEWw6iql23tgPEcMZPurpe4n37Kyml4WHPpBoJFy3kfTNN9Tp1AO5Q2QA3X/NUiGvfthWppHvoWD8G6f+SYce3Dl/e95n7+/sagZZBKjE5cq5HBcjtV54MeEo2UQ/nUyIKfez68hcUqdiroZMFVgXsXp9XHKr/OpqAzbSVJCUBqOjvucljtiq53jbEuVq/4BWgMm3dMX8KBB0fGOgVRS7K69jqcLjVVWJaESTN5nrPGOGOeptsaoZX/bFn7oiQYhqANxg+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sS4vN0B007EKkP1XMPd8fLlcPKLBb6hFPWHQrWCzXFM=;
 b=YXbql60NwBDkPgxF8FD7RbE43qtGLCTYDkXpNTR9IAvuooA5Sc34w2wBf0VS+v3n256MovG3mbeXRtE2S9B8mahyyy/WydEAW2+4NC/KYxDYsB5QrBxwDIPfD1hXjO308w+i5IqOzc9UxRpVECVb5Go2PWnEr2RhDjnXJ38+U9EdNVARozMXl1iTlXtYifD4TK/cgyrKXQHl97Sf4OlX3eT/kvfaJn4Pl0NJ0BANQv8JzObXNfovg/3kar5pIrKgjgplxnxPiLWhndS20Cgd4gkMmcVrOzW8z7kx662NzXcED5Rgba/QVFd8NorFy5OcrJZ9yce8EyWlHDKDRE6Txw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sS4vN0B007EKkP1XMPd8fLlcPKLBb6hFPWHQrWCzXFM=;
 b=nphjRgsEkJE8A0D/FUYL3BVY/aEa8hb2gqp5qQKlw0pFKUFIoGcCRi1/UmmoAGDwkZqnu6DbFtCvM86sy+MQs+QB8RmuFyYp+0FRJBOg2eX8AebWDzsE2yKDko/tCJtdIuQslu/xT8rjx994fRIlvRuUa5tvEUpFc2En202EwA8=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBAPR03MB6390.eurprd03.prod.outlook.com (2603:10a6:10:17f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23; Tue, 29 Jun
 2021 18:01:36 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 18:01:35 +0000
Subject: Re: [PATCH v4 3/3] pwm: Add support for Xilinx AXI Timer
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Emil Lenngren <emil.lenngren@gmail.com>,
        michal.simek@xilinx.com, Alvaro Gamez <alvaro.gamez@hazent.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
References: <20210625061958.yeaxjltuq7q2t7i7@pengutronix.de>
 <a748143d-f157-562e-795d-dcd9a0cf9d85@seco.com>
 <20210625165642.5iuorl5guuq5c7gc@pengutronix.de>
 <f1772da9-8bd8-57cf-6eba-3c16c58a903f@seco.com>
 <20210627181919.iunagls4j67ignhh@pengutronix.de>
 <59e93f67-0552-04bb-116e-73ddf878761e@seco.com>
 <20210628162407.dxxt6hqfzeokdtxa@pengutronix.de>
 <27fca5ef-8c82-f122-4bd0-f595cad4d588@seco.com>
 <20210628172021.q5enzmr7u6cornm6@pengutronix.de>
 <661e52c3-cd79-c2aa-e031-64eef5617be0@seco.com>
 <20210629083144.53onthkcchbk73lo@pengutronix.de>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <a4943aa5-956c-1820-3489-994f0812c3a7@seco.com>
Date:   Tue, 29 Jun 2021 14:01:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210629083144.53onthkcchbk73lo@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: BL1PR13CA0235.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::30) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL1PR13CA0235.namprd13.prod.outlook.com (2603:10b6:208:2bf::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.13 via Frontend Transport; Tue, 29 Jun 2021 18:01:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0388fe9a-99fb-48fc-06e0-08d93b27ef65
X-MS-TrafficTypeDiagnostic: DBAPR03MB6390:
X-Microsoft-Antispam-PRVS: <DBAPR03MB639059CAA2B1CA7B640783B596029@DBAPR03MB6390.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FinYwhZly32KKCBJ7lBUr0UUnH5aRy+K8ekHNpp6KeeCkfFD29md18qgg4fQGj2JWm8oHXY383PUfPqC1RDzsxK/jFmkwVgF2t137V/a4RtVJx/V7aKKi4Q0Xw9EZ8u/qVIXEeKDGfsQH1MKd5WmU5255VmPwAqP0psyoyI86+1Kczn+YvAApAvE8ulqmxWJRU6iZm31VzIhSmeAZCxhMSlelb2dLvtTYjxeK3XrDRR+pYa5J6Sr08JvgSY2Lz3lprsSIXzi9w5nv5CYOTRno0Tfe753b40q9R8JXtoxStXyg4nm7yb5kYFsOkoYF9Xr1oUfGjOLRT5PUwyJci/kxPCLdsFyTfULsgWraC6X9wtmCF9iKXMo91bImT3i9zfBt4KksLrGU8a/iXJFwRKBmD1KGOzmn5dYho/ppzO8OwNgW9rViNb2PR/m8/nKxZLuU8OalrybomtuLSckIxwCOE+cwTVj10fFVTMGph+jVAyTzbvqti0hAxHJoR4m1fGpNw5yPvIhoic13Z/tw5s0vUejTS+CAQr7CVYCWa7CPUVJJQzNznx1GwX4gmkvbuwreIg+jwfl/iRS3rID+iWLX+Sdh3ivmml58sYic3tYI8E2hHIRiwGtX1W1toT4/RxljoyFD7bk9jY1C/rdq17CvfOUnEObSVk48b4o+Da/9+fGBcwfUU9rgZ4f/f5mGfOe868BocdFlTpWFm4X5xnB15OruVSx7C3x6A6fnfRVQyXjb6tam7xyZoPVqgL9gfnUXM9Mzv6gVpo1ynm96f1GTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39840400004)(346002)(136003)(376002)(66556008)(66476007)(66946007)(2906002)(36756003)(5660300002)(186003)(16526019)(478600001)(6486002)(6916009)(31686004)(31696002)(66574015)(2616005)(956004)(7416002)(4326008)(52116002)(44832011)(26005)(8936002)(8676002)(316002)(16576012)(54906003)(86362001)(38350700002)(38100700002)(6666004)(53546011)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?txH+B7fE56gaHGoQ+B6W06fzU01ikuXqb8wLF4xOYlm7oNxA+Cx3ph4R?=
 =?Windows-1252?Q?u2MtSO8SOb/fBGcU2tpXWZh8oBcWl1OLtG6xZMeNucupvfxv6FWusvd2?=
 =?Windows-1252?Q?zI9jufETq3aY41SWQ+FYQQ2LKekJb3SVEZiFODHdRPFKZsOav3uesnDn?=
 =?Windows-1252?Q?vi2VpezoI/zC2YYa7DICjXGQGbv85DBtnq6SWPtUPfqcCVJ6qr8mNPMu?=
 =?Windows-1252?Q?yhg66IGacqDmENP/JzFvsRdd7pPElodOq/YaFMN2VHF9PYQyGYZD08VN?=
 =?Windows-1252?Q?H24ltv6MpDjP+Toqn7jy5mBrvQmnjUJO06qmHkKllXhlLrE8RGUJMg2S?=
 =?Windows-1252?Q?T2VgS/ToUKQWws29Tx1t9hEoey6mVUr8DNQy2DrxRoPJKl6f6GlzT57W?=
 =?Windows-1252?Q?gqgzqBHuAAPbRNQnyYD/M08HdzPz0aDRFhN6JH9pVBEXf4aBOz8pWB4h?=
 =?Windows-1252?Q?mabcrVZwncaQER9KsmqC9as/GZ6EBANxTganOADkuuycj91jM1xrpz+x?=
 =?Windows-1252?Q?avxSkLcUNIJnFuynTupUM7mAK+oz42ZE9YIpzqdoT9DehxlLCQ4HR/eY?=
 =?Windows-1252?Q?EC/ZIQGxwf7DiH57Bxvc2uBpMYm23O0DEt9hTufmb6TvKCaM6MHpywUQ?=
 =?Windows-1252?Q?Mb5UIRABJGtZ5fiqbXztNd7xN7CS4pC+UKN3agwNd/TaWC82e67w+iMG?=
 =?Windows-1252?Q?BdP9oRkkJ0J8bSvyWiGM0DgqAvA63EPQwMXrDVgNimtBGHsDciJaohOa?=
 =?Windows-1252?Q?egUdJgMsJA2MJ8vir2Jnidvh+QPMYy+PcxxMlpZ7Svgd1eIwV2YkXrou?=
 =?Windows-1252?Q?Yt7z83MrLiDxIj4ZRICa/pcbuty2ovYdS7/fH2VP8CyizwAoMRENhUVp?=
 =?Windows-1252?Q?Ylp6tVuChs04do+pOExQvZ178xhsJJTXB+9GKhAIuY4VodALLw/4P7OH?=
 =?Windows-1252?Q?vA96DJZg914L2JFq0T8RsI4uwwYT/oYXBmi6cvk9yYRexN2QGZ3RXGyk?=
 =?Windows-1252?Q?2TTx1ktq9XQQenQFph3DUVZX6gfSeOVzPhmQzi9bzU+xUwRrBStHH5p4?=
 =?Windows-1252?Q?T9YOjRKrZqLeDZUwaYqajQwtH5gZtY9E5Kwq/8FS8KjmeBAUsWMeRThz?=
 =?Windows-1252?Q?fk9qKUasTb/4naBlAapA4T9f4Z4a6wlJU5Z3qgBfZzYS7C9ThR1fD9Ss?=
 =?Windows-1252?Q?EeUDn3Q7xCetkVxwhw9TceQv7ihAn1Vtl9Mj+ed0qOp/4e/cEjU67xCC?=
 =?Windows-1252?Q?rpPuRiCMYXV5UXgE66AjvfH+ky1B6j6WColPT3h8aHh4vFLx0mFvDshZ?=
 =?Windows-1252?Q?Np3B93g6pWI/s6jkPY7u5I5BIYw8H36nbL4mgZafVsc/r46jIor6mlSK?=
 =?Windows-1252?Q?06IeakVyxoD+ndF1hgJVwxViwHykHRmQW1pAqW0LZ4+6SAuAzgXPc0Kf?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0388fe9a-99fb-48fc-06e0-08d93b27ef65
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 18:01:35.8962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1pTWrJ4cMLfDcV0mOHfmz3EBwzXO0Rx24WEYZCTM6RC+GLeEFdb50yTIA4gtMcdZ9p8QcJASgXtpSlICrXH4ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6390
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 6/29/21 4:31 AM, Uwe Kleine-König wrote:
 > Hello Sean,
 >
 > On Mon, Jun 28, 2021 at 01:41:43PM -0400, Sean Anderson wrote:
 >> On 6/28/21 1:20 PM, Uwe Kleine-König wrote:
 >> > On Mon, Jun 28, 2021 at 12:35:19PM -0400, Sean Anderson wrote:
 >> >> On 6/28/21 12:24 PM, Uwe Kleine-König wrote:
 >> >> > On Mon, Jun 28, 2021 at 11:50:33AM -0400, Sean Anderson wrote:
 >> >> > > On 6/27/21 2:19 PM, Uwe Kleine-König wrote:
 >> >> > > > On Fri, Jun 25, 2021 at 01:46:26PM -0400, Sean Anderson wrote:
 >> >> > > > > So for the moment, why not give an error? This will be legal code both
 >> >> > > > > now and after round_state is implemented.
 >> >> > > >
 >> >> > > > The problem is where to draw the line. To stay with your example: If a
 >> >> > > > request for period = 150 ns comes in, and let X be the biggest period <=
 >> >> > > > 150 ns that the hardware can configure. For which values of X should an
 >> >> > > > error be returned and for which values the setting should be
 >> >> > > > implemented.
 >> >> > > >
 >> >> > > > In my eyes the only sensible thing to implement here is to tell the
 >> >> > > > consumer about X and let it decide if it's good enough. If you have a
 >> >> > > > better idea let me hear about it.
 >> >> > >
 >> >> > > Sure. And I think it's ok to tell the consumer that X is the best we can
 >> >> > > do. But if they go along and request an unconfigurable state anyway, we
 >> >> > > should tell them as much.
 >> >> >
 >> >> > I have the impression you didn't understand where I see the problem. If
 >> >> > you request 150 ns and the controller can only do 149 ns (or 149.6667 ns)
 >> >> > should we refuse? If yes: This is very unusable, e.g. the led-pwm driver
 >> >> > expects that it can configure the duty_cycle in 1/256 steps of the
 >> >> > period, and then maybe only steps 27 and 213 of the 256 possible steps
 >> >> > work. (This example doesn't really match because the led-pwm driver
 >> >> > varies duty_cycle and not period, but the principle becomes clear I
 >> >> > assume.) If no: Should we accept 151 ns? Isn't that ridiculous?
 >> >>
 >> >> I am fine with this sort of rounding. The part I take issue with is when
 >> >> the consumer requests (e.g.) a 10ns period, but the best we can do is
 >> >> 20ns. Or at the other end if they request a 4s period but the best we
 >> >> can do is 2s. Here, there is no obvious way to round it, so I think we
 >> >> should just say "come back with a reasonable period" and let whoever
 >> >> wrote the device tree pick a better period.
 >> >
 >> > Note that giving ridiculus examples is easy, but this doesn't help to
 >> > actually implement something sensible. Please tell us for your example
 >> > where the driver can only implement 20 ns what is the smallest requested
 >> > period the driver should accept.
 >>
 >> 20ns :)
 >>
 >> In the case of this device, that would result in 0% duty cycle with a
 >> 100MHz input. So the smallest reasonable period is 30ns with a duty
 >> cycle of 20ns.
 >
 > I took the time to understand the hardware a bit better, also to be able
 > to reply to your formulae below. So to recap (and simplify slightly
 > assuming TCSR_UDT = 1):
 >
 >
 >                TLR0 + 2
 >   period     = --------
 >                clkrate
 >
 >                TLR1 + 2
 >   duty_cycle = -------- if TLR1 < TLR0, else 0
 >                clkrate
 >
 >
 > where TLRx has the range [0..0xffffffff] (for some devices the range is
 > smaller). So clkrate seems to be 100 MHz?

On my system, yes.

 >
 >> >> > > IMO, this is the best way to prevent surprising results in the API.
 >> >> >
 >> >> > I think it's not possible in practise to refuse "near" misses and every
 >> >> > definition of "near" is in some case ridiculous. Also if you consider
 >> >> > the pwm_round_state() case you don't want to refuse any request to tell
 >> >> > as much as possible about your controller's capabilities. And then it's
 >> >> > straight forward to let apply behave in the same way to keep complexity
 >> >> > low.
 >> >> >
 >> >> > > The real issue here is that it is impossible to determine the correct
 >> >> > > way to round the PWM a priori, and in particular, without considering
 >> >> > > both duty_cycle and period. If a consumer requests very small
 >> >> > > period/duty cycle which we cannot produce, how should it be rounded?
 >> >> >
 >> >> > Yeah, because there is no obviously right one, I picked one that is as
 >> >> > wrong as the other possibilities but is easy to work with.
 >> >> >
 >> >> > > Should we just set TLR0=1 and TLR1=0 to give them 66% duty cycle with
 >> >> > > the least period? Or should we try and increase the period to better
 >> >> > > approximate the % duty cycle? And both of these decisions must be made
 >> >> > > knowing both parameters. We cannot (for example) just always round up,
 >> >> > > since we may produce a configuration with TLR0 == TLR1, which would
 >> >> > > produce 0% duty cycle instead of whatever was requested. Rounding rate
 >> >> > > will introduce significant complexity into the driver. Most of the time
 >> >> > > if a consumer requests an invalid rate, it is due to misconfiguration
 >> >> > > which is best solved by fixing the configuration.
 >> >> >
 >> >> > In the first step pick the biggest period not bigger than the requested
 >> >> > and then pick the biggest duty cycle that is not bigger than the
 >> >> > requested and that can be set with the just picked period. That is the
 >> >> > behaviour that all new drivers should do. This is somewhat arbitrary but
 >> >> > after quite some thought the most sensible in my eyes.
 >> >>
 >> >> And if there are no periods smaller than the requested period?
 >> >
 >> > Then return -ERANGE.
 >>
 >> Ok, so instead of
 >>
 >> 	if (cycles < 2 || cycles > priv->max + 2)
 >> 		return -ERANGE;
 >>
 >> you would prefer
 >>
 >> 	if (cycles < 2)
 >> 		return -ERANGE;
 >> 	else if (cycles > priv->max + 2)
 >> 		cycles = priv->max;
 >
 > The actual calculation is a bit harder to handle TCSR_UDT = 0 but in
 > principle, yes, but see below.
 >
 >> But if we do the above clamping for TLR0, then we have to recalculate
 >> the duty cycle for TLR1. Which I guess means doing something like
 >>
 >> 	ret = xilinx_timer_tlr_period(priv, &tlr0, tcsr0, state->period);
 >> 	if (ret)
 >> 		return ret;
 >>
 >> 	state->duty_cycle = mult_frac(state->duty_cycle,
 >> 				      xilinx_timer_get_period(priv, tlr0, tcsr0),
 >> 				      state->period);
 >>
 >> 	ret = xilinx_timer_tlr_period(priv, &tlr1, tcsr1, state->duty_cycle);
 >> 	if (ret)
 >> 		return ret;
 >
 > No, you need something like:
 >
 > 	/*
 > 	 * The multiplication cannot overflow as both priv_max and
 > 	 * NSEC_PER_SEC fit into an u32.
 > 	 */
 > 	max_period = div64_ul((u64)priv->max * NSEC_PER_SEC, clkrate);
 >
 > 	/* cap period to the maximal possible value */
 > 	if (state->period > max_period)
 > 		period = max_period;
 > 	else
 > 		period = state->period;
 >
 > 	/* cap duty_cycle to the maximal possible value */
 > 	if (state->duty_cycle > max_period)
 > 		duty_cycle = max_period;
 > 	else
 > 		duty_cycle = state->duty_cycle;

These caps may increase the % duty cycle. For example, consider when the
max is 100, and the user requests a period of 150 and a duty cycle of
75, for a % duty cycle of 50%. The current logic is equivalent to

	period = min(state->period, max_period);
	duty_cycle = min(state->duty_cycle, max_period);

Which will result in a period of 100 and a duty cycle of 75, for a 75%
duty cycle. Instead, we should do

	period = min(state->period, max_period);
	duty_cycle = mult_frac(state->duty_cycle, period, state->period);

which will result in a period of 100 and a duty cycle of 50.

 > 	period_cycles = period * clkrate / NSEC_PER_SEC;
 >
 > 	if (period_cycles < 2)
 > 		return -ERANGE;
 >
 > 	duty_cycles = duty_cycle * clkrate / NSEC_PER_SEC;
 >
 > 	/*
 > 	 * The hardware cannot emit a 100% relative duty cycle, if
 > 	 * duty_cycle >= period_cycles is programmed the hardware emits
 > 	 * a 0% relative duty cycle.
 > 	 */
 > 	if (duty_cycle == period_cycles)
 > 		duty_cycles = period_cycles - 1;
 >
 > 	/*
 > 	 * The hardware cannot emit a duty_cycle of one clk step, so
 > 	 * emit 0 instead.
 > 	 */
 > 	if (duty_cycles < 2)
 > 		duty_cycles = period_cycles;

Of course, the above may result in 100% duty cycle being rounded down to
0%. I feel like that is too big of a jump to ignore. Perhaps if we
cannot return -ERANGE we should at least dev_warn.

--Sean

 >> >> > > > > Perhaps I should add
 >> >> > > > >
 >> >> > > > > 	if (tlr0 <= tlr1)
 >> >> > > > > 		return -EINVAL;
 >> >> > > > >
 >> >> > > > > here to prevent accidentally getting 0% duty cycle.
 >> >> > > >
 >> >> > > > You can assume that duty_cycle <= period when .apply is called.
 >> >> > >
 >> >> > > Ok, I will only check for == then.
 >> >> >
 >> >> > You just have to pay attention to the case that you had to decrement
 >> >> > .period to the next possible value. Then .duty_cycle might be bigger
 >> >> > than the corrected period.
 >> >>
 >> >> This is specifically to prevent 100% duty cycle from turning into 0%. My
 >> >> current draft is
 >> >>
 >> >> 	/*
 >> >> 	 * If TLR0 == TLR1, then we will produce 0% duty cycle instead of 100%
 >> >> 	 * duty cycle. Try and reduce the high time to compensate. If we can't
 >> >> 	 * do that because the high time is already 0 cycles, then just error
 >> >> 	 * out.
 >> >> 	 */
 >> >> 	if (tlr0 == tlr1 && !tlr1--)
 >> >> 		return -EINVAL;
 >> >
 >> > If you follow my suggested policy this isn't an error and you should
 >> > yield the biggest duty_cycle here even if it is zero.
 >>
 >> So like this?
 >>
 >> 	if (tlr0 == tlr1) {
 >> 		if (tlr1)
 >> 			tlr1--;
 >> 		else if (tlr0 != priv->max)
 >> 			tlr0++;
 >> 		else
 >> 			return -ERANGE;
 >> 	}
 >
 > No, this is wrong as it configures a longer period than requested in
 > some cases.
 >
 >> And I would really appreciate if you could write up some documentation
 >> with common errors and how to handle them. It's not at all obvious to me
 >> what all the implications of the above guidelines are.
 >
 > Yes, I fully agree this should be documented and doing that is on my
 > todo list. Until I come around to do this, enabling PWM_DEBUG should
 > help you getting this right (assuming you test extensively and read the
 > resulting kernel messages).
 >
 > Best regards
 > Uwe
 >
