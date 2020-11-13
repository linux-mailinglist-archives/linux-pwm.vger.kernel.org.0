Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56162B1661
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Nov 2020 08:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbgKMH0g (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Nov 2020 02:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgKMH0f (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Nov 2020 02:26:35 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD95C0613D1;
        Thu, 12 Nov 2020 23:26:19 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id d3so4150880plo.4;
        Thu, 12 Nov 2020 23:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bVc4aZk4rKy/6/VqEhMXbEQ5ZVosOHXwKRbVIxDDoGY=;
        b=GMiotV0GyRZSn0pn1dgPWm/1yR1DzPikBgKi5Lbkr2+y/iNDlpqYBVO7SfIvAgqAbf
         uIaCVLY528t7w5yWehm/+G4BNoS1lB69IH4dB9iSPueZ2vY4/XYJoWpU0aQEMS570PMt
         gfyrGW2DRdfuIkQPiOQfGiyd6Icf9TqwlJVhKT9GlbO7q/Mj4/7h6vRa/vNWfxW1mehI
         GBBBTEzl+JU36/Sc52m4n+V0gVtafzPbCLB2RuMl1UZyUSG2LeWJBlAiNPu5ZgflYKFh
         dBz3JOOX0NRmiUfmf22A+yolC5R2dAEyS/GcPJGRpS4tu3Prtj7hQV+cpG105mS2OmpU
         cB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bVc4aZk4rKy/6/VqEhMXbEQ5ZVosOHXwKRbVIxDDoGY=;
        b=ilHQ4bKelIaLk5fRLJ4K1wju+atXDEou+ME04dzDW8cMYGS+v2y4Y4OjmjWaHt6BLT
         eEVVnoYvNVkyO6tOmQLejfAufnSDjZuoTvwvvqHkVtXRuWhISdm/Qgo9Y8tkj0WidDHo
         ymwkSnf3iGUQ41ZzQgnQALh5rSRSgJ9QG7o48MyseNa5w2DKiU6EjmOFODonKVWSRRc5
         AjS58F6JdNtusghqSNWVNuYSJhP7j2rnXn9Mz6NswUsWoQrVv/rv0pnZTbxSt4sU/bfn
         6Y54Prxym1xcAfx7r49UWixjR/ArssAhsVQE5gLkxzz7gGdRLh8vjL0bBBUOV5LcWBrf
         BwvQ==
X-Gm-Message-State: AOAM532fH+1JKn1dF+HSjqLXCfcqO5Y2WwahbF5zC1zyGjqPSCo7Rkh5
        esLkJOwqWGGCZ2wfXQzYJZ0=
X-Google-Smtp-Source: ABdhPJwxvk3sEiTwtCGzh6+CErNAzuUpI0fhTqrV5pUBqPIIf6eT7t4y2GPOTdCy6tzoqSvWpYqfbA==
X-Received: by 2002:a17:902:c016:b029:d7:1a0:7cf0 with SMTP id v22-20020a170902c016b02900d701a07cf0mr878425plx.64.1605252379251;
        Thu, 12 Nov 2020 23:26:19 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id l20sm9170507pfd.103.2020.11.12.23.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 23:26:18 -0800 (PST)
Date:   Thu, 12 Nov 2020 23:26:15 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-pwm@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        linux-input <linux-input@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v4 01/11] firmware: raspberrypi: Keep count of all
 consumers
Message-ID: <20201113072615.GE356503@dtor-ws>
References: <20201112163630.17177-1-nsaenzjulienne@suse.de>
 <20201112163630.17177-2-nsaenzjulienne@suse.de>
 <CAHp75Vf9E7UWVDMs=eRjLjoSN6SVOWw9thNdnR8ruCL6GmY7JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vf9E7UWVDMs=eRjLjoSN6SVOWw9thNdnR8ruCL6GmY7JQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Nov 12, 2020 at 07:52:14PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 12, 2020 at 6:40 PM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> >
> > When unbinding the firmware device we need to make sure it has no
> > consumers left. Otherwise we'd leave them with a firmware handle
> > pointing at freed memory.
> >
> > Keep a reference count of all consumers and introduce rpi_firmware_put()
> > which will permit automatically decrease the reference count upon
> > unbinding consumer drivers.
> 
> ...
> 
> >  /**
> > - * rpi_firmware_get - Get pointer to rpi_firmware structure.
> >   * @firmware_node:    Pointer to the firmware Device Tree node.
> >   *
> > + * The reference to rpi_firmware has to be released with rpi_firmware_put().
> > + *
> >   * Returns NULL is the firmware device is not ready.
> >   */
> >  struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node)
> >  {
> >         struct platform_device *pdev = of_find_device_by_node(firmware_node);
> > +       struct rpi_firmware *fw;
> >
> >         if (!pdev)
> >                 return NULL;
> >
> > -       return platform_get_drvdata(pdev);
> > +       fw = platform_get_drvdata(pdev);
> > +       if (!fw)
> > +               return NULL;
> > +
> > +       if (!kref_get_unless_zero(&fw->consumers))
> > +               return NULL;
> 
> Don't we have a more traditional way of doing this, i.e.
> try_module_get() coupled with get_device() ?

get_device() will make sure that device is there, but gives no
assurances that device is bound to a driver, so it will not help with
the racy access to firmware via platform_get_drvdata() call.

Thanks.

-- 
Dmitry
