Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8AD6FFE25
	for <lists+linux-pwm@lfdr.de>; Fri, 12 May 2023 02:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239303AbjELAvO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 11 May 2023 20:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjELAvN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 11 May 2023 20:51:13 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DC35BA9
        for <linux-pwm@vger.kernel.org>; Thu, 11 May 2023 17:51:12 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-24dec03ad8fso6729561a91.1
        for <linux-pwm@vger.kernel.org>; Thu, 11 May 2023 17:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683852671; x=1686444671;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FWIVONgsTG8tyZO4czScY/E1DrXruS2jmV8+a09agaU=;
        b=cxGlmx/cWWtA/Xfgqu+3EdMl8RtrZ9p92WkVvYKduWamZ3oID6FHjRXmrNurzk/pLP
         oettecbeyQHggPNkxLl7TlCuFrLRBpV5IG/mRHkI0lw/7f8kIQMekXwYTyMaWSUxvSwQ
         SCuMgsAudVNW7WMXLp46NLTPYbXh5lX+uDKm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683852671; x=1686444671;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FWIVONgsTG8tyZO4czScY/E1DrXruS2jmV8+a09agaU=;
        b=QLjxJPFEKh4ej9bsqRxzizgcaOELqO+GLnt8MT+sEyJSSy25DQpne3uPTIVxsCrx6V
         a4xQFtVNoJop+G0aG1hp372JOCo/W+lGHXI9kJ+eqAAj8LNvwrY82Qsvmz498S3Y4leP
         ulAxUypOiexOEzGfNdxlcxhA6or+mmaapasBiijVl8ctFV1n47nsn/ZIsDLbIWOESUcR
         K3sd4FWOkkEI8FNq9Dm4AwVHWAsfKqyj4i0gAqbxKpEqkXm1V6SVxAKq8o1vslVnHold
         xsah1w6ob2z9778IDWyMmXU7UEDFsf1/AVqjs7xD24j9cW3go6fVTx8r7/wfmDWkxTYA
         A9lg==
X-Gm-Message-State: AC+VfDx1MH7BqzrJwD9vHFh0FeKMOS5ZZH+KNXxVBDV+odFa1gZfWskh
        hE7sYm9Qx5MYj16CP7Y56X1Gxajp51HXri65ztM=
X-Google-Smtp-Source: ACHHUZ483DzJtNlpdjtj0hsX9EbSPSgJHdNkHYSv6/w4A91sZGEAgMvUiK0ffGXDMfA1p+diH8hNlQ==
X-Received: by 2002:a17:90a:890a:b0:250:ce6a:cf1a with SMTP id u10-20020a17090a890a00b00250ce6acf1amr8285772pjn.38.1683852671469;
        Thu, 11 May 2023 17:51:11 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:5c55:153c:a26f:d30f])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902ee4c00b001aafc8cea5fsm6540284plo.148.2023.05.11.17.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 17:51:11 -0700 (PDT)
Date:   Thu, 11 May 2023 17:51:09 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-pwm@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH] pwm: core: Permit unset period when applying
 configuration of disabled PWMs
Message-ID: <ZF2Nfbx+/aKJOk3v@google.com>
References: <20230511181853.185685-1-marex@denx.de>
 <ZF1ZMNBMxLqNI0zh@google.com>
 <52131759-457b-12ba-ef05-b91eafd7d342@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52131759-457b-12ba-ef05-b91eafd7d342@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, May 12, 2023 at 01:32:49AM +0200, Marek Vasut wrote:
> On 5/11/23 23:08, Brian Norris wrote:
> > On Thu, May 11, 2023 at 08:18:53PM +0200, Marek Vasut wrote:
> > > Fixes: ef2bf4997f7d ("pwm: Improve args checking in pwm_apply_state()")
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > ---
> > > Cc: Brian Norris <briannorris@chromium.org>
> > > Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> > > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > Cc: linux-pwm@vger.kernel.org
> > > ---
> > >   drivers/pwm/core.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > > index 3dacceaef4a9b..87252b70f1c81 100644
> > > --- a/drivers/pwm/core.c
> > > +++ b/drivers/pwm/core.c
> > > @@ -510,8 +510,8 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
> > >   	 */
> > >   	might_sleep();
> > > -	if (!pwm || !state || !state->period ||
> > > -	    state->duty_cycle > state->period)
> > > +	if (!pwm || !state || (state->enabled &&
> > > +	    (!state->period || state->duty_cycle > state->period)))
> > >   		return -EINVAL;
> > >   	chip = pwm->chip;
> > 
> > By making the period assertions conditional, you're allowing people to
> > write garbage period values via sysfs. However you fix the (legitimate)
> > bug you point out, you shouldn't regress that.
> 
> I wanted to say, it might be best to fix userspace so that it wouldn't
> export pwmchip and then suspend without configuring it. But (!) this
> actually allows userspace to export pwmchip and that way, block suspend
> completely, because with pwmchip exported and not configured, the system
> just would not suspend. So, yes, this is a legitimate fix for a real bug,
> right ?

It's a real bug, yes. (Quoting myself, "(legitimate) bug you point
out".)

But you're introducing the old one again, so I wouldn't call it a
"legitimate fix."

commit ef2bf4997f7da6efa8540d9cf726c44bf2b863af
[...]
    In particular, I noted that we are now allowing invalid period
    selections, e.g.:

      # echo 1 > /sys/class/pwm/pwmchip0/export
      # cat /sys/class/pwm/pwmchip0/pwm1/period
      100
      # echo 101 > /sys/class/pwm/pwmchip0/pwm1/duty_cycle
      [... driver may or may not reject the value, or trigger some logic bug ...]

The only difference is that we'll still *eventually* reject it somewhere
(probably when we try to enable the PWM), but just not at the
"echo 101 > .../duty_cycle" phase.

> > (Now, that's sounding
> > like we could use some unit tests for the PWM framework...)
> 
> Not just the PWM framework ...
> 
> > You could, for example, also add the bounds checks to
> > drviers/pwm/sysfs.c's period_store().
> > 
> > Or perhaps you could teach the suspend/resume functions to not bother
> > calling pwm_apply_state() on a disabled PWM.
> 
> Right, I think it boils down to -- should this be fixed on the sysfs ABI
> side, or in the pwm core ?

I don't know if I have a strong preference (I haven't tried to write it
out to see what looks cleaner / has the fewest holes), I just would
prefer that this isn't allowed:

      # echo 1 > /sys/class/pwm/pwmchip0/export
      # echo 100 > /sys/class/pwm/pwmchip0/pwm1/period
      ### Should fail with EINVAL:
      # echo 101 > /sys/class/pwm/pwmchip0/pwm1/duty_cycle

Brian
