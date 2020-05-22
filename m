Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0801C1DE5E4
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2020 13:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgEVLuL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 May 2020 07:50:11 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12165 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbgEVLuL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 May 2020 07:50:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec7bc220000>; Fri, 22 May 2020 04:48:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 22 May 2020 04:50:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 22 May 2020 04:50:10 -0700
Received: from [10.26.74.233] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 May
 2020 11:50:07 +0000
Subject: Re: [PATCH V2] pwm: tegra: dynamic clk freq configuration by PWM
 driver
To:     Sandipan Patra <spatra@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
CC:     Bibek Basu <bbasu@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1587398043-18767-1-git-send-email-spatra@nvidia.com>
 <34ae18f5-494c-7bc7-0f30-2d1455bbcb55@nvidia.com>
 <BYAPR12MB3014B051AD088B42001A8132ADB40@BYAPR12MB3014.namprd12.prod.outlook.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <21428954-41cc-c01a-bca2-7eb19f444272@nvidia.com>
Date:   Fri, 22 May 2020 12:50:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB3014B051AD088B42001A8132ADB40@BYAPR12MB3014.namprd12.prod.outlook.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590148130; bh=yI/+m748+MOsQtm6uoltc0jINBpkfoBnNW5r6tZsKYs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=qX/mLBGswt2CFjr8YSj8qxjPOcIu6DWoGFKTf8kF0HjvHrxaklVNpydTHD4VcCyVi
         RBa+XUM35CWxR2xorg5XK4scr6A5xlI3MYimd10KkuS2Fx7efYp2w6jUFMBaiZFX5M
         4cFMs8GfAIY7/ce1l55gBphjcWAwXexixg3H+ppFxA+DPGMuWgQsxeoFQfoJWHJ6Na
         tnI61mZmaDI48B9Sv6b0xMMjVAWVL0Rs1M6aseAVfp13Vr9TpGSgA4u2IVsTFGY97i
         oiStz9jr14S8TyOfOohD1l47qX5bH8SrGG668IrWt5vSD8DUfEUAzhcHYmS84kDFIr
         cQ+zm23InY4hQ==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 22/05/2020 12:01, Sandipan Patra wrote:
> Thanks Jonathan,
> Please help reviewing further with my replies inline.
>=20
>=20
> Thanks & Regards,
> Sandipan
>=20
>> -----Original Message-----
>> From: Jonathan Hunter <jonathanh@nvidia.com>
>> Sent: Friday, May 22, 2020 3:54 PM
>> To: Sandipan Patra <spatra@nvidia.com>; Thierry Reding
>> <treding@nvidia.com>; robh+dt@kernel.org; u.kleine-koenig@pengutronix.de
>> Cc: Bibek Basu <bbasu@nvidia.com>; Laxman Dewangan
>> <ldewangan@nvidia.com>; linux-pwm@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-tegra@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH V2] pwm: tegra: dynamic clk freq configuration by PW=
M
>> driver
>>
>>
>> On 20/04/2020 16:54, Sandipan Patra wrote:
>>> Added support for dynamic clock freq configuration in pwm kernel driver=
.
>>> Earlier the pwm driver used to cache boot time clock rate by pwm clock
>>> parent during probe. Hence dynamically changing pwm frequency was not
>>> possible for all the possible ranges. With this change, dynamic
>>> calculation is enabled and it is able to set the requested period from
>>> sysfs knob provided the value is supported by clock source.
>>>
>>> Changes mainly have 2 parts:
>>>   - T186 and later chips [1]
>>>   - T210 and prior chips [2]
>>>
>>> For [1] - Changes implemented to set pwm period dynamically and
>>>           also checks added to allow only if requested period(ns) is
>>>           below or equals to higher range.
>>>
>>> For [2] - Only checks if the requested period(ns) is below or equals
>>>           to higher range defined by max clock limit. The limitation
>>>           in T210 or prior chips are due to the reason of having only
>>>           one pwm-controller supporting multiple channels. But later
>>>           chips have multiple pwm controller instances each having
>>> 	  single channel support.
>>>
>>> Signed-off-by: Sandipan Patra <spatra@nvidia.com>
>>> ---
>>> V2:
>>> 1. Min period_ns calculation is moved to probe.
>>> 2. Added descriptioins for PWM register bits and regarding behaviour
>>>    of the controller when new configuration is applied or pwm is disabl=
ed.
>>> 3. Setting period with possible value when supplied period is below lim=
it.
>>> 4. Corrected the earlier code comment:
>>>    plus 1 instead of minus 1 during pwm calculation
>>>
>>>  drivers/pwm/pwm-tegra.c | 110
>>> +++++++++++++++++++++++++++++++++++++++++-------
>>>  1 file changed, 94 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c index
>>> d26ed8f..7a36325 100644
>>> --- a/drivers/pwm/pwm-tegra.c
>>> +++ b/drivers/pwm/pwm-tegra.c
>>> @@ -4,8 +4,39 @@
>>>   *
>>>   * Tegra pulse-width-modulation controller driver
>>>   *
>>> - * Copyright (c) 2010, NVIDIA Corporation.
>>> - * Based on arch/arm/plat-mxc/pwm.c by Sascha Hauer
>>> <s.hauer@pengutronix.de>
>>> + * Copyright (c) 2010-2020, NVIDIA Corporation.
>>> + *
>>> + * Overview of Tegra Pulse Width Modulator Register:
>>> + * 1. 13-bit: Frequency division (SCALE)
>>> + * 2. 8-bit : Puls division (DUTY)
>>> + * 3. 1-bit : Enable bit
>>> + *
>>> + * The PWM clock frequency is divided by 256 before subdividing it
>>> + based
>>> + * on the programmable frequency division value to generate the
>>> + required
>>> + * frequency for PWM output. The maximum output frequency that can be
>>> + * achieved is (max rate of source clock) / 256.
>>> + * i.e. if source clock rate is 408 MHz, maximum output frequency cab =
be:
>>> + * 408 MHz/256 =3D 1.6 MHz.
>>> + * This 1.6 MHz frequency can further be divided using SCALE value in =
PWM.
>>> + *
>>> + * PWM pulse width: 8 bits are usable [23:16] for varying pulse width.
>>> + * To achieve 100% duty cycle, program Bit [24] of this register to
>>> + * 1=E2=80=99b1. In which case the other bits [23:16] are set to don't=
 care.
>>> + *
>>> + * Limitations and known facts:
>>> + * -	When PWM is disabled, the output is driven to 0.
>>> + * -	It does not allow the current PWM period to complete and
>>> + *	stops abruptly.
>>> + *
>>> + * -	If the register is reconfigured while pwm is running,
>>> + *	It does not let the currently running period to complete.
>>> + *
>>> + * -	Pulse width of the pwm can never be out of bound.
>>> + *	It's taken care at HW and SW
>>> + * -	If the user input duty is below limit, then driver sets it to
>>> + *	minimum possible value.
>>> + * -	If anything else goes wrong for setting duty or period,
>>> + *	-EINVAL is returned.
>>>   */
>>>
>>>  #include <linux/clk.h>
>>> @@ -41,6 +72,7 @@ struct tegra_pwm_chip {
>>>  	struct reset_control*rst;
>>>
>>>  	unsigned long clk_rate;
>>> +	unsigned long min_period_ns;
>>>
>>>  	void __iomem *regs;
>>>
>>> @@ -67,8 +99,9 @@ static int tegra_pwm_config(struct pwm_chip *chip,
>> struct pwm_device *pwm,
>>>  			    int duty_ns, int period_ns)
>>>  {
>>>  	struct tegra_pwm_chip *pc =3D to_tegra_pwm_chip(chip);
>>> -	unsigned long long c =3D duty_ns, hz;
>>> -	unsigned long rate;
>>> +	unsigned long long p_width =3D duty_ns, period_hz;
>>> +	unsigned long rate, required_clk_rate;
>>> +	unsigned long pfm; /* Frequency divider */
>>
>> If it is not necessary to change the variable names, then I would prefer=
 we keep
>> them as is as then changes would be less.
>=20
> The earlier name was misleading so thought to use a specific name for
> which it can be helpful to follow up with the TRM. Since its recommended
> to retain the variable names, I will change this in next patch.

I was just wondering if was necessary to change 'c' to 'p_width'. This
could reduce the diff a bit.

>>
>>>  	u32 val =3D 0;
>>>  	int err;
>>>
>>> @@ -77,37 +110,77 @@ static int tegra_pwm_config(struct pwm_chip *chip,
>> struct pwm_device *pwm,
>>>  	 * per (1 << PWM_DUTY_WIDTH) cycles and make sure to round to the
>>>  	 * nearest integer during division.
>>>  	 */
>>> -	c *=3D (1 << PWM_DUTY_WIDTH);
>>> -	c =3D DIV_ROUND_CLOSEST_ULL(c, period_ns);
>>> +	p_width *=3D (1 << PWM_DUTY_WIDTH);
>>> +	p_width =3D DIV_ROUND_CLOSEST_ULL(p_width, period_ns);
>>>
>>> -	val =3D (u32)c << PWM_DUTY_SHIFT;
>>> +	val =3D (u32)p_width << PWM_DUTY_SHIFT;
>>> +
>>> +	/*
>>> +	 *  Period in nano second has to be <=3D highest allowed period
>>> +	 *  based on max clock rate of the pwm controller.
>>> +	 *
>>> +	 *  higher limit =3D max clock limit >> PWM_DUTY_WIDTH
>>> +	 *  lower limit =3D min clock limit >> PWM_DUTY_WIDTH >>
>> PWM_SCALE_WIDTH
>>> +	 */
>>> +	if (period_ns < pc->min_period_ns) {
>>> +		period_ns =3D pc->min_period_ns;
>>> +		pr_warn("Period is adjusted to allowed value (%d ns)\n",
>>> +				period_ns);
>>
>> I see that other drivers (pwm-img.c) consider this to be an error and re=
turn an
>> error. I wonder if adjusting the period makes sense here?
>>
>> I wonder if the handling of the min_period, should be a separate change?
>=20
> I think I misunderstood one of the discussions in initial patch and added=
 this change
> to apply the minimum possible value. Understood and will revert this chan=
ge
> with returning error in such case.
>=20
>>
>>> +	}
>>>
>>>  	/*
>>>  	 * Compute the prescaler value for which (1 << PWM_DUTY_WIDTH)
>>>  	 * cycles at the PWM clock rate will take period_ns nanoseconds.
>>>  	 */
>>> -	rate =3D pc->clk_rate >> PWM_DUTY_WIDTH;
>>> +	if (pc->soc->num_channels =3D=3D 1) {
>>
>> Are you using num_channels to determine if Tegra uses the BPMP? If so th=
en the
>> above is not really correct, because num_channels is not really related =
to what is
>> being done here. So maybe you need a new SoC attribute in the soc data.
>=20
> Here, it tries to find if pwm controller uses multiple channels (like in =
Tegra210 or older)
> or single channel for every pwm instance (i.e. T186, T194). If found mult=
iple channels on
> a single controller then it is not correct to configure separate clock ra=
tes to each of the
> channels. So to distinguish the controller and channel type, num_channels=
 is referred.

OK, then that makes sense. Maybe add this detail to the comment about
why num_channels is used.

>>
>>> +		/*
>>> +		 * Rate is multiplied with 2^PWM_DUTY_WIDTH so that it
>> matches
>>> +		 * with the hieghest applicable rate that the controller can
>>
>> s/hieghest/highest/
>=20
> Got it.
>=20
>>
>>> +		 * provide. Any further lower value can be derived by setting
>>> +		 * PFM bits[0:12].
>>> +		 * Higher mark is taken since BPMP has round-up mechanism
>>> +		 * implemented.
>>> +		 */
>>> +		required_clk_rate =3D
>>> +			(NSEC_PER_SEC / period_ns) << PWM_DUTY_WIDTH;
>>> +
>>
>> Should be we checking the rate against the max rate supported?
>=20
> If the request rate is beyond max supported rate, then the clk_set_rate w=
ill be failing
> and can get caught with error check followed by. Otherwise it will fail t=
hrough fitting in
> the register's frequency divider filed. So I think it is not required to =
check against max rate.
> Please advise if I am not able to follow with what you are suggesting.

I think that it would be better to update the cached value so that it is
not incorrectly used else where by any future change. Furthermore, this
simplifies matters a bit because you can do the following for all
devices, but only update the clk_rate for those you wish to ...

    rate =3D pc->clk_rate >> PWM_DUTY_WIDTH;

>>
>>> +		err =3D clk_set_rate(pc->clk, required_clk_rate);
>>> +		if (err < 0)
>>> +			return -EINVAL;
>>> +
>>> +		rate =3D clk_get_rate(pc->clk) >> PWM_DUTY_WIDTH;
>>
>> Do we need to update the pwm->clk_rate here?
>=20
> This return rate is basically from the factor that requested clk_set_rate=
 and the actual rate set
> mostly will have a little deviation based on the clock divider and other =
factors while setting
> a new rate. So capturing the actual rate for further calculation and conv=
ersion to Hz.
> Whenever it is required to use pwm->clk_rate we are no longer depending u=
pon the cached value
> for num_channels =3D=3D 1. So in my opinion it does not need to be cached=
. However it is kept
> stored for the SoCs having num_channels > 1.
> Please suggest if I am missing any case where we need to keep the value s=
tored.

OK sounds fine.

>>
>>> +	} else {
>>> +		/*
>>> +		 * This is the case for SoCs who support multiple channels:
>>> +		 *
>>> +		 * clk_set_rate() can not be called again in config because
>>> +		 * T210 or any prior chip supports one pwm-controller and
>>> +		 * multiple channels. Hence in this case cached clock rate
>>> +		 * will be considered which was stored during probe.
>>> +		 */
>>> +		rate =3D pc->clk_rate >> PWM_DUTY_WIDTH;
>>> +	}
>>>
>>>  	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
>>> -	hz =3D DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns);
>>> -	rate =3D DIV_ROUND_CLOSEST_ULL(100ULL * rate, hz);
>>> +	period_hz =3D DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC,
>> period_ns);
>>> +	pfm =3D DIV_ROUND_CLOSEST_ULL(100ULL * rate, period_hz);
>>>
>>>  	/*
>>>  	 * Since the actual PWM divider is the register's frequency divider
>>> -	 * field minus 1, we need to decrement to get the correct value to
>>> +	 * field plus 1, we need to decrement to get the correct value to
>>>  	 * write to the register.
>>>  	 */
>>> -	if (rate > 0)
>>> -		rate--;
>>> +	if (pfm > 0)
>>> +		pfm--;
>>>
>>>  	/*
>>> -	 * Make sure that the rate will fit in the register's frequency
>>> +	 * Make sure that pfm will fit in the register's frequency
>>>  	 * divider field.
>>>  	 */
>>> -	if (rate >> PWM_SCALE_WIDTH)
>>> +	if (pfm >> PWM_SCALE_WIDTH)
>>>  		return -EINVAL;
>>>
>>> -	val |=3D rate << PWM_SCALE_SHIFT;
>>> +	val |=3D pfm << PWM_SCALE_SHIFT;
>>>
>>>  	/*
>>>  	 * If the PWM channel is disabled, make sure to turn on the clock @@
>>> -205,6 +278,10 @@ static int tegra_pwm_probe(struct platform_device
>> *pdev)
>>>  	 */
>>>  	pwm->clk_rate =3D clk_get_rate(pwm->clk);
>>>
>>> +	/* Set minimum limit of PWM period for the IP */
>>> +	pwm->min_period_ns =3D
>>> +	    (NSEC_PER_SEC / (pwm->soc->max_frequency >>
>> PWM_DUTY_WIDTH)) +
>>> +1;
>>> +
>>>  	pwm->rst =3D devm_reset_control_get_exclusive(&pdev->dev, "pwm");
>>>  	if (IS_ERR(pwm->rst)) {
>>>  		ret =3D PTR_ERR(pwm->rst);
>>> @@ -313,4 +390,5 @@ module_platform_driver(tegra_pwm_driver);
>>>
>>>  MODULE_LICENSE("GPL");
>>>  MODULE_AUTHOR("NVIDIA Corporation");
>>> +MODULE_AUTHOR("Sandipan Patra <spatra@nvidia.com>");
>>>  MODULE_ALIAS("platform:tegra-pwm");
>>>
>>
>> --
>> nvpublic

--=20
nvpublic
