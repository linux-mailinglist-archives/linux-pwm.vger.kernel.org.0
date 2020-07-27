Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBBEC22E6C7
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 09:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgG0Hl0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Jul 2020 03:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgG0HlZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Jul 2020 03:41:25 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3A8C0619D2;
        Mon, 27 Jul 2020 00:41:25 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id d6so2203540ejr.5;
        Mon, 27 Jul 2020 00:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YTdnbyliOi9Ndfm/J+eV0kp1Cp44Yzlw3Ep8ue+gCRw=;
        b=csqkhZtO0OXfSvZbA0eRcoiQxr74bXtGArNV9KJJmFC+mh3OqlM0VhU+6Nao0M9LQb
         Xy5BSlaA+UjngK+UIC5Wu/f8a/dqFAsmM5uiIq3hg5d3oOVsOpVYkS0l8Lr5aRLDXO3F
         TS7X4g0YSwI+VW4kFq8zKVJlW7c5MJlWZWyA/Neq044uopm5T/TpBehF/AIB2GIhyQyW
         IKnNKNYvn6p72UnDbyqHNti7zS6/f8Q4XorvYIlMKQ+C5qxP45jB9q1fBY4k4XII0zLY
         3+GK5gMFVnRJl06b5L+a5QgDkBjlFPltt69gWnN5Y8wmvK8j0rrK1h0piQEqO2dw++8H
         k76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YTdnbyliOi9Ndfm/J+eV0kp1Cp44Yzlw3Ep8ue+gCRw=;
        b=sr1vuMejZzac7eOVq+CzImMINmh2vf/LXjIf/MfLR8nuHDWstIq59UVBrNhPB2NkDC
         KptF8VkEmZEWaGEnqcQuxV2yzAlOs8r6JYqe7g+2h2iOTs248+dhmf7EZod6WtXx4rMO
         3fEEuu0vYZeyq3GkUGE8l141EbrVgUYAWBK4Yxfl09CoufHsvzslPVNDtgzgl1u65k1h
         v/WhMMuAv4zzdmRRLWAkIZWI5ZJLyMprDICRA6FpJ8eHynBMohv3US4E5zOiShXJgunB
         4A0YLTOdCbZN1Meo8FHLNd5rv5nrXfa6DIuh+D/7Wr/eYzj2PyLeDqYVH2fjepkMGQ1M
         Ma5A==
X-Gm-Message-State: AOAM530PfCtuqpHR89qXjFLg0jsQ9I1+o6RWX2hACxVd5iQueTysrz67
        Vl5TuMex1grkLguL57C33dw=
X-Google-Smtp-Source: ABdhPJysa1QPB3h2kqk//gcCYrzyYhq+X63NKOXLOWWub6OcC4DxUh9bdfQlnj3HX3EdNtThuwiF6A==
X-Received: by 2002:a17:906:37c3:: with SMTP id o3mr1508022ejc.54.1595835683896;
        Mon, 27 Jul 2020 00:41:23 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id q17sm6358906ejd.20.2020.07.27.00.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 00:41:21 -0700 (PDT)
Date:   Mon, 27 Jul 2020 09:41:20 +0200
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
Subject: Re: [PATCH v5 00/16] acpi/pwm/i915: Convert pwm-crc and i915
 driver's PWM code to use the atomic PWM API
Message-ID: <20200727074120.GB2781612@ulmo>
References: <20200717133753.127282-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
In-Reply-To: <20200717133753.127282-1-hdegoede@redhat.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2020 at 03:37:37PM +0200, Hans de Goede wrote:
> Hi All,
>=20
> Here is v5 of my patch series converting the i915 driver's code for
> controlling the panel's backlight with an external PWM controller to
> use the atomic PWM API. See below for the changelog.
>=20
> This series consists of 4 parts:
>=20
> 1. acpi_lpss fixes workarounds for Cherry Trail DSTD nastiness
> 2. various fixes to the pwm-lpss driver
> 3. convert the pwm-crc driver to support the atomic PWM API and
> 4. convert the i915 driver's PWM code to use the atomic PWM API
>=20
> The involved acpi_lpss and pwm drivers do not see a whole lot of churn,
> so the plan is to merge this all through drm-intel-next-queued (dinq)
> once all the patches are reviewed / have acks.
>=20
> Specifically patches 5-9, 11 still need an Acked- / Reviewed-by
>=20
> Andy, can you please take a look at the unreviewed patches? Specifically
> patches 5-6 should address your review remarks from v4 of this set
> and I've addressed your review remarks on patches 7-9 in v3 already.
> A review of patch 11 would also be welcome
>=20
> Uwe, can you please take a look at the unreviewed patches?
>=20
> Uwe, may I have your Acked-by for merging this series through the
> drm-intel-next-queued branch once all PWM patches have an Acked- or
> Reviewed-by ?
>=20
> This series has been tested (and re-tested after adding various bug-fixes)
> extensively. It has been tested on the following devices:
>=20
> -Asus T100TA  BYT + CRC-PMIC PWM
> -Toshiba WT8-A  BYT + CRC-PMIC PWM
> -Thundersoft TS178 BYT + CRC-PMIC PWM, inverse PWM
> -Asus T100HA  CHT + CRC-PMIC PWM
> -Terra Pad 1061  BYT + LPSS PWM
> -Trekstor Twin 10.1 BYT + LPSS PWM
> -Asus T101HA  CHT + CRC-PMIC PWM
> -GPD Pocket  CHT + CRC-PMIC PWM
>=20
> Changelog:
> Changes in v5:
> - Dropped the "pwm: lpss: Correct get_state result for base_unit =3D=3D 0"
>   patch. The base_unit =3D=3D 0 condition should never happen and sofar i=
t is
>   unclear what the proper behavior / correct values to store in the
>   pwm_state should be when this does happen.  Since this patch was added =
as
>   an extra pwm-lpss fix in v4 of this patch-set and otherwise is orthogon=
al
>   to the of this patch-set just drop it (again).
> - "[PATCH 04/16] pwm: lpss: Add range limit check for the base_unit regis=
ter value"
>   - Use clamp_val(... instead of clam_t(unsigned long long, ...
> - "[PATCH 05/16] pwm: lpss: Add pwm_lpss_prepare_enable() helper"
>   - This is a new patch in v5 of this patchset
> - [PATCH 06/16] pwm: lpss: Use pwm_lpss_apply() when restoring state on r=
esume
>   - Use the new pwm_lpss_prepare_enable() helper
>=20
> Changes in v4:
> - "[PATCH v4 06/16] pwm: lpss: Correct get_state result for base_unit =3D=
=3D 0"
>   - This is a new patch in v4 of this patchset
> - "[PATCH v4 12/16] pwm: crc: Implement get_state() method"
>   - Use DIV_ROUND_UP when calculating the period and duty_cycle values
> - "[PATCH v4 16/16] drm/i915: panel: Use atomic PWM API for devs with an =
external PWM controller"
>   - Add a note to the commit message about the changes in pwm_disable_bac=
klight()
>   - Use the pwm_set/get_relative_duty_cycle() helpers
>=20
> Changes in v3:
> - "[PATCH v3 04/15] pwm: lpss: Add range limit check for the base_unit re=
gister value"
>   - Use base_unit_range - 1 as maximum value for the clamp()
> - "[PATCH v3 05/15] pwm: lpss: Use pwm_lpss_apply() when restoring state =
on resume"
>   - This replaces the "pwm: lpss: Set SW_UPDATE bit when enabling the PWM"
>     patch from previous versions of this patch-set, which really was a ha=
ck
>     working around the resume issue which this patch fixes properly.
> - PATCH v3 6 - 11 pwm-crc changes:
>   - Various small changes resulting from the reviews by Andy and Uwe,
>     including some refactoring of the patches to reduce the amount of chu=
rn
>     in the patch-set
>=20
> Changes in v2:
> - Fix coverletter subject
> - Drop accidentally included debugging patch
> - "[PATCH v3 02/15] ACPI / LPSS: Save Cherry Trail PWM ctx registers only=
 once (
>   - Move #define LPSS_SAVE_CTX_ONCE define to group it with LPSS_SAVE_CTX

Hi Hans,

I've applied patches 3 through 12 to the PWM tree. I thought it was a
bit odd that only a handful of these patches had been reviewed and there
were no Tested-bys, but I'm going to trust that you know what you're
doing. =3D) If this breaks things for anyone I'm sure they'll complain.

That said I see that Rafael has acked patches 1-2 and Jani did so for
patches 13-16. I'm not sure if you expect me to pick those patches up as
well. As far as I can tell the ACPI, PWM and DRM parts are all
independent, so these patches could be applied to the corresponding
subsystem trees.

Anyway, if you want me to pick those all up into the PWM tree, I suppose
that's something I can do as well.

Thierry

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl8ehR4ACgkQ3SOs138+
s6ETag//Xn1kIxUq5jxo1JOZr7YSDLCg0zHSxh4D/a2c7iaZ+48DjqeSsjW/8hQF
kXQI8XwjKgqG2TerIa6KfI9asvwSPizBmYOP1rnkNg7yTvkdM57qPduT7SmC4h5o
P8emV1Niqe8SYN5pVJD/o7A9CTRvwGj3dbMoQRemni2X8/lmKwOgcR1Gm22d4FoQ
Uvzu77YAY3lNRt2wAqhRDoHAPvVj2436KN+iHBnxEir/UeGf1UhKDzw3YLzhVo/d
XrqoVN0nPYqAaOtB83FnPKyNsqEGu5IeZDD+kjwT1+JILOh3thNh1yJUFX9qcHRF
onRvHaezJS/4KcC0j155NbxEAqiA3wnfsgEWsceBwsBeeVRaF2s/vuxqDVHA4NuU
WdwAXU+aGmccrsMOgTEdxJC58HC7nbIo6kvbqVy1mmgwyVXjGoPn5ckrR7ef05DT
Ba3Rgaucsz2esx7ZY3ejdb3IV4ECaQ4bkBZ7K/WxTWFXbZmhIa6fyH2DEt/hgB2n
6q9AUA26y4KQXCLRlnOmtiTLhLSho6+jHXKq4Pf+6yr/hUg/Uzmqja1LiN/0oSAA
XO85HzYswijhx/twC3zVEdsKUcyJTaTE2Nsd0+l2trjNOgPeRWFm6H+9Ba9fBoOJ
/d/ZsgPYja/frCBE3m1kcf/3zQdIediIgdWk4zD1Cf63FLyMv/k=
=wsUd
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
