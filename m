Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5BF362181
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Apr 2021 15:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbhDPNy5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Apr 2021 09:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbhDPNy5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 16 Apr 2021 09:54:57 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC00C061574;
        Fri, 16 Apr 2021 06:54:31 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id r9so42270665ejj.3;
        Fri, 16 Apr 2021 06:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KDk3amLs0Zl+rRoVpfXZhI0atBu/zQbhsj1RfUtselA=;
        b=lKlNd6BbkPwTyNkHOTZRnX0iDbb2TgVGLzu55+YftgoNzLJSSJGaYPoyg8E0dZ8xR0
         rYsnThJY3dl2H62jYsA+2E8//nx/yafkJUec1BohIIwhEhuONmNkTCM8VD/JrLX6FX7q
         tYD1tvwGKkV3CNzzNRWTsDtMya7adSbsx7eI4S56Wfc9WVkdiUtdUHcE3+FEIwNl8xuv
         MRUsygSswlXwxmDVno4FB3/rLGn3tKlibgZX6LL57aLX3WQYnwv6pV3tNgdNdAGj3gBl
         bwsvPdcQNwUA201LiM7ulpeb40D8T6eryJeZ7b0GMx4/Gz0V2HwOHNT4PQPAWFfZ66jQ
         7jJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KDk3amLs0Zl+rRoVpfXZhI0atBu/zQbhsj1RfUtselA=;
        b=OHtwKcuFxjPYgdsfI9SYQ6E5HQ39N8KYmurVWijflqUmWSgYScoW+r2fgBPW2KpDCs
         2R685b5hieSEPvMrzRZ8MBRNNqA3jIWKY5e9ORHVIye9tvG4HFVzzxUp/ABDLfPTfmnt
         XOYMtsJnRe4b/TuNDXY2Yo+LvZ7QmFmTZS8VgQkdlLT08N0iu5zuS5iKU3H52zd3LtnH
         wgdzCaFYhSb4VWTKxXYJRMLbF859OAsGeod93VxS9JngTPl4Win446TASp0sGT4aPkoJ
         Ch8P1oJryRMnY4GqqsaM6UOpSgTBKVW2WZY+B7pxyA4x5ze8b4/3+2En0JAnehacDIBD
         456A==
X-Gm-Message-State: AOAM532waVK6MveGk5xadzCwjXSFV9NvFoc/stidq6kv/fCMnL8JwGzf
        5nGoyNVbX/CiD8Ou0WVyNNQ=
X-Google-Smtp-Source: ABdhPJxsoAA0G4Bt4HknjHiIPZuQRBEjgsZO5sOBy03fib7O8u7qlp7wFovDtI2HB59oKaG/6ZikAA==
X-Received: by 2002:a17:906:85cb:: with SMTP id i11mr8075474ejy.311.1618581269965;
        Fri, 16 Apr 2021 06:54:29 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id c12sm5968623edx.54.2021.04.16.06.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 06:54:28 -0700 (PDT)
Date:   Fri, 16 Apr 2021 15:55:11 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-pwm@vger.kernel.org, Sven Van Asbroeck <TheSven73@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/8] dt-bindings: pwm: Support new PWM_USAGE_POWER flag
Message-ID: <YHmXPyf+XjgJs3C8@orome.fritz.box>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
 <20210412132745.76609-4-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XbFHZBPVqfivajiW"
Content-Disposition: inline
In-Reply-To: <20210412132745.76609-4-clemens.gruber@pqgruber.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--XbFHZBPVqfivajiW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 12, 2021 at 03:27:41PM +0200, Clemens Gruber wrote:
> Add the flag and corresponding documentation for PWM_USAGE_POWER.
>=20
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm.txt | 3 +++
>  include/dt-bindings/pwm/pwm.h                 | 1 +
>  2 files changed, 4 insertions(+)

Rob, what are your thoughts on this? I've been thinking about this some
more and I'm having second thoughts about putting this into device tree
because it doesn't actually describe a property of the PWM hardware but
rather a use-case specific hint. It's a bit of a gray area because this
is just part of the PWM specifier which already has use-case specific
"configuration", such as the period and the polarity.

Perhaps a better place for this is within the PWM API? We could add the
same information into struct pwm_state and then consumers that don't
care about specifics of the signal (such as pwm-backlight) can set that
flag when they request a state to be applied.

Thierry

--XbFHZBPVqfivajiW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmB5lzwACgkQ3SOs138+
s6EIRBAAopZq0WA+PGKaCMBdc3iqIKquJL4ZtHYLNy7PIFmUgxNw2bn/B3IRihS1
WKd0Tvt9OYiP9vMhVKdUUm2W0How6aUWgACYAfj1O8LZU5Xa44ENeXSCkACBN6mW
A+ff1QrfNZqxE9BtFPChjTKsm2ty+2ybzT9Z5RcwcmWoZn2/rioZGsx79QzuO02Y
D1fk3L7jkPa7sZsqwkJOdBgSb31hgMzPSOxm3VZaJoxIxr+uIEqJVHNG5vpw/cY0
EStGp0wZc5uROb/zFFlHTi5JuAV+Mxrk/2A6vUU+IL6OwFQ3o1toTQToIW+oK1Ul
1gh/Ts3lFj3O6ALj/8n7pW6eN6JAnE0ZZo75ccWHmaNmzypPNiePA0Vit1WDklZM
KtdIHdCTC0i55R90wFQNPZBhYIfk72hNUJGWjHQV5AwmjwmsXGPLY6q0qvl11kzy
kzDg7CSF2E1BuIb4VGAg+fdJzsoaVQa4pbNT1TYB94eQvPZXUvJ7urNBOntKWH6T
IpDp/DJd5btx+qsXLFKF3fqyEwYlpfQkZlCqhEBM8Qivwa7pMrCLp8YpsDBXGwPK
36GJAzwDQRRx2Efgugk898nZ60dCllaJyt+rMs8HpCkkb6P8OsRuXrrgEcOVLtzl
MkQ1FhpXZOjiIcCh1tqcfjv/7KXCbkam1O2i7d1JSpiHbAzL/Cc=
=GQic
-----END PGP SIGNATURE-----

--XbFHZBPVqfivajiW--
