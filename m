Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC77025BFF9
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Sep 2020 13:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgICLPk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Sep 2020 07:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbgICLLx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Sep 2020 07:11:53 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4F0C061245;
        Thu,  3 Sep 2020 04:00:16 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id i1so2074845edv.2;
        Thu, 03 Sep 2020 04:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yYnEhusLXt+hTyNwij80s+Gh0oRryAwxqx+BI6vUKbE=;
        b=gTvX8FwXfFQlpDzzVsS3ip59h/XuerPrvVdnqrG5HcIi0cwxOp/w/0CGVCLZiXunDa
         Si4JRPhN46mTAW0harbqSN0VL6x4uD/uUbpUahC0z9lIAn9G998blexk8fAo0McVyy2q
         J7iMSvDdzMXtnMx3ZO3cK9AgTQF1qPFxtYxyEcrDlQTimYuw6VSjxjSwIohmVkPS0jZ7
         UWyAoP+0ISccomDzz9ok/mpEuW6NAk5wgeSNurjfk2MLkTUQmFUuWZ4jpfKkfyJs5Ff2
         /oIF3cC7+96yKk25gXRHoMvtIpYK7wy/zEsu2WUrhJqLd1/b5SMEsXneE4qoSShVejDt
         PT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yYnEhusLXt+hTyNwij80s+Gh0oRryAwxqx+BI6vUKbE=;
        b=GtYWgLI9im+Wvk8CDgDMtkfSTSxK5/jt3t4puZnW2jj1lZSayEGz7JYc0EBWBrKhgl
         7idg2cTxv8ZqO7ulPN3NuXmTFNZIp/BMU4hsx7lES7PZ/Sf9JyuEHVAKRr+B7cgXRB7K
         maXhCRUU8wAhe4j1Kjdx4ZLkJ7uk72/fDUcDOXoYQVU19/CSbT706HHgICK4X0ojFsP9
         INWKAC4nX6Rryj5Jzz31CXslRv9owaF3sMmHHh3ztywcnDY4NylmG3D2l4A3zJyHSJP8
         1WsTXijzaTe5cGPeh/HxyB6sHkZzfv0D7wYq4z99NRQyD7ViuLB/dEn00F0IoS5TeU02
         MyZA==
X-Gm-Message-State: AOAM5325OzmjtsD+UyLSoHHA8jw59QcUCHHu5NEztXCEAwg7LQP52aEc
        vcB5XZRfrWxorfJMGwcqS+pauzZto95Osg==
X-Google-Smtp-Source: ABdhPJwwigy71b9GHpZk/fZqbXWJuk42q2qwbW6hq0JrDrtGYE2aQTX2CZ9GJMutQVQv23fU0NgwLg==
X-Received: by 2002:aa7:d417:: with SMTP id z23mr2362298edq.62.1599130815291;
        Thu, 03 Sep 2020 04:00:15 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id c8sm2877359ejp.30.2020.09.03.04.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 04:00:14 -0700 (PDT)
Date:   Thu, 3 Sep 2020 13:00:12 +0200
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
Subject: Re: [PATCH v9 07/17] pwm: lpss: Remove suspend/resume handlers
Message-ID: <20200903110012.GB3756465@ulmo>
References: <20200903105114.9969-1-hdegoede@redhat.com>
 <20200903105114.9969-8-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
In-Reply-To: <20200903105114.9969-8-hdegoede@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2020 at 12:51:04PM +0200, Hans de Goede wrote:
> PWM controller drivers should not restore the PWM state on resume. The
> convention is that PWM consumers do this by calling pwm_apply_state(),
> so that it can be done at the exact moment when the consumer needs
> the state to be stored, avoiding e.g. backlight flickering.
>=20
> The only in kernel consumers of the pwm-lpss code, the i915 driver
> and the pwm-class sysfs interface code both correctly restore the
> state on resume, so there is no need to do this in the pwm-lpss code.
>=20
> More-over the removed resume handler is buggy, since it blindly
> restores the ctrl-register contents without setting the update
> bit, which is necessary to get the controller to actually use/apply
> the restored base-unit and on-time-div values.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/pwm/pwm-lpss-platform.c |  1 -
>  drivers/pwm/pwm-lpss.c          | 24 ------------------------
>  drivers/pwm/pwm-lpss.h          |  3 ---
>  3 files changed, 28 deletions(-)

Nice!

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9QzLwACgkQ3SOs138+
s6HB4w/7BWTWBa37E/k/JCj9g8/G5zhz6bPtbVQvfjK9uo2SR3Cw9i8ICbGP4kBz
Hws/izNzkiZT1xylqpMH29fNoLekSTTmA8xxMMwGwbxlqEWdGXgOzKR5cgJ25rCb
VmEvNxXpITvKR7PeHDrUspOtpZl3CscbScJDA2vxE7W0SeTF2iO19fgF8B//u/tu
DUQ7aEiORHBGwnIMefulW3bYO2yq8iFG18Iq+vVnPIcak/YqYxKlDaDs+5jY/Oqa
Jqh250h+36HM0cSYvSMxIqDV1pP6HarcgRavj5daC1V/ymQqZFfmmiq+XVplJSxO
+CPyioI2QcaRX2iQtOUFd5aAQSaj3E7sKCsv9APE2TqSushpoufrkwnKi1/1lIll
YMzlXmVRivUg94dYeKWASJ5D9wWzCz5H67aBtu5V21oNcZc3L7Y1Xuztyxhp9ESH
TDEIiFxqDyritfY+jqC4XXJiwtQYrI16310kEwi2wFA3PB4x2tRmWAi6BQuU5+tU
y7hCBcSZZaOxbVlKG2dHsUawLT4pJ35G73YjsPzsJJLFfHN504aVSLIbZEogNt3r
jq466Qm87cD0M6eqT8b338dmUffjZn+bJtp6b0i9FRny+i0Yy3z4KfaT7kh0EP79
OsdzaUeoPDhyFupUt5Rai5wmOflTsqOupN4bA4OEKDwD8XM35f8=
=hZTz
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
