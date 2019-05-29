Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10A5B2DE84
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2019 15:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfE2NiU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 May 2019 09:38:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41872 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbfE2NiU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 29 May 2019 09:38:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so1805763wrm.8;
        Wed, 29 May 2019 06:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SSDX0IFzK0JxKasOQZVU7qtkKz86xcHes4zgxSIsoSg=;
        b=pWcFBaNCYTLQdWxClVVn1othoB766n4ZklHunshXkb3iD8qynOvsLDB+ZfxqnjY8wN
         W/crGWwN+MXDPPKQ3LOUDlmuHaxfd6R4+rm1wSASWbWhAp33823UVmFAv23VCchh28Vm
         pXik+jBh6s2HGYpyaYk75KNJruPp0VeXwDMWCCr4ASWI8VOezyPH0crToQuRcGJ8mXPv
         S7yRAy6DloyRA73ysgp2l7Gr7xjohMZ49h6rvJrXad4UBJtkQ1RDI0zea+ov4wXjrZHJ
         OAdPpxQ7RHNIvddagbnpiOKIFLwkFO7WRk9xZWlOlIzcaee0W4x0bNUrjD6QIuHjioRK
         J+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SSDX0IFzK0JxKasOQZVU7qtkKz86xcHes4zgxSIsoSg=;
        b=MFTm/fR9BdqbOakcSym9nPijnt3b3QPsyQT56gFxxCgltNfEXRtO100yWRSl5t9E+h
         XXktdxmbG6MO+soPbbFkP/ph4jXgyJswiiPO+TVnRgqnz1MUFKl/SSvL0tCWquOU+gBF
         G6iUg9JldW5RHoRhWh9dv354mC2EV8N7/KxXxENdpzIpTM36YTx5JpKNx/ovNU3cjYNw
         a4r5S4wuGaJ1CdUMIakPk6WZE6UDky7IThmLZfVxvngsHh/hlgSLf44VcO9v9JRXIW7C
         eyqIAPpbsEthT6a57Js/5vdUsEQtwp3s1IZM9C3KB7qnLOpuflX3eImc2nqkKoZd8Iqj
         Gjiw==
X-Gm-Message-State: APjAAAVTIghJhTfd1qhFoOv7oW+bLOPZmXvl5CARLEhxz9WOB9yEpFNR
        tDS/ouZwk6t3YSB9d3Lk8w8=
X-Google-Smtp-Source: APXvYqzj2AgDvBS6ybct/IQ2xtIYu9JRP26iPU3GieWzhXz3xNK3wIi4p/a8dqjK+ak7IMtMXzNcXw==
X-Received: by 2002:a05:6000:12:: with SMTP id h18mr4994529wrx.29.1559137098788;
        Wed, 29 May 2019 06:38:18 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id f197sm6661841wme.39.2019.05.29.06.38.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 29 May 2019 06:38:18 -0700 (PDT)
Date:   Wed, 29 May 2019 15:38:17 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 3/4] pwm: sysfs: Add suspend/resume support
Message-ID: <20190529133817.GB17223@ulmo>
References: <1559116082-9851-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1559116082-9851-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
In-Reply-To: <1559116082-9851-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2019 at 04:48:01PM +0900, Yoshihiro Shimoda wrote:
> According to the Documentation/pwm.txt, all PWM consumers should have
> power management. Since this sysfs interface is one of consumers so that
> this patch adds suspend/resume support.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pwm/sysfs.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 64 insertions(+)
>=20
> diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
> index 7eb4a13..72dafdd 100644
> --- a/drivers/pwm/sysfs.c
> +++ b/drivers/pwm/sysfs.c
> @@ -18,6 +18,7 @@ struct pwm_export {
>  	struct device child;
>  	struct pwm_device *pwm;
>  	struct mutex lock;
> +	bool enabled_in_suspend;

How about if we save the complete state here? Something like:

	struct pwm_state suspend;

Or similar? Then we can just pwm_get_state() into that and then disable
the PWM like you do.

>  };
> =20
>  static struct pwm_export *child_to_pwm_export(struct device *child)
> @@ -372,10 +373,73 @@ static struct attribute *pwm_chip_attrs[] =3D {
>  };
>  ATTRIBUTE_GROUPS(pwm_chip);
> =20
> +static int pwm_class_suspend_resume(struct device *parent, bool suspend)

I would prefer if these were separate functions. I think the kind of
conditionals that you have below isn't worth the few lines that you may
save by fusing suspend/resume into one function.

Also, if you store struct pwm_state suspend during suspend, then both
implementations will end up being fairly different, so reusing the code
isn't going to be much of an advantage.

> +{
> +	struct pwm_chip *chip =3D dev_get_drvdata(parent);
> +	unsigned int i;
> +	int ret =3D 0;
> +
> +	for (i =3D 0; i < chip->npwm; i++) {
> +		struct pwm_device *pwm =3D &chip->pwms[i];
> +		struct device *child;
> +		struct pwm_export *export;
> +		struct pwm_state state;
> +
> +		if (!test_bit(PWMF_EXPORTED, &pwm->flags))
> +			continue;
> +
> +		child =3D device_find_child(parent, pwm, pwm_unexport_match);
> +		if (!child)
> +			goto rollback;
> +
> +		export =3D child_to_pwm_export(child);
> +		put_device(child);	/* for device_find_child() */
> +		if (!export)
> +			goto rollback;

Con this even happen? I have a hard time seeing how.

> +
> +		mutex_lock(&export->lock);
> +		pwm_get_state(pwm, &state);

All of the above is shared code, so perhaps it'd be worth putting that
into a separate helper function to achieve the code reuse that you
otherwise get from sharing the function.

> +		if (suspend) {
> +			if (state.enabled)
> +				export->enabled_in_suspend =3D true;
> +			state.enabled =3D false;
> +		} else if (export->enabled_in_suspend) {
> +			state.enabled =3D true;
> +			export->enabled_in_suspend =3D false;
> +		}

This in particular is what I mean. I think the two levels of
conditionals here make this more complicated to understand than
necessary.

> +		ret =3D pwm_apply_state(pwm, &state);
> +		mutex_unlock(&export->lock);
> +		if (ret < 0)
> +			goto rollback;
> +	}
> +
> +	return ret;
> +
> +rollback:
> +	/* roll back only when suspend */
> +	if (suspend)
> +		pwm_class_suspend_resume(parent, false);

And then there's stuff like this where you need to explain what's going
on just to save a couple of lines of code.

Other than that, looks really nice.

Thierry

> +
> +	return ret;
> +}
> +
> +static int pwm_class_suspend(struct device *parent)
> +{
> +	return pwm_class_suspend_resume(parent, true);
> +}
> +
> +static int pwm_class_resume(struct device *parent)
> +{
> +	return pwm_class_suspend_resume(parent, false);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(pwm_class_pm_ops, pwm_class_suspend, pwm_class_=
resume);
> +
>  static struct class pwm_class =3D {
>  	.name =3D "pwm",
>  	.owner =3D THIS_MODULE,
>  	.dev_groups =3D pwm_chip_groups,
> +	.pm =3D &pwm_class_pm_ops,
>  };
> =20
>  static int pwmchip_sysfs_match(struct device *parent, const void *data)
> --=20
> 2.7.4
>=20

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzui0gACgkQ3SOs138+
s6GgPA/9HP01fYqDpR4ZSkzwJ42hzwmbxiYDbZqFvwWi8zh3Q0fAplyTvHwfNKor
azZ9OtlQWhFCaFrST6VD0ad9tWd7MTPabMKJgUoOTQOnl9GHNWHe64JVvyEfblp5
br5q6zIEPvSksbTlw9ojTL15C1no2IlkXQ9NDIlNcm8q09FM2PyOOtXt1MYh302m
cHk2UISuJccxYN/Qqmm2vtFEnx64bwJjU4PRNDD22aIHmPT1YjZgI7s9kSDG9qpa
BdBt8Ve7VDsna7piyAzNqRc7Dcf7L/D0QUrwTSEreoFBYlw2KEZ8gC43gvXVZq39
/Vvf5Bh8N0JgXryae0wQDX3wqbpV7G+zeXuBwMb5/AMAvYGsc6rhnpGUakzea5lZ
0/f8h/1DX+yPQXEdGzO9/CQB5aTM6x61ahZVfrzR1vSjp4aAXG1BObI1Z62hD+Hf
/igvvVSzhtY6VgQ80sb+zUbc0xSQmQmP6PLGl3KE6bL/kOmUa7oQU66krZtPOPsM
tnUpjWcbLkmM+xgXtGMVHeYpnavCSLmRqWPWnxtW8WgyHSmvR3cuGOu3esV+yslO
541mnTU/GMxMyEJc+wcj+/nhmvL8Vrit8nyrbsYpC7EQBx7NKi9OYy8U2n5cq+Fc
W1Is+pUmyJ+L6MPeP7fYKcZjOVFu74kKQbNBN4Qn008d4BgCahY=
=3T+7
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
