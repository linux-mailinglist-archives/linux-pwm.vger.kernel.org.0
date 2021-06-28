Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D022A3B6619
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Jun 2021 17:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbhF1PxO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Jun 2021 11:53:14 -0400
Received: from mail-eopbgr150044.outbound.protection.outlook.com ([40.107.15.44]:39748
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235456AbhF1PxI (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 28 Jun 2021 11:53:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHcwOhlo8Nk9Ba7u1nTaWacJHdr737KMu/K1FzLdvIo8xDWHZcynenBSArkwi3ZDx6e1em3EIcU8L8mms/eQM62hp/hs/6EvaZrEkFaS2OFTCtS9ZIy/5kdjTnEj3HI8FoVYJRwXUKGyFTxL6OpcsRtK/pOlRZ2QOxcIGNVOuW26mfyO0VyR6kzOCe5upGVWm6JKOPCg0ACoAXpd4v+O0mtdaGKICUBsETNuchK7w8KVf5lnN3H5pxSBq2LfU5eTJgePpAye+BvM4FZ5PpLObeAUTZrurR8w5GCLUX8Yx0X3chOMYRRKiEvxlf7Sftf6t6PLeTMuMV5roZ9eACp1sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSHaveLx/rRAJYVQG63UiwgxJDjnbx98s+g9Hvlgjb8=;
 b=G440hVVI6cQc3vHh3IfoVhz0LY/vTsJZi/iPyimP/if2S7+YYVOVFczqXsvjAFlOZojr9iWbOSIhd2dKoRgxbDNBZW0pP0QAUev+Rsph9oGYSrq9Jh86BjrSqTmSQN+7/tnN+S6S7U3e4UcTefDYGMItlJ2WfNfvR5/8Cw69zHF7bGrXLAMY6QuIyh7nGMytZcO3YKBclf47ZlQ1WGN9KGKM3/WgLDsBxfec/luPmnoLQGyU7sTwnpEIq0MfdaoeATsOXPMBs4jTueiNFqejBu4Way+HSy3M2DceOzclIUWzI/zL6701P77qtfndWR7EHFRinJN/igaDyn4lio0TOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSHaveLx/rRAJYVQG63UiwgxJDjnbx98s+g9Hvlgjb8=;
 b=YbqfitKJ6XtOVKibIdoLGfgHQmswsGPg41gEVCt38b07pUoWRc0hQM2xmKKH79nR5ae2NGQ9Pjl//zB5mMfGsvwq8YlFiTxmpS3OOQ42gAc90k2aWXNMbcHXv0HrZ3PDUvoztrV1uT1/VdbdwGDeWOYN/KNqNkRAHu2gYBPU7as=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB4858.eurprd03.prod.outlook.com (2603:10a6:10:7f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 28 Jun
 2021 15:50:38 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 15:50:38 +0000
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
Message-ID: <59e93f67-0552-04bb-116e-73ddf878761e@seco.com>
Date:   Mon, 28 Jun 2021 11:50:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210627181919.iunagls4j67ignhh@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: BL1PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::22) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL1PR13CA0137.namprd13.prod.outlook.com (2603:10b6:208:2bb::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8 via Frontend Transport; Mon, 28 Jun 2021 15:50:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51be9bf9-512a-485e-294d-08d93a4c79ab
X-MS-TrafficTypeDiagnostic: DB7PR03MB4858:
X-Microsoft-Antispam-PRVS: <DB7PR03MB4858D7D5A2B7ECA4CA17A87896039@DB7PR03MB4858.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V1tn1t8fYwhrt3jf+mqImgOXY6OeSnXNWoWopN1iPx8Xl26uqur/KUUick3kiT4fEEAhcQoKhzFliBuC3NkN9HXWfOPbem7MRYXtRu/ktYBp3RmH+sIj5W+r6+ibuhR5dRy4sGPHnQJP5jH1QKHdOv70whPIXL7xcBzpkYgFOFlnxL7GHh+vesa5UodHT6vG7B7GiN5iitDxj6td7FHEDL26o03LCWfhO5xMAYDiNqCwZ59RleZe7dqOQlD2dKpurREvCWBf6OOSHY/C1qx+TNo2plqv3MRvtUE86x8+/4yO5nvoP07D8aZtMm5TKA/Kg5xF0oH2ULK1a6g4wv1ukOwInfrNnpL4BnPyp1x5kj11TXcaisJpjBdkrL7zajCnkuv2cd31LYn8Ehj2S1BjA8zep9f2ZwJ9MsUYNKa066A1alTvDpyuTqaXEfT/UdBTfW3nQuxnanpA2JgbNaPLwZ+56w38tiEEGOYXNabaeqzHUE3LswfcU85x64JgxUViqdLyeyycvZUBiW5JUYHYPE5lfYYkK5XqIpFjp39vhNvR0sHHrxP+SxczdNR74dGUIToREKZUBUpNrM30jW470AMzi4jUHzfrZ8VamgN92FUxow3Y1le26JTJ9CYQrnv2AZ72QPV+qqNIGBQpasnAnru7PyJTu6Vy/JPzhmqpBc9sfS+QhuHlSUcpjO54xN6PaiWgxx7VFVVp+L0Z5yKa3e+8N/DmqfAMsuHjCkGIddYY6dngBXt7Eb5tYhNmKO9Om6hzYdQcLDIjPuFDhZ/0bTQ/Ls4HjtxE4Ox2ClmFfFWJobvNlDO+vattPVCpCkWpG8aSTrTmz3/TctlMoThSj/Cfk/ywkP/YKwDcsor3khSxy5FyvYyIqTu6p44cikBoxEXoLbgfN3iOWsgDnWCcaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39840400004)(366004)(396003)(376002)(346002)(38350700002)(44832011)(38100700002)(5660300002)(6486002)(54906003)(478600001)(4326008)(36756003)(2906002)(16576012)(316002)(31696002)(956004)(2616005)(6666004)(83380400001)(16526019)(8936002)(53546011)(66556008)(26005)(66574015)(66946007)(66476007)(186003)(86362001)(8676002)(52116002)(31686004)(966005)(6916009)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?xJCUzYysPMsF6QMiqY07+udyZGo3yPsAzTTup0k18daJ+mgaFGGWmFnG?=
 =?Windows-1252?Q?7BNAYMGm3aw9vvNlxVjpwSYgnCCd1lr0LAB562uaM2OdDKH5u8CKwnkA?=
 =?Windows-1252?Q?+2kaFvxMtZMJLYz26eGF2sN3gIL4ZcV5MOYGmfNu3LzKtgDNQY4kfHeu?=
 =?Windows-1252?Q?/GR3ZEGCdciGpImEy+n8zju7Mti+syI59H3YN4OLorjVHLkZBv2llPA1?=
 =?Windows-1252?Q?WjwKsjXoJekAnHTwBL6W7KtRq8o89XNEZoY8QXgrylRwZ5aKd57lNsI8?=
 =?Windows-1252?Q?CpPjRa5ncDaSMJZdkdRUPRzbkI5qgaqOEKRJq5PwVgKuloNRKb50HvzF?=
 =?Windows-1252?Q?ZHFoKFx2nbx5SLfpFKXAyC90Syo8EDB0kJ4WeJtWD/Q7dC2uDXbQozmG?=
 =?Windows-1252?Q?aM1Ughro9GRI5pwW4Uy4WMSjZMRS+7qPfydpmu5yATZghI49Ud2rv9kJ?=
 =?Windows-1252?Q?c8yXEPngDi/+2/q0+f5XhSnYJOboNKA6lKyLKY3San8sOmRXaqxWeFEJ?=
 =?Windows-1252?Q?+gh/cnMTeRDmEyxmSh870LUdOtZS/Q9QZi6yMnvNcL+6BLQk2cH1f16n?=
 =?Windows-1252?Q?uVN3wJUop4vM3YCv5jbLB73YeWqe7mp4eheUD03hHq539VSaq8zkr+ig?=
 =?Windows-1252?Q?eF2q/sApG5OJ0FHuVUgXlYEBgm6eo8uz++cvdaN6Nbq00Ph1UmfnjWje?=
 =?Windows-1252?Q?5a8X+GjgBhJnpEy7nW694nbO4IL7xqNa0fpP6XrElF4xzvLtPoUjjggl?=
 =?Windows-1252?Q?FFazkBuf1RhiOpvVnNSsjWZWUpD3se2FVV2hThKIuekdfPqGu9QADBr+?=
 =?Windows-1252?Q?hAdbwLiiR8ROxsoujEJnSQdyfLPqV1+ZnwXom6ZcA4Tw8xeG8+4mhpJH?=
 =?Windows-1252?Q?8MSlqxfhIwzO86qe3gJ+GDBlDuLKZIkI0DH4FY5dxjLLgFAr4+au/Zij?=
 =?Windows-1252?Q?as6PFsAYQRvKNnnaHygya3Guv/AjtEf/HLd7zZYCO96WSXfk9GpEy3pk?=
 =?Windows-1252?Q?d4brC4ab5gd1NaV5NrCtLnLWAAkWjzrFP4TrwkUB9IzfzA9IMbBx7uIa?=
 =?Windows-1252?Q?jLTpW+Xul9HwjuBnV7u4dvsj0lfLxD3404QUgSD+sxvHMEEf3cjbLRIj?=
 =?Windows-1252?Q?8RvFNgW127raWJt2ax1Sj3waJg/3P/n5gjNJ15AGTOwT0i2CEFk7mbfd?=
 =?Windows-1252?Q?xQ+qRtRdJZ6Q5O58X8m748T0tSThM/eyebp/GT4gHJyG8iDiTAJa6KGe?=
 =?Windows-1252?Q?Lzsf3AgEBDR9y7bSn0Rt6bQSlorwPiZhvm6cCPJQt+LI6OuX7mhEZiEU?=
 =?Windows-1252?Q?3hkf7c8a0Gn91Nq+YjzAv87kQfefSqykDS0nH3FsiBRdI0XBeVzP5L24?=
 =?Windows-1252?Q?OVJ2adrhFYsY+5dUqMT2P44UDWteEEpU/5CcYAv436GgF8LYrbx/aEv9?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51be9bf9-512a-485e-294d-08d93a4c79ab
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 15:50:38.4110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PnK7w0LZ4W9pVlXR5upATje5VcByh6ndd0bwTTy3AROjEYnkjkTv7Aif9kZD/Hp537gR+Dg5soLupfZHgVX5rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB4858
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 6/27/21 2:19 PM, Uwe Kleine-König wrote:
> Hello Sean,
>
> On Fri, Jun 25, 2021 at 01:46:26PM -0400, Sean Anderson wrote:
>> On 6/25/21 12:56 PM, Uwe Kleine-König wrote:
>> > On Fri, Jun 25, 2021 at 11:13:33AM -0400, Sean Anderson wrote:
>> > > On 6/25/21 2:19 AM, Uwe Kleine-König wrote:
>> > > > On Fri, May 28, 2021 at 05:45:22PM -0400, Sean Anderson wrote:
>> > > >> + * - Cannot produce 100% duty cycle.
>> > > >
>> > > > Can it produce a 0% duty cycle? Below you're calling
>> > > > xilinx_timer_tlr_period(..., ..., ..., 0) then which returns -ERANGE.
>> > >
>> > > Yes. This is what you get when you try to specify 100% duty cycle (e.g.
>> > > TLR0 == TLR1).
>> >
>> > OK, so the hardware can do it, but your driver doesn't make use of it,
>> > right?
>>
>> So to clarify, I have observed the following behavior
>>
>> * When TCSR == 0, the output is constant low.
>> * When TLR1 (duty_cycle) >= TLR0 (period), the output is constant low.
>>
>> It might be possible to achieve constant high output by stopping the
>> counters during the high time, but leaving the PWM bit set. However, I
>> do not have a use case for this. I think it might be a nice follow-up
>> for someone who wants that feature.
>
> A typical use case is having an LED or a backlight connected to the PWM
> and and want it to be fully on.

I mean that I personally do not need this feature for my current
project, though I could see how someone might want this.

>
>> That being said, is there a standard way to specify 100% or 0% duty
>> cycle? It seems like one would have to detect these situations and use a
>> different code path.
>
> I don't understand that question. If pwm_apply_state is called with a
> state having .duty_cycle = 0 (and .enabled = true) you're supposed to
> emit a 0% relative duty. If .duty_cycle = .period is passed you're
> supposed to emit a 100% relative duty.

Ok.

>
>> > > >> + * - Only produces "normal" output.
>> > > >
>> > > > Does the output emit a low level when it's disabled?
>> > >
>> > > I believe so.
>> >
>> > Is there a possibility to be sure? I'd like to know that to complete my
>> > picture about the behaviour of the supported PWMs.
>>
>> See above.
>>
>> > > >> +static int xilinx_pwm_apply(struct pwm_chip *chip, struct pwm_device *unused,
>> > > >> +			    const struct pwm_state *state)
>> > > >> +{
>> > > >> +	int ret;
>> > > >> +	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
>> > > >> +	u32 tlr0, tlr1;
>> > > >> +	u32 tcsr0 = xilinx_timer_read(priv, TCSR0);
>> > > >> +	u32 tcsr1 = xilinx_timer_read(priv, TCSR1);
>> > > >> +	bool enabled = xilinx_timer_pwm_enabled(tcsr0, tcsr1);
>> > > >> +
>> > > >> +	if (state->polarity != PWM_POLARITY_NORMAL)
>> > > >> +		return -EINVAL;
>> > > >> +
>> > > >> +	ret = xilinx_timer_tlr_period(priv, &tlr0, tcsr0, state->period);
>> > > >> +	if (ret)
>> > > >> +		return ret;
>> > > >
>> > > > The implementation of xilinx_timer_tlr_period (in patch 2/3) returns
>> > > > -ERANGE for big periods. The good behaviour to implement is to cap to
>> > > > the biggest period possible in this case.
>> > >
>> > > Ok. Is this documented anywhere?
>> >
>> > I tried but Thierry didn't like the result and I didn't retry. The
>> > problem is also that many drivers we already have in the tree don't
>> > behave like this (because for a long time nobody cared). That new
>> > drivers should behave this way is my effort to get some consistent
>> > behaviour.
>>
>> Do you have a link to the thread? IMO if you would like to specify
>> behavior like this, is is very helpful to write it down so new authors
>> don't have to get to v4 before finding out about it ;)
>
> I misremembered, the last time I wanted to improve the documentation I
> didn't write anything about the policy with the goal to improve the
> documentation without hitting the a bit controversial policy stuff. The
> thread is available at
>
> 	https://lore.kernel.org/r/20191209213233.29574-2-u.kleine-koenig@pengutronix.de

This link does not work, but I was able to find the patch at

	https://patchwork.ozlabs.org/project/linux-pwm/patch/20191209213233.29574-2-u.kleine-koenig@pengutronix.de/

However, it has no mention of rounding the rate, or what to do if a
given configuration cannot be applied.

> . Thierry didn't reply to this thread yet.

It seems the patch is marked as "Rejected" which is odd with no
feedback. Perhaps you should resend.

>
> My intension was to build on this one and formulate the expected policy
> for new drivers.
>
> The situation I'm in here wanting to install this policy is: On one hand
> Thierry argues that consumers don't care much about how .apply rounds
> because most consumers just don't have so exact requirements. And on the
> other hand he doesn't want to change the existing behaviour for already
> existing drivers to not break consumers. So the best I can currently to
> do work on a more consistent behaviour is to enforce this for new
> drivers.
>
>> > > And wouldn't this result in the wrong duty cycle? E.g. say the max
>> > > value is 100 and I try to apply a period of 150 and a duty_cycle of 75
>> > > (for a 50% duty cycle). If we cap at 100, then I will instead have a
>> > > 75% duty cycle, and there will be no error.
>> >
>> > Yes that is right. That there is no feedback is a problem that we have
>> > for a long time. I have a prototype patch that implements a
>> > pwm_round_state() function that lets a consumer know the result of
>> > applying a certain pwm_state in advance. But we're not there yet.
>>
>> So for the moment, why not give an error? This will be legal code both
>> now and after round_state is implemented.
>
> The problem is where to draw the line. To stay with your example: If a
> request for period = 150 ns comes in, and let X be the biggest period <=
> 150 ns that the hardware can configure. For which values of X should an
> error be returned and for which values the setting should be
> implemented.
>
> In my eyes the only sensible thing to implement here is to tell the
> consumer about X and let it decide if it's good enough. If you have a
> better idea let me hear about it.

Sure. And I think it's ok to tell the consumer that X is the best we can
do. But if they go along and request an unconfigurable state anyway, we
should tell them as much. IMO, this is the best way to prevent surprising
results in the API.

The real issue here is that it is impossible to determine the correct
way to round the PWM a priori, and in particular, without considering
both duty_cycle and period. If a consumer requests very small
period/duty cycle which we cannot produce, how should it be rounded?
Should we just set TLR0=1 and TLR1=0 to give them 66% duty cycle with
the least period? Or should we try and increase the period to better
approximate the % duty cycle? And both of these decisions must be made
knowing both parameters. We cannot (for example) just always round up,
since we may produce a configuration with TLR0 == TLR1, which would
produce 0% duty cycle instead of whatever was requested. Rounding rate
will introduce significant complexity into the driver. Most of the time
if a consumer requests an invalid rate, it is due to misconfiguration
which is best solved by fixing the configuration.

>> > > So I will silently get the wrong duty cycle, even when that duty cycle
>> > > is probably more important than the period.
>> >
>> > It depends on the use case and every policy is wrong for some cases. So
>> > I picked the policy I already explained because it is a) easy to
>> > implement for lowlevel drivers and b) it's easy to work with for
>> > consumers once we have pwm_round_state().
>>
>> What about sysfs? Right now if you try to specify an inexpressible
>> period you get an error message. I saw [1], but unfortunately there do
>> not appear to be any patches associated with it. Do you have plans to
>> implement such an interface?
>>
>> [1] https://lore.kernel.org/linux-pwm/CAO1O6seyi+1amAY5YLz0K1dkNd7ewAvot4K1eZMpAAQquz0-9g@mail.gmail.com/
>
> In my eyes we better implement a pwmctl interface that doesn't work via
> sysfs but using an ioctl; similar what gpio did with gpioctl for various
> reasons.
>
>> > > > Also note that state->period is an u64 but it is casted to unsigned int
>> > > > as this is the type of the forth parameter of xilinx_timer_tlr_period.
>> > >
>> > > Hm, it looks like I immediately cast period to a u64. I will change the
>> > > signature for this function next revision.
>> >
>> > Then note that period * clk_get_rate(priv->clk) might overflow.
>>
>> Ok, so is mult_frac the correct macro to use here?
>>
>> > > >> +	ret = xilinx_timer_tlr_period(priv, &tlr1, tcsr1, state->duty_cycle);
>> > > >> +	if (ret)
>> > > >> +		return ret;
>>
>> Perhaps I should add
>>
>> 	if (tlr0 <= tlr1)
>> 		return -EINVAL;
>>
>> here to prevent accidentally getting 0% duty cycle.
>
> You can assume that duty_cycle <= period when .apply is called.

Ok, I will only check for == then.

--Sean
