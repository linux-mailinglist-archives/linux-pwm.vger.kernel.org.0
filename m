Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BE71EED87
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Jun 2020 23:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgFDVwD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 4 Jun 2020 17:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbgFDVwD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 4 Jun 2020 17:52:03 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7A4C08C5C0
        for <linux-pwm@vger.kernel.org>; Thu,  4 Jun 2020 14:52:02 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a127so3860849pfa.12
        for <linux-pwm@vger.kernel.org>; Thu, 04 Jun 2020 14:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AVPTbQ8NFmXxqrUWzxefqxjRddWDIP1x9mYNjqrmPjE=;
        b=nvCBfgRFWPPl3m6Bthhk0OWoXZRMMIM+TK/2J+9C4SQ0piWaVE9ZVnk8WiFbpsbRT/
         /g29RqVU8fUG9ThA2iqChW/8MiSP+ZFwEPslOSU0ICuby2DV5HBeUOs5LDQMbQDatIgj
         6uG1WrRWePfyjCUmkYEfSxiAWCdHEBunPK80I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AVPTbQ8NFmXxqrUWzxefqxjRddWDIP1x9mYNjqrmPjE=;
        b=N0lIl3UBYOftsA9w5/KojQvXlG8Gn4cRAdbdbRpH6rP3m6HN+t42iB7RYAecu4HSRM
         mcv1MXULARlzh8c4iKKbQJhrq3NG+kvYh6hypXcXeshMOP6+WEL5N3kcsppMv44dsGOP
         eylYuyNPNOAGcUYXA96q/msuWfHfUshF74wIZH3le7XMP9Devma9cfqTEqhV5GTqFml/
         nZ/cbb2ikqZ+UBxOHwZENA506GXmbmpIvqAtnDgYvtstS1DFD50l7YfFfLP124qX4sDn
         VNEYzkXIwRIP4DXyoVFFX4XVFJk28RMTwTAzzfbV/wIPczOhZQP0Xydqq+Ha1oLYOlyq
         1Axg==
X-Gm-Message-State: AOAM531XLgR2Sk1wTWLOoS/Ya8bV0k4V2giaPSIhwQg6M2hLxYmxWXcB
        7sS8VtURKnCH/fxmEK2ThNK0NOjXyo13ZQ==
X-Google-Smtp-Source: ABdhPJzl+XR3LgR5r+6XiLd36g6PDrxYDguA3/nHf6QujkMv8ETocNSKltDFZQ8341Fl+XxZA922iw==
X-Received: by 2002:a63:d918:: with SMTP id r24mr6439147pgg.119.1591307522152;
        Thu, 04 Jun 2020 14:52:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z138sm5469147pfc.70.2020.06.04.14.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 14:52:01 -0700 (PDT)
Date:   Thu, 4 Jun 2020 14:52:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] pwm: Add missing "CONFIG_" prefix
Message-ID: <202006041451.19491ECA@keescook>
References: <202006031539.4198EA6@keescook>
 <b08611018fdb6d88757c6008a5c02fa0e07b32fb.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b08611018fdb6d88757c6008a5c02fa0e07b32fb.camel@perches.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Jun 03, 2020 at 04:04:31PM -0700, Joe Perches wrote:
> On Wed, 2020-06-03 at 15:40 -0700, Kees Cook wrote:
> > The IS_ENABLED() use was missing the CONFIG_ prefix which would have
> > lead to skipping this code.
> > 
> > Fixes: 3ad1f3a33286 ("pwm: Implement some checks for lowlevel drivers")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/pwm/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index 9973c442b455..6b3cbc0490c6 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -121,7 +121,7 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
> >  		pwm->chip->ops->get_state(pwm->chip, pwm, &pwm->state);
> >  		trace_pwm_get(pwm, &pwm->state);
> >  
> > -		if (IS_ENABLED(PWM_DEBUG))
> > +		if (IS_ENABLED(CONFIG_PWM_DEBUG))
> >  			pwm->last = pwm->state;
> >  	}
> >  
> > -- 
> > 2.25.1
> > 
> 
> more odd uses (mostly in comments)
> 
> $ git grep -P -oh '\bIS_ENABLED\s*\(\s*\w+\s*\)'| \
>   sed -r 's/\s+//g'| \
>   grep -v '(CONFIG_' | \
>   sort | uniq -c | sort -rn
>       7 IS_ENABLED(DEBUG)
>       4 IS_ENABLED(DRM_I915_SELFTEST)
>       4 IS_ENABLED(cfg)
>       2 IS_ENABLED(opt_name)
>       2 IS_ENABLED(DEBUG_PRINT_TRIE_GRAPHVIZ)
>       2 IS_ENABLED(config)
>       2 IS_ENABLED(cond)
>       2 IS_ENABLED(__BIG_ENDIAN)
>       1 IS_ENABLED(x)
>       1 IS_ENABLED(STRICT_KERNEL_RWX)
>       1 IS_ENABLED(PWM_DEBUG)
>       1 IS_ENABLED(option)
>       1 IS_ENABLED(ETHTOOL_NETLINK)
>       1 IS_ENABLED(DEBUG_RANDOM_TRIE)
>       1 IS_ENABLED(DEBUG_CHACHA20POLY1305_SLOW_CHUNK_TEST)
> 
> STRICT_KERNEL_RWX is misused here in ppc
> 
> ---
> 
> Fix pr_warn without newline too.
> 
>  arch/powerpc/mm/book3s64/hash_utils.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
> index 51e3c15f7aff..dd60c5f2b991 100644
> --- a/arch/powerpc/mm/book3s64/hash_utils.c
> +++ b/arch/powerpc/mm/book3s64/hash_utils.c
> @@ -660,11 +660,10 @@ static void __init htab_init_page_sizes(void)
>  		 * Pick a size for the linear mapping. Currently, we only
>  		 * support 16M, 1M and 4K which is the default
>  		 */
> -		if (IS_ENABLED(STRICT_KERNEL_RWX) &&
> +		if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX) &&
>  		    (unsigned long)_stext % 0x1000000) {
>  			if (mmu_psize_defs[MMU_PAGE_16M].shift)
> -				pr_warn("Kernel not 16M aligned, "
> -					"disabling 16M linear map alignment");
> +				pr_warn("Kernel not 16M aligned, disabling 16M linear map alignment\n");
>  			aligned = false;
>  		}

Joe, I was going to send all of the fixes for these issues, but your
patch doesn't have a SoB. Shall I add one for the above patch?

-- 
Kees Cook
