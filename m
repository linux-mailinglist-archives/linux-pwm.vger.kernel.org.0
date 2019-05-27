Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 881862B763
	for <lists+linux-pwm@lfdr.de>; Mon, 27 May 2019 16:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfE0ORp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 May 2019 10:17:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35096 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfE0ORp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 May 2019 10:17:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so17111821wrv.2;
        Mon, 27 May 2019 07:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3LKT/2C/PED5+ciUv67/zZEFcmySguZpZQ8rp55Smm8=;
        b=lEzzFehkTo2TuRXdB3JVJx5XlSbApF65a/lNVQ2Ygb9ToN7kKZ0DL8CNuHh/h7ASgh
         VLn9Vphklf9ThWHFRttk9y1JYehRxyd66cbtvmoD/t5hSpnFYWx1MS3Q8F/X44owBGFA
         zkxnc/2g/4DgetK9uWCNDJLdMCiA26vVBYdApWPCeujIE1jcTLRv9RH3itwLy3+H4I57
         xMsDYLMvF0R8C0JLMQcM5LBBHrE/l5pxu9ULPE1ui/d7tHlTxwTl8n/FKWJGT5Une3vx
         P6IXeUODHXZlzUk0PKLIRf/w4mITrWOo9vHkNo812mq40gzopVONoOWy92XrBh83cG5u
         cHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3LKT/2C/PED5+ciUv67/zZEFcmySguZpZQ8rp55Smm8=;
        b=j0/OuM+LIkaaQ/8hBEZYsgHJHDTNgc3ipL5aOWZ2Jp2c6eCFE0DnXe44P1oCepovYI
         KX0N6C856RDWsqFemrHxL4a4rumVEirdihh7mQb5XXrk+KBk0pwAd4OpCf4Obur+J+ng
         eNDKJf1czagiU4ojk6ZORsA5cmj4PNfnkCopTorBnwNP0y1+al177iV5CMWVBWPD2IK3
         kzjM3tmPTcmgqZw7vSDSRF4AducJ3K7jXkoOvXfcRK2vM0/ryE9HMjQypnRdgcXVsOmg
         vaBq0cJ2u100PBmRYfTeqt9/nSbIOWl+TxZczAKT8D1vbeudViDNm4y8QVh2ovQ1HCtW
         96uw==
X-Gm-Message-State: APjAAAXcbQt/r0negA7hbbr+FLfWM8rwmNK5zCWeqVVsdrmUUhLAEntr
        IdsgcylyWYNo0XJHA7OATqI=
X-Google-Smtp-Source: APXvYqxgYXsPm4wmgjbLimvTmPEYAgUesw94Do2loCzJosdJmlENryru/FPEOtgF6GE3fSGkwFfEdQ==
X-Received: by 2002:adf:f704:: with SMTP id r4mr18767807wrp.27.1558966663175;
        Mon, 27 May 2019 07:17:43 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id c14sm11802878wrt.45.2019.05.27.07.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 07:17:42 -0700 (PDT)
Date:   Mon, 27 May 2019 16:17:41 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Cao Van Dong <cv-dong@jinso.co.jp>
Cc:     linux-renesas-soc@vger.kernel.org, horms+renesas@verge.net.au,
        geert+renesas@glider.be, broonie@kernel.org,
        linux-pwm@vger.kernel.org, yoshihiro.shimoda.uh@renesas.com,
        kuninori.morimoto.gx@renesas.com, h-inayoshi@jinso.co.jp,
        na-hoan@jinso.co.jp
Subject: Re: [PATCH v5] pwm: renesas-tpu: Add suspend/resume function
Message-ID: <20190527141741.GC7202@ulmo>
References: <1558923757-9843-1-git-send-email-cv-dong@jinso.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline
In-Reply-To: <1558923757-9843-1-git-send-email-cv-dong@jinso.co.jp>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2019 at 11:22:37AM +0900, Cao Van Dong wrote:
> This patch adds suspend/resume function support for Renesas the 16-Bit Ti=
mer
> Pulse Unit (TPU) driver. This has been tested on the Salvator-XS board=20
> with R-Car M3-N and H3 at renesas-drivers-2019-05-21-v5.2-rc1 tag.
> I expect this to work on other SoCs.
>=20
> Test procedure:
>   - Enable TPU and pin control in DTS.
>   - Make sure switches { SW29-[1-2] are switched off or=20
>     SW31-[1-4] are switched off(only for Salvator-xs) }.
>   - Exercise userspace PWM control for pwm[2,3]=20
>     of /sys/class/pwm/pwmchip1/ .
>   - Inspect PWM signals on the input side of { CN29-[58,60]=20
>     or SW31-[1,2] (only for Salvator-xs) }
>     before and after suspend/resume using an oscilloscope.=20
>=20
> Signed-off-by: Cao Van Dong <cv-dong@jinso.co.jp>
> Tested-by: Cao Van Dong <cv-dong@jinso.co.jp>
> ---
> Changes v4 -> v5:
>   - Remove test_bit(PWMF_REQUESTED, &pwm->flags) check.
> ---
> Changes v3 -> v4:
>   - Use pwm_is_enabled(pwm) to check channel instead of pwm_get_chip_data=
(&chip->pwms[i]).
>   - Move tpu_pwm_disable() to tpu_pwm_suspend(), tpu_pwm_enable() to tpu_=
pwm_resume().
>   - Remove tpu_pwm_restart_timer() function and remove pm_runtime_get_syn=
c() in tpu_pwm_resume().
> ---
> Changes v2 -> v3:
>   - Changes '3' -> TPU_CHANNEL_MAX in loop.
>   - Remove pm_runtime_put() function in tpu_pwm_suspend() function.
> ---
> Changes v1 -> v2:
>   - Repair the handling code to cover case of using multiple timers.
> ---
>  drivers/pwm/pwm-renesas-tpu.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)

This has been discussed before, but this really shouldn't be done in the
PWM driver. Consumers should really be reconfiguring the PWM upon resume
as appropriate. This is the only way to ensure that everything is
resumed in the proper order.

Most, if not all, consumers already implement suspend/resume that way.
sysfs is the only one that I'm aware of that doesn't.

Since you've been using sysfs to test this, things are slightly more
complicated (i.e. we don't have a consumer driver in the conventional
way). However, you should be able to solve this by implementing
dev_pm_ops for the pwm_class.

Do you think you could give that a try?

Thierry

>=20
> diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
> index 4a855a2..86b7da4 100644
> --- a/drivers/pwm/pwm-renesas-tpu.c
> +++ b/drivers/pwm/pwm-renesas-tpu.c
> @@ -366,6 +366,41 @@ static void tpu_pwm_disable(struct pwm_chip *chip, s=
truct pwm_device *_pwm)
>  	tpu_pwm_timer_stop(pwm);
>  }
> =20
> +#ifdef CONFIG_PM_SLEEP
> +static int tpu_pwm_suspend(struct device *dev)
> +{
> +	struct tpu_device *tpu =3D dev_get_drvdata(dev);
> +	struct pwm_chip *chip =3D &tpu->chip;
> +	struct pwm_device *pwm;
> +	int i;
> +
> +	for (i =3D 0; i < TPU_CHANNEL_MAX; i++) {
> +		pwm =3D &chip->pwms[i];
> +		if (pwm_is_enabled(pwm))
> +			tpu_pwm_disable(pwm->chip, pwm);
> +	}
> +
> +	return 0;
> +}
> +
> +static int tpu_pwm_resume(struct device *dev)
> +{
> +	struct tpu_device *tpu =3D dev_get_drvdata(dev);
> +	struct pwm_chip *chip =3D &tpu->chip;
> +	struct pwm_device *pwm;
> +	int i;
> +
> +	for (i =3D 0; i < TPU_CHANNEL_MAX; i++) {
> +		pwm =3D &chip->pwms[i];
> +		if (pwm_is_enabled(pwm))
> +			tpu_pwm_enable(pwm->chip, pwm);
> +	}
> +
> +	return 0;
> +}
> +#endif /* CONFIG_PM_SLEEP */
> +static SIMPLE_DEV_PM_OPS(tpu_pwm_pm_ops, tpu_pwm_suspend, tpu_pwm_resume=
);
> +
>  static const struct pwm_ops tpu_pwm_ops =3D {
>  	.request =3D tpu_pwm_request,
>  	.free =3D tpu_pwm_free,
> @@ -459,6 +494,7 @@ static struct platform_driver tpu_driver =3D {
>  	.remove		=3D tpu_remove,
>  	.driver		=3D {
>  		.name	=3D "renesas-tpu-pwm",
> +		.pm	=3D &tpu_pwm_pm_ops,
>  		.of_match_table =3D of_match_ptr(tpu_of_table),
>  	}
>  };
> --=20
> 2.7.4
>=20

--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzr8YUACgkQ3SOs138+
s6EKpQ//foUX46nWEuswTh2M7sX5uGiebanMYMMI6aWotjybyrwd1Qeh/apKuarQ
K1uts2J7dLzwPi8AuPFXa/J2D8+iw9f6SYW9jH5NPau/X3dYGd7DpU+3BDuTS8AT
UCZRn10SEY2APW69wYBEqMtN9cXUiU4IKti1xgB1NcpKJQnwo/GKuS4SOyVqR9tr
kxrJ7ryKtMyDZ35mMMbjlfmFrFvEu4osTO/1S2VJzHql9F1EJVKsXPkABu0TjDaA
fQdmSvWGWHhZ7gASkOeDsyH22rnYQIMkCB85XGAdRWF0AlAgBKg+6yDghZJDVpt/
ohZyBH8+aHngnpNK5OtMDmJ0fdMUdOPdWTKcb/a8O/TysLt94o8u3kBISIwxCuu5
6LltTFKqvSu1E2hLvfEIjTgLRydJf1QAyITrf5y4XcnCdDOxbGvko4CcZk0bqQWR
quD0fz4X7sotFcMLlQLNNqahp0ptD419ILWuJhCNgGnR6fFFs9yvT2cIpFufdgUN
PCFWs8jyRg4wB0TvSPXYnRqjAC+TVuoBRz7JCUGbPImyGUYnv6k/prfCMF7ki7ah
du/4CU2FyCg0dhGPw4tSk3v/EOvZBsyat2XcQo5dPgPnqj20kKUbY8MCTqPjcYzK
DMNomPmvI1JeoV3eTC0Owc3gdpRMKHH8NItLCPZvatZa1Dh3HJ0=
=41Rd
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--
