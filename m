Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9AE1BD496
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Apr 2020 08:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgD2G1a (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 Apr 2020 02:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgD2G1a (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 29 Apr 2020 02:27:30 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82C9C03C1AD
        for <linux-pwm@vger.kernel.org>; Tue, 28 Apr 2020 23:27:29 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j2so1011543wrs.9
        for <linux-pwm@vger.kernel.org>; Tue, 28 Apr 2020 23:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wv05h1X7qRrPjYPf9y0VD7+PHwezUYitVP0Fh0igQuY=;
        b=I4vZV4PACb5f7K2uxifM99GPqkcfyrpLc74PzSrCUF61KrqkAGgKNBFNHr+XiC1Zzr
         XqIjNrgmZ91TIAda8FEWPq1gg3Xaa84/0qQWu5Ae3sW4csU35iEp2O/nwCWdMpbr7El6
         eoZD/tvPP5RteAWgnhbWIY/PMqJ+ssDOZvekrrEimOB3ENhCiVutsoNIJ5zLGgynqmXb
         8Rc5rpcdAkqbshwzs7C11AcGOjJ9hcJFu+NIFlqEadlAtAupqh+9vJ50K1QkhtgQmjWR
         R9djt4X9WtAHl95Nhhfz3sSbWTT0MATduTJ2F9hJdP0sNOI+tsziWlYROFDtUt7Fy1Op
         uYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wv05h1X7qRrPjYPf9y0VD7+PHwezUYitVP0Fh0igQuY=;
        b=kxa0e8i9rgO0vrfgLwb4uJcrhNBcWXKjiE9do9TDAW0bR/qumbvlIj86sStHzxkXsi
         WsRv55WuLV5G/sWdfR5gdhGjcYmi+Kv0yg1f2ck9tspKulJglVhEpLps1V3nu66Xz+To
         5IpozfDit9h7noedQsSC8lkyeTBTgzYK5BVwekkj4poQcafR+zX2k1lU1+43h55oLijI
         37kdtp2Rd5/Bvq9XTsa3qwFg0nW6qDuNzMOAgCl8O4bvfCLJxwV5Uxt2Rspiu/dNbYbx
         j4e9q0Q2SfcY1wR6LhImCX0E5caOJZ7BWdy0bL5kZ1VmC86oIJTUDH28D0he621aaAes
         oB2w==
X-Gm-Message-State: AGi0PubtMs9kpp+v4fiv1vKhoJvLqwQQvDGY9307hbQXpgGDuHJ7Jq/e
        1xUjhBnpFrV1a0d6eEynM+XoKA==
X-Google-Smtp-Source: APiQypKTqIt46QQB2nB/SSJZXWRFVeB9A294fdRkNMgBYLOeiiFcpBnVXBSKVh/jOHoB1iCbHHyjSA==
X-Received: by 2002:adf:f187:: with SMTP id h7mr37818290wro.331.1588141648280;
        Tue, 28 Apr 2020 23:27:28 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id t17sm27729510wro.2.2020.04.28.23.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 23:27:27 -0700 (PDT)
Date:   Wed, 29 Apr 2020 07:27:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Michael Walle <michael@walle.cc>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 05/16] mfd: Add support for Kontron sl28cpld
 management controller
Message-ID: <20200429062725.GU3559@dell>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-6-michael@walle.cc>
 <20200428125049.GU185537@smile.fi.intel.com>
 <5e2d486077f9e2ce8bd9b171cf806fd9@walle.cc>
 <20200428144958.GZ185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200428144958.GZ185537@smile.fi.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 28 Apr 2020, Andy Shevchenko wrote:

> On Tue, Apr 28, 2020 at 04:43:24PM +0200, Michael Walle wrote:
> > Am 2020-04-28 14:50, schrieb Andy Shevchenko:
> > > On Thu, Apr 23, 2020 at 07:45:32PM +0200, Michael Walle wrote:
> > > > This patch adds core support for the board management controller found
> > > > on the SMARC-sAL28 board. It consists of the following functions:
> > > >  - watchdog
> > > >  - GPIO controller
> > > >  - PWM controller
> > > >  - fan sensor
> > > >  - interrupt controller
> > > 
> > > ...
> > > 
> > > >  obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
> > > > 
> > > >  obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
> > > > +
> > > > +obj-$(CONFIG_MFD_SL28CPLD)	+= sl28cpld.o
> > > 
> > > Perhaps keep an order?
> > 
> > I don't see any order in that makefile. Looked to me like every new
> > file was added at the end.
> 
> Okay, just didn't note from above context.

Yes, this is historical.  I've been meaning to visit this for ~7 years!

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
