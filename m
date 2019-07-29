Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA1BA79AEC
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2019 23:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388439AbfG2VTl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Jul 2019 17:19:41 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:43848 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388438AbfG2VTk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jul 2019 17:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1564435178; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QmEPIGFBMm6hTexG00Zc+PEgLZAbvvk8D/QaFLV1UTU=;
        b=x4tH5xz6Tnwv9keFVRYGBUv2iYQ1Nh1fmK+6DvgUAs/VqBGsLKMDw72yTxoQ6praZ4VV6J
        9TjVBzJnbiL5PgvbnCGWrF0f6NUce24hSRlN+8V8w1r/aK1OJyoQzofAzVaqBRp4apw/ZZ
        c2fSPStyF4N+bQT061Q+azuv2epAOJY=
Date:   Mon, 29 Jul 2019 17:19:23 -0400
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 3/6] pwm: jz4740: Apply configuration atomically
To:     Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Message-Id: <1564435163.6633.4@crapouillou.net>
In-Reply-To: <20190724064745.7ghecdpg3gmxsiim@pengutronix.de>
References: <20190607154410.10633-1-paul@crapouillou.net>
        <20190607154410.10633-4-paul@crapouillou.net>
        <20190722193456.h4hfte5cczucermd@pengutronix.de>
        <1563914800.1918.0@crapouillou.net>
        <20190724064745.7ghecdpg3gmxsiim@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,


Le mer. 24 juil. 2019 =E0 2:47, Uwe =3D?iso-8859-1?q?Kleine-K=3DF6nig?=3D=20
<u.kleine-koenig@pengutronix.de> a =E9crit :
> Hello Paul,
>=20
> On Tue, Jul 23, 2019 at 04:46:40PM -0400, Paul Cercueil wrote:
>>  Le lun. 22 juil. 2019 =E0 15:34, Uwe =3D?iso-8859-1?q?Kleine-K=3DF6nig?=
=3D
>>  <u.kleine-koenig@pengutronix.de> a =E9crit :
>>  > On Fri, Jun 07, 2019 at 05:44:07PM +0200, Paul Cercueil wrote:
>>  > >  -	is_enabled =3D jz4740_timer_is_enabled(pwm->hwpwm);
>>  > >  -	if (is_enabled)
>>  > >  -		jz4740_pwm_disable(chip, pwm);
>>  > >  +	jz4740_pwm_disable(chip, pwm);
>>  >
>>  > I assume this stops the PWM. Does this complete the currently=20
>> running
>>  > period? How does the PWM behave then? (Does it still drive the=20
>> output?
>>  > If so, on which level?)
>>=20
>>  Some PWM channels work in one mode "TCU1" and others work in=20
>> "TCU2". The
>>  mode in which channels work depends on the version of the SoC.
>>=20
>>  When stopped, the pins of TCU1 channels will be driven to the=20
>> inactive
>>  level (which depends on the polarity). It is unknown whether or not=20
>> the
>>  currently running period is completed. We set a bit to configure for
>>  "abrupt shutdown", so I expect that it's not, but somebody would=20
>> need
>>  to hook up a logic analyzer to see what's the exact behaviour with
>>  and without that bit.
>=20
> This might be done even without a logic analyzer. Just do something
> like:
>=20
> 	pwm_apply_state(pwm, { .enabled =3D 1, .period =3D 5s })
> 	pwm_apply_state(pwm, { .enabled =3D 1, .period =3D 5s, .duty =3D 5s })
>=20
> and if that takes less then 5s the period is not completed.
>=20
> And note that "abrupt shutdown" is a bug.

I remember you asked that already in an older patchset.
The result of this test is that the period is never completed,
independently of the "abrupt shutdown" bit.

Cheers,
-Paul


>>  TCU2 channels on the other hand will stop in the middle of a period,
>>  leaving the pin hanging at whatever level it was before the stop.
>>  That's the rationale behind the trick in commit 6580fd173070 ("pwm:
>>  jz4740: Force TCU2 channels to return to their init level").
>=20
> Strange, but ok.
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig       =20
>     |
> Industrial Linux Solutions                 |=20
> http://www.pengutronix.de/  |

=

