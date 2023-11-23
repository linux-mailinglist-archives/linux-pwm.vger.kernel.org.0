Return-Path: <linux-pwm+bounces-168-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627B17F5C2B
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 11:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E49281721
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 10:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA360224E7;
	Thu, 23 Nov 2023 10:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcUCA1OJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC71224C2;
	Thu, 23 Nov 2023 10:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78CEC433C7;
	Thu, 23 Nov 2023 10:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700734877;
	bh=Mx8OxIizhyT66AtyfB908usr8wqSONtkBJqHyFIRXX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YcUCA1OJWB1cgWnPzkxoWJEKEqF5KRwQsg4Zm/s2mNgzzORb4a7Kx43uUb53rudrd
	 SNf06WO/iMQHO9U/wxb7Dazh6gW8vgeihSPnvpeaJauN8UgQfIYursZm19eO4okNVt
	 SOGfnwDUSPtpGANoNVP2dj0Vkap3nOuAc15vNSQqe482pAHUkBdtcL3DHgCKx+//7a
	 iy3MA5h6iTBxnJPeF1wNXo6/rObT2i5gAYXw8EXaJTFSE4rtZmRYvVtv6rHogrFN4i
	 LXuQR0EmdyyOBWrLHOyraXFtsXyk5HywnC78OMrpj5GJbD4wB3dDeS89V3B/rwHzj/
	 VCgouCmVNXvSw==
Date: Thu, 23 Nov 2023 10:21:11 +0000
From: Lee Jones <lee@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Kees Cook <keescook@chromium.org>, linux-pwm@vger.kernel.org,
	Luca Weiss <luca@z3ntu.xyz>,
	Conor Dooley <conor.dooley@microchip.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
	kernel@pengutronix.de,
	Anjelique Melendez <quic_amelende@quicinc.com>
Subject: Re: [PATCH v3 102/108] leds: qcom-lpg: Make use of
 devm_pwmchip_alloc() function
Message-ID: <20231123102111.GB1184245@google.com>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-103-u.kleine-koenig@pengutronix.de>
 <20231122115621.GK173820@google.com>
 <20231122175413.5yxsdveausehkbgm@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231122175413.5yxsdveausehkbgm@pengutronix.de>

On Wed, 22 Nov 2023, Uwe Kleine-König wrote:

> Hello Lee,
> 
> On Wed, Nov 22, 2023 at 11:56:21AM +0000, Lee Jones wrote:
> > On Tue, 21 Nov 2023, Uwe Kleine-König wrote:
> > 
> > > This prepares the pwm sub-driver to further changes of the pwm core
> > > outlined in the commit introducing devm_pwmchip_alloc(). There is no
> > > intended semantical change and the driver should behave as before.
> > > 
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/leds/rgb/leds-qcom-lpg.c | 30 +++++++++++++++++++++---------
> > >  1 file changed, 21 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
> > > index 68d82a682bf6..283227e02df6 100644
> > > --- a/drivers/leds/rgb/leds-qcom-lpg.c
> > > +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> > > @@ -77,7 +77,7 @@ struct lpg {
> > >  
> > >  	struct mutex lock;
> > >  
> > > -	struct pwm_chip pwm;
> > > +	struct pwm_chip *pwm;
> > >  
> > >  	const struct lpg_data *data;
> > >  
> > > @@ -977,9 +977,15 @@ static int lpg_pattern_mc_clear(struct led_classdev *cdev)
> > >  	return lpg_pattern_clear(led);
> > >  }
> > >  
> > > +static inline struct lpg *lpg_pwm_from_chip(struct pwm_chip *chip)
> > > +{
> > > +	struct lpg **lpg = pwmchip_priv(chip);
> > > +	return *lpg;
> > > +}
> > 
> > I don't have easy-vis into the other patches, but if this is a common
> > pattern, perhaps add a generic helper in <linux/pwm.h>?
> > 
> > >  static int lpg_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> > >  {
> > > -	struct lpg *lpg = container_of(chip, struct lpg, pwm);
> > > +	struct lpg *lpg = lpg_pwm_from_chip(chip);
> > >  	struct lpg_channel *chan = &lpg->channels[pwm->hwpwm];
> > >  
> > >  	return chan->in_use ? -EBUSY : 0;
> > > [...]
> > > @@ -1089,13 +1095,19 @@ static const struct pwm_ops lpg_pwm_ops = {
> > >  
> > >  static int lpg_add_pwm(struct lpg *lpg)
> > >  {
> > > +	struct pwm_chip *chip;
> > >  	int ret;
> > >  
> > > -	lpg->pwm.dev = lpg->dev;
> > > -	lpg->pwm.npwm = lpg->num_channels;
> > > -	lpg->pwm.ops = &lpg_pwm_ops;
> > > +	lpg->pwm = chip = devm_pwmchip_alloc(lpg->dev, lpg->num_channels,
> > > +					     sizeof(&lpg));
> > > +	if (IS_ERR(chip))
> > > +		return PTR_ERR(chip);
> > >  
> > > -	ret = pwmchip_add(&lpg->pwm);
> > > +	*(struct lpg **)pwmchip_priv(chip) = lpg;
> > 
> > This is vile!
> 
> This is indeed one of the uglier conversions. It gets a bit prettier
> with the following addon patch:
> 
> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
> index 283227e02df6..e09eba823057 100644
> --- a/drivers/leds/rgb/leds-qcom-lpg.c
> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> @@ -206,6 +206,10 @@ struct lpg_data {
>  	const struct lpg_channel_data *channels;
>  };
>  
> +struct lpg_pwm_data {
> +	struct lpg *lpg;
> +};
> +
>  static int triled_set(struct lpg *lpg, unsigned int mask, unsigned int enable)
>  {
>  	/* Skip if we don't have a triled block */
> @@ -979,8 +983,9 @@ static int lpg_pattern_mc_clear(struct led_classdev *cdev)
>  
>  static inline struct lpg *lpg_pwm_from_chip(struct pwm_chip *chip)
>  {
> -	struct lpg **lpg = pwmchip_priv(chip);
> -	return *lpg;
> +	struct lpg_pwm_data *lpg_pwm_data = pwmchip_priv(chip);
> +
> +	return lpg_pwm_data->lpg;
>  }
>  
>  static int lpg_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> @@ -1096,14 +1101,16 @@ static const struct pwm_ops lpg_pwm_ops = {
>  static int lpg_add_pwm(struct lpg *lpg)
>  {
>  	struct pwm_chip *chip;
> +	struct lpg_pwm_data *lpg_pwm_data;
>  	int ret;
>  
>  	lpg->pwm = chip = devm_pwmchip_alloc(lpg->dev, lpg->num_channels,
> -					     sizeof(&lpg));
> +					     sizeof(*lpg_pwm_data));
>  	if (IS_ERR(chip))
>  		return PTR_ERR(chip);
>  
> -	*(struct lpg **)pwmchip_priv(chip) = lpg;
> +	lpg_pwm_data = pwmchip_priv(chip);
> +	lpg_pwm_data->lpg = lpg;
>  
>  	chip->ops = &lpg_pwm_ops;
>  
> Would you like it better then?

It's definitely nicer to read and more in-line with the style I expect,
but the additional wrapper/abstraction layer is still bothersome.

-- 
Lee Jones [李琼斯]

