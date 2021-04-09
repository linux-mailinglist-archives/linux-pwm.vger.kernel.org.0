Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB236359D83
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 13:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhDILen (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 07:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhDILem (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 07:34:42 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B89C061760;
        Fri,  9 Apr 2021 04:34:28 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a7so8157616eju.1;
        Fri, 09 Apr 2021 04:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+Q886mZ2vXSyhmThgRJ+WL6oAKy+j0t94LnbGDcq84M=;
        b=Om7SbyF0RORPhAISt8g+pm9UT+SGnShgZU5KSXR64dBDSeOGAq8oC36WuybyDiJnqn
         fFYp6Jtq3raPAQlz5LNBJUuiPN1u1KAUsH/Re4TYxDf/jONrR1DBS9bmO53yPmLt0kfY
         aOB1DlHNUa7XjTxLQby1AtjjxBPr/iEQrxE11k1P59bJ4EgeHfRXZuKUSIQW9g2coiyP
         KVE+T4sw3wC/Gu7xTE9lVzwpnQ+6Jjl2oEUNee/vblLt+IhzHMEolabF9/67wYdgH4q2
         tvortzGiOY94S8V6uxm20KZ12FGMic6UUK/w5lubfW+UglNAQBlmTLcJGVxy0YFIgxdM
         w3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Q886mZ2vXSyhmThgRJ+WL6oAKy+j0t94LnbGDcq84M=;
        b=dy+dDxXvrI11koUsIoAnGcllOXojufUZgUDJLXK6ul6D9xpw51kxhWL7EbI5gxgqNe
         L5W29c5L66rvblX5dBWPVoLc0EiB3ESNkyF/VbE6DiTSe7TNmwzkksWeIvZ23sxIkCkQ
         ZjFpqEEy07tztw5jcskdaBh4LYLmUi0Trd+axrHKTP2yb7UGgoDtGauK/q+yZ+xl+9Or
         tlKHANjQqOn61G61XLGN2HIoO5+K7CMdEoX2WW33v/JvELiyIy4FLBYkdgC/z++e8X/y
         2TZfL0TreJmuVk260BCYPlKvBvm0+F8cPR6jVU8BpT9OveY8jMgv3xxfQrT4n7pu1vx7
         JNWQ==
X-Gm-Message-State: AOAM531IfPF+fRVJAsutDqEbvvF7gj889ocoUvtKEIDUif3MmACPj8wT
        lN97n+cL2WBVTRIWVnQ0BAA=
X-Google-Smtp-Source: ABdhPJwZ6Oe30yZu3zEj/JtNc2Ad2xSY+eU7nCcXOchFrm1HtcMVYc8zuAq9uiayJh+K3c2kSEV+zA==
X-Received: by 2002:a17:906:e0b:: with SMTP id l11mr16124299eji.111.1617968067533;
        Fri, 09 Apr 2021 04:34:27 -0700 (PDT)
Received: from localhost (pd9e51abe.dip0.t-ipconnect.de. [217.229.26.190])
        by smtp.gmail.com with ESMTPSA id w1sm1314382edt.89.2021.04.09.04.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 04:34:26 -0700 (PDT)
Date:   Fri, 9 Apr 2021 13:35:02 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        arnd@arndb.de, kernel test robot <lkp@intel.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: raspberrypi-poe: Fix mailbox message initialization
Message-ID: <YHA75lbdVaAujbT6@orome.fritz.box>
References: <20210409090819.24805-1-nsaenz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jMduNBvg3zDQVoBy"
Content-Disposition: inline
In-Reply-To: <20210409090819.24805-1-nsaenz@kernel.org>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jMduNBvg3zDQVoBy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 09, 2021 at 11:08:19AM +0200, Nicolas Saenz Julienne wrote:
> For testing purposes this driver might be built on big-endian
> architectures. So make sure we take that into account when populating
> structures that are to be passed to RPi4's mailbox.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 79caa362eab6 ("pwm: Add Raspberry Pi Firmware based PWM bus")
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
> ---
>=20
> @arndb: This was just meged into the arm-soc tree some days ago. Should I
> prepare a second PR once it's been reviewed?
>=20
>  drivers/pwm/pwm-raspberrypi-poe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--jMduNBvg3zDQVoBy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBwO+YACgkQ3SOs138+
s6HZlhAAgYtwqWAQAbpzMxsYadZoEZz7Wg7Nd0kBPrJqiY3phVtUGZ0Gz4Z4BSJF
rMu6VhiRkLoEPhy/L+yjReL8I7OT5CR28s4QPhe7Wm4zWtc6GHFgMzfqYf2QXnIG
5Cqutci9ckZUBUT0hOFdvLEDyiv60cgzVcGfwrpkwUu5ov6HeUIExr6uN6naTn0A
iylysaYdQlzCCe0NqUt97NwhgD+o5lJ/WKNM+Dpvrm3GT1HgZr3c6NiE+buuxGR+
TQJ3cQ3ajG2smYUnVlfpuRznucX3yjDhLZVib4+lNEzmblWtkSt+IE11RSukszWu
l5wfVbXXGa8wDDNrSka+YM9K/LT/F70n0gFNpKKhLZ1p/vYAdiD+SocLOLYtekyG
Trr965zh4T9hPgC1etj0VKglF+NbW+eqoHRpXQFnLwaEBdDVvdguZEL8RynRDbGG
xzRHdQoy1+ILL0jYgNUdRe7hWJ7LZtaSSFA3AOxZC9SSFfEaWEGskklB7BCmxhfZ
+rQZp0eOIdbnQIDcaxkSecr4o4j0UblZJwip4OlBGH/9Nz0XGVdx+eI9r0SGBTmf
0f7qJqmDUcyaCiL3CgsiJZzUMQerSFsy3v23g/5ko6Vo+J+j+BG4m7lO/8NQBzDp
2b6SksLh6eStvxFZ1NkJ8auGblHgL7xj72IAsC9lMNUQB+M/7Q0=
=YX3Q
-----END PGP SIGNATURE-----

--jMduNBvg3zDQVoBy--
