Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18933EE08B
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Aug 2021 01:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhHPXv5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Aug 2021 19:51:57 -0400
Received: from mail-db8eur05on2067.outbound.protection.outlook.com ([40.107.20.67]:15488
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232470AbhHPXv4 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 16 Aug 2021 19:51:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B20f8uCihqhVHzsw6hlLVlxnw4fWfQ5VncJhU5fRaYgYideSgonJR9PztXalAn+n7vX9k94xa6kQK9YzWndNoeczBrJsoK429cNHUdypHeAa10+p5gByykQQjoTEIj1HlX2dhISvNLVIz06GJhGY4M4oouzy8go2GtODedfJiHgqUyNmHD/VA4UixX8ioFnLWvMxBM4FpbyDQAI+tTjeIS1GUAFTEU1ycspA/ez/zc5Gcv10fEcsaWEClqfJhllNxXRY9rMPTX9qdmE7crOxvEhAwrLArJn5xtOtGMRu+ACi0pPiZoUr2dJNAJkhcERomJkeK6tl+qXHRC5yxyrC0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6CRt7bzhRFTbb+XqNW1rWp9hgKXgqhml7xNyQ5656Y=;
 b=IH/8ZQA11shSJn8+OPi3eGVCMwi12kaFEI2J47lY/8Si72PsUzxcwTihdwyCymhCUQQFD7+nyTh802Pq9+nKq5nkAmGnwcm3i5NjO0d6UVbyUPHtSjJIlpIa2kwuEUb5SaAdpTRzVlH1Mz1zx/Dq8sLu8XdthubMJIfkdVhjvBo/F67uo9WzBywW5VC2YFNh0ZAr4kPFU3+2/ICEPINfRWyTLiGyn5WHoSTTQOTZo67Q3wyCw9m5izAjYcGpoJjhslF5EdsI1hChytJRawA+RKD1DccsgiBaH51kHt6IA3rBnHVkNpqjpPq/fSb9VGDCUWXdNqjdKydQSnrglU3pGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6CRt7bzhRFTbb+XqNW1rWp9hgKXgqhml7xNyQ5656Y=;
 b=3jJXkG64TJeHxXhCzf5TsE+QeU/mx9JxTEBf8cUuFF8dc4enHvfGe1fx1J//9+h063jVM1K7/nZx1W5Qpv5sYy0iId+XBZtZR7qj2Ubv7udyCUASbfE004SfsCmyQo3fvbiJFq3hO+Xp6n9A2nOChSDjYR76sFSUINGwk+N9qsM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB4153.eurprd03.prod.outlook.com (2603:10a6:10:16::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Mon, 16 Aug
 2021 23:51:21 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4415.024; Mon, 16 Aug 2021
 23:51:21 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v5 3/3] pwm: Add support for Xilinx AXI Timer
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        michal.simek@xilinx.com, Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210719221322.3723009-1-sean.anderson@seco.com>
 <20210719221322.3723009-3-sean.anderson@seco.com>
 <20210814204710.retjwn5fycwtrypp@pengutronix.de>
Message-ID: <e8d39f18-3aa9-e617-6439-2c0b071f62b3@seco.com>
Date:   Mon, 16 Aug 2021 19:51:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210814204710.retjwn5fycwtrypp@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0192.namprd13.prod.outlook.com
 (2603:10b6:208:2be::17) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL1PR13CA0192.namprd13.prod.outlook.com (2603:10b6:208:2be::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Mon, 16 Aug 2021 23:51:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92ae96aa-0324-43ef-7c67-08d96110bfb9
X-MS-TrafficTypeDiagnostic: DB7PR03MB4153:
X-Microsoft-Antispam-PRVS: <DB7PR03MB41536BDBD3E22A6359B7202296FD9@DB7PR03MB4153.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wDWZZXKLXA2pS8ATe43Vkriop+29iXKWNnHUzbul6bapJokULAvyQ+c8bTVBBlsZU/4GXgGT/02r6jm9N90CShxXmG5/uMA7WYf85Pbe3ZAEhhKM6CI05xEkrFLZX9/iHyTef0PFshon/FC/3uU/pj1S+wI3rudaxvSXrPgSHgDIEOyIPqYPM5b58hFQgA/MEn8qxsLe1RhF4HaP8hO6Zw875uGY4OzP2laYaQk+6u4+ltxIdMLeFet9EmNG1sPbCMHwRcjC8gMapXBZxjY58vkY6/x0ZAiX7gGnWsdHT4fLy1ykBgkJm/X5WZysaT6SXUsSUG5uA1ZaSLJsxz2JAfRV/ZVDD7g/clIl5DMOHs7OnpMstyxhRXzElrpdn6utaokr2j11KZH0jA62wN9bP9fXnyHGwmTEnVlM/Z7L0mSK1tvfrzfVMI29WmGQr8MrUGF+/Agi5xPoZIFw3BfMhe4e1ThXY3dVuhidJ9hHFCwHtKyrgrSFtiuut4/tl0wFF64jD3/3/JJYaISBV2mfTzIUSwU4wIB0pGOtsO3Vev/6YL/slLt1+bkK71XGno8tSQ1DlQOnMX6MOpLViTuREigpS+tX3EDKsVsb1Ji5YvI/hVOSt5TQxYLC56YBJpvmqQciQtc9nE8iBLaZ7ztGm5Vvp0lOMGU2Sxz8G0tqTcZoM+XVkF8b/FgUapDz/8uIU6nOi+FUgfIU0FCY5ysBuug8oVAo2/rLQPtVFQy8S49mPDAXEint8Kbaggvkuw1ilqe7cKuimgnoFAukfeQF/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(136003)(376002)(396003)(366004)(346002)(66574015)(8936002)(478600001)(2906002)(66556008)(54906003)(36756003)(6916009)(31696002)(16576012)(66476007)(86362001)(66946007)(52116002)(83380400001)(6666004)(38350700002)(38100700002)(4326008)(186003)(31686004)(956004)(44832011)(5660300002)(26005)(6486002)(8676002)(53546011)(316002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?mXtceU7mAmVYCh1vXuWw1ApGjt2UAFnmYAim0dfrWW7goqhJVbREXG92?=
 =?Windows-1252?Q?JHRSY1nDrpIEsoWQdz2Gv6Z0GFCeTtIO1Ti9NL5gl04df6Sont2gU27M?=
 =?Windows-1252?Q?dwZG342zo8iTBtG5RV5WFzd2xM7Fivj1GYNHj9TMRYkIwH7w3Wxh/CVN?=
 =?Windows-1252?Q?elEoCkd4WmY+83zwK08Vf+0oc9uDzWd1d8sF3rdh1osDpBAVzJZiS+5H?=
 =?Windows-1252?Q?XV1oJa9glm2f22kd6X+JR047SZ1H2W2ugqhRzPfO0RduW6l6oQU0nfVT?=
 =?Windows-1252?Q?AmF9X9KF5og1z/GxX6FWl1il4tQSr5DLuEfEaydQRZyUDFU9um1jN2nf?=
 =?Windows-1252?Q?/Xs8fH6Bi9WLcFhDZeuFj3SWwh8AivG/g2iOInSu6bh83tHpVqGCyjMo?=
 =?Windows-1252?Q?ebEuKxGfPT4A/vrnp1liFdIZg1BaYO7iWVNjjrpbrWuOdOG9AxQCLMCI?=
 =?Windows-1252?Q?bcOZ0wQ6eWbzKvjPoJWeO5eI4mTJlHfFyj+2lW1PeQdQsTlRgS65EbaC?=
 =?Windows-1252?Q?sKfEREkzjDhehjT/Lm3KEai52+vlEqaD9vJCf0Z4MZN7hdqLavQWduMo?=
 =?Windows-1252?Q?MoWF5pWv+CzSo1SaSvIkKrSnEzlJH1w2A+vXzdnROteW2GMcVqJINr5z?=
 =?Windows-1252?Q?ISOd9dhF4z5/oYlWSbdKPAeSRlCh7lSrcrAs1PvnnoNndC2ruGLLJBSN?=
 =?Windows-1252?Q?pt3W+DskdDzQ4wSMI+mfXp7xhork2MDwxn3VcsAAe066u5RopWHhXaxv?=
 =?Windows-1252?Q?ZzdMmytIER4VdC+KO1H52vP9QKRojMw9L0r6drcKvfGrPLdIgVn/151d?=
 =?Windows-1252?Q?7PQI1pp/F4mjEOgmWIHnPL9Nh+i5utrciTwqVeJoVJ1ZuYIcPHRuNIeM?=
 =?Windows-1252?Q?LER5OSZB2fF+cS27SJp59I0Nrsgmd/UmfqpOhl69oeEKpApn5ItPjD4B?=
 =?Windows-1252?Q?Kcu5S52g3lAK4UH+PWvX5vNyEVOLZvQjKgAJnfqrDd9rIP0Obh1/ZdQ+?=
 =?Windows-1252?Q?x6nYNcHVakoQxSpJnFOXOheacSzohUMoBZCmRBu+UYP2u2mxHfcgx4sU?=
 =?Windows-1252?Q?tHQImakskfGUqUUVb0dcrpB5s3VSZ2TvJ5GN9qhHyWjAQgE0HJhiJkAI?=
 =?Windows-1252?Q?jSWSiqmZIXRTP5AHztRE8f6wXISG2kmZ5wAioNdRpY5RVSSdaHW6MSRZ?=
 =?Windows-1252?Q?r8NKEtRyu6pzZIGbbgIAXM5noQ1skVT8Nr3L4fTz+WkbI5jMIQ252LFs?=
 =?Windows-1252?Q?gyh6oFrfujH7Q4nsAviWJQ3GIoY6s6in5X95b7CAmeRnmIL2P9lWRxa/?=
 =?Windows-1252?Q?iseH33WywWY+lfFo6sjufsbEuJx4KTHU/qMMsB/M0fk6/kfknIXGf0dC?=
 =?Windows-1252?Q?o5cZluKP+1TmN5i7Zi4ZdyYxr9KLJYmTtEsNIAKYlFBK733H5UeClD4R?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ae96aa-0324-43ef-7c67-08d96110bfb9
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 23:51:21.4980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYAXS2c9PsvcHJECmYrTwBXi6k1qVSEdENOJbGuMa6VgSeJz+UEN6xc9Xcm9CCSasqHKkC+xonqhFF+ZjqrTwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB4153
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 8/14/21 4:47 PM, Uwe Kleine-König wrote:
> Hello Sean,
>
> sorry for having you let waiting so long. Now here some more feedback:
>
> On Mon, Jul 19, 2021 at 06:13:22PM -0400, Sean Anderson wrote:
>> +static int xilinx_pwm_apply(struct pwm_chip *chip, struct pwm_device *unused,
>> +			    const struct pwm_state *state)
>> +{
>> +	bool enabled;
>> +	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
>> +	u32 tlr0, tlr1, tcsr0, tcsr1;
>> +	u64 period_cycles, duty_cycles;
>> +	unsigned long rate;
>> +
>> +	if (state->polarity != PWM_POLARITY_NORMAL)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * To be representable by TLR, cycles must be between 2 and
>> +	 * priv->max + 2. To enforce this we can reduce the duty
>> +	 * cycle, but we may not increase it.
>> +	 */
>> +	rate = clk_get_rate(priv->clk);
>> +	period_cycles = mul_u64_u32_div(state->period, rate, NSEC_PER_SEC);
>
> cool, I didn't know mul_u64_u32_div.

I didn't either. Alas, many useful functions like these have no
documentation...

>
> Hmm, we still have a problem here if
>
> 	state->period * rate > 1000000000 * U64_MAX.

Note that this can only occur with rate > 1GHz (and period = U64_MAX).
The highest fmax in the datasheet is 300 MHz (on a very expensive FPGA).

Maybe it is more prudent to do

	period = min(state->period, ULONG_MAX * NSEC_PER_SEC)

I think a period of 136 years is adequate :) This comparison also has
the advantage of being against const values.

> So to be entirely save, we either need:
>
> 	/*
> 	 * To ensure that period * rate / NSEC_PER_SEC fits into an u64
> 	 * we need:
> 	 *            U64_MAX * NSEC_PER_SEC
> 	 *   period < ----------------------
> 	 *                    rate
>           *
> 	 * . If rate is not bigger than NSEC_PER_SEC this is true for
> 	 * sure as the RHS is bigger than U64_MAX. Otherwise we can
> 	 * calculate the RHS using mul_u64_u32_div.
> 	 */
> 	if (rate > NSEC_PER_SEC)
> 		period = min(state->period, mul_u64_u32_div(U64_MAX, NSEC_PER_SEC, rate);
> 	else
> 		period = state->period;
>
> or we go a step further and check the priv->max limit in the same step:
>
> 	period = min(state->period, ((u64)priv->max + 2) * NSEC_PER_SEC / rate)
>
> . The latter is simpler and it's safe as priv->max is an u32 and so
> there is no overflow.
>
>> +	if (period_cycles - 2 > priv->max || period_cycles < 2)
>
> I'd check for period_cycles < 2 first, because otherwise period_cycles -
> 2 might underflow. Nothing bad happens in this case, but reading from
> left to right my first thought was I found a bug. Also please decrease
> period_cycles if it's bigger than priv->max + 2. (With the suggestion
> above you don't need to check for period_cycles - 2 > priv->max any more
> however.)

Ok, will swap.

>> +		return -ERANGE;
>> +	duty_cycles = mul_u64_u32_div(state->duty_cycle, rate, NSEC_PER_SEC);
>> +
>> +	/*
>> +	 * If we specify 100% duty cycle, we will get 0% instead, so decrease
>> +	 * the duty cycle count by one.
>> +	 */
>> +	if (period_cycles == duty_cycles)
>> +		duty_cycles--;
>> +
>> +	/* Round down to 0% duty cycle for unrepresentable duty cycles */
>> +	if (duty_cycles < 2)
>> +		duty_cycles = period_cycles;
>> +
>> +	regmap_read(priv->map, TCSR0, &tcsr0);
>> +	regmap_read(priv->map, TCSR1, &tcsr1);
>> +	tlr0 = xilinx_timer_tlr_cycles(priv, tcsr0, period_cycles);
>> +	tlr1 = xilinx_timer_tlr_cycles(priv, tcsr1, duty_cycles);
>> +	regmap_write(priv->map, TLR0, tlr0);
>> +	regmap_write(priv->map, TLR1, tlr1);
>> +
>> +	enabled = xilinx_timer_pwm_enabled(tcsr0, tcsr1);
>> +	if (state->enabled) {
>> +		/*
>> +		 * If the PWM is already running, then the counters will be
>> +		 * reloaded at the end of the current cycle.
>> +		 */
>
> If state->enabled is false, $enabled isn't used, so you can move the
> assignment into the if body and also limit the scope of $enabled.

Ok.

>> +		if (!enabled) {
>> +			/* Load TLR into TCR */
>> +			regmap_write(priv->map, TCSR0, tcsr0 | TCSR_LOAD);
>> +			regmap_write(priv->map, TCSR1, tcsr1 | TCSR_LOAD);
>> +			/* Enable timers all at once with ENALL */
>> +			tcsr0 = (TCSR_PWM_SET & ~TCSR_ENT) | (tcsr0 & TCSR_UDT);
>> +			tcsr1 = TCSR_PWM_SET | TCSR_ENALL | (tcsr1 & TCSR_UDT);
>> +			regmap_write(priv->map, TCSR0, tcsr0);
>> +			regmap_write(priv->map, TCSR1, tcsr1);
>> +		}
>> +	} else {
>> +		regmap_write(priv->map, TCSR0, 0);
>> +		regmap_write(priv->map, TCSR1, 0);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void xilinx_pwm_get_state(struct pwm_chip *chip,
>> +				 struct pwm_device *unused,
>> +				 struct pwm_state *state)
>> +{
>> +	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
>> +	u32 tlr0, tlr1, tcsr0, tcsr1;
>> +
>> +	regmap_read(priv->map, TLR0, &tlr0);
>> +	regmap_read(priv->map, TLR1, &tlr1);
>> +	regmap_read(priv->map, TCSR0, &tcsr0);
>> +	regmap_read(priv->map, TCSR1, &tcsr1);
>> +	state->period = xilinx_timer_get_period(priv, tlr0, tcsr0);
>
> xilinx_timer_get_period rounds down, this is however wrong for
> .get_state().

Why is this wrong? I thought get_state should return values which would
not be rounded if passed to apply_state.

>> +	state->duty_cycle = xilinx_timer_get_period(priv, tlr1, tcsr1);
>
> ditto for duty_cycle.
>
>> +	state->enabled = xilinx_timer_pwm_enabled(tcsr0, tcsr1);
>> +	state->polarity = PWM_POLARITY_NORMAL;
>> [...]
>> +static int xilinx_timer_probe(struct platform_device *pdev)
>> +{
>> +	int ret;
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *np = dev->of_node;
>> +	struct xilinx_timer_priv *priv;
>> +	struct xilinx_pwm_device *pwm;
>> +	u32 pwm_cells, one_timer;
>> +	void __iomem *regs;
>> +
>> +	ret = of_property_read_u32(np, "#pwm-cells", &pwm_cells);
>> +	if (ret == -EINVAL)
>> +		return -ENODEV;
>> +	else if (ret)
>> +		return dev_err_probe(dev, ret, "could not read #pwm-cells\n");
>
> Please capitalize error messages.

Ok.

>> [...]
>> +	if (ret) {
>> +		clk_rate_exclusive_put(priv->clk);
>> +		clk_disable_unprepare(priv->clk);
>> +		return dev_err_probe(dev, ret, "could not register pwm chip\n");
>
> s/pwm/PWM/

Ok.

Thanks for the review.

--Sean
