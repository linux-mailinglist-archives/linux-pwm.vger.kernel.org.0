Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867C31DC2B7
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2020 01:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgETXPK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 20 May 2020 19:15:10 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:55831 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728462AbgETXPK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 May 2020 19:15:10 -0400
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 May 2020 16:15:09 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg02-sd.qualcomm.com with ESMTP; 20 May 2020 16:15:09 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 14D2A4D8D; Wed, 20 May 2020 16:15:09 -0700 (PDT)
Date:   Wed, 20 May 2020 16:15:09 -0700
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
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
Message-ID: <20200520231508.GA29437@codeaurora.org>
Mail-Followup-To: Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Guenter Roeck <linux@roeck-us.net>, Joe Perches <joe@perches.com>
References: <cover.1587523702.git.gurus@codeaurora.org>
 <20200423114857.GG3612@dell>
 <20200423215306.GA8670@codeaurora.org>
 <20200424064303.GJ3612@dell>
 <20200424221422.GA31118@codeaurora.org>
 <20200427064434.GA3559@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427064434.GA3559@dell>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Apr 27, 2020 at 07:44:34AM +0100, Lee Jones wrote:
> On Fri, 24 Apr 2020, Guru Das Srinagesh wrote:
> 
> > On Fri, Apr 24, 2020 at 07:43:03AM +0100, Lee Jones wrote:
> > > A great deal of mailing lists contain numerous protections against
> > > things like flooding and spamming.  One of those protections is a
> > > check for "Too many recipients to the message".  Most of the time this
> > > simply requires moderator intervention by way of review and approval,
> > > but this ultimately depends on the ML's configuration.
> > > 
> > > The first thing to ascertain is why your recipients list is so large.
> > > Have you added every reviewer, subsystem-maintainer, maintainer and
> > > contributor suggested by get-maintainer.pl?  If so, consider pruning
> > > that a little.  Contributors do not tend to care about subsequent
> > > changes to a file.  As someone who receives a lot of patches, I tend
> > > to get fed-up when receiving patches simply because I made a change X
> > > years ago.  Stick to listed maintainers/reviewers in the first
> > > instance and see how far that takes you.
> > 
> > Thank you for the detailed reply. I did this in the first few patchsets
> > and then when a few patches didn't get any attention, expanded the
> > audience thus. Still, around 50% of the patches in this series remain
> > unreviewed by anyone.
> 
> This isn't a reason to add more recipients (who are likely to care
> even less than your original group).  However it *is* a good argument
> for including all of the specified maintainers/reviewers in on all of
> the patches.
> 
> > > If your recipients list is as succinct as reasonably possible, maybe
> > > just accept that every version isn't going to be archived by every
> > > ML.  It's still much more useful for the correct people to have
> > > visibility into the set than for it to be archived multiple times.
> > 
> > Thank you, will prune the list and remove past contributors from the
> > Cc-list and add all parties to all patches.
> 
> Great.  Once you've done that, we can start to help you acquire the
> Acks you need on your remaining patches.

Hi Lee, Thierry, Uwe,

In v14 of this patchset I've pruned the list of contributors, removed
past contributors from the cc-list, and added all parties to all patches
(except for the patches that are yet to reviewed, for which I've added
what get_maintainer.pl showed me). I've also resent v14 a couple of
times already, with around a week's time interval between resends, and
somehow it seems like this set has lost traction.

Could you please indicate what next steps I should take to have more
eyes on the unreviewed patches? Only 4 out of 11 patches remain
unreviewed.

Thank you.

Guru Das.
