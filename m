Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F8825783A
	for <lists+linux-pwm@lfdr.de>; Mon, 31 Aug 2020 13:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgHaLXa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 Aug 2020 07:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbgHaLV1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 Aug 2020 07:21:27 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55864C08EAD3;
        Mon, 31 Aug 2020 04:17:36 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p9so2225263ejf.6;
        Mon, 31 Aug 2020 04:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DSSVd8p6/dHeCEBoP4aiz1EfuW8J6OaQI2DYqDCSq5c=;
        b=KJVm8zv0+8kriTrjuETpgAnoY27wt07gGtULILLJX7MCS1Ed9W2T0Ba2cihQ4octqu
         mU5WlmkWuDiXycn+pLJ8pLmvsTyGCWRBNIxFljC8ZR9Bi7ssUcOeG6hHyPNxz3SXdwpY
         dbRd8bjqzcz/bMXTHBaqyQ8TK+T5ELY10qGCvLMJmQvKgb28O4e+NAlnRZY//ZdcwxPs
         rWalvhMFcitabEYR0o+JjzWOvhKzEp3f81GnSsCjMuiHb+srpv7+jt0a9aqOeUJfSz41
         +cFGIcAU9msGESVS1wuCLb72WisiJ0Q9L9t6BmeFOPSNrqTYvh9cuQl/LG4BoLko4/tU
         UmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DSSVd8p6/dHeCEBoP4aiz1EfuW8J6OaQI2DYqDCSq5c=;
        b=I+2O6fl/COooaNKjP56NbkG/WMlwzQ0CL6hPQxkn+7VNvxOboDNT5AOtF7u33IdGm8
         0F36RA3LpSdJoZSR/vsCeU+z8xOiHx3PHsex++p5jxngEYdlTkog9Tn2XXd7gD49+IPB
         M+oKVpIvrUR7PRhcdL6Zu0aWdiSREg7OMJSxpzd5ox8O4rwRoI3xuMEl31/nMdY9jHAk
         F+Y+OEJTkW7Vlf2Goib4BMLrW3H3+AXq+oywDvTTdA7P33t9xz1fjB34EKDhFm8dWo5Z
         ZHMtuuC9Xo6CrAABbXjHZzvv5Hh8l1zcOvI4IreHDhYQ2noWl7CwQ4yzusxIwknTgZvx
         Obog==
X-Gm-Message-State: AOAM531L6c/CEm728xP1wRLFRe+VBM++5InXZkms4uX9Fjv7J/yHyVao
        8vOIU1RDI4QVQR3BFiwmCPA=
X-Google-Smtp-Source: ABdhPJyQ5vu+8Qs6gYtaLvyhMSoJ9W6H5b5/CY8OKCToCH0O2wKCDeXkfoJz2rWxd0eEG9p8UH/bkA==
X-Received: by 2002:a17:906:5246:: with SMTP id y6mr656291ejm.316.1598872655608;
        Mon, 31 Aug 2020 04:17:35 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id m12sm7211555eda.51.2020.08.31.04.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 04:17:34 -0700 (PDT)
Date:   Mon, 31 Aug 2020 13:17:33 +0200
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
Subject: Re: [PATCH v8 12/17] pwm: crc: Implement apply() method to support
 the new atomic PWM API
Message-ID: <20200831111733.GK1688464@ulmo>
References: <20200830125753.230420-1-hdegoede@redhat.com>
 <20200830125753.230420-13-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2feizKym29CxAecD"
Content-Disposition: inline
In-Reply-To: <20200830125753.230420-13-hdegoede@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--2feizKym29CxAecD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2020 at 02:57:48PM +0200, Hans de Goede wrote:
> Replace the enable, disable and config pwm_ops with an apply op,
> to support the new atomic PWM API.
>=20
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v6:
> - Rebase on 5.9-rc1
> - Use do_div when calculating level because pwm_state.period and .duty_cy=
cle are now u64
>=20
> Changes in v3:
> - Keep crc_pwm_calc_clk_div() helper to avoid needless churn
> ---
>  drivers/pwm/pwm-crc.c | 89 ++++++++++++++++++++++++++-----------------
>  1 file changed, 54 insertions(+), 35 deletions(-)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--2feizKym29CxAecD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9M3E0ACgkQ3SOs138+
s6FjbBAAtshiQemFYzlF29cpAiz3Y8sEV7441JLRKFgwbpreSRChITG83WrA/Wbp
Ica8diIGjrL07RYcAnm6T+pLsXI2Ep0GyJ0QxQyk08KKXDIZQOaaW90F6P0iu1nK
drHNm3bbHrAUM0Mjw+H8FQHqggFUr04ugC8y8b44fdUSdg2nwRtUbiKtSreGQWsu
Jg/Zukj7QNod54XzQGtR6RVxlt/99B6g69zGhiwDVwNbuIuFs+SBiaTa7zhQWUdh
qRjbbnLnUYELBa6Dn3oDXDCNUDFTG1zHNwJUVNoDmD4TMPBId6hStZkWVVSpRpZZ
XZiiiv9K6JD9a94XwkQbHvf+oaL3xxazt2roDaLNtyHoIxuaMiMgkMFqk7VJLxil
Jln+1PuEZF7IIqiKsoNTmFZ8bFAJWErv9grdDMNVqMRL8ThcS6vRN4j28oHn+GWA
AlhzxP4kiIQ6Fgz9aUwJNqhbFQdInriBLQ5PIWFJONM4U0uPrfi3mwOARoGNFFFE
SifX93MB7CdAZJCDKz1aQX4MvEUL9SDzcOGSpPGtZZHeCu+F3daJs2rNHK2wSeg9
CMYULqOBSyQhzjbIqfocinzZNUNkW6h/YRazDuXU/tgnByCV/nYZFfMqPSN+aYSD
vnDB5WvyzCI8xwGr0/8OjE8+e+LivnIMSIu/E77H+pBaLnJN2oE=
=VWBE
-----END PGP SIGNATURE-----

--2feizKym29CxAecD--
