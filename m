Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150983B67E0
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Jun 2021 19:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbhF1RoS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Jun 2021 13:44:18 -0400
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:1076
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235067AbhF1RoS (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 28 Jun 2021 13:44:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5xXbzEOS8QNl65+p6ZNMoO4urEf0+WZbDGpll2D1IHc49wvyrTQoUdGYC2wgIB0uhZVpgscbzThlEiKZCMIuE+yQr5utgZSdhwGe2UTXL1QQ7n/uoCiXpKmRQvy6nx87C//2j855vhlH2Vb7Frh44XzivQ6EsJ+t/u9NDpNRC8te4iCqYZxfnuQesPZPCrswMYeMxLytfsnSlV1K8uzJ0qngxSmecx3A2wkT5Hm14Z2CghCaclE+AMbFAwT2gxlk4l0sXVlXOX8qkXQYTsE3AxKORMjvhtkO6p+KRrvJMGH1TcnLsDLKIwt+UDQTx+lxn8oLp3YkndRBEt8P3PyzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YK8XE1LXUZ+vqz7XfB+anQc1ZCGrrLuOzo/xLFSl9As=;
 b=iUZmmEAtFXCxeaMGYpWsxYygrZWT95c4C1tiawyYxFn0F3rDu9LY8DGVDnhIT0apNmeE5B6MIwQfzLEh2TkeCAj7iQHUYCHohAq+n1Bcb/XJGr+e6zpC1enZSdmUbifbV13NV7mxmJoigRpXdtrJSzvNck6AK5CnD8et/6D7G6JhrHAgBFDW4sayQIOUbOGWZb/M2EDkyni1rWZYqB150b3Z8AqZQdyWbPZCsuh4qJ62bVEwqZsO29D0aPdxqvcH0grvObSzjgxSHHorlQdoVmbc6hElQXxxV0uR2vUEIVC3h333EwsHPUlfO6mvaUM7fdRldgK+wwATMr3VMjspkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YK8XE1LXUZ+vqz7XfB+anQc1ZCGrrLuOzo/xLFSl9As=;
 b=DoO0sut5l1gOTT3J9TGYNLRszY75hKBuguldAPPJyrC2Cc+OEH8IyLgiEMRFBgPVEY4uGOdQ3TIt5x4RQqKaxSbpJKW26qszoe6phDoShPaL6DsY/VhV6iPWOfLJfhfE3AsAiUiTH6J2edT+6d3OnI83MujRMtsA0zfp7lSvA3w=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBAPR03MB6408.eurprd03.prod.outlook.com (2603:10a6:10:194::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 28 Jun
 2021 17:41:49 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 17:41:49 +0000
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
 <27fca5ef-8c82-f122-4bd0-f595cad4d588@seco.com>
 <20210628172021.q5enzmr7u6cornm6@pengutronix.de>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <661e52c3-cd79-c2aa-e031-64eef5617be0@seco.com>
Date:   Mon, 28 Jun 2021 13:41:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210628172021.q5enzmr7u6cornm6@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: BL1P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::7) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL1P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend Transport; Mon, 28 Jun 2021 17:41:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbde3947-d4e6-44eb-1ed4-08d93a5c01f2
X-MS-TrafficTypeDiagnostic: DBAPR03MB6408:
X-Microsoft-Antispam-PRVS: <DBAPR03MB6408D6C79F45223BB064F83596039@DBAPR03MB6408.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WjLeWqKCj7l+XdDE2xaoPn3a75FJtGIMC8heH5h+0NE1icseDdAuIagulpF2UO/vmB3R9DWI2ISNdIvyW2gBGdw2cG56YUWggFNluJa5ZfTS1kgZd9UnDvAeyJ0TTIAjKbnE4Eda2/9zhzXRakKwSLXY4jLyAl4M4/WY+8Lbw0pD5B21r0QT4iuXjlIGah1h11dqvldrfEYoc7tVJR+AGPl9L479WfQhsZ+AlsNyXlx9tVVOWXe3HMOpZw9mzXpzEHaq3mboxspfx5e5i11vN9otCIpk8pW7Bv4FFcgND4Gxh+ETVvj+1Obp/a368VGCoezf8tZBXDfNE781+JNNRAEhdXT8EyxE6MfWRHEEiGSeVYLfb5oYIxkq38uuvvtCjbUCE4BDeQHq5AZS9TyAYagfXUMKUkl3rgw3xvbVzhxsivPODHmMuHbPZigqvbpB2m7TkNINUrgFxJW3d3H2xi7JZMVQjC+BGGC0IvHr4UFm37E/DrUpYzZiXWgdbmUXit9qexc68VW9+LBUGPsSukaQZ8lsf2WhqhI/RJeeBJr6yymzolIT/AtILZxMd4U4PPRXaTCRDWz4iUGTN0HcO47FOxTbzDcG33oMU85quYLcN1Y/z7y0ldU21hnblvQgXSvNlxYpYtgl7SiRsKCC/XWJddatPYAdAbPqU2n+4AD6uUuDVNn6/jBqjKnwrm7y0PusiDjSIlV7BvhywV9x90KuYxBxJ03JfX1LDsDh2lbTn17lkuBDHdRzN9JdX70p9L3jI3XJS4x6PHMmRIY1sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(39840400004)(366004)(396003)(31696002)(36756003)(38350700002)(26005)(66946007)(83380400001)(5660300002)(52116002)(66574015)(31686004)(6916009)(6486002)(38100700002)(16526019)(8676002)(186003)(53546011)(478600001)(44832011)(6666004)(7416002)(4326008)(8936002)(316002)(16576012)(956004)(54906003)(66476007)(86362001)(2616005)(66556008)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?u5aGb/Ss2F11a3nsovW9URd6ljSEX8ETwqQiM9CDd6Tpa3nRx4yYUUFJ?=
 =?Windows-1252?Q?jmxk7TJBpTMu7KGGBbLn8DVvutWHBIQaTJHCN+hmXeTVT++vMRK2tzAh?=
 =?Windows-1252?Q?FZv7rDcn1cK3HNkDed4owTwycoMeh50/HQ/Y/GvH4M1oTVzBg2W6yrNj?=
 =?Windows-1252?Q?cuBMzbycJQpePOkGxA4RLrDxr2uBCQdi5WsDhgYVi02dcIxRtSjl0emo?=
 =?Windows-1252?Q?paDqLJ5RrysQN69SvOxclRbcMoDohfVbFboq1h2+8vTHoTJd2+LZzZOo?=
 =?Windows-1252?Q?NPMpQ0X2ZA5l6Xz6zKY+LSzTTS2iLSROOt9Uc+2a40tfSHt12f63W7BB?=
 =?Windows-1252?Q?/ChLojZUqThMfTYK4lJanLe1OvSArRfEVKa/1t8KramcznuRjEf7TlDS?=
 =?Windows-1252?Q?6T78L7KLe3CKlRw+ErXCdibTLhDcpz4sNNsYSlgEz9ZYB6CDGK93V04W?=
 =?Windows-1252?Q?+PAAgBa7qsfbj4I7iFDkX0OiK96uwjOG2c2Hydt+uIetn4CfxzoDBEKU?=
 =?Windows-1252?Q?71IEoNpecEdo2ZDFj/n96/i4adaVZg2m51c2zgp5FrD1OPzpuWUqf/ty?=
 =?Windows-1252?Q?k+3RBKoNof+nJV9/dMo3HcwVAZZI1IvEM9sTye9UszjcZj3IWTiZlS3P?=
 =?Windows-1252?Q?RFNJbphxYJjmQflKMcXg5PeV2TuPFMTRSsLDcTT5+KnvGrepn5qAmLng?=
 =?Windows-1252?Q?h37WYOi4e1VvHwN+Op1aDGst4oYvegu5deid9W/sFKrVbX7d6LrC5EQB?=
 =?Windows-1252?Q?CJFG5yCz3ZoglKWmWnf3Cbm/ZRtjW1W3Jyfa3jtMkzLvwuNuUyGSKGh6?=
 =?Windows-1252?Q?oTWrOHFoNQp0nruam8fQb/gNH6jt95eJJOACRn+22e9553x8c4IwYZCi?=
 =?Windows-1252?Q?S6tsLB60hR2MiFD/UytlltoQAn9XszX8ya3BrqrnHak59whufekrZ8NQ?=
 =?Windows-1252?Q?/TSqCPM5whCAkbjxJj9Ne0mefg/0PRWlT3Ssy0zJj2I4IVnN51u5kkJw?=
 =?Windows-1252?Q?ONYEH14hJASnrt2UMT9uotCEE/FUsExFld7LmZEs4UZx9SHL01jquGlm?=
 =?Windows-1252?Q?BEdmP++AStZI43YUC+aeOYb6Smnxrt1lURhMRwoxTQlwGa6107YcnGcP?=
 =?Windows-1252?Q?6tAsjupX/sC4yZFtGXqHGKcUl+a9ewp98qm9G8U0P3r9P3e7iWb4FU6W?=
 =?Windows-1252?Q?0zPplb6KP5YuEZ59TK5fDmC2D57SvBZQfzwcqzOm0kHRGYdRG6s0WNjt?=
 =?Windows-1252?Q?DmbuN9cieILfLPw+l9pV8KLdZtXAB8qE2/GEfvPqUSeL59yC7BPkxGxa?=
 =?Windows-1252?Q?6z2YC+GXM97nff9m99OY0znmA7lKcOC4BFVzfjxaaYECKVUwgHP9PaNX?=
 =?Windows-1252?Q?1+07NNa0nSCpxI4yLcOcJEgmZ1FAs812UXnPHw1Up6S/UPFq7XnX3Zwn?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbde3947-d4e6-44eb-1ed4-08d93a5c01f2
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 17:41:49.5022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUDUkh/5H/Tk4hakeKDEtB1IJN7gEAL14rDazSaDXFAOffDmN3wO1SO43orag0eP+BbjAEqbtmH6Leo7y0FQ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6408
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 6/28/21 1:20 PM, Uwe Kleine-König wrote:
 > Hello Sean,
 >
 > On Mon, Jun 28, 2021 at 12:35:19PM -0400, Sean Anderson wrote:
 >> On 6/28/21 12:24 PM, Uwe Kleine-König wrote:
 >> > On Mon, Jun 28, 2021 at 11:50:33AM -0400, Sean Anderson wrote:
 >> > > On 6/27/21 2:19 PM, Uwe Kleine-König wrote:
 >> > > > On Fri, Jun 25, 2021 at 01:46:26PM -0400, Sean Anderson wrote:
 >> > > > > So for the moment, why not give an error? This will be legal code both
 >> > > > > now and after round_state is implemented.
 >> > > >
 >> > > > The problem is where to draw the line. To stay with your example: If a
 >> > > > request for period = 150 ns comes in, and let X be the biggest period <=
 >> > > > 150 ns that the hardware can configure. For which values of X should an
 >> > > > error be returned and for which values the setting should be
 >> > > > implemented.
 >> > > >
 >> > > > In my eyes the only sensible thing to implement here is to tell the
 >> > > > consumer about X and let it decide if it's good enough. If you have a
 >> > > > better idea let me hear about it.
 >> > >
 >> > > Sure. And I think it's ok to tell the consumer that X is the best we can
 >> > > do. But if they go along and request an unconfigurable state anyway, we
 >> > > should tell them as much.
 >> >
 >> > I have the impression you didn't understand where I see the problem. If
 >> > you request 150 ns and the controller can only do 149 ns (or 149.6667 ns)
 >> > should we refuse? If yes: This is very unusable, e.g. the led-pwm driver
 >> > expects that it can configure the duty_cycle in 1/256 steps of the
 >> > period, and then maybe only steps 27 and 213 of the 256 possible steps
 >> > work. (This example doesn't really match because the led-pwm driver
 >> > varies duty_cycle and not period, but the principle becomes clear I
 >> > assume.) If no: Should we accept 151 ns? Isn't that ridiculous?
 >>
 >> I am fine with this sort of rounding. The part I take issue with is when
 >> the consumer requests (e.g.) a 10ns period, but the best we can do is
 >> 20ns. Or at the other end if they request a 4s period but the best we
 >> can do is 2s. Here, there is no obvious way to round it, so I think we
 >> should just say "come back with a reasonable period" and let whoever
 >> wrote the device tree pick a better period.
 >
 > Note that giving ridiculus examples is easy, but this doesn't help to
 > actually implement something sensible. Please tell us for your example
 > where the driver can only implement 20 ns what is the smallest requested
 > period the driver should accept.

20ns :)

In the case of this device, that would result in 0% duty cycle with a
100MHz input. So the smallest reasonable period is 30ns with a duty
cycle of 20ns.

 >
 >> > > IMO, this is the best way to prevent surprising results in the API.
 >> >
 >> > I think it's not possible in practise to refuse "near" misses and every
 >> > definition of "near" is in some case ridiculous. Also if you consider
 >> > the pwm_round_state() case you don't want to refuse any request to tell
 >> > as much as possible about your controller's capabilities. And then it's
 >> > straight forward to let apply behave in the same way to keep complexity
 >> > low.
 >> >
 >> > > The real issue here is that it is impossible to determine the correct
 >> > > way to round the PWM a priori, and in particular, without considering
 >> > > both duty_cycle and period. If a consumer requests very small
 >> > > period/duty cycle which we cannot produce, how should it be rounded?
 >> >
 >> > Yeah, because there is no obviously right one, I picked one that is as
 >> > wrong as the other possibilities but is easy to work with.
 >> >
 >> > > Should we just set TLR0=1 and TLR1=0 to give them 66% duty cycle with
 >> > > the least period? Or should we try and increase the period to better
 >> > > approximate the % duty cycle? And both of these decisions must be made
 >> > > knowing both parameters. We cannot (for example) just always round up,
 >> > > since we may produce a configuration with TLR0 == TLR1, which would
 >> > > produce 0% duty cycle instead of whatever was requested. Rounding rate
 >> > > will introduce significant complexity into the driver. Most of the time
 >> > > if a consumer requests an invalid rate, it is due to misconfiguration
 >> > > which is best solved by fixing the configuration.
 >> >
 >> > In the first step pick the biggest period not bigger than the requested
 >> > and then pick the biggest duty cycle that is not bigger than the
 >> > requested and that can be set with the just picked period. That is the
 >> > behaviour that all new drivers should do. This is somewhat arbitrary but
 >> > after quite some thought the most sensible in my eyes.
 >>
 >> And if there are no periods smaller than the requested period?
 >
 > Then return -ERANGE.

Ok, so instead of

	if (cycles < 2 || cycles > priv->max + 2)
		return -ERANGE;

you would prefer

	if (cycles < 2)
		return -ERANGE;
	else if (cycles > priv->max + 2)
		cycles = priv->max;

But if we do the above clamping for TLR0, then we have to recalculate
the duty cycle for TLR1. Which I guess means doing something like

	ret = xilinx_timer_tlr_period(priv, &tlr0, tcsr0, state->period);
	if (ret)
		return ret;

	state->duty_cycle = mult_frac(state->duty_cycle,
				      xilinx_timer_get_period(priv, tlr0, tcsr0),
				      state->period);

	ret = xilinx_timer_tlr_period(priv, &tlr1, tcsr1, state->duty_cycle);
	if (ret)
		return ret;



 >
 >> Any way you slice it, there will be situations where there is nothing
 >> reasonable to do other than return an error.
 >
 > ack.
 >
 >> > > > > Perhaps I should add
 >> > > > >
 >> > > > > 	if (tlr0 <= tlr1)
 >> > > > > 		return -EINVAL;
 >> > > > >
 >> > > > > here to prevent accidentally getting 0% duty cycle.
 >> > > >
 >> > > > You can assume that duty_cycle <= period when .apply is called.
 >> > >
 >> > > Ok, I will only check for == then.
 >> >
 >> > You just have to pay attention to the case that you had to decrement
 >> > .period to the next possible value. Then .duty_cycle might be bigger
 >> > than the corrected period.
 >>
 >> This is specifically to prevent 100% duty cycle from turning into 0%. My
 >> current draft is
 >>
 >> 	/*
 >> 	 * If TLR0 == TLR1, then we will produce 0% duty cycle instead of 100%
 >> 	 * duty cycle. Try and reduce the high time to compensate. If we can't
 >> 	 * do that because the high time is already 0 cycles, then just error
 >> 	 * out.
 >> 	 */
 >> 	if (tlr0 == tlr1 && !tlr1--)
 >> 		return -EINVAL;
 >
 > If you follow my suggested policy this isn't an error and you should
 > yield the biggest duty_cycle here even if it is zero.

So like this?

	if (tlr0 == tlr1) {
		if (tlr1)
			tlr1--;
		else if (tlr0 != priv->max)
			tlr0++;
		else
			return -ERANGE;
	}

And I would really appreciate if you could write up some documentation
with common errors and how to handle them. It's not at all obvious to me
what all the implications of the above guidelines are.

--Sean
