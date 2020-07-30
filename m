Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83669233697
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Jul 2020 18:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgG3QWD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 30 Jul 2020 12:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbgG3QWC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 30 Jul 2020 12:22:02 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08D6C061574;
        Thu, 30 Jul 2020 09:22:01 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id o1so14620726plk.1;
        Thu, 30 Jul 2020 09:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=aX2Eg5Gk0V/jRI/X4rim3dxz+h5U/hgYWDFRrQixu1U=;
        b=kH+mNkGKtbV/we4VOn77a1cfLYJbSy7IRU65jsULUtkVMY7LlT5ldcjVPsnDU57jx4
         D1oYQDmo3t5hfCS8dbeE2W/3H3oDbI+aIg9EM9F0ByrcB/SEA7NKaVT41yywWG70SfGS
         jwS2O/TqFGvMTeNI72GmWKgIj3vl9IAAxbhQLOzX3p9RZ14hRNe5g76KZ+gCNsyiDPsH
         /qcHXigYTba+XBCscKt1v9tr7V9Lgq4swhdNqaTSos8l7xEXJ+yNDxtxMNu5CFCFK7TK
         j68MhNBxGwfgGkuwesvt/BKxUZkHN4VcXQc1yDt4Kl6s+9VvdUkgeyCuqHUmWX7huZpj
         wroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aX2Eg5Gk0V/jRI/X4rim3dxz+h5U/hgYWDFRrQixu1U=;
        b=Vee8uAZFEjvShJ4V72QiT0asLtgY2qxHCesdwezsTgbz6MH1SdlN7/gFMIyh/k2lE0
         pEB5NcuY8b9/rbVnClw0v3s+3L1zeFldzu2wqByoSvXnGXp6qsXV878jIdIyVeHMwvTR
         qTULNqAAPemgTFvQmCm0uEqKzk3xlciNg+qxYbmz3RomLjChULqA6QKqhdaQcXurk0gX
         pz9tVONclnWnPdAhSX+200VJxB95MRYUmXX0LQ3bzHEoDXF61qo1Z8qeAkki3ifPGHud
         YNlyays5cXeTWD1+60tN6uJ7E9FoCQTcMP3UpfAkQvCmHqeWeher6PmgZus9ro01Rr3A
         ugVw==
X-Gm-Message-State: AOAM533t2GpEuyXxR6XTqSQqPt+vbRs53quEkSdYhBmudogX9EMcaxGV
        xM6+exmlwHSq0Cw/u/JBlMQ=
X-Google-Smtp-Source: ABdhPJxsbtys0VGyQSLoeP/4r5EtvTBYw9ZHBb7MqZSwGRi95+8bm14rpD50tN+X5FlubnPm8tBVTA==
X-Received: by 2002:a63:475c:: with SMTP id w28mr36536961pgk.222.1596126121197;
        Thu, 30 Jul 2020 09:22:01 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id s8sm6548365pfc.122.2020.07.30.09.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 09:22:00 -0700 (PDT)
Date:   Thu, 30 Jul 2020 09:21:57 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Roy Im <roy.im.opensource@diasemi.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Brian Masney <masneyb@onstation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v18 3/3] Input: new da7280 haptic driver
Message-ID: <20200730162157.GI1665100@dtor-ws>
References: <cover.1595991580.git.Roy.Im@diasemi.com>
 <23b3470401ec5cf525add8e1227cb67586b9f294.1595991580.git.Roy.Im@diasemi.com>
 <20200729063638.GY1665100@dtor-ws>
 <20200729072145.ifzoe656sjpxdior@pengutronix.de>
 <20200730050653.GA1665100@dtor-ws>
 <20200730061631.y4r4s6v3xepktj54@pengutronix.de>
 <20200730083058.GC3703480@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200730083058.GC3703480@smile.fi.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Jul 30, 2020 at 11:30:58AM +0300, Andy Shevchenko wrote:
> On Thu, Jul 30, 2020 at 08:16:31AM +0200, Uwe Kleine-König wrote:
> > On Wed, Jul 29, 2020 at 10:06:53PM -0700, Dmitry Torokhov wrote:
> > > On Wed, Jul 29, 2020 at 09:21:45AM +0200, Uwe Kleine-König wrote:
> > > > On Tue, Jul 28, 2020 at 11:36:38PM -0700, Dmitry Torokhov wrote:
> 
> ...
> 
> > > Maybe we should introduce something like '%de' for the integer error
> > > case?
> > 
> > I suggested that some time ago with limited success, see
> > https://lore.kernel.org/lkml/20200129115516.zsvxu56e6h7gheiw@pathway.suse.cz/
> 
> Oh, please, no need for that really. We have now dev_err_probe() on its way to
> upstream (now in Greg's tree) which hides all this behind.
> 
> Just switch to dev_err_probe() and forget about what is under the hood.

Awesome, we just need to make sure there is never an error condition
outside of probe path, and we will be set ;) Easy peasy ;)

Thanks.

-- 
Dmitry
