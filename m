Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5180A474783
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Dec 2021 17:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhLNQUf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Dec 2021 11:20:35 -0500
Received: from guitar.tcltek.co.il ([84.110.109.230]:39105 "EHLO mx.tkos.co.il"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229542AbhLNQUf (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 14 Dec 2021 11:20:35 -0500
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Dec 2021 11:20:34 EST
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 886E8440F2F;
        Tue, 14 Dec 2021 18:13:54 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1639498435;
        bh=1fwIRY6SB3en15B126frdgqHFepu3cN45gLKiln9Nso=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=cdw3xqZFuSgR1xxHE6O8fkXx9pMF+xk8tQ4fd2t34wC3GLOUi6slFaBkrhOZNwZof
         0Da0Bn179QiOLwtMxT96UQn6kOmlZYnKd1ZvmN/j3x520pCiIdEpThimWCewQP2g2o
         sC3eA5WO9r3E+iR/vzHSjhxfqj8i2hFAHHySxrLyC4Kfx4U/UNB0e7jDb0shTjLJFc
         g8arPYBAoONPTa0twWhLU6KeISS2rTuWrEfo+ZedJlVSsT6zFvj8DMIp8Yjh6/OT9F
         Ve/LaPoDVVXD05Q7I9ajmRr+3w+ZjTSMUbzNx/NYpRbkVgOzcEfvbVhX1olHPhEjRV
         tAVJKnN9qK5Pg==
References: <5c95bcf62a9d08208a7da19f0b1cec0689502b9a.1630323987.git.baruch@tkos.co.il>
 <bdc61569e4068490f53f347dcf29ee9539a8bc0b.1630323987.git.baruch@tkos.co.il>
 <20210914124959.spwjiifvysposhls@pengutronix.de>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v8 2/4] pwm: driver for qualcomm ipq6018 pwm block
Date:   Tue, 14 Dec 2021 18:05:08 +0200
In-reply-to: <20210914124959.spwjiifvysposhls@pengutronix.de>
Message-ID: <87pmpzmaf1.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Tue, Sep 14 2021, Uwe Kleine-K=C3=B6nig wrote:
> On Mon, Aug 30, 2021 at 02:46:25PM +0300, Baruch Siach wrote:
>> +	for (; pre_div <=3D IPQ_PWM_MAX_DIV; pre_div++) {
>> +		pwm_div =3D DIV64_U64_ROUND_UP(period_ns * rate,
>> +				(u64)NSEC_PER_SEC * (pre_div + 1));
>> +		pwm_div--;
>
> Can it happen that pwm_div is zero before it is decreased by one? Also
> you need to round down here; with rounding up the resulting period is
> bigger than the requested period (unless the division yields an exact
> integer).

I followed your round down advice on v9, but it turned out to be
wrong. Round down means that the divider is smaller so the period is
larger. This means that 'diff' below can not be positive. So only exact
match (diff =3D=3D 0) works. When there is no exact match, best_* values are
left in their initial setting.

I'll fix that in v10 along with another bug I introduced in v9.

baruch

>> +		if (pre_div > pwm_div)
>> +			break;
>
> A comment here why we can end the search would be good.
>
>> +		/*
>> +		 * Make sure we can do 100% duty cycle where
>> +		 * hi_dur =3D=3D pwm_div + 1
>> +		 */
>> +		if (pwm_div > IPQ_PWM_MAX_DIV - 1)
>> +			continue;
>> +
>> +		diff =3D ((uint64_t)freq * (pre_div + 1) * (pwm_div + 1))
>> +			- (uint64_t)rate;
>> +
>> +		if (diff < 0) /* period larger than requested */
>> +			continue;
>> +		if (diff =3D=3D 0) { /* bingo */
>> +			best_pre_div =3D pre_div;
>> +			best_pwm_div =3D pwm_div;
>> +			break;
>> +		}
>> +		if (diff < min_diff) {
>> +			min_diff =3D diff;
>> +			best_pre_div =3D pre_div;
>> +			best_pwm_div =3D pwm_div;
>> +		}
>> +	}
>> +
>> +	/* config divider values for the closest possible frequency */
>> +	config_div_and_duty(pwm, best_pre_div, best_pwm_div,
>> +			    rate, duty_ns, state->enabled);
>> +
>> +	return 0;
>> +}

--=20
                                                     ~. .~   Tk Open Systems
=3D}------------------------------------------------ooO--U--Ooo------------=
{=3D
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
