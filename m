Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955232D27E0
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Dec 2020 10:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgLHJja (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Dec 2020 04:39:30 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37617 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgLHJj2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Dec 2020 04:39:28 -0500
Received: by mail-lj1-f195.google.com with SMTP id s11so9655341ljp.4
        for <linux-pwm@vger.kernel.org>; Tue, 08 Dec 2020 01:39:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DTvJajZ3HUb4nu8M5pZUhUsPRLHsfu5EOUbf+sGZc2Q=;
        b=K6iJB5pNVM7qbseN3FWuP8JEyGvo3kChKOE2lTqfBAndUyo9BZP6WSd8yVrAd0fxWb
         2rrIb2KDyMrvsB+vxFYPvYXg3rOfUqgeh1TPxfqZ3a7i30ipT5uUtPWLozZYmbwGLSrF
         1j0Di4wGoguatGcPejf/JEdX1rKoBZiF6O+TuiueNqwnhRk1pDRg4Hjy0TnrfUG2x4Sn
         yWsq0P9mPDgU3q9wpxeeIN8XUGvZWjKlCvEB8n3NpR0CwF7xlU+72KB+/BqalAplBFtC
         ufh4XvVlcGj8AzahGvR/7j3r/ZeBv7Wx0sWNfclWOzp8EXgBlcR8GMLwbU3xpT1CUXwA
         Sv/Q==
X-Gm-Message-State: AOAM532eNcjMEC+wfQtUs2eDxNGnrdh9z1juo6M2eG/6FI8XbCZssl2h
        oFr9BQA29/tdYkjJCMHLVKJUiWvL7Ie+qQ==
X-Google-Smtp-Source: ABdhPJzXZe26yxx/l3kvM/RPCez5mYI4jwN42wzERbqcaO2zVyY1QWfCknrrrH7IZHoGDHwqqBrarw==
X-Received: by 2002:a2e:b5d9:: with SMTP id g25mr797ljn.471.1607420326452;
        Tue, 08 Dec 2020 01:38:46 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id y22sm3337923ljy.89.2020.12.08.01.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 01:38:45 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kmZSt-0002VW-Mh; Tue, 08 Dec 2020 10:39:23 +0100
Date:   Tue, 8 Dec 2020 10:39:23 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH] greybus: Add TODO item about modernizing the pwm code
Message-ID: <X89JyygGo8FV5Heo@localhost>
References: <20201204183335.3839726-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201204183335.3839726-1-uwe@kleine-koenig.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Dec 04, 2020 at 07:33:35PM +0100, Uwe Kleine-König wrote:
> drivers/staging/greybus/pwm.c uses the old style PWM callbacks, new drivers
> should stick to the atomic API instead.
> ---

No sign off?

Please also add a staging prefix since this part of greybus still lives
there.

>  drivers/staging/greybus/TODO | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/greybus/TODO b/drivers/staging/greybus/TODO
> index 31f1f2cb401c..6461e0132fe3 100644
> --- a/drivers/staging/greybus/TODO
> +++ b/drivers/staging/greybus/TODO
> @@ -1,3 +1,5 @@
>  * Convert all uses of the old GPIO API from <linux/gpio.h> to the
>    GPIO descriptor API in <linux/gpio/consumer.h> and look up GPIO
>    lines from device tree or ACPI.
> +* Make pwm.c use the struct pwm_ops::apply instead of ::config, ::set_polarity,
> +  ::enable and ::disable.

Johan
