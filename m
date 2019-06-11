Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF8343C8F0
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2019 12:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405257AbfFKK2z (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Jun 2019 06:28:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40166 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfFKK2z (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Jun 2019 06:28:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id p11so12392041wre.7;
        Tue, 11 Jun 2019 03:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kRV64qOLk302VnydNwilJeJlw6qAsvjITuOu4JcewOI=;
        b=Owvgti8ev0Q2Svwoc/QM7kP8DGSc2ws8wTrpIcXAUby3lM8o1qN83/uImt673botdy
         VyMq/UO78Gau6FNAqve+9zmvGzP+kuVpnk3vEjnG2phg3fdoD/wQC+iizbOyNxMpX33d
         4P/GF/+Stk3LsnUXjmuR0idSfj8jytar/Wi2JG8X67+NYznWs9W9Sd7/3rYL5NHlcwRY
         2sxmHROdlk2DX8UyoASDZTf2K+pzzSNtp3ZGB7+8CfctOra4GxWTM5sR8GTcfhkjHoSm
         iiCnyra78kjCJ4vfnUYIJA2qfJZLIA/7fQGKqsGBsJg4e6Y5r1J8F1Gzh8g5YAWlIT4q
         o0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kRV64qOLk302VnydNwilJeJlw6qAsvjITuOu4JcewOI=;
        b=BDH+8x57lb5sTrR/OlROqYDMXIO/5Oe7ju2yFjye1aJnEtyepjl1iOzMVvG85LYiYr
         qVxhc12GZdYvIWuxm8SYlt2JfObSDDFq+5P2+oA7mCwwrOzwfABg4mIdVZdInB/jELVM
         n71Tvvr1QNh2VlyTCVR6qMhyrEquTwWQmzUmZCzZGE1634qt6fH2NJ/sm0790srJHk96
         U5g13LGAZ/e4UrhGAKAC8PTXhhFEQnE/XPrMUzuGQVUbVPG3Jpu7B9cganXxKPXkmoHM
         42hXdCGiWOQuNdlXaUg+VeBypqqD+v6AxzV98+c/VdosRPTDulm2iLH+kkIFNq16CNS7
         LISA==
X-Gm-Message-State: APjAAAVDr9awRHakKP8yh93HQIfTX2V0R6mlKBjaEW3JcESVql8NU27k
        m0bJ7IpObH2VY9nEwnIRNFk=
X-Google-Smtp-Source: APXvYqxYQSDvYU9Fh6rHXAZAfFkNW9UpmNYyFibITu3A7Iz68Yf8OmktlYaaG3dH818Rlqt4nABtWQ==
X-Received: by 2002:adf:eb4e:: with SMTP id u14mr2276335wrn.168.1560248933055;
        Tue, 11 Jun 2019 03:28:53 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id z14sm23673644wre.96.2019.06.11.03.28.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 03:28:52 -0700 (PDT)
Date:   Tue, 11 Jun 2019 12:28:51 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 1/2] dt-bindings: pwm-backlight: Add 'max-brightness'
 property
Message-ID: <20190611102851.GA16611@ulmo>
References: <20190610233739.29477-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <20190610233739.29477-1-mka@chromium.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2019 at 04:37:38PM -0700, Matthias Kaehlcke wrote:
> Add an optional 'max-brightness' property, which is used to specify
> the number of brightness levels (max-brightness + 1) when the node
> has no 'brightness-levels' table.
>=20
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  .../devicetree/bindings/leds/backlight/pwm-backlight.txt       | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlig=
ht.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> index 64fa2fbd98c9..98f4ba626054 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> @@ -27,6 +27,9 @@ Optional properties:
>                              resolution pwm duty cycle can be used without
>                              having to list out every possible value in t=
he
>                              brightness-level array.
> +  - max-brightness: Maximum brightness value. Used to specify the number=
 of
> +                    brightness levels (max-brightness + 1) when the node
> +                    has no 'brightness-levels' table.

Back at the time when these bindings were defined we specifically didn't
add this because it was deemed impractical. That is, no real hardware is
actually capable of achieving useful results with a simplified
description like this.

Besides, we already have the num-interpolated-steps property which
should allow you to achieve the same thing:

	brightness-levels =3D <0 255>;
	default-brightness-level =3D <1>;
	num-interpolated-steps =3D <255>;

Though given the original discussion that we had around how backlight
hardware behaves, that doesn't seem like a good choice.

Thierry

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz/gl4ACgkQ3SOs138+
s6GSfxAAwY+qUwKq+54LHTg+9GjvcE4Uq0lDCHIfRvxHcE9LkoP6hO+howgYknDN
8jhc8KUrHT4VgdE3gGokIwPssNaRzeEnGJ82WaIQ0s0PIhD1Vsa0gx81P+fDj4TT
ByA5QlRiF1aaVDQLBlXDhTTjzl0xL/8/Q+gANrZVezWsDUBBCEwofvEQMoj0MJ+g
NH+AdOPsjMZnY4QToqzPnEQ2WU3HrLB45MLKm+fxUdgEkN2h80tvjmXr5jgyBnQ1
/dk8aOxFteV0kyvDJt+ZprHTGFvp43hZ5uvQqTLVZyEiW3pyt4snu1jnv8p9GTEV
C3lP1/U3Xh+y+1CuZ4RCykHYBh1dr1YFrkbtebcAFFFuAI+qtbdPEym7IDOjKHhb
o9XwM7j4EOpLyoaWdOE4IbdPMCsoCyZzNQklw1CfS6F+8Ei6qbFUq2302/RTPcZv
NlgAHTQ0Ngh0rLBW5GaUE/Tb0zb3GksiVAnILi/lk2u+BhFxB8KCK0GgCVHY7I81
iP+DiCXDciGi6r8+WkdFsz0577IntMoOVPqQ2OliC4snRnp6SJ6fJEAT5zAMB3id
uc2LsElo8NT7VtTQzq6WRjtS2Yb+AexuVtpZDnwIWqO5U17Sdc9Li1YdV9s/p4eG
Zbj2CZoWVjHVlv/7Fk4dY/ofFOPPcpgK/Aengy3NmXjIL4DxmcI=
=qSIX
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
