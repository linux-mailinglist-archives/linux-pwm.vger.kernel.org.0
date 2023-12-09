Return-Path: <linux-pwm+bounces-474-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 150A780B379
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Dec 2023 10:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0761C20997
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Dec 2023 09:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E9911706;
	Sat,  9 Dec 2023 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="I1ET6nwY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38B810C4;
	Sat,  9 Dec 2023 01:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1702115391; bh=K4v35Dp8Lp3NPnkhtZ9R6FJpo7oiN2Hzlx29IfU2Lq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I1ET6nwYmIPj1dDOlJ36cuv6adMCSee+/l3bvMCLtEZVJ3gsKIvTkgWpvUyf4/ydw
	 CGstHQFag5r1HK6Ftg6STvHYYVV2iTxngtTBcs5UDam5c9d53JE4Z5TzmbLJ5pyyA3
	 mariSQplhWY+wSwgFCLalvfeRztZooSqtT2s5r0altoeoNl8tTgXkQ09atOVR7mLsm
	 nZYM0UNi0mHCJ4iNfZBqMg0bpb67Qn22K0ZJJ4W09VbwU3fDZid9ynlvX2K6rPGB8A
	 5yqzXwpbcGepDvmlvCc/F1FCV6G/xfzG8oGHxmesi7f6GKT4sekIMzJjC2kufb4kXw
	 dCEcayhOICYsg==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id 9697B100091; Sat,  9 Dec 2023 09:49:51 +0000 (GMT)
Date: Sat, 9 Dec 2023 09:49:51 +0000
From: Sean Young <sean@mess.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/4] pwm: make it possible to apply pwm changes in
 atomic context
Message-ID: <ZXQ4P39_sq10XD9u@gofer.mess.org>
References: <cover.1701248996.git.sean@mess.org>
 <734c9985a6f54d34d9ef20203ba7f962b572cb45.1701248996.git.sean@mess.org>
 <ZXNCKFZcjFznko89@orome.fritz.box>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXNCKFZcjFznko89@orome.fritz.box>

Hi Thierry,


On Fri, Dec 08, 2023 at 05:19:52PM +0100, Thierry Reding wrote:
> On Wed, Nov 29, 2023 at 09:13:35AM +0000, Sean Young wrote:
> > Some pwm devices require sleeping, for example if the pwm device is
> > connected over i2c. However, many pwm devices could be used from atomic
> > context, e.g. memmory mapped pwm. This is useful for, for example, the
> > pwm-ir-tx driver which requires precise timing. Sleeping causes havoc
> > with the generated IR signal.
> > 
> > Since not all pmw devices can support atomic context, we also add a
> > pwm_is_atomic() function to check if it is supported.
> 
> s/i2c/I2C/ and s/pwm/PWM/ in the above. Also, s/memmory/memory/

Thanks for your detailed review. I agree with all your points, they are
all nice improvements. Just a question at the bottom:

> 
> > 
> > Signed-off-by: Sean Young <sean@mess.org>
> > ---
> >  Documentation/driver-api/pwm.rst |  9 +++++
> >  drivers/pwm/core.c               | 63 ++++++++++++++++++++++++++------
> >  drivers/pwm/pwm-renesas-tpu.c    |  1 -
> >  include/linux/pwm.h              | 29 ++++++++++++++-
> >  4 files changed, 87 insertions(+), 15 deletions(-)
> > 
> > diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/pwm.rst
> > index f1d8197c8c43..1d4536fdf47c 100644
> > --- a/Documentation/driver-api/pwm.rst
> > +++ b/Documentation/driver-api/pwm.rst
> > @@ -43,6 +43,15 @@ After being requested, a PWM has to be configured using::
> >  
> >  	int pwm_apply_might_sleep(struct pwm_device *pwm, struct pwm_state *state);
> >  
> > +Some PWM devices can be used from atomic context. You can check if this is
> > +supported with::
> > +
> > +        bool pwm_is_atomic(struct pwm_device *pwm);
> 
> This is now going to look a bit odd. I think it'd be best to change this
> to pwm_might_sleep() for consistency with the pwm_apply_might_sleep()
> function. Fine to keep the actual member variable as atomic, though, so
> we don't have to change the default for all drivers.

Agreed, I was struggling with finding good name and yours is much better,
thanks.

 > +{
> > +	return pwm->chip->atomic;
> > +}
> > +
> >  /* PWM provider APIs */
> >  int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
> >  		unsigned long timeout);
> > @@ -406,16 +420,27 @@ struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
> >  				       struct fwnode_handle *fwnode,
> >  				       const char *con_id);
> >  #else
> > +static inline bool pwm_is_atomic(struct pwm_device *pwm)
> > +{
> > +	return false;
> > +}
> > +
> >  static inline int pwm_apply_might_sleep(struct pwm_device *pwm,
> >  					const struct pwm_state *state)
> >  {
> >  	might_sleep();
> > -	return -ENOTSUPP;
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +static inline int pwm_apply_atomic(struct pwm_device *pwm,
> > +				   const struct pwm_state *state)
> > +{
> > +	return -EOPNOTSUPP;
> >  }
> >  
> >  static inline int pwm_adjust_config(struct pwm_device *pwm)
> >  {
> > -	return -ENOTSUPP;
> > +	return -EOPNOTSUPP;
> >  }
> 
> What's wrong with ENOTSUPP?

This was found by checkpatch, see

https://github.com/torvalds/linux/blob/master/scripts/checkpatch.pl#L4891-L4892

# ENOTSUPP is not a standard error code and should be avoided in new patches.
# Folks usually mean EOPNOTSUPP (also called ENOTSUP), when they type ENOTSUPP.

ENOTSUPP is not really widely used in the tree.

So it was really done to keep checkpatch happy, please let me know what you
would like me to do here.

Thanks,

Sean

