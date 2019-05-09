Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9E318C5C
	for <lists+linux-pwm@lfdr.de>; Thu,  9 May 2019 16:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfEIOwq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 May 2019 10:52:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55566 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfEIOwq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 May 2019 10:52:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id y2so3614100wmi.5;
        Thu, 09 May 2019 07:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a1mSEvBcWliyo5EhRJMQRVCOMthYdHYHBHHuPNvU0UM=;
        b=M+FN6B2MBKrB5K/MgMp3XiZNG9lhFHskRCTbyo1lnz1UAF+MtV1rCwKd3IToZ7cDCi
         m7PjLF6yq03pWdrfNCH4LX7l4qajtgiwGCMG8y//ebtsMFdHa6fnCjSHuPv+XUbADhoq
         VxiEnfykY/466xARZrXlh9gPjPprdd0SanmtndoJlAkd8A6JsCBTjla8dEXb+9gO1Nw+
         C/lDlI1LF0Mp4Adm9rv4O2h9XbdX5t3W4c3/sscyBUFDepwtbriOdCaPFTx2Rx28oqUZ
         8gS9YGUKz5pn2AZo4s3fHOisxtM/53DmP/1g0jGEJDcKppw+zDSr7eKnHreaXzeU1TIV
         LS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a1mSEvBcWliyo5EhRJMQRVCOMthYdHYHBHHuPNvU0UM=;
        b=UkqkS45BUv2QVuIiU0Qu3PUyihxXbNtLC3ZHgNtjk/b30jAC4CBwJMkxhoowy7XTFy
         YaJwRSYEQRE1n0u2ndwpTCJrhiyrAlz3Gh6JMeSK7e34ThZL4QszWKqdrWDOtlkaWo0w
         INd/q85pfb3jiGNY7Jl/9jpK1hsELgAXchxQeFFs6zGNRa/u6Jnf7G8r7GycLLxLcUUD
         g+7VQpw3Rd+rmV6nzdhecOZOqZwwmiMxtEQEdlhY8Tss25djO0BdktB0OaQlt9WSm6T7
         ru7LSWLnZll+3CtgN6aPsilJSE6t0TLzlAFq5FXl9hTARJY9YFGsL6wXVnYOlmNbv+Kb
         k7tg==
X-Gm-Message-State: APjAAAU+ALBedewPkGaBIXCRmayJopHgNEyE7Oc+MDjFb2teDLKmIqTw
        xaBNPIEwRl3pttuzf8ONSR1yC3jX+Ng=
X-Google-Smtp-Source: APXvYqyp7HHKcshcQDFEs9klXPopVR55hJEby0tFHAI5KP3xTanR05+4OdehHVqjKJoqQl3kNr0Q2A==
X-Received: by 2002:a1c:f70c:: with SMTP id v12mr3207118wmh.86.1557413564456;
        Thu, 09 May 2019 07:52:44 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id q2sm3249998wrd.48.2019.05.09.07.52.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 07:52:43 -0700 (PDT)
Date:   Thu, 9 May 2019 16:52:42 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH v2 1/1] pwm: meson: use the spin-lock only to protect
 register modifications
Message-ID: <20190509145242.GZ8907@ulmo>
References: <20190401175748.5376-1-martin.blumenstingl@googlemail.com>
 <20190401175748.5376-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LvlcLv3JjFtLV6y2"
Content-Disposition: inline
In-Reply-To: <20190401175748.5376-2-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--LvlcLv3JjFtLV6y2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 07:57:48PM +0200, Martin Blumenstingl wrote:
> Holding the spin-lock for all of the code in meson_pwm_apply() can
> result in a "BUG: scheduling while atomic". This can happen because
> clk_get_rate() (which is called from meson_pwm_calc()) may sleep.
> Only hold the spin-lock when modifying registers to solve this.
>=20
> The reason why we need a spin-lock in the driver is because the
> REG_MISC_AB register is shared between the two channels provided by one
> PWM controller. The only functions where REG_MISC_AB is modified are
> meson_pwm_enable() and meson_pwm_disable() so the register reads/writes
> in there need to be protected by the spin-lock.
>=20
> The original code also used the spin-lock to protect the values in
> struct meson_pwm_channel. This could be necessary if two consumers can
> use the same PWM channel. However, PWM core doesn't allow this so we
> don't need to protect the values in struct meson_pwm_channel with a
> lock.
>=20
> Fixes: 211ed630753d2f ("pwm: Add support for Meson PWM Controller")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-meson.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)

Applied, thanks.

Thierry

--LvlcLv3JjFtLV6y2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUPrkACgkQ3SOs138+
s6EbQQ//cCrVsIOMfus+LS3hL9db6Yhpor2moT9YI9tTtoyGZjgbCupOilKeMqDu
jj5vflVwl/AWtW6okavjVj+xaUaUxNxHxm9Nx2yWwDo4fmhZ5BcRhg0O4bfo55eY
ED1NvERiM9P5TCCsnakPJxc/VVUt9voqU0C7TR6CzxlucTUAn84GtQNhdyMKJV4Y
3XHr2fYynP3UJbv/WXXSoIO4VPNOHO9/c/FkdPN+51lbum1pxeUXOB4OIqEzSwCh
Y175JhoOMqt7nKy5AnWWm20IpgEOA7MT4/gZDOkeyVni2FzGeHFeA3w41fwdQnl6
aM7mClWdYGY5WqDLpe+8GOhTD+LeNxlLsSPoo6H5M+YahDDULYoX2f0QT2U1UiX7
MFMTjDy2gNWfPdO1y+ynScbFVW6VCuczmOelwMdQdWEf5U7kYxED7zNHDJGmemE8
tQ0vuLZEDPqctCwACswaDYagHgDBFPD575sqJmf5FvA7aMedjFlNNamfK5t1rB/s
lrgYobMqhatckbeeMUVBVipxtL6N6MYbfM8pFO1GULGnC5u9q8plRGsB+X0na0in
gk9+9DAYpQgrkXRsKG0McHbvEWGckogX3FbckxivAj0wRnQwSM/cgswcHGwJs3GR
ZfJBEEqf8UAEQSQPu+gpHm5py7KWRO/taKr98J4unhGfNzh9mow=
=HHny
-----END PGP SIGNATURE-----

--LvlcLv3JjFtLV6y2--
