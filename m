Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36A61E1BA0
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2020 08:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgEZG7l (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 26 May 2020 02:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbgEZG7l (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 26 May 2020 02:59:41 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8FFC061A0E
        for <linux-pwm@vger.kernel.org>; Mon, 25 May 2020 23:59:39 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y17so10872487wrn.11
        for <linux-pwm@vger.kernel.org>; Mon, 25 May 2020 23:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Dz97bPhLZ2ojNQGt11gbxPQ9ck+IuPqmj2aW0HoNGhg=;
        b=D7Uw9a/JVKnF0pVA+pYqWXeBRUa/98xIhoXCxzZ0fMF6kxK3Yclb5IyPwH1rQvZcQx
         PRIDQjMWomTvrUmpx10glsAB0F9n+0wjDUtkRQbjinYPxpQcCNIO911QKzLlQ8dy20R6
         /seAYXBtxV2WEX1sL94NgARBwogsDH7He7z0moGleqimmz5jG/fQ79ihd/ZoBE4sAa9d
         gWPBNgQkl8ogkDEwKnaxbtIvQE4XdpF7Tqinb8gypUmNoaE5WgChBHQK/SxNSXTGgkZY
         oVb7CkMzDuEw7Wm3JULpbd7dGpMzTWm+5+vCOYwwuEdb8pv0EjRGzemUS4NkOl++5zQk
         FI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Dz97bPhLZ2ojNQGt11gbxPQ9ck+IuPqmj2aW0HoNGhg=;
        b=AGO4xjGpQpbuh3nMBWJQgj7F0SDlQYih7PrxiU9K46tyz4pJrnf9kdwn6HZj3uG1yp
         5Fd3vPhJIbh6PpcrU58DvXfLw8ViteGCd/7hD64W4fbtIDfcLD/RUUpXUSCM5fU6EMZl
         3T01qZhhHa+7mMLBy31UqripzNOBnXVVFTozgbzGz5HdOtdkI0MqOq8qyCG8rxVDaM/e
         PqSlapBm0bQYza2f0HJBxfNPP/tYw1k1oxeb5OQ0MOynGN9j9uPJdCBDPQHoZtHRwhzB
         FlwrRO2o6gkIjmYCyOyMnbOO6y2nwZutajgORrBZoYdqiHAt4fG2aW1M2Zytuf55571y
         Plpg==
X-Gm-Message-State: AOAM531PNTe81mEt+Ny8wZNXRfo8VsPzzALMsLM6XcICU57dYmLF767A
        zu7pN0dasaIJY/U4cYhz3xZb/g==
X-Google-Smtp-Source: ABdhPJw+bsauGUqy0+jK+Ts+WdqeB/X3jRFwdtLs+MM/yik3Rw1liGYIXDZchJ+h6BTQeTJhUpK2XA==
X-Received: by 2002:a05:6000:128b:: with SMTP id f11mr18590698wrx.227.1590476378170;
        Mon, 25 May 2020 23:59:38 -0700 (PDT)
Received: from dell ([95.149.164.102])
        by smtp.gmail.com with ESMTPSA id l204sm10601698wmf.19.2020.05.25.23.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 23:59:37 -0700 (PDT)
Date:   Tue, 26 May 2020 07:59:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Guenter Roeck <linux@roeck-us.net>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v13 00/11] Convert PWM period and duty cycle to u64
Message-ID: <20200526065935.GA3628@dell>
References: <20200423114857.GG3612@dell>
 <20200423215306.GA8670@codeaurora.org>
 <20200424064303.GJ3612@dell>
 <20200424221422.GA31118@codeaurora.org>
 <20200427064434.GA3559@dell>
 <20200520231508.GA29437@codeaurora.org>
 <20200521071505.GL271301@dell>
 <20200522111657.GA2163848@ulmo>
 <20200522113147.GU271301@dell>
 <20200522125028.GG2163848@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200522125028.GG2163848@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 22 May 2020, Thierry Reding wrote:

> On Fri, May 22, 2020 at 12:31:47PM +0100, Lee Jones wrote:
> > On Fri, 22 May 2020, Thierry Reding wrote:
> > 
> > > On Thu, May 21, 2020 at 08:15:05AM +0100, Lee Jones wrote:
> > > > On Wed, 20 May 2020, Guru Das Srinagesh wrote:
> > > > 
> > > > > On Mon, Apr 27, 2020 at 07:44:34AM +0100, Lee Jones wrote:
> > > > > > On Fri, 24 Apr 2020, Guru Das Srinagesh wrote:
> > > > > > 
> > > > > > > On Fri, Apr 24, 2020 at 07:43:03AM +0100, Lee Jones wrote:
> > > > > > > > A great deal of mailing lists contain numerous protections against
> > > > > > > > things like flooding and spamming.  One of those protections is a
> > > > > > > > check for "Too many recipients to the message".  Most of the time this
> > > > > > > > simply requires moderator intervention by way of review and approval,
> > > > > > > > but this ultimately depends on the ML's configuration.
> > > > > > > > 
> > > > > > > > The first thing to ascertain is why your recipients list is so large.
> > > > > > > > Have you added every reviewer, subsystem-maintainer, maintainer and
> > > > > > > > contributor suggested by get-maintainer.pl?  If so, consider pruning
> > > > > > > > that a little.  Contributors do not tend to care about subsequent
> > > > > > > > changes to a file.  As someone who receives a lot of patches, I tend
> > > > > > > > to get fed-up when receiving patches simply because I made a change X
> > > > > > > > years ago.  Stick to listed maintainers/reviewers in the first
> > > > > > > > instance and see how far that takes you.
> > > > > > > 
> > > > > > > Thank you for the detailed reply. I did this in the first few patchsets
> > > > > > > and then when a few patches didn't get any attention, expanded the
> > > > > > > audience thus. Still, around 50% of the patches in this series remain
> > > > > > > unreviewed by anyone.
> > > > > > 
> > > > > > This isn't a reason to add more recipients (who are likely to care
> > > > > > even less than your original group).  However it *is* a good argument
> > > > > > for including all of the specified maintainers/reviewers in on all of
> > > > > > the patches.
> > > > > > 
> > > > > > > > If your recipients list is as succinct as reasonably possible, maybe
> > > > > > > > just accept that every version isn't going to be archived by every
> > > > > > > > ML.  It's still much more useful for the correct people to have
> > > > > > > > visibility into the set than for it to be archived multiple times.
> > > > > > > 
> > > > > > > Thank you, will prune the list and remove past contributors from the
> > > > > > > Cc-list and add all parties to all patches.
> > > > > > 
> > > > > > Great.  Once you've done that, we can start to help you acquire the
> > > > > > Acks you need on your remaining patches.
> > > > > 
> > > > > Hi Lee, Thierry, Uwe,
> > > > > 
> > > > > In v14 of this patchset I've pruned the list of contributors, removed
> > > > > past contributors from the cc-list, and added all parties to all patches
> > > > > (except for the patches that are yet to reviewed, for which I've added
> > > > > what get_maintainer.pl showed me). I've also resent v14 a couple of
> > > > > times already, with around a week's time interval between resends, and
> > > > > somehow it seems like this set has lost traction.
> > > > > 
> > > > > Could you please indicate what next steps I should take to have more
> > > > > eyes on the unreviewed patches? Only 4 out of 11 patches remain
> > > > > unreviewed.
> > > > 
> > > > Looks like we're waiting on Thierry (again).
> > > > 
> > > > This has been a common theme over the past few months.
> > > > 
> > > > Perhaps he has changed employer/project?
> > > 
> > > My work on PWM is purely done in my spare time. I don't get paid for any
> > > of it. I currently have two kids that need home-schooling, as many
> > > others probably do, and I have a full time job doing non-PWM related
> > > things. As a result my spare time is close to nil these days.
> > 
> > This is no different to many others.  I too am not paid for this work,
> > but it's still my responsibly to ensure a reply within a reasonable
> > amount of time.
> 
> I realize that this is the same for many others. Still, you seemed to
> suggest that the lack of time that I was able to spend on PWM was
> somehow related to me changing employers, so I wanted to clarify that
> this isn't 
> 
> > We can all appreciate that the latest situation has exacerbated issues,
> > but a reasonable level of PWM participation, blocking various
> > patch-sets has been lacking for months before we'd even heard of
> > Covid-19 [0].
> 
> Covid-19 started to impact me around mid-March, and you'll see that
> that's about the time that I stopped maintaining patchwork.
> 
> > If you need help, just ask for it.
> 
> Hm... who do you go and ask for help? Every maintainer I know is already
> at least as busy as I am.
> 
> > I am willing to step up and review patches if you're overloaded. Uwe
> > is already listed as a designated reviewer. Perhaps between the 3 of
> > us we can work something out in order to reduce the latency.
> 
> That's very kind of you. Yes, I'd be willing to do this as a sort of
> group maintenance, and perhaps even eventually step away from my role
> as maintainer entirely if I think somebody else will do a better job.
> I do still care about the PWM subsystem, having looked after it for a
> couple of years, so I do want any hand-off to be somewhat orderly.
> 
> > [0] https://patchwork.ozlabs.org/project/linux-pwm/list/
> > 
> > > I very much appreciate all the effort that others have spent in getting
> > > this reviewed. I haven't been able to keep a very close eye on this, but
> > > even the latest versions have some comments, so I didn't consider this
> > > ready yet. If that's changed and everybody's okay with the changes, then
> > > I can apply this to for-next. We haven't got all that much time left
> > > before the merge window and I had hoped this would be ready earlier so
> > > that we'd have more time for this in linux-next. But I'd be willing to
> > > at least give it a try. If it starts to look like there are going to be
> > > issues with this I can always back them out and we can have another go
> > > next release.
> > 
> > If you would be so kind as to review the PWM patches, I can take them
> > in but I can't do anything without your Ack.
> 
> Looking at v14 I think there are no longer any discussions (looks like
> the last comment I thought was from v14 was actually on v13 and it seems
> to have been solved in v14 now) and there are Acked-bys for all the non-
> PWM patches, so there's nothing in the way of me applying this to the
> PWM tree. I can let it soak there for a few days and send out a stable
> branch if anyone needs it if there aren't any huge issues.
> 
> Does that sound like a plan?

I had it in my mind that I'd apply it, as MFD is usually the central
repo to a lot of these cross-subsystem type patchsets, and the fact
that I'm already set-up for it (I have scripts which make this easy).

However, as long as a pull-request is sent out for us to potentially
pull from, it really makes no difference to me.  Go for it! :)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
