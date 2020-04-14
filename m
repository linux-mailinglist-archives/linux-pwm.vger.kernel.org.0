Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28631A7F3D
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2020 16:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389204AbgDNOKQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Apr 2020 10:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389201AbgDNOKO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Apr 2020 10:10:14 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB1EC061A0C
        for <linux-pwm@vger.kernel.org>; Tue, 14 Apr 2020 07:10:14 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k1so7264722wrx.4
        for <linux-pwm@vger.kernel.org>; Tue, 14 Apr 2020 07:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DZdXyroSeiVaAxe3IAS67vO3tIcLGaIAwlq/aeAVLbU=;
        b=htS5CFyzu/jZZPkA00PkpwVKELX5oEUiRcVEFTTdDVfNhjzPDnc1mRVmsQCVWaRsbC
         WDukAkJ8U86icP/24QqVKJKC06SSt8EDTFIyTOr6+Oj7jLmLkW5Cpg92EaXm8mffiUHH
         XY3uX3IJNrriazk4FLX0glpGozkvRYs0lrDYKn0FgZPt9owHsqsPRgIH8ircQcJ8IXXi
         shRAvwYQczEJsKrdYJdreKLXHx42ldz7mGGPF+NhmE8O/exZBbUOOcW/pxJxEysIt/S3
         Jr6gABWc3XfXM9uwQel4s9fChDd9yxwS7ZLxcBM3WZV9qoqtmGWGGYOcN41lY+GUryES
         WURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DZdXyroSeiVaAxe3IAS67vO3tIcLGaIAwlq/aeAVLbU=;
        b=aibH1BlLOsqVNALbCoJOX/Nd0tuoRILQfXRmQlrsm0c7R2ruH3Y8YJnGssBUyGobkD
         j5YSZBdvhoJtKaanzmESt7hkf5fcJ6k7wHdJuw3gnittjbZm5V4GKgIQXZrvruHwwkzS
         5baonZfWUDZx1jZ/2uklytInZZe7lMPSkUoIUv+2BfC/u5fMW/1IUr9jBG9YyDs3B7cL
         NbAydX9BcrgBljHKgFESQmf5I/nGHWTBd9VXtZXh7WWpMVdVUJuOlmgCJZvxy9DPnkmS
         uYHX4sOpxouWIBeC1bk109wUSuQuMPHXkO+I1q3GebBZyepO9/DHdolGHfaICNin4RdJ
         HFIQ==
X-Gm-Message-State: AGi0PuYhI7635QHv+9o0m5MSlzdtLBzKpcgJ7nip98kRCoKqnkLqDqfs
        zbACjMKgViHKp585GIk2Yzwkbnaa
X-Google-Smtp-Source: APiQypKx0FPuNcHU4ld63LJrh+D7OKsR1GU04hYLvyChOlJknbyw5Rgry/Q/2ZhZJPLKLRcOVgx9mQ==
X-Received: by 2002:a5d:5150:: with SMTP id u16mr1397520wrt.371.1586873413003;
        Tue, 14 Apr 2020 07:10:13 -0700 (PDT)
Received: from localhost (pD9E51D62.dip0.t-ipconnect.de. [217.229.29.98])
        by smtp.gmail.com with ESMTPSA id l5sm19618046wrm.66.2020.04.14.07.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 07:10:11 -0700 (PDT)
Date:   Tue, 14 Apr 2020 16:10:10 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Subject: Re: [RESEND v5] pwm: Add support for Azoteq IQS620A PWM generator
Message-ID: <20200414141010.GD3593749@ulmo>
References: <1586744116-14157-1-git-send-email-jeff@labundy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="W5WqUoFLvi1M7tJE"
Content-Disposition: inline
In-Reply-To: <1586744116-14157-1-git-send-email-jeff@labundy.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--W5WqUoFLvi1M7tJE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 12, 2020 at 09:15:16PM -0500, Jeff LaBundy wrote:
> This patch adds support for the Azoteq IQS620A, capable of generating
> a 1-kHz PWM output with duty cycle between ~0.4% and 100% (inclusive).
>=20
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Note: This patch was originally part of a series that was intended to be =
taken
>       through mfd in its entirety. However, attempts to elicit an Ack for=
 this
>       patch went unanswered, so it was dropped in order to unblock the se=
ries.
>=20
>       The remainder of the series (including pwm bindings) landed in 5.7-=
rc1,
>       so this patch is being sent on its own so that it may be taken thro=
ugh
>       pwm during the next merge window.
>=20
> Changes in v5:
>   - Replaced iqs62x->map with iqs62x->regmap throughout
>   - Updated iqs620_pwm_probe to read the values of IQS620_PWR_SETTINGS_PW=
M_OUT
>     and IQS620_PWM_DUTY_CYCLE so that iqs620_pwm_get_state reflects the a=
ctual
>     state of the device following any changes made by a bootloader
>   - Dropped #defines for platform_driver name and alias in favor of the a=
ctual
>     string names
>=20
> Changes in v4:
>   - Updated iqs620_pwm_apply and iqs620_pwm_get_state to hold the lock ar=
ound
>     only the minimum necessary code
>   - Removed the completion protecting against early use of chip->pwms[0] =
=66rom
>     inside iqs620_pwm_notifier in favor of cached register values
>   - Updated iqs620_pwm_get_state to use the cached register values instea=
d of
>     reading IQS620_PWR_SETTINGS_PWM_OUT and IQS620_PWM_DUTY_CYCLE (both e=
qual
>     to zero by default)
>   - Added a comment in iqs620_pwm_notifier to note that the parent MFD dr=
iver
>     prints an error message in the event of a device reset
>=20
> Changes in v3:
>   - Updated the commit message to say "~0.4%" instead of "0.4%"
>   - Clarified the effect of duty cycle and state changes in the 'Limitati=
ons'
>     section and added a restriction regarding 0% duty cycle
>   - Added a comment in iqs620_pwm_apply to explain how duty cycle is deri=
ved
>   - Updated iqs620_pwm_apply to disable the output first and enable it la=
st to
>     prevent temporarily driving a stale duty cycle
>   - Rounded the calculation for duty cycle up and down in iqs620_pwm_get_=
state
>     and iqs620_pwm_apply, respectively
>   - Added a comment in iqs620_pwm_get_state to explain what it reports fo=
llow-
>     ing requests to set duty cycle to 0%
>   - Added a lock to prevent back-to-back access of IQS620_PWR_SETTINGS_PW=
M_OUT
>     and IQS620_PWM_DUTY_CYCLE from being interrupted
>   - Updated iqs620_pwm_notifier to reference pwm->state directly as oppos=
ed to
>     calling pwm_get_state
>   - Moved notifier unregistration back to a device-managed action
>   - Added a completion to prevent iqs620_pwm_notifier from referencing the
>     pwm_chip structure until it has been initialized by pwmchip_add
>=20
> Changes in v2:
>   - Merged 'Copyright' and 'Author' lines into one in introductory commen=
ts
>   - Added 'Limitations' section to introductory comments
>   - Replaced 'error' with 'ret' throughout
>   - Added const qualifier to state argument of iqs620_pwm_apply and remov=
ed all
>     modifications to the variable's contents
>   - Updated iqs620_pwm_apply to return -ENOTSUPP or -EINVAL if the reques=
ted
>     polarity is inverted or the requested period is below 1 ms, respectiv=
ely
>   - Updated iqs620_pwm_apply to disable the PWM output if duty cycle is z=
ero
>   - Added iqs620_pwm_get_state
>   - Eliminated tabbed alignment of pwm_ops and platform_driver struct mem=
bers
>   - Moved notifier unregistration to already present iqs620_pwm_remove, w=
hich
>     eliminated the need for a device-managed action and ready flag
>   - Added a comment in iqs620_pwm_probe to explain the order of operations
>   - Changed Kconfig "depends on" logic to MFD_IQS62X || COMPILE_TEST
>=20
>  drivers/pwm/Kconfig       |  10 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-iqs620a.c | 270 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 281 insertions(+)
>  create mode 100644 drivers/pwm/pwm-iqs620a.c

Applied, thanks.

Thierry

--W5WqUoFLvi1M7tJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6VxEAACgkQ3SOs138+
s6GrJBAAjCtLnttEO5NbHOAnDjf5PoFx3biAjFxfaDTpWWmMnhZbPPzFJ0JrPzRU
XTMgZqZLygHqYvM6uWQlvf7zdKL0ALetXyLTAGwEGa/BjMJW0YXAilpDSrlYJDIR
yN2zvdBNLAvu7XBaW3CL1FkEQ0ttK5wACjnGcrVo9qGVCtmEidQIVBQKHAjfp5CX
pqaanNHdX6GWhGdFxFCoEr7UR7XGXKsam5NQ7IxmIFNu/MN/GTgCA6hMccbAxXho
qbRZUzpB0nwH13ahdl+JTDZJsbrSMK/MCm+eJS3DGYdmsRNZjNcLVqP13hYCuEL4
ERhTRse5O/chnBzpr5XOXAhReLOr6ujGzxE41H4IOLNJp73EBXpTsgFH5yVM+VOR
FShi1/o9JNRfNXuOSiaZ7aucGNSC0ffL/0rGe9qBQlK13Fm1K6hrQS9JaeJ16ApX
xL5sam3WIxKzEDoVrqvE7dvKpqf2GdfdwEBQsDGWVryARAL9OewWublBcVNumGkY
ABGos053lHmRADgcYF0Gr5fuaYt4fm8gS6sGg9UPD2UmJkpDFXehT4xo5iLIF7ar
MRYfs2vIqZJiy05kJ/mph3qDUfXsEaWQbRHTiIaJy0rm88EZR4eeRjS5Ut6zVqrX
zEVK9oaeu5XL0Vf0KQxglXkGAJ9FvSjPY6peVkC1/7eeypUk5kg=
=yyTn
-----END PGP SIGNATURE-----

--W5WqUoFLvi1M7tJE--
