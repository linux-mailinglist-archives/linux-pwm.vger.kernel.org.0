Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27032235362
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Aug 2020 18:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgHAQcX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 1 Aug 2020 12:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgHAQcX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 1 Aug 2020 12:32:23 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B656C06174A;
        Sat,  1 Aug 2020 09:32:23 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh1so5653586plb.12;
        Sat, 01 Aug 2020 09:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hf4wmlXbM8Y1yfz9A2PpnBfNHx4wDDGWjHytvgX2LxI=;
        b=Bw0nxA/COTG5Slp7a8BT19ay7Kl7PnTXGtZVh1lQcVIbGXWR5QsGE+r+YA5werwNi4
         DkzaLAbdsyVmgw0Q7c1j+IBv+BJx5J6L2K475N/KpG/Pwmp1RJZnVyXtd0A5KsXT8YEx
         6sCvSwapnZagXXME/lTs3c6OYx9nDkSjCBkHaLIFvhVqVSttM7Atk9490M3P07kljHOc
         VuBzEuAHTJyp8gSxTTz8jPurcRQ3K3dOWuuMf3zDs8NyBWN3u8RqF8hUFnu+Epjf+5jF
         hvoKO49faLwnQE0qH1YKwKDnCCTjm1KbFF0PiQ1p60C7lT3FD8ggouqTV1OULsl/matz
         kxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=hf4wmlXbM8Y1yfz9A2PpnBfNHx4wDDGWjHytvgX2LxI=;
        b=mJbNDqZ8BSUzATErG+/fWvqT6XLMZfMH/wd3X3uSk2uJJZe/5nWKZbXGhDEjvg/rFQ
         4T1f14/IZC69/oWUZZ1jk5jCZUoT923yw1NGKxAcEbwRDTdqw8pd6kN00v1vEc1bOM4A
         0sjh7KeFDGy+llE5Y2Qevp/DL4TrSN1mucyTqL+ebWWEjJ66klpNegMcIr8RfrzbzosD
         J0vhrgRydNMcVdLfLzbUpICdSTjH49R2FoF/DMgeGDHIeZsslB/I6LNNQOz09LTiDmca
         LyHmoCp/pEnT9pDdjL72FnUwNyn7GN7VJBv1bSxiMHPRpXDo92FQQFKbhD2vCKa8Ust1
         PGhg==
X-Gm-Message-State: AOAM530A1CzFz7OXdy3BzQ8aC5+Lf6UaAS7Wy5O6hQknsP3pFtjvtKR9
        HCM8CRZre9AP0SElP/jy688=
X-Google-Smtp-Source: ABdhPJzN4tP6ZRTtNtqh69LTmOfZNNBAZvVVlURQwpZDqwti5NjmrMd2FcsPDVoZ6iQEQrjm3HzGxQ==
X-Received: by 2002:a17:90a:2723:: with SMTP id o32mr8975915pje.97.1596299542624;
        Sat, 01 Aug 2020 09:32:22 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p10sm14252739pgn.6.2020.08.01.09.32.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Aug 2020 09:32:21 -0700 (PDT)
Date:   Sat, 1 Aug 2020 09:32:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH v3 4/6] pwm: cros-ec: Accept more error codes from
 cros_ec_cmd_xfer_status
Message-ID: <20200801163219.GA230759@roeck-us.net>
References: <20200726220101.29059-1-linux@roeck-us.net>
 <20200726220101.29059-5-linux@roeck-us.net>
 <20200801072130.tmm7b4vtizshmmyo@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200801072130.tmm7b4vtizshmmyo@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Aug 01, 2020 at 09:21:30AM +0200, Uwe Kleine-König wrote:
> On Sun, Jul 26, 2020 at 03:00:59PM -0700, Guenter Roeck wrote:
> > Since commit c5cd2b47b203 ("platform/chrome: cros_ec_proto: Report command
> > not supported") we can no longer assume that cros_ec_cmd_xfer_status()
> > reports -EPROTO for all errors returned by the EC itself. A follow-up
> > patch will change cros_ec_cmd_xfer_status() to report additional errors
> > reported by the EC as distinguished Linux error codes.
> > 
> > Handle this change by no longer assuming that only -EPROTO is used
> > to report all errors returned by the EC itself. Instead, support both
> > the old and the new error codes.
> > 
> > Cc: Gwendal Grignou <gwendal@chromium.org>
> > Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> > Cc: Prashant Malani <pmalani@chromium.org>
> > Cc: Brian Norris <briannorris@chromium.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > v3: Added patch
> > 
> >  drivers/pwm/pwm-cros-ec.c | 21 ++++++++++++++-------
> >  1 file changed, 14 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
> > index 09c08dee099e..ef05fba1bd37 100644
> > --- a/drivers/pwm/pwm-cros-ec.c
> > +++ b/drivers/pwm/pwm-cros-ec.c
> > @@ -213,20 +213,27 @@ static int cros_ec_num_pwms(struct cros_ec_device *ec)
> >  		u32 result = 0;
> >  
> >  		ret = __cros_ec_pwm_get_duty(ec, i, &result);
> > -		/* We want to parse EC protocol errors */
> > -		if (ret < 0 && !(ret == -EPROTO && result))
> > -			return ret;
> > -
> >  		/*
> >  		 * We look for SUCCESS, INVALID_COMMAND, or INVALID_PARAM
> >  		 * responses; everything else is treated as an error.
> >  		 */
> 
> This comment is at least misleading now.
> 
Good point. I'll rephrase.

> > -		if (result == EC_RES_INVALID_COMMAND)
> > +		switch (ret) {
> > +		case -EOPNOTSUPP:	/* invalid command */
> >  			return -ENODEV;
> 
> My first reaction here was to wonder why -EOPNOTSUPP isn't passed to the
> upper layer. OK, this is a loop to test the number of available devices.
> 
I'll be happy to add a comment.

> > -		else if (result == EC_RES_INVALID_PARAM)
> > +		case -EINVAL:		/* invalid parameter */
> >  			return i;
> > -		else if (result)
> > +		case -EPROTO:
> > +			/* Old or new error return code: Handle both */
> > +			if (result == EC_RES_INVALID_COMMAND)
> > +				return -ENODEV;
> > +			else if (result == EC_RES_INVALID_PARAM)
> > +				return i;
> 
> If I understand correctly this surprising calling convention (output
> parameter is filled even though the function returned an error) is the
> old one that is to be fixed.
> 
Sorry, I don't get your point. This is the old convention, correct,
which we still want to support at this point. Plus, it matches the
current code, as surprosing as it may be.

Guenter

> >  			return -EPROTO;
> > +		default:
> > +			if (ret < 0)
> > +				return ret;
> > +			break;
> > +		}
> >  	}
> >  
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |


