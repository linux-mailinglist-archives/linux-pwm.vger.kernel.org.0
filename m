Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D60322E7B7
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 10:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgG0I31 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Jul 2020 04:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgG0I30 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Jul 2020 04:29:26 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF316C061794;
        Mon, 27 Jul 2020 01:29:25 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id g11so4394031ejr.0;
        Mon, 27 Jul 2020 01:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kTvFHWIgSGjnFCLXvF/yM/fZKWRBifqnvOHS6nXZY60=;
        b=rhBWZ8UZfJnc/0LDqRq1hvkXo3Y/bKWD9uXPbt5ZdJCJL7MPyacKwMj8uZl1LoIx+t
         JJBPVDfd7U0T8YGwhhCJZBJRhG0dHWshYxK6BiKXvS39U3Jw7WixJpP1+v2N11/KeHpD
         6HRq0M47ZM+dxh2MLcWdc83LoqK0WnCPn57cLleZTUTRKoZmnpBKdymAOnGspTpzafp5
         gb1bUilnrQWaQ0abFXdY7bDQVaOHvhDYjHZxAnWcDYHv3vdQN/3joHxoMLjitYb5lnF8
         6pZBf228xQ3KVpJs+dn+U/NOv9hndoHDYa9Anl8xVsk+VTOR4KNJh3UTq35soi/MYg42
         Qxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kTvFHWIgSGjnFCLXvF/yM/fZKWRBifqnvOHS6nXZY60=;
        b=KOef3x0qMsuz+UKNeEULY64JzHMEeLdPx8sYTEty4wK3A6IDrQJUkqK8LX5kb3ELhl
         WX0/u9Rv5onN9X0I9m2RPGlIYPwPB3HGC3AIGUM/nfLTe6aGhldGuIQpKmh/+YWNQAyx
         E9r/1LX5CCsRGUXMses2hCGw02ZtZ53KsEYuYyqQMztzMaW0OG5EYZC/q6PI8FXlv09m
         ZcSHBqv5b8DkAOEODE+y3e090DwIwDnD5puDlsT9nwN2B+k2X/cqATaEuPguSawdI+uE
         aCdsAbdDTzlZP48IaAM8NpUHRxNIeMirMSi2MS2GU4uczekrmRZzg/hy6e4iWTN0t5Jm
         2V/w==
X-Gm-Message-State: AOAM530eLenRNnoV6D3a7WkiMOwUR2LoBLswUiDTU4DFTvrQJVZAIUPj
        G1LQ6wONXxoEEK47tOCVVvU=
X-Google-Smtp-Source: ABdhPJxBJ61Af8cchsQdC/QftI94zMlte4qABD6xZOGp0SVf0126WE3jJmOlPkHbPFHUG5f9p+9U8A==
X-Received: by 2002:a17:907:2119:: with SMTP id qn25mr1249847ejb.278.1595838564540;
        Mon, 27 Jul 2020 01:29:24 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id o9sm6972837edz.81.2020.07.27.01.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 01:29:23 -0700 (PDT)
Date:   Mon, 27 Jul 2020 10:29:22 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: [PATCH v4] pwm: bcm-iproc: handle clk_get_rate() return
Message-ID: <20200727082922.GE2781612@ulmo>
References: <20200718044606.18739-1-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sfyO1m2EN8ZOtJL6"
Content-Disposition: inline
In-Reply-To: <20200718044606.18739-1-scott.branden@broadcom.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--sfyO1m2EN8ZOtJL6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2020 at 09:46:06PM -0700, Scott Branden wrote:
> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>=20
> Handle clk_get_rate() returning 0 to avoid possible division by zero.
>=20
> Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controller")
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>=20
> ---
> Changes from v3: fixed typo in commit message: Reviewed-off-by.
> Hopefully everything clean now.
> Changes from v2: update commit message to remove <=3D condition
> as clk_get_rate only returns value >=3D 0
> ---
>  drivers/pwm/pwm-bcm-iproc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--sfyO1m2EN8ZOtJL6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl8ekGEACgkQ3SOs138+
s6E9NQ/8DRh+Uofx9uOez18XOB5EXMG+bglfBoTGCIZtSqn9NLcVnGNpM37XVEhU
F1rSljb4082n2YzA5yGXz5CPR0IMWldexngcbyrH1HOKYruiP/tjI5ndl7qE3s1v
UfMeqw0EOx8Jp7lUGEQcHB4w2tMFY/5LVJJqdVdIU9b4ddmIZkXnxpIpUFN+FTfR
FZ7+ZkCGFAHPH0OEWQ6H8SjwTS1t+iqoB4FbV22xXUYe9BCg7JxT55pMfoz3Ktke
lfTKrwT1cA0tPLww9G0pd5MiI4+9L2p3imzyVLQ0ZC4evYi09S1cmSFlQbfuI3xC
6+caPgkKJl96zbK0zlR9immVgzZ+ZFQKhFa7iP7GqTJMfnAtN0B0rukctzmTTq1Y
UeG2QZO3KO39Kow7UOaVKNTdJ74tjzphJSJsbDRTL70c7sm2FxsodTBGmqs29EFb
DdJ8Pq81mLI1y+TWyN3PCqHXm+AJNzWQuXMBQBpGVfSYIquaFuNsX2CZtuLVS2kR
eu5WoN+Oh9mGJxjNNLIHHsl+U4V7qm+vNnsA5a17QKkps+5oUz1qeduy/0/PHqkm
Mk1IFbX7lQRZjiAJt2IUMypYOS9IP9nGCdqUYeEh44dkSgzLV7o8OjO5V2BXMC6I
6wki2OpMXEs2wJWjit5PWynQJQIEugfEiLjFyHSJ1pnBrV45+Fo=
=qIz5
-----END PGP SIGNATURE-----

--sfyO1m2EN8ZOtJL6--
