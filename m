Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5168725783C
	for <lists+linux-pwm@lfdr.de>; Mon, 31 Aug 2020 13:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgHaLYW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 Aug 2020 07:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgHaLWt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 Aug 2020 07:22:49 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBC4C0619CD;
        Mon, 31 Aug 2020 04:14:01 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id w1so1408969edr.3;
        Mon, 31 Aug 2020 04:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FExIKAHJpPJFM3Hd44tazabRIhwd+0VFgHYZYcprPmE=;
        b=EKtSjKtzv24vUhMxF+gt7LwUCEObaU3gPowz0n9Rvrs8wdxgAIP+QWufXKZujYYBhU
         Uo3CawjQpfdgFZBlGzpSwcubxyiiNXXVDUdNI9pGzCRScHb+9Bx0Wi6AFSI38OW/MVsW
         mb5I7dO6ZerK1fHSeLbbvhUX8Mk7s4nXY26gGXR0ddg0f/1pkKMVDJ7n6HCmfyccD01O
         TznDM/nTvjkVwovGVCCZqGsAi99CkHPtrA75S8+H4pbgxqW7Agw7EvCJ4jPhT3AO0jZR
         VaBi0zdqGpEtCxJsbI8Y7bMV9TAgfmtiuqHV0OqjC1iMDTIKHeR6L+M0OzsqDwofuF2e
         eWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FExIKAHJpPJFM3Hd44tazabRIhwd+0VFgHYZYcprPmE=;
        b=fPwR34Ctgons79u596ymLdW3VpmeCHpJLICdaf3VBJ4vITwFgrVsef0b6bUFVKYL+M
         vT39xWD3WwxOJHmggMsVvtp7P6VlkSakzhVTBOiTLaRWwr+XVmTLe3SUL0eol0aVi62G
         Q+1/8SadJkM7dXw3ceJPMqs6CplrAs9pnZEioZO9PyfgZJREr0BZ90cLYLj898CYhytW
         DEFzsHSywk6IhSEHj4mn9iCsHECgfherS94Xg7wP38rgZKagTbH6HNqNlPB7FE01qOwS
         rfOrSu3BJ/S4hmpb/7i8fFpycQFaAvCWta50AsQNthF0VwfnVrhy83Pg4N4gkN8tq2Yv
         A9Ug==
X-Gm-Message-State: AOAM5321OD2yhBESZ0d6rom0AMBzisJ1Gv03sr0fERkvAfx3qkVQuV8s
        S1TlhcMa8wo0QKodJIwg6ZI=
X-Google-Smtp-Source: ABdhPJzSou1EakYOIg96I8GnoircE3Vn7kSNmn6F1/7zwYOg6k41dpCvAPKfpjEEd/aEdMlY9skw5w==
X-Received: by 2002:aa7:d146:: with SMTP id r6mr720807edo.335.1598872440245;
        Mon, 31 Aug 2020 04:14:00 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id o7sm7165100edq.53.2020.08.31.04.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 04:13:59 -0700 (PDT)
Date:   Mon, 31 Aug 2020 13:13:58 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v8 08/17] pwm: crc: Fix period / duty_cycle times being
 off by a factor of 256
Message-ID: <20200831111358.GF1688464@ulmo>
References: <20200830125753.230420-1-hdegoede@redhat.com>
 <20200830125753.230420-9-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/QKKmeG/X/bPShih"
Content-Disposition: inline
In-Reply-To: <20200830125753.230420-9-hdegoede@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--/QKKmeG/X/bPShih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2020 at 02:57:44PM +0200, Hans de Goede wrote:
> While looking into adding atomic-pwm support to the pwm-crc driver I
> noticed something odd, there is a PWM_BASE_CLK define of 6 MHz and
> there is a clock-divider which divides this with a value between 1-128,
> and there are 256 duty-cycle steps.
>=20
> The pwm-crc code before this commit assumed that a clock-divider
> setting of 1 means that the PWM output is running at 6 MHZ, if that
> is true, where do these 256 duty-cycle steps come from?
>=20
> This would require an internal frequency of 256 * 6 MHz =3D 1.5 GHz, that
> seems unlikely for a PMIC which is using a silicon process optimized for
> power-switching transistors. It is way more likely that there is an 8
> bit counter for the duty cycle which acts as an extra fixed divider
> wrt the PWM output frequency.
>=20
> The main user of the pwm-crc driver is the i915 GPU driver which uses it
> for backlight control. Lets compare the PWM register values set by the
> video-BIOS (the GOP), assuming the extra fixed divider is present versus
> the PWM frequency specified in the Video-BIOS-Tables:
>=20
> Device:		PWM Hz set by BIOS	PWM Hz specified in VBT
> Asus T100TA 	200			200
> Asus T100HA 	200			200
> Lenovo Miix 2 8	23437			20000
> Toshiba WT8-A	23437			20000
>=20
> So as we can see if we assume the extra division by 256 then the register
> values set by the GOP are an exact match for the VBT values, where as
> otherwise the values would be of by a factor of 256.
>=20
> This commit fixes the period / duty_cycle calculations to take the
> extra division by 256 into account.
>=20
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> - Use NSEC_PER_USEC instead of adding a new (non-sensical) NSEC_PER_MHZ d=
efine
> ---
>  drivers/pwm/pwm-crc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--/QKKmeG/X/bPShih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9M23UACgkQ3SOs138+
s6FFYg/+Mtzc1XwV7Zl1w99FCSgZyIrsahQ4SvPhVAXHLByxVW0Sgfi/z9K/bDcB
Fjw3E5MB0XL4UD9DWtdCKefCLe/5kIlbsS/LK7BPplf1GNfctSYQ72L5soS7HKrn
vBjHnIr5ohFn/EGf3RWeLczkUoFVhfbMYFgor/H1FjXo5OeHQ3Fkr2AVPsnyIYXZ
Iuc7iGLT8lI57IoxRlJ7ZKu0IXImzrN7YU4a+pfZ77fBAu3B9D9jom+L+U0E+E6q
Y+ZBnaRVz13j6OSRMtfu13/kATzx1HgJZfjmMiimldrXbucWCovYXK2GWz8RJp5J
YrXCFi8WdHdxB/JxDSYsswynJtRiSmGTjQmvxy6GYXZe8IvSB3VkpaTkQS5bzA65
QAYAclX3dnxT46eQ+yiNH4WEWlgL5gxsLeOMCvFWa5Lismv4q2gvxjBTF0RapKaD
oncskpQfC4HlP1vQieYkUrYQUfAq+Gq2a6OU5qk0HES6N504YLAhS35xqHvWvT+9
QT50ulvZJVyUzZN9HgmMphXKi0jTeJ5dAZjdf8RbzIXD8hBlFJbObnPl6Xk2VRh2
kJSwxDm74OT4sD2IydJQQCBnOtf6MZ/HjfLa5M6UP34DyWKg5LTlUbBDjp5+cJcs
jrZ53SdqyD8MbZ/0meG1wcRvneBbIEKkPtAkowDRt2wkQHEO6nc=
=4Oyz
-----END PGP SIGNATURE-----

--/QKKmeG/X/bPShih--
