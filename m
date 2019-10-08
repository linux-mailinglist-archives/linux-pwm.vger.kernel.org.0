Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B65ECF75E
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2019 12:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbfJHKnS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Oct 2019 06:43:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39031 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730389AbfJHKnR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Oct 2019 06:43:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id v17so2584449wml.4
        for <linux-pwm@vger.kernel.org>; Tue, 08 Oct 2019 03:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kNT0uravG5d+lNDf6zaLGqaWiN2XpE5JXyYmizVBilE=;
        b=K9H4eDofUQAKZFM6o8SaI1fDGTLc4h7zvLiQ1+kb/3hl9KTydNTP7sOmaT6ZOvOy+h
         qCDq8mzBa37VmuqcmWj5VvjaBvps+QwcM68guyWqS7cr9uaOY134H4lb7mkzoSRr4Buc
         MoeRrevZYD2M/FEAhj2Pmft/ekWeOstHP3Qd7drNLISZ3UzzZWZWJrRbTlsAaqGTlbMn
         zlC88mSLkqFcvForhTUElc0Tk8aobntBt2kXJ7UPWhnu9ZKaS1Q5JYKqELXmOkI4xbf4
         4yCCbqemhFWRxC1rFNomOZHXO8jgNt7JK20q4ZEL/O60BOBasjqAhiJtzqMKkGJNHJHP
         hZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kNT0uravG5d+lNDf6zaLGqaWiN2XpE5JXyYmizVBilE=;
        b=ddS/n5aXNlmOH+WSYVTG3Kh89iY4Ti+tyZTXNFyAaEJpZ8CUpZcSgDdFdLJvVAPKEN
         2gZKrumc0uhotpQ6qizSwZhlFLptPZxjYz17XpvJae0MeRxa4vPRWdSqXo58QVnBg3ei
         hUzDE2a8zphte6/NAVvwrrLJdK3uFictvdRKP9QibWkZ+ScKxjrcsNeXZkuxhjlYE5+T
         MpBwjyWTn4QsIGaZjnkOTKyForDnpuPbFD7IrnHjIhoOH915sxp8hWUQgQYWceaMTkQX
         ICM/Jb0FQhQvL1MH3ybkNuUSCBFhkK35IDqpLdt8ze2HtUTqvlDwGECMnLGAeRJzRCoz
         FVxQ==
X-Gm-Message-State: APjAAAUcWNzEhBaJTFsW645Qye9DMJvj21CTUJ9ObDvhvZRbIdm30y0C
        DbKm/2PnGaAC90zoXjty8cs/aA==
X-Google-Smtp-Source: APXvYqwDdhuAhHaQJXOqUmc7Qcgp2Qnp21uhE7Cr0GMQdE2+Bt2iLHZCWbFgdquKZmjYilbrPc3XeA==
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr3278073wmk.145.1570531394197;
        Tue, 08 Oct 2019 03:43:14 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id b62sm4548867wmc.13.2019.10.08.03.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 03:43:13 -0700 (PDT)
Date:   Tue, 8 Oct 2019 11:43:11 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] backlight: pwm_bl: drop use of int_pow()
Message-ID: <20191008104311.s4k5syr7gd7tb55w@holly.lan>
References: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
 <20190919140620.32407-3-linux@rasmusvillemoes.dk>
 <20191007152800.3nhbf7h7knumriz4@holly.lan>
 <5f19e307-29c4-f077-568d-b2bd6ae74608@rasmusvillemoes.dk>
 <20191008093145.kgx6ytkbycmmkist@holly.lan>
 <9bf6baf9-46be-771c-7e26-527b117c998a@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bf6baf9-46be-771c-7e26-527b117c998a@rasmusvillemoes.dk>
User-Agent: NeoMutt/20180716
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Oct 08, 2019 at 12:02:07PM +0200, Rasmus Villemoes wrote:
> On 08/10/2019 11.31, Daniel Thompson wrote:
> > On Mon, Oct 07, 2019 at 08:43:31PM +0200, Rasmus Villemoes wrote:
> >> On 07/10/2019 17.28, Daniel Thompson wrote:
> >>> On Thu, Sep 19, 2019 at 04:06:18PM +0200, Rasmus Villemoes wrote:
> >>>
> >>> It feels like there is some rationale missing in the description here.
> >>>
> >>
> >> Apart from the function call overhead (and resulting register pressure
> >> etc.), using int_pow is less efficient (for an exponent of 3, it ends up
> >> doing four 64x64 multiplications instead of just two). But feel free to
> >> drop it, I'm not going to pursue it further - it just seemed like a
> >> sensible thing to do while I was optimizing the code anyway.
> >>
> >> [At the time I wrote the patch, this was also the only user of int_pow
> >> in the tree, so it also allowed removing int_pow altogether.]
> > 
> > To be honest the change is fine but the patch description doesn't make
> > sense if the only current purpose of the patch is as a optimization.
> 
> Agreed. Do you want me to resend the series with patch 3 updated to read
> 
> "For a fixed small exponent of 3, it is more efficient to simply use two
> explicit multiplications rather than calling the int_pow() library
> function: Aside from the function call overhead, its implementation
> using repeated squaring means it ends up doing four 64x64 multiplications."
> 
> (and obviously patch 5 dropped)?

Yes, please.

When you resend you can add my R-B: to all patches:

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.


PS Don't mind either way but I wondered the following is clearer than
   the slightly funky multiply-and-assign expression (which isn't wrong
   but isn't very common either so my brain won't speed read it):

		retval = DIV_ROUND_CLOSEST_ULL(retval * retval * retval,
		 			       scale * scale);
