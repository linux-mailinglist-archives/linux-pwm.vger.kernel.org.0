Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CE5257837
	for <lists+linux-pwm@lfdr.de>; Mon, 31 Aug 2020 13:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgHaLW5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 Aug 2020 07:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgHaLEl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 Aug 2020 07:04:41 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D23EC061236;
        Mon, 31 Aug 2020 04:03:14 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id e23so2407522eja.3;
        Mon, 31 Aug 2020 04:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qiWf16bEkbIxIbt47pSSmSFJYYSoidLtqGuD+HmFqX4=;
        b=jUoOJFwVgB8HUTapnyBOZFJbVgSUKZl/UWcPBcV1FrIZoZgHZYSDZhloU9z81Z0Asg
         cN9MM2pOooJevU6dOAa2CrWeHvZ6FpaJls5JSUwJF1fMRQRMXfw3E4nXATmnGj0u13e3
         sdjq515ETDQ7C+Sxpnd3Z9hsHJAmb/itrTm44c2k6vKWhaO/yrsKNYVreaNOFUHdg3GW
         HBeTuXAFOLbuzOSYM79c2xlWkWLj88FQ2lmRliS4kQe1kbMTLxkYn16BBwhmb+CKIWo9
         4ZMJTKQuOFyunHlXoTLeutzDeMCNq9YWOTe0RowQwtl0+9iiEtI4C7DYIgBvUQkEn1b3
         Q0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qiWf16bEkbIxIbt47pSSmSFJYYSoidLtqGuD+HmFqX4=;
        b=hlmDW3FpUGqUhc0KoY43fQLSRmdcxGc/C8UiDczubBCDWkn9BT6hZBS2r+jkr4lmRT
         MEKKgVIM1RU0wu3nDqwZUEkndL7BPUhvjalL5UARKl7lik1jsd7f7Whkg3vZVDqErsKM
         870aDeZ5NTAjOD2C1bIW7qIWXnGAE/LOH8AxWuWpKPqTdM8+NPFR5QIo83HN9Tsl5q1/
         j7xlSeU6WMgbSbD8hYvITgfCuCRwd+3QSxcSdma8G0g6uFN6TPhX5RrZ/UY6x+bER0rw
         XZClhMRrJ0jfXtFVupiYlAJ87K6OE8gHKKX/mYu7WFLuIpZLuBkZxKrvK7aMuug37hmP
         uCIA==
X-Gm-Message-State: AOAM530e4tIsqIwZoSwM9o/TSvzNwcytl7UbjikwmLfpOpxksoHP1pIA
        v6l14f0Cje0YnkuaBAi5q3Y=
X-Google-Smtp-Source: ABdhPJxpalZvGztc9OM/9Nrw8ULCaRGBBhIMcbzO/TmzeKrer6F4s8xg0IzOsJgoiV2F1GmjjYtweg==
X-Received: by 2002:a17:906:12c7:: with SMTP id l7mr594853ejb.306.1598871793227;
        Mon, 31 Aug 2020 04:03:13 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id w6sm8002543ejy.63.2020.08.31.04.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 04:03:11 -0700 (PDT)
Date:   Mon, 31 Aug 2020 13:03:10 +0200
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
Subject: Re: [PATCH v8 05/17] pwm: lpss: Add pwm_lpss_prepare_enable() helper
Message-ID: <20200831110310.GC1688464@ulmo>
References: <20200830125753.230420-1-hdegoede@redhat.com>
 <20200830125753.230420-6-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Content-Disposition: inline
In-Reply-To: <20200830125753.230420-6-hdegoede@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2020 at 02:57:41PM +0200, Hans de Goede wrote:
> In the not-enabled -> enabled path pwm_lpss_apply() needs to get a
> runtime-pm reference; and then on any errors it needs to release it
> again.
>=20
> This leads to somewhat hard to read code. This commit introduces a new
> pwm_lpss_prepare_enable() helper and moves all the steps necessary for
> the not-enabled -> enabled transition there, so that we can error check
> the entire transition in a single place and only have one pm_runtime_put()
> on failure call site.
>=20
> While working on this I noticed that the enabled -> enabled (update
> settings) path was quite similar, so I've added an enable parameter to
> the new pwm_lpss_prepare_enable() helper, which allows using it in that
> path too.
>=20
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/pwm/pwm-lpss.c | 45 ++++++++++++++++++++++++------------------
>  1 file changed, 26 insertions(+), 19 deletions(-)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9M2O4ACgkQ3SOs138+
s6FcaBAAmahm7vjnpEjic+s1cnpr0uL01wcrb3qNbQNL6mIidS0z9E6STXPkY5f0
qLpKaWjYR4iNTxu/Ygu4HhQY7z2ApkY/2L70fidb8uhac0o06DBmXXBgH5fkOq0r
kjZ206Chh7gBwiD1BtW/Uvt1nK4VtBAWuxybt78oOGV2B5a35TW/PNdY0VGiP6KS
kS7oPJctfvzevNcsyXNt2uiKfOWtDIgU/eLLLO0X/U3h90jDYghljDIUEA4dlG8/
3RghmPV2pP5QuzfSXn7FCRZbbT9ZdrTCj9ZUcPIlrIIOQZEkaWsUOlkgmYewWPXq
BcIlRqidHLQIlkJiodPo/A0MEncupBKnNh3zszR1XNquCBaRw05O3Z+y0KjKmXOT
k2CerltsPRBVwEFLeaWuRlERlJCc3DY1bwD1NG9SbDmPlK4Y2pdIiz0llUNpe9gF
PnMnbCxBoA0QmK6mJvbQJT3HZsIodDBqCzFyd2Smj5uA8fDRkYWrLCRnHIiGTvj4
uqp0ysjaR54ZTMbbJ+swkgYOuP/TaHfHE3y7eIOZSPnePe+zC0k/LXQ/5QqF8MHm
rKPHAYK+dKjiF7j/uCz+rUIkF63z6FSHjxRkPxVhfJSWicURqTKPI4sOweSqazr6
lB4xqswBFHfWUJqRb+xqb/EXJPvWGMoE1sTqqKu/n0rWZk0p2AA=
=xuNM
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--
