Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61C3343B7F
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 09:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhCVIRV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 04:17:21 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:39468 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhCVIQ5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 04:16:57 -0400
Received: from antares.kleine-koenig.org (localhost [127.0.0.1])
        by antares.kleine-koenig.org (Postfix) with ESMTP id C962BB3C86B;
        Mon, 22 Mar 2021 09:16:48 +0100 (CET)
Received: from antares.kleine-koenig.org ([94.130.110.236])
        by antares.kleine-koenig.org (antares.kleine-koenig.org [94.130.110.236]) (amavisd-new, port 10024)
        with ESMTP id B0BHinaC3rfe; Mon, 22 Mar 2021 09:16:47 +0100 (CET)
Received: from taurus.defre.kleine-koenig.org (unknown [IPv6:2a02:8071:b5c8:7bfc:9c64:7e23:b041:2958])
        by antares.kleine-koenig.org (Postfix) with ESMTPSA;
        Mon, 22 Mar 2021 09:16:47 +0100 (CET)
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <20210316203813.48999-1-uwe@kleine-koenig.org>
 <YFfHciL2CXX0aERa@google.com>
From:   =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCH] input: misc: max8997: Switch to pwm_apply()
Message-ID: <2972bc70-2535-0c09-faff-b74f6842fbc4@kleine-koenig.org>
Date:   Mon, 22 Mar 2021 09:16:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFfHciL2CXX0aERa@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JvyNxNltdv0BXIJPkZRotIbzCSnA5NFaQ"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JvyNxNltdv0BXIJPkZRotIbzCSnA5NFaQ
Content-Type: multipart/mixed; boundary="w33nu2tB8mrXCo1yBobfSrvxPtJKuPS6T";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
 Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org,
 linux-pwm@vger.kernel.org
Message-ID: <2972bc70-2535-0c09-faff-b74f6842fbc4@kleine-koenig.org>
Subject: Re: [PATCH] input: misc: max8997: Switch to pwm_apply()
References: <20210316203813.48999-1-uwe@kleine-koenig.org>
 <YFfHciL2CXX0aERa@google.com>
In-Reply-To: <YFfHciL2CXX0aERa@google.com>

--w33nu2tB8mrXCo1yBobfSrvxPtJKuPS6T
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On 3/21/21 11:23 PM, Dmitry Torokhov wrote:
> On Tue, Mar 16, 2021 at 09:38:13PM +0100, Uwe Kleine-K=C3=B6nig wrote:
>> max8997_haptic_enable() is the only caller of
>> max8997_haptic_set_duty_cycle(). For the non-external case the PWM is
>> already enabled in max8997_haptic_set_duty_cycle(), so this can be don=
e
>=20
> Are you sure about that? I think the intent was to enable it in
> max8997_haptic_configure(), and only after "inmotor" regulator is
> enabled. If the device is enabled earlier then I'd say we need to make
> sure we disable it until it is needed.

If you claim you understand this better, I will well believe that. I=20
described my train of thoughts, i.e. how I understood the internal case.

Anyhow, there is little sense in separating configuration and enablement =

of the PWM, because the change of duty_cycle and period for a disabled=20
PWM is expected to do nothing to the hardware's output.

So the safer approach is to do the pwm_apply_state at the place, where=20
pwm_enable was before, but the more consistent is how I suggested in my=20
patch. If it feels better I can do the more conservative change instead=20
and if somebody with a deeper understanding of the driver and/or a=20
testing possibility can be found, the internal and external cases can be =

unified.

Best regards
Uwe



--w33nu2tB8mrXCo1yBobfSrvxPtJKuPS6T--

--JvyNxNltdv0BXIJPkZRotIbzCSnA5NFaQ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBYUmwACgkQwfwUeK3K
7AmkRAf8CAFrFLvQHlKyLbx7t9+KGMdjs2F6VHvUPJjk5uGtFc2rRsPPFugjqwfR
uuPomfMeIrhRv6t76cOFtDhva7ArOmhdAHDk0ETHQl6RpqQJPCHFAv5EWOpElHqU
TpftF9OxpC4Bl4ZHWgCIDeB9c1JrwrA8BOUlgLsXPQxEZWgJpHwKehfl59Ezy7jP
QU1en1uRwQ+G1U45t6ktpNRazwv3KUMgyDQI6wLw37KLSRgWHKp2vEE4pflviK6i
7Zl/zOsDbzQFd/4SqnLvpTWWPgjMI7JuYf5/soNYLjJPTCFnrDiiRTw6B4kgdR1K
XlMFIdwEB2zRoZ7Ggl6Ni0GsbJDPQQ==
=keJR
-----END PGP SIGNATURE-----

--JvyNxNltdv0BXIJPkZRotIbzCSnA5NFaQ--
