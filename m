Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9649A257867
	for <lists+linux-pwm@lfdr.de>; Mon, 31 Aug 2020 13:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgHaL2i (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 Aug 2020 07:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgHaL1e (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 Aug 2020 07:27:34 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85ED4C0619D0;
        Mon, 31 Aug 2020 04:14:28 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id b17so7916585ejq.8;
        Mon, 31 Aug 2020 04:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X01LvFXFueRcI2ZlU9XeqbPTzDVMYa+4OS/23RAvwKo=;
        b=FEi57b8RlVkzPZvNuNN7nPhUzXSlgnXhuytyGSPKiFSMVEc9kpojXWHL7SL+APG5vP
         B0FZmBkP38k2jWlalIGtXGjMhVM+e+Q7Bx/C6RA2DKb1Ki6WVLULMIVWOKCHBWK21OAb
         1DZyyc25lSAHHfRcLYTHcE3t9AE2W4x3mv7kf5Lin/qpgSxvC6XieHEKuSV7/2GVhx0J
         aImwsdzkb5kCEfXWUFGQJ1avl0u/1Tty0+9gJ+vQOMUAuLoMa3LXpRV2AN55BnjRHRKa
         5p2bf1qK09WSl9RGi8DeVSGNM4TZc15yTaHh/pNugf5yU1LPbED6W56FSNF3FCVkxHU0
         wEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X01LvFXFueRcI2ZlU9XeqbPTzDVMYa+4OS/23RAvwKo=;
        b=cT9fRDoQ5Bo3MSiq98O9tlVk+BYAOzv2BWq2Lhyr9ZeGSWwTvBXYk9qc+lhbzjC/xu
         +BEI4EKFgmclbNmFp6Hly7QAcP2hGrbEOpv3AakusVHKR7FGKqZmfJbKTXNQqwS9WFG4
         nhJvfNVf/6eEQMcasfgNwqP5Tq18yAuLTQia80Hlqq39ACbPg7Hw2pp4NRgdJYp+TTWW
         HnklyZAb/prVYIeB3nVAnD8oT4bfXTlVKiODNZuP8cbrqLizGHv05xfzeWOrzGZWw+jg
         v0uNRQz0olYDK4HcZEMEPRo4SU4iwPrbHtAcyN79okT/mWMTfzAIus5OSR2vhsGCzIAx
         /K1Q==
X-Gm-Message-State: AOAM531Az4JwuO/TEnm05xxACmg7ZLzj3K8rEiYqDpQsCs63Kn5d9MQY
        IDc5d/14a3/6HEUWJId6Ln4=
X-Google-Smtp-Source: ABdhPJwianpUVafwqpi+1jPvnzk6IyxvTYuhXEJ+rOOom5+IAAvmkMeA6Nv+4Vx0aPY/4m56CcsZ3Q==
X-Received: by 2002:a17:906:f897:: with SMTP id lg23mr651887ejb.124.1598872467235;
        Mon, 31 Aug 2020 04:14:27 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id m24sm7788005eje.80.2020.08.31.04.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 04:14:26 -0700 (PDT)
Date:   Mon, 31 Aug 2020 13:14:25 +0200
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
Subject: Re: [PATCH v8 08/17] pwm: crc: Fix period / duty_cycle times being
 off by a factor of 256
Message-ID: <20200831111425.GG1688464@ulmo>
References: <20200830125753.230420-1-hdegoede@redhat.com>
 <20200830125753.230420-9-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/Zw+/jwnNHcBRYYu"
Content-Disposition: inline
In-Reply-To: <20200830125753.230420-9-hdegoede@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--/Zw+/jwnNHcBRYYu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2020 at 02:57:44PM +0200, Hans de Goede wrote:
> While looking into adding atomic-pwm support to the pwm-crc driver I
> noticed something odd, there is a PWM_BASE_CLK define of 6 MHz and
> there is a clock-divider which divides this with a value between 1-128,
> and there are 256 duty-cycle steps.
>=20
> The pwm-crc code before this commit assumed that a clock-divider
> setting of 1 means that the PWM output is running at 6 MHZ, if that
> is true, where do these 256 duty-cycle steps come from?
>=20
> This would require an internal frequency of 256 * 6 MHz =3D 1.5 GHz, that
> seems unlikely for a PMIC which is using a silicon process optimized for
> power-switching transistors. It is way more likely that there is an 8
> bit counter for the duty cycle which acts as an extra fixed divider
> wrt the PWM output frequency.
>=20
> The main user of the pwm-crc driver is the i915 GPU driver which uses it
> for backlight control. Lets compare the PWM register values set by the
> video-BIOS (the GOP), assuming the extra fixed divider is present versus
> the PWM frequency specified in the Video-BIOS-Tables:
>=20
> Device:		PWM Hz set by BIOS	PWM Hz specified in VBT
> Asus T100TA 	200			200
> Asus T100HA 	200			200
> Lenovo Miix 2 8	23437			20000
> Toshiba WT8-A	23437			20000
>=20
> So as we can see if we assume the extra division by 256 then the register
> values set by the GOP are an exact match for the VBT values, where as
> otherwise the values would be of by a factor of 256.
>=20
> This commit fixes the period / duty_cycle calculations to take the
> extra division by 256 into account.
>=20
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> - Use NSEC_PER_USEC instead of adding a new (non-sensical) NSEC_PER_MHZ d=
efine
> ---
>  drivers/pwm/pwm-crc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--/Zw+/jwnNHcBRYYu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9M25EACgkQ3SOs138+
s6GH8xAAjMo/M+ShCe5lfOAZJTXx9VgYTRYj/q1jrMtkTKQI89rLA2vj+RXkHMY3
Q/vbefQxtubkKj0G85UhahEhAJ4WI03Wg18LxBA4EgkyyYtrWY0BpSa/0HnCOpTL
+1nBBty7TShZZYWDjhS2eRmRuM8kLPVfSG998SJ80Yk5fNpg7lWsih26uVftL2jC
eOCDl8GxAN6bRn3f2sly5fKH+uhIjHYg5B18pVZ1MdkwpIY7BtYLNWQsd1VXvb+I
SO0REjIpB8UVzQZ11Ea3sUrZhNMu/x2P6J93VuGxCfkMZMM3BpwDeLAfyM/sW0Ko
Kc0YiedvxaD10jvTKXbVhZCL3N9sV0eh3zNPOOL/Vxw0OOTafwbyoDrpxQVGJp3A
LUOsz+5GeuSM/JyEMHAGq/JYxdPyLDX/ZgWEJzUvWwhCJFQ+4K4c10Ri1qITTVSQ
+gn6Rn3pf/SjlrZJ6loA8K/Yi4ndfmrfl/KeJ81TeTOYZVBrma6W6NFFQpUwI+PD
SDXskyBVU5T8v+rd2AzN5nM1ubFH4p3y5dqzdzX1uz5MC9aRTwFV17g44Q3FY8HL
qfPoPgeSoA0o7jxf63aTVYgqXcnSJ8Bg9fZ/POn/s/GXAcB+bV0apJYFWwQ/Tgg9
bZ67o0uSIfAKKR0sNxPHU/Hd/kzQ7W+4zCkxbx377zuSi7wf5yc=
=JLKH
-----END PGP SIGNATURE-----

--/Zw+/jwnNHcBRYYu--
