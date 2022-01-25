Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB9149B8B7
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Jan 2022 17:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354693AbiAYQc7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Jan 2022 11:32:59 -0500
Received: from guitar.tcltek.co.il ([84.110.109.230]:35343 "EHLO mx.tkos.co.il"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351814AbiAYQ1w (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 25 Jan 2022 11:27:52 -0500
Received: from tarshish (unknown [10.0.8.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 3C10244054B;
        Tue, 25 Jan 2022 18:27:32 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1643128052;
        bh=365wbsZ+slH2WT/1BiDeRvDFqeAyANMTS5QZ1uk8BG0=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=M0ufAGtM9x63kvTpequ0qLOIGlgJZPfzPyBMjA+FBNJcvvVscLlQmI0CB0bGxcsWO
         BOKALsKf1bxozGcK74Qw8eja/x2TPgVcic/x9fz6E3aURvImP61GSC7ybQA1MGZ7gr
         BxYJH1klo9/OxGs25sQ/7JeSmZUCIDEiLSg1ceGDrTSl1BZxTKAfBG8UoY1OVF5l4w
         6dVwX+D5KZyYcaGbM4bu2D+LDkRr+rwbsHbsovS682LE+C3zvkTN7HGpAx4clneTlR
         w1pDqMLn+wpAMVWmxEkuIwqeAV9JWbcMjWGibooQitCS1MNk8Nol2sNIfKq7vOBvFg
         sd72CyJdQe5Qg==
References: <ab2a4c345844f66aa22a847e522b2f4ee0786d8b.1639499239.git.baruch@tkos.co.il>
 <20220119172439.be4xpaqgwzdy26oh@pengutronix.de> <87tuds7y09.fsf@tarshish>
 <20220125161204.hx5foivny6iupjke@pengutronix.de>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 1/3] pwm: driver for qualcomm ipq6018 pwm block
Date:   Tue, 25 Jan 2022 18:22:45 +0200
In-reply-to: <20220125161204.hx5foivny6iupjke@pengutronix.de>
Message-ID: <87pmof93wf.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Tue, Jan 25 2022, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Jan 25, 2022 at 03:03:08PM +0200, Baruch Siach wrote:
>> On Wed, Jan 19 2022, Uwe Kleine-K=C3=B6nig wrote:
>> > The task here is to calculate the biggest pwm_div for a given pre_div
>> > such that
>> >
>> >
>> > 	(pre_div + 1) * (pwm_div + 1) * NSEC_PER_SEC
>> > 	-------------------------------------------- <=3D period_ns
>> > 	                   rate
>> >
>> > right?
>> >
>> > This is equivalent to:
>> >
>> > 	                  period_ns * rate
>> > 	pre_div <=3D ---------------------------- - 1
>> > 	           (pre_div + 1) * NSEC_PER_SEC
>> >
>> > As pre_div is integer, rounding down should be fine?!
>>=20
>> I can't follow. With round down (as in v8) the result is always:
>>=20
>>   NSEC_PER_SEC * (pre_div + 1) * (pwm_div + 1) <=3D period_rate
>
> Yes, that's the condition that a valid configuration should fulfill
> because then the configured period is never bigger than the requested
> period.
>=20=20
>> As a result, 'diff' calculation below will always produce diff <=3D 0. W=
hen
>> there is no diff =3D=3D 0 result (bingo) we get IPQ_PWM_MAX_DIV in both =
best_
>> values at the end of the loop.
>
> Looking again, your check is wrong. I think you need:
>
> 	diff =3D period_rate - NSEC_PER_SEC * (pre_div + 1) * (pwm_div + 1)
>
> . Given the calculations for pre_div and pwm_div this should never be
> negative and you should pick values that minimize diff.

So, if I understand correctly, you suggest to leave round up as in v10,
and invert the diff calculation. Is that correct?

Thanks,
baruch

--=20
                                                     ~. .~   Tk Open Systems
=3D}------------------------------------------------ooO--U--Ooo------------=
{=3D
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
