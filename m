Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61DB71832BC
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Mar 2020 15:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgCLOVa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Mar 2020 10:21:30 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39706 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbgCLOVa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Mar 2020 10:21:30 -0400
Received: by mail-pj1-f67.google.com with SMTP id d8so2721711pje.4;
        Thu, 12 Mar 2020 07:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xA6hYZYQHhZOK5w4gl5vlgvd5UjngUj1HWav2zK4YIE=;
        b=elAvbo1K35UXfjiU7s7C6Fr9ny3r+zuq45aGb0obKM6MUmebz83Om5sR5EldQ2SDgz
         Og0VcNpXOI9i+t4VR3d7CMdNkJus2nXmDWCBFyVCIl4V8DrooAAFnWMis1sxuv53Y0B+
         ku1ZKLsP0J8dg8z3MBUH+p1Q1SxXHFZXQ6PdsRVVhAAMSF0Uf9EnvNeh0bYSu4Rrom8i
         UhZMG8hOG8pEczd9Ogd+3+Q8DE0JK3rn8ERKhEgv03HyVQ7oaawEy0Afd2Chbmdhb53W
         QeJQh4lX+sN6H2dX6bUnRWq8OJmv+OV+m3ZmAdSqDwq0awnF2/tMa9LC60qbWSBqG+EG
         5kwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xA6hYZYQHhZOK5w4gl5vlgvd5UjngUj1HWav2zK4YIE=;
        b=Co1KgQkYuoQZkghdr6t2Wc0ivrIWtxAM3QaxC527cfPov27oj1/jjsFyQjP2EbIDLj
         94Or81YhHE62q57LJhdsj5TqRQcQK2td+JaFpew6DIjfXDHtsZQ0ZxLkEazU52ZBFLi6
         b5ZEWHNsdUgsrUDHNR5Dr0gtPGa+NLUMnjDZZxczq9dWjw1+F4OY6aSrGssznQgWNEYJ
         +Gb0NirMg6LnFVKu+8rJDm6HpQsly31qlleG+Dr0GKWxWk+ggLncyslKGONWtsE1X14n
         Wn+37tnrr85W3nIgMANc0QPW6HGEguO7e58ZfYx6WAta4/BoYfkEmvufPdtAu6Nfg4Mf
         qzVw==
X-Gm-Message-State: ANhLgQ0uhAZX19MuB85vJNyEqt4GWRAm6XQumrAz8k7NbxRRNY75bvhc
        SbBsQkFkIGAqd6Q0erMF0HoNQ5wI
X-Google-Smtp-Source: ADFU+vsTQyN4Pfu6NQPzwD6SbwLEp4VXwcjudj3agC6kETt85Aq0K0JBWrXCGhcDemgNyIORo3UffQ==
X-Received: by 2002:a17:902:bcc5:: with SMTP id o5mr8187811pls.174.1584022889113;
        Thu, 12 Mar 2020 07:21:29 -0700 (PDT)
Received: from localhost (c-73-241-114-122.hsd1.ca.comcast.net. [73.241.114.122])
        by smtp.gmail.com with ESMTPSA id 15sm49441428pfp.125.2020.03.12.07.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 07:21:28 -0700 (PDT)
Date:   Thu, 12 Mar 2020 07:21:26 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH v3 4/5] pwm: omap-dmtimer: Do not disable pwm before
 changing period/duty_cycle
Message-ID: <20200312142126.GB2466@localhost>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
 <20200312042210.17344-5-lokeshvutla@ti.com>
 <20200312064042.p7himm3odxjyzroi@pengutronix.de>
 <f250549f-1e7c-06d6-b2a4-7ae01c06725b@ti.com>
 <20200312084739.isixgdo3txr6rjzg@pengutronix.de>
 <2a5a06cd-7aca-c450-b048-33329d058eca@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a5a06cd-7aca-c450-b048-33329d058eca@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Mar 12, 2020 at 04:14:34PM +0530, Lokesh Vutla wrote:
> But the problem here is that inactive breaks between two periods is not desired.
> Because the pwm is used to generate a 1PPS signal and is continuously
> synchronized with PTP clock.

The 1-PPS case is the "easy" one.  If the PWM is adjustable on the
fly, then people will use it with higher frequency signals.
 
> I am up if this can be solved generically. But updating period is very specific
> to hardware implementation. Not sure what generic solution can be brought out of
> this. Please correct me if I am wrong.

What happens today when the PWM frequency or duty cycle are changed
while the signal is enabled?

Do different PWM devices/drivers behave the same way?

Does this series change the behavior of the am335x and friends?

Thanks,
Richard
