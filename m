Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB805E26E0
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2019 01:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391340AbfJWXI6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Oct 2019 19:08:58 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:34392 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbfJWXI5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Oct 2019 19:08:57 -0400
Received: by mail-pl1-f173.google.com with SMTP id k7so10860142pll.1;
        Wed, 23 Oct 2019 16:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QxDr+e6+5QdQzyCN6NaD0cQCCfsuFPgUpkpn762LbCY=;
        b=Bp4Q67s74UcB2h4To3GUb4bxX5cdnjSsAdYj4JFcXpIT1HEAI87HRAsD2nB29jxrd2
         vIkwH16XY+uUPjU0fDSqzMZey8SAbAR/mCS/GzV5eibEJDilwceCXlB6++2GcFcYu5iX
         diVQmUb2lI3ZOndtT1fSZdxndVXsW44qUid4v7X/Sspsy5uN4qpOH89t2Ir+tvILvHbV
         rloY1MH0q048K378e5hXc6g9CQYeltPBJ0r7U4OXYkQ6m/Hrlrc1JYYDjIj+NHJtAm9Y
         5s0GYTiTKYfoqH9usNTvxwujFyEdJb81yaF3Q/9Saj15wEQZ8JWpeEew77wRKdbKlgW5
         V3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QxDr+e6+5QdQzyCN6NaD0cQCCfsuFPgUpkpn762LbCY=;
        b=tI4Ozhm2I3IqKJ87z4EiFcIy/DCSVUk+QWApQ3/kquDz9TMeKMGb5V/bkOfTWc9KAq
         do6VEAdZh/H7tYlBwZSbpAFI1aWil5F30KvW9851a7tM3WduaZRLv7JN6c7ddGX6CXIJ
         qQwa0JqUXf3K4ZB60/XrGfJ612e4jBX5v3BDLk6+7Vo2Pqj86ZocIKJqwXd56q+mvcsy
         ORDwy1dk4b9KHnmuILvXM/BVYdYNbimpxiBoF9vhPYYmztmszh5TpKiH0uQT4WqvMENy
         tsVk7uZJYaPaZ1q0Uyl6+rY4vU1K9HkXMrAU652aFbnCY/nMDLOkkOqlsMdNzNKl1juU
         uUNg==
X-Gm-Message-State: APjAAAXQlDUTrvwJ8iF18YpFD/cB8hcvm884h75ieMiq95CXH5eYd6pU
        deqbwRXyMZNzCJYfxfzXxQg=
X-Google-Smtp-Source: APXvYqyUSrOsqTEVS/KFil0C4ircSVPx3Y670+4lzr4ms8Rlx8BKye/k/4pDNTv6EatZDUf/FITCUQ==
X-Received: by 2002:a17:902:fe88:: with SMTP id x8mr8185982plm.266.1571872136538;
        Wed, 23 Oct 2019 16:08:56 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id b18sm24620716pfi.157.2019.10.23.16.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 16:08:55 -0700 (PDT)
Date:   Wed, 23 Oct 2019 16:08:52 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     lee.jones@linaro.org, jdelvare@suse.com, linux@roeck-us.net,
        thierry.reding@gmail.com, jic23@kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-hwmon@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH 3/8] input: keyboard: Add support for Azoteq
 IQS620A/621/622/624/625
Message-ID: <20191023230852.GB35946@dtor-ws>
References: <1571631083-4962-1-git-send-email-jeff@labundy.com>
 <1571631083-4962-4-git-send-email-jeff@labundy.com>
 <20191023002254.GW35946@dtor-ws>
 <20191023012913.GA3233@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023012913.GA3233@labundy.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Oct 22, 2019 at 08:29:13PM -0500, Jeff LaBundy wrote:
> Hi Dmitry,
> 
> Thank you for your prompt review.
> 
> On Tue, Oct 22, 2019 at 05:22:54PM -0700, Dmitry Torokhov wrote:
> > Hi Jeff,
> > 
> > On Sun, Oct 20, 2019 at 11:11:18PM -0500, Jeff LaBundy wrote:
> > > +	/*
> > > +	 * Each frame contains at most one wheel event (up or down), in which
> > > +	 * case a full keystroke is emulated.
> > > +	 */
> > > +	if (event_flags & BIT(IQS62X_EVENT_WHEEL_UP)) {
> > > +		input_report_key(iqs62x_keys->input,
> > > +				 iqs62x_keys->keycode[IQS62X_EVENT_WHEEL_UP],
> > > +				 0);
> > > +		input_sync(iqs62x_keys->input);
> > > +	} else if (event_flags & BIT(IQS62X_EVENT_WHEEL_DN)) {
> > > +		input_report_key(iqs62x_keys->input,
> > > +				 iqs62x_keys->keycode[IQS62X_EVENT_WHEEL_DN],
> > > +				 0);
> > 
> > Not '1'?
> > 
> 
> We pick up the '1' in the first of the two for loops above so long as the wheel
> moved "enough." In this case (and this case only), a subsequent '0' is sent to
> emulate a full press/release cycle (2 * {EV_KEY + EV_SYN}) for wheel "ticks."
> 
> I will update the comment to say "...in which case a complementary release cycle
> is emulated." If I have misunderstood your concern, please let me know.

Ah, sorry, no, I misread the code.

Thanks.

-- 
Dmitry
