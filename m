Return-Path: <linux-pwm+bounces-877-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738CB836B89
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jan 2024 17:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F8431C24B4B
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jan 2024 16:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46113FE3F;
	Mon, 22 Jan 2024 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rV7rGxU9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAB83FE3B
	for <linux-pwm@vger.kernel.org>; Mon, 22 Jan 2024 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936806; cv=none; b=CeBQj4s+FgRW0QNLSU2VfrcAi5ZvVmE2EdEiJLN9yYnCBiHO30uRzxxlmNY2CxSva9zBPj1nOMjMFHcb68gWBA7VQop789i5l/KbK2rc7+phfRFPuYxtWMWDvOCk2DzvYDa8k096EfnbOCjVfdfWmwSVdfEvSn0z3haKzVmZS5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936806; c=relaxed/simple;
	bh=SXUPVZkJmcierNdtKqvg9SmUNHeTPRtiZts/xJRvssk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ips+FIGDxyVipeqmyvG4D7Fx7OYrX2cMmAGxvBAvJ8XlxSOwh6cs5FPVimooECUGHjAenlrqGpJR2Qf1nmCNhOuxFSwt545G9PUM1tr8XEY2rjVHdm2h7AQVtCGGvCulBz1xaYt9jISRRVGttYvd/1P/YXUy6g2xjH6q5F/yMXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rV7rGxU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A54C43330
	for <linux-pwm@vger.kernel.org>; Mon, 22 Jan 2024 15:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936806;
	bh=SXUPVZkJmcierNdtKqvg9SmUNHeTPRtiZts/xJRvssk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rV7rGxU92XXwycgUGJw7K4cnzR088p6xQt3GeF0u42UV8it4WfI/TQVkK6f3YEDPR
	 bygxas0sFl8gF3YUTiuDLBQT0pY1RdyU6ATXhDMRThgrOGgoqFzEFd0AkCshx7ClBK
	 4G2iXtwl8IlyhM33mvX3O2mwdL5H7Z6ZUKhVlrmKq5SeDtOQ59k+9LHkXKlSMynBz7
	 cJvRQEKrsi77S0BOWh9k3JDrV0nWxgTF1WikQChLAnZ9/0wO7ztG5RUpBZywzb9Bz6
	 MhD63oQN33YPpsV8HcK8tR5sMEJaMmkajO5egAK+6CT0+rXZMsSj2p208Jhi4TVDpO
	 cpjXU1vqThWcg==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5f0629e67f4so32265277b3.3
        for <linux-pwm@vger.kernel.org>; Mon, 22 Jan 2024 07:20:06 -0800 (PST)
X-Gm-Message-State: AOJu0YxX08hrcY5pMtU19/Mmg9kvNkOdaE6sxLFS2rlspEpe+LsAg6iC
	J0Vj+zLJzozvCWKl0dG7tX0+NDqsKG841yy21p5l+0xRTnKuhnL7hf1TeEtvnBujWwkzs8eHb6N
	J1ZEo3cuyoS4NFmKSOJ+LwOs2qZNIr1pwhCkRCA==
X-Google-Smtp-Source: AGHT+IHR9EW9F+L1o9xTG0NWnaQNNaPen2WULRKl2Ey5mTjdWB7qIXk9iNSTyKGEeFaaFtAETMuRe2rPCt8bmP5ufzo=
X-Received: by 2002:a81:a1d5:0:b0:5ff:850e:ca42 with SMTP id
 y204-20020a81a1d5000000b005ff850eca42mr3334295ywg.4.1705936805503; Mon, 22
 Jan 2024 07:20:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701860672.git.u.kleine-koenig@pengutronix.de> <3a67fffe50fe267b612d5557bb6b790ff1a792ca.1701860672.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <3a67fffe50fe267b612d5557bb6b790ff1a792ca.1701860672.git.u.kleine-koenig@pengutronix.de>
From: Robert Foss <rfoss@kernel.org>
Date: Mon, 22 Jan 2024 16:19:54 +0100
X-Gmail-Original-Message-ID: <CAN6tsi6iDsoTpNS7e0XCTf-2RM924za+B7_z9HL+xRR430jjjg@mail.gmail.com>
Message-ID: <CAN6tsi6iDsoTpNS7e0XCTf-2RM924za+B7_z9HL+xRR430jjjg@mail.gmail.com>
Subject: Re: [PATCH v4 107/115] drm/bridge: ti-sn65dsi86: Make use of
 devm_pwmchip_alloc() function
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, kernel@pengutronix.de, 
	Jonas Karlman <jonas@kwiboo.se>, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
	Douglas Anderson <dianders@chromium.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	linux-pwm@vger.kernel.org, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Andrzej Hajda <andrzej.hajda@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 12:49=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> This prepares the pwm driver of the ti-sn65dsi86 to further changes of
> the pwm core outlined in the commit introducing devm_pwmchip_alloc().
> There is no intended semantical change and the driver should behave as
> before.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi86.c
> index c45c07840f64..33eb2ed0a729 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -197,7 +197,7 @@ struct ti_sn65dsi86 {
>         DECLARE_BITMAP(gchip_output, SN_NUM_GPIOS);
>  #endif
>  #if defined(CONFIG_PWM)
> -       struct pwm_chip                 pchip;
> +       struct pwm_chip                 *pchip;
>         bool                            pwm_enabled;
>         atomic_t                        pwm_pin_busy;
>  #endif
> @@ -1372,7 +1372,7 @@ static void ti_sn_pwm_pin_release(struct ti_sn65dsi=
86 *pdata)
>
>  static struct ti_sn65dsi86 *pwm_chip_to_ti_sn_bridge(struct pwm_chip *ch=
ip)
>  {
> -       return container_of(chip, struct ti_sn65dsi86, pchip);
> +       return pwmchip_get_drvdata(chip);
>  }
>
>  static int ti_sn_pwm_request(struct pwm_chip *chip, struct pwm_device *p=
wm)
> @@ -1585,22 +1585,31 @@ static const struct pwm_ops ti_sn_pwm_ops =3D {
>  static int ti_sn_pwm_probe(struct auxiliary_device *adev,
>                            const struct auxiliary_device_id *id)
>  {
> +       struct pwm_chip *chip;
>         struct ti_sn65dsi86 *pdata =3D dev_get_drvdata(adev->dev.parent);
>
> -       pdata->pchip.dev =3D pdata->dev;
> -       pdata->pchip.ops =3D &ti_sn_pwm_ops;
> -       pdata->pchip.npwm =3D 1;
> -       pdata->pchip.of_xlate =3D of_pwm_single_xlate;
> -       pdata->pchip.of_pwm_n_cells =3D 1;
> +       /*
> +        * This should better use adev->dev instead of pdata->dev. See
> +        * https://lore.kernel.org/dri-devel/20231127101547.734061-2-u.kl=
eine-koenig@pengutronix.de
> +        */
> +       pdata->pchip =3D chip =3D devm_pwmchip_alloc(pdata->dev, 1, 0);
> +       if (IS_ERR(chip))
> +               return PTR_ERR(chip);
>
> -       return pwmchip_add(&pdata->pchip);
> +       pwmchip_set_drvdata(chip, pdata);
> +
> +       chip->ops =3D &ti_sn_pwm_ops;
> +       chip->of_xlate =3D of_pwm_single_xlate;
> +       chip->of_pwm_n_cells =3D 1;
> +
> +       return pwmchip_add(chip);
>  }
>
>  static void ti_sn_pwm_remove(struct auxiliary_device *adev)
>  {
>         struct ti_sn65dsi86 *pdata =3D dev_get_drvdata(adev->dev.parent);
>
> -       pwmchip_remove(&pdata->pchip);
> +       pwmchip_remove(pdata->pchip);
>
>         if (pdata->pwm_enabled)
>                 pm_runtime_put_sync(pdata->dev);
> --
> 2.42.0
>

Acked-by: Robert Foss <rfoss@kernel.org>

