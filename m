Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5700C704990
	for <lists+linux-pwm@lfdr.de>; Tue, 16 May 2023 11:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjEPJmL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 16 May 2023 05:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjEPJmK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 16 May 2023 05:42:10 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502B41FC6
        for <linux-pwm@vger.kernel.org>; Tue, 16 May 2023 02:42:04 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f42c86543bso55952975e9.3
        for <linux-pwm@vger.kernel.org>; Tue, 16 May 2023 02:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684230123; x=1686822123;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFDj2rMpl+Yfu5DS+jk8KB0XWT+AkysOCUeQgCl0eZY=;
        b=pFwgLdC8Xb7im7ZITyzRazN8RItJVMCrgqF+Yfn+7cyPJC7ss5drS8TF8CmTHrNhzu
         PsSN6wybBg5eNZXrrMWgRoDv23HWSuI63egaw3ba+cQY4l5qVvlfXyjSXI+CXVj7xpX/
         uHxVZjSczTlTFozHyS8kGoJNtWntVcV20AIpNWdvoSN4wVa+Wi1tkELVAI24fmd5Dq79
         XQMW9XTwDlsF2cSB2gyX2fHMSmyotwEuDrWRKreJnFf59rB0OvDdvm2kSG1/tGvzV+Re
         +SFz2gsrOLAh2DDVNKSguXRdFf73qa5nX7qM/9hej2DDyYmQpmZ6z8Br+M1LfWmv+c3/
         VYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684230123; x=1686822123;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFDj2rMpl+Yfu5DS+jk8KB0XWT+AkysOCUeQgCl0eZY=;
        b=YSPkxH+vtL9lKGLMTJBKw5ABAyzfCyjRQr9K9J/XK62fEmLbXG99EZ6XeKkltSEK29
         SfKrtWW6JpLM5cM1svLLnyM3tT2eA+m58e3TXEZbMcK/eIzpo4FNFFGmD4oaHQkKl9d+
         QBEJyf5h0BV0lH0VPX/uexjG+7fy0nj8Ra2RFN0H48t48m7qRwrIpwWWuje+6vX8U6ac
         SfAE5H+A+g97ucsJNuSepqWww9u6qx1Fep/9Uyz5MUc6YW+KWKUh62kJQ6DU0IV7WU11
         MVCTqCnYmbOORXRQYIDD9hlkQyYQyxkvN+/c+LnD3NCRGN3CNDBo/SdXkl58Vf8AnZvX
         lrIQ==
X-Gm-Message-State: AC+VfDxQshL/Q0XxbmfgaKrdP7CYXvBVTV+a+M7uDfoTZxtMxYoe4vKF
        0585hvVRSbgddCtZ0EdN0VQ=
X-Google-Smtp-Source: ACHHUZ6aTuF0X2EJqroGBcV8nkMeEsU513+zHvm6soX59C6dBOm4cRD6/iktjgb9953vN5WaXVzqoQ==
X-Received: by 2002:a7b:cc93:0:b0:3f4:2bb3:a5c9 with SMTP id p19-20020a7bcc93000000b003f42bb3a5c9mr17586677wma.8.1684230122634;
        Tue, 16 May 2023 02:42:02 -0700 (PDT)
Received: from orome (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id j4-20020adfe504000000b002f6dafef040sm1964378wrm.12.2023.05.16.02.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 02:42:02 -0700 (PDT)
Date:   Tue, 16 May 2023 11:42:00 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Marek Vasut <marex@denx.de>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH] pwm: core: Permit unset period when applying
 configuration of disabled PWMs
Message-ID: <ZGNP6B5JRaHiJ5uL@orome>
References: <20230511181853.185685-1-marex@denx.de>
 <20230512062227.5buu6mhgxajvjhqf@pengutronix.de>
 <d33a20a5-33e3-16a0-6b7c-7b0ec44fc3b3@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hbzGjP/4Vd6ySoIq"
Content-Disposition: inline
In-Reply-To: <d33a20a5-33e3-16a0-6b7c-7b0ec44fc3b3@denx.de>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--hbzGjP/4Vd6ySoIq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2023 at 02:20:12PM +0200, Marek Vasut wrote:
> On 5/12/23 08:22, Uwe Kleine-K=C3=B6nig wrote:
> > Hello Marek,
> >=20
> > On Thu, May 11, 2023 at 08:18:53PM +0200, Marek Vasut wrote:
> > > In case the PWM is not enabled, the period can still be left unconfig=
ured,
> > > i.e. zero . Currently the pwm_class_apply_state() errors out in such =
a case.
> > > This e.g. makes suspend fail on systems where pwmchip has been export=
ed via
> > > sysfs interface, but left unconfigured before suspend occurred.
> > >=20
> > > Failing case:
> > > "
> > > $ echo 1 > /sys/class/pwm/pwmchip4/export
> > > $ echo mem > /sys/power/state
> > > ...
> > > pwm pwmchip4: PM: dpm_run_callback(): pwm_class_suspend+0x1/0xa8 retu=
rns -22
> > > pwm pwmchip4: PM: failed to suspend: error -22
> > > PM: Some devices failed to suspend, or early wake event detected
> > > "
> > >=20
> > > Working case:
> > > "
> > > $ echo 1 > /sys/class/pwm/pwmchip4/export
> > > $ echo 100 > /sys/class/pwm/pwmchip4/pwm1/period
> > > $ echo 10 > /sys/class/pwm/pwmchip4/pwm1/duty_cycle
> > > $ echo mem > /sys/power/state
> > > ...
> > > "
> > >=20
> > > Permit unset period in pwm_class_apply_state() in case the PWM is dis=
abled
> > > to fix this issue.
> > >=20
> > > Fixes: ef2bf4997f7d ("pwm: Improve args checking in pwm_apply_state()=
")
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > ---
> > > Cc: Brian Norris <briannorris@chromium.org>
> > > Cc: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de>
> > > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > Cc: linux-pwm@vger.kernel.org
> > > ---
> > >   drivers/pwm/core.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > > index 3dacceaef4a9b..87252b70f1c81 100644
> > > --- a/drivers/pwm/core.c
> > > +++ b/drivers/pwm/core.c
> > > @@ -510,8 +510,8 @@ int pwm_apply_state(struct pwm_device *pwm, const=
 struct pwm_state *state)
> > >   	 */
> > >   	might_sleep();
> > > -	if (!pwm || !state || !state->period ||
> > > -	    state->duty_cycle > state->period)
> > > +	if (!pwm || !state || (state->enabled &&
> > > +	    (!state->period || state->duty_cycle > state->period)))
> >=20
> > While I tend to agree that the checks about period and duty_cycle are
> > (somewhat) irrelevant if enabled =3D=3D false, I fear we'd break assump=
tions
> > here as some drivers configure duty_cycle/period in hardware even with
> > .enabled =3D=3D false, and so proably rely on period > 0 and duty_cycle=
 <=3D
> > period.
> >=20
> > Another approach would be to skip pwm_apply_state() in
> > pwm_class_suspend() if the state is already disabled. That one sounds
> > safer.
>=20
> I am not convinced that would be identical behavior.
>=20
> If we skip apply_state call on PWMs exported via sysfs interface which are
> enabled=3Dfalse , then the drivers wouldn't have their apply_state callba=
ck
> called to disable the PWM before suspend ... I think ... which seems like=
 a
> problem to me ?

If a PWM exported via sysfs has enabled=3Dfalse, then it should already be
disabled, so calling pwm_apply_state() on them to disable them should be
a no-op.

Thierry

--hbzGjP/4Vd6ySoIq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmRjT+gACgkQ3SOs138+
s6GyNg//UJa03zOX8q9FykpCyy24Uo+CULR3qXFTBIavw8DJkZwj4zgWJ2GRQFoc
rMdQeYRSUG0R0S1PcudLz+rplRkeGw+TLJ1Rw1Da9SItS+wBaggHsxWytY0mTYGe
i1S+cJZqtISOwwsVlbCSLrWqC9IiyaNtiF/I3HkFEBSX6ne7RabuX3zxXpdUCrZl
rC5gtQcFotyOYZWkPN20WbW+dkGZ8/TVP9dr1pCYeBmXyo6XQEwzDWtr2qg7tizQ
idvx6N3JfLK9gJqQPjAGjJ57e9AypRbBPzy7JXTKNP7LyYde79v8P/WflII/AS+q
6iNJZeOXfF8fN9husNmMz1znkzeLlavLZH7eG5yJbD3GopfSdfK5UjaZK4297Q1b
OuIH7NQG6lzbwI8Msk8L7e7U6lJYGHLMF+1cg1MtKF6OUWBaigu2HSLbH7zvlVbh
Hpx/HbUgiBjTvm3txYEFlRlxtThodtu+lPGc+iqIOiaFAcWhZvtD3gQ1tVMRd06J
yQLF5DXeYRSwIug7cldLV1FM+m//Dx/DiAqZqqH2BS9Dj4FTFfOA0AF1/L/NrwKG
HXLjnR1Zj2mzpVg9dBBL/RKSj1Om0MdP0bSiRSMGdQCW5ikeap1JL2T0YLBcz/a1
7wOLKyfUGGv01grhZQ4KGNg/gphqkhfY8NDh19Adt0Aie/PJr1Y=
=ZbdL
-----END PGP SIGNATURE-----

--hbzGjP/4Vd6ySoIq--
