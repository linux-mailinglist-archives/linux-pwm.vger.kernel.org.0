Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67EBB257866
	for <lists+linux-pwm@lfdr.de>; Mon, 31 Aug 2020 13:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgHaL2r (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 Aug 2020 07:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgHaL1e (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 Aug 2020 07:27:34 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82140C0619D3;
        Mon, 31 Aug 2020 04:15:50 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w1so1413809edr.3;
        Mon, 31 Aug 2020 04:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wB2qZKe8kJ4DOSk+iMZuE+HL46/zEWqLBDYicDmejYQ=;
        b=NqltErlr9fRjntqRGNJfCqQ5EzbMfOP6JdW3aSDVaoP6PV1Uzn8d0pmeZcyl268UYE
         MgdN3RwHVkz0L8BhZiwj4WJQWMNatQEY8fLA01vicXaPl5BxH/HlQJVmNV3dEuOhYzf5
         TjAwNR01gf11HnJPX44qxwISgRhgamZ5tq7T2zcKN6OTJhhC4gUrqTgnWXQ/RSUHmMRy
         cZIp179TQsjYMBm78SxHyM9suPwrENrBnc7xirlCjflw0X65Nzk6PBvhl/hLFMgl4urq
         +3ODlAjG5EnFZEKMCg3ObRBFAh6J/9Izma49CKVw747hQIueqHVmdVXaFuIpFkjzknYM
         mPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wB2qZKe8kJ4DOSk+iMZuE+HL46/zEWqLBDYicDmejYQ=;
        b=BOog+KW8R21G7P4K3oPQuhC5Oz9tzp1WD0feHzsd4WrQAUx22f9p8heSSC6sZflFuP
         GhHkOQKdQ/50FgY7+5SX7WFha1paGSJ0oCubD5h8JXFSuIHrdYQv63nk5dYm9lqLPLoB
         HAoPbycfa3cU+k379d+ZBNLXUSt51Y9W6s5UUiBQWbN/fa68AzZ6yvGY7VE8mCBbK3qF
         /UaPA9tFXy+j/r4qNH6KWV4yGls9b1qDOR9UUqtDLGF5c0MFMIxOggiCdk3civQCeoFp
         0vY0K5neyzLkO3zTg032seGPOi0YxET4OB2aSImH2hsajZpXd5Vv1XBF2D0Mm2ZWZMou
         lCXw==
X-Gm-Message-State: AOAM530vS0v+9Q60ZPGHalS8o0NqD6gOCxgWNLOdVMAH3BQLGuXEgNwJ
        iMHx6KR3Wuf63en/3Z+bFJ0=
X-Google-Smtp-Source: ABdhPJy54EuS2k166Uf/hEVlXns0X/peHx00E0yh/sQjntKViO0xu8sUkwn/hHO1sds2siIEFmhmSA==
X-Received: by 2002:a50:ef15:: with SMTP id m21mr759661eds.300.1598872549215;
        Mon, 31 Aug 2020 04:15:49 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id u10sm7436744edo.14.2020.08.31.04.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 04:15:48 -0700 (PDT)
Date:   Mon, 31 Aug 2020 13:15:47 +0200
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
Subject: Re: [PATCH v8 10/17] pwm: crc: Fix period changes not having any
 effect
Message-ID: <20200831111547.GI1688464@ulmo>
References: <20200830125753.230420-1-hdegoede@redhat.com>
 <20200830125753.230420-11-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="svExV93C05KqedWb"
Content-Disposition: inline
In-Reply-To: <20200830125753.230420-11-hdegoede@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--svExV93C05KqedWb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2020 at 02:57:46PM +0200, Hans de Goede wrote:
> The pwm-crc code is using 2 different enable bits:
> 1. bit 7 of the PWM0_CLK_DIV (PWM_OUTPUT_ENABLE)
> 2. bit 0 of the BACKLIGHT_EN register
>=20
> The BACKLIGHT_EN register at address 0x51 really controls a separate
> output-only GPIO which is earmarked to be used as output connected to the
> backlight-enable pin for LCD panels, this GPO is part of the PMIC's
> "Display Panel Control Block." . This pin should probably be moved over
> to a GPIO provider driver (and consumers modified accordingly), but that
> is something for an(other) patch.
>=20
> Enabling / disabling the actual PWM output is controlled by the
> PWM_OUTPUT_ENABLE bit of the PWM0_CLK_DIV register.
>=20
> As the comment in the old code already indicates we must disable the PWM
> before we can change the clock divider. But the crc_pwm_disable() and
> crc_pwm_enable() calls the old code make for this only change the
> BACKLIGHT_EN register; and the value of that register does not matter for
> changing the period / the divider. What does matter is that the
> PWM_OUTPUT_ENABLE bit must be cleared before a new value can be written.
>=20
> This commit modifies crc_pwm_config() to clear PWM_OUTPUT_ENABLE instead
> when changing the period, so that period changes actually work.
>=20
> Note this fix will cause a significant behavior change on some devices
> using the CRC PWM output to drive their backlight. Before the PWM would
> always run with the output frequency configured by the BIOS at boot, now
> the period time specified by the i915 driver will actually be honored.
>=20
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/pwm/pwm-crc.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--svExV93C05KqedWb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9M2+IACgkQ3SOs138+
s6E5KxAApXK34q3C3ieCWdzG1PdQ1k6JHm5UL/g7oRjpm8tKaVsZBkQUaG7zwYuQ
jkG6bBRDtF/X2CLcncU4Dw6UYGzTcmh6byoYAkBggVgVVK789jq60jB87snEW8Wd
DhnT5eO/XWiJmBT02roJYDpo02kmysXPJfP4224Be6aRfxaD0DVCpa4LAKFHYeSk
Pu/u1ydColi8w2mgMb+MKj2bB8QNsaBTrG6N/BI1IwNVsUkerOQ9EjnmVy2f9b2N
0eWgby389QqZ242pVrWs8o6WOe/Ju+2Sq7POWLTBmiab3u2ngxPRRkiUDr2ZI9+l
Auz8Fa8n1aOHRvIggyr/5oXH6UtqmcxIqWLL+D037/zSaWCmZsr09fLA8K+ZHpYg
ymffnKrABbhMZciobvNrfbxQXGZQp2xp1oAqTAv0qrtuILYneL/sqA1vn24eNsK1
j1dDf5oDGrCij0ySeFx0dnKeEPfdRwGGC5fauVUoFwAxGonUFwiAcT1Ad6fOJvNG
+w45vNKkn41+xl4FcpdmrEZRjogheai96ZMJVo/bJMnFawIxG7N9mDLMEH5biU3D
U1YcTHdu5i2MYvALntwgOJ5kgRkjNIwbXRKqXNStimcmPq3I9pfaeFjkyvBiHTbt
FChyPvjlvqBIqizaoy8CEQRPXRZ9eRQWCI90n3ax64irhCtkGdY=
=bb6R
-----END PGP SIGNATURE-----

--svExV93C05KqedWb--
