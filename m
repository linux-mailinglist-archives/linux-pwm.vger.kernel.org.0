Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA57925784B
	for <lists+linux-pwm@lfdr.de>; Mon, 31 Aug 2020 13:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgHaLZv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 Aug 2020 07:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgHaLXr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 Aug 2020 07:23:47 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5858C061573;
        Mon, 31 Aug 2020 04:10:10 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id nw23so6516879ejb.4;
        Mon, 31 Aug 2020 04:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hSMOrFIuB8KhU/CeTgamOD+l3UuVWWHZ0INs/jiXeLA=;
        b=oc3+dIiLM3jDDv/0aloRcP+W6CFmE2gEP3Fxq9AQ3LTw1WP3Au5ZGB8CExeDFFcxVt
         7cQjRPbhdiiQ6Atmu3d7+Ap6wm3mMQhcJzurZxWN0sM/Z+fvVnlqtCo6WRGWqX7BLUwT
         A8gp7a3jtYiqI7CNkyRWZkWt5VdfnTvrUepG0zndqG+LbEKpxLfQE9DKm8jtcSnTVJWs
         y4QFASOQUU5Nw36bwT+8JmDFluprN7uzCosTD8Dxf2OID6qqzDDE1lZLOgkH7RYOFAkA
         L6fx+/9NsMWhzDyM1xJEOEFnkHiNMHxRlW6954S9inPdYf244Sem4yrLVX/slETFO9Ha
         GYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hSMOrFIuB8KhU/CeTgamOD+l3UuVWWHZ0INs/jiXeLA=;
        b=mb0d+C39KWNtb3V6O/pzt9DxEsP/fEzSnDpFc2HFonZvMtHOQb+K/A8r6KlBPC9wTf
         +rR8AkViWQzqQtpwuHYw3se02+mfVCYyYUP/MYZxkQJZ0VqpP+CzszV2Hgaw9IKjHER5
         QoADC0R8LeuyzneQQa+Fqjpk8//7F+RPefuhiYh6wGA8NhQcf3vTrwY07M7rXoDhgtAk
         PW7k7Wl1T0imihMHx7JRZDowNCRjHtVUhoR50DRi7e1P76gVV064p7eEAN3u+GBUAm/W
         /WoxIlNqinC3QjBrjEzg93atxbGBr06yBg1T4zmE8JPXNe2PDLekEjKpn/po4RLbM9ev
         pNyQ==
X-Gm-Message-State: AOAM532Zu8yXjKgV9qf7K0VXL6J+Vydj2CyndKoeCZzXtMgDEpYkmvgH
        7e8u0iODsAk9x4hIRaOEfR8=
X-Google-Smtp-Source: ABdhPJzfdgepShBDrS4mxIxiNzu3BtIBOSwtT1EE5Gebeeo8x5D8jxQlktyvYXtubOXAirSZ3b1X0A==
X-Received: by 2002:a17:906:18a9:: with SMTP id c9mr627627ejf.294.1598872209418;
        Mon, 31 Aug 2020 04:10:09 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id e4sm7130736edv.73.2020.08.31.04.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 04:10:07 -0700 (PDT)
Date:   Mon, 31 Aug 2020 13:10:06 +0200
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
Subject: Re: [PATCH v8 06/17] pwm: lpss: Use pwm_lpss_restore() when
 restoring state on resume
Message-ID: <20200831111006.GD1688464@ulmo>
References: <20200830125753.230420-1-hdegoede@redhat.com>
 <20200830125753.230420-7-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NtwzykIc2mflq5ck"
Content-Disposition: inline
In-Reply-To: <20200830125753.230420-7-hdegoede@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--NtwzykIc2mflq5ck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2020 at 02:57:42PM +0200, Hans de Goede wrote:
> Before this commit a suspend + resume of the LPSS PWM controller
> would result in the controller being reset to its defaults of
> output-freq =3D clock/256, duty-cycle=3D100%, until someone changes
> to the output-freq and/or duty-cycle are made.
>=20
> This problem has been masked so far because the main consumer
> (the i915 driver) was always making duty-cycle changes on resume.
> With the conversion of the i915 driver to the atomic PWM API the
> driver now only disables/enables the PWM on suspend/resume leaving
> the output-freq and duty as is, triggering this problem.

Doesn't this imply that there's another bug at play here? At the PWM API
level you're applying a state and it's up to the driver to ensure that
the hardware state after ->apply() is what the software has requested.

If you only switch the enable state and that doesn't cause period and
duty cycle to be updated it means that your driver isn't writing those
registers when it should be.

> The LPSS PWM controller has a mechanism where the ctrl register value
> and the actual base-unit and on-time-div values used are latched. When
> software sets the SW_UPDATE bit then at the end of the current PWM cycle,
> the new values from the ctrl-register will be latched into the actual
> registers, and the SW_UPDATE bit will be cleared.
>=20
> The problem is that before this commit our suspend/resume handling
> consisted of simply saving the PWM ctrl register on suspend and
> restoring it on resume, without setting the PWM_SW_UPDATE bit.
> When the controller has lost its state over a suspend/resume and thus
> has been reset to the defaults, just restoring the register is not
> enough. We must also set the SW_UPDATE bit to tell the controller to
> latch the restored values into the actual registers.
>=20
> Fixing this problem is not as simple as just or-ing in the value which
> is being restored with SW_UPDATE. If the PWM was enabled before we must
> write the new settings + PWM_SW_UPDATE before setting PWM_ENABLE.
> We must also wait for PWM_SW_UPDATE to become 0 again and depending on the
> model we must do this either before or after the setting of PWM_ENABLE.
>=20
> All the necessary logic for doing this is already present inside
> pwm_lpss_apply(), so instead of duplicating this inside the resume
> handler, this commit adds a new pwm_lpss_restore() helper which mirrors
> pwm_lpss_apply() minus the runtime-pm reference handling (which we should
> not change on resume).

If this is all already implemented in pwm_lpss_apply(), why isn't it
working for the suspend/resume case? It shouldn't matter that the
consumer only changes the enable/disable state. After ->apply()
successfully returns your hardware should be programmed with exactly
the state that the consumer requested.

Thierry

--NtwzykIc2mflq5ck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9M2o4ACgkQ3SOs138+
s6EVeA/8CVuiSoo0jeOSu2zC6wPJUTR1ytUmbQ9QPv3ZatYw/QjtlbntPzS1G/Ae
xHn/dEoiPx8TpwoqPBaJlyWyDPdsvYk9/vB+JLixN5XdudQi5GDH3+RQSROdgq18
wcWYBe3asLVnCbLUm5RH3OfbJX5ZFy4qXMudc2eWZ90l/dSRhKK3RoAEAqOWFduZ
uKpe4of9pjBFtQ3vOVqYlUv+7gU0McNqZ4pElGwRT8aeuDl3ZB7Fq3c9tEPA+BW1
fKU4uoGla8V9GYCc9Ydcm/xrr+zN6mdRv77hpkD/gPxePYrqkjx1AneWSalbCgjb
PhDnBmgPBA1goanZfez6w31IYobty1ZF8fZIx2wG0qnyBizTxSpQW2mMxZqqlyky
Tar5sbWbF/ahNh0xQbkpd18O4w2XRVyRZIvswc/8jrexmw8Ss7VdSQPNvH0EJcxI
k82GQTi3O3fZ82Hg85T27OWonAYUnMU2l/L8jtH9LcdywM2JeIh+2aYJpUsPdcaQ
VdT3o4gX1T1EZH0wHYHRgbG4qo/guM9a7AVmB1D0YwmDePXacGsj3eVkGK+S7AmB
k+N19508vZebYHD/8pY++NHll3f6EjZVbKNQpd9bdAcUtmWILZPvb1Hq1TCfP5+a
PV5Q71ZeFF9qQz+ifvPC0aHF6LOB02KnahdJ8JJvB4objo/dIbA=
=x/LS
-----END PGP SIGNATURE-----

--NtwzykIc2mflq5ck--
