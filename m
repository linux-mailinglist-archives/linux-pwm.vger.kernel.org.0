Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BBA1DE563
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2020 13:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgEVLbw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 May 2020 07:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbgEVLbv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 May 2020 07:31:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDD0C05BD43
        for <linux-pwm@vger.kernel.org>; Fri, 22 May 2020 04:31:50 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w7so9783563wre.13
        for <linux-pwm@vger.kernel.org>; Fri, 22 May 2020 04:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=H+185K8zSeFBmMQkc0S2RpgtIxTxnwzQ8bRdc8/PQjM=;
        b=q+YdiOxy50fn0EDWPfyux9D59iEKwr2m1eM/cY/K375GdUBqXo3pp8piI4gBaf+77n
         5JFz0Rdi1Li+a4O7EXM5o/44mHHtxvSCxfDUtcA6i7aF/qlWsy4CFzZOdXmp/PELASm1
         js6fRLjYLxNuTscq5IysyTvBt/OdhbpBaFAlJNve8xt0rItgtgEfHkDSKhz52ka0lRh5
         Lkosx4VnWq1Ero3FcBFS61qSRLJsMGkEy3mN2B2PGAave3WtTUfChxXhHHs9587Kwc1k
         2zu9agWN+tmBk2jOuD3qLe1B/3y32XOVqGYrtfROZCihGW/LVilfrIRKqxxmMvKmOESx
         qMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=H+185K8zSeFBmMQkc0S2RpgtIxTxnwzQ8bRdc8/PQjM=;
        b=dkSOcKgr5OAaRe3yOTFct87NhxmfhH78y7SIQyOZltjWyvJwi3vG0L5UkK6q16ZxUe
         4AXcMBEuswLA340r/Fes4OjA8NbLEkjkeAwRxmKSTPxlSO/1h4l0itbsrMh+FHSOkb3T
         ku1BtooWd34lVxoGCJTE/Rrr8cDGdkwq56eYqFMxhTJTnhjlEl/4olqu5BVmVJF31t1n
         m9kkE5qM1wi+ToYSrf9LgvK1G6t8aSRwsB7yg2a6uMV5T7RzhP+WZYQ5seocGA1Joq9+
         U0zhdgYZCN9mm3NnZtQXylkyV9W3MMCsnhR9bapLu7+4DaySwkpZVHMfL18XT1g3+5hN
         W1Wg==
X-Gm-Message-State: AOAM532FuZmv0RVsfHoc7kq0zHfhaxIdSqkhUm+QPPLzr1dx/v3n5JW2
        cwcmURJr9JhUATxlFDnnOPoNZA==
X-Google-Smtp-Source: ABdhPJxMrG645+ScNEZnUJ9mYLHUahwPJZi/ay1v1u3J3vkccuz0qPf8MklUXDpEa8FUI0I6irUaQw==
X-Received: by 2002:adf:cd0d:: with SMTP id w13mr3254074wrm.150.1590147109398;
        Fri, 22 May 2020 04:31:49 -0700 (PDT)
Received: from dell ([95.149.164.102])
        by smtp.gmail.com with ESMTPSA id z9sm9252016wrp.66.2020.05.22.04.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 04:31:48 -0700 (PDT)
Date:   Fri, 22 May 2020 12:31:47 +0100
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
Message-ID: <20200522113147.GU271301@dell>
References: <cover.1587523702.git.gurus@codeaurora.org>
 <20200423114857.GG3612@dell>
 <20200423215306.GA8670@codeaurora.org>
 <20200424064303.GJ3612@dell>
 <20200424221422.GA31118@codeaurora.org>
 <20200427064434.GA3559@dell>
 <20200520231508.GA29437@codeaurora.org>
 <20200521071505.GL271301@dell>
 <20200522111657.GA2163848@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200522111657.GA2163848@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 22 May 2020, Thierry Reding wrote:

> On Thu, May 21, 2020 at 08:15:05AM +0100, Lee Jones wrote:
> > On Wed, 20 May 2020, Guru Das Srinagesh wrote:
> > 
> > > On Mon, Apr 27, 2020 at 07:44:34AM +0100, Lee Jones wrote:
> > > > On Fri, 24 Apr 2020, Guru Das Srinagesh wrote:
> > > > 
> > > > > On Fri, Apr 24, 2020 at 07:43:03AM +0100, Lee Jones wrote:
> > > > > > A great deal of mailing lists contain numerous protections against
> > > > > > things like flooding and spamming.  One of those protections is a
> > > > > > check for "Too many recipients to the message".  Most of the time this
> > > > > > simply requires moderator intervention by way of review and approval,
> > > > > > but this ultimately depends on the ML's configuration.
> > > > > > 
> > > > > > The first thing to ascertain is why your recipients list is so large.
> > > > > > Have you added every reviewer, subsystem-maintainer, maintainer and
> > > > > > contributor suggested by get-maintainer.pl?  If so, consider pruning
> > > > > > that a little.  Contributors do not tend to care about subsequent
> > > > > > changes to a file.  As someone who receives a lot of patches, I tend
> > > > > > to get fed-up when receiving patches simply because I made a change X
> > > > > > years ago.  Stick to listed maintainers/reviewers in the first
> > > > > > instance and see how far that takes you.
> > > > > 
> > > > > Thank you for the detailed reply. I did this in the first few patchsets
> > > > > and then when a few patches didn't get any attention, expanded the
> > > > > audience thus. Still, around 50% of the patches in this series remain
> > > > > unreviewed by anyone.
> > > > 
> > > > This isn't a reason to add more recipients (who are likely to care
> > > > even less than your original group).  However it *is* a good argument
> > > > for including all of the specified maintainers/reviewers in on all of
> > > > the patches.
> > > > 
> > > > > > If your recipients list is as succinct as reasonably possible, maybe
> > > > > > just accept that every version isn't going to be archived by every
> > > > > > ML.  It's still much more useful for the correct people to have
> > > > > > visibility into the set than for it to be archived multiple times.
> > > > > 
> > > > > Thank you, will prune the list and remove past contributors from the
> > > > > Cc-list and add all parties to all patches.
> > > > 
> > > > Great.  Once you've done that, we can start to help you acquire the
> > > > Acks you need on your remaining patches.
> > > 
> > > Hi Lee, Thierry, Uwe,
> > > 
> > > In v14 of this patchset I've pruned the list of contributors, removed
> > > past contributors from the cc-list, and added all parties to all patches
> > > (except for the patches that are yet to reviewed, for which I've added
> > > what get_maintainer.pl showed me). I've also resent v14 a couple of
> > > times already, with around a week's time interval between resends, and
> > > somehow it seems like this set has lost traction.
> > > 
> > > Could you please indicate what next steps I should take to have more
> > > eyes on the unreviewed patches? Only 4 out of 11 patches remain
> > > unreviewed.
> > 
> > Looks like we're waiting on Thierry (again).
> > 
> > This has been a common theme over the past few months.
> > 
> > Perhaps he has changed employer/project?
> 
> My work on PWM is purely done in my spare time. I don't get paid for any
> of it. I currently have two kids that need home-schooling, as many
> others probably do, and I have a full time job doing non-PWM related
> things. As a result my spare time is close to nil these days.

This is no different to many others.  I too am not paid for this work,
but it's still my responsibly to ensure a reply within a reasonable
amount of time.

We can all appreciate that the latest situation has exacerbated issues,
but a reasonable level of PWM participation, blocking various
patch-sets has been lacking for months before we'd even heard of
Covid-19 [0].

If you need help, just ask for it.  I am willing to step up and review
patches if you're overloaded.  Uwe is already listed as a designated
reviewer.  Perhaps between the 3 of us we can work something out in
order to reduce the latency.

[0] https://patchwork.ozlabs.org/project/linux-pwm/list/

> I very much appreciate all the effort that others have spent in getting
> this reviewed. I haven't been able to keep a very close eye on this, but
> even the latest versions have some comments, so I didn't consider this
> ready yet. If that's changed and everybody's okay with the changes, then
> I can apply this to for-next. We haven't got all that much time left
> before the merge window and I had hoped this would be ready earlier so
> that we'd have more time for this in linux-next. But I'd be willing to
> at least give it a try. If it starts to look like there are going to be
> issues with this I can always back them out and we can have another go
> next release.

If you would be so kind as to review the PWM patches, I can take them
in but I can't do anything without your Ack.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
